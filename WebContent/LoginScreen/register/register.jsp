<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
<title>Insert title here</title>
<style type="text/css">
#idCheck{
	color:red;
	font-size:9pt;
}
#pwCheck{
	color:red;
	font-size:9pt;
}
#registerCheck{
	color:red;
	font-size:12pt;
}
.fa-check-circle{
	color:#06ad16b3;
}
</style>

<script type="text/javascript">
var xhr = null;
var register = false;
function getXHR(){
	if(window.XMLHttpRequest){
		return new XMLHttpRequest();
	}
}

function nameCheck(){
	if(!document.userInfo.name.value){
		document.getElementById("registerCheck").innerHTML="이름을 입력하세요";
		document.getElementById("name-check-circle").style.display = "none";
	}else{
		
		document.getElementById("registerCheck").innerHTML="";
		document.getElementById("name-check-circle").style.display = "inline-block";
	}
}

function idCheck(){
	xhr = getXHR();
	xhr.onreadystatechange = getResult;
	var id = document.getElementById("id").value;
	xhr.open("get","idcheck.jsp?id=" + id, true);
	xhr.send(null);
}

function pwCheck(){
	if(document.userInfo.pw.value == document.userInfo.pw2.value){
		document.getElementById("registerCheck").innerHTML="";
		document.getElementById("pw-check-circle").style.display = "inline-block";
	}else{
		document.getElementById("registerCheck").innerHTML="비밀번호를 동일하게 입력하세요";
		document.getElementById("pw-check-circle").style.display = "none";
	}
}

function getResult(){
	if(xhr.readyState == 4 && xhr.status == 200){
		var xml = xhr.responseXML;
		var re = xml.getElementsByTagName("result")[0].firstChild.nodeValue;
		
		if(re == 'true'){
			document.getElementById("idCheck").innerHTML="이미 사용중인 아이디 입니다";
			document.getElementById("id-check-circle").style.display = "none";
			document.getElementById("idCheck").style.color = "red";
			register = false;
		}else{
			document.getElementById("idCheck").innerHTML="";
			document.getElementById("id-check-circle").style.display = "inline-block";
			document.getElementById("idCheck").style.color = "blue";
			register = true;
		}
		if(!document.userInfo.id.value)
			document.getElementById("idCheck").innerHTML="";
	}
}
function checkValue(){
	if(!document.userInfo.name.value){
		document.getElementById("registerCheck").innerHTML="이름을 입력하세요";
		return false;
	}
	if(!document.userInfo.id.value){
		document.getElementById("registerCheck").innerHTML="아이디를 입력하세요";
		return false;
	}
	if(!document.userInfo.pw.value){
		document.getElementById("registerCheck").innerHTML="비밀번호를 입력하세요";
		return false;
	}
	if(document.userInfo.pw.value != document.userInfo.pw2.value){
		document.getElementById("registerCheck").innerHTML="비밀번호를 동일하게 입력하세요";
		return false;
	}
	if(!document.userInfo.email.value){
		document.getElementById("registerCheck").innerHTML="이메일을 입력하세요";
		return false;
	}
	if(!register){
		document.getElementById("registerCheck").innerHTML="이미 사용중인 아이디 입니다";
		return false;
	}
}

</script>
</head>
<body>
<center>
Web Calendar 회원가입
<form action="register-db.jsp" method="post" name="userInfo" onsubmit="return checkValue()">
<table border="0" style="text-align:center;">
	<tr>
	<td> 이 름 </td>
	<td><input type="text" name="name" size="15" onkeyup="nameCheck()"></td>
	<td><i style="display:none;" id = "name-check-circle" class="fas fa-check-circle"></i></td>
	</tr>
	
	<tr>
	<td> 아이디 </td>
	<td><input type="text" name="id" id="id" size="15" onkeyup="idCheck()">
	<br><span id="idCheck"></span></td>
	<td><i style="display:none;" id = "id-check-circle" class="fas fa-check-circle"></i></td>
	</tr>
	
	<tr>
	<td> 비밀번호 </td>
	<td><input type="text" name="pw" size="15"></td>
	</tr>
	
	<tr>
	<td> 비밀번호 확인 </td>
	<td><input type="text" name="pw2" size="15" onkeyup="pwCheck()"></td>
	<td><i style="display:none;" id = "pw-check-circle" class="fas fa-check-circle"></i></td>
	</tr>
	
	<tr>
	<td> 이메일 </td>
	<td><input type="text" name="email" size="30" onkeyup="emailCheck()"></td>
	</tr>
</table>
<span id="registerCheck"></span><br>
<input type="submit" value="회원가입">
</form>
</center>
</body>
</html>