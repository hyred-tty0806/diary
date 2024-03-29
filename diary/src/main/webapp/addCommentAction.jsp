<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="common.Common"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Common common = new Common();
	/* 전달 파라미터 */
	String diaryDate = request.getParameter("diaryDate");
	String memo = request.getParameter("memo");
	if(diaryDate == null){
		common.msgRedirect("./diaryOne.jsp", "");
		return;
	}else{
		System.out.println("diaryDate : " + diaryDate);
		System.out.println("memo : " + memo);
	}
	/* 전달 파라미터 */
	
	/* ******DB 연결***** */
	common.DBConnection();
	/* ******DB 연결***** */
	
	/* DB 연결 기본 객체 */
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	String sql1 = "";
	/* 
		INSERT INTO diary(diary_date, feeling, title, weather, content, update_date, create_date)"
		+ "VALUES(?, ?, ?, ?, ?, NOW(), NOW()) 
	*/
	/* DB 연결 기본 객체 */
	String sql = "insert INTO COMMENT(diary_date, memo, update_date, create_date) VALUES "
			+"(?, ?, NOW(), NOW())";
	List<String> sqlParams = new ArrayList<String>();
	sqlParams.add(diaryDate);
	sqlParams.add(memo);
	ResultSet rs = common.sqlResult(sql, sqlParams);
	response.sendRedirect("/diary/diaryOne.jsp?diaryDate="+diaryDate);
	return;
%>