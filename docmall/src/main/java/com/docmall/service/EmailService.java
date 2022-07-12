package com.docmall.service;

import com.docmall.dto.EmailDTO;

public interface EmailService {

	void sendMail(EmailDTO dto, String message);
	//EmailDTO dto : 이메일 관련 정보
	//String message : 본문 내용
}
