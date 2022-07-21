package com.docmall.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.docmall.domain.CategoryVO;
import com.docmall.domain.ProductVO;
import com.docmall.dto.Criteria;
import com.docmall.mapper.AdProductMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class AdProductServiceImpl implements AdProductService {
	
	@Setter(onMethod_ = {@Autowired})
	private AdProductMapper adPMapper;
	
	//1차 카테고리 정보
	@Override
	public List<CategoryVO> getCateList() {
		return adPMapper.getCateList();
	}

	//2차 카테고리 정보
	@Override
	public List<CategoryVO> getSubCateList(Integer categoryCode) {
		return adPMapper.getSubCateList(categoryCode);
	}

	//파일 업로드 정보
	@Override
	public void productInsert(ProductVO vo) {
		adPMapper.productInsert(vo);
	}

	//상품목록
	@Override
	public List<ProductVO> getProductList(Criteria cri) {
		return adPMapper.getProductList(cri);
	}

	//상품 목록 개수 : 페이징 구현 사용
	@Override
	public int getProductTotalCount(Criteria cri) {
		return adPMapper.getProductTotalCount(cri);
	}

	//상품 수정 시 선택된 상품의 상품코드에 맞는 정보 가져오기
	@Override
	public ProductVO getProductByNum(Integer p_num) {
		return adPMapper.getProductByNum(p_num);
	}
	
	//상품 수정
	@Override
	public void productModify(ProductVO vo) {
		adPMapper.productModify(vo);
	}

}
