<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%
	String diaryDate = request.getParameter("diaryDate");
	String feeling = request.getParameter("feeling");
	String title = request.getParameter("title");
	String weather = request.getParameter("weather");
	String content = request.getParameter("content");
	
	System.out.println("diaryDate : " + diaryDate);
	System.out.println("feeling : " + feeling);
	System.out.println("title : " + title);
	System.out.println("weather : " + weather);
	System.out.println("content : " + content);
	
	String sql1 = "select my_session mySession from login";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	conn = DriverManager.getConnection(
			"jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
	stmt1 = conn.prepareStatement(sql1);
	rs1 = stmt1.executeQuery();
	String mySession = null;
	if(rs1.next()) {
		mySession = rs1.getString("mySession");
	}
	// diary.login.my_session => 'OFF' => redirect("loginForm.jsp")
	if(mySession.equals("OFF")) {
		String errMsg = URLEncoder.encode("잘못된 접근 입니다. 로그인 먼저 해주세요", "utf-8");
		response.sendRedirect("/diary/loginForm.jsp?errMsg="+errMsg);
		return; // 코드 진행을 끝내는 문법 ex) 메서드 끝낼때 return사용
	}
	String checkDate = request.getParameter("checkDate");
	
	String sql2 = "select diary_date diaryDate from diary where diary_date=?";
	// 결과가 있으면 이미 이날짜에 일기가 있다 -> 이날짜로는 입력X
	
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
	stmt2 = conn.prepareStatement(sql2);
	stmt2.setString(1, checkDate);
	rs2 = stmt2.executeQuery();
	
	PreparedStatement stmt3 = null;
	ResultSet rs3 = null;
	if(rs2.next()) {
		//  이 날짜 일기 기록 불가능(이미존재)
		String msg = "해당 날짜에 기등록된 일기 기록이 존재합니다.";
		response.sendRedirect("/diary/addDiaryForm.jsp?checkDate="+checkDate+"&tf=f&msg="+msg);
	} else {
		//  이날짜 일기 기록 가능
		String sql3 = "INSERT INTO diary(diary_date, feeling, title, weather, content, update_date, create_date)"
			+ "VALUES(?, ?, ?, ?, ?, NOW(), NOW())";
		System.out.println("sql3 : " + sql3);
		stmt3 = conn.prepareStatement(sql3);
		stmt3.setString(1, diaryDate);
		stmt3.setString(2, feeling);
		stmt3.setString(3, title);
		stmt3.setString(4, weather);
		stmt3.setString(5, content);
		rs3 = stmt3.executeQuery();
		response.sendRedirect("/diary/diary.jsp");
	}
%>