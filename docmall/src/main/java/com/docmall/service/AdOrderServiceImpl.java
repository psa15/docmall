package com.docmall.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.docmall.domain.OrderVO;
import com.docmall.dto.Criteria;
import com.docmall.mapper.AdOrderMapper;

import lombok.Setter;

@Service
public class AdOrderServiceImpl implements AdOrderService {

	@Setter(onMethod_ = {@Autowired})
	private AdOrderMapper adOrderMapper;
	
	//주문 목록
	@Override
	public List<OrderVO> getOrderList(Criteria cri) {
		return adOrderMapper.getOrderList(cri);
	}
	//주문목록 개수
	@Override
	public int totalOrderCount(Criteria cri) {
		return adOrderMapper.totalOrderCount(cri);
	}
	
	//주문상태 변경
	@Override
	public void updateOrderStatus(Long o_code, String o_status) {
		adOrderMapper.updateOrderStatus(o_code, o_status);
	}
	
	//선택한 주문 목록 삭제
	@Override
	public void deleteOrder(Long o_code) {
		adOrderMapper.deleteOrder(o_code);
	}

}
