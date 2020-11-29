<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@page import="certification.mail.DoCompare" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
</script>
</head>
<body>
<%
String id = request.getParameter("id");

if(request.getParameter("userInput").equals(DoCompare.getCode())){
	if(id == null || id.equals("") || id.equals("null")){
		String email = request.getParameter("email");
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
			out.println(rs.getString("id")+"<br>");
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
	out.println("인증번호가 다릅니다");
}

DoCompare.setCode("1");
DoCompare.setInput("1");
%>
</body>
</html>