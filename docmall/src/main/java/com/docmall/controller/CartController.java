package com.docmall.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.docmall.domain.CartVO;
import com.docmall.domain.CartVOList;
import com.docmall.domain.MemberVO;
import com.docmall.service.CartService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/user/cart/*")
public class CartController {

	@Setter(onMethod_ = {@Autowired})
	private CartService cartService;
	
	//장바구니 담기
	@ResponseBody
	@GetMapping("/addCart")
	public ResponseEntity<String> addCart(CartVO vo, HttpSession session) {
		
		ResponseEntity<String> entity = null;		
		
		//세션으로 로그인 시 사용한 정보를 사용
		String m_userid = ((MemberVO) session.getAttribute("loginStatus")).getM_userid();
		vo.setM_userid(m_userid);
		
		log.info("장바구니: " + vo);		
		
		cartService.addCart(vo);
		
		entity = new ResponseEntity<String>("success", HttpStatus.OK);
		
		return entity;
	}
	
	//로그인 한 사용자가 사용하는 매핑주소의 메서드는 파라미터에 HttpSession session이 반드시 있어야 함
	// -> 세선에 로그인한 사용자 정보가 저장되어 있음
	//Model model : jsp에 데이터 전달 하여 정보를 보여주고자 할 때 사용
	//장바구니 폼
	@GetMapping("/cartList")
	public void cartList(HttpSession session, Model model) {
		//회원만 장바구니 담고 구매할 수 있어서 session객체 필요
		String m_userid = ((MemberVO) session.getAttribute("loginStatus")).getM_userid();
		//로그인 메소드에 session.setAttribute("loginStatus",vo); 코드를 통해 저장함 -> get으로 가져오는 것!
		
		List<CartVOList> cartList = cartService.getCartList(m_userid);
		for(int i=0; i<cartList.size();i++) {
			String p_image_folder = cartList.get(i).getP_image_dateFolder().replace("\\", "/");
			cartList.get(i).setP_image_dateFolder(p_image_folder);
		}
		
		model.addAttribute("cartList", cartList);
		
	}
	
	@ResponseBody
	@GetMapping("/cartAcountChange")
	public ResponseEntity<String> cartAcountChange(@RequestParam("cart_code") Long cart_code, @RequestParam("cart_acount") int cart_acount) {
		
		ResponseEntity<String> entity = null;
		
		cartService.changeCartAcount(cart_code, cart_acount);
		
		entity = new ResponseEntity<String>("success", HttpStatus.OK);
		
		return entity;
	}
	
	@GetMapping("/cartAcountChange2")
	public String cartAcountChange2(@RequestParam("cart_code") Long cart_code, @RequestParam("cart_acount") int cart_acount) {
				
		cartService.changeCartAcount(cart_code, cart_acount);
		
		return "redirect:/user/cart/cartList";
	}
}
