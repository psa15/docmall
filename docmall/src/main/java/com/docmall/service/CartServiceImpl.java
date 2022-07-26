package com.docmall.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.docmall.domain.CartVO;
import com.docmall.mapper.CartMapper;

import lombok.Setter;

@Service
public class CartServiceImpl implements CartService {

	@Setter(onMethod_ = {@Autowired})
	private CartMapper cartMapper;

	//장바구니 담기 기능
	@Override
	public void addCart(CartVO vo) {
		cartMapper.addCart(vo);
	}
	
	
}
