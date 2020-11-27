<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="register.css">
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
	<!-- header -->
	<div id="header">
    	<h1>Web Calendar</h1>
    	<h3 id="header_comment">Web Calendar 계정으로 새로운 일정관리를 경험하세요</h3>
    </div>
    
    <!-- wrapper -->
    <form action="register-db.jsp" method="post" name="userInfo" onsubmit="return checkValue()">
    	<div id="wrapper">
    		<!-- content -->
    		<div id="content">
    			<!-- name -->
    			<div>
    				<h3 class="join_title"><label for="name">이름</label></h3>
    				<span class="box int_name">
    					<input type="text" name="name" id="name" class="int" maxlength="20" 
    					onkeyup="nameCheck()">
    					<i style="display:none;" id = "name-check-circle" class="fas fa-check-circle"></i>
    				</span>
    			</div>
    			
    			<!-- ID -->
                <div>
                    <h3 class="join_title">
                        <label for="id">아이디</label>
                    </h3>
                    <span class="box int_id">
                        <input type="text" name="id" id="id" class="int" maxlength="20" 
                        onkeyup="idCheck()">
                        <i style="display:none;" id = "id-check-circle" class="fas fa-check-circle"></i>
                    </span>
                    <span id="idCheck" class="error_next_box"></span>
                </div>

                <!-- PW1 -->
                <div>
                    <h3 class="join_title"><label for="pswd1">비밀번호</label></h3>
                    <span class="box int_pass">
                        <input type="text" name="pw" id="pswd1" class="int" maxlength="20" 
                        onkeyup="pwCheck()">
                    </span>
                </div>

                <!-- PW2 -->
                <div>
                    <h3 class="join_title"><label for="pswd2">비밀번호 확인</label></h3>
                    <span class="box int_pass_check">
                        <input type="text" name="pw2" id="pswd2" class="int" maxlength="20" 
                        onkeyup="pwCheck()">
                        <i style="display:none;" id = "pw-check-circle" class="fas fa-check-circle"></i>
                    </span>
                </div>
                
                <!-- EMAIL -->
                <div>
                    <h3 class="join_title"><label for="email">본인확인 이메일</label>(선택)</h3>
                    <span class="box int_email">
                        <input type="text" name="email" id="email" class="int" maxlength="100" 
                        placeholder="아이디/비밀번호 찾기에 사용됩니다" onkeyup="emailCheck()">
                    </span>
                </div>
                
                <!-- JOIN BTN-->
                <br><span id="registerCheck"></span>
                <div class="btn_area">
                    <button type="submit" id="btnJoin">
                        <span>가입하기</span>
                    </button>
                </div>
    		</div>
    	</div>
    </form>
        
        
</body>
</html>
