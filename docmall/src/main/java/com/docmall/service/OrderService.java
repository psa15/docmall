package com.docmall.service;

import java.util.List;

import com.docmall.domain.CartOrderInfo;
import com.docmall.domain.OrderVO;

public interface OrderService {

	//주문 폼 중 상품 목록
	List<CartOrderInfo> cartOrderList(String m_userid);
	
	//주문 하기 기능 : 주문 테이블(insert), 주문 상세테이블(insert), 장바구니 테이블(delete)->CartMapper
	void orderBuy(OrderVO vo);
}
