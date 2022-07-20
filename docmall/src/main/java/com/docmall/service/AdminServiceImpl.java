package com.docmall.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.docmall.domain.AdminVO;
import com.docmall.dto.AdLoginDTO;
import com.docmall.mapper.AdminMapper;

import lombok.Setter;

@Service
public class AdminServiceImpl implements AdminService {

	@Setter(onMethod_ = {@Autowired})
	private AdminMapper adMapper;

	//로그인
	@Override
	public AdminVO login(AdminVO vo) {
		return adMapper.login(vo);
	}

	////로그인 날짜 업데이트
	@Override
	public void updateLoginDate(AdminVO vo) {
		adMapper.updateLoginDate(vo);
	}	
	/*
	@Override
	public AdminVO login(AdLoginDTO dto) {
		return adMapper.login(dto);
	}
*/

}
