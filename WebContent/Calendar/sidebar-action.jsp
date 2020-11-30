<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.*" %>
<% 
	request.setCharacterEncoding("utf-8");
	
	String username;
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;

	String act = request.getParameter("act");
	if(act.equals("logout")) {
		String redirectURL = "../LoginScreen/loginscreen.jsp";
		session.invalidate();
		out.println("<script>location.href='"+redirectURL+"';</script>");
	}
	else if(act.equals("search")) {
		response.setContentType("text/html");
		
		username = request.getParameter("username");
		String sql = "select name, id from member where name='"+username+"'";
		try {
			Class.forName("com.mysql.jdbc.Driver");
		    String jdbcurl = "jdbc:mysql://localhost:3306/mycal?serverTimezone=UTC";
		    conn = DriverManager.getConnection(jdbcurl, "root", "0000");		
		    stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
		    rs = stmt.executeQuery(sql);
		    int cnt = 0;
		    while(rs.next()) {
		    	response.getWriter().write(rs.getString("name")+" ("+rs.getString("id")+")"+"&nbsp;&nbsp;&nbsp;");
		    	response.getWriter().write("<button type='button' class='follow-btn'");
		    	response.getWriter().write(" value='"+rs.getString("id")+"'>팔로우</button><br><br>");
		    	cnt++;
		    }
		    if(cnt == 0) {
		    	response.getWriter().write("검색 결과가 없습니다.");
		    }
		    else {
		    	response.getWriter().write("<br><br><small>총 검색결과 "+cnt+"개</small>");
		    }
		    
		}
		catch(Exception e){
			out.println("DB 연동 오류입니다.:"+e.getMessage());
		}
	}
%>
