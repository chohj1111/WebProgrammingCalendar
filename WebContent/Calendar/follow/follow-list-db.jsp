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
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		ResultSet rs2 = null;
		
		String myID = (String)request.getParameter("myID");
		String targetID = (String)request.getParameter("targetID");
		String sql = "select followed from follow where follower='"+myID+"'";
		String sql2;
		
		try {
			conn = DBConnection.getCon();	
		    stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
		    rs = stmt.executeQuery(sql);
		    int cnt = 0;
		    while(rs.next()){
		    	Statement stmt2 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
		    	String id = rs.getString("followed");
		    	sql2 = "select name from member where id='"+id+"'";
		    	rs2 = stmt2.executeQuery(sql2);
		    	cnt++;
				if(rs2.next()){
			    	response.getWriter().write(rs2.getString("name")+"&nbsp;(");
			    	response.getWriter().write(id+")&nbsp;&nbsp;&nbsp;");
			    	response.getWriter().write("<button type='button' class='follow-watch-btn'");
			    	response.getWriter().write(" value='"+id+"'>보기</button>&nbsp;");
			    	response.getWriter().write("<button type='button' class='follow-delete-btn'");
			    	response.getWriter().write(" value='"+id+"'>삭제</button><br>");
			    	response.getWriter().write("<br>");
				}
		    }
		    if(cnt == 0) {
		    	response.getWriter().write("아직 팔로우 한 사람이 없습니다!");		    	
		    }

		}
		catch(Exception e){
			out.println("DB 연동 오류입니다.:"+e.getMessage());
		}	
	%>
</body>
</html>