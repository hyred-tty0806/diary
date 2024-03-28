<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% 
	String tf = request.getParameter("tf");
	String checkDate = "";
	String msg = null;
	
	if(tf == null){
		tf = "";
	}
	if(tf.equals("t")){
		checkDate = request.getParameter("checkDate");
	}else if(tf.equals("f")){
		checkDate = request.getParameter("checkDate");		
		msg = request.getParameter("msg");		
	}
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>addDiaryForm</title>
</head>
<body>
	<h1>일기쓰기</h1>
	<form method="post" action="/diary/checkDateAction.jsp">
		<div>
			<label for="checkDate">날짜확인 : </label>
			<input type="date" name="checkDate" id="checkDate" value="<%=checkDate%>">
		</div>
		<button type="submit">기등록날짜 확인</button>
	</form>
	<% 
		if(tf.equals("f")){
	%>
			<%=msg%>
	<% 
		}
	%>
	<form action="./addDiaryAction.jsp" method="post">
		<div>
			<label for="diaryDate">날짜 : </label>
			<input type="text" id="diaryDate" name="diaryDate" readonly="readonly" 
			value="<%=tf.equals("t") ? checkDate : ""%>" 
			required="required">
		</div>	
		<div>
			기분 : 
			<input type="radio" name="feeling" value="&#128512;">&#128512;
			<input type="radio" name="feeling" value="&#128545;">&#128545;
		</div>	
		<div>
			<label for="title">제목 : </label><input type="text" name="title" id="title">
		</div>	
		<div>
			<select name="weather">
				<option value="맑음">맑음</option>
				<option value="흐림">흐림</option>
				<option value="비">비</option>
				<option value="눈">눈</option>
			</select>
		</div>	
		<div>
			<textarea rows="7" cols="50" name="content"></textarea>
		</div>
		<div>
			<button type="submit">제출</button>
		</div>
	</form>
</body>
</html>