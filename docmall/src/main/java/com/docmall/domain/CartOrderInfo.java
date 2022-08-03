package com.docmall.domain;

import lombok.Data;

//상품 테이블과 장바구니 테이블 조인
@Data
public class CartOrderInfo {

	/*
	 c.cart_code, c.p_num, c.m_userid, c.cart_acount,
     p.p_name, p.p_cost, p.p_discount, p.p_company, 
     p.p_image, p.p_image_datefolder
	 */
	private Long cart_code;
	private Integer p_num;
	private String m_userid;
	private int cart_acount;
	private String p_name;
	private int p_cost;
	private int p_discount;
	private String p_company;
	private String p_image;
	private String p_image_dateFolder;
}
