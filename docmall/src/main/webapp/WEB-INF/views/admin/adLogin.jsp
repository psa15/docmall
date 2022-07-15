<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>  
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>AdminLTE 2 | Starter</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">  
  
  <%@include file="/WEB-INF/views/admin/include/plugin1.jsp" %>
  
  <link rel="stylesheet" href="/resources/css/adLogin.css">

  <script>
  	//rttr.addFlashAttribute("msg", msg); 이렇게 코드를 작성했기 때문에 선언 필요
  	//let msg = "${msg}";
  	
  	if("${msg}" == "noPw") {
  		alert("비밀번호를 확인해 주세요.");
  	} else if("${msg}" == "noID") {
  		alert("아이디를 확인해 주세요.");
  	}
  </script>
</head>
<body>
<div class="main">
	<div class="container">
		<div style="text-align: center;">
			<div class="middle">
			
			<div id="login">
				<form action="login" method="post">
					<fieldset class="clearfix">
					<p>
						<span class="fa fa-user"></span>
						<input type="text" name="admin_id"  Placeholder="AdminID" required>
					</p> <!-- JS because of IE support; better: placeholder="Username" -->
					<p>
						<span class="fa fa-lock"></span>
						<input type="password" name="admin_pw" Placeholder="Password" required>
					</p> <!-- JS because of IE support; better: placeholder="Password" -->
					<div>
						<span style="width:48%; text-align:left;  display: inline-block;">
							<a class="small-text" href="#">Forgot password?</a>
						</span>
						<span style="width:50%; text-align:right;  display: inline-block;">
							<input type="submit" value="Sign In">
						</span>
					</div>
					
					</fieldset>
					<div class="clearfix"></div>
				</form>
				<div class="clearfix"></div>
			</div> <!-- end login -->
			
			<div class="logo">LOGO
				<div class="clearfix"></div>
			</div>
			</div>
		</div>
	</div>

</div>
</body>
</html>