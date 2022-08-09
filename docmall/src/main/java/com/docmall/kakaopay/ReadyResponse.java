package com.docmall.kakaopay;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

//결제 준비 단계의 Response 데이터 - https://developers.kakao.com/docs/latest/ko/kakaopay/single-payment
@Getter
@Setter
@ToString
public class ReadyResponse {

	private String tid;
	private String next_redirect_pc_url;
	private String partner_order_id;
}
