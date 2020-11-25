<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.sql.*" %>
<%@ page import="test.db.DBConnection" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
String id = request.getParameter("id");

Connection con = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
boolean result = false;

try{
	con = DBConnection.getCon();
	String sql = "select * from member where id=?";
	pstmt = con.prepareStatement(sql);
	pstmt.setString(1,id);
	rs=pstmt.executeQuery();
	if(rs.next()){
		result = true;
	}
}catch(Exception e){
	out.println("DB 연동 오류입니다. : " + e.getMessage());
}finally{
	rs.close();
	pstmt.close();
	con.close();
}
response.setContentType("text/xml;charset=utf-8");
PrintWriter pw = response.getWriter();
pw.println("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
pw.println("<data>");
pw.println("<result>" + result + "</result>");
pw.println("</data>");
pw.close();
%>
</body>
</html>