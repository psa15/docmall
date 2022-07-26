package com.docmall.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.docmall.domain.CategoryVO;
import com.docmall.domain.ProductVO;
import com.docmall.dto.Criteria;
import com.docmall.mapper.UserProductMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class UserProductServiceImpl implements UserProductService {
	
	@Setter(onMethod_ = {@Autowired})
	private UserProductMapper userPMapper;
	
	//1차 카테고리
	@Override	
	public List<CategoryVO> getFirstCategoryList() {
		return userPMapper.getFirstCategoryList();
	}

	//2차 카테고리
	@Override
	public List<CategoryVO> getSecondCategoryList(Integer categoryCode) {
		return userPMapper.getSecondCategoryList(categoryCode);
	}

	//2차 카테고리 별 상품목록
	@Override
	public List<ProductVO> getProductBySecondCategory(Integer s_ct_code, Criteria cri) {
		return userPMapper.getProductBySecondCategory(s_ct_code, cri);
	}

	//2차 카테고리 별 상품개수
	@Override
	public int totalProductCountBySecondCategory(Integer s_ct_code, Criteria cri) {
		return userPMapper.totalProductCountBySecondCategory(s_ct_code, cri);
	}

	//상품상세보기
	@Override
	public ProductVO getProductByNum(Integer p_num) {
		return userPMapper.getProductByNum(p_num);
	}

}
