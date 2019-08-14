<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");

	String id  = request.getParameter("uid");
	String pwd = request.getParameter("upwd");
	
	out.println("<p>" + "id: " + id + "</p>");
	out.println("<p>" + "pwd: " + pwd + "</p>");
	
	/*
	id 존재하면
		패스워드확인
		맞으면
			(id) session 설정
			redirect to index
		아니면
			패스워드 오류
	없으면
		아이디 오류
	*/
	
	// finally
	id = null;
	pwd = null;
%>