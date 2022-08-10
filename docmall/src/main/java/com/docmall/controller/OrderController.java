package com.docmall.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.docmall.domain.CartOrderInfo;
import com.docmall.domain.CartVO;
import com.docmall.domain.CartVOList;
import com.docmall.domain.MemberVO;
import com.docmall.domain.OrderVO;
import com.docmall.domain.PaymentVO;
import com.docmall.kakaopay.ApproveResponse;
import com.docmall.kakaopay.ReadyResponse;
import com.docmall.service.CartService;
import com.docmall.service.KakaoPayServiceImpl;
import com.docmall.service.OrderService;
import com.docmall.util.UploadFileUtils;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/user/order/*")
public class OrderController {
	
	@Resource(name = "uploadPath") 
	private String uploadPath;
	
	@Setter(onMethod_ = {@Autowired})
	private OrderService orderService;
	
	@Setter(onMethod_ = {@Autowired})
	private CartService cartService;
	
	@Setter(onMethod_ = {@Autowired})
	private KakaoPayServiceImpl kakaopayService;
	
	/*
	 주문 내역  
	 1)장바구니에서 주문하기 
	 2)상품리스트 팝업 대화상자->구매하기 
	 -> 구분값 사용
	 */
	@GetMapping("/orderListInfo")
	public void orderListInfo(HttpSession session, Model model,
								@RequestParam("type") String type, @RequestParam(value = "p_num", required = false) Integer p_num, @RequestParam(value = "cart_acount", required = false) Integer o_amount ) {
		
		String m_userid = ((MemberVO) session.getAttribute("loginStatus")).getM_userid();
		
		List<CartOrderInfo> orderList = null;
				
		if(type.equals("cartOrder")) {
			//장바구니 구매	- String type 만 사용	
			orderList = orderService.cartOrderList(m_userid);
						
		} else if(type.equals("directOrder")) {
			//직접 구매 - String type, Integer p_num, int o_amount 전부 사용
			orderList = orderService.directOrderList(p_num, o_amount);
			//log.info("직접 구매: " + orderList);
			
			//직접 구매시 장바구니에 데이터 담기
			CartVO vo = new CartVO();
			vo.setCart_acount(o_amount);
			vo.setM_userid(m_userid);
			vo.setP_num(p_num);
			cartService.addCart(vo);
		}

		for(int i=0; i<orderList.size();i++) {
			String p_image_folder = orderList.get(i).getP_image_dateFolder().replace("\\", "/");
			orderList.get(i).setP_image_dateFolder(p_image_folder);
		}
		
		model.addAttribute("cartOrderList", orderList);
		
		
	}
	
	//상품 목록에서 이미지 보여주기
	@ResponseBody
	@GetMapping("/displayFile")
	public ResponseEntity<byte[]> displayFile(String folderName, String fileName){
		//String fileName : jsp 페이지에 뿌려진 날짜 폴더와 이미지 이름이 합쳐져서 들어올 예정
		
		log.info("폴더이름: " + folderName);
		log.info("파일이름: " + fileName);
		
		//이미지를 byte[]로 읽어오는 작업 - UploadFileUtils		
		return UploadFileUtils.getFile(uploadPath, folderName + "\\" + fileName);
	}
	
	//주문 저장하기
	@PostMapping("/orderSave")
	public String orderSave(OrderVO ordervo,PaymentVO payVO, String type, HttpSession session) {
		
		log.info("주문 정보: " + ordervo);
		log.info("결제 정보: " + payVO);
		
		String m_userid = ((MemberVO) session.getAttribute("loginStatus")).getM_userid();
		ordervo.setM_userid(m_userid);
		
		//1)무통장 입금일 경우
		if(type.equals("무통장")) {
			
			ordervo.setPay_status("입금전");
			payVO.setPate_tot_price(ordervo.getO_totalcost()); //실제 총 결제금액
			payVO.setPay_rest_price(0);	//추가 입금 금액
		}
		
		/*
		 * //2)카카오 페이 결제일 경우 if(type.equals("카카오페이")) {
		 * 
		 * ordervo.setPay_status("입금전");
		 * payVO.setPate_tot_price(ordervo.getO_totalcost()); //실제 총 결제금액
		 * payVO.setPay_rest_price(0); //추가 입금 금액 }
		 */
		
		orderService.orderBuy(ordervo, payVO);
		
		return "redirect:/user/order/orderComplete";
	}
	
	//카카오페이 결제요청 - 바로구매는 에러
	@GetMapping("/orderPay")
	public @ResponseBody ReadyResponse payReady(int totalAmount, /*OrderVO orderVO,  PaymentVO payVO, */ HttpSession session) {
		
		//장바구니에서 상품에서 (상품명, 상품 코드, 수량, 상품가격*단위별 금액)
		String m_userid = ((MemberVO) session.getAttribute("loginStatus")).getM_userid();
		List<CartVOList> orderList = cartService.getCartList(m_userid);
		String itemName = orderList.get(0).getP_name() + "외 " + (orderList.size() - 1) + "개";
		int quantity = orderList.size() - 1; 
		
		ReadyResponse readyResponse = kakaopayService.payReady(itemName, quantity, m_userid, totalAmount);	
		
		return readyResponse;
	}
	
	//카카오페이 결제 승인 요청 : 큐알코드 찍어 결제 요청 한 후 카카오페이 서버에서 결제가 성공적으로 끝나면, 카카오페이 서버에서 호출하는 주소
	@GetMapping("/orderApproval")
	public String orderApproval(String pgToken, String tid){
		
		log.info("결제 고유 번호: " + tid);
		log.info("결제 승인 요청 인증 토큰: " + pgToken);
		
		ApproveResponse approveResponse = kakaopayService.payApprove(tid, pgToken);
		
		return "redirect:/user/order/orderComplete";
	}
	
	@GetMapping("/orderComplete")
	public void orderComplete() {
		
	}
}
