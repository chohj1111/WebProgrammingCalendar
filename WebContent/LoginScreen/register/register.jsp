<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>회원가입</title>
    <link rel="stylesheet" href="lib/fonts/material-icon/css/material-design-iconic-font.min.css">
    <link rel="stylesheet" href="lib/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />

    <script src="lib/js/jquery-3.5.1.min.js"></script>
    <script src="lib/js/main.js"></script>
</head>

<body>
    <div class="js-fullheight position-center">
        <section class="signup">
            <div class="container">
                <div class="signup-content">
                    <div class="signup-form">
                        <h2 class="form-title">회원가입</h2>
                        <form class="register-form" id="register-form" 
                        	action="register-db.jsp" method="post" name="userInfo" onsubmit="return checkValue()">
                            <div class="form-group">
                              	<label for="name"><i class="zmdi zmdi-account"></i></label>
                              	<input type="text" class="int" name="name" id="name" placeholder="이름" maxlength="20" onkeyup="nameCheck()"/>
                              	<i style="display:none;" id = "name-check-circle" class="fas fa-check-circle"></i>
                            </div><br>
                            <div class="form-group">
                               	<label for="name"><i class="zmdi zmdi-card"></i></label>
                                <input type="text" class="int" name="id" id="id" placeholder="아이디" maxlength="20" onkeyup="idCheck()"/>
                                <i style="display:none;" id = "id-check-circle" class="fas fa-check-circle"></i>
                            </div><span id="idCheck" class="error_next_box">&nbsp;</span>
                            <div class="form-group">
                                <label for="email"><i class="zmdi zmdi-email"></i></label>
                                <input type="email" name="email" id="email" maxlength="40" placeholder="이메일" />
                            </div><br>
                            <div class="form-group">
                                <label for="pass"><i class="zmdi zmdi-lock"></i></label>
                                <input type="password" name="pw" id="pswd1" placeholder="비밀번호" maxlength="20" onkeyup="pwCheck()" />
                            </div><br>
                            <div class="form-group">
                                <label for="re-pass"><i class="zmdi zmdi-lock-outline"></i></label>
                                <input type="password" name="pw2" id="pswd2" placeholder="비밀번호 확인" maxlength="20" onkeyup="pwCheck()" />
                                <i style="display:none;" id = "pw-check-circle" class="fas fa-check-circle"></i>
                            </div><br>
                            <span id="registerCheck">&nbsp;</span><br><br>
                            <div class="form-group form-button">
                                <button type="submit" name="signup" id="btnJoin" class="btn btn-skyblue btn-block form-submit">
                                	회원가입
                                </button>
                            </div>
                        </form>
                    </div>
                    <div class="signup-image">
                        <figure><img src="lib/images/calendar.png" alt="sing up image"></figure>
                        <a href="../loginscreen.jsp" class="back-login">이미 계정이 있습니다</a>
                    </div>
                </div>
            </div>
        </section>
    </div>
</body>
</html>