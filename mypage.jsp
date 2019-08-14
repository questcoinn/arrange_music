<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String user = (String)session.getAttribute("ID");

	if(user == null)
//		response.sendRedirect("pages/login.jsp");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>my page</title>
	<link rel="stylesheet" type="text/css" href="style/index.css">
	<link rel="stylesheet" type="text/css" href="style/mypage.css">
</head>
<body>
	<%@ include file="pages/header.jsp" %>
	<main>
		<h2><%= user %>님 환영합니다.</h2>
		<hr>
		<div>
			<h3>유저정보</h3>
			<p>닉네임 ~~</p>
			<p>생년월일 ~~</p>
			<p>총 플레이시간 ~~~</p>
		</div>
		<hr>
		<div>
			<h3>최근 추천한 앨범</h3>
			<p>ㅁㄴㅇㅁㄴ</p>
			<p>ㅁㄴㅇㅁㄴ</p>
			<p>ㅁㄴㅇㅁㄴ</p>
		</div>
		<hr>
		<div>
			<h3>들었던 앨범</h3>
			<p>ㅁㄴㅇㅁㄴ</p>
			<p>ㅁㄴㅇㅁㄴ</p>
			<p>ㅁㄴㅇㅁㄴ</p>
			<p id="etc">...</p>
			<input type="button" value="펼치기">
		</div>
		<hr>
	</main>
</body>
</html>