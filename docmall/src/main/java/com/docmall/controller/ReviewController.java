package com.docmall.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.docmall.domain.MemberVO;
import com.docmall.domain.ReviewVO;
import com.docmall.dto.Criteria;
import com.docmall.dto.PageDTO;
import com.docmall.service.ReviewService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RestController //리턴값이 jsp페이지가 아니라 json형식의 데이터가 됨
@RequestMapping("/user/review/*")
@Log4j
public class ReviewController {

	@Setter(onMethod_ = {@Autowired})
	private ReviewService rService;
	
	//상품 후기 작성
	//consumes : 클라이언트에서 보내는 데이터 타입 지정
	//produces : 서버에서 클라이언트에게 보내는 데이터 타입
	//@RequestBody : json데이터를 ReviewVO vo 객체로 변환하는 작업
	@PostMapping(value = "/new", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> create(@RequestBody ReviewVO vo, HttpSession session) {
		
		log.info("상품 후기: " + vo);
		
		String m_userid = ((MemberVO) session.getAttribute("loginStatus")).getM_userid();
		vo.setM_userid(m_userid);
		
		ResponseEntity<String> entity = null;
		
		rService.create(vo);
		
		entity = new ResponseEntity<String>("success", HttpStatus.OK);
		
		return entity;
	}
	
	//상품 후기 수정 : rest API 개발
	@PatchMapping(value = "/modify", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> modify(@RequestBody ReviewVO vo, HttpSession session) {
		
		log.info("상품 후기: " + vo);
		
		String m_userid = ((MemberVO) session.getAttribute("loginStatus")).getM_userid();
		vo.setM_userid(m_userid);
		
		ResponseEntity<String> entity = null;
		
		rService.update(vo);
		
		entity = new ResponseEntity<String>("success", HttpStatus.OK);
		
		return entity;
	}
	
	//상품 후기 삭제
	/*
	 * @DeleteMapping(value = "/delete", consumes = "application/json", produces =
	 * {MediaType.TEXT_PLAIN_VALUE}) public ResponseEntity<String>
	 * delete(@RequestBody ReviewVO vo, HttpSession session) {
	 * 
	 * String m_userid = ((MemberVO)
	 * session.getAttribute("loginStatus")).getM_userid(); vo.setM_userid(m_userid);
	 * 
	 * ResponseEntity<String> entity = null;
	 * 
	 * rService.delete(vo);
	 * 
	 * entity = new ResponseEntity<String>("success", HttpStatus.OK);
	 * 
	 * return entity; }
	 */
	
	@DeleteMapping(value = "/delete/{r_num}", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> delete(@PathVariable("r_num") Integer r_num, HttpSession session) {
		
		
		ResponseEntity<String> entity = null;
		
		rService.deleteReview(r_num);
		
		entity = new ResponseEntity<String>("success", HttpStatus.OK);
		
		return entity;
	}
	
	//상품 후기 목록 : 목록데이터 + 페이징 정보 -> JSON포맷으로 클라이언트에게 2개 정보 다 보내야 함
	@GetMapping("/list/{p_num}/{page}")
	public ResponseEntity<Map<String, Object>> reviewList(@PathVariable("p_num") Integer p_num, @PathVariable("page") Integer page){
		
		ResponseEntity<Map<String, Object>> entity = null;
		Map<String, Object> map = new HashMap<String, Object>();
		
		//검색기능을 사용했다면 파라미터에 Criteria가 있어야 함!
		Criteria cri = new Criteria();
		cri.setPageNum(page);
		
		//1)댓글목록		
		List<ReviewVO> reviewList = rService.getReviewList(p_num, cri);		
		map.put("list", reviewList);
		
		//2)페이징 정보
		PageDTO pageDTO = new PageDTO(cri, rService.totalReview(p_num));
		map.put("pageMaker", pageDTO);
		
		entity = new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
		
		return entity;
	}
}
