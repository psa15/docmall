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
	  <h1 class="display-4">Pricing</h1>
	  <p class="lead">Quickly build an effective pricing table for your potential customers with this Bootstrap example. It’s built with default Bootstrap components and utilities with little customization.</p>
	</div>
	
	<div class="container">
	  <div class="card-deck mb-3 text-center">
	    <div class="card mb-4 shadow-sm">
	      <div class="card-header">
	        <h4 class="my-0 font-weight-normal">Free</h4>
	      </div>
	      <div class="card-body">
	        <h1 class="card-title pricing-card-title">$0 <small class="text-muted">/ mo</small></h1>
	        <ul class="list-unstyled mt-3 mb-4">
	          <li>10 users included</li>
	          <li>2 GB of storage</li>
	          <li>Email support</li>
	          <li>Help center access</li>
	        </ul>
	        <button type="button" class="btn btn-lg btn-block btn-outline-primary">Sign up for free</button>
	      </div>
	    </div>
	    <div class="card mb-4 shadow-sm">
	      <div class="card-header">
	        <h4 class="my-0 font-weight-normal">Pro</h4>
	      </div>
	      <div class="card-body">
	        <h1 class="card-title pricing-card-title">$15 <small class="text-muted">/ mo</small></h1>
	        <ul class="list-unstyled mt-3 mb-4">
	          <li>20 users included</li>
	          <li>10 GB of storage</li>
	          <li>Priority email support</li>
	          <li>Help center access</li>
	        </ul>
	        <button type="button" class="btn btn-lg btn-block btn-primary">Get started</button>
	      </div>
	    </div>
	    <div class="card mb-4 shadow-sm">
	      <div class="card-header">
	        <h4 class="my-0 font-weight-normal">Enterprise</h4>
	      </div>
	      <div class="card-body">
	        <h1 class="card-title pricing-card-title">$29 <small class="text-muted">/ mo</small></h1>
	        <ul class="list-unstyled mt-3 mb-4">
	          <li>30 users included</li>
	          <li>15 GB of storage</li>
	          <li>Phone and email support</li>
	          <li>Help center access</li>
	        </ul>
	        <button type="button" class="btn btn-lg btn-block btn-primary">Contact us</button>
	      </div>
	    </div>
	  </div>
	
	  <!-- footer -->
	  <%@include file="/WEB-INF/views/include/footer.jsp" %>
	</div>
	

    
  </body>
</html>
