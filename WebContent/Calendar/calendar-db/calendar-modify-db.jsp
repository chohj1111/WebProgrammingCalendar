<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>


<% request.setCharacterEncoding("utf-8"); %>
<html>
<body>
<%
String id,title,color,startdate, enddate, memo; 
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


try{
	Class.forName("com.mysql.jdbc.Driver");
	String url = "jdbc:mysql://localhost:3306/mycal?serverTimezone=UTC";
	conn = DriverManager.getConnection(url, "root", "0000");
	sql_update = "update plan set title=?,color=?,startdate=?,enddate=?,memo=? where id=?";
	pstmt = conn.prepareStatement(sql_update);
	pstmt.setString(1,title);
	pstmt.setString(2,color);
	pstmt.setString(3,startdate);
	pstmt.setString(4,enddate);
	if(memo!=null) pstmt.setString(5,memo);
	else pstmt.setNull(5,Types.VARCHAR);
	pstmt.setString(6,id);
	pstmt.executeUpdate();

}catch(Exception e){
%>
	<script language = "javascript">
		alert("DB 연동 오류입니다! : "+e.getMessage());
		response.sendRedirect(redirectURL);
	</script>
	
<% 
}
// back to calendar
redirectURL = "../calendar.jsp"; 

response.sendRedirect(redirectURL);

%>

</body>
</html>