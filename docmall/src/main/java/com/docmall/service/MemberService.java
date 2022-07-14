package com.docmall.service;

import org.apache.ibatis.annotations.Param;

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
	
	//아이디 찾기
	String searchID(String m_username, String m_email);
	
	//임시 비밀번호 발급하기 전 사용자가 입력한 데이터가 존재하는지 확인하기
	String getIdEmailExists(String m_userid, String m_email);
	
	//임시비밀번호를 암호화하여 변경
	void changePw(String m_userid, String enc_m_passwd);

	//회원정보 수정
	void modify(MemberVO vo);
}
