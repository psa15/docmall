package com.docmall.service;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import com.docmall.domain.OrderVO;
import com.docmall.kakaopay.ApproveResponse;
import com.docmall.kakaopay.ReadyResponse;

import lombok.extern.log4j.Log4j;

//인터페이스 없이 단독 클래스 구성

@Service
@Log4j
public class KakaoPayServiceImpl {

	//1) 카카오 pay에서 요청하는 정보
	public ReadyResponse payReady(String itemName,int quantity, String m_userid, int totalAmount) {
		
		String order_id = "100";
//		String itemName = "테스트 상품";
//		int quantity = 1;
		
		//카카오페이가 요청한 결제요청 request 정보를 구성
		//MultiValueMap : 키 하나 당 값 여러개 갖는 구조의 스프링 프레임워크에서 제공하는 map
		//컬렉션 Map 인터페이스의 특징은 key 1개 당 value 1개라는 특징 -> map.put("key", "value")
		MultiValueMap<String, String> parameters = new LinkedMultiValueMap<String, String>();
		
		parameters.add("cid", "TC0ONETIME"); //테스트 가맹점 아이디
		parameters.add("partner_order_id", order_id); //가맹점 주문번호 = 고객 주문번호
		parameters.add("partner_user_id", m_userid); //가맹점 회원 id
		parameters.add("item_name", itemName ); //상품명 cf 000상품 외 2건
		parameters.add("quantity", String.valueOf(quantity)); //상품 수량
		parameters.add("total_amount", String.valueOf(totalAmount)); //상품 총액
		parameters.add("tax_free_amount", "0"); //상품 비과세 금액
		parameters.add("approval_url", "http://localhost:9090/user/order/orderApproval"); //결제 성공시 redirect url
		parameters.add("cancel_url", "http://localhost:9090/user/order/orderCancel"); //결제 취소시
		parameters.add("fail_url", "http://localhost:9090/user/order/orderFail"); //결제 실패시 redirect url
		
		//HttpEntity<T> 클래스 : HttpHeader와 HttpBody를 포함하는 클래스
		//HttpEntity<T> 클래스를 상속받아 구현한 클래스 : RequestEntity, ResponseEntity
		//ResponseEntity 클래스에 HttpStatus, HttpBody, HttpHeaders 관리
		HttpEntity<MultiValueMap<String, String>> requestEntity = new HttpEntity<MultiValueMap<String,String>>(parameters, this.getHeaders());
		
		/*외부 URL 통신
		 RestTemplate : spring 3.0에서 지원, http 통신에 사용하는 기능을 제공
		  - Http서버와의 통신을 단순화하고 Restfull원칙을 지킴
		  - 특징
		  	- 기계적이고 반복적인 코드를 최대한 줄여줌
		  	- Restfull 형식, json or xml 형태로 응답을 받아 쉽게 사용 가능
		 */
		RestTemplate template = new RestTemplate();
		//결제 준비의 요청 주소(https://developers.kakao.com/docs/latest/ko/kakaopay/single-payment)
		String url = "https://kapi.kakao.com/v1/payment/ready";
		
		//메인(첫번째 요청) - 카카오 페이에서 응답해준 json형태의 데이터를 ReadyResponse 객체로 변환하여 받기 위해
		ReadyResponse readyResponse = template.postForObject(url, requestEntity, ReadyResponse.class);
		
		return readyResponse;
		
	}
	
	//두번째 요청 : 결제 승인 요청 메소드
	public ApproveResponse payApprove(String tid, String pgToken) {
		
		String order_id = "100";
		
		MultiValueMap<String, String> parameters = new LinkedMultiValueMap<String, String>();
		
		parameters.add("cid", "TC0ONETIME"); //테스트 가맹점  ID
		parameters.add("tid", tid);	//카카오 페이에서 보내준 결재 고유 ID
		parameters.add("partner_order_id", order_id);	//가맹점 주문 번호
		parameters.add("partner_user_id", "doccomsa");	//가맹점 회원 id
		parameters.add("pg_token", pgToken);
		
		HttpEntity<MultiValueMap<String, String>> requestEntity = new HttpEntity<MultiValueMap<String,String>>(parameters, this.getHeaders());
		
		RestTemplate template = new RestTemplate();
		//결제 요청의 요청 주소(https://developers.kakao.com/docs/latest/ko/kakaopay/single-payment)
		String url = "https://kapi.kakao.com/v1/payment/approve";
		
		//메인(두번째 요청) - 카카오 페이에서 응답해준 json형태의 데이터를 ApproveResponse 객체로 변환하여 받기 위해
		ApproveResponse approveResponse = template.postForObject(url, requestEntity, ApproveResponse.class);
		
		return approveResponse;
	}
	
	//2) kakaopay request Headers정보 - 결제 준비 및 결제 요청에서 사용되는 공통 메소드
	private HttpHeaders getHeaders() {
		HttpHeaders headers = new HttpHeaders();
		headers.set("Authorization", "KakaoAK ");
		headers.set("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
		
		return headers;
	}
}
