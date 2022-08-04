package com.docmall.domain;

import java.util.Date;

import lombok.Data;

//TBL_ORDER
@Data
public class OrderVO {

	//o_code, m_userid, o_name, o_post, o_addr, o_addr_d, o_tel, o_totalcost, o_date, o_message
	private Long o_code; //시퀀스
	private String m_userid; //session
	private String o_name; //배송받는 사람 이름 - 입력 데이터
	private String o_post; //     "   우편번호         "
	private String o_addr; 
	private String o_addr_d;
	private String o_tel;
	private int o_totalcost; //
	private Date o_date; //sysdate
	private String o_message;
}
