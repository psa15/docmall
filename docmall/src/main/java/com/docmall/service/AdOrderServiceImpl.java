package com.docmall.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.docmall.domain.OrderVO;
import com.docmall.domain.PaymentVO;
import com.docmall.dto.Criteria;
import com.docmall.mapper.AdOrderMapper;

import lombok.Setter;

@Service
public class AdOrderServiceImpl implements AdOrderService {

	@Setter(onMethod_ = {@Autowired})
	private AdOrderMapper adOrderMapper;
	
	//주문 목록
	@Override
	public List<OrderVO> getOrderList(Criteria cri,String startDate, String endDate) {
		return adOrderMapper.getOrderList(cri, startDate, endDate);
	}
	//주문목록 개수
	@Override
	public int totalOrderCount(Criteria cri,String startDate, String endDate) {
		return adOrderMapper.totalOrderCount(cri, startDate, endDate);
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
	
	//선택한 주문 목록 삭제 - 쿼리 사용
	@Override
	public void deleteListOrder(List<Long> oCodeArr) {
		adOrderMapper.deleteListOrder(oCodeArr);
	}
	
	//주문 상세 - 주문 정보
	@Override
	public OrderVO getOrderInfo(Long o_code) {
		return adOrderMapper.getOrderInfo(o_code);
	}
	
	//주문 상세 - 결제 정보
	@Override
	public PaymentVO getPaymentInfo(Long o_code) {
		return adOrderMapper.getPaymentInfo(o_code);
	}

}
