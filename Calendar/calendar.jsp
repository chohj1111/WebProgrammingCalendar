<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
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

<title>WEB Calendar</title>
</head>
<body>
	<div id="calendar"></div>
	<div id="content-box">
		<form action="" method="get">
			<fieldset>
				<input type="search" id="search-bar">
				<button type="submit" id="search-submit">
					<i class="fa-search"></i>
				</button>
			</fieldset>
		</form>
	</div>
	<div id="addEvent-modal" class="modal">
		<h2>일정 추가</h2><hr><br>
		
		<form action="#">
		<table width="900px">
			<tr>
				<td><b>일정명</b></td>
				<td><input type="text" name="title" id="input-title" required="required"></td>
			</tr>
			<tr>
				<td><b>색상</b></td>
				<td>
					<select name="color" id="input-color" required="required">
						<option>기본 색상</option>
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
	
	<form action="#">
	<table width="900px">
		<tr>
			<td><b>일정명</b></td>
			<td><input type="text" name="title" id="edit-title" required="required"></td>
		</tr>
		<tr>
			<td><b>색상</b></td>
			<td>
			<select name="color" id="edit-color" required="required">
				<option>기본 색상</option>
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
</body>
</html>
