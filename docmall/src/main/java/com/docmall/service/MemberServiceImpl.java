package com.docmall.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.docmall.domain.MemberVO;
import com.docmall.dto.LoginDTO;
import com.docmall.mapper.MemberMapper;

import lombok.Setter;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberMapper mapper;
	
	/* 롬복 스타일
	@Setter(onMethod_ = {@Autowired})
	private MemberMapper mapper;
	*/
	
	@Override
	public void join(MemberVO vo) {
		mapper.join(vo);
		
	}

	//ID 존재 여부 확인(중복체크)
	@Override
	public String idCheck(String m_userid) {
		return mapper.idCheck(m_userid);
	}

	//로그인 정보 인증작업
	@Override
	public MemberVO login_ok(LoginDTO dto) {
		return mapper.login_ok(dto);
	}

	//아이디 찾기
	@Override
	public String searchID(String m_username, String m_email) {
		return mapper.searchID(m_username, m_email);
	}

	//임시 비밀번호 발급하기 전 사용자가 입력한 데이터가 존재하는지 확인하기
	@Override
	public String getIdEmailExists(String m_userid, String m_email) {
		return mapper.getIdEmailExists(m_userid, m_email);
	}

	//임시비밀번호를 암호화하여 변경
	@Override
	public void changePw(String m_userid, String enc_m_passwd) {
		mapper.changePw(m_userid, enc_m_passwd);
	}

	//회원정보 수정
	@Override
	public void modify(MemberVO vo) {
		mapper.modify(vo);
	}

}
