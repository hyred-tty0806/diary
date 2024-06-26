<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	Connection conn = null;
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");	
	String menuStr = "";

	Calendar target = Calendar.getInstance();
	int targetYear = target.get(Calendar.YEAR);
	int targetMonth = target.get(Calendar.MONTH)+1;
	int targetDay = target.get(Calendar.DATE);
	String currentDateStr = ""+targetYear +"-"+ targetMonth +"-"+ targetDay;
	System.out.println("target year : " + targetYear);
	System.out.println("target month : " + targetMonth);
	System.out.println("target day : " + targetDay);
	System.out.println("currentDateStr : " + currentDateStr);

	String sql1 = "SELECT lunch_date, menu, updated_date, create_date FROM lunch WHERE lunch_date = ?";
	stmt1 = conn.prepareStatement(sql1);
	stmt1.setString(1, currentDateStr);
	rs1 = stmt1.executeQuery();
	String lunchDate = "";
	String menu = "";
	String updatedDate = "";
	String createDate = "";
	boolean foundOrNotFound = false;

	if(rs1.next()){
		lunchDate = rs1.getString("lunch_date");
		menu = rs1.getString("menu");
		updatedDate = rs1.getString("updated_date");
		createDate = rs1.getString("create_date");
		foundOrNotFound = true;
	}else{
		System.out.println("today data is nothing");
		foundOrNotFound = false;
	}
	
	System.out.println("lunchDate : " + lunchDate);
	System.out.println("menu : " + menu);
	System.out.println("updatedDate : " + updatedDate);
	System.out.println("createDate : " + createDate);
	System.out.println("foundOrNotFound : " + foundOrNotFound);
	
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Lunch One</title>
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
					<a href="/diary/diary.jsp" class="list-group-item list-group-item-action">
						Diary			
					</a>
					<a href="/diary/statsLunch.jsp" class="list-group-item list-group-item-action">
						Lunch Statistics	
					</a>
					<a href="/diary/logout.jsp" class="list-group-item list-group-item-action">
						Logout
					</a>
				</div>
			</div>
			<div class="mt-5 mb-1 col-7 border border-success shadow p-3  bg-body-tertiary rounded">
			<%if(foundOrNotFound){%>
				<form action="./lunchDeleteAction.jsp" method="get">
					<table class="table">
						<colgroup>
							<col style="width: 40%;">
							<col style="width: 60%;">
						</colgroup>
						<thead>
							<th colspan="2">Information</th>
						</thead>
						<tbody>
							<tr>
								<td>Lunch Date</td>
								<td>
									<%=lunchDate%>
									<input type="hidden" value="<%=lunchDate%>" name="lunchDate">
								</td>
							</tr>
							<tr>
								<td>Menu</td>
								<td><%=menu%></td>
							</tr>
							<tr>
								<td>Updated Date</td>
								<td><%=updatedDate%></td>
							</tr>
							<tr>
								<td>Created Date</td>
								<td><%=createDate%></td>
							</tr>
							<tr>
								<td colspan="2" style="text-align: center;">
									<button type="submit" class="btn btn-primary">DELETE</button>
								</td>
							</tr>
						</tbody>
					</table>
				</form>
			<%}else{%>
				<form action="./lunchInsertAction.jsp" method="get">
					<table class="table">
						<colgroup>
							<col style="width: 40%;">
							<col style="width: 60%;">
						</colgroup>
						<thead>
							<th colspan="2">Information</th>
						</thead>
						<tbody>
							<tr>
								<td>Date</td>
								<td><input type="text" name="currentDateStr" value="<%=currentDateStr%>"></td>
							</tr>
							<tr>
								<td>Menu</td>
								<td>
									<label for="m1">한식</label>
									<input type="radio" id="m1" name="menu" value="1">
									<label for="m2">중식</label>
									<input type="radio" id="m2" name="menu" value="2">
									<label for="m3">일식</label>
									<input type="radio" id="m3" name="menu" value="3">
									<label for="m4">양식</label>
									<input type="radio" id="m4" name="menu" value="4">
									<label for="m5">기타</label>
									<input type="radio" id="m5" name="menu" value="5">
								</td>
							</tr>
							<tr>
								<td colspan="2" style="text-align: center;">
									<button type="submit" class="btn btn-primary">SUBMIT</button>
								</td>
							</tr>
						</tbody>
					</table>
				</form>
			<%}%>
			</div>
			<div class="col"></div>
		</div>
	</div>
</body>
</html>