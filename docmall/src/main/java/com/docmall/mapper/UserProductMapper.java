package com.docmall.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.docmall.domain.CategoryVO;
import com.docmall.domain.ProductVO;
import com.docmall.dto.Criteria;

public interface UserProductMapper {

	//1차 카테고리
	List<CategoryVO> getFirstCategoryList();
	
	//2차 카테고리
	List<CategoryVO> getSecondCategoryList(Integer categoryCode);
	
	//2차 카테고리 별 상품목록
	List<ProductVO> getProductBySecondCategory(@Param("s_ct_code") Integer s_ct_code, @Param("cri") Criteria cri);
	
	//2차 카테고리 별 상품개수
	int totalProductCountBySecondCategory(@Param("s_ct_code") Integer s_ct_code, @Param("cri") Criteria cri);
	
	//상품 상세정보 - 상품의 상품코드에 맞는 정보 가져오기
	ProductVO getProductByNum(Integer p_num);
}
