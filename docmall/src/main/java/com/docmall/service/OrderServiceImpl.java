package com.docmall.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.docmall.domain.CartOrderInfo;
import com.docmall.domain.OrderVO;
import com.docmall.mapper.CartMapper;
import com.docmall.mapper.OrderMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class OrderServiceImpl implements OrderService {

	@Setter(onMethod_ = {@Autowired})
	private OrderMapper orderMapper;
	
	//장바구니 mapper 참조
	@Setter(onMethod_ = {@Autowired})
	private CartMapper cartMapper;
	
	//주문 폼 중 상품 목록
	@Override
	public List<CartOrderInfo> cartOrderList(String m_userid) {
		return orderMapper.cartOrderList(m_userid);
	}

	//바로구매 주문 목록
	@Override
	public List<CartOrderInfo> directOrderList(Integer p_num, int o_amount) {
		return orderMapper.directOrderList(p_num, o_amount);
	}

	//주문 하기 기능 : 주문 테이블(insert), 주문 상세테이블(insert), 장바구니 테이블(delete)->CartMapper
	@Transactional
	@Override
	public void orderBuy(OrderVO vo) {
		
		//1)주문 테이블
		orderMapper.orderSave(vo);

		//2)주문상세테이블에 저장(장바구니 테이블에서 이동작업)
		//시퀀스 값 확보 -> 주문상세테이블에 저장할 때 사용
		Long o_code = vo.getO_code();
		String m_userid = vo.getM_userid();
		log.info("번호: " + o_code);
		log.info(m_userid);
		
		orderMapper.orderDetailSave(o_code, m_userid);		
		
		//3)장바구니비우기 - CartMapper에 만들어져있는 메소드 재사용
		//직접 구매 진행 시 장바구니에 데이터가 존재하지 않아 실행은 되지만 삭제되는 데이터가 없다.
		cartMapper.clearCart(m_userid);
	}


	

}
