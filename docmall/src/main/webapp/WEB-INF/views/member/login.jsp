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

   	<script>
   		let msg = "${msg}";
   		
   		if(msg == "wrongId") {
   			alert("아이디를 확인하세요.");
   		}else if (msg == "wrongPassword") {
   			//else만 적어도 되는데 정확히 어떤 경우인지 확인하기 위해 else if 사용
   			
   			alert("비밀번호를 확인하세요.");
   		}
   	</script>
    
  </head>
  <body>
    
	<!-- header -->
	<%@include file="/WEB-INF/views/include/header.jsp" %>
	
	<h3>로그인</h3>
	
	<div class="container">
	  <div class=" mb-3 text-center">
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
		  
	      <button type="submit" class="btn btn-dark text-center" id="btnLogin">로그인</button>
	      		
		</form>
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
		/* 로그인 */
		//html문서와 내용을 브라우저가 읽고 난 이후에 동작되는 특징
		//<button type="submit" id="btnLogin"> 클릭하면 전송이벤트가 동작,
		//<form> 태그의 이벤트 설정
		$(document).ready(function(){

			let loginForm = $("#loginForm");

			//로그인 정보 전송 톰캣		<button type="submit" id="btnLogin">	
			$("#btnLogin").on("click", function(){
				console.log("login");

				//유효성 검사
				if($("#m_userid").val() == "") {
					alert("아이디를 입력하세요");
					$("#m_userid").focus();
					return false; 
				}
				if($("#m_passwd").val() == "") {
					alert("비밀번호를 입력하세요");
					$("#m_passwd").focus();
					return false; 
				}

				return true; // 전송 X 

			});

			
		});
	</script>
    
  </body>
</html>
