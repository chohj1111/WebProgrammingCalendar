<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
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
<style type="text/css">
iframe{
	width:83%;
	height:60%;
	border:1px solid #dae1e6;
	margin-left:10px;
}
</style>
<!-- calendar_db로 전송 -->
<%  
	String user_id = (String)session.getAttribute("user_id");
	String user_name = (String)session.getAttribute("user_name");
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
		<iframe name="search_frame"></iframe>
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
		<div id="follow-list-result">불러오는중..</div>
		<br><br>
	</div>
	
	<script type="text/javascript" src="sidebar.js"></script>
</body>
</html>
