<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	String lunchDate = request.getParameter("lunchDate");
	System.out.println("lunchDate1111 : " + lunchDate);		
	if(lunchDate != null){
	}
	
	Connection conn = null;
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");	
		
	String sql2 = "DELETE FROM lunch WHERE lunch_date = ?";		
	System.out.println("lunchDate1111 : " + lunchDate);		
	stmt2 = conn.prepareStatement(sql2);
	stmt2.setString(1, lunchDate);
	rs2 = stmt2.executeQuery();
	response.sendRedirect("/diary/lunchOne.jsp");
	return;
%>