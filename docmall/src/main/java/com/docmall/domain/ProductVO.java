package com.docmall.domain;

import java.util.Date;

import lombok.Data;

//TBL_PRODUCT
@Data
public class ProductVO {
	//p_num, f_ct_code, s_ct_code, p_name, p_cost, 
	//p_discount, p_company, p_image, p_amount, p_buy_ok, 
	//p_regdate, p_updatedate, p_detail
	private Integer p_num;
	private Integer f_ct_code; //1차 카테고리
	private Integer s_ct_code; //2차 카테고리
	private String p_name;
	private int p_cost;
	private int p_discount;
	private String p_company;
	private int p_amount;
	private String p_buy_ok;
	private String p_image;
	private Date p_regdate;
	private Date p_updatedate;
	private String p_detail;
}
