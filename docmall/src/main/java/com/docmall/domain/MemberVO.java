package com.docmall.domain;

import java.util.Date;

import lombok.Data;

@Data //getter, setter, toString 메소드 자동 생성
public class MemberVO {

	//m_userid, m_username, m_passwd, m_postnum, m_addr, 
	//m_addr_d, m_tel, m_nickname, m_email, m_email_accept, 
	//m_point, m_regdate, m_updatedate, m_lastdate, m_authcode
	private String m_userid;	//회원 id
	private String m_username;	//회원 이름
	private String m_passwd;	//회원 비밀번호
	private String m_postnum;	//우편번호(char(5))
	private String m_addr;		//주소
	private String m_addr_d;	//상세 주소
	private String m_tel;		//전화번호
	private String m_nickname;	//닉네임
	private String m_email;		//이메일
	private String m_email_accept;	//이메일 수신 동의 여부 (char(1) default 'Y')
	private int m_point;		//적립금
	private Date m_regdate;		//가입 날짜
	private Date m_updatedate;	//수정 날짜
	private Date m_lastdate;	//마지막 로그인 날짜
	private String m_authcode;	//이메일 인증 코드 (char(1) default 'N')
}
