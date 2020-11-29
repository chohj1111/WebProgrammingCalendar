<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="certification.mail.DoCompare" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action="compare.jsp" method="post" >
	<input name="userInput" type="text" placeholder="인증번호 입력">
	<input type="hidden" name="email" value=<%=(String)session.getAttribute("email") %>>
	<input type="hidden" name="id" value=<%=(String)session.getAttribute("id") %>>
	<button id="check" type="submit">인증번호확인</button><br>
</form>
</body>
</html>