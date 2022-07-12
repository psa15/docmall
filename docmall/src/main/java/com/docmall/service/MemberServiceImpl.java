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

	@Override
	public MemberVO login_ok(LoginDTO dto) {
		return mapper.login_ok(dto);
	}

}
