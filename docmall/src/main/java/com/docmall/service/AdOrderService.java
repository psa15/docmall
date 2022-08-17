package com.docmall.service;

import java.util.List;

import com.docmall.domain.OrderVO;
import com.docmall.dto.Criteria;

public interface AdOrderService {

	//주문 목록
	List<OrderVO> getOrderList(Criteria cri);
	//주문목록 개수
	int totalOrderCount(Criteria cri);
	
	//주문상태 변경
	void updateOrderStatus(Long o_code, String o_status);
	
	//선택한 주문 목록 삭제
	void deleteOrder(Long o_code);
}
