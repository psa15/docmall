<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!doctype html>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.88.1">
    <title> DocMall Shopping</title>
	
	<!-- 부트스트랩 css  cdn 버전 -> footer아래에 common.jsp로 참조
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">
    -->
    
	<meta name="theme-color" content="#563d7c">


    <style>
      .bd-placeholder-img {
        font-size: 1.125rem;
        text-anchor: middle;
        -webkit-user-select: none;
        -moz-user-select: none;
        -ms-user-select: none;
        user-select: none;
      }

      @media (min-width: 768px) {
        .bd-placeholder-img-lg {
          font-size: 3.5rem;
        }
      }
    </style>

   
    
  </head>
  <body>
    
	<!-- header -->
	<%@include file="/WEB-INF/views/include/header.jsp" %>
	
	<h3>		아이디 및 비밀번호 찾기</h3>
	
	<div class="container">
	  <div class=" mb-3 text-center">
	  	<div class="row">
	  		<!-- 아이디 찾기 -->
	  		<div class="col-6">
	  			<form id="loginForm" method="post" action="loginPost">
				  <div class="form-group row">
				    <label for="m_userid" class="col-sm-4 col-form-label">아이디</label>
				    <div class="col-sm-6">
				      <input type="text" class="form-control" id="m_userid" name="m_userid">
				    </div>
				   </div>		    
				  <div class="form-group row">
				    <label for="m_passwd" class="col-sm-4 col-form-label">비밀번호</label>
				    <div class="col-sm-6">
				      <input type="password" class="form-control" id="m_passwd" name="m_passwd">
				    </div>
				  </div>		  
				  <div class="form-group">
				    <div class="text-center">
						<button type="submit" class="btn btn-dark text-center" id="btnLogin">아이디 찾기</button>
				    </div>
				  </div>
				  <div class="form-group">
					<div class="text-center">
						<button type="button" class="btn btn-dark" id="btnSearchIDPW">로그인</button>
				    </div>
				  </div>
				</form>
	  		</div>
	  		<!-- 임시 비밀번호 발급 -->
	  		<div class="col-6">
	  			<form id="loginForm" method="post" action="loginPost">
				  <div class="form-group row">
				    <label for="m_userid" class="col-sm-4 col-form-label">아이디</label>
				    <div class="col-sm-6">
				      <input type="text" class="form-control" id="m_userid" name="m_userid">
				    </div>
				   </div>		    
				  <div class="form-group row">
				    <label for="m_passwd" class="col-sm-4 col-form-label">비밀번호</label>
				    <div class="col-sm-6">
				      <input type="password" class="form-control" id="m_passwd" name="m_passwd">
				    </div>
				  </div>		  
				  <div class="form-group">
				    <div class="text-center">
						<button type="submit" class="btn btn-dark text-center" id="btnLogin">임시 비밀번호 발급</button>
				    </div>
				  </div>
				  <div class="form-group">
					<div class="text-center">
						<button type="button" class="btn btn-dark" id="btnSearchIDPW">로그인</button>
				    </div>
				  </div>
				</form>
	  		</div>
		    
	   </div>		
	 </div>
	
	  <!-- footer -->
	  <%@include file="/WEB-INF/views/include/footer.jsp" %>
	</div>
	
	<!-- bootstrap 버전 및 여러 script 파일들 -->
	<%@include file="/WEB-INF/views/include/common.jsp" %>
    
    <%-- 클라이언트에서 접근이 가능해야 하기 때문에 resources에 따로 폴더를 만들었고, 
    	원래는 /resources/js/member/join.js 이렇게 경로를 작성해야하지만
    	resources를 숨기기 위해 servlet-context.xml에 설정을 추가한다 
	<script type="text/javascript" src="/js/member/join.js"></script> --%>
	
	<script>
		//html문서와 내용을 브라우저가 읽고 난 이후에 동작되는 특징
		$(document).ready(function(){
			
			//메일 인증코드 요청
			$("#btnAuthcode").on("click", function(){

				if($("#m_email").val() == "") {
					alert("메일 주소를 입력하세요")
					return; //진행되면 안되니까
				}

				$.ajax({
					url: '/email/send', //emailcontroller의 주소
					type: 'get',
					dataType: 'text',
					data: { receiveMail : $("#m_email").val() }, 
					/*
					url주소의 파라미터 
					 - EmailDTO dto = new EmailDTO(); : 스프링에서 자동 객체 생성
					 	- receiveMail 제외 전부 기본값 생성되어있음
					 	- $("#m_email") : form태그의 사용자가 입력한 이메일주소, 의 값(.val())
					*/
					success: function(result) {
						if(result == "success") {
							alert("메일이 발송되었으니 인증코드를 확인해주세요");
						} else {
							alert("메일 발송 실패되었으니 메일주소 확인 및 관리자에게 문의바랍니다");
						}
					}
				});
			});

			
			//상태변수 - 최종 회원가입 버튼 클릭시 다시 사용 예정
			let isAuthCode = false;

			//메일 인증 확인
			$("#btnConfirmAuthcode").on("click", function(){

				let authCode = $("#m_authcode").val();

				$.ajax ({
					url: '/member/confirmAuthCode',
					type: 'post',
					dataType: 'text',
					data: { uAuthCode : authCode }, //파라미터는 스프링의 메소드와 일치
					success: function(result) {
						if(result == "success") {
							alert("인증코드가 일치합니다.");
							isAuthCode = true;
						} else if(result == "fail") {
							alert("인증코드가 다릅니다. \n 메일인증요청을 다시해주세요");
							isAuthCode = false;
						}
					}
				});
			});
		});
	</script>
  
  </body>
</html>
