package com.docmall.service;

import java.util.List;

import com.docmall.domain.ReviewVO;
import com.docmall.dto.Criteria;

public interface ReviewService {

	//리뷰 저장
	void create(ReviewVO vo);
	
	//리뷰 목록 + 페이징(검색은 X)
	List<ReviewVO> getReviewList(Integer p_num, Criteria cri);
	
	//전체 리뷰 개수
	int totalReview(Integer p_num);
}
