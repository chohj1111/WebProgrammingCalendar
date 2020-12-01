<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Random" %>
<%@page import="java.sql.*" %>
<%@page import="javax.mail.Transport"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.Address"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.Session"%>
<%@page import="javax.mail.Authenticator"%>
<%@page import="java.util.Properties"%>
<%@page import="certification.mail.SMTPAuthenticatior"%>
<%@page import="certification.mail.DoCompare"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");

int r = new Random().nextInt(900000)+100000;

session.setAttribute("email", request.getParameter("email"));
session.setAttribute("id", request.getParameter("id"));

DoCompare.setCode(Integer.toString(r));

String from = "webcalendar12@gmail.com";
String to = (String)session.getAttribute("email");
String number = Integer.toString(r);
String subject = "Web Calendar 인증이메일";
String content = "이메일 발송 테스트 본문";
String redirectURL = "compare.jsp";
 
Properties p = new Properties(); // 정보를 담을 객체

p.put("mail.smtp.auth", "true");
p.put("mail.smtp.starttls.enable", "true");
p.put("mail.smtp.host", "smtp.gmail.com");
p.put("mail.smtp.port", "587");

try{
    Authenticator auth = new SMTPAuthenticatior();
    Session ses = Session.getInstance(p, auth);
     
    ses.setDebug(true);
    MimeMessage msg = new MimeMessage(ses); // 메일의 내용을 담을 객체  

    msg.setSubject(subject); //  제목 
    
	Address fromAddr = new InternetAddress(from);
	msg.setFrom(fromAddr);	

	Address toAddr = new InternetAddress(to);
	msg.addRecipient(Message.RecipientType.TO, toAddr); // 받는 사람 
	
	msg.setContent("<head><meta charset='urf-8'></head>"+"<body style='color:darkgray;'>"
				+"<center><div style='background:#212429;color:darkgray; width:70%; font-weight:bolder;'><br><br>"
				+"<h2 style='color:darkgray;background:#212429'>"+to+" 님 반갑습니다,</h2>"
				+"<h1 style='color:darkgray;background:#212429'>WEB Calendar 인증 이메일입니다.</h1>"
				+"<h2 style='color:darkgray;background:#212429'>자격 증명을 위한 인증번호는 다음과 같습니다.</h2>"
				+"<h2 style='color:#ff9e00;background:#101112; width:20%; font-size:40px'>"+ number +"</h2><br><br>"
				+"<h5 style='color:darkgray;background:#212429; width:40%; border-left:3px solid #ff9e00'><br>Copyrightⓒ2020  Web Calendar All rights reserved.<br><br></h5><br>"
				+"</div></center></body>",
				"text/html;charset=UTF-8"); // 내용
	Transport.send(msg); // 전송   
	
	%><jsp:forward page="test.jsp"></jsp:forward><%

} catch(Exception e){
    e.printStackTrace();
    return;
}
%>
<script>
function compare(){
	
}
</script>