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
    </style>

  <script>
	if('${msg}' == 'logout') {
		alert("로그아웃 되었습니다.");
	}
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
        <c:forEach items="${productList}" var="productVO">
        	<div class="col-md-4">
	          <div class="card mb-4 shadow-sm">
	            <!-- <svg class="bd-placeholder-img card-img-top" width="100%" height="225" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: Thumbnail" preserveAspectRatio="xMidYMid slice" focusable="false"><title>Placeholder</title><rect width="100%" height="100%" fill="#55595c"></rect><text x="50%" y="50%" fill="#eceeef" dy=".3em">Thumbnail</text></svg> -->
	            <!-- 상품 이미지 -->
	            <img src="/user/product/displayFile?folderName=${productVO.p_image_dateFolder}&fileName=s_${productVO.p_image}" 
					 alt="" class="bd-placeholder-img card-img-top" width="100%" height="225" onerror="this.onerror=null; this.src='/image/no_image.png'">
	
	            <div class="card-body">
	              <p class="card-text">
	              	${productVO.p_name}<br>
	              	${productVO.p_company}<br>
	              	<fmt:setLocale value="ko_kr"/><fmt:formatNumber type="number" maxFractionDigits="3" value="${productVO.p_cost}"></fmt:formatNumber>
	              	<%-- maxFractionDigits="3" : 3자리마다 ,(콤마) 삽입 --%>
	              </p>
	              <div class="d-flex justify-content-between align-items-center">
	                <div class="btn-group">
	                  <button type="button" data-p_num="${productVO.p_num}" name="btnBuyCart" class="btn btn-sm btn-outline-secondary">BUY & CART</button>
	                </div>
	                <small class="text-muted">후기</small>
	              </div>
	            </div>
	          </div>
	        </div>
        </c:forEach>
        
      </div>
      <!-- footer -->
	  <%@include file="/WEB-INF/views/include/footer.jsp" %>
    </div>
    
    <!-- 상품상세보기(바로구매 + 장바구니) 모달 -->
	<div class="modal fade" id="modal_productDetail" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-xl">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLabel">New message</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
			<div class="row">
				<div class="col-md-6">
					<img src="" id="modal_detail_image" 
					 alt="" class="bd-placeholder-img card-img-top" width="100%" height="225" onerror="this.onerror=null; this.src='/image/no_image.png'">
				</div>
				<div class="col-md-6">
					<form>
						<div class="form-group row">
							<label for="p_name" class="col-form-label col-3">상품명</label>
							<div class="col-9">
								<input type="text" class="form-control" id="p_name" readonly>
								<input type="hidden" class="form-control" id="p_num">
							</div>
						</div>
						<div class="form-group row">
							<label for="p_cost" class="col-form-label col-3">판매가격</label>
							<div class="col-9">
								<input type="text" class="form-control" id="p_cost" readonly>
							</div>
						</div>
						<div class="form-group row">
							<label for="p_company" class="col-form-label col-3">제조사</label>
							<div class="col-9">
								<input type="text" class="form-control" id="p_company" readonly>
							</div>
						</div>
						<div class="form-group row">
							<label for="p_amount" class="col-form-label col-3">수량</label>
							<div class="col-9">
								<input type="number" class="form-control" id="p_amount" min="1" value="1">
							</div>
						</div>
					</form>
				</div>
			</div>	        
	      </div>
	      <div class="modal-footer">
	        <button type="button" name="btnModalBuy" class="btn btn-primary">Buy Now</button>
	        <button type="button" name="btnModalCart" class="btn btn-primary">Add to Cart</button>
	      </div>
	    </div>
	  </div>
	</div>

    <script>

		$(function(){
	
			//상세보기 : 모달
			$("button[name='btnBuyCart']").on("click", function(){
				// console.log("상세보기 모달");
	
				let p_num = $(this).data("p_num");
				console.log(p_num);
				$("#modal_productDetail").modal('show');
				
				let url = "/user/product/productDetail/" + p_num;
				console.log(url);

				$.getJSON(url, function(result){
					
					//console.log(result.p_num);

					//모달 대화상자에서 상품 상세정보 표시
					$("div#modal_productDetail input#p_num").val(result.p_num); //상품 코드
					$("div#modal_productDetail input#p_name").val(result.p_name); //상품명
					$("div#modal_productDetail input#p_cost").val(result.p_cost); //판매가격
					$("div#modal_productDetail input#p_company").val(result.p_company); //제조사

					//상품 이미지
					///user/product/displayFile?folderName=${productVO.p_image_dateFolder}&fileName=s_${productVO.p_image}
					let imgUrl = "/user/product/displayFile?folderName=" + result.p_image_dateFolder + "&fileName=" + result.p_image;
					//console.log(imgUrl);
					$("div#modal_productDetail img#modal_detail_image").attr("src", imgUrl);
				});
			});

			//장바구니 담기
			$("button[name='btnModalCart']").on("click", function(){

				$.ajax({
					url: '/user/cart/addCart',
					data: { p_num : $("div#modal_productDetail input#p_num").val(), cart_acount : $("div#modal_productDetail input#p_amount").val() },
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
	
		});
	
	  </script>
  </body>

  
</html>
