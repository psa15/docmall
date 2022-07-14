package com.docmall.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class EmailDTO {
	
	//메일에 들어가는 기본 정보
	private String senderName; //이메일 발신자 이름
	private String senderMail; //발신자 메일 주소
	private String receiveMail; //수신자 메일 주소	
	private String subject; //메일 제목
	private String message; //메일 내용
	
	//기본값 지정
	public EmailDTO() {
		this.senderName = "DocMall";
		this.senderMail = "DocMall"; //gmail smpt메일서버 정보 (현업 -> 회사 메일 서버 정보 이용)
		this.subject = "DocMall 회원가입 메일 인증코드입니다.";
		this.message = "메일 인증을 위한 인증코드를 확인하시고, 회원가입 시 인증코드 입력란에 입력하세요.";
	}
	
}
