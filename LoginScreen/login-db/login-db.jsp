<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<% request.setCharacterEncoding("utf-8"); %>
<html>
<body>
<%
String id, pw;
Connection conn = null;
Statement stmt = null;
ResultSet rs = null;
String sql;

id = request.getParameter("id");
pw = request.getParameter("pw");
String redirectURL = "../loginscreen.jsp";

try{
	Class.forName("com.mysql.jdbc.Driver");
	String url = "jdbc:mysql://localhost:3306/mycal?serverTimezone=UTC";
	conn = DriverManager.getConnection(url, "root", "0000");
	stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	sql = "select id, pw from member where id='"+id+"'";
	rs = stmt.executeQuery(sql);
	
	if(rs.next()) {	
		if(pw.equals(rs.getString("pw"))){
			redirectURL = "login-suc.jsp";
			out.println("<script>location.href='"+redirectURL+"';</script>");
		}
	}
		
	out.println("<script>alert('가입되지 않은 아이디이거나, 잘못된 비밀번호입니다');</script>");
	out.println("<script>location.href='"+redirectURL+"';</script>");
	
	rs.close();
	conn.close();
	stmt.close();
	
}
catch(Exception e) {
	out.println("DB 연동 오류입니다. : " + e.getMessage());
}
%>
</body>
</html>