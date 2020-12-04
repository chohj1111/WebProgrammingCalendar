<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="connection.DBConnection" %> 
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
</head>
<body>
	<%
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		
		String redirectURL = "../calendar.jsp"; 
		String myID = (String)request.getParameter("myID");
		String targetID = (String)request.getParameter("targetID");
		
		//System.out.println(myID);
		//System.out.println(targetID);
		
		if(myID.equals("null")) {
			%>
				<script>
					alert("guest는 팔로우 할 수 없습니다.");
					window.location.href="<%=redirectURL%>";
				</script>
			<%
		}
		else{
			if(myID.equals(targetID)) {
				%>
					<script>
						alert("자기 자신은 팔로우 할 수 없습니다.");
						window.location.href="<%=redirectURL%>";
					</script>
				<%
			}
			else{
				String sql_check = "select followed from follow where follower='"+myID+"'";
				String sql_update = "insert into follow values"+"('"+myID+"','"+targetID+"')";
				try {
					conn = DBConnection.getCon();	
				    stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
				    rs = stmt.executeQuery(sql_check);
				    boolean dup_follow = false;
				    while(rs.next()){
				    	if(rs.getString("followed").equals(targetID)) {
				    		dup_follow = true;
				    		break;
				    	}
				    }
				    if(dup_follow){
						%>
						<script>
							alert("이미 팔로우한 사람입니다.");
							window.location.href="<%=redirectURL%>";
						</script>
						<%
				    }
				    else{
				    	stmt.executeUpdate(sql_update);
				    	
				    	sql_update = "insert into notice values(?,?,?,?)";
				    	PreparedStatement pstmt = conn.prepareStatement(sql_update);
				    	pstmt.setString(1,targetID);
				    	pstmt.setString(2,myID+" 님이 당신을 팔로우하기 시작했습니다");
				    	pstmt.setString(3,(String)session.getAttribute("today"));
				    	pstmt.setString(4,"1");
				    	pstmt.executeUpdate();
						%>
						<script>
							alert("팔로우 완료");
							window.location.href="<%=redirectURL%>";
						</script>
						<%
				    }
				}
				catch(Exception e){
					out.println("DB 연동 오류입니다.:"+e.getMessage());
				}	
			}		
		}
	%>
</body>
</html>