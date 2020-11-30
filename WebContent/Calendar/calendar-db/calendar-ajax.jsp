<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="connection.DBConnection" %>
<html>
<body>
<%
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String redirectURL = "../calendar.jsp";
	
	String title = request.getParameter("title");
	String startdate = request.getParameter("startdate");
	String enddate = request.getParameter("enddate");
	String id = request.getParameter("id");
	String user_id = request.getParameter("user_id");
	try{
		con = DBConnection.getCon();
		String sql="update plan set title=?,startdate=?,enddate=?  where id=? and user_id=?";
		pstmt = con.prepareStatement(sql);
		
		pstmt.setString(1,title);
		pstmt.setString(2,startdate);
		pstmt.setString(3,enddate);
		pstmt.setString(4,id);
		pstmt.setString(5,user_id);
		
		rs=pstmt.executeQuery();
	}catch(Exception e){
		out.println("DB 연동 오류입니다. : " + e.getMessage());
	}finally{
		rs.close();
		pstmt.close();
		con.close();
		response.sendRedirect(redirectURL);
	}
	
%>
</body>
</html>