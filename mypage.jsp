<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet,
				 javax.sql.DataSource, javax.naming.InitialContext" %>
<%
	String id    = (String) session.getAttribute("id");
	String nick  = (String) session.getAttribute("nick");
	String birth = (String) session.getAttribute("birth");

	if(id == null) {
		response.sendRedirect("pages/login.jsp");
	}
	
	try {
		InitialContext ctx = new InitialContext();
		DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/mysql");
		Connection con = ds.getConnection();

		String sql = "SELECT * FROM webuser WHERE id=?";

		PreparedStatement s = con.prepareStatement(sql);
		s.setString(1, id);

		ResultSet r = s.executeQuery();

		if (r.next()) {
			nick = r.getString(3);
			birth = r.getString(4);
			
			session.setAttribute("nick", r.getString(3));
		}

		r.close();
		s.close();
		con.close();

	} catch (Exception e) {
		out.println("Connection Failed..");
		out.println(e.getMessage());
		e.printStackTrace();
	}
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
		<h2><%= nick %>님 환영합니다.</h2>
		<hr>
		<div>
			<h3>유저정보</h3>
			<p>닉네임 <%= nick %></p>
			<p>생년월일 <%= birth %></p>
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