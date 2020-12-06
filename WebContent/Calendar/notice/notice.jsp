<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.*" %>
<%@page import="connection.DBConnection" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="notice.css">
<script type="text/javascript" src='../lib/jquery-3.5.1.min.js'></script>
<script>
	function f4fSubmit(){
		var submit = 0;
		var target=$("#notice_frame",window.parent.document);
		target.css("display","none");
		submit = 1;
		if(submit == 1)
			return true;
	}
</script>
</head>
<body>
<%
Connection conn = null;
Statement stmt = null;
ResultSet rs = null;
String sql = null;
String user_id = (String)session.getAttribute("user_id");

try{
	conn = DBConnection.getCon();
	stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	sql = "select info, date from notice where id = '"+user_id+"' and isnew = '1' order by num desc";
	rs = stmt.executeQuery(sql);
}catch(Exception e){
	out.println("DB 연동 오류입니다.:"+e.getMessage());
}
if(rs.next()){
	%><h3>새로운 팔로워</h3><br><%
	rs.beforeFirst();
}

String sql_follow = "select followed from follow where follower = '"+user_id+"'";
Statement stmt_follow = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);;
ResultSet rs_follow = stmt_follow.executeQuery(sql_follow);

while(rs.next()){
	String info = rs.getString("info");
	String target_ID = info.substring(0,info.indexOf("님")-1);
	%><span id="info"><%
		out.println(rs.getString("info"));
	%></span>
	<span id="date"><%
		out.println(rs.getString("date"));
	%></span><br><%
	boolean following = false;
	rs_follow = stmt_follow.executeQuery(sql_follow);
	while(rs_follow.next()){
		if(rs_follow.getString("followed").equals(target_ID)){
			following = true;
		}
	}
	if(following == true){
		%><button id="following" disabled="true">팔로잉</button><%
		%><br><%
	}else{
		%><form action="../follow/follow-db.jsp" method="post" onsubmit="return f4fSubmit()">
			<input type="hidden" name="myID" value="<%=user_id%>">
			<input type="hidden" name="targetID" value="<%=target_ID%>">
			<button type="submit" id="f4f">팔로우</button>
		</form><%
	}
}
sql = "select info, date from notice where id = '"+user_id+"' and isnew = '0' order by num desc";
rs = stmt.executeQuery(sql);
%><hr><br><%
while(rs.next()){
	String info = rs.getString("info");
	String target_ID = info.substring(0,info.indexOf("님")-1);
	%><span id="info"><%
		out.println(rs.getString("info"));
	%></span>
	<span id="date"><%
		out.println(rs.getString("date"));
	%></span><br><%
	boolean following = false;
	rs_follow = stmt_follow.executeQuery(sql_follow);
	while(rs_follow.next()){
		if(rs_follow.getString("followed").equals(target_ID)){
			following = true;
		}
	}
	if(following == true){
		%><button id="following" disabled="true">팔로잉</button><%
		%><br><%
	}else{
		%><form action="../follow/follow-db.jsp" method="post" onsubmit="return f4fSubmit()">
			<input type="hidden" name="myID" value="<%=user_id%>">
			<input type="hidden" name="targetID" value="<%=target_ID%>">
			<button type="submit" id="f4f">팔로우</button>
		</form><%
	}
}
sql = "update notice set isnew='0' where id = '"+user_id+"'";
stmt.executeUpdate(sql);
%><br>모두 확인하였습니다.
</body>
</html>