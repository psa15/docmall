package com.docmall.domain;

import lombok.Data;

//TBL_ORDER_D
@Data
public class OrderDetailVO {

	//o_code, p_num, o_amount, o_cost
	private Long o_code;
	private Integer p_num;
	private int o_amount;
	private int o_cost; //상품 가격 * 수량
}
