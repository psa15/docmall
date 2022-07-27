package com.docmall.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.docmall.domain.CartVO;
import com.docmall.domain.CartVOList;
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

	//장바구니 목록가져오기(페이징 생략)
	@Override
	public List<CartVOList> getCartList(String m_userid) {
		return cartMapper.getCartList(m_userid);
	}

	//장바구니에서 수량 변경
	@Override
	public void changeCartAcount(Long cart_code, int cart_acount) {
		cartMapper.changeCartAcount(cart_code, cart_acount);
	}

	
	
	
	
}
