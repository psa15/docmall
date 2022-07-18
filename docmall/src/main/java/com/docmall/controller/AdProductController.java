package com.docmall.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.docmall.domain.CategoryVO;
import com.docmall.service.AdProductService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

//관리자가 상품관리할 수 있는 기능 제공
@Controller
@Log4j
@RequestMapping("/admin/product/*")
public class AdProductController {

	//@Resource : 자원들에 대한 bean을 주입할 때 사용
	//Bean 중에 uploadPath bean 객체를 찾아 아래 변수에 주입
	@Resource(name = "uploadPath") 
	private String uploadPath; //변수명이 같을 필요는 없음
	
	@Setter(onMethod_ = {@Autowired})
	private AdProductService adPService;
	
	//상품등록 폼(+1차 카테고리 정보 불러오기)
	@GetMapping("/productInsert")
	public void productInsert(Model model) {
		model.addAttribute("firstCateList", adPService.getCateList());
	}
	//2차 카테고리 정보 불러오기-rest api
	@ResponseBody
	@GetMapping("/subCategoryList/{cateCode}") //subCategoryList/1차카테고리코드 ex)subCategoryList/1
	public ResponseEntity<List<CategoryVO>> subCategoryList(@PathVariable("cateCode") Integer categoryCode) {
		
		ResponseEntity<List<CategoryVO>> entity = null;
		
		entity = new ResponseEntity<List<CategoryVO>>(adPService.getSubCateList(categoryCode), HttpStatus.OK);
		
		return entity;
	}
	
	//ckeditor 웹에디터를 통한 이미지 업로드 작업 (상세설명에 사용하는 설명 이미지파일)
	@PostMapping("/imageUpload")
	public void imageUpload(HttpServletRequest req, HttpServletResponse res, MultipartFile upload) {
		//MultipartFile upload - CKEditor : 업로드<input type="file" name="upload"> 로 name을 일치시킨 것
		//업로드 되는 파일 정보가 넘어온
		
		OutputStream out = null;
		PrintWriter printWriter = null;
		
		//클라이언트의 브라우저에게 보내는 정보
		res.setCharacterEncoding("utf-8");
		res.setContentType("text/html; charset=utf-8");
		
		try {
			String fileName = upload.getOriginalFilename(); //클라이언트에서 업로드한 원본의 파일 명
			byte[] bytes = upload.getBytes(); //업로드 파일
			
			//서버측의 업로드 폴더경로 작업, 1) 프로젝트 내부 or 2)외부
			//1) 프로젝트 내부 :포리젝트 내부 : 톰캣이 war 파일로 리눅스 서버에 배포를 할 경우, 톰캣을 재 시작하며 기존 upload 폴더를 삭지
				
			//String uploadPath = req.getSession().getServletContext().getRealPath("/") + "resources\\upload\\"; 
			//내부 폴더 경로 - 톰캣이 실제 관리하는 물리적인 경로 (resources의 upload는 중간 가상경로)
			
			//2)외부 폴더
			String uploadPath ="C:\\Dev\\upload\\ckeditor\\";
			log.info("외부 물리적 경로: " + uploadPath);
			
			uploadPath = uploadPath + fileName;
			
			out = new FileOutputStream(new File(uploadPath)); //파일 입출력 스트림 객체 생성(폴더에 파일명 소개 - 0byte)
			
			out.write(bytes); //출력스트림의 업로드된 파일을 가리키는 바이트 배열을 쓴다 - 업로드한 파일 크기
			
			//ckeditor 에게 보낼 파일 정보 작업
			printWriter = res.getWriter();
			
			//클라이언에서 요청할 이미ㅣㅈ 주소 정보
			String fileUrl = "/upload/" + fileName;
			
			// {"filename":"abc.gif", "uploaded":1, "url":"/upload/abc.gif"} CKEditor 4.x  version에서 요구하는  json포맷
			printWriter.println("{\"filename\":\"" + fileName + "\", \"uploaded\":1,\"url\":\"" + fileUrl + "\"}");
			printWriter.flush(); // 전송 (return과 같은 역할: 클라이언트로 보냄)

			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(out != null) {
				try {
					out.close();
				} catch(IOException e) {
					e.printStackTrace();
				}
			}
			if(printWriter != null) {
				printWriter.close();
			}
		}
		
	}
	
	
	//상품 저장
}
