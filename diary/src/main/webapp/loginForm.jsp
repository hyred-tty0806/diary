<%@page import="java.net.URLEncoder"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	/* ******DB 연결***** */
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");	
	/* ******DB 연결***** */
	
	/* DB 연결 기본 객체 */
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	String sql1 = "";
	/* DB 연결 기본 객체 */
	
	/* ********로그인 상태 체크****** */
	String idOnSession = (String)(session.getAttribute("idOnSession"));
	boolean userLogin = false;
	userLogin = idOnSession == null ? false : true;
	if(userLogin){
		response.sendRedirect("/diary/diary.jsp");
		return;
	}else{
		// 로그인을 하지 않은 경우의 코드진행
	}
	/* ********로그인 상태 체크****** */
	
	
	// 로그인(인증) 분기
	// diary.login.my_ssesion => 'ON' => redirect("diary.jsp")
	String errMsg = request.getParameter("errMsg");
	System.out.println("errMsg : " + errMsg);
		 

	/* 
		기존 로그인 on/off 체크 후 리다이렉트 코드 
		로그인 기록 용도로 바꿀 예정
	*/
	/* 	
		PreparedStatement stmt1 = null;
		ResultSet rs1 = null;
		String sql1 = "select my_session mySession from login";
		stmt1 = conn.prepareStatement(sql1);
		rs1 = stmt1.executeQuery();
		String mySession = null;
		if(rs1.next()){
			mySession = rs1.getString("mySession");
		}
		if(mySession.equals("ON")) {
			errMsg = URLEncoder.encode("잘못된 접근 입니다. 로그인 아웃을 먼저 해주세요.", "utf-8");
			response.sendRedirect("/diary/diary.jsp?errMsg="+errMsg);
			return; // 코드 진행을 끝내는 문법 ex) 메서드 끝낼때 return 사용
		} 
	*/

%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</head>
<body>
	<div class="container text-center">
		<div class="row align-items-center mt-5">
			<div class="col"></div>
			<div class="col">
				<h1>LOGIN</h1>
				<form method="post" action="/diary/loginAction.jsp">
					<div class="mb-3 row">
						<label for="staticEmail" class="col-sm-3 col-form-label">ID</label>
						<div class="col-sm-9">
							<input type="text" class="form-control"  name="memberId" id="memberId" value="">
						</div>
					</div>
					<div class="mb-3 row">
						<label for="inputPassword" class="col-sm-3 col-form-label">PASSWORD</label>
						<div class="col-sm-9">
							<input type="password" class="form-control" id="inputPassword" name="memberPw" id="memberPw" value="">
						</div>
					</div>
					<button type="submit" class="btn btn-success">로그인</button>
				</form>
				<div>
				<% 
					if(errMsg != null) {
				%>
						<%=errMsg%>		
				<%
					} 
				%>
				</div>
			</div>
			<div class="col"></div>
		</div>
	</div>

</body>
</html>