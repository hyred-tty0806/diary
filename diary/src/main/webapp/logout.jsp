<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.sql.*"%>
<%
	/*  
		logout	
		1. 이미 로그아웃 상태면 메시지와 함께 로그인화면으로 이동
		2. mySession 으로 off  값으로 바꾸고 loginForm으로 이동
	*/
/* 	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");	
	
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	
	String sql1 = "select my_session mySession from login";
	stmt1 = conn.prepareStatement(sql1);
	rs1 = stmt1.executeQuery();

	String mySession = null;
	if(rs1.next()){
		mySession = rs1.getString("mySession");
	}
	
	if(mySession.equals("OFF")) {
		String errMsg = URLEncoder.encode("로그인 정보를 확인할 수 없습니다. 다시 로그인 해주세요.", "utf-8");
		response.sendRedirect("/diary/loginForm.jsp?errMsg="+errMsg);
		return; // 코드 진행을 끝내는 문법 ex) 메서드 끝낼때 return 사용
	}
	
	PreparedStatement stmt2 = null;
	
	String sql2 = "UPDATE login set my_session='OFF', off_date=now()";	
	stmt2 = conn.prepareStatement(sql2);
	
	int row = stmt2.executeUpdate();
	System.out.println("row : " + row);
	
	response.sendRedirect("/diary/loginForm.jsp");
	ResultSet rs2 = null; */
	
	session.invalidate(); // 세션 공간 초기화(포맷)
	response.sendRedirect("/diary/loginForm.jsp");
%>