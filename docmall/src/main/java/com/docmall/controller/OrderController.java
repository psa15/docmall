package com.docmall.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.docmall.domain.CartOrderInfo;
import com.docmall.domain.MemberVO;
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
	
	//주문 내역
	@GetMapping("/orderListInfo")
	public void orderListInfo(HttpSession session, Model model) {
		
		String m_userid = ((MemberVO) session.getAttribute("loginStatus")).getM_userid();
		
		List<CartOrderInfo> cartOrderList = orderService.cartOrderList(m_userid);
		
		for(int i=0; i<cartOrderList.size();i++) {
			String p_image_folder = cartOrderList.get(i).getP_image_dateFolder().replace("\\", "/");
			cartOrderList.get(i).setP_image_dateFolder(p_image_folder);
		}
		
		model.addAttribute("cartOrderList", cartOrderList);
		
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
}
