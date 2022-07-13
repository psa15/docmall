package com.docmall.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.docmall.domain.MemberVO;
import com.docmall.dto.LoginDTO;
import com.docmall.service.MemberService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/member/*")
public class MemberController {
	
	//스프링 시큐리티 암호화 클래스 bean 주입
	
	@Setter(onMethod_ = {@Autowired})
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	
	@Setter(onMethod_ = {@Autowired})
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
			
		//vo.getM_passwd() : 평문 텍스트 비밀번호
		String cryptEncoderPw = bCryptPasswordEncoder.encode(vo.getM_passwd());
		//cryptEncoderPw : 암호화된 비밀번호
		
//		log.info("평문 비밀번호: " + vo.getM_passwd()); //12345
//		log.info("암호화된 비밀번호 " + cryptEncoderPw); //$2a$10$uWNN6bqRqh6KK/yGhQQ15eGx0eROld8UqeBGh.gkJ63Q/ezuJZ6Ku
//		log.info("암호화된 비밀번호 길이 : " + cryptEncoderPw.length()); //60
		
		vo.setM_passwd(cryptEncoderPw); //평문텍스트 비밀번호 -> 암호화된 비밀번호로 변경하기
		
		
		//지금은 자바스크립트로 메일수신여부를 반드시 체크하게 할 건데 
		//체크를 할 지 안할지 사용자가 선택하게 할 때 그 정보를 서버측으로 받아야 할 때는 판단이 필요
		if(vo.getM_email_accept().equals("on")) {
			vo.setM_email_accept("Y"); //체크 했을 때 m_email_accept=Y 출력 확인
		}

		log.info(vo);
		
		//db저장
		service.join(vo);
		
		return "/member/login"; //회원가입 후 로그인 주소로 이동
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
	
	//메일 인증확인 작업
	@PostMapping("/confirmAuthCode")
	@ResponseBody //ajax작업
	public ResponseEntity<String> confirmAuthCode(String uAuthCode, HttpSession session) {
		
		ResponseEntity<String> entity = null;
		
		String authCode = (String) session.getAttribute("authCode");
		//emailcontroller의 session.setAttribute("authCode", authCode); 의 값인 authCode가 Object 타입이어서 String으로 형변환 필요
		
		if(uAuthCode.equals(authCode)) {
			entity = new ResponseEntity<String>("success", HttpStatus.OK);
			
			//세션 정보가 더이상 필요 없으면 세션을 사용하고 난 후 즉시 제거해야 한다.
			session.removeAttribute("authCode");
			
		} else {
			entity = new ResponseEntity<String>("fail", HttpStatus.OK);
		}
		return entity;
	}
	
	//로그인 폼
	@GetMapping("/login")
	public void login() {
		log.info("로그인 폼");
	}
	//로그인 작업
	@PostMapping("/loginPost")
	public String login_ok(LoginDTO dto, RedirectAttributes rttr, HttpSession session) throws Exception {
		//throws Exception : db작업이 들어가므로
		log.info("로그인 정보 " + dto);
		
		//로그인 정보 인증 작업
		MemberVO vo = service.login_ok(dto);		
		
		String url = ""; //아이디와 비밀번호 일치 여부에 따라 달라지는 다음 주소
		
		//RedirectAttributes인터페이스
		//1)rttr.addFlashAttribute(attributeName, attributeValue); : 페이지 이동주소의 jsp에서 참조할 경우		
		/*
		 2)rttr.addAttribute(attributeName, attributeValue);
		 	- 리다이렉트 주소에 파라미터로 사용 -> /member/login?파라미터=값 이런 형태로 구성해줌
		 
		 /member/login?pageNum=값&amount=값
		  - rttr.addAttribute("pageNum", pageNum);
		  - rttr.addAttribute("amount", amount);
		 */
		
		String msg = "";
		
		if(vo != null) {//아이디가 존재하는 경우
			
			//사용자가 입력한 평문텍스트(일반 비밀번호)와 db에 저장된 암호화된 비밀번호를 비교
			
				
			String passwd = dto.getM_passwd(); //사용자가 입력한 비밀번호
			String db_passwd = vo.getM_passwd(); //db에서 가져온 비밀번호(암호화 처리 전임)
			
			if(bCryptPasswordEncoder.matches(passwd, db_passwd)) {
				//1) 비번 일치되는 경우 -> 메인 페이지로
				url = "/"; 
				
				session.setAttribute("loginStatus", vo); 
				//로그인 성공 시 서버측에 세션을 통한 정보 저장
				//vo : 회원가입시 필요한 정보들이 loginStatus라는 이름으로 다 들어 있음
				
				msg="loginSuccess";
				
			}else {	
				//2) 비번일치되지 않는 경우 -> 다시 로그인 페이지로
				url = "/member/login";
				
				msg="wrongPassword";
			}
			
		}else { //아이디가 존재하지 않는 경우
			
			url = "/member/login"; //다시 로그인 페이지로
			
			msg="wrongId";
			
		}
		
		rttr.addFlashAttribute("msg", msg);
		//이동하는 주소의 jsp에서 키("msg")로 참조
		
		return "redirect:" + url;
	}
	
	//로그아웃 - 실제는 post방식을 사용(보안적이유)
	@GetMapping("/logout")
	public String logout(HttpSession session, RedirectAttributes rttr) {
		//세션 제거 해야함 HttpSession
		//사용자에게 메시지를 주고 싶음 RedirectAttributes
		
		//세션 소멸
		session.invalidate(); //모든 세션을 소멸시키는 메소드
		
		//로그아웃 됐다고 알려주기
		rttr.addFlashAttribute("msg", "logout"); //jsp에서 참조
		
		return "redirect:/";
	}
	
	//아이디 비밀번호 찾기 폼
	@GetMapping("/lostIDPw")
	public void lostIDPw() {
		
	}
	
}
