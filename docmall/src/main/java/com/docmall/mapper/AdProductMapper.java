package com.docmall.mapper;

import java.util.List;

import com.docmall.domain.CategoryVO;
import com.docmall.domain.ProductVO;
import com.docmall.dto.Criteria;

public interface AdProductMapper {

	//1차 카테고리 정보
	List<CategoryVO> getCateList();
	
	//2차 카테고리 정보
	List<CategoryVO> getSubCateList(Integer categoryCode); //1차 카테고리 코드가 파라미터에 들어감
	
	//파일 업로드 정보
	void productInsert(ProductVO vo);
	
	//상품목록
	List<ProductVO> getProductList(Criteria cri);
	
	//상품 목록 개수 : 페이징 구현 사용
	int getProductTotalCount(Criteria cri);
}
