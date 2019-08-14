<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
			날짜 앨범
		</article>
		<article id="calendar-info">
			설명
		</article>
	</main>
</body>
</html>