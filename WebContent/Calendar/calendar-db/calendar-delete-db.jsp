<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>


<% request.setCharacterEncoding("utf-8"); %>
<html>
<body>
<%
String id; 
Connection conn = null;
PreparedStatement pstmt = null;
Statement stmt = null;
ResultSet rs = null;
String sql_update;

String redirectURL = "../../LoginScreen/loginscreen.jsp";

id=request.getParameter("id");

try{
	Class.forName("com.mysql.jdbc.Driver");
	String url = "jdbc:mysql://localhost:3306/mycal?serverTimezone=UTC";
	conn = DriverManager.getConnection(url, "root", "0000");
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