package com.docmall.domain;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

//장바구니 목록 불러오기 위한 클래스
@Getter //데이터를 읽어올 일만 있음
@ToString
@Data
public class CartVOList {

	/*
	 c.cart_code, c.m_userid, c.p_num, c.cart_acount, 
	 m.m_point, 
	 p.p_buy_ok, p.p_cost, p.p_image, p.p_image_datefolder, p.p_name,  p.p_discount, p.p_company
	 */
	//CartVO
	private Long cart_code;
	private String m_userid;
	private Integer p_num;
	private int cart_acount;
	
	//MemberVO
	private int m_point;

	//ProductVO
	private String p_buy_ok;
	private int p_cost;
	private String p_image;
	private String p_image_dateFolder;
	private String p_name;
	private int p_discount;
	private String p_company;
}
