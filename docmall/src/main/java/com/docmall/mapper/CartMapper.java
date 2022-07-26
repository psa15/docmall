package com.docmall.mapper;

import com.docmall.domain.CartVO;

public interface CartMapper {

	//장바구니 담기 기능
	void addCart(CartVO vo);
}
