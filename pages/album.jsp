<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet,
				 javax.sql.DataSource, javax.naming.InitialContext" %>
<%
	request.setCharacterEncoding("utf-8");

	String artist  = "";
	String title   = "";
	String rDate   = "";
	String imgName = "";
	int recommend  = 0;
	String desc    = "";
	String writer  = "";
	String heard   = "";
	
	try {
		artist = request.getParameter("artist");
		title  = request.getParameter("title");
	
	} catch(Exception e) {
		artist = null;
		title = null;
	}
	
	try {
		InitialContext ctx = new InitialContext();
		DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/mysql");
		Connection con = ds.getConnection();
		
		String sql = "SELECT * FROM album WHERE "
			+ "artist='" + escapeQuotes(artist) + "' AND "
			+ "title='" + escapeQuotes(title) + "'";

		PreparedStatement s = con.prepareStatement(sql);
		
		ResultSet r = s.executeQuery();
		
		while(r.next()) {
			rDate     = r.getString(4);
			imgName   = r.getString(5);
			recommend = Integer.parseInt(r.getString(6));
			desc      = r.getString(7).trim().replaceAll("[\n]", "<br>");
			writer	  = r.getString(8);
		}
		
		String user = (String) session.getAttribute("id");
		sql = "SELECT * FROM webuser_info WHERE "
			+ "userid='" + user + "' AND "
			+ "artist='" + escapeQuotes(artist) + "' AND "
			+ "title='" + escapeQuotes(title) + "'";
		
		s = con.prepareStatement(sql);
		r = s.executeQuery();
		
		heard = r.next()
			? r.getInt("heard") == 1
				? "heard"
				: "not-heard"
			: "not-heard";
		
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
	<title><%= artist + " - " + title %></title>
	<link rel="stylesheet" type="text/css" href="/style/index.css">
	<link rel="stylesheet" type="text/css" href="/style/eachAlbum.css">
</head>
<body>
	<%@ include file="/pages/header.jsp" %>
	<main>
		<jsp:include page="/pages/loginBox.jsp" />
		
		<h2>
			<span class="artist"><%= artist %></span>
			<span class="title"><%= title %></span>
		</h2>
		<div id="info">
			<p>발매일 <strong><%= rDate %></strong></p>
			<p>추천  <strong class="reco"><%= recommend %></strong></p>
			<p>작성자 <strong id="writer"><%= writer %></strong></p>
		</div>
		<hr>
		<div id="edit-btns">
			<form action="/pages/update.jsp" method="post">
				<input type="button" value="수정" id="update-fake">
				<%
					out.println("<input type=\"hidden\" name=\"artist\" value=\"" + artist + "\">");
					out.println("<input type=\"hidden\" name=\"title\" value=\"" + title + "\">");
				%>
				<input type="submit" value="수정" id="update-btn">
			</form>
			<form action="/db/delete.jsp" method="post" id="delete-form">
				<input type="button" value="삭제" id="delete-fake">
				<%
					out.println("<input type=\"hidden\" name=\"artist\" value=\"" + artist + "\">");
					out.println("<input type=\"hidden\" name=\"title\" value=\"" + title + "\">");
					out.println("<input type=\"hidden\" name=\"img\" value=\"" + imgName + "\">");
				%>
				<input type="submit" value="삭제" id="delete-btn">
			</form>
		</div>
		<div id="img-container">
			<%= "<img src=\"/images/" + imgName + "\">" %>
		</div>
		<p>
			<%= desc %>
		</p>
		<hr>
		<div class="album-btns">
			<input type="button" value="추천" class="reco-btn">
			<%= "<input type=\"button\" value=\"들었음\" class=\"heard-btn " + heard + "\">" %>
		</div>
	</main>
	
	<script src="/script/deleteCheck.js"></script>
	<script src="/script/validwritercheck.js"></script>
	<script src="/script/albumbtns.js"></script>
</body>
</html>

<%!
	private String escapeQuotes(String str) {
		if(str == null) return null;
	
		String result = str
			.replaceAll("'", "\\\\'")
			.replaceAll("\"", "\\\\\"");
		
		return result;
	}
%>