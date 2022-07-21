package com.docmall.service;

import java.util.List;

import com.docmall.domain.CategoryVO;
import com.docmall.domain.ProductVO;
import com.docmall.dto.Criteria;

public interface AdProductService {

	//1차 카테고리 정보
	List<CategoryVO> getCateList();
	
	//2차 카테고리 정보
	List<CategoryVO> getSubCateList(Integer categoryCode);
	
	//파일 업로드 정보
	void productInsert(ProductVO vo);
	
	//상품목록
	List<ProductVO> getProductList(Criteria cri);
	
	//상품 목록 개수 : 페이징 구현 사용
	int getProductTotalCount(Criteria cri);
	
	//상품 수정 시 선택된 상품의 상품코드에 맞는 정보 가져오기
	ProductVO getProductByNum(Integer p_num);
	
	//상품 수정
	void productModify(ProductVO vo);
}
