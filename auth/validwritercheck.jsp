<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");

	String reader = (String) session.getAttribute("id");
	
	out.println(reader);
%>