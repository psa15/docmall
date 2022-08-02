package com.docmall.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.docmall.domain.ReviewVO;
import com.docmall.dto.Criteria;

public interface ReviewMapper {

	//리뷰 저장
	void create(ReviewVO vo);
	
	//리뷰 목록 + 페이징(검색은 X)
	List<ReviewVO> getReviewList(@Param("p_num") Integer p_num, @Param("cri") Criteria cri);
	
	//전체 리뷰 개수
	int totalReview(Integer p_num);
	
	//리뷰 수정
	void update(ReviewVO vo);
	
	//리뷰 삭제
	void delete(ReviewVO vo);
	
	//리뷰 삭제2
	void deleteReview(Integer r_num);

}
