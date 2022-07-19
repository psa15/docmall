package com.docmall.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.docmall.domain.CategoryVO;
import com.docmall.domain.ProductVO;
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

}
