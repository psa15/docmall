/* 회원가입 */

//html문서와 내용을 브라우저가 읽고 난 이후에 동작되는 특징
$(document).ready(function(){

	let joinForm = $("#joinForm");

	//회원가입 저장하기 - type이 button일때만 폼참조해서 submit메소드 사용 가능
	$("#joinSend").on("click", function(){
		//console.log("회원가입하기"); 확인 완

		//유효성검사

		//제출
		joinForm.submit();
	});

	//ID중복 체크
	$("#btnIDCheck").on("click", function(){

		//id입력 됐는지 확인
		if($("#m_userid").val() == "") { //아이디가 공백이면 == null이면
			
			alert("아이디를 입력하세요");

			$("#m_userid").focus(); //아이디 입력칸에 포커스 이동

			return;
		}

		
	});
});