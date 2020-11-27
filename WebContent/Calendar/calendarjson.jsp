<%@ page import="java.sql.*" %>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%!
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
String sql;
JSONArray arr; %>
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
  			obj.put("end", rs.getString("enddate"));
  			obj.put("description", rs.getString("memo"));
  			obj.put("id", rs.getString("id"));
  			arr.add(obj);
  		}

          } catch (Exception e) {
                   System.out.println(e);
         }

%>
<%=arr%>
