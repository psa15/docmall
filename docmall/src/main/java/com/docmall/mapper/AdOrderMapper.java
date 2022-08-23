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
	
	//주문 상품 개별 취소
	//1)주문상세테이블 데이터 삭제
	void orderDetailProductDelete(@Param("o_code") Long o_code, @Param("p_num") Integer p_num); 
	//2)주문테이블 가격 수정
	void orderTotalPriceChange(@Param("o_code") Long o_code, @Param("o_unitprice") int o_unitprice);
	//3)결제테이블 결제 금액 수정
	void paymentTotalPriceChange(@Param("o_code") Long o_code, @Param("o_unitprice") int o_unitprice);
	//4) 주문 상세 테이블의 데이터가 1개임을 확인
	int getorderDetailProductCount(Long o_code);
	//5)결제 테이블 삭제
	void deletePayment(Long o_code);
}
	