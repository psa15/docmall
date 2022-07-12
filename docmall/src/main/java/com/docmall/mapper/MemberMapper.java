package com.docmall.mapper;

import com.docmall.domain.MemberVO;
import com.docmall.dto.LoginDTO;

public interface MemberMapper {

	//회원가입 저장
	//controller의 파라미터가 insert문에 해당하는 모든 정보를 커버할 수 있는지 확인해보기
	void join (MemberVO vo);
	
	//아이디 존재여부 작업(중복체크)
	String idCheck(String m_userid);
	
	//로그인 정보 인증작업
	MemberVO login_ok(LoginDTO dto); //조건식에 아이디만 사용할 예정

}
