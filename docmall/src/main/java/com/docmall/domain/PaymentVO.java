package com.docmall.domain;

import java.util.Date;

import lombok.Data;

@Data
public class PaymentVO {

	/*
	 pay_code, o_code, pay_method, pay_date, pate_tot_price, 
	 pay_rest_price, pay_price, pay_user, pay_bank
	 */
	private Integer pay_code; //시퀀스
	private Long o_code;	//주문번호
	private String pay_method;	//사용자 선택 및 입력
	private Date pay_date;	//sql(sysdate)
	private int pate_tot_price;
	private int pay_rest_price;
	private int pay_price; //무통장 입금 가격
	private String pay_user; //무통장 입금자 명
	private String pay_bank; //무통장 입금 은행
	
}
