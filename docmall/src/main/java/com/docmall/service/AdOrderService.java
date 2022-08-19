package com.docmall.service;

import java.util.List;
import java.util.Map;

import com.docmall.domain.OrderVO;
import com.docmall.domain.PaymentVO;
import com.docmall.dto.Criteria;

public interface AdOrderService {

	//주문 목록
	List<OrderVO> getOrderList(Criteria cri,String startDate, String endDate);
	//주문목록 개수
	int totalOrderCount(Criteria cri,String startDate, String endDate);
	
	//주문상태 변경
	void updateOrderStatus(Long o_code, String o_status);
	
	//선택한 주문 목록 삭제
	void deleteOrder(Long o_code);
	
	//선택한 주문 목록 삭제
	void deleteListOrder(List<Long> oCodeArr);
	
	//주문 상세 - 주문 정보
	OrderVO getOrderInfo(Long o_code);
	//주문 상세 - 결제 정보
	PaymentVO getPaymentInfo(Long o_code);
	//주문 상세 - 주문 상품 정보
	List<Map<String, Object>> getOrderProductInfo(Long o_code);
}
