<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.*" %>
<%@ page import="connection.DBConnection" %>

<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<body>
<%
String name, id, pw, email;
Connection conn = null;
Statement stmt = null;
ResultSet rs = null;
String sql_update;
String redirectURL = "../loginscreen.jsp";

name = request.getParameter("name");
id = request.getParameter("id");
pw = request.getParameter("pw");
email = request.getParameter("email");

sql_update = "insert into member values(?,?,?,?)";

try{
	conn = DBConnection.getCon();
    stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	PreparedStatement pstmt = conn.prepareStatement(sql_update);
	pstmt.setString(1,name);
	pstmt.setString(2,id);
	pstmt.setString(3,pw);
	pstmt.setString(4,email);
	pstmt.executeUpdate();
	%>
    <script>alert("<%=name%>님 가입을 축하드립니다.");</script>
	<form name="RegisterSuccess" action="<%=redirectURL%>" method="post">
				<input type="hidden" name="id" value="<%=id%>">
	</form>
	<script type="text/javascript">document.RegisterSuccess.submit();</script>
	<% 
}catch(Exception e){
	out.println("DB 연동 오류입니다.:"+e.getMessage());
}

%>
<center>
	<h2>회원가입이 완료되었습니다.</h2>
</center>
</body>
</html>