package com.docmall.service;

import com.docmall.domain.MemberVO;
import com.docmall.dto.LoginDTO;

//어노테이션 사용 x - 어노테이션을 사용하면 bean이 생성되는데 인터페이스는 객체 생성 X
public interface MemberService {

	//회원가입 저장		
	void join (MemberVO vo);
	
	//아이디 존재여부 작업(중복체크)
	//아이디가 없으면 null, 아이디가 있으면 아이디 출력
	String idCheck(String m_userid);
	
	//로그인 정보 인증작업
	MemberVO login_ok(LoginDTO dto);
}
