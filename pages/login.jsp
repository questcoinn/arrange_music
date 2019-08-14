<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>login</title>
	<link rel="stylesheet" type="text/css" href="/style/index.css">
	<link rel="stylesheet" type="text/css" href="/style/login.css">
</head>
<body>
	<%@ include file="header.jsp" %>
	<div id="login-box">
		<form action="auth/idcheck.jsp" method="post">
			<div>
				<input type="text" name="uid" placeholder="id" id="uid-box">
			</div>
			<div>
				<input type="password" name="upwd" placeholder="password" id="upwd-box">
			</div>
			<div id="login-btns">
				<input type="submit" value="로그인" id="login-btn">
				<a href="/auth/signin.jsp">
					<input type="button" value="회원가입" id="signin-btn">
				</a>
			</div>
		</form>

	</div>

</body>
</html>