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
ResultSet rs = null;
String sql_update;

// 로그인 안되어 있으면 redirect 필요
//from calendar.jsp (foreign key)
id = request.getParameter("id");
String redirectURL = "../../LoginScreen/loginscreen.jsp";



title=request.getParameter("title");
color=request.getParameter("color");
startdate = request.getParameter("startdate");
enddate = request.getParameter("enddate");
memo = request.getParameter("memo");

if(id==null) { 
%>
	alert("로그인 실패!!"));
<%
}
else{
	try{	
		Class.forName("com.mysql.jdbc.Driver");
		String url = "jdbc:mysql://localhost:3306/mycal?serverTimezone=UTC";
		conn = DriverManager.getConnection(url, "root", "0000");
		sql_update = "insert into plan(title,color,startdate,enddate,memo,id) values(?,?,?,?,?,?)";
		pstmt = conn.prepareStatement(sql_update);
		pstmt.setString(1,title);
		pstmt.setString(2,color);
		pstmt.setString(3,startdate);
		pstmt.setString(4,enddate);
		if(memo!=null) pstmt.setString(5,memo);
		else pstmt.setNull(5,Types.VARCHAR);
		pstmt.setString(6,id);
		pstmt.executeUpdate();
		%>alert("ss");<%
	}
	// redirection 필요
	catch(Exception e) {
%>
	alert("DB 연동 오류입니다! : "+e.getMessage()));
<% 
	}
	// back to calendar
	redirectURL = "../calendar.jsp"; 
} 
%>
<form name="insertFinished" action="<%=redirectURL%>" method="post">
		<input type="hidden" name="id" value="<%=id%>">
</form>
<script type="text/javascript">document.insertFinished.submit();</script>
</body>
</html>