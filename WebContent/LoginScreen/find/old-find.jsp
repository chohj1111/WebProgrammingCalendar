<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="certification.mail.DoCompare" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="find.js"></script>
</head>
<body>
아이디  찾기<br>
<form action="certification/certification.jsp" method="post" target="iframe1">
	<input id="email"  onkeyup="emailCheck(email)" type="text" id="email" name="email" placeholder="이메일">
	<button type="submit" id="submit_btn_id" disabled="disabled">아이디 찾기</button><br>
	<span id="emailCheck"></span>
</form>
<iframe style="border:0px; width:300px; height:150px;" name="iframe1"></iframe><br>
비밀번호 찾기

<form action="certification/findpw.jsp" method="post" target="iframe2">
	<input type="text" id="findpw_id" name="id" onkeyup="idCheck(findpw_id)" placeholder="아이디">
	<button type="submit" id="submit_btn_pw" disabled="disabled">비밀번호 찾기</button><br>
	<span id="idCheck"></span>
</form>
<iframe style="border:0px; width:300px; height:150px;" name="iframe2"></iframe><br>
</body>
</html>