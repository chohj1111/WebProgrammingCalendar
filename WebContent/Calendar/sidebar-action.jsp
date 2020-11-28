<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
</head>
<body>
	<%
		String act = request.getParameter("act");
		if(act.equals("logout")) {
			String redirectURL = "../LoginScreen/loginscreen.jsp";
			session.invalidate();
			out.println("<script>location.href='"+redirectURL+"';</script>");
		}
	%>
</body>
</html>