package com.docmall.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.docmall.dto.EmailDTO;
import com.docmall.service.EmailService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@RestController //비동기 방식으로 ajax 방식을 사용하기 위해
@RequestMapping("/email/*")
public class EmailController {
	
	@Setter(onMethod_ = {@Autowired})
	private EmailService service;
	
	@GetMapping("/send")
	public ResponseEntity<String> send(EmailDTO dto, HttpSession session) {
		//HttpSession session : jsp 에서 로그인 연습할 때 사용했던 session.setAttributes
		//EmailDTO dto : 사용자가 입력한 메일주소(receiveMail)
		
		ResponseEntity<String> entity = null;
		
		//인증코드 생성(6자리)
		String authCode = "";
		for(int i=0; i<6; i++) {
			authCode += String.valueOf((int)(Math.random()*10)); //0~9범위의 값
		}
		
		session.setAttribute("authCode", authCode);
		//session객체를 통해 "authCode"라는 이름으로 인증코드 정보를 서버측 메모리에 저장
		
		log.info("인증코드: " + authCode);
		
		//메일 보내기 기능
		try {
			
			service.sendMail(dto, authCode);
			entity = new ResponseEntity<String>("success", HttpStatus.OK);
			
		}catch (Exception e) {
			//콘솔
			e.printStackTrace();
			
			//에러라고 넘겨주기
			entity = new ResponseEntity<String>("error", HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
}
