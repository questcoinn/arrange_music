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
				<input type="submit" id="calendar-submit">
			</form>
			<div id="feed">
				<span class="date">8.1.</span>
				<p class="album">
					<span class="artist">Black Milk</span>
					<span class="title">DIVE (EP)</span>
				</p>
				<p class="album">
					<span class="artist">Black Milk</span>
					<span class="title">DIVE (EP)</span>
				</p>
				<p class="album">
					<span class="artist">Black Milk</span>
					<span class="title">DIVE (EP)</span>
				</p>
				<p class="album">
					<span class="artist">Black Milk</span>
					<span class="title">DIVE (EP)</span>
				</p>
				<span class="date">8.11.</span>
				<p class="album">
					<span class="artist">Black Milk</span>
					<span class="title">DIVE (EP)</span>
				</p>
				<p class="album">
					<span class="artist">Black Milk</span>
					<span class="title">DIVE (EP)</span>
				</p>
				<span class="date">12.28.</span>
				<p class="album">
					<span class="artist">Black Milk</span>
					<span class="title">DIVE (EP)</span>
				</p>
				<p class="album">
					<span class="artist">Black Milk</span>
					<span class="title">DIVE (EP)</span>
				</p>
				<p class="album">
					<span class="artist">Black Milk</span>
					<span class="title">DIVE (EP)</span>
				</p>
			</div>
		</article>
		<article id="calendar-info">
			설명
		</article>
	</main>
</body>
</html>