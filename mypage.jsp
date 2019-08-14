<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String user = (String)session.getAttribute("ID");

	if(user == null)
		response.sendRedirect("pages/login.jsp");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>my page</title>
	<link rel="stylesheet" type="text/css" href="style/index.css">
</head>
<body>
	<%@ include file="pages/header.jsp" %>
	<main>
		
	</main>
</body>
</html>