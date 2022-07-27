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
	  <h1 class="display-4">CART</h1>
	</div>
	
	<div class="container">
		<div class="row">
	      	<div class="col-md-12">      	
	      		<div class="box box-primary">
	      			<div class="box-header">
	      				LIST CART     
	      			</div>	
	      			<div class="box-body">	      				
					  <table class="table table-hover" id="cartListResult">
						  <thead>
						    <tr>
						      <th scope="col">제품</th>
						      <th scope="col">수량</th>
						      <th scope="col">배송비</th>
						      <th scope="col">가격</th>						      
						      <th scope="col">적립</th>
						      <th scope="col">취소</th>
						    </tr>
						  </thead>
						  <tbody>
						  <c:forEach items="${cartList}" var="cartVO">
						  <c:set var="price" value="${cartVO.cart_acount * cartVO.p_cost}"></c:set>
						    <tr>	
						      <!-- 제품 : 이미지 및 상품이름 -->				      
						      <td>						      	
						      	<a class="move" href="${cartVO.p_num}">
						      		<img src="/user/product/displayFile?folderName=${cartVO.p_image_dateFolder}&fileName=s_${cartVO.p_image}" 
						      		alt="" style="width: 80px; height: 80px" onerror="this.onerror=null; this.src='/image/no_image.png'">
						      		<c:out value="${cartVO.p_name}" />
						      	</a>
						      </td>
						      <!-- 수량 -->
						      <td>
						      	<input type="hidden" name="p_cost" value="${cartVO.p_cost}">
						      	<input type="number" class="w-25" name="cart_acount" value='<c:out value="${cartVO.cart_acount}" />'>
						      	<button type="button" name="btnCartAcountChange" data-cart_code="${cartVO.cart_code}" class="btn btn-link">수량변경</button>
						 		<button type="button" name="btnCartAcountChange2" data-cart_code="${cartVO.cart_code}" class="btn btn-link">수량변경(AJAX X)</button>
						      </td>
						      <!-- 배송비 -->	
						      <td>
						      	[기본배송]
						      </td>	
						      <!-- 가격 : 수량 * 하나가격 -->				      
						      <td>
						      	<span class="unitPrice">						      	
						      		<fmt:formatNumber type="number" maxFractionDigits="3" value="${price}" />
						      	</span>
						      </td>							  
						      <!-- 적립 -->
						      <td>
						      	<c:out value="${cartVO.m_point}" />
						      </td>
						      <!-- 삭제 -->
						      <td>
			                    <input type="hidden" name="p_image_dateFolder" value="${cartVO.p_image_dateFolder}">
			                    <input type="hidden" name="p_image" value="${cartVO.p_image}">
			                    <button type="button" name="btnCartDelete" data-cart_code="${cartVO.cart_code}" class="btn btn-link">삭제</button></td>
						    </tr>
						    <c:set var="sum" value="${sum + price}"></c:set>
						   </c:forEach> 
						   
						  </tbody>
						  <tfoot>
						  	<tr>
						  		<td colspan="6" style="text-align: right"> 
						  			총 구매 금액: <span id="cartTotalPrice"><fmt:formatNumber type="number" maxFractionDigits="3" value="${sum}" /></span>
						  		</td>
						  	</tr>
						  </tfoot>
						</table>							
	      			</div>		
	      		</div>     
	      	</div>      
	      </div>
		
      
      <!-- footer -->
	  <%@include file="/WEB-INF/views/include/footer.jsp" %>
    </div>
    
    <script>

		$(function(){

			//수량변경 버튼 - 장바구니 코드, 변경 수량
			$("button[name='btnCartAcountChange']").on("click", function(){
				
				let btnCartAcountChange = $(this);
				
				//장바구니 코드 값 참조
				let cart_code = $(this).data("cart_code");
				//변경수량
				let cart_acount = $(this).parent().find("input[name='cart_acount']").val();
				//console.log("장바구니 코드: " + cart_code + " 변경수량: " + cart_acount );

				$.ajax({
					url: '/user/cart/cartAcountChange',
					data: { cart_code : cart_code, cart_acount : cart_acount },
					dataType: 'text',
					method: 'get',
					success: function(result) {
						if(result == "success") {
							alert("수량 변경이 되었습니다.");
							
							let p_cost = btnCartAcountChange.parent().find("input[name='p_cost']").val();
							
							//개별상품 금액
							// console.log("단위 가격: " + (p_cost * cart_acount));
							btnCartAcountChange.parents("tr").find("span.unitPrice").html($.numberWithCommas(p_cost * cart_acount));
							
							//총금액 변경작업
							let total_price = 0;
							$("table#cartListResult tr td span.unitPrice").each(function(index, item){
								// console.log("단위가격: " + $(item).html());
								// console.log("단위가격: " + $(item).text());

								total_price += parseInt($.withoutCommas($(item).text())); //무언갈 읽어오는 데이터는 전부 text(String)
								$("table#cartListResult tr td span#cartTotalPrice").text($.numberWithCommas(total_price));
							});

						}
					}
				});
			});
		});

		//숫자값을 천단위 마다 콤마 찍기
		$.numberWithCommas = function(x) {
			return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
		}

		//3자리마다 콤마 제거하기
		$.withoutCommas = function (x) {
			return x.toString().replace(",", '');
		}

		//ajax 사용안한 수량변경2
		$(function(){

			//수량변경 버튼 - 장바구니 코드, 변경 수량
			$("button[name='btnCartAcountChange2']").on("click", function(){
				
				let btnCartAcountChange = $(this);
				
				//장바구니 코드 값 참조
				let cart_code = $(this).data("cart_code");
				//변경수량
				let cart_acount = $(this).parent().find("input[name='cart_acount']").val();
				//console.log("장바구니 코드: " + cart_code + " 변경수량: " + cart_acount );

				location.href ="/user/cart/cartAcountChange2?cart_code=" + cart_code + "&cart_acount=" + cart_acount;
				
			});
		});
	  </script>
  </body>

  
</html>
