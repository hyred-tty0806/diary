<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<% 
	// 1. 요청 분석
	// 출력하고자는 달력의 년과 월값을 넘겨받음
	String targetYear = request.getParameter("targetYear");
	String targetMonth = request.getParameter("targetMonth");
	
	Calendar target = Calendar.getInstance();
	int day = target.get(Calendar.DATE);
	
	if(targetYear == null || targetMonth == null){
		target.set(Calendar.DATE, 1); // 2024/3/8 -> 2024/3/1변경		
	} else {
		target.set(Calendar.YEAR, Integer.parseInt(targetYear)); // 원하는 년도
		target.set(Calendar.MONTH, Integer.parseInt(targetMonth)); // 원하는 월
		target.set(Calendar.DATE, 1); // 1일
	}
	
	//타이틀로 사용할 현 연과 현 월
	int tYear = target.get(Calendar.YEAR);
	int tMonth = target.get(Calendar.MONTH);
	System.out.println("tMonth : " + tMonth);
	// 시작공백의 개수 -> 1일의 요일이 필요 -> 타겟 날짜를 1일로 변경
	int yoNum = target.get(Calendar.DAY_OF_WEEK); // 일:0, 월:1, .....토:6
	System.out.println(yoNum);
	
	int startBlank = yoNum - 1;
	int lastDate = target.getActualMaximum(Calendar.DATE);
	System.out.println("lastDate : " + lastDate);

	int afterBlank = 0;
	
	// 7) 전체 TD개수는 7로 나누어 떨어져야 한다
	if((startBlank + lastDate + afterBlank)%7 != 0) {
		// 1이 남는다 -> 6개의 TD가 필요
		// 2가 남는다 -> 5개의 TD가 필요
		afterBlank = 7 - (startBlank + lastDate + afterBlank)%7;
	}
	// 8) 전체 TD의 개수는
	int countDiv = startBlank + lastDate + afterBlank;	
	
	
	String sql1 = "select day(diary_date) day, left(title,5) title from diary where year(diary_date)=? and month(diary_date)=?";
	Connection conn = null;
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
	stmt1 = conn.prepareStatement(sql1);
	stmt1.setInt(1, tYear);
	stmt1.setInt(2, (tMonth+1));
	
	System.out.println("stmt1 : " + stmt1);
	rs1 = stmt1.executeQuery();
	


/* 	int dbday = 0;
	String title = "";
	if(rs1.next()){
		dbday = Integer.parseInt(rs1.getString("day"));
		title = rs1.getString("title");
	} */
/* 	System.out.println("dbday : " + dbday);
	System.out.println("title : " + title); */
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>달력</title>
<!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<style>
	.cell {
		float: left;
		background-color: #F2CB61;
		width: 100px; height: 100px;
		border: 1px solid #8C8C8C;
		border-radius: 5px;
		margin: 3px;
	}
	.sun {
		clear: both;
		color: #FF0000;
	}
	.sat {
		color: #0054FF;
	}
	.base-ground {
		background-color:  #F2CB61;	
	}
	.in-date {
		text-align: left; vertical-align: top;
	}
	.th-seven {
		clear: both;
		color: #FF0000;
	}
	.title{
		border: 1px solid #8C8C8C;
		border-radius: 5px;
		margin-left: 8px;
	}
</style>
</head>
<body>
	<div class="container">	
		<div class="row">
			<div class="col">
				<h1>Diary</h1>
				<div class="list-group">
					<a href="/diary/diary.jsp" class="list-group-item list-group-item-action">
						Diary			
					</a>
					<a href="/diary/logout.jsp" class="list-group-item list-group-item-action">
						Logout
					</a>
				</div>
			</div>
			<div class="mt-1 mb-1 col-8 border border-success shadow p-3  bg-body-tertiary rounded" style="">
				<div style="" class="title mb-1">
					<h1 style="text-align: center;">
						<%=tYear%>년 <%=tMonth+1%>월
					</h1>	
				</div>
				<div>
				  	<a class="btn btn-success" href="./calendar.jsp?targetYear=<%=tYear%>&targetMonth=<%=tMonth-1%>" style="margin-right: 630px; margin-left: 10px;">이전달</a>
					<a class="btn btn-success" href="./calendar.jsp?targetYear=<%=tYear%>&targetMonth=<%=tMonth+1%>">다음달</a>						  		
				</div>
				<div class="cell th-seven">일</div>
				<div class="cell">월</div>
				<div class="cell">화</div>
				<div class="cell">수</div>
				<div class="cell">목</div>
				<div class="cell">금</div>
				<div class="cell">토</div>
				<!-- DATE값이 들어갈 DIV -->
				<%
					for(int i=1; i<=countDiv; i=i+1) {
						if(i%7 == 1) {		
				%>
							<%
								if(i-startBlank == day){
							%>
									<div class="cell sun in-date th-seven" style="background-image: url(./choppa2.png); background-size: cover">										
							<% 
								}else{
							%>
									<div class="cell sun in-date th-seven">					
							<% 
								}
							%>
				<%			
						} else if(i%7 == 0){
				%>	
							<%
								if(i-startBlank == day){
							%>
									<div class="cell sat in-date" style="background-image: url(./choppa2.png); background-size: cover">											
							<% 
								}else{
							%>
									<div class="cell sat in-date">					
							<% 
								}
							%>
				<%
						}else{
				%>
							<%
								if(i-startBlank == day){
							%>
									<div class="cell in-date" style="background-image: url(./choppa2.png); background-size: cover">									
							<% 
								}else{
							%>
									<div class="cell in-date">					
							<% 
								}
							%>
				<%				
						}
							if(i-startBlank > 0  && i-startBlank <= lastDate) {
						%>
								
								<%=i-startBlank%>
							 	<% 
									while(rs1.next()){
										System.out.println("i-startBlank : " + (i-startBlank));
										System.out.println("dbday : " + Integer.parseInt(rs1.getString("day")));
								%>
									<%
										if(i-startBlank == Integer.parseInt(rs1.getString("day"))){  
									%>
											<div>day : <%=rs1.getString("day")%></div>
											<div>title : <%=rs1.getString("title")%></div>
									<% 
										}
									%>
								<% 
									}
							 		rs1.beforeFirst();
								%>
						<%		
							} else {
						%>
								&nbsp;
						<%		
							}
						%>
						
							
						
						</div>
					<%		
						}
					%>
			</div>
			<div class="col"></div>
		</div>
	</div>
</body>
</html>