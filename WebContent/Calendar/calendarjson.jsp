<%@ page import="java.sql.*" %>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="java.util.Calendar" %>
<%@page import="java.util.Date" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="java.text.DateFormat" %>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%!
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
String sql;
JSONArray arr; 

%>
<%
      try {
    	Class.forName("com.mysql.jdbc.Driver");
  		String url = "jdbc:mysql://localhost:3306/mycal?serverTimezone=UTC";
  		conn = DriverManager.getConnection(url, "root", "0000");
        Statement st = conn.createStatement();
        sql="select * from plan order by id asc";
        rs = st.executeQuery(sql);
        arr = new JSONArray();
  		
  		while(rs.next()){
  		
  			
  			JSONObject obj = new JSONObject();
  			obj.put("title", rs.getString("title"));
  			obj.put("color", rs.getString("color"));
  			obj.put("start", rs.getString("startdate"));
			 if(rs.getString("startdate")== rs.getString("enddate")) obj.put("end", rs.getString("startdate"));
  			else { 
  				// converting sql date to util.date 
  				java.util.Date endDate = rs.getTimestamp("enddate");
  				// add one day using Calendar class
  				Calendar c = Calendar.getInstance(); 
  				c.setTime(endDate); 
  				c.add(Calendar.DATE, 1);
  				endDate = c.getTime();
  				// endDate to string 
  				DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
  				String endDateAsString = df.format(endDate);
  				obj.put("end", endDateAsString);
  			} 
  			obj.put("description", rs.getString("memo"));
  			obj.put("id", rs.getString("id"));
  			arr.add(obj);
  		}

          } catch (Exception e) {
                   System.out.println(e);
         }

%>
<%=arr%>
