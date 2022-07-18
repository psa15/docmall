package com.docmall.service;

import java.util.List;

import com.docmall.domain.CategoryVO;

public interface AdProductService {

	//1차 카테고리 정보
	List<CategoryVO> getCateList();
	
	//2차 카테고리 정보
	List<CategoryVO> getSubCateList(Integer categoryCode);
}
