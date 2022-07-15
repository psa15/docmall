package com.docmall.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.docmall.domain.AdminVO;
import com.docmall.dto.AdLoginDTO;
import com.docmall.service.AdminService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/admin/*")
@Log4j
public class AdminController {

	@Setter(onMethod_ = {@Autowired})
	private AdminService adService;
	
	@Setter(onMethod_ = {@Autowired})
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	
	//로그인 폼(첫 페이지)
	@GetMapping("")
	public String login() {
		return "/admin/adLogin";
	}
	/* AdLoginDTO 를 추가한 버전
	//관리자 로그인
	@PostMapping("/login")
	public String login(AdLoginDTO dto, RedirectAttributes rttr, HttpSession session) throws Exception {
		
		//log.info("로그인 정보 " + dto); //사용자가 입력한 아이디와 비밀번호 확인
		
		AdminVO vo = adService.login(dto);
		//log.info("AdminVO: " + vo); //쿼리 실행 결과 확인
		
		String url = "";
		
		//메시지 추가
		String msg = "";
		
		if (vo != null) {
			String passwd = dto.getAdmin_pw(); //사용자가 입력한 비밀번호
			String db_passwd = vo.getAdmin_pw(); //db에 저장되어 있는 암호화된 비밀번호
			
			if(bCryptPasswordEncoder.matches(passwd, db_passwd)) {
				//1) 비번 일치되는 경우 -> 메인 페이지로
				url = "/admin/main"; 
				
				//로그인 성공 시 서버측에 세션을 통한 정보 저장
				session.setAttribute("adLoginStatus", vo);
				
				
			}else {	
				//2) 비번일치되지 않는 경우 -> 다시 로그인 페이지로
				url = "/admin/";
				
				msg = "noPw";
			}
			
		}else { //아이디가 존재하지 않는 경우
			
			url = "/admin/"; //다시 로그인 페이지로
			
			msg = "noID";
		}
		
		rttr.addFlashAttribute("msg", msg);
		
		return "redirect:" + url;
	}
	*/
	@PostMapping("/login")
	public String login(AdminVO vo, RedirectAttributes rttr, HttpSession session) throws Exception {
		
		AdminVO dbAdminVO = adService.login(vo);
		log.info("db 정보: " + dbAdminVO);
		
		String url = "";
		//메시지 추가
		String msg = "";
		
		if (dbAdminVO != null) {
			
			if(bCryptPasswordEncoder.matches(vo.getAdmin_pw(), dbAdminVO.getAdmin_pw())) {
				//1) 비번 일치되는 경우 -> 메인 페이지로
				url = "/admin/main"; 
				
				//로그인 성공 시 서버측에 세션을 통한 정보 저장
				session.setAttribute("adLoginStatus", vo);
				
				
			}else {	
				//2) 비번일치되지 않는 경우 -> 다시 로그인 페이지로
				url = "/admin/";
				
				msg = "noPw";
			}
			
		}else { //아이디가 존재하지 않는 경우
			
			url = "/admin/"; //다시 로그인 페이지로
			
			msg = "noID";
		}
		
		rttr.addFlashAttribute("msg", msg);
		
		return "redirect:" + url;
	}
	
	//메인 페이지
	@GetMapping("/main")
	public void main() {
		
	}
	
	//로그아웃
	@GetMapping("/adLogout")
	public String adLogout(HttpSession session) {
		session.invalidate();
		
		return "redirect:/admin/";
	}
}
