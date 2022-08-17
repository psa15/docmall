package com.docmall.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.docmall.domain.OrderVO;
import com.docmall.dto.Criteria;

public interface AdOrderMapper {

	//주문 목록
	List<OrderVO> getOrderList(Criteria cri);
	//주문목록 개수
	int totalOrderCount(Criteria cri);
	
	//주문상태 변경
	void updateOrderStatus(@Param("o_code") Long o_code, @Param("o_status") String o_status);
	
	//선택한 주문 목록 삭제
	void deleteOrder(Long o_code);
	
	//선택한 주문 목록 삭제
	void deleteListOrder(List<Long> oCodeArr);

}
	