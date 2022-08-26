package com.docmall.mapper;

import java.util.List;

import com.docmall.domain.ChartVO;

public interface ChartMapper {

	//1차 카테고리 별 주문
	List<ChartVO> primaryChart();
}
