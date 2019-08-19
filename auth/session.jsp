<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	session.setMaxInactiveInterval(-1);

	String id  = request.getParameter("uid");
	session.setAttribute("id", id);
	
	response.sendRedirect("/mypage.jsp");
%>