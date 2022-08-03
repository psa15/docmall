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
	  <h1 class="display-4">ORDER LIST </h1>
	</div>
	
	<div class="container">
		
		<div class="row">
	      	<div class="col-md-12">      	
	      		<div class="box box-primary">
	      			<div class="box-header">
	      				LIST ORDER     
	      			</div>	
	      			<div class="box-body">	      				
					  <table class="table table-hover" id="cartListResult">
						  <thead>
						    <tr>
						      <th scope="col">상품</th>
						      <th scope="col">수량</th>
						      <th scope="col">적립</th>
						      <th scope="col">주문금액</th>
						    </tr>
						  </thead>
						  <tbody>
						  <c:forEach items="${cartOrderList}" var="cartOrderInfo">
						  <c:set var="price" value="${cartOrderInfo.cart_acount * cartOrderInfo.p_cost}"></c:set>
						    <tr>	
						      <!-- 제품 : 이미지 및 상품이름 -->				      
						      <td>						      	
						      	<a class="move" href="${cartOrderInfo.p_num}">
						      		<img src="/user/order/displayFile?folderName=${cartOrderInfo.p_image_dateFolder}&fileName=s_${cartOrderInfo.p_image}" alt="" style="width: 80px; height: 80px" onerror="this.onerror=null; this.src='/image/no_image.png'">
						      		<c:out value="${cartOrderInfo.p_name }"></c:out>						      								      		
						      	</a>						      	
						      </td>
						      <!-- 수량 -->
						      <td>
						      	<input type="hidden" name="p_cost" value="${cartOrderInfo.p_cost}">
						      	<c:out value="${cartOrderInfo.cart_acount}" />개
						      </td>
						      <!-- 적립 	-->
						      <td>
						      	<c:out value="${sessionScope.loginStatus.m_point}" />
						      </td>
						      <!-- 주문금액 -->				      
						      <td>
						      	<span class="unitPrice">						      	
						      		<fmt:formatNumber type="number" maxFractionDigits="3" value="${price}" />
						      	</span>
						      </td>	
						    <c:set var="sum" value="${sum + price}"></c:set>
						   </c:forEach> 
						   
						  </tbody>
						  <tfoot>
						  	<tr>
						  		<%-- empty : 데이터가 존재하지 않으면 true, 존재하면 false --%>
						  		<c:if test="${!empty cartOrderList}">
							  		<td colspan="4" style="text-align: right"> 
							  			총 구매 금액: <span id="cartTotalPrice"><fmt:formatNumber type="number" maxFractionDigits="3" value="${sum}" /></span>
							  		</td>
						  		</c:if>
						  		<c:if test="${empty cartOrderList}">
							  		<td colspan="4" style="text-align: center"> 
							  			주문내역 상품이 없습니다.
							  		</td>
						  		</c:if>
						  	</tr>
						  </tfoot>
						</table>							
	      			</div>
	      			<div>
	      				<form id="joinForm" method="post" action="join">
	      				  <h5>주문자 정보</h5>
	      				  <hr>
						  <div class="form-group row">
						    <label for="m_username" class="col-sm-2 col-form-label">이름</label>
						    <div class="col-sm-10">
						      <c:out value="${sessionScope.loginStatus.m_username}" />
						    </div>
						  </div>
						  <div class="form-group row">
						    <label for="m_email" class="col-sm-2 col-form-label">이메일</label>
						    <div class="col-sm-10">
						      <input type="text" class="form-control" name="m_email" value="${sessionScope.loginStatus.m_email}">
						    </div>
						  </div>
						  <div class="form-group row">
						    <label for="m_tel" class="col-sm-2 col-form-label">휴대폰 번호</label>
						    <div class="col-sm-10">
						      <input type="text" class="form-control" name="m_tel" value="${sessionScope.loginStatus.m_tel}">
						    </div>
						  </div>
						  <hr>
						  <h5>배송 정보</h5>
	      				  <hr>
						  <div class="form-group row">
						    <label for="o_name" class="col-sm-2 col-form-label">이름</label>
						    <div class="col-sm-10">
						      <input type="text" class="form-control" id="o_name" name="o_name">
						    </div>
						  </div>
						  <div class="form-group row">
						    <label for="o_tel" class="col-sm-2 col-form-label">휴대폰 번호</label>
						    <div class="col-sm-10">
						      <input type="text" class="form-control" id="o_tel" name="o_tel">
						    </div>
						  </div>
						  <div class="form-group row">
						    <label for="m_tel" class="col-sm-2 col-form-label">배송지 선택</label>
						    <div class="col-sm-10">
						      배송지 작업
						    </div>
						  </div>
						  <div class="form-group row">
						    <label for="sample2_postcode" class="col-sm-2 col-form-label">우편번호</label>
						    <div class="col-sm-10">
						      <input type="text" class="form-control" id="sample2_postcode" name="o_post">
						      <input type="button" onclick="sample2_execDaumPostcode()" value="우편번호 찾기">
						    </div>
						  </div>
						  <div class="form-group row">
						    <label for="sample2_address" class="col-sm-2 col-form-label">주소</label>
						    <div class="col-sm-10">
						      <input type="text" class="form-control" id="sample2_address" name="o_addr">
						    </div>
						  </div>
						  <div class="form-group row">
						    <label for="sample2_detailAddress" class="col-sm-2 col-form-label">상세주소</label>
						    <div class="col-sm-10">
						      <input type="text" class="form-control" id="sample2_detailAddress" name="o_addr_d">
						      <input type="hidden" id="sample2_extraAddress" placeholder="참고항목">
						    </div>
						  </div>
						  <div class="form-group row">
						    <label for="m_tel" class="col-sm-2 col-form-label">배송지 메시지(100자 이내)</label>
						    <div class="col-sm-10">
						      	<textarea rows="3" cols="3"></textarea>
						    </div>
						  </div>		
						</form>
	      			</div>
	      			<div class="box-footer text-center">
	      				<button type="button" id="btnCancelOrder"  class="btn btn-primary">주문 취소</button>
	      				<button type="button" id="btnOrder"  class="btn btn-primary">주문하기</button>
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

			//수량변경 버튼 - 장바구니 코드, 변경 수량
			$("button[name='btnCartAcountChange2']").on("click", function(){
				
				//장바구니 코드 값 참조
				let cart_code = $(this).data("cart_code");
				//변경수량
				let cart_acount = $(this).parent().find("input[name='cart_acount']").val();
				//console.log("장바구니 코드: " + cart_code + " 변경수량: " + cart_acount );

				location.href ="/user/cart/cartAcountChange2?cart_code=" + cart_code + "&cart_acount=" + cart_acount;
				
			});

			//상품 삭제 
			$("button[name='btnCartDelete']").on("click", function(){

				// console.log("삭제버튼 클릭");
				
				//장바구니 코드 값 참조
				let cart_code = $(this).data("cart_code");
				//console.log("장바구니 코드: " + cart_code);

				if(!confirm($(this).data("p_name") + " 상품을 삭제하시겠습니까?")){
					return;
				}

				location.href ="/user/cart/deleteCart?cart_code=" + cart_code;
				
			});

			//장바구니 비우기 btnClearCart
			$("button[name='btnClearCart']").on("click", function(){
				// console.log("장바구니 비우기");

				if(!confirm("장바구니를 비우시겠습니까?")){
					return;
				}

				

				location.href ="/user/cart/clearCart"; //session정보에 아이디 정보가 있기 때문에 파라미터값이 필요 없음
				$("tfoot tr").remove();
				
			});
		});

		/* 함수 */
		//숫자값을 천단위 마다 콤마 찍기
		$.numberWithCommas = function(x) {
			return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
		}

		//3자리마다 콤마 제거하기
		$.withoutCommas = function (x) {
			return x.toString().replace(",", '');
		}

	  </script>
  </body>

  
</html>
