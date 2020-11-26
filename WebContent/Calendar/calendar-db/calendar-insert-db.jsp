<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>


<% request.setCharacterEncoding("utf-8"); %>
<html>
<body>
<%
int cnt, new_id=0;
String id,title,color,startdate, enddate, memo; 
Connection conn = null;
PreparedStatement pstmt = null;
Statement stmt = null;
ResultSet rs = null;
String sql,sql_update;

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
		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,
	 			ResultSet.CONCUR_UPDATABLE);
	 	sql = "select count(*) as cnt, max(post_id) as max_id from plan order by post_id asc ";
	 	rs = stmt.executeQuery(sql);
	 	rs.beforeFirst();
		
	}
	// redirection 필요
	catch(Exception e) {
%>
	alert("DB 연동 오류입니다! : "+e.getMessage()));
<% 
	}
	while(rs.next()){
		cnt = Integer.parseInt(rs.getString("cnt"));
		if(cnt != 0) new_id = Integer.parseInt(rs.getString("max_id"));
	}
	new_id++;
	sql_update = "insert into plan(title,color,startdate,enddate,memo,post_id,id) values(?,?,?,?,?,?,?)";
	pstmt = conn.prepareStatement(sql_update);
	pstmt.setString(1,title);
	pstmt.setString(2,color);
	pstmt.setString(3,startdate);
	pstmt.setString(4,enddate);
	if(memo!=null) pstmt.setString(5,memo);
	else pstmt.setNull(5,Types.VARCHAR);
	pstmt.setInt(6,new_id);
	pstmt.setString(7,id);
	try{
		pstmt.executeUpdate();
	  	
	}catch(Exception e){
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