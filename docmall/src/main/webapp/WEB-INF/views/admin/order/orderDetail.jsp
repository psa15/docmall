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
      				LIST ORDER DETAIL    
      			</div>	
      			<div class="box-body">
      			<h3>주문 상세 조회</h3>
      			
      			  <h5 style="color:red; font-weight:bold">주문 정보</h5>
				  <table class="table table-bordered">
					  <thead>
					    <tr>
					      <th scope="col">주문번호</th>
					      <td scope="col">${orderInfo.o_code}</td>
					    </tr>
					  </thead>
					  <tbody>
					    <tr>
					      <th scope="col">주문일자</th>
					      <td scope="col"><fmt:formatDate value="${orderInfo.o_date}" pattern="yyyy-MM-dd hh:mm:ss"/></td>
					    </tr>
					    <tr>
					      <th scope="col">주문자</th>
					      <td scope="col">${orderInfo.o_name}</td>
					    </tr>
					    <tr>
					      <th scope="col">주문 처리 상태</th>
					      <td scope="col">${orderInfo.o_status}</td>
					    </tr>
					  </tbody>
					</table>
					
					<h5 style="color:red; font-weight:bold">결제 정보</h5>
					  <table class="table table-bordered">
						  <thead>
						    <tr>
						      <th scope="col">총 주문 금액</th>
						      <td scope="col">${paymentInfo.pate_tot_price}</td>
						    </tr>
						  </thead>
						  <tbody>
						    <tr>
						      <th scope="col">총 결제 금액</th>
						      <td scope="col">${paymentInfo.pate_tot_price}</td>
						    </tr>
						    <tr>
						      <th scope="col">결제 수단</th>
						      <td scope="col">${paymentInfo.pay_method}</td>
						    </tr>
						  </tbody>
						</table>
						
						<h5 style="color:red; font-weight:bold">주문 상품 정보</h5>
							<table class="table table-bordered">
						  <thead>
						  <!--  -->
						    <tr>
						      <th scope="col">이미지</th>
						      <th scope="col">상품 정보</th>
						      <th scope="col">수량</th>
						      <th scope="col">상품 금액</th>
						      <th scope="col">주문 처리 상태</th>
						      <th scope="col">취소/교환/반품</th>
						    </tr>
						  </thead>
						  <tbody>
						  	<c:forEach items="${orderProductMap }" var="orderProduct">
							    <tr>
							    <!-- MAP의 키를 대문자로 입력 -->
							      
							      <td scope="col">
								      <img src="/admin/product/displayFile?folderName=${orderProduct.P_IMAGE_DATEFOLDER }&fileName=s_${orderProduct.P_IMAGE }" 
							      		alt="" style="width: 80px; height: 80px" onerror="this.onerror=null; this.src='/image/no_image.png'">
							      		 
							      </td>
							      <td scope="col">${orderProduct.P_NAME}</td>
							      <td scope="col">${orderProduct.O_AMOUNT}</td>
							      <td scope="col">${orderProduct.O_UNITPRICE}</td>
							      <td scope="col">${orderProduct.O_STATUS}</td>
							      <td scope="col">
							      	<button type="button" id="btnCancelProduct" class="btn btn-link">취소</button>
							      </td>
							    </tr>
						    </c:forEach>
						  </tbody>
						</table>					
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

        });
    </script>
</body>
</html>