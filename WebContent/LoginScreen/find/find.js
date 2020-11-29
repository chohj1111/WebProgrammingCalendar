function getXHR(){
	if(window.XMLHttpRequest){
		return new XMLHttpRequest();
	}
}

function emailCheck(email){
	var reg = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	
	if(reg.test(email.value)==false){
		document.getElementById("emailCheck").innerHTML="형식이 일치하지 않습니다.";
		document.getElementById("emailCheck").style.color = "red";
		document.getElementById("submit_btn_id").disabled = "disabled";
		return;
	}else{
		document.getElementById("emailCheck").innerHTML="";
		document.getElementById("submit_btn_id").disabled = false;
	}
	
	xhr = getXHR();
	xhr.onreadystatechange = getResultEmail;
	var id = document.getElementById("email").value;
	xhr.open("get","emailcheck.jsp?email=" + id, true);
	xhr.send(null);
}

function idCheck(id){
	
	if(id.value == "" || id.value == " "){
		document.getElementById("idCheck").innerHTML="아이디를 입력하세요";
		document.getElementById("idCheck").style.color = "red";
		document.getElementById("submit_btn_pw").disabled = "disabled";
		return;
	}
	
	xhr = getXHR();
	xhr.onreadystatechange = getResultId;
	var id = document.getElementById("findpw_id").value;
	xhr.open("get","../register/idcheck.jsp?id=" + id, true);
	xhr.send(null);
}

function getResultEmail(){
	if(xhr.readyState == 4 && xhr.status == 200){
		var xml = xhr.responseXML;
		var re = xml.getElementsByTagName("result")[0].firstChild.nodeValue;
		
		if(re == 'true'){
			document.getElementById("emailCheck").innerHTML="";
			document.getElementById("submit_btn_id").disabled = false;
		}else{
			document.getElementById("emailCheck").innerHTML="등록되지 않은 이메일입니다.";
			document.getElementById("emailCheck").style.color = "red";
			document.getElementById("submit_btn_id").disabled = "disabled";
		}
	}
}

function getResultId(){
	if(xhr.readyState == 4 && xhr.status == 200){
		var xml = xhr.responseXML;
		var re = xml.getElementsByTagName("result")[0].firstChild.nodeValue;
		
		if(re == 'true'){
			document.getElementById("idCheck").innerHTML="";
			document.getElementById("submit_btn_pw").disabled = false;
		}else{
			document.getElementById("idCheck").innerHTML="등록되지 않은 아이디입니다.";
			document.getElementById("idCheck").style.color = "red";
			document.getElementById("submit_btn_pw").disabled = "disabled";
		}
	}
}