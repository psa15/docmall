package com.docmall.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.docmall.service.UserProductService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

/*
 @ControllerAdvice
  - com.docmall.controller 패키지 안에 존재하는 컨트롤러에서 주소요청을 받으면
  	@ModelAttribute의 mainCategoryList()메소드가 자동으로 호출
  	-> 공통모델을 사용할 수 있음
 */

@Log4j
@ControllerAdvice(basePackages = {"com.docmall.controller"})
public class GlobalControllerAdvice {

	//카테고리 메뉴 데이터를 db에서 불러오는 작업 : Model 추가작업
	
	@Setter(onMethod_ = {@Autowired})
	private UserProductService userPService;
	
	//1차 카테고리를 Model 작업으로 가져오기
	@ModelAttribute
	public void mainCategoryList(Model model) {
		
		log.info("1차 카테고리 모델작업");
		model.addAttribute("mainCategoryList", userPService.getFirstCategoryList());
	}
	
}
