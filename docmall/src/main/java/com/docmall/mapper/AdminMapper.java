package com.docmall.mapper;

import com.docmall.domain.AdminVO;
import com.docmall.dto.AdLoginDTO;

public interface AdminMapper {

	//로그인
	//AdminVO login(AdLoginDTO dto);
	AdminVO login(AdminVO vo);
}
