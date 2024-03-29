<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>sign in</title>
	<link rel="stylesheet" type="text/css" href="/style/index.css">
	<link rel="stylesheet" type="text/css" href="/style/signin.css">
</head>
<body>
	<%@ include file="/pages/header.jsp" %>
	<form action="signsubmit.jsp" method="post" id="sign-form">
		<div class="item" id="uid" required>
			<label for="uid">아이디</label>
			<input type="text" name="uid" id="uid-in" required>
			<input type="button" value="중복확인" id="check" >
			<p class="info"></p>
		</div>
		<div class="item" id="upwd" required>
			<label for="upwd">패스워드</label>
			<input type="password" name="upwd" id="upwd-in" required>
		</div>
		<div class="item" id="upwd-cfg" required>
			<label for="upwd-cfg">패스워드확인</label>
			<input type="password" id="upwd-cfg-in" required>
			<p class="info"></p>
		</div>
		<div class="item" id="unick" required>
			<label for="unick">닉네임</label>
			<input type="text" name="unick" id="unick-in" required>
		</div>
		<div class="item unreq" id="ubirth">
			<label for="ubirth">생년월일</label>
			<input type="date" name="ubirth">
		</div>
		<div>
			<input type="submit" value="회원가입" id="submit">
		</div>
	</form>
	
	<script src="/script/ajax.js"></script>
	<script src="/script/signin.js"></script>
</body>
</html>