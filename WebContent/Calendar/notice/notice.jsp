<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.*" %>
<%@page import="connection.DBConnection" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
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
	sql = "select info, date from notice where id = '"+user_id+"' and isnew = '1' order by date desc";
	rs = stmt.executeQuery(sql);
}catch(Exception e){
	out.println("DB 연동 오류입니다.:"+e.getMessage());
}
%><h3>새로운 팔로워</h3><hr><br><%
while(rs.next()){
	%><span id="info"><%
		out.println(rs.getString("info"));
	%></span>
	<span id="date"><%
		out.println(rs.getString("date"));
	%></span><br><%
}
sql = "select info, date from notice where id = '"+user_id+"' and isnew = '0' order by date desc";
rs = stmt.executeQuery(sql);

while(rs.next()){
	%><span id="info"><%
		out.println(rs.getString("info"));
	%></span>
	<span id="date"><%
		out.println(rs.getString("date"));
	%></span><br><%
}
sql = "update notice set isnew='0' where id = '"+user_id+"'";
stmt.executeUpdate(sql);
%><br>모두 확인하였습니다.
</body>
</html>