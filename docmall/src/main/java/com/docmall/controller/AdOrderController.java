package com.docmall.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.docmall.domain.OrderVO;
import com.docmall.dto.Criteria;
import com.docmall.dto.PageDTO;
import com.docmall.service.AdOrderService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/admin/order/*")
public class AdOrderController {
	
	@Setter(onMethod_ = {@Autowired})
	private AdOrderService adOrderService;
	
	//주문 목록
	@GetMapping("/orderList")
	public void orderList(Criteria cri, Model model) {
		
		List<OrderVO> orderList = adOrderService.getOrderList(cri);
		model.addAttribute("orderList", orderList);
		
		int total = adOrderService.totalOrderCount(cri);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}
	
	//배송 상태 변경
	@GetMapping("/orderStatusChange")
	@ResponseBody
	public ResponseEntity<String> orderStatusChange(Long o_code, String o_status){
		
		ResponseEntity<String> entity = null;
		
		adOrderService.updateOrderStatus(o_code, o_status);
		
		entity = new ResponseEntity<String>("success", HttpStatus.OK);
			
		return entity;
	}
	
	//선택된 주문목록 삭제
	/*
	 ajax 구문으로 배열값이 파라미터로 전송될 경우 스프링에서의 파라미터 작업
	  - @RequestParam("배열명[]")
	 ajax가 아닌 동일한 name으로 (동일한 파라미터명으로) 데이터가 전송될 경우 파라미터 작업
	 - @RequestParam("배열명")
	 */
	@ResponseBody
	@PostMapping("/deleteCheckOrder")
	public ResponseEntity<String> deleteCheckOrder(@RequestParam("oCodeArr[]") List<Long> oCodeArr){
				
		ResponseEntity<String> entity = null;
		
		//방법 1) 단순하게 for문 으로 받기
		/*
		 * for(int i=0; i<oCodeArr.size(); i++) {
		 * 
		 * //주문번호를 이용하여 삭제구문 진행 adOrderService.deleteOrder(oCodeArr.get(i));
		 * 
		 * }
		 */
		
		/*
		 방법2) 쿼리로 생성
		 delete 주문테이블 where 주문번호 in (x, y, z,,,,,)
		 */
		
		
		
		entity = new ResponseEntity<String>("success", HttpStatus.OK);
		
		return entity;
	}

}
