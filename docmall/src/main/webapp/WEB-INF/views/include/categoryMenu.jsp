<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
	
	<!-- 카테고리 -->
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
	  <a class="navbar-brand" href="/">DocMall</a>
	  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
	    <span class="navbar-toggler-icon"></span>
	  </button>
	
	  <div class="collapse navbar-collapse" id="navbarSupportedContent">
	    <ul class="navbar-nav mr-auto">
	      <!--  
	      <li class="nav-item active">
	        <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
	      </li>
	      <li class="nav-item">
	        <a class="nav-link" href="#">Link</a>
	      </li>
	      -->
	      <c:forEach items="${mainCategoryList}" var="categoryVO">
		      <li class="nav-item dropdown">
		      	<!-- 1차 카테고리 -->	      	
		        <a class="nav-link dropdown-toggle" href="${categoryVO.ct_code }" role="button" data-toggle="dropdown" aria-expanded="false" style="display: inline">
		          ${categoryVO.ct_name}
		        </a>	       	
		        <!-- 2차 카테고리 -->
		        <div class="dropdown-menu subCategory">
		        	<!-- script에서 추가 -->
		        </div>
		      </li>
	      </c:forEach>
	      <!--  
	      <li class="nav-item">
	        <a class="nav-link disabled">Disabled</a>
	      </li>
	      -->
	    </ul>
	    <form class="form-inline my-2 my-lg-0">
	      <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
	      <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
	    </form>
	  </div>
	</nav>

	<script>

		// $(document).ready(function(){}); 와 같은 의미
		$(function(){

			//1차 카테고리 클릭
			$("ul.navbar-nav li.nav-item a.nav-link").on("click", function(e){
			
				//ajax 작업 구문 사용시 이전에 필요한 선택자의 정보를 변수에 미리 저장해서 사용해야 함
				let selectedCategory = $(this);

				let url = "/user/product/subCategoryList/" + $(this).attr("href");
				//console.log("2차 카테고리: " + url);

				//result : 2차 카테고리 정보
				$.getJSON(url, function(result){
					//console.log("2차 카테고리 정보: " + selectedCategory.attr("href"));
					
					let subCategoryList = selectedCategory.next();
					
					//전에 선택한 1차 카테고리의 2차 카테고리 정보를 지우기
					subCategoryList.children().remove();

					let subCategoryStr = '';
					for(let i=0; i<result.length; i++) {
						
						/* 직접 주소 작업
						subCategoryStr += "<a class='dropdown-item' href='/product/productList/" + result[i].ct_code + "'>" + result[i].ct_name + "</a>";
						*/
						
						//jquery문법을 사용하여 이벤트 적용을 통한 주소 요청 작업
						subCategoryStr += "<a class='dropdown-item' href='" + result[i].ct_code + "'>" + result[i].ct_name + "</a>";
					}

					subCategoryList.append(subCategoryStr);
				});

/* 				$.ajax({
					url: '',
					data: '',
					dataType: 'json',
					success: function(result) {

					}
				}); */
			});

			//2차 카테고리 클릭
			$("ul.navbar-nav li.nav-item div.subCategory").on("click", "a", function(e){
				e.preventDefault();

				let ct_code = $(this).attr("href");
				let ct_name = $(this).text();
				//console.log(ct_name);
				location.href = "/user/product/userProductList/" + ct_code + "/" + encodeURIComponent(ct_name);

			});

		});

	</script>