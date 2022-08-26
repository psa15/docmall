package com.docmall.service;

import java.util.List;

import com.docmall.domain.ChartVO;

public interface ChartService {

	//1차 카테고리 별 주문
	List<ChartVO> primaryChart();
}
