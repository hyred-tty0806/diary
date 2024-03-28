<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	String dateParam = request.getParameter("currentDateStr");
	String menuParam = request.getParameter("menu");
	
	Connection conn = null;
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");	
	String menuStr = "";
	
	
	switch(menuParam){
	case "1" :
		menuStr = "한식";
		break;
	case "2" :
		menuStr = "중식";
		break;
	case "3" :
		menuStr = "일식";
		break;
	case "4" :
		menuStr = "양식";
		break;
	default :
		menuStr = "기타";
		break;
	}
	
	String sql2 = "INSERT INTO lunch VALUES(?,?,NOW(),NOW())";		
	stmt2 = conn.prepareStatement(sql2);
	stmt2.setString(1, dateParam);
	stmt2.setString(2, menuStr);
	rs2 = stmt2.executeQuery();
	response.sendRedirect("/diary/lunchOne.jsp");
	return;
%>