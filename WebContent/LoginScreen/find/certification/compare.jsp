<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@page import="certification.mail.DoCompare" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="../find.css">
<script>
</script>
</head>
<body>
<%
String id = request.getParameter("id");
String email = request.getParameter("email");
if(request.getParameter("userInput").equals(DoCompare.getCode())){
	if(id == null || id.equals("") || id.equals("null")){
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try{
			Class.forName("com.mysql.jdbc.Driver");
	        String jdbcurl = "jdbc:mysql://localhost:3306/mycal?serverTimezone=UTC";
	        conn = DriverManager.getConnection(jdbcurl, "root", "0000");
	        String sql = "select * from member where email = ?";
	        pstmt = conn.prepareStatement(sql);
	    	pstmt.setString(1, email);
	    	rs=pstmt.executeQuery();
		}catch(Exception e){
			out.println("DB 연동 오류입니다.: "+e.getMessage());
		}
		while(rs.next()){
			out.println("아이디는 "+rs.getString("id")+" 입니다.<br>");
		}
	}else{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try{
			Class.forName("com.mysql.jdbc.Driver");
	        String jdbcurl = "jdbc:mysql://localhost:3306/mycal?serverTimezone=UTC";
	        conn = DriverManager.getConnection(jdbcurl, "root", "0000");
	        String sql = "select * from member where id = ?";
	        pstmt = conn.prepareStatement(sql);
	    	pstmt.setString(1, id);
	    	rs=pstmt.executeQuery();
		}catch(Exception e){
			out.println("DB 연동 오류입니다.: "+e.getMessage());
		}
		while(rs.next()){
			out.println("패스워드는 "+rs.getString("pw")+" 입니다<br>");
		}
	}
}else{
	%>
	<form action="compare.jsp" method="post" >
		인증번호가 다릅니다.<br>
		<input name="userInput" type="text" placeholder="인증번호 입력">
		<input type="hidden" name="email" value=<%=email %>>
		<input type="hidden" name="id" value=<%=id %>><br><br>
		<button id="check" type="submit"
			class="btn btn-skyblue btn-block form-submit">인증번호 확인</button><br>
	</form>
	<% 
}
%>
</body>
</html>
