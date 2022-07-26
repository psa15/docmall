package com.docmall.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.docmall.domain.CartVO;
import com.docmall.domain.MemberVO;
import com.docmall.mapper.CartMapper;
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
}
