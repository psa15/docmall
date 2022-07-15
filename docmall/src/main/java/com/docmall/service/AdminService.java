package com.docmall.service;

import com.docmall.domain.AdminVO;
import com.docmall.dto.AdLoginDTO;

public interface AdminService {

	//로그인
	//AdminVO login(AdLoginDTO dto);
	AdminVO login(AdminVO vo);
}
