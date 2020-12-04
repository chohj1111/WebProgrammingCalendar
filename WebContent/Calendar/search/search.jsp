<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ page import="java.sql.*"%>
    <%@ page import="java.text.*" %>
    <%@page import="connection.DBConnection" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link rel="stylesheet" type="text/css" href="search.css">
<script type="text/javascript" src='../lib/jquery-3.5.1.min.js'></script>
<script type="text/javascript" src='search.js'></script>
<title>Insert title here</title>
</head>
<body>
<%
Connection conn = null;
Statement stmt = null;
ResultSet rs = null;
String sql = null;
String search_word = request.getParameter("search_word");
String user_id = (String)session.getAttribute("user_id");
try{
	conn = DBConnection.getCon();
	stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	sql = "select title, startdate, memo from plan where title like '%"
	+search_word+"%' and user_id='"+user_id+"' order by startdate desc";
	rs = stmt.executeQuery(sql);
}catch(Exception e){
	out.println("DB 연동 오류입니다.:"+e.getMessage());
}
%>
<div class="search_wrap">
	<ul>
<%
while(rs.next()){
	%><li><a class="title"><%
		out.println(rs.getString("title")+" ");
		%></a><span class="li_memo"><% out.println(rs.getString("memo")); %></span><div class="li_date"><%
			out.println(rs.getString("startdate"));
		%></div><%
	%></li><%
}
%>	</ul>
</div>
</body>
</html>