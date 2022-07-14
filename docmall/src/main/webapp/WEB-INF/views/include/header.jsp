<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="d-flex flex-column flex-md-row align-items-center p-3 px-md-4 mb-3 bg-white border-bottom shadow-sm">
  <h5 class="my-0 mr-md-auto font-weight-normal">DocMall</h5>
  <nav class="my-2 my-md-0 mr-md-3">
  	<!-- 로그인 이전 -->
  	<c:if test="${sessionScope.loginStatus == null}">
    	<a class="p-2 text-dark" href="/member/login">LOGIN</a> |
    	<a class="p-2 text-dark" href="/member/join">JOIN</a> |
    </c:if>
    
    <!-- 로그인 후 -->
    <c:if test="${sessionScope.loginStatus != null}">
    	<a class="p-2 text-dark" href="/member/logout">LOGOUT[${sessionScope.loginStatus.m_userid}]</a> |
    	<a class="p-2 text-dark" href="/member/confirmPw">MODIFY</a> |
    </c:if>
    
    <!-- 공통 -->
    <!-- mypage는 로그인을 하든 안하든 보여주고, 로그인을 했을 때만 포인트를 보여주기 위해 안에 if문 사용 -->
    <a class="p-2 text-dark" href="#">MYPAGE
    	<c:if test="${sessionScope.loginStatus != null}">
    		<span style="color:red">포인트: [${sessionScope.loginStatus.m_point}]</span>
    	</c:if>
    </a> |
    <a class="p-2 text-dark" href="#">ORDER</a> |
    <a class="p-2 text-dark" href="#">CART</a>
  </nav>
</div>