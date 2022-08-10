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
	      				<form id="orderForm" method="post" action="">
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
						      <input type="text" class="form-control" name="m_email" readonly value="${sessionScope.loginStatus.m_email}">
						    </div>
						  </div>
						  <div class="form-group row">
						    <label for="m_tel" class="col-sm-2 col-form-label">휴대폰 번호</label>
						    <div class="col-sm-10">
						      <input type="text" class="form-control" name="m_tel" readonly value="${sessionScope.loginStatus.m_tel}">
						      <input type="hidden" class="form-control" name="s_o_post" value="${sessionScope.loginStatus.m_postnum}">
						      <input type="hidden" class="form-control" name="s_o_addr" value="${sessionScope.loginStatus.m_addr}">
						      <input type="hidden" class="form-control" name="s_o_addr_d" value="${sessionScope.loginStatus.m_addr_d}">
						    </div>
						  </div>
						  <input type="checkbox" id="same"><label for="same"> 위 정보와 같음</label>
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
						    <label for="mem_phone" class="col-sm-2 col-form-label">배송지 선택</label>
						    <div class="col-sm-10">
						      <div class="form-check form-check-inline">
							  	<input class="form-check-input" type="radio" name="receiveAddr" id="receiveAddr1" value="1" checked>
							  	<label class="form-check-label" for="inlineRadio1">자택</label>
							   </div>
							   <div class="form-check form-check-inline">
								  <input class="form-check-input" type="radio" name="receiveAddr" id="receiveAddr2" value="2">
								  <label class="form-check-label" for="inlineRadio2">타지역</label>
							   </div>
						    </div>
						  </div>
						  <div class="form-group row">
						    <label for="sample2_postcode" class="col-sm-2 col-form-label">우편번호</label>
						    <div class="col-sm-10">
						      <input type="text" class="form-control" id="sample2_postcode" name="o_post" value="${sessionScope.loginStatus.m_postnum}">
						      <input type="button" onclick="sample2_execDaumPostcode()" value="우편번호 찾기">
						    </div>
						  </div>
						  <div class="form-group row">
						    <label for="sample2_address" class="col-sm-2 col-form-label">주소</label>
						    <div class="col-sm-10">
						      <input type="text" class="form-control" id="sample2_address" name="o_addr" value="${sessionScope.loginStatus.m_addr}">
						    </div>
						  </div>
						  <div class="form-group row">
						    <label for="sample2_detailAddress" class="col-sm-2 col-form-label">상세주소</label>
						    <div class="col-sm-10">
						      <input type="text" class="form-control" id="sample2_detailAddress" name="o_addr_d" value="${sessionScope.loginStatus.m_addr_d}">
						      <input type="hidden" id="sample2_extraAddress" placeholder="참고항목">
						    </div>
						  </div>
						  <div class="form-group row">
						    <label for="mem_phone" class="col-sm-2 col-form-label">배송 메세지(100자 이내)</label>
						    <div class="col-sm-10">
						      <textarea name="o_message" class="form-control" rows="5"></textarea>
						      <input type="hidden" name="o_totalcost" value="${sum}">
						    </div>
						  </div>
						  <div class="form-group">
						    <label for="exampleFormControlSelect1">결제 방법</label>
						    <select class="form-control" id="pay_method" name="pay_method">
						      <option value="">결제방법을 선택하세요</option>
						      <option value="무통장 입금">무통장 입금</option>
						      <option value="카카오 페이">카카오 페이</option>
						      <option value="휴대폰 결제">휴대폰 결제</option>
						      <option value="신용카드 결제">신용카드 결제</option>
						      <option value="페이코">페이코</option>
						    </select>
						    <select class="form-control" id="bank" name="bank">
						      <option value="">은행을 선택하세요</option>
						      <option value="국민-0000000000000">국민 은행(0000000000000)</option>
						      <option value="우리-1111111111111">우리 은행(1111111111111)</option>
						      <option value="신한-2222222222222">신한 은행(2222222222222)</option>
						      <option value="하나-3333333333333">하나 은행(3333333333333)</option>
						    </select>
						    <input type="hidden" class="form-control" name="pay_bank" id="pay_bank" value="">
						    <input type="hidden" class="form-control" name="pay_price" id="pay_price" value="${sum}">
						  </div>
						  <div class="form-group row">
						    <label for="pay_user" class="col-sm-2 col-form-label">입금자 명</label>
						    <div class="col-sm-10">
						      <input type="text" class="form-control" name="pay_user" id="pay_user">
						    </div>
						  </div>		
						</form>
	      			</div>
	      			<div class="box-footer text-center">
	      				<button type="button" id="btnCancelOrder"  class="btn btn-primary">주문 취소</button>
	      				<img id="kakao_pay" alt="kakaoPay" src="/image/payment_icon_yellow_medium.png" style="display: none;">
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

			//위 정보와 같을 때 체크박스
			$("#same").on("click", function(){

				if($("#same").is(":checked") == true) {
					$("#o_name").val("${sessionScope.loginStatus.m_username}");
					$("#o_tel").val($("input[name='m_tel']").val());
				} else{
					$("#o_name").val("");
					$("#o_tel").val("");
				}
				
			});

			//자택 또는 타지역 라디오 버튼 선택
			$("input[name='receiveAddr']").on("click", function(){

				if($("input[name='receiveAddr']:checked").val() == 1) {
					//자택
					$("input[name='o_post']").val($("input[name='s_o_post']").val());
					$("input[name='o_addr']").val($("input[name='s_o_addr']").val());
					$("input[name='o_addr_d']").val($("input[name='s_o_addr_d']").val());

				} else if($("input[name='receiveAddr']:checked").val() == 2) {			
					//타지역
					$("input[name='o_post']").val("");
					$("input[name='o_addr']").val("");
					$("input[name='o_addr_d']").val("");
				}
			});

			//결제 방법 선택
			$("#pay_method").on("change", function(){
				if($("#pay_method option:selected").val() =="") {
					alert("결제 방법을 선택하세요");
					return;
				}

				//카카오 페이 선택 시
				if($("#pay_method option:selected").val() =="카카오 페이") {
					alert("카카오페이 이미지를 클릭하세요");
					$("#kakao_pay").attr("style", "display:inline;");
					return;
				}

			});

			//카카오페이 버튼 클릭(ajax구문으로 사용해야 함)
			$("img#kakao_pay").on("click", function(){

				//카카오 페이에서 요청하는 필수 입력값 확보
				
				//주문자				
				let o_name = $("input[name='o_name']").val();
				//연락처
				let o_tel = $("input[name='o_tel']").val();
				//전자우편
				let m_email = $("input[name='m_email']").val();
				//전체금액
				let o_totalcost = $("input[name='o_totalcost']").val();
				//적립금
				//쿠폰

				$.ajax ({
					url: '/user/order/orderPay',
					type: 'get',
					data: {
						//자바스크립트 Object 구문으로 저송
						totalAmount : o_totalcost
					},
					success: function(response) {
						alert(response.tid);
						location.href = response.next_redirect_pc_url;
					}
				});
			});

			//무통장 입금 시 은행 선택
			$("#bank").on("change", function(){
				if($("#bank option:selected").val() =="") {
					alert("입금 은행을 선택하세요");
					return;
				}

				$("#pay_bank").val($("#bank option:selected").text().substring(0,5));

			});


			//주문하기 버튼 클릭
			$("#btnOrder").on("click", function(){

				//유효성 검사


				$("#orderForm").attr("action", "/user/order/orderSave?type=무통장");
				alert("주문이 완료되었습니다.");
				$("#orderForm").submit();
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
