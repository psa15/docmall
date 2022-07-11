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
	
	<h3>회원 가입</h3>
	
	<div class="container">
	  <div class=" mb-3 text-center">
	    <form id="joinForm" method="post" action="join">
		  <div class="form-group row">
		    <label for="m_userid" class="col-sm-2 col-form-label">아이디</label>
		    <div class="col-sm-5">
		      <input type="text" class="form-control" id="m_userid" name="m_userid" placeholder="아이디를 8 ~ 15이내로 입력하세요">
		    </div>
		    <div class="col-sm-3">
		      <button type="button" class="btn btn-link" id="btnIDCheck">아이디 중복체크</button>		      
		    </div>
		    <label class="col-form-label col-sm-2" style="display: none;" id="idCheckStatus">중복체크 결과</label>
		  </div>
		  <div class="form-group row">
		    <label for="m_passwd" class="col-sm-2 col-form-label">비밀번호</label>
		    <div class="col-sm-10">
		      <input type="password" class="form-control" id="m_passwd" name="m_passwd">
		    </div>
		  </div>
		  <div class="form-group row">
		    <label for="m_passwd2" class="col-sm-2 col-form-label">비밀번호 확인</label>
		    <div class="col-sm-10">
		      <input type="password" class="form-control" id="m_passwd2">
		    </div>
		  </div>
		  <div class="form-group row">
		    <label for="m_username" class="col-sm-2 col-form-label">이름</label>
		    <div class="col-sm-10">
		      <input type="text" class="form-control" id="m_username" name="m_username">
		    </div>
		  </div>
		  <div class="form-group row">
		    <label for="m_nickname" class="col-sm-2 col-form-label">닉네임</label>
		    <div class="col-sm-10">
		      <input type="text" class="form-control" id="m_nickname" name="m_nickname">
		    </div>
		  </div>
		  <div class="form-group row">
		    <label for="m_email" class="col-sm-2 col-form-label">이메일</label>
		    <div class="col-sm-10">
		      <input type="text" class="form-control" id="m_email" name="m_email">
		    </div>
		  </div>
		  <div class="form-group row">
		    <label for="m_authcode" class="col-sm-2 col-form-label">이메일 인증코드</label>
		    <div class="col-sm-10">
		      <input type="text" class="form-control" id="m_authcode" name="m_authcode">
		    </div>
		  </div>
		  <div class="form-group row">
		    <label for="m_tel" class="col-sm-2 col-form-label">휴대폰 번호</label>
		    <div class="col-sm-10">
		      <input type="text" class="form-control" id="m_tel" name="m_tel">
		    </div>
		  </div>
		  <div class="form-group row">
		    <label for="sample2_postcode" class="col-sm-2 col-form-label">우편번호</label>
		    <div class="col-sm-10">
		      <input type="text" class="form-control" id="sample2_postcode" name="m_postnum">
		      <input type="button" onclick="sample2_execDaumPostcode()" value="우편번호 찾기">
		    </div>
		  </div>
		  <div class="form-group row">
		    <label for="sample2_address" class="col-sm-2 col-form-label">주소</label>
		    <div class="col-sm-10">
		      <input type="text" class="form-control" id="sample2_address" name="m_addr">
		    </div>
		  </div>
		  <div class="form-group row">
		    <label for="sample2_detailAddress" class="col-sm-2 col-form-label">상세주소</label>
		    <div class="col-sm-10">
		      <input type="text" class="form-control" id="sample2_detailAddress" name="m_addr_d">
		      <input type="hidden" id="sample2_extraAddress" placeholder="참고항목">
		    </div>
		  </div>	
		  <div class="form-group row">
	      	<label class="form-check-label col-sm-2" for="m_email_accept">메일 수신 동의</label>
	      	<div class="col-sm-10 text-left">
		    	<input type="checkbox" class="form-check-input" id="m_email_accept" name="m_email_accept">
		    	<%-- value속성을 따로 적지 않고 수신동의에 체크하면 m_email_accept=on 이 값이 들어감
		    		 체크하지 않으면 null값이 들어감 --%>		
		    </div>	    		    
		  </div>
		  
	      <button type="button" class="btn btn-dark text-center" id="joinSend">회원가입</button>
	      		
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

			//아이디 중복체크를 했는지 확인하기 위한 전역변수
			let isIDCheck = false;

			//ID중복 체크
			$("#btnIDCheck").on("click", function(){

				//id입력 됐는지 확인
				if($("#m_userid").val() == "") { //아이디가 공백이면 == null이면
					
					alert("아이디를 입력하세요");

					$("#m_userid").focus(); //아이디 입력칸에 포커스 이동

					return;
				}

				$.ajax({
					url : '/member/idCheck',
					type: "get",
					dataType: 'text',
					data: { m_userid : $("#m_userid").val() },
					success: function(result) {

						console.log(result);
						
						//<label class="col-form-label col-sm-2" style="display: none;" id="idCheckStatus">중복체크 결과</label>
						$("#idCheckStatus").css({ 'display':'inline', 'color':'red' }); 
						//해당 태그 보이기 -> <label> 태그는 inline성격이어서 

						if(result =="yes"){	

							$("#idCheckStatus").html("<b>사용가능</b>");
							isIDCheck = true;
						} else {

							$("#idCheckStatus").html("<b>사용불가능</b>");
							isIDCheck = false;
						}
					}
				});
			});
		});
	</script>
    
    <%-- 우편번호 카카오 api --%>
    <!-- iOS에서는 position:fixed 버그가 있음, 적용하는 사이트에 맞게 position:absolute 등을 이용하여 top,left값 조정 필요 -->
	<div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
		<%-- display:none : 화면에 안보임 -> 우편번호 찾기 버튼 클릭하면 나타나는 창을 의미 --%>
		<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
		<%-- X 표 이미지 --%>
	</div>
	
	<%-- 다음 제공 우편번호 api js 파일 --%>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	
	<script>
	    // 우편번호 찾기 화면을 넣을 element
	    var element_layer = document.getElementById('layer'); 
	  	//<div id="layer">태그가 현재 실행코드보다 앞에 작성되어 있어야 한다
	    //document : html 안의 태그들을 참조할 때 쓰는 객체, 위의 div 태그를 참조
	
	    //x 클릭하면 창이 사라지는 함수
	    function closeDaumPostcode() {
	        // iframe을 넣은 element를 안보이게 한다.
	        
	        element_layer.style.display = 'none';
	        //태그참조변수.style.css속성명령어 = '값';
	    }
	
	    //우편번호 찾기 버튼 클릭시 동작하는 함수
	    function sample2_execDaumPostcode() {
	        new daum.Postcode({
	            oncomplete: function(data) {
	                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var addr = ''; // 주소 변수
	                var extraAddr = ''; // 참고항목 변수
	
	                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                    addr = data.roadAddress;
	                } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                    addr = data.jibunAddress;
	                }
	
	                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	                if(data.userSelectedType === 'R'){
	                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                        extraAddr += data.bname;
	                    }
	                    // 건물명이 있고, 공동주택일 경우 추가한다.
	                    if(data.buildingName !== '' && data.apartment === 'Y'){
	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }
	                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                    if(extraAddr !== ''){
	                        extraAddr = ' (' + extraAddr + ')';
	                    }
	                    // 조합된 참고항목을 해당 필드에 넣는다.
	                    document.getElementById("sample2_extraAddress").value = extraAddr;
	                
	                } else {
	                    document.getElementById("sample2_extraAddress").value = '';
	                }
	
	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                document.getElementById('sample2_postcode').value = data.zonecode;
	                document.getElementById("sample2_address").value = addr;
	                // 커서를 상세주소 필드로 이동한다.
	                document.getElementById("sample2_detailAddress").focus();
	
	                // iframe을 넣은 element를 안보이게 한다.
	                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
	                element_layer.style.display = 'none';
	            },
	            width : '100%',
	            height : '100%',
	            maxSuggestItems : 5
	        }).embed(element_layer);
	
	        // iframe을 넣은 element를 보이게 한다.
	        element_layer.style.display = 'block';
	
	        // iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
	        initLayerPosition();
	    }
	
	    // 브라우저의 크기 변경에 따라 레이어를 가운데로 이동시키고자 하실때에는
	    // resize이벤트나, orientationchange이벤트를 이용하여 값이 변경될때마다 아래 함수를 실행 시켜 주시거나,
	    // 직접 element_layer의 top,left값을 수정해 주시면 됩니다.
	    function initLayerPosition(){
	        var width = 300; //우편번호서비스가 들어갈 element의 width
	        var height = 400; //우편번호서비스가 들어갈 element의 height
	        var borderWidth = 5; //샘플에서 사용하는 border의 두께
	
	        // 위에서 선언한 값들을 실제 element에 넣는다.
	        element_layer.style.width = width + 'px';
	        element_layer.style.height = height + 'px';
	        element_layer.style.border = borderWidth + 'px solid';
	        // 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
	        element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
	        element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px';
	    }
	</script>
  </body>
</html>
