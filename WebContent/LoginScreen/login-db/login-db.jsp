<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="connection.DBConnection" %>
<% request.setCharacterEncoding("utf-8"); %>
<html>
<body>
<%
String id, pw;
Connection conn = null;
Statement stmt = null;
ResultSet rs = null;
String sql;

id = request.getParameter("id");
pw = request.getParameter("pw");
String redirectURL = "../loginscreen.jsp";

try{
	conn = DBConnection.getCon();
	stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	sql = "select id, pw, name from member where id='"+id+"'";
	rs = stmt.executeQuery(sql);
	
	if(rs.next()) {	
		if(pw.equals(rs.getString("pw"))){
			redirectURL = "../../LoginSession";
			String name = rs.getString("name");
			%>
			<form name="loginSuccess" action="<%=redirectURL%>" method="post">
				<input type="hidden" name="user_id" value="<%=id%>">
				<input type="hidden" name="user_name" value="<%=name%>">
			</form>
			<script type="text/javascript">document.loginSuccess.submit();</script> 
			<%
			//out.println("<script>location.href='"+redirectURL+"';</script>");
			
		}
	}
	String msg = "가입되지 않은 아이디이거나, 잘못된 비밀번호입니다";
	%>
	<form name="loginFailInfo" action="<%=redirectURL%>" method="post">
		<input type="hidden" name="msg" value="<%=msg%>">
		<input type="hidden" name="id" value="<%=id%>">
	</form>
	<script type="text/javascript">document.loginFailInfo.submit();</script>
	<%
	//out.println("<script>alert('');</script>");
	//out.println("<script>location.href='"+redirectURL+"';</script>");
	
	rs.close();
	conn.close();
	stmt.close();
	
}
catch(Exception e) {
	out.println("DB 연동 오류입니다. : " + e.getMessage());
}
%>
</body>
</html>