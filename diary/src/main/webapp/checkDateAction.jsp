<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<% 
	String checkDate = request.getParameter("checkDate");
	if(checkDate == null){
		response.sendRedirect("/diary/addDiary.jsp");
		return;
	}
	
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
		String errMsg = URLEncoder.encode("잘못된 접근 입니다. 로그인 먼저 해주세요.", "utf-8");
		response.sendRedirect("/diary/loginForm.jsp?errMsg="+errMsg);
		return; // 코드 진행을 끝내는 문법 ex) 메서드 끝낼때 return 사용
	}
	
	String sql2 = "SELECT diary_date FROM diary WHERE diary_date = '" + checkDate +"'";
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
	stmt2 = conn.prepareStatement(sql2);
	rs2 = stmt2.executeQuery();
		
	if(rs2.next()){
		String msg = URLEncoder.encode("해당 날짜에는 이미 기등록된 정보가 존재합니다.", "utf-8");
		response.sendRedirect("/diary/addDiaryForm.jsp?msg="+msg+"&tf=f&"+"checkDate="+checkDate);		
	} else {
		response.sendRedirect("/diary/addDiaryForm.jsp?tf=t&"+"checkDate="+checkDate);		
	}
%>