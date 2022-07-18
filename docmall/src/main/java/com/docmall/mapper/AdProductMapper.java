package com.docmall.mapper;

import java.util.List;

import com.docmall.domain.CategoryVO;

public interface AdProductMapper {

	//1차 카테고리 정보
	List<CategoryVO> getCateList();
	
	//2차 카테고리 정보
	List<CategoryVO> getSubCateList(Integer categoryCode); //1차 카테고리 코드가 파라미터에 들어감
}
