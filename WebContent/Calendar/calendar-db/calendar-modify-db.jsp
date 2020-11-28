<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.ParseException" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.util.Date" %>

<% request.setCharacterEncoding("utf-8"); %>
<html>
<body>
<%
String id,title,color,startdate, enddate, memo; 
Connection conn = null;
PreparedStatement pstmt = null;
Statement stmt = null;
ResultSet rs = null;
String sql_update;

String redirectURL = "../../LoginScreen/loginscreen.jsp";

id=request.getParameter("id");
title=request.getParameter("title");
color=request.getParameter("color");
startdate = request.getParameter("startdate");
enddate = request.getParameter("enddate");
// 일정이 여러 날일 때 
/* if(startdate!= enddate) {
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		// converting sql date to util.date 
		java.util.Date endDate_ = df.parse(enddate);
		// add one day using Calendar class
		Calendar c = Calendar.getInstance(); 
		c.setTime(endDate_); 
		c.add(Calendar.DATE, 1);
		endDate_ = c.getTime();
		// endDate_ to string 
		enddate = df.format(endDate_);
		
}  */
memo = request.getParameter("memo");


try{
	Class.forName("com.mysql.jdbc.Driver");
	String url = "jdbc:mysql://localhost:3306/mycal?serverTimezone=UTC";
	conn = DriverManager.getConnection(url, "root", "0000");
	sql_update = "update plan set title=?,color=?,startdate=?,enddate=?,memo=? where id=?";
	pstmt = conn.prepareStatement(sql_update);
	pstmt.setString(1,title);
	pstmt.setString(2,color);
	pstmt.setString(3,startdate);
	pstmt.setString(4,enddate);
	if(memo!=null) pstmt.setString(5,memo);
	else pstmt.setNull(5,Types.VARCHAR);
	pstmt.setString(6,id);
	pstmt.executeUpdate();


}catch(Exception e){
%>
	<script language = "javascript">
		alert("DB 연동 오류입니다!  ";
		response.sendRedirect(redirectURL);
	</script>
	
<% 
}
// back to calendar
redirectURL = "../calendar.jsp"; 

response.sendRedirect(redirectURL);

%>

</body>
</html>