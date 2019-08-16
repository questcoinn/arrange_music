<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");

	/*
		데이터베이스에 넣고
		세션 설정하고
		인덱스로 리디렉트
	*/
%>
<p><%= request.getParameter("uid") %></p>
<p><%= request.getParameter("upwd") %></p>
<p><%= request.getParameter("unick") %></p>
<p><%= request.getParameter("ubirth") %></p>