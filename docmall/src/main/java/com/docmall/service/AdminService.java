package com.docmall.service;

import com.docmall.domain.AdminVO;
import com.docmall.dto.AdLoginDTO;

public interface AdminService {

	//로그인
	//AdminVO login(AdLoginDTO dto);
	AdminVO login(AdminVO vo);
	
	//로그인 날짜 업데이트
	void updateLoginDate(AdminVO vo);
}
