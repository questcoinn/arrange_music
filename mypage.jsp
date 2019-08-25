<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList,
				 java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet,
				 javax.sql.DataSource, javax.naming.InitialContext" %>
<%
	String id    = (String) session.getAttribute("id");
	String nick  = (String) session.getAttribute("nick");
	String birth = "";
	ArrayList<Album> albumList = new ArrayList<Album>();

	if(id == null)
		response.sendRedirect("pages/login.jsp");
	
	try {
		InitialContext ctx = new InitialContext();
		DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/mysql");
		Connection con = ds.getConnection();

		String sql = "SELECT * FROM webuser WHERE id='" + id + "'";

		PreparedStatement s = con.prepareStatement(sql);
		ResultSet r = s.executeQuery();

		if (r.next()) {
			nick = r.getString(3);
			birth = r.getString(4);
			
			session.setAttribute("nick", r.getString(3));
		}
		
		sql = "SELECT * FROM webuser_info WHERE userid='" + id + "' ORDER BY id DESC";
		s = con.prepareStatement(sql);
		r = s.executeQuery();
		
		while(r.next()) {
			Album album = new Album();
			
			album.artist      = r.getString("artist");
			album.title       = r.getString("title");
			album.recommended = r.getInt("recommended");
			album.heard       = r.getInt("heard");
			
			albumList.add(album);
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
		</div>
		<hr>
		<%
			final int SIZE = albumList.size();
			final int MAX_SIZE = Math.min(SIZE, 5);
		%>
		<div>
			<h3>최근 추천한 앨범</h3>
			<%
				int counter = 0;
			
				for(Album album: albumList) {
					if (album.recommended == 1) {
						out.println("<p>");
						out.println(album.artist + " - " + album.title);
						out.println("</p>");
						
						counter++;
					}
					
					if(counter == MAX_SIZE) break;
				}
			%>
		</div>
		<hr>
		<div>
			<h3>들었던 앨범</h3>
			<div id="heard-box">
				<%
					for(Album album: albumList) {
						if(album.heard == 1) {
							out.println("<p>");
							out.println(album.artist + " - " + album.title);					
							out.println("</p>");
						}
					}
				%>
			</div>
			<%= SIZE > 5 ? "<input type=\"button\" value=\"펼치기\" id=\"open-btn\">" : "" %>
		</div>
		<hr>
	</main>
	
	<script src="/script/mypage.js"></script>
</body>
</html>

<%!
	private class Album {
		String artist;
		String title;
		int recommended;
		int heard;
	}
%>