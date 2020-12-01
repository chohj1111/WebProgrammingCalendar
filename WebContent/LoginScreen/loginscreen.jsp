<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<%  
	String user_id = (String)session.getAttribute("user_id");
	String user_name = (String)session.getAttribute("user_name");
%>
<html lang="ko">
<head>
    <meta charset="utf-8">

    <title>Web Calendar</title>

    <!-- css  -->
    <link href="lib/js/owl-carousel/owl.carousel.css" rel="stylesheet">
    <link href="lib/js/owl-carousel/owl.theme.css" rel="stylesheet">
    <link href="lib/js/owl-carousel/owl.transitions.css" rel="stylesheet">

    <!-- 폰트 -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.css" rel="stylesheet">

    <!-- bootstarp, main css -->
    <link href="lib/bootstrap-3.3.7/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="lib/main.css" rel="stylesheet">

    <!-- js 라이브러리 -->
    <script src="lib/js/jquery-3.5.1.min.js"></script>
    <script src="lib/bootstrap-3.3.7/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <script src="lib/js/owl-carousel/owl.carousel.min.js"></script>
    <script src="lib/js/typed.js-master/typed.js-master/dist/typed.min.js"></script>
    <script src="lib/main.js"></script>
    <script type="text/javascript">
    
    function request(){
    	var id = "<%=request.getParameter("id")%>";
     	if(id != "null"){
     		$('#id-form').prop("value",id);
     	}
    }
    </script>
</head>

<body onload="request()">
    <section id="main">
        <div class="container">
            <div class="row">
                <div class="col-md-6 caption">
                    <h1>Web Calendar</h1>
                    <h2>
                        <span class="animated-text"></span>
                        <span class="typed-cursor"></span>
                    </h2>
                </div>

                <div class="col-md-5 col-md-offset-1">
                    <form class="login-form" action="login-db/login-db.jsp" method="post">
                        <h2 class="text-center">로그인</h2>
                        <hr>
                        <div class="form-group">
                            <input type="text" class="form-control" id="id-form" placeholder="아이디" name="id" required="required" >
                        </div>
                        <div class="form-group">
                            <input type="password" class="form-control" placeholder="비밀번호" name="pw" required="required">
                        </div>
                        <div class="login-fail-info">
                            <%
                                String msg = request.getParameter("msg");
                                if(msg != null) { out.println(msg); } 
                            %>
                            &nbsp;
                        </div>
                        <br>
                        <div class="form-group text-center">
                            <button type="submit" class="btn btn-indigo btn-block">로그인</button>
                        </div>
                        <div class="form-group text-center">
                            <button class="btn btn-darkcyan btn-block" 
                            	onclick="location.href='register/register.jsp'">
                            회원가입
                            </button>
                        </div>
                        <div class="form-group text-center">
	                        <a href="find/find.jsp" id="find-id-pw">아이디를 잊으셨나요?</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </section>

    <br><br>
    <section id="sub">
        <div class="container">
            <div class="row">
                <div id="owl-lib">
                	<div class="item"><img src="lib/img/logos/bootst.png" class="center-block"></div>
                    <div class="item"><img src="lib/img/logos/fullcal.png" class="center-block"></div>
                    <div class="item"><img src="lib/img/logos/JQuery.png" class="center-block"></div>
                    <div class="item"><img src="lib/img/logos/owl.png" class="center-block"></div>
                    <div class="item"><img src="lib/img/logos/typedjs.png" class="center-block"></div>
                    <div class="item"><img src="lib/img/logos/tomcat.png" class="center-block"></div>
                    <div class="item"><img src="lib/img/logos/freepik.png" class="center-block"></div>
                </div>
            </div>
        </div>
    </section>
</body>
</html>