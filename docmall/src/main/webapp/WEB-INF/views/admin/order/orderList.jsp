<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<!--
This is a starter template page. Use this page to start your new project from
scratch. This page gets rid of all links and provides the needed markup only.
-->
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>AdminLTE 2 | Starter</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  
  <!-- plugin1 - Font, Ionicons, Theme style, AdminLTE Skins, Google Font -->
  <%@include file="/WEB-INF/views/admin/include/plugin1.jsp" %>
  
</head>
<!--
BODY TAG OPTIONS:
=================
Apply one or more of the following classes to get the
desired effect
|---------------------------------------------------------|
| SKINS         | skin-blue                               |
|               | skin-black                              |
|               | skin-purple                             |
|               | skin-yellow                             |
|               | skin-red                                |
|               | skin-green                              |
|---------------------------------------------------------|
|LAYOUT OPTIONS | fixed                                   |
|               | layout-boxed                            |
|               | layout-top-nav                          |
|               | sidebar-collapse                        |
|               | sidebar-mini                            |
|---------------------------------------------------------|
-->
<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">

  <!-- Main Header -->
  <%@include file="/WEB-INF/views/admin/include/header.jsp" %>
  
  <!-- Left side column. contains the logo and sidebar -->
  <%@include file="/WEB-INF/views/admin/include/nav.jsp" %>

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        Page Header
        <small>Optional description</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
        <li class="active">Here</li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content container-fluid">

      <div class="row">
      	<div class="col-md-12">      	
      		<div class="box box-primary">
      			<div class="box-header">
      				LIST ORDER     
      			</div>	
      			<div class="box-body">
      				<form id="searchForm" action="/admin/product/productList" method="get">
					  <%-- 검색 단추를 누르면 - pageNum은 1로 돌아가게  --%>
					    <select name="type" id="selectType">
							 <option value="" <c:out value="${pageMaker.cri.type == null ? 'selected' : ''}" />>--</option> 
							 <option value="O" <c:out value="${pageMaker.cri.type eq 'O' ? 'selected' : ''}" />>주문번호</option>
							 <option value="I" <c:out value="${pageMaker.cri.type eq 'I' ? 'selected' : ''}" />>주문자 아이디</option>
							 <option value="NC" <c:out value="${pageMaker.cri.type eq 'NC' ? 'selected' : ''}" />>상품명  or 제조사</option>
							 <option value="Y" <c:out value="${pageMaker.cri.type eq 'Y' ? 'selected' : ''}" />>판매여부</option>
					  	</select>
					  	<c:if test="${pageMaker.cri.keyword == 'Y'}">
					  		<select name="keyword">
						      <option value="Y" selected>판매가능</option>
						      <option value="N">판매불가</option>
						    </select>
					  	</c:if>
					  	<c:if test="${pageMaker.cri.keyword == 'N'}">
					  		<select name="keyword">
						      <option value="Y">판매가능</option>
						      <option value="N" selected>판매불가</option>
						    </select>
					  	</c:if>
					  	<c:if test="${pageMaker.cri.keyword != 'N' and pageMaker.cri.keyword != 'Y'}">
				  			<input type="text" id="keywordTag" name="keyword" value="${pageMaker.cri.keyword}">
					  	</c:if>
					  	<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
					  	<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
					  	<button type="button" id="btnSearch" class="btn btn-info">Search</button>
					  </form>
					  <button type="button" name="btnDeleteCheck" class="btn btn-link">선택 삭제(체크 확인)</button>
					
					
					  <table class="table table-hover">
						  <thead>
						    <tr>
						      <th scope="col"><input type="checkbox" id="checkAll" name="checkAll"></th>
						      <th scope="col">주문 번호</th>
						      <th scope="col">주문일시</th>
						      <th scope="col">수령인 / 주문자 아이디 </th>
						      <th scope="col">주문금액 / 배송비</th>
						      <th scope="col">결제 상태</th>
						      <th scope="col">배송 상태</th>
						      <th scope="col">주문 관리</th>
						    </tr>
						  </thead>
						  <tbody>
						  <c:forEach items="${orderList}" var="ordertVO">
						    <tr>
						      <!-- 비고 -->
						      <td scope="row"><input type="checkbox" class="check" value="${ordertVO.o_code }"></td>	
						      <!-- 주문 번호 -->
						      <td><c:out value="${ordertVO.o_code}" /></td>
						      <!-- 주문일시 -->				      
						      <td>
						      	<fmt:formatDate value="${ordertVO.o_date}" pattern="yyyy-MM-dd hh:mm:ss"/>
						      </td>							  
						      <!-- 수령인 / 주문자 아이디 -->
						      <td><c:out value="${ordertVO.o_name}" /> / <c:out value="${ordertVO.m_userid}" /></td>
						      <!-- 주문금액 / 배송비 -->
						      <td><c:out value="${ordertVO.o_totalcost}"/></td>
						      <!-- 결제 상태 -->
						      <td><c:out value="${ordertVO.pay_status}" /></td>
						      <!-- 배송상태 -->
						      <td>
						      	<select class="form-control" id="o_status" name="o_status">
							      <option value="주문접수"${ordertVO.o_status eq '주문접수' ? 'selected' : ''}>주문접수</option>
							      <option value="배송준비중"${ordertVO.o_status eq '배송준비중' ? 'selected' : ''}>배송 준비 중</option>
							      <option value="배송보류"${ordertVO.o_status eq '배송보류' ? 'selected' : ''}>배송 보류</option>
							      <option value="배송대기"${ordertVO.o_status eq '배송대기' ? 'selected' : ''}>배송 대기</option>
							      <option value="배송중"${ordertVO.o_status eq '배송중' ? 'selected' : ''}>배송 중</option>
							      <option value="배송완료"${ordertVO.o_status eq '배송완료' ? 'selected' : ''}>배송 완료</option>
							      <option value="주문취소"${ordertVO.o_status eq '주문취소' ? 'selected' : ''}>주문 취소</option>
							      <option value="취소요청"${ordertVO.o_status eq '취소요청' ? 'selected' : ''}>취소 요청</option>
							      <option value="취소완료"${ordertVO.o_status eq '취소완료' ? 'selected' : ''}>취소 완료</option>
							      <option value="교환요청"${ordertVO.o_status eq '교환요청' ? 'selected' : ''}>교환 요청</option>
							      <option value="교환완료"${ordertVO.o_status eq '교환완료' ? 'selected' : ''}>교환 완료</option>
							    </select>
							    <button type="button" name="btnChangeOrderStatus" data-o_code="${ordertVO.o_code }" class="btn btn-link">변경</button>
						      </td>
						      <!-- 주문 관리 -->						      
						      <td><button type="button" name="btnOrderDetail" data-o_code="${ordertVO.o_code}" class="btn btn-link">주문 상세</button></td>
						      
						     </tr>
						   </c:forEach> 
						   
						  </tbody>
						</table>
						<nav aria-label="...">
						  <ul class="pagination justify-content-center">
						  
						  	<%-- 이전표시 --%>
						  	<c:if test="${pageMaker.prev}">
							    <li class="page-item">
							      <a class="page-link" href="${pageMaker.startPage-1}">이전</a>
							    </li>
						    </c:if>
						    
						    <%-- 페이지 번호 표시 ( 1 2 3 4 5) --%>
						    <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="num">
						    	<li class='page-item ${pageMaker.cri.pageNum == num ? "active" : ""}'><a class="page-link" href="${num}">${num}</a></li>
						    </c:forEach>
						
						    
						    <%-- 다음표시 --%>
						    <c:if test="${pageMaker.next}">
							    <li class="page-item">
							      <a class="page-link" href="${pageMaker.endPage +1}">다음</a>
							    </li>
						    </c:if>   
						  </ul>
						  
						  <%--- 페이지 번호 클릭시(/admin/product/productList)
								상품 수정버튼 클릭 시(수정주소)
								   - 상품코드 추가
								상품 삭제버튼 클릭 시(삭제주소)
								   - 상품코드 추가 --%>
						  <form id="actionForm" action="/admin/product/productList" method="get">
								<%-- 페이지 번호 클릭시 list주소로 보낼 파라미터 작업 - model 덕분에 ${pageMaker.cri.___} 사용 가능 --%>
								<input type="hidden" name="pageNum" value="${cri.pageNum}">
								<input type="hidden" name="amount" value="${cri.amount}">
								<input type="hidden" name="type" value="${cri.type}">
								<input type="hidden" name="keyword" value="${cri.keyword}">
								<%-- 한 번 검색하면 list()메소드에 Criteria cri 에 값이 들어가게 되어 위 사용 가능 --%>
							</form>
						</nav>
      			</div>		
      		</div>     
      	</div>      
      </div>

    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->

  <!-- Main Footer -->
  <%@include file="/WEB-INF/views/admin/include/footer.jsp" %>

  <!-- Control Sidebar -->
  <aside class="control-sidebar control-sidebar-dark">
    <!-- Create the tabs -->
    <ul class="nav nav-tabs nav-justified control-sidebar-tabs">
      <li class="active"><a href="#control-sidebar-home-tab" data-toggle="tab"><i class="fa fa-home"></i></a></li>
      <li><a href="#control-sidebar-settings-tab" data-toggle="tab"><i class="fa fa-gears"></i></a></li>
    </ul>
    <!-- Tab panes -->
    <div class="tab-content">
      <!-- Home tab content -->
      <div class="tab-pane active" id="control-sidebar-home-tab">
        <h3 class="control-sidebar-heading">Recent Activity</h3>
        <ul class="control-sidebar-menu">
          <li>
            <a href="javascript:;">
              <i class="menu-icon fa fa-birthday-cake bg-red"></i>

              <div class="menu-info">
                <h4 class="control-sidebar-subheading">Langdon's Birthday</h4>

                <p>Will be 23 on April 24th</p>
              </div>
            </a>
          </li>
        </ul>
        <!-- /.control-sidebar-menu -->

        <h3 class="control-sidebar-heading">Tasks Progress</h3>
        <ul class="control-sidebar-menu">
          <li>
            <a href="javascript:;">
              <h4 class="control-sidebar-subheading">
                Custom Template Design
                <span class="pull-right-container">
                    <span class="label label-danger pull-right">70%</span>
                  </span>
              </h4>

              <div class="progress progress-xxs">
                <div class="progress-bar progress-bar-danger" style="width: 70%"></div>
              </div>
            </a>
          </li>
        </ul>
        <!-- /.control-sidebar-menu -->

      </div>
      <!-- /.tab-pane -->
      <!-- Stats tab content -->
      <div class="tab-pane" id="control-sidebar-stats-tab">Stats Tab Content</div>
      <!-- /.tab-pane -->
      <!-- Settings tab content -->
      <div class="tab-pane" id="control-sidebar-settings-tab">
        <form method="post">
          <h3 class="control-sidebar-heading">General Settings</h3>

          <div class="form-group">
            <label class="control-sidebar-subheading">
              Report panel usage
              <input type="checkbox" class="pull-right" checked>
            </label>

            <p>
              Some information about this general settings option
            </p>
          </div>
          <!-- /.form-group -->
        </form>
      </div>
      <!-- /.tab-pane -->
    </div>
  </aside>
  <!-- /.control-sidebar -->
  <!-- Add the sidebar's background. This div must be placed
  immediately after the control sidebar -->
  <div class="control-sidebar-bg"></div>
</div>
<!-- ./wrapper -->

<!-- REQUIRED JS SCRIPTS -->

<!-- jQuery 3, Bootstrap 3.3.7, AdminLTE App -->
<%@include file="/WEB-INF/views/admin/include/plugin2.jsp" %>

<!-- Optionally, you can add Slimscroll and FastClick plugins.
     Both of these plugins are recommended to enhance the
     user experience. -->

     <script>

        $(document).ready(function(){

          //주문 상태 변경 작업
          $("button[name='btnChangeOrderStatus']").on("click", function(){
            //console.log("변경 버튼 클릭");

            //주문 번호, 선택한 배송상태 값
            let o_code = $(this).data("o_code");
            let o_status = $(this).parent().find("select#o_status option:selected").val();

            // console.log("주문 번호: " + o_code + " 배송상태: " + o_status);

            $.ajax({
              url: '/admin/order/orderStatusChange',
              method: 'get',
              data: {o_code : o_code, o_status : o_status},
              dataType: 'text',
              success: function(result) {
                if(result == "success"){
                  alert("배송 상태가 변경 되었습니다.")
                }
              }
            });
          });

          //체크박스 전체선택(제목 행 체크박스)
          let isCheck = true;
          $("#checkAll").on("click", function(){
            
            $(".check").prop("checked", this.checked);
            //attr()메소드 사용 X

            isCheck = this.checked;
          });

          //데이터 행 체크박스
          $(".check").on("click", function(){

            //데이터 행의 체크박스가 전부 체크되어있다면 전체선택 체크박스도 체크!
            $("#checkAll").prop("checked", this.checked);

            //데이터 행의 체크박스의 선택자 해당하는 만큼 동작하는 구문
            $(".check").each(function() {
              if(!$(this).is(":checked")) {
                //체크가 하나라도 존재
                $("#checkAll").prop("checked", false);
              }
            });
          });

          //선택한 주문 삭제하기
          $("button[name='btnDeleteCheck']").on("click", function(){

            if($(".check:checked").length == 0){
              alert("삭제할 주문정보를 선택하세요.");
              return;
            }

            let isOrderDel = confirm("선택하신 주문목록을 삭제하시겠습니까?");
            if(!isOrderDel) return;

            //삭제할 주문번호 배열로 받기
            let oCodeArr = [];
            $(".check:checked").each(function(){
              oCodeArr.push($(this).val());
            });

            // console.log("선택된 주문번호: " + oCodeArr);

            $.ajax({
              url: '/admin/order/deleteCheckOrder',
              type: 'post',
              dataType: 'text',
              data: {
                oCodeArr : oCodeArr
              },
              success: function(result) {
                if(result == "success") {
                  alert("선택하신 주문 목록이 삭제되었습니다.");

                  location.href="/admin/order/orderList";
                }
              }
            });

          });







          //actionForm 참조 (상품 수정, 상품 삭제, 페이지 번호)
          let actionForm = $("#actionForm");

          //상품 수정 버튼 클릭 시
          $("button[name='btnProductEdit']").on("click", function(){

            //상품 목록 중 선택한 목록
            console.log("상품코드: " + $(this).data("p_num"));

            //상품코드를 자식으로 추가
            actionForm.append("<input type='hidden' name='p_num' value='" + $(this).data("p_num") + "'>");
            
            //폼태그 주소 변경
            actionForm.attr("action", "/admin/product/productModify");

            actionForm.submit();

          });

          //상품 삭제 버튼 클릭 시          
          $("button[name='btnProductDelete']").on("click", function(){

            //상품 목록 중 선택한 목록
            //console.log("상품코드: " + $(this).data("p_num"));

            if(!confirm($(this).data("p_num") + "번 상품을 삭제하시겠습니까?")) {
              return;
            }

            //날짜 폴더와 파일 이름 추가
            let p_image_dateFolder = $(this).siblings("input[name='p_image_dateFolder']").val();
            //let p_image_dateFolder = $(this).parent().children("input[name='p_image_dateFolder']").val();
            let p_image = $(this).siblings("input[name='p_image']").val();
            //console.log("날짜 폴더: " + p_image_dateFolder)

            actionForm.append("<input type='hidden' name='p_image_dateFolder' value='" + p_image_dateFolder + "'>");
            actionForm.append("<input type='hidden' name='p_image' value='" + p_image + "'>");

            //상품코드를 자식으로 추가
            actionForm.append("<input type='hidden' name='p_num' value='" + $(this).data("p_num") + "'>");

            //폼태그 주소 변경
            actionForm.attr("action", "/admin/product/deleteProduct");

            actionForm.submit();

            });

          let searchForm = $("#searchForm");

          //검색버튼 클릭 시 pageNum 1로 초기화
          $("#btnSearch").on("click", function(){
            //searchForm.children("input[name='pageNum']").val(1);
            searchForm.find("input[name='pageNum']").val(1);
            searchForm.submit();
          });

          //페이지 번호 클릭
          $("ul.pagination li a.page-link").on("click", function(e){

            e.preventDefault();

            let pageNum = $(this).attr("href");
            //console.log("pageNum: " + pageNum )

            //pageNum 필드는 acttionForm에 수동으로 작업되어 있어 추가하는 것이 아니라 참조하여 값을 변경
            actionForm.find("input[name='pageNum']").val(pageNum);
            actionForm.submit();
          });
          
          $("#selectType").change(function(){

              let result = $("#selectType option:selected").val();
              console.log(result);

              let buyYN = "<select id='buyCan' name='keyword'><option value='Y'>판매가능</option><option value='N'>판매불가</option></select>"
              
              
              $(this).parent().find("input[name='keyword']").val("");
              $(this).parent().find("input[name='keyword']").remove();
              $(this).parent().find("select[name='keyword']").remove();

              if(result == "Y") {
                $(this).after(buyYN);  
               
                
              } else  {
                // $(this).parent().find("input[name='keyword']").val("");
                $(this).after("<input type='text' id='keywordTag' name='keyword' value='${pageMaker.cri.keyword}'>");
                
                $("#buyCan").remove();
                
              }

              $(this).parent().find("input[name='keyword']").val("");
              
            }); 

        });
    </script>
</body>
</html>