<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%
/* 	// 0. 
	String sql1 = "select my_session mySession from login";
 */
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection(
			"jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
	
	/* 
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	stmt1 = conn.prepareStatement(sql1);
	rs1 = stmt1.executeQuery();
	
	String mySession = null;
	if(rs1.next()) {
		mySession = rs1.getString("mySession");
	} 
	*/
	
	/* ?? 	
	if(mySession.equals("ON")) {
		response.sendRedirect("/diary/loginForm.jsp");
		return; // 코드 진행을 끝내는 문법 ex) 메서드 끝낼때 return사용
	} */

	// 1. 요청값 분석
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	
	/* ********로그인 상태 체크****** */
	String idOnSession = (String)(session.getAttribute("idOnSession"));
	boolean userLogin = false;
	userLogin = idOnSession == null ? false : true;
	if(userLogin){
		response.sendRedirect("/diary/diary.jsp");
		return;
	}else{
		// 로그인을 하지 않은 경우의 코드진행
		String sql2 = "select member_id memberId from member where member_id=? and member_pw=?";
		PreparedStatement stmt2 = null;
		ResultSet rs2 = null;
		stmt2 =	conn.prepareStatement(sql2);
		stmt2.setString(1, memberId);
		stmt2.setString(2, memberPw);
		rs2 = stmt2.executeQuery();
		if(rs2.next()) {
			// 로그인 성공
			System.out.println("로그인 성공");
			// diary.login.my_session -> "ON" 변경
			/* String sql3 = "update login set my_session = 'ON', on_date = NOW()";
			PreparedStatement stmt3 = conn.prepareStatement(sql3);
			int row = stmt3.executeUpdate(); */
			session.setAttribute("idOnSession", rs2.getString("memberId"));
			response.sendRedirect("/diary/diary.jsp");
		} else {
			// 로그인 실패
			System.out.println("로그인 실패");
			String errMsg = URLEncoder.encode("아이디와 비밀번호를 확인 해주세요", "utf-8");
			response.sendRedirect("/diary/loginForm.jsp?errMsg="+errMsg);
		}
	}
	/* ********로그인 상태 체크****** */
	
%>