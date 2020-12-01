<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="connection.DBConnection" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
<%
String id = request.getParameter("id");
String email= null;
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

try{
	conn = DBConnection.getCon();
    String sql = "select * from member where id = ?";
    pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, id);
	rs=pstmt.executeQuery();
}catch(Exception e){
	out.println("DB 연동 오류입니다.: "+e.getMessage());
}
while(rs.next()){
	email = rs.getString("email");
	%>
	<form name="certification" action="certification.jsp" method="post">
		<input type="hidden" name="email" value=<%=email %>>
		<input type="hidden" name="id" value=<%=id %>>
	</form>
	<script type="text/javascript">document.certification.submit();</script>
	<%
}
%>
</body>
</html>