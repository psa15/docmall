package com.docmall.domain;

import lombok.Data;

//TBL_CART
@Data
public class CartVO {

	//cart_code, p_num, m_userid, cart_acount
	private Long cart_code;
	private Integer p_num;
	private String m_userid;
	private int cart_acount;
}
