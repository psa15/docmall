package com.docmall.mapper;

import org.apache.ibatis.annotations.Param;

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
	
	//id 찾기
	//@Param("") 안의 이름을 xml파일에서 사용하는 것!
	String searchID(@Param("m_username") String m_username, @Param("m_email") String m_email);
	
	//임시 비밀번호 발급하기 전 사용자가 입력한 데이터가 존재하는지 확인하기
	String getIdEmailExists(@Param("m_userid") String m_userid, @Param("m_email") String m_email);
	
	//임시비밀번호를 암호화하여 변경
	void changePw(@Param("m_userid") String m_userid, @Param("m_passwd") String enc_m_passwd);

	//회원정보 수정
	void modify(MemberVO vo);
}
