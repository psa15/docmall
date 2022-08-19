package com.docmall.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.docmall.domain.OrderVO;
import com.docmall.domain.PaymentVO;
import com.docmall.dto.Criteria;

public interface AdOrderMapper {

	//목록과 카운트작업은 조건을 동일하게 해야 한다.!!!!!!!!!!
	//주문 목록
	List<OrderVO> getOrderList(@Param("cri") Criteria cri, @Param("startDate") String startDate, @Param("endDate") String endDate);
	//주문목록 개수
	int totalOrderCount(@Param("cri") Criteria cri, @Param("startDate") String startDate, @Param("endDate") String endDate);
	
	//주문상태 변경
	void updateOrderStatus(@Param("o_code") Long o_code, @Param("o_status") String o_status);
	
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
	