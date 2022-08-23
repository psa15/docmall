package com.docmall.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
	@Transactional
	@Override
	public void deleteOrder(Long o_code) {
		
		//주문 삭제 기능 : 관련된 작업 모두 삭제, 트랙잭션 설정
		//주문 테이블 삭제(처리)
		adOrderMapper.deleteOrder(o_code);
		
		//아래는 트리거에서 처리도 가능
		//주문 상세 테이블 삭제
		
		//결제 테이블 삭제
		
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
	
	//주문 상세 - 주문 상품 정보
	@Override
	public List<Map<String, Object>> getOrderProductInfo(Long o_code) {
		return adOrderMapper.getOrderProductInfo(o_code);
	}
	
	//주문 상품 개별 삭제
	@Transactional
	@Override
	public void orderUnitProductDelete(Long o_code, Integer p_num, int o_unitprice) {
		//테이블의 조건식에 일치하는 데이터가 존재하지 않아도 정상 실행됨(DELETE + UPDATE)
		
		//주문 상품 중 마지막 상품을 취소시(주문 상세 테이블의 데이터가 1개이면) 체크 주문테이블, 결제 테이블 주문 정보 삭제
		if(adOrderMapper.getorderDetailProductCount(o_code) == 1) {
			
			//주문 테이블 삭제
			adOrderMapper.deleteOrder(o_code);
			
			//결제 테이블 삭제
			adOrderMapper.deletePayment(o_code);
			
		}
				
		//주문 상세 테이블의 상품 삭제
		adOrderMapper.orderDetailProductDelete(o_code, p_num);
		
		//주문 테이블의 총 주문 금액 변경
		adOrderMapper.orderTotalPriceChange(o_code, o_unitprice);
		//결제 테이블의 총 주문 금액 변경
		adOrderMapper.paymentTotalPriceChange(o_code, o_unitprice);
		
	}

}
