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
		
		document.getElementById("registerCheck").innerHTML="&nbsp;";
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
		document.getElementById("registerCheck").innerHTML="&nbsp;";
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
		console.log(re);
		if(re == 'true'){
			document.getElementById("idCheck").innerHTML="이미 사용중인 아이디 입니다";
			document.getElementById("id-check-circle").style.display = "none";
			document.getElementById("idCheck").style.color = "red";
			register = false;
		}else{
			document.getElementById("idCheck").innerHTML="&nbsp;";
			document.getElementById("id-check-circle").style.display = "inline-block";
			document.getElementById("idCheck").style.color = "blue";
			register = true;
		}
		if(!document.userInfo.id.value)
			document.getElementById("idCheck").innerHTML="&nbsp;";
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