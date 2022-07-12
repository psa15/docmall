package com.docmall.service;

import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.docmall.dto.EmailDTO;

import lombok.Setter;

@Service
public class EmailServiceImpl implements EmailService {

	@Setter(onMethod_ = {@Autowired}) //jdk1.8에서만 onMethod에 언더바(_)가 붙는다
	private JavaMailSender mailSender;
	//mailSender : 메일 보내기 위한 객체
	
	@Override
	public void sendMail(EmailDTO dto, String authCode) {

		//메일 구성정보(받는사람, 보내는 사람 등)를 담당하는 객체
		MimeMessage msg = mailSender.createMimeMessage();
		
		try {
			//받는사람
			msg.addRecipient(RecipientType.TO, new InternetAddress(dto.getReceiveMail()));
			//RecipientType : MimeMessage가 있는 클래스 선택
			//new InternetAddress(dto.getReceiveMail()) : 받는 사람 메일 주소
			
			//보내는 사람
			msg.addFrom(new InternetAddress[] { new InternetAddress(dto.getSenderMail(), dto.getSenderName()) });
			//addFrom의 파라미터는 Address[] (배열형태) -> new InternetAddress[] {}
			
			//메일 제목
			msg.setSubject(dto.getSubject(), "utf-8");
			//받았을 때 글자 깨질까봐 인코딩 설정 추가
			
			//본문 내용
			msg.setText(authCode, "utf-8");
			
			//메일 보내기
			mailSender.send(msg); //G-Mail보안설정을 낮게 해야 정상적으로 메일 발송됨
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

}
