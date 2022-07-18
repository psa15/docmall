package com.docmall.domain;

import lombok.Data;

@Data
public class CategoryVO {
	//ct_code, ct_p_code, ct_name
	
	/*
	 ct_p_code가 null이면 ct_code필드는 1차 카테고리를 의미
	 ct_p_code가 not null이면 ct_code필드는 2차 카테고리를 의미
	 */
	private Integer ct_code;
	private Integer ct_p_code;
	private String ct_name;
}
