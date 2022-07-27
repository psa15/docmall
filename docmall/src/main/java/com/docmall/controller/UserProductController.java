package com.docmall.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.docmall.domain.CategoryVO;
import com.docmall.domain.ProductVO;
import com.docmall.dto.Criteria;
import com.docmall.dto.PageDTO;
import com.docmall.service.UserProductService;
import com.docmall.util.UploadFileUtils;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

//사용자 기능 - 주문하기

@RequestMapping("/user/product/*")
@Controller
@Log4j
public class UserProductController {
	
	@Resource(name = "uploadPath") 
	private String uploadPath; //변수명이 같을 필요는 없음

	@Setter(onMethod_ = {@Autowired})
	private UserProductService userPService;
	
	//1차 카테고리 정보 불러오는 작업 생략 
	//-> GlobalControllerAdvice 클래스가 (@ControllerAdvice적용) 카테고리 Model 작업을 함
	
	//2차 카테고리 정보-ajax
	@GetMapping("/subCategoryList/{ct_code}")
	@ResponseBody
	public ResponseEntity<List<CategoryVO>> subCategoryList(@PathVariable("ct_code") Integer ct_code){
		
		ResponseEntity<List<CategoryVO>> entity = null;
		
		entity = new ResponseEntity<List<CategoryVO>>(userPService.getSecondCategoryList(ct_code), HttpStatus.OK);
		
		return entity;
	}
	
	//상품 목록 + 페이징 (restapi)
	@GetMapping("/userProductList/{ct_code}/{ct_name}")
	public String userProductList(@PathVariable("ct_code") Integer ct_code, @ModelAttribute("cri") Criteria cri, Model model, @PathVariable("ct_name") String ct_name) {
		
		log.info("2차 카테고리 코드: " + ct_code);
		
		//한 페이지에 9개의 상품이 출력되게
		//cri.setAmount(9);
		
		List<ProductVO> productList = userPService.getProductBySecondCategory(ct_code, cri);
		
		//윈도우 운영체제의 경로 구분자는 \를 사용
		//날짜폴더명의 \를 /로 변환하는 작업. \가 클라이언트에서 서버로 보내지는 데이터로 사용이 안됨
		for(int i=0; i<productList.size();i++) {
			String p_image_folder = productList.get(i).getP_image_dateFolder().replace("\\", "/");
			productList.get(i).setP_image_dateFolder(p_image_folder);
		}
	
		//페이징 쿼리에 의한 상품 목록
		model.addAttribute("productList", productList);
		
		log.info(productList);
		
		//페이징
		int totalCount = userPService.totalProductCountBySecondCategory(ct_code, cri);
		model.addAttribute("pageMaker", new PageDTO(cri, totalCount));
		
		return "/user/product/userProductList";
	}
	//상품 목록에서 이미지 보여주기
	@ResponseBody
	@GetMapping("/displayFile")
	public ResponseEntity<byte[]> displayFile(String folderName, String fileName){
		//String fileName : jsp 페이지에 뿌려진 날짜 폴더와 이미지 이름이 합쳐져서 들어올 예정
		
		log.info("폴더이름: " + folderName);
		log.info("파일이름: " + fileName);
		
		//이미지를 byte[]로 읽어오는 작업 - UploadFileUtils		
		return UploadFileUtils.getFile(uploadPath, folderName + "\\" + fileName);
	}
	
	//모달 대화상자에서 사용할 상품 상세정보(바로구매 + 장바구니 가능한 모달)
	@ResponseBody
	@GetMapping("/productDetail/{p_num}")
	public ResponseEntity<ProductVO> productDetail(@PathVariable("p_num") Integer p_num) {
		
		ResponseEntity<ProductVO> entity = null;		
		
		ProductVO vo = userPService.getProductByNum(p_num);
		vo.setP_image_dateFolder(vo.getP_image_dateFolder().replace("\\", "/"));
		
		entity = new ResponseEntity<ProductVO>(vo, HttpStatus.OK);
		
		return entity;
	}
	
	//상품 상세
	
	//장바구니
	
	//주문하기
}
