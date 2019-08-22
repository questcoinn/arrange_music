<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet,
				 javax.sql.DataSource, javax.naming.InitialContext" %>
<%
	request.setCharacterEncoding("utf-8");

	String artist = request.getParameter("artist");
	String title  = request.getParameter("title");
	String rDate   = "";
	String imgName = "";
	int recommend  = 0;
	String desc    = "";
	
	if(artist == null || title == null)
		response.sendRedirect("/");
	
	try {
		InitialContext ctx = new InitialContext();
		DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/mysql");
		Connection con = ds.getConnection();
		
		String sql = "SELECT * FROM album WHERE artist=? AND title=?";

		PreparedStatement s = con.prepareStatement(sql);
		s.setString(1, artist);
		s.setString(2, title);
		
		ResultSet r = s.executeQuery();
		
		while(r.next()) {
			rDate     = r.getString(4);
			imgName   = r.getString(5);
			recommend = Integer.parseInt(r.getString(6));
			desc      = r.getString(7);
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
	<title>update</title>
	<link rel="stylesheet" type="text/css" href="/style/index.css">
	<link rel="stylesheet" type="text/css" href="/style/form.css">
</head>
<body>
	<%@ include file="/pages/header.jsp" %>
	<main>
		<form action="/db/update.jsp" enctype="multipart/form-data" method="post">
			<div id="title-container">
				<%
					out.println("<input type=\"text\" name=\"artist\" placeholder=\"아티스트*\" id=\"artist-in\" value=\"" + artist + "\">");
					out.println("<input type=\"text\" name=\"title\" placeholder=\"앨범이름*\" id=\"title-in\" value=\"" + title + "\">");
				%>
			</div>
			<div id="date-container">
				<label for="r_date">발매일</label>
				<%
					out.println("<input type=\"date\" name=\"r_date\" id=\"date-in\" value=\"" + rDate + "\">");
				%>
			</div>
			<div id="dsc-container">
				<textarea name="dsc" placeholder="상세"><%= desc %></textarea>
			</div>
			<div id="file-container">
				<div>
					<p style="margin: 0;">현재 앨범커버</p>
					<%
						out.println("<img src=\"/images/" + imgName + "\" style=\"width: 100px;\">");
						out.println("<input type=\"hidden\" name=\"curImg\" value=\"" + imgName + "\">");
					%>
				</div>
				<div>
					<label for="img">새로운 앨범커버</label>
				</div>
				<input type="file" name="img" accept=".jpg, .jpeg, .png">
			</div>
			<div>
				<input type="submit" value="저장" id="submit">
			</div>
		</form>
	</main>
</body>
</html>