package com.docmall.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import net.coobird.thumbnailator.Thumbnailator;

/* ex05의 UploadController.java 파일에서 참조
1. 파일 업로드 작업
2. 업로드시 날짜 폴더생성해서 파일 관리
3. 썸네일 이미지 생성 - 업로드한 파일이 이미지 또는 일반파일인지 확인
4. byte[] 배열로 다운로드
 */
public class UploadFileUtils {

	//1. 파일 업로드 작업 - String 리턴값 : 업로드한 실제 파일명을 뽑기 위한 목적 -> db에 저장
	public static String uploadFile(String uploadFolder, String uploadDateFolderPath, MultipartFile uploadFile) {
		//파라미터에 업로드할 수 있는 입출력 스트림이나 MultipartFile 인터페이스 필요
		//MultipartFile uploadFile : 업로드된 파일 명(uploadFile)
		//String uploadFolder : 업로드 될 폴더(서버츠측에 저장할 폴더)
		
		String uploadFileName = ""; //실제 업로드한 파일명
		
		//1)업로드 날짜폴더 생성
		//String uploadDateFolderPath = getFolder(); //2022\07\19
		File uploadPath = new File(uploadFolder, uploadDateFolderPath); //C:\\Dev\\upload\\2022\\07\\19
		//File 클래스 : File - file + folder
		
		//날짜 폴더가 존재하지 않으면 폴더들 모두 생성
		if(uploadPath.exists() == false) {			
			uploadPath.mkdirs();
		}
		
		//클라이언트에서 업로드한 파일 이름
		String uploadClientFileName = uploadFile.getOriginalFilename();
		
		//중복되지 않는 고유의 문자열 생성
		UUID uuid = UUID.randomUUID();		
		//서버에 업로드할 때 중복되지 않는 파일이름을 생성 -> 리턴시켜 db에 저장
		uploadFileName = uuid.toString() + "_" + uploadClientFileName;
		
		try {
			//실제 중복되지 않는, 유일한 파일이름으로 객체 생성
			File saveFile = new File(uploadPath, uploadFileName);			
			//파일 업로드(파일 복사됨) : transferTo(File file); - File 객체 필요해서 바로 위의 코드 작성
			uploadFile.transferTo(saveFile);
			
			//3. 썸네일 이미지 생성
			//pom.xml에 라이브러리 추가, bean 설정 X, 다이렉트로 사용 가능
			if(checkImageType(saveFile)) {
				//썸네일 작업
				FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_" + uploadFileName));
				
				Thumbnailator.createThumbnail(uploadFile.getInputStream(), thumbnail, 100, 100);
				thumbnail.close();				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return uploadFileName; //실제 업로드한 파일 명
	}
	
	//2. 업로드시 날짜 폴더생성하여 파일 관리 - ex05 uploadController에서 가져옴
	public static String getFolder() {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		//현재 시스템의 날짜
		Date date = new Date();
		
		String str = sdf.format(date); //"2022-07-19" 저장됨
		
		//File.separator : 응용체제에 따라 다른 파일경로 구분자를 반환하여 -를 구분자로 대체 -> 운영체제에 영향받지 않고 동작하게
		//윈도우(\) : c:\temp\...  리눅스(/) /home/etc/..
		return str.replace("-", File.separator); // "2022-07-19" -> "2022\07\19"
	}
		
	//이미지 파일여부를 체크
	private static boolean checkImageType(File saveFile) {
		
		boolean isImage = false;
		
		try {
			String contentType = Files.probeContentType(saveFile.toPath());
			//contentType : 현재 업로드 된 파일의 정보가 들어감 ( text/html, text/plain, image 등)
			
			isImage = contentType.startsWith("image");
			//contentType.startsWith("image") : image로 시작하면 true 반환
			
		} catch (IOException e) {
			e.printStackTrace();
		}
				
		return isImage; 
	}
	
	//이미지를 바이트배열로 읽어오는 작업
	public static ResponseEntity<byte[]> getFile(String uploadPath, String fileName) {
		//String uploadPath : 주입된 bean

		File file = new File(uploadPath, fileName);
		
		//이미지가 존재하지 ㅇ낳을 경우
		if(!file.exists()) {
			uploadPath = "C:\\Dev\\upload\\tmp\\";
			fileName = "s_no_image.png";
			
			file = new File(uploadPath, fileName);
		}
		
		ResponseEntity<byte[]> entity = null;		
		
		//헤더작업 : 서버에서 이미지 정보를 바이트 배열로 읽어와서 이 정보를 브라우저에 전달할 때 브라우저에게 이미지 파일이라고 알려주기 위해
		HttpHeaders headers = new HttpHeaders();
		
		try {
			//브라우저에게 보낼 데이터의 MIME정보(image/png, image/jpeg, image/gif 등)가 패킷의 헤더부분에 추가
			headers.add("Content-Type", Files.probeContentType(file.toPath()));			
			entity = new ResponseEntity<byte[]>(FileCopyUtils.copyToByteArray(file), headers, HttpStatus.OK);
			//FileCopyUtils.copyToByteArray(file) : 파일 정보를 byte배열로 가져옴
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return entity;
	}
	
	//파일 삭제 
	public static void deleteFile( String uploadPath, String fileName) {
		
		//원본 이미지 + 썸네일 이미지 삭제
		/*
		 uploadPath : C:\\Dev\\upload
		 fileName : 2022/07/21/s_~~~~~~~~~.jpg
		 */
		
		String front = fileName.substring(0, 11); //날짜 폴더 2022/07/21
		String end = fileName.substring(13); //s_를 뺀 파일명 ~~~~~~~~~.jpg
		String origin = front + end; //원본 이미지 파일
		
		//윈도우 운영체제 경로구분자 : /를 \로 변경하기
		//File.separator : 각 운영체제에 맞게 변경
		new File(uploadPath + origin.replace("/", File.separator)).delete(); //원본 이미지 삭제
		new File(uploadPath + fileName.replace("/", File.separator)).delete(); //썸네일 이미지 삭제
	}
}
