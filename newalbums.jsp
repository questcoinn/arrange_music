<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Calendar" %>
<%
	Calendar c = Calendar.getInstance();

	final int YEAR  = c.get(Calendar.YEAR);
	final int MONTH = c.get(Calendar.MONTH) + 1;
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>new albums</title>
	<link rel="stylesheet" type="text/css" href="style/index.css">
	<link rel="stylesheet" type="text/css" href="style/newalbums.css">
</head>
<body>
	<%@ include file="pages/header.jsp" %>
	<main>
		<jsp:include page="pages/loginBox.jsp" />
		
		<article id="calendar">
			<form action="" method="post">
				<select id="year" name="year">
					<%
						for (int i = 2013; i <= 2019; i++) {
							if (i == YEAR) {
								out.println(String.format("<option value=\"%d\" selected>%d</option>", i, i));
							} else {
								out.println(String.format("<option value=\"%d\">%d</option>", i, i));
							}
						}
					%>
				</select>
				<select id="month" name="month">
					<%
						for (int i = 1; i <= 12; i++) {
							if (i == MONTH) {
								out.println(String.format("<option value=\"%d\" selected>%d</option>", i, i));
							} else {
								out.println(String.format("<option value=\"%d\">%d</option>", i, i));
							}
						}
					%>
				</select>
			</form>
			<div id="feed"></div>
		</article>
		<article id="calendar-info"></article>
	</main>
	
	<script src="/script/newalbums.js"></script>
</body>
</html>