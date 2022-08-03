package com.docmall.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.docmall.domain.CartOrderInfo;
import com.docmall.mapper.OrderMapper;

import lombok.Setter;

@Service
public class OrderServiceImpl implements OrderService {

	@Setter(onMethod_ = {@Autowired})
	private OrderMapper orderMapper;
	
	//주문 폼 중 상품 목록
	@Override
	public List<CartOrderInfo> cartOrderList(String m_userid) {
		return orderMapper.cartOrderList(m_userid);
	}

}
