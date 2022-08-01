<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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

	<!-- bootstrap 버전 및 여러 파일들 -->
	<%@include file="/WEB-INF/views/include/common.jsp" %>

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

	  /*상품 후기 별 평점*/	
	  /*별점 기본 스타일*/  
	  #star_r_score a.r_score {
		font-size: 22px;
		text-decoration: none;
		color: lightgray;
	  }
	  /*별점 클릭 시 jquery의 addClass(), removeClass()메소드를 이용하여 사용하여 색 변경
	  .on을 클래스로! */
	  #star_r_score a.r_score.on {
		color: black;
	  }
    </style>
    
	<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
	<!-- <link rel="stylesheet" href="/resources/demos/style.css"> -->
	<!-- <script src="https://code.jquery.com/jquery-3.6.0.js"></script> -->
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>

  <script>
	if('${msg}' == 'logout') {
		alert("로그아웃 되었습니다.");
	}
  </script>
    
	
  <%-- 핸들바 템플릿 --%>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
  
  <script id="reviewTemplate" type="text/x-handlebars-template">
	
	{{#each .}}
	<div class="list-group">
		<div class="d-flex w-100 justify-content-between">
			<h6 class="mb-1">{{idDisplay m_userid}}</h6>
			<small>평점 : {{displayStar r_score}}</small>
		</div>
		<p class="mb-1">{{r_content}}</p>
		<small>{{prettifyDate r_regdate}}</small>
	</div>
	<hr>
	{{/each}}

  </script>
	
  </head>
  <body>
  
    <!-- header -->
	<%@include file="/WEB-INF/views/include/header.jsp" %>
	<!-- 카테고리 -->
	<%@include file="/WEB-INF/views/include/categoryMenu.jsp" %>   

	
	<div class="pricing-header px-3 py-3 pt-md-5 pb-md-4 mx-auto text-center">
	  <h1 class="display-4">${ct_name}</h1>
	  <p class="lead">Quickly build an effective pricing table for your potential customers with this Bootstrap example. It’s built with default Bootstrap components and utilities with little customization.</p>
	</div>
	
	<div class="container">
      <div class="row">          
       	<div class = "col-6">
  			<!-- 상품 이미지 -->
      		<img src="/user/product/displayFile?folderName=${productVO.p_image_dateFolder}&fileName=${productVO.p_image}" 
					alt="" class="bd-placeholder-img card-img-top" width="100%" height="225" onerror="this.onerror=null; this.src='/image/no_image.png'">
      	</div>
      	<div class = "col-6">
      		<!-- 상품 이미지 필드 정보 -->
      		<h5>${productVO.p_name}</h5>
      		<p>판매가격: <fmt:formatNumber type="number" maxFractionDigits="3" value="${productVO.p_cost}" /></p>
      		<p>
      			<input type="hidden" id="p_num" value="${productVO.p_num}">
      			수량: <input type="number" id="p_amount" min="1" value="1">
      		</p>
      		<button type="button" id="btnOrder"  class="btn btn-primary">구매하기</button>
			<button type="button" id="btnCart"  class="btn btn-primary">장바구니</button>
      	</div>
      </div>
      <div class="row">
      	<div class="col text-center">     	
      	</div>      
      </div>
      
      <div class="row">
      	<div class="col-12">
      		<div id="productDetailTabs">
			  <ul>
			    <li><a href="#productDetailInfo">상세정보</a></li>
			    <li><a href="#productDetailReview">상품리뷰</a></li>
			    <li><a href="#tabs-3">QnA</a></li>
			  </ul>
			  <div id="productDetailInfo">
			    <p>${productVO.p_detail}</p>
			  </div>
			  <div id="productDetailReview">
			  	<div class="row">
				    <div class="col-6">
				    	REVIEW
				    </div>
				    <div class="col-6">
				    	<button type="button" id="btnReview" class="btn btn-info">상품 리뷰 쓰기</button>
					</div>
				</div>		  
				<!--상품 후기  출력 위치-->
				<div id="reviewListResult">
<!-- 					<div class="list-group">
						<div class="d-flex w-100 justify-content-between">
							<h6 class="mb-1">아이디</h6>
							<small>평점</small>
						</div>
						<p class="mb-1">Some placeholder content in a paragraph.</p>
						<small>And some small print.</small>
					</div>
					<hr>
					<div class="list-group">
						<div class="d-flex w-100 justify-content-between">
							<h6 class="mb-1">아이디</h6>
							<small>평점</small>
						</div>
						<p class="mb-1">Some placeholder content in a paragraph.</p>
						<small>And some small print.</small>
					</div>
					<hr>
					<div class="list-group">
						<div class="d-flex w-100 justify-content-between">
							<h6 class="mb-1">아이디</h6>
							<small>평점</small>
						</div>
						<p class="mb-1">Some placeholder content in a paragraph.</p>
						<small>And some small print.</small>
					</div> -->
				</div>


				<!-- 상품 후기 페이징 출력 위치-->				
				<div>
					<nav aria-label="Page navigation example">
					  <ul class="pagination" id="reviewPagingResult">
					  </ul>
					</nav>
				</div>


			    
			  </div>
			  <div id="tabs-3">
			    <p>Mauris eleifend est et turpis. Duis id erat. Suspendisse potenti. Aliquam vulputate, pede vel vehicula accumsan, mi neque rutrum erat, eu congue orci lorem eget lorem. Vestibulum non ante. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Fusce sodales. Quisque eu urna vel enim commodo pellentesque. Praesent eu risus hendrerit ligula tempus pretium. Curabitur lorem enim, pretium nec, feugiat nec, luctus a, lacus.</p>
			    <p>Duis cursus. Maecenas ligula eros, blandit nec, pharetra at, semper at, magna. Nullam ac lacus. Nulla facilisi. Praesent viverra justo vitae neque. Praesent blandit adipiscing velit. Suspendisse potenti. Donec mattis, pede vel pharetra blandit, magna ligula faucibus eros, id euismod lacus dolor eget odio. Nam scelerisque. Donec non libero sed nulla mattis commodo. Ut sagittis. Donec nisi lectus, feugiat porttitor, tempor ac, tempor vitae, pede. Aenean vehicula velit eu tellus interdum rutrum. Maecenas commodo. Pellentesque nec elit. Fusce in lacus. Vivamus a libero vitae lectus hendrerit hendrerit.</p>
			  </div>
			</div>
      	</div>
      </div>
   
      
      <!-- footer -->
	  <%@include file="/WEB-INF/views/include/footer.jsp" %>
    </div>

    <script>

		$(function(){
			  	
			//장바구니 담기
			$("#btnCart").on("click", function(){

				$.ajax({
					url: '/user/cart/addCart',
					data: { p_num : $("input#p_num").val(), cart_acount : $("input#p_amount").val() },
					dataType: 'text',
					success: function(result) {
						if(result == "success") {
							alert("장바구니가 추가되었습니다.");
							if(confirm("장바구니로 이동하시겠습니까?")){
								location.href = "/user/cart/cartList";
							}
						}
					}
				});
			});
			

			let searchForm = $("#searchForm");

			//검색버튼 클릭 시 pageNum 1로 초기화
			$("#btnSearch").on("click", function(){
			//searchForm.children("input[name='pageNum']").val(1);
			searchForm.find("input[name='pageNum']").val(1);
			searchForm.submit();
			});

			//상품 이미지 / 상품 제목 클릭
			$("div.container a.move").on("click", function(e){
				e.preventDefault();

				let p_num = $(this).attr("href"); //attr: 속성의 값

				actionForm.attr("method", "get");
				actionForm.attr("action", "상품상세주소");

				actionForm.append("<input type='hidden' name='p_num' value'" + p_num + "'>");
				// actionForm.submit();
			});
				
			//jquery-ui tab
			$("#productDetailTabs").tabs();

			//상품 후기 모달 상자
			$("button#btnReview").on("click", function(){

				console.log("버튼클릭");
				$("#reviewModal").modal('show');
			});

			//평점 별 클릭시 색상 변경
			$("#star_r_score a.r_score").on("click", function(e){
				
				e.preventDefault();

				$(this).parent().children().removeClass("on"); 
				//별 선택시 클래스에 추가되어 있던 on 선택자를 제거(처음에는 제거할 on선택자가 없지만 다시 별을 선택하게 되면 on선택자 제거해야 함)
				$(this).addClass("on").prevAll("a").addClass("on"); 
				//제거된 on선택자를 선택한 별의 태그에 on선택자를 추가하고, 그 이전 a태그에 on선택자를 다시 추가
			});

			//상품후기 저장 버튼 클릭
			$("#btnReviewWrite").on("click", function(){

				let r_score = 0;
				let r_content = $("#r_content").val();
				let p_num = $("#p_num").val();

				//별점 5개여서 each 5번 돌음
				$("#star_r_score a.r_score").each(function(index, item){
					
					if($(this).attr("class") == 'r_score on') {
						r_score += 1;
					}
					
				});
				console.log("별 평점: " + r_score);

				if(r_score == 0) {
					alert("별 평점을 선택해 주세요");
					return;
				}

				if(r_content == "") {
					alert("상품 후기를 작성해 주세요");
					return;
				}

				let data = { p_num:p_num, r_score:r_score, r_content:r_content };
				//data라는 객체를 json문자열로 변환시켜야 함 -JSON.stringify(data)
				$.ajax({
					url: '/user/review/new',
					headers: {
			              "Content-type" : "application/json", "X-HTTP-Method_Override" : "POST"
			            },
					data: JSON.stringify(data),
					dataType: 'text',
					type: 'post',
					success: function(result) {
						if(result =="success") {
							alert("상품후기가 등록됨");
							
							//상품후기 목록
							reviewPage = 1;
							url = "/user/review/list/" + $("#p_num").val() + "/" + reviewPage;							
							getPage(url);
							

							//상품후기 대화상자 숨김
							$("#reviewModal").modal('hide');

							$("#star_r_score a.r_score").parent().children().removeClass("on"); 
							$("#r_content").val("");
						}
					}
				});
				
			});
		});

		let reviewPage = 1;
		let url = "/user/review/list/" + ${productVO.p_num} + "/" + reviewPage;
		getPage(url);

		//페이지 번호 얻는 함수
		function getPage(pageInfo) {
			$.getJSON(pageInfo, function(data){

				if(data.list.length > 0) {

					//함수 : 상품후기 목록
					printReviewList(data.list, $("#reviewListResult"), $("#reviewTemplate"));

					//함수 : 페이징 기능
					printReviewPaging(data.pageMaker, $("#reviewPagingResult"));
				}
			});
		}

		
		
		//상품 후기 출력하는 함수
		let printReviewList = function(reviewArrData, target, templateObj) {
			//핸들바 코드가 존재하는 상품 후기 디자인 코드를 컴파일
			let template = Handlebars.compile(templateObj.html());

			//템플릿과 소스가 합쳐진 결과 - 상품 후기 목록 데이터 _ 상품 페이징 UI
			let html =template(reviewArrData);

			target.empty();
			target.append(html); //자식으로 추가
		}

		

		//상품 후기 등록일 : 사용자 정의 Helper 함수 -> 템플릿에서 사용
		Handlebars.registerHelper("prettifyDate", function(timeValue){

			let dateObj = new Date(timeValue);
			let year = dateObj.getFullYear();
			let month = dateObj.getMonth();
			let date = dateObj.getDate();

			return year + "/" + month + "/" + date;
		});

		//별점 평점 표시하기
		Handlebars.registerHelper("displayStar", function(rating){

			let stars = "";
			switch(rating) {
				case 1:
					stars = "★☆☆☆☆";
				case 2:
					stars = "★★☆☆☆";
				case 3:
					stars = "★★★☆☆";
				case 4:
					stars = "★★★★☆";
				case 5:
					stars = "★★★★★";
			}

			return stars;
		});

		//아이디 4글자만 보여주기
		Handlebars.registerHelper("idDisplay", function(userid){
			return userid.substring(0, 4) + "****";
		});

		//상품 후기 페이징 함수
		let printReviewPaging = function(pageMaker, target) {

			let pagingStr = "";

			/*
			<li class="page-item"><a class="page-link" href="#">Previous</a></li>
			<li class="page-item"><a class="page-link" href="#">1</a></li>
			<li class="page-item"><a class="page-link" href="#">2</a></li>
			<li class="page-item"><a class="page-link" href="#">3</a></li>
			<li class="page-item"><a class="page-link" href="#">Next</a></li>
			*/
			//이전 표시
			if(pageMaker.prev) {
				pagingStr += "<li class='page-item'><a class='page-link' href='" + (pageMaker.startPage - 1) + "'>이전</a></li>";
			}

			//페이지 번호 표시
			for(let i=pageMaker.startPage; i<=pageMaker.endPage; i++) {
				let classStr = pageMaker.cri.pageNum == i ? 'active' : '';
				pagingStr += "<li class='page-item " + classStr + "''><a class='page-link' href ='" + i + "'>" + i + "</a></li>";
			}

			//다음 표시
			if(pageMaker.next) {
				pagingStr += "<li class='page-item'><a class='page-link' href='" + (pageMaker.endPage + 1) + "'>다음</a></li>";
			}

			target.children().remove();
			target.html(pagingStr);

		}

		
	

		//이전, 페이지 번호, 다음 클릭
		$("nav ul#reviewPagingResult").on("click", "li a.page-link", function(e){
			e.preventDefault();
			// console.log("페이지 번호 클릭");

			reviewPage = $(this).attr("href");
			url = "/user/review/list/" + $("#p_num").val() + "/" + reviewPage;	
			// console.log(url);
			getPage(url);

		});

		
		
	
	  </script>


	  <!-- 리뷰 작성할 모달 -->
		<div class="modal fade" id="reviewModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="exampleModalLabel">상품 후기</h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      <div class="modal-body">
		        <form>
		          <div class="form-group">
		            <label for="recipient-name" class="col-form-label">상품평점:</label>
		            <p id="star_r_score">
		            	<a class="r_score" href="#">★</a>
		            	<a class="r_score" href="#">★</a>
		            	<a class="r_score" href="#">★</a>
		            	<a class="r_score" href="#">★</a>
		            	<a class="r_score" href="#">★</a>
		            </p>
		          </div>
		          <div class="form-group">
		            <label for="r_content" class="col-form-label">리뷰내용:</label>
		            <textarea class="form-control" id="r_content"></textarea>
		          </div>
		        </form>
		      </div>
		      <div class="modal-footer">		        
		        <button type="button" id="btnReviewWrite" class="btn btn-primary btnReview">상품 리뷰 저장</button>
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
		      </div>
		    </div>
		  </div>
		</div>
  </body>

  
</html>
