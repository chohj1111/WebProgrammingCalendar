<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.*" %>
<%@page import="connection.DBConnection" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="notice.css">
</head>
<body>
<%
Connection conn = null;
Statement stmt = null;
ResultSet rs = null;
String sql = null;
String user_id = (String)session.getAttribute("user_id");
try{
	conn = DBConnection.getCon();
	stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	sql = "select info from notice where id = '"+user_id+"'";
	rs = stmt.executeQuery(sql);
}catch(Exception e){
	out.println("DB 연동 오류입니다.:"+e.getMessage());
}
while(rs.next()){
	out.println(rs.getString("info"));
}
%>
</body>
</html>