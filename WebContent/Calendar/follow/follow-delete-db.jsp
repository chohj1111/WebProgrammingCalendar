<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="connection.DBConnection" %>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
</head>
<body>
	<%
		String redirectURL = "../calendar.jsp"; 
		String myID = (String)request.getParameter("myID");
		String targetID = (String)request.getParameter("targetID");
		
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;

		String sql = "delete from follow where follower='"+myID+"' and followed='"+targetID+"'";
		
		try {
			conn = DBConnection.getCon();		
		    stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			stmt.executeUpdate(sql);
			%>
			<script>
				alert("팔로우를 취소했습니다.");
				window.location.href="<%=redirectURL%>";
			</script>
			<%
		}
		catch(Exception e){
			out.println("DB 연동 오류입니다.:"+e.getMessage());
		}	
	%>
</body>
</html>