<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>
<%@ page import="connection.DBConnection" %>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset='utf-8' />

<link href='lib/main.css' rel='stylesheet' />
<script type="text/javascript" src='lib/jquery-3.5.1.min.js'></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
<script type="text/javascript" src='lib/jquery.modal.min.js'></script>
<link rel="stylesheet" type="text/css" href="lib/jquery.modal.min.css">

<script type="text/javascript" src='lib/main.js'></script>
<script type="text/javascript" src="calendar.js"></script>
<link rel="stylesheet" type="text/css" href="calendar.css">
<!-- calendar_db로 전송 -->
<%  
	String user_id = (String)session.getAttribute("user_id");
	String user_name = (String)session.getAttribute("user_name");
	String notice_num = null;
	Calendar t_cal = Calendar.getInstance();
	
	String t_year = Integer.toString(t_cal.get(Calendar.YEAR));
	String t_month = Integer.toString(t_cal.get(Calendar.MONTH) + 1);
	String t_date = Integer.toString(t_cal.get(Calendar.DATE));
	String coming_date = Integer.toString(t_cal.get(Calendar.DATE) + 7);
	if(t_cal.get(Calendar.DATE)<10)
		t_date = "0"+t_date;
	String today = t_year+"-"+t_month+"-"+t_date;
	session.setAttribute("today",today);
	
	String coming_day = t_year+"-"+t_month+"-"+coming_date;
%>
<script>var myID="<%=user_id%>"</script>

<title>WEB Calendar</title>
</head>
<body>
	<div id="sidebar-wrap">
	    <nav id="sidebar">
	      <br><br>
	      <div id="user-name">
	      	<%
	      		if(user_id == null) out.println("guest");
	      		else out.println(user_name);
	      	%>
	      </div>
	      <div id="user-msg">님 반갑습니다.</div><br><br>
	      <a id="user-search" href="#">사용자 검색</a>
	      <a id="follow-list" href="#">팔로우 목록</a>
		  <a id="logout" href="#">
	      	<%
	      		if(user_id == null) out.println("로그인");
	      		else out.println("로그아웃");
	      	%>
		  </a>
	    </nav>
	    <div class="overlay"></div>
	</div>

	<div id="calendar"></div>
	<div id="content-box">
		<form action="search/search.jsp" method="get" target="search_frame">
			<fieldset>
				<input type="search" id="search-bar" name="search_word" placeholder="일정을 검색하세요">
				<button type="submit" id="search-submit">
					<i class="fa fa-search"></i>
				</button>
			</fieldset>
		</form>
		<div id="search_frame">
			<iframe name="search_frame"></iframe>
			<button id="frame_close_btn"><i class="fas fa-times"></i></button>
		</div>
		<div id="mid_box">
			&emsp;&emsp; 제작 <br>
			김동욱 2017112090<br>
			이정욱 2017112129<br>
			조현준 2017112125<br>
			<p></p>
			<input type="checkbox" id="holiday_chk" checked>공휴일 표시
			<div id="notice">
				<form action="notice/notice.jsp" method="get" target="notice_frame">
					<button type="submit" id="notice_btn"><i class="fas fa-users"></i></button>
				</form>
				<div id="notice_frame">
					<iframe name="notice_frame"></iframe>
				</div>
				<div id="notice_num"></div>
			</div>
		</div>
		<div id="bottom_box">
			<div id="oncoming">
				<%
				Connection conn = null;
				Statement stmt = null;
				ResultSet rs = null;
				String sql = null;
				try{
					conn = DBConnection.getCon();
					stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
					sql = "select * from plan where startdate between '"+today+"' and '"
					+coming_day+"' and user_id='"+user_id+"' order by startdate";
					rs = stmt.executeQuery(sql);
				}catch(Exception e){
					out.println("DB 연동 오류입니다.:"+e.getMessage());
				}
				%>
				<p style="font-weight:bolder; color:#2c3e50">다가오는 일정</p>
				<%
				while(rs.next()){
					%><div id="oncoming_title" style='color:<%= rs.getString("color") %>'><%
					out.println(rs.getString("title"));
						%><span id="oncoming_memo"><%
						out.println(rs.getString("memo"));
					%></span></div>
					<span id="oncoming_date"><%
					out.println(rs.getString("startdate"));
					%></span><br><%
				}
				sql = "select COUNT(*) as cnt from notice where id='"+user_id+"' and isnew='1'";
				rs = stmt.executeQuery(sql);
				while(rs.next())
					notice_num = rs.getString("cnt");
				%>
				<script>$("#notice_num").text(<%=notice_num %>)</script>
			</div>
		</div>
	</div>
	 
	<div id="addEvent-modal" class="modal">
		<h2>일정 추가</h2><hr><br>
		
		<form id="calendar_insert_form" action="calendar-db/calendar-insert-db.jsp" method="get">
		<!-- for calender-insert-db.jsp -->
		<input type="hidden" name="user_id" value="<%=user_id%>">
		
		<table width="900px">
			<tr>
				<td><b>일정명</b></td>
				<td><input type="text" name="title" id="input-title" required="required"></td>
			</tr>
			<tr>
				<td><b>색상</b></td>
				<td>
					<select name="color" id="input-color" required="required">
						<option value="Default" selected>기본 색상</option>
						<option value="Red" style="color: Red;">빨간색</option>
						<option value="Purple" style="color: Purple;">보라색</option>
						<option value="Orange" style="color: Orange;">주황색</option>
						<option value="Blue" style="color: Blue;">파란색</option>
						<option value="Pink" style="color: Pink;">핑크색</option>
						<option value="LightGreen" style="color: LightGreen;">연두색</option>
						<option value="Green" style="color: Green;">초록색</option>
						<option value="Indigo" style="color: Indigo;">남색</option>
					</select>
				</td>
			</tr>
			<tr>
				<td><b>시작</b></td>
				<td><input id="input-start" type="date" placeholder="YYYY-MM-DD" name="startdate" required="required"></td>
			</tr>
			<tr>
				<td><b>종료</b></td>
				<td><input id="input-end" type="date" placeholder="YYYY-MM-DD" name="enddate" required="required"></td>
			</tr>
			<tr>
				<td><b>메모</b></td>
				<td><textarea id="input-memo" name="memo" rows="5"></textarea></td>
			</tr>
		</table>
		<br><hr><br>
		
		<button type="button" id="input-save" class="pop-save-btn">저장</button>
		&nbsp;&nbsp;
		<button type="button" class="pop-close-btn" onclick="$.modal.close()">닫기</button>
		</form>
	</div>
	
	<div id="editEvent-modal" class="modal">
	<h2>일정 수정</h2><hr><br>
	
		<form id="calendar_modify_form" action="calendar-db/calendar-modify-db.jsp" method="get">
		<!-- for calender-insert-db.jsp -->
		<input type="hidden" name="user_id" value="<%=user_id%>">
		<table width="900px">
			<tr>
				<td><b>일정명</b></td>
				<td><input type="text" name="title" id="edit-title" required="required"></td>
			</tr>
			<tr>
				<td><b>색상</b></td>
				<td>
					<select name="color" id="edit-color" required="required">
							<option value="Default" selected>기본 색상</option>
							<option value="Red" style="color: Red;">빨간색</option>
							<option value="Purple" style="color: Purple;">보라색</option>
							<option value="Orange" style="color: Orange;">주황색</option>
							<option value="Blue" style="color: Blue;">파란색</option>
							<option value="Pink" style="color: Pink;">핑크색</option>
							<option value="LightGreen" style="color: LightGreen;">연두색</option>
							<option value="Green" style="color: Green;">초록색</option>
							<option value="Indigo" style="color: Indigo;">남색</option>
					</select>
				</td>
			</tr>
			<tr>
				<td><b>시작</b></td>
				<td><input id="edit-start" type="date" placeholder="YYYY-MM-DD" name="startdate" required="required"></td>
			</tr>
			<tr>
				<td><b>종료</b></td>
				<td><input id="edit-end" type="date" placeholder="YYYY-MM-DD" name="enddate" required="required"></td>
			</tr>
			<tr>
				<td><b>메모</b></td>
				<td><textarea id="edit-memo" name="memo" rows="5"></textarea></td>
			</tr>
		</table>
		<br><hr><br>
		
		<button type="button" id="edit-save" class="pop-save-btn">수정</button>
		&nbsp;&nbsp;
		<button type="button" id="edit-delete" class="pop-delete-btn">삭제</button>
		&nbsp;&nbsp;
		<button type="button" class="pop-close-btn" onclick="$.modal.close()">닫기</button>
		</form>
	</div>
	<div id="user-search-modal" class="modal">
		<h2>유저 검색</h2><hr><br>
		<input id="username-input" type="text" name="name" 
			style="width: 300px;" placeholder="이름으로 검색하기" required>
		&nbsp;&nbsp;
		<input type="hidden" name="act" value="search">
		<button type="button" id="user-search-btn" class="user-search-btn">검색</button>
		<br><br>
		<div id="user-search-result"></div>
		<br><br>
	</div>
	
	<div id="follow-list-modal" class="modal">
		<h1><%=user_name%></h1>
		<h4>&nbsp;님의 팔로우 목록</h4><hr><br>
		<br><br>
		<div id="follow-list-result">불러오는중...</div>
		<br><br>
	</div>
	
	<script type="text/javascript" src="sidebar.js"></script>
</body>
</html>
