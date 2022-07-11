package com.docmall.controller;

import javax.servlet.http.HttpSession;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.docmall.dto.EmailDTO;

import lombok.extern.log4j.Log4j;

@Log4j
@RestController
@RequestMapping("/email/*")
public class EmailController {
	
	@GetMapping("/send")
	public ResponseEntity<String> send(EmailDTO dto, HttpSession session) {
		//HttpSession session : jsp 에서 로그인 연습할 때 사용했던 session.setAttributes
		
		ResponseEntity<String> entity = null;
		
		//인증코드 생성(6자리)
		String authCode = "";
		for(int i=0; i<6; i++) {
			authCode += String.valueOf((int)(Math.random()*10)); //0~9범위의 값
		}
		
		session.setAttribute("authCode", authCode);
		
		log.info("인증코드: " + authCode);
		
		return entity;
	}
}
