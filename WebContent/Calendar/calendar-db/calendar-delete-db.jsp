<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="connection.DBConnection" %>

<% request.setCharacterEncoding("utf-8"); %>
<html>
<body>
<%
Connection conn = null;
PreparedStatement pstmt = null;
Statement stmt = null;
ResultSet rs = null;
String sql_update;

String redirectURL = "../../LoginScreen/loginscreen.jsp";

String id=request.getParameter("id");

try{
	conn = DBConnection.getCon();
	sql_update = "delete from plan where id=?";
	pstmt = conn.prepareStatement(sql_update);
	pstmt.setString(1,id);
	pstmt.executeUpdate();
}catch(Exception e){
%>
	alert("DB 연동 오류입니다! : "+e.getMessage()));
	response.sendRedirect(redirectURL);
<% 
}
// back to calendar
redirectURL = "../calendar.jsp"; 

response.sendRedirect(redirectURL);

%>

</body>
</html>