package com.docmall.service;

import java.util.List;

import com.docmall.domain.CategoryVO;
import com.docmall.domain.ProductVO;

public interface AdProductService {

	//1차 카테고리 정보
	List<CategoryVO> getCateList();
	
	//2차 카테고리 정보
	List<CategoryVO> getSubCateList(Integer categoryCode);
	
	//파일 업로드 정보
	void productInsert(ProductVO vo);
}
