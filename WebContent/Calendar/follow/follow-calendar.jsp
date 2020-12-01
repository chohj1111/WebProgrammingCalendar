<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<%
	String targetID = request.getParameter("id");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset='utf-8' />
<script>var targetID = "<%=targetID%>"</script>
<link href='../lib/main.css' rel='stylesheet' />
<script type="text/javascript" src='../lib/jquery-3.5.1.min.js'></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
<script type="text/javascript" src='../lib/jquery.modal.min.js'></script>
<link rel="stylesheet" type="text/css" href="../lib/jquery.modal.min.css">

<script type="text/javascript" src='../lib/main.js'></script>
<script type="text/javascript" src="follow-calendar.js"></script>
<link rel="stylesheet" type="text/css" href="../calendar.css">
<title><%=targetID %>님의 캘린더</title>
</head>
<body>
	<div id="f-calendar"></div>
</body>
</html>