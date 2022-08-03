package com.docmall.mapper;

import java.util.List;

import com.docmall.domain.CartOrderInfo;

public interface OrderMapper {

	//주문 폼 중 상품 목록
	List<CartOrderInfo> cartOrderList(String m_userid);
}
