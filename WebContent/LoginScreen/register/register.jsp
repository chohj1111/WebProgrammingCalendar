<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
#idCheck{
	color:red;
	font-size:9pt;
}
</style>

<script type="text/javascript">
var xhr = null;

function getXHR(){
	if(window.XMLHttpRequest){
		return new XMLHttpRequest();
	}
}

function idCheck(){
	xhr = getXHR();
	xhr.onreadystatechange = getResult;
	var id = document.getElementById("id").value;
	xhr.open("get","idcheck.jsp?id=" + id, true);
	xhr.send(null);
}

function getResult(){
	if(xhr.readyState == 4 && xhr.status == 200){
		var xml = xhr.responseXML;
		var re = xml.getElementsByTagName("result")[0].firstChild.nodeValue;
		
		if(re == 'true'){
			document.getElementById("idCheck").innerHTML="이미 사용중인 아이디 입니다.";
			document.getElementById("idCheck").style.color = "red";
		}else{
			document.getElementById("idCheck").innerHTML="사용 가능한 아이디 입니다.";
			document.getElementById("idCheck").style.color = "blue";
		}
		if(document.getElementById("id").equals(""))
			document.getElementById("idCheck").innerHTML="";
	}
}

</script>
</head>
<body>
<center>
Web Calendar 회원가입
<form action="register-db.jsp" method="post">
<table border="0" style="text-align:center;">
	<tr>
	<td> 이 름 :</td>
	<td><input type="text" name="name" size="15"></td>
	</tr>
	
	<tr>
	<td> 아이디 :</td>
	<td><input type="text" name="id" id="id" size="15" onkeyup="idCheck()">
	<br><span id="idCheck"></span></td>
	</tr>
	
	<tr>
	<td> 비밀번호 :</td>
	<td><input type="text" name="pw" size="15"></td>
	</tr>
	
	<tr>
	<td> 비밀번호 확인 :</td>
	<td><input type="text" name="pw2" size="15"></td>
	</tr>
	
	<tr>
	<td> 이메일 :</td>
	<td><input type="text" name="email" size="30"></td>
	</tr>
</table>
<input type="submit" value="회원가입">
</form>
</center>
</body>
</html>