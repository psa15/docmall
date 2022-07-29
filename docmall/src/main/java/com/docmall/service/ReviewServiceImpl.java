package com.docmall.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.docmall.domain.ReviewVO;
import com.docmall.dto.Criteria;
import com.docmall.mapper.ReviewMapper;

import lombok.Setter;

@Service
public class ReviewServiceImpl implements ReviewService {

	@Setter(onMethod_ = {@Autowired})
	private ReviewMapper rMapper;

	//리뷰 저장
	@Override
	public void create(ReviewVO vo) {
		rMapper.create(vo);
	}

	//리뷰 목록 + 페이징(검색은 X)
	@Override
	public List<ReviewVO> getReviewList(Integer p_num, Criteria cri) {
		return rMapper.getReviewList(p_num, cri);
	}

	//전체 리뷰 개수
	@Override
	public int totalReview(Integer p_num) {
		return rMapper.totalReview(p_num);
	}

}
