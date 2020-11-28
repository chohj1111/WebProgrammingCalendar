<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>


<% request.setCharacterEncoding("utf-8"); %>
<html>
<body>
<%

String id,title,color,startdate, enddate, memo,user_id; 
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
String sql_update;

String redirectURL = "../../LoginScreen/loginscreen.jsp";

title=request.getParameter("title");
color=request.getParameter("color");
startdate = request.getParameter("startdate");
enddate = request.getParameter("enddate");
memo = request.getParameter("memo");
user_id = request.getParameter("user_id");
	try{	
		Class.forName("com.mysql.jdbc.Driver");
		String url = "jdbc:mysql://localhost:3306/mycal?serverTimezone=UTC";
		conn = DriverManager.getConnection(url, "root", "0000");
		sql_update = "insert into plan(title,color,startdate,enddate,memo,user_id) values(?,?,?,?,?,?)";
		pstmt = conn.prepareStatement(sql_update);
		pstmt.setString(1,title);
		pstmt.setString(2,color);
		pstmt.setString(3,startdate);
		pstmt.setString(4,enddate);
		if(memo!=null) pstmt.setString(5,memo);
		else pstmt.setNull(5,Types.VARCHAR);
		pstmt.setString(6,user_id);
		pstmt.executeUpdate();
		
	}
	// redirection 필요
	catch(Exception e) {
%>
		<script type="text/javascript">
    		alert("DB 연동 오류입니다.");
		</script> 
<% 
		//response.sendRedirect(redirectURL);
	}
	// back to calendar
	redirectURL = "../calendar.jsp"; 
	response.sendRedirect(redirectURL);
%>
	

</body>
</html>