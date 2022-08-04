package com.docmall.domain;

import lombok.Data;

//TBL_ORDER_D
@Data
public class OrderDetailVO {

	//o_code, p_num, o_amount, o_cost
	private Long o_code; //tbl_order 테이블의 o_code 시퀀스 값을 참조 - </selectKey> 사용
	private Integer p_num;
	private int o_amount;
	private int o_cost; //상품 가격 * 수량 - 주문리스트의 주문상품에서 가져오는 방법도 있고, 장바구니에서 참조해와도 됨
}
