package com.docmall.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.docmall.domain.MemberVO;
import com.docmall.service.MemberService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/member/*")
public class MemberController {
	
	@Autowired
	private MemberService service;
	
	//회원가입 폼
	@GetMapping("/join")
	public void join() {
		
	}
	//회원가입 저장
	@PostMapping("/join")
	public String join(MemberVO vo, RedirectAttributes rttr) throws Exception {
		//RedirectAttributes : db연동(회원가입(insert), 회원삭제(delete), 회원수정(update))을 마치고 다른 주소로 이동 시, 파라미터를 제공하는 목적으로 사용
		//MemberVO vo = new MemberVO(); 작업을 스프링이 객체 생성을 자동으로 해줌
				
		//지금은 자바스크립트로 메일수신여부를 반드시 체크하게 할 건데 
		//체크를 할 지 안할지 사용자가 선택하게 할 때 그 정보를 서버측으로 받아야 할 때는 판단이 필요
		if(vo.getM_email_accept().equals("on")) {
			vo.setM_email_accept("Y"); //체크 했을 때 m_email_accept=Y 출력 확인
		}

		log.info(vo);
		
		service.join(vo);
		
		return ""; //회원가입 후 이동할 주소
	}
	
	//id중복확인
	@GetMapping("/idCheck")
	@ResponseBody
	public ResponseEntity<String> idCheck( @RequestParam("m_userid") String m_userid){
		ResponseEntity<String> entity = null;
		
		////아이디 존재여부 작업(중복체크)
		String isUseID = "";
		
		if(service.idCheck(m_userid) != null) {
			isUseID = "no"; //id가 존재하므로 사용 불가
		} else {
			isUseID = "yes";
		}
		
		entity = new ResponseEntity<String>(isUseID, HttpStatus.OK);
		//isUseID 값이 ajax의 result값으로 넘어감
		
		return entity;
	}
	
}
