package com.docmall.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import org.springframework.web.multipart.MultipartFile;

import net.coobird.thumbnailator.Thumbnailator;

/* ex05의 UploadController.java 파일에서 참조
1. 파일 업로드 작업
2. 업로드시 날짜 폴더생성해서 파일 관리
3. 썸네일 이미지 생성
4. byte[] 배열로 다운로드
 */
public class UploadFileUtils {

	//1. 파일 업로드 작업 - String 리턴값 : 업로드한 실제 파일명을 뽑기 위한 목적 -> db에 저장
	public static String uploadFile(String uploadFolder, String uploadDateFolderPath, MultipartFile uploadFile) {
		//파라미터에 업로드할 수 있는 입출력 스트림이나 MultipartFile 인터페이스 필요
		//MultipartFile uploadFile : 업로드된 파일 명(uploadFile)
		//String uploadFolder : 업로드 될 폴더(서버의 폴더)
		
		String uploadFileName = ""; //실제 업로드한 파일명
		
		//1)업로드 날짜폴더 생성
		//String uploadDateFolderPath = getFolder(); //2022\07\19
		File uploadPath = new File(uploadFolder, uploadDateFolderPath); //C:\\Dev\\upload\\2022\\07\\19
		
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
			//파일 업로드(파일 복사됨)
			uploadFile.transferTo(saveFile);
			
			//3. 썸네일 이미지 생성
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
	
	//2. 업로드시 날짜 폴더생성해서 파일 관리 - ex05 uploadController에서 가져옴
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
}
