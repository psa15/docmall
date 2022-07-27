package com.docmall.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.docmall.domain.CartVO;
import com.docmall.domain.CartVOList;

public interface CartMapper {

	//장바구니 담기 기능
	void addCart(CartVO vo);
	
	//장바구니 목록가져오기(페이징 생략)
	List<CartVOList> getCartList(String m_userid);
	
	//장바구니에서 수량 변경
	void changeCartAcount(@Param("cart_code") Long cart_code, @Param("cart_acount") int cart_acount);
}
