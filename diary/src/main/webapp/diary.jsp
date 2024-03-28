<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.sql.*"%>
<%
	// 로그인(인증) 분기
	// diary.login.my_ssesion => 'OFF' => redirect("loginForm.jsp")
	
	String sql1 = "select my_session mySession from login";
	Connection conn = null;
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	
	Class.forName("org.mariadb.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");	
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
	
	String sql = "SELECT COUNT(*) FROM diary"; // --> 전체 행의 수
	PreparedStatement stmt = null;
	ResultSet rs = null;
	stmt = conn.prepareStatement(sql);
	rs = stmt.executeQuery();
	
	int currentPage = 1; // 1. 처음이면 1페이지 
	if(request.getParameter("currentPage") != null){ // 요청된 파라미터가 있으면
		// 페이지 이동하여 currentPage 값을 받았을 때
		currentPage = Integer.parseInt(request.getParameter("currentPage"));	
	}
	
	int totalRow = 0;
	if(rs.next()){
		totalRow = rs.getInt("count(*)");
	}
	System.out.println("totalRow : " + totalRow);

	int rowPerPage = 10; 
	int lastPage = totalRow / rowPerPage;
	if(totalRow%rowPerPage != 0){
		lastPage = lastPage + 1;
	}
	
	String sql2 = "SELECT diary_date, title, weather, content, update_date, create_date FROM diary order by diary_date DESC LIMIT ?, ?";
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
	stmt2 = conn.prepareStatement(sql2);
	stmt2.setInt(1, (currentPage-1)*rowPerPage);
	stmt2.setInt(2, rowPerPage);
	rs2 = stmt2.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>diary</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</head>
<body>
	<div class="container">	
		<div class="row">
			<div class="col">
				<h1>Diary</h1>
				<div class="list-group">
					<a href="/diary/calendar.jsp" class="list-group-item list-group-item-action">
						Calendar
					</a>
					<a href="/diary/addDiaryForm.jsp" class="list-group-item list-group-item-action">
						Write	
					</a>
					<a href="/diary/lunchOne.jsp" class="list-group-item list-group-item-action">
						Lunch Voting	
					</a>
					<a href="/diary/statsLunch.jsp" class="list-group-item list-group-item-action">
						Lunch Statistics	
					</a>
					<a href="/diary/logout.jsp" class="list-group-item list-group-item-action">
						Logout
					</a>
				</div>
			</div>
			<div class="mt-1 mb-1 col-7 border border-success shadow p-3  bg-body-tertiary rounded" style="">
	<table class="table table-hover">
		<thead>
			<tr>
				<th>diary_date</th>
				<th>title</th>
				<th>weather</th>
				<th>content</th>
				<th>update_date</th>
				<th>create_date</th>
			</tr>
		</thead>
		<tbody>
			<%
				while(rs2.next()){ 
			%>
					<tr>
						<td>
							<%=rs2.getString("diary_date")%>
						</td>
						<td>
							<a href="/diary/diaryOne.jsp?diaryDate=<%=rs2.getString("diary_date")%>">
								<%=rs2.getString("title")%>
							</a>
						</td>
						<td>
							<%=rs2.getString("weather") %>
						</td>
						<td>
							<%=rs2.getString("content") %>
						</td>
						<td>
							<%=rs2.getString("update_date") %>
						</td>
						<td>
							<%=rs2.getString("create_date") %>				
						</td>
					</tr>
			<% 
				} 
			%>
		</tbody>
	</table>
	<nav aria-label="Page navigation example">
		<ul class="pagination justify-content-center">
			<% 
				if(currentPage > 1){
			%>
					<li class="page-item"><a class="page-link" href="./diary.jsp?currentPage=1">FIRST</a></li>
					<li class="page-item"><a class="page-link" href="./diary.jsp?currentPage=<%=currentPage-1%>">PREV</a></li>
			<%
				}else{
			%>
					<li class="page-item"><a class="page-link" href="#">FIRST</a></li>
					<li class="page-item"><a class="page-link" href="#">PREV</a></li>						
			<% 
				}
			%>
				 <li class="page-item"><a class="page-link" href="#"><%=currentPage%></a></li>
			<%
				if(currentPage < lastPage){	
			%>
			   		<li class="page-item"><a class="page-link" href="./diary.jsp?currentPage=<%=currentPage+1%>">NEXT</a></li>
				 	<li class="page-item"><a class="page-link" href="./diary.jsp?currentPage=<%=lastPage+1%>">LAST</a></li>
			<% 
				}else{
			%>
			   		<li class="page-item"><a class="page-link" href="#">NEXT</a></li>						
				 	<li class="page-item"><a class="page-link" href="#">LAST</a></li>
			<% 
				}
			%>
		</ul>
	</nav>
	</div>
	<div class="col"></div>
	</div>
</div>
</body>
</html>