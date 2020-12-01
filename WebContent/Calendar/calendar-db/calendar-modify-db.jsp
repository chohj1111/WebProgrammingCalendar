<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.ParseException" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.util.Date" %>
<%@ page import="connection.DBConnection" %> 

<% request.setCharacterEncoding("utf-8"); %>
<html>
<body>
<%
String id,title,color,startdate, enddate, memo,user_id; 
Connection conn = null;
PreparedStatement pstmt = null;
Statement stmt = null;
ResultSet rs = null;
String sql_update;

String redirectURL = "../../LoginScreen/loginscreen.jsp";

id=request.getParameter("id");
title=request.getParameter("title");
color=request.getParameter("color");
startdate = request.getParameter("startdate");
enddate = request.getParameter("enddate");
memo = request.getParameter("memo");
user_id = request.getParameter("user_id");

try{
	conn = DBConnection.getCon();
	sql_update = "update plan set title=?,color=?,startdate=?,enddate=?,memo=? where id=? and user_id=?";
	pstmt = conn.prepareStatement(sql_update);
	pstmt.setString(1,title);
	pstmt.setString(2,color);
	pstmt.setString(3,startdate);
	pstmt.setString(4,enddate);
	if(memo!=null) pstmt.setString(5,memo);
	else pstmt.setNull(5,Types.VARCHAR);
	pstmt.setString(6,id);
	pstmt.setString(7,user_id);
	pstmt.executeUpdate();


}	// redirection 필요
catch(Exception e) {
	out.println("DB 연동 오류입니다. : " + e.getMessage());
}
// back to calendar
redirectURL = "../calendar.jsp"; 
response.sendRedirect(redirectURL);
%>
</body>
</html>