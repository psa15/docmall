package com.docmall.service;

import java.util.List;

import com.docmall.domain.CategoryVO;
import com.docmall.domain.ProductVO;
import com.docmall.dto.Criteria;

public interface UserProductService {

	//1차 카테고리
	List<CategoryVO> getFirstCategoryList();
	
	//2차 카테고리
	List<CategoryVO> getSecondCategoryList(Integer categoryCode);
	
	//2차 카테고리 별 상품목록
	List<ProductVO> getProductBySecondCategory(Integer s_ct_code, Criteria cri);
	
	//2차 카테고리 별 상품개수
	int totalProductCountBySecondCategory(Integer s_ct_code, Criteria cri);

	//상품 상세정보 - 상품의 상품코드에 맞는 정보 가져오기
	ProductVO getProductByNum(Integer p_num);
}
