<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<html>
<head>
<meta charset="UTF-8">
<link href="loginscreen.css" rel="stylesheet" type="text/css">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Jua&display=swap" rel="stylesheet">
<title>웹 캘린더 로그인 화면입니다. </title>
</head>
<body>
	<div class="daemoon">
		<img src="image/daemoon.png" class="firstimage"> 
	</div>

	<div class="loginbox">
		<h1 class="calendarfont"> Web Calendar </h1> <br>
		<form action="login-db/login-db.jsp" method="post">
			<div class="id-wrap">	
				<input placeholder="User ID" type="text" name="id">
			</div>
			<div class="password-wrap">	
				<input placeholder="Input Password" type="password" name="pw">
			</div><br>
			<div class="login-fail-info">
				<%
					String msg = request.getParameter("msg");
					if(msg != null) { out.println(msg); } 
				%>
				&nbsp;
			</div>
			<div class="login-button-wrap">
				<button type="submit">로그인</button>
				<center><a href="register/register.jsp" class="sign-up">회원가입</a></center>
			</div>
			
		</form>
 	</div>

</body>
</html>