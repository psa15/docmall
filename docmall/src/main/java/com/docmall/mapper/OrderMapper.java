package com.docmall.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.docmall.domain.CartOrderInfo;
import com.docmall.domain.OrderVO;

public interface OrderMapper {

	//주문 폼 중 상품 목록
	List<CartOrderInfo> cartOrderList(String m_userid);
	
	//주문 하기 기능 : 주문 테이블(insert), 주문 상세테이블(insert), 장바구니 테이블(delete)->CartMapper
	//1)주문 테이블
	void orderSave(OrderVO vo); //o_code필드가 시퀀스의 값으로 채워짐
	//2)주문 상세테이블
	void orderDetailSave(@Param("o_code") Long o_code, @Param("m_userid") String m_userid);
	
}
