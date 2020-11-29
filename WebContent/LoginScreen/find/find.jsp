<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>아이디 비밀번호 찾기</title>
<link rel="stylesheet"
	href="../register/lib/fonts/material-icon/css/material-design-iconic-font.min.css">
<link rel="stylesheet" href="find.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />

<script src="../register/lib/js/jquery-3.5.1.min.js"></script>
<script src="find.js"></script>
</head>
<body class="body-bg">
    <div class="js-fullheight position-center">
        <section class="find">
            <div class="container">
                <div class="find-content">
                    <div class="find-form">
                        <h2 class="form-title">아이디 찾기</h2>
                        <form class="register-form" id="register-form" 
                        	action="certification/certification.jsp" method="post" target="iframe1">
                            <div class="form-group">
                                <label for="email"><i class="zmdi zmdi-email"></i></label>
                                <input id="email" onkeyup="emailCheck(email)" type="text" name="email" placeholder="이메일">
                            </div><br>
                            <div class="form-group form-button">
                                <button type="submit" name="find" id="submit_btn_id" disabled="disabled" class="btn btn-indigo btn-block form-submit">
                                	아이디 찾기
                                </button>
                            </div>
                            <span id="emailCheck">&nbsp;</span>
                        </form>	
                       	<div class="iframe-box">
                       		<iframe name="iframe1"></iframe>                       
                   		</div>           	
                    </div>
                    <div class="find-form">
                        <h2 class="form-title">비밀번호 찾기</h2>
                        <form class="register-form" id="register-form" 
                        	action="certification/findpw.jsp" method="post" target="iframe2">
                            <div class="form-group">
                                <label for="id"><i class="zmdi zmdi-account"></i></label>
                                <input type="text" id="findpw_id" name="id" onkeyup="idCheck(findpw_id)" placeholder="아이디">
                            </div><br>

                            <div class="form-group form-button">
                                <button type="submit" id="submit_btn_pw" disabled="disabled" 
                                	class="btn btn-indigo btn-block form-submit">
                                	비밀번호 찾기
                                </button>
                            </div>  
                            <span id="idCheck">&nbsp;</span>
                        </form>
                        <div class="iframe-box">
                        	<iframe name="iframe2"></iframe><br>
                        </div>
                        <a href="../loginscreen.jsp" class="back-login">뒤로가기</a>
                    </div>
                </div>
            </div>
        </section>
    </div>
</body>
</html>