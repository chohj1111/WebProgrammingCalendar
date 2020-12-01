<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="certification.mail.DoCompare" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="../find.css">
</head>
<body>
<br>
<form action="compare.jsp" method="post">
	<h5><%=(String)session.getAttribute("email") %><br>로 인증번호를 발송했습니다.</h5>
	<input name="userInput" type="text" placeholder="인증번호 입력"><br><br>
	<input type="hidden" name="email" value=<%=(String)session.getAttribute("email") %>>
	<input type="hidden" name="id" value=<%=(String)session.getAttribute("id") %>>
	<button id="check" type="submit" 
		class="btn btn-skyblue btn-block form-submit">인증번호 확인</button><br>
</form>
</body>
</html>