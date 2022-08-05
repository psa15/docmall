package com.docmall.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.docmall.domain.CartOrderInfo;
import com.docmall.domain.OrderVO;

public interface OrderMapper {

	// 장바구니 주문 목록 : 장바구니 테이블의 상품 여러개
	List<CartOrderInfo> cartOrderList(String m_userid);
	//바로구매 주문 목록 : 상품 1개 여도 List를 씀 -> 모델에서 동일하게 사용하기 위해
	List<CartOrderInfo> directOrderList(@Param("p_num") Integer p_num, @Param("o_amount") int o_amount);
	
	//주문 하기 기능 : 주문 테이블(insert), 주문 상세테이블(insert), 장바구니 테이블(delete)->CartMapper
	//1)주문 테이블
	void orderSave(OrderVO vo); //o_code필드가 시퀀스의 값으로 채워짐
	//2)주문 상세테이블
	void orderDetailSave(@Param("o_code") Long o_code, @Param("m_userid") String m_userid);
	
}
