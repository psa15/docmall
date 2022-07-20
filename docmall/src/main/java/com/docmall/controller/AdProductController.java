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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.docmall.domain.CategoryVO;
import com.docmall.domain.ProductVO;
import com.docmall.dto.Criteria;
import com.docmall.dto.PageDTO;
import com.docmall.service.AdProductService;
import com.docmall.util.UploadFileUtils;

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
	
	//CKEditor 웹에디터를 통한 이미지 업로드 작업(상세설명에서 사용하는 설명이미지파일)
	@PostMapping("/imageUpload")  // CKEditor: 업로드 <input type="file" name="upload">
	public void imageUpload(HttpServletRequest req, HttpServletResponse res, MultipartFile upload) {
		/*
		 HttpServletRequest req, HttpServletResponse res
		 - Request : 클라이언트가 서버에 접속하는 작업형태
		 - Response : 서버에서 클라이언트에게 결과를 보낼 때 담당
		 */
		
		//입출력 스트림 방식으로 파일 업로드
		
		OutputStream out = null;
		PrintWriter printWriter = null; //개체의 형식화된 표현을 텍스트 출력 스트림에 출력하는 기능을 제공
		//response 객체에서 받아옴 - 아래 printWriter = res.getWriter(); 코드
		
		//클라이언의 브라우저에게 보내는 정보.
		res.setCharacterEncoding("utf-8");
		res.setContentType("text/html; charset=utf-8");
		
		try {
			String fileName = upload.getOriginalFilename(); // 클라이언트에서 업로드한 원본파일명.
			byte[] bytes = upload.getBytes(); // 업로드 파일
			
			//서버측의 업로드폴더경로 작업. 1)프로젝트 내부  2)외부
			//1)프로젝트 내부 : 톰캣이 war 파일로 리눅스서버에 배포를 할 경우, 톰캣이 재시작하면, 기존 upload폴더를 삭제해버린다. 
			// 톰캣이 실제관리하는 물리적인 경로		
			String uploadTomcatTempPath = req.getSession().getServletContext().getRealPath("/") + "resources\\upload\\";
			log.info("톰캣 물리적 경로: " + uploadTomcatTempPath);
			
			//2)외부폴더(프로젝트 관리하는 폴더가 아님)
			//작업시 톰캣의 server.xml의 <Context docBase="C:\\Dev\\upload\\ckeditor" path="/upload/" reloadable="true"/>설정 할것.
			String uploadPath = "C:\\Dev\\upload\\ckeditor\\";
			//server.xml의 새로 추가한 경로를 참조해야 하기 때문에 docBase속성의 값과 같아야 함
			
			log.info("외부 물리적 경로: " + uploadPath);
			
			uploadPath = uploadPath + fileName;
			
			log.info("외부 물리적 경로 파일 이름: " + uploadPath);
			
			out = new FileOutputStream(new File(uploadPath)); // 파일입출력스트림 객체생성(실제폴더에 파일생성됨). 0byte
			//위까지는 빈 파일
			
			out.write(bytes); // 출력스트림에 업로드된 파일을 가리키는 바이트배열을 쓴다.  업로드된 파일크기.
			//빈 파일에 내용을 붓는 작업
			
			// CKEditor에게 보낼 파일정보작업 - CKEditor에서 피요로 하는 코드	
			printWriter = res.getWriter();
			
			//클라이언트에서 요청할 이미지 주소정보
			String fileUrl = "/upload/" + fileName;
			//"/upload/" : server.xml의 path속성의 매핑주소
			
			log.info("클라이언트에서 요청할 이미지 주소 정보: " + fileUrl);
			
			// {"filename":"abc.gif", "uploaded":1, "url":"/upload/abc.gif"} CKEditor 4.x version에서 요구하는 json포맷
			printWriter.println("{\"filename\":\"" + fileName + "\", \"uploaded\":1,\"url\":\"" + fileUrl + "\"}");
			printWriter.flush(); // 전송 (return과 같은 역할: 클라이언트로 보냄)
			
		
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(out != null) {
				try {
					out.close();
				}catch(IOException e) {
					e.printStackTrace();
				}
			}
			if(printWriter != null) {
				printWriter.close();
			}
		}
		
	}
	
	//상품 저장
	@PostMapping("/productInsert")
	public String productInsert(ProductVO vo, RedirectAttributes rttr) {
		
		log.info("상품 등록 정보: " + vo);
		
		//파일 업로드 작업
//		vo.getP_image(); //현재 null 상태(상품 이미지의 input태그에 name 값을 변경함) 
		//이미지 파일명이 저장될 p_image필드에 업로드한 후 실제 파일명을 저장
		String uploadDateFolderPath = UploadFileUtils.getFolder();
		vo.setP_image_dateFolder(uploadDateFolderPath);//날짜 폴더명
		vo.setP_image(UploadFileUtils.uploadFile(uploadPath, uploadDateFolderPath, vo.getUploadFile()));//-> 실제 이미지 명 할당
		//uploadFolder : 에러남 -> @Resource로 주입한 bean객체 이름을 작성
		
		//상품 정보 저장
		adPService.productInsert(vo);
		
		return "redirect:/admin/product/productList";
	}
	
	//상품목록 - 페이징 + 검색
	@GetMapping("/productList")
	public void productList(@ModelAttribute("cri") Criteria cri, Model model) {
		//자동으로 cri 객체가 생성이 되는데 pageNum과 amount 에 각각 1과 10이 들어간 생성자가 호출
		//Model model 상품 목록을 db에서 가져와 jsp에 제공해야 함
		
		log.info("검색 및 페이징 정보: " + cri);
		
		List<ProductVO> productList = adPService.getProductList(cri);
		
		//날짜폴더명의 \를 /로 변환하는 작업. \가 클라이언트에서 서버로 보내지는 데이터로 사용이 안됨
		for(int i=0; i<productList.size();i++) {
			String p_image_folder = productList.get(i).getP_image_dateFolder().replace("\\", "/");
			productList.get(i).setP_image_dateFolder(p_image_folder);
		}
		log.info(productList.get(0).getP_image_dateFolder());
	
		//페이징 쿼리에 의한 상품 목록
		model.addAttribute("productList", productList);
		
		//페이징
		int totalCount = adPService.getProductTotalCount(cri);
		model.addAttribute("pageMaker", new PageDTO(cri, totalCount));
	}
	
	//상품 목록에서 이미지 보여주기
	@ResponseBody
	@GetMapping("/displayFile")
	public ResponseEntity<byte[]> displayFile(String folderName, String fileName){
		//String fileName : jsp 페이지에 뿌려진 날짜 폴더와 이미지 이름이 합쳐져서 들어올 예정
		
		log.info("폴더이름: " + folderName);
		log.info("파일이름: " + fileName);
		
		//이미지를 byte[]로 읽어오는 작업 - UploadFileUtils		
		return UploadFileUtils.getFile(uploadPath, folderName + "\\s_" + fileName);
	}
}
