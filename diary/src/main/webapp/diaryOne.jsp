<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	String diaryDate = request.getParameter("diaryDate");
	System.out.println("diaryDate : " + diaryDate);

	Connection conn = null;
	Class.forName("org.mariadb.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
	
	String sql1 = "SELECT diary_date, feeling, title, weather, content, update_date, create_date FROM diary WHERE diary_date = ?";
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	
	stmt1 = conn.prepareStatement(sql1);
	stmt1.setString(1, diaryDate);
	rs1 = stmt1.executeQuery();	
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>addDiaryForm</title>
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
					<a href="/diary/logout.jsp" class="list-group-item list-group-item-action">
						Logout
					</a>
				</div>
			</div>
			<div class="mt-5 mb-1 col-7 border border-success shadow p-3  bg-body-tertiary rounded" style="">
				<% 
					if(rs1.next()){
				%>
						<div class="mb-3">
							<label for="exampleFormControlInput1" class="form-label">diary date</label>
							<input type="text" class="form-control" id="exampleFormControlInput1" value="<%=rs1.getString("diary_date")%>" readonly>
						</div>
						<div class="mb-3">
							<label for="exampleFormControlTextarea1" class="form-label">title</label>
							<input type="text" class="form-control" id="exampleFormControlInput1" value="<%=rs1.getString("title")%>" readonly>							
						</div>
						<div class="mb-3">
							<label for="exampleFormControlInput1" class="form-label">weather</label>
							<input type="text" class="form-control" id="exampleFormControlInput1" value="<%=rs1.getString("weather")%>" readonly>
						</div>
						<div class="mb-3">
							<label for="exampleFormControlTextarea1" class="form-label">content</label>
							<textarea class="form-control" id="exampleFormControlTextarea1" readonly><%=rs1.getString("content")%></textarea>
						</div>
				<% 
					}
				%>
					<div class="row">
					    <div class="col">
							<a href="" class="btn btn-primary" style="color:white; display: block;">UPDATE</a>
					    </div>
					    <div class="col">
							<a href="" class="btn btn-primary" style="color:white; display: block;">DELETE</a>      
					    </div>
					    <div class="col">
							<a href="./diary.jsp" class="btn btn-primary" style="color:white; display: block;">LIST</a>
					    </div>
					</div>
			</div>
			<div class="col"></div>
		</div>
	</div>

</body>
</html>