<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet,
				 javax.sql.DataSource, javax.naming.InitialContext" %>
<%
	final int N = 8;
	int _page = 1;	

	try {
		_page = Integer.parseInt(request.getParameter("page"));
	} catch(Exception e) {
		_page = 1;
	}
	
	int rows = 0;

	Connection con = null;
	PreparedStatement s = null;
	ResultSet r = null;

	try {
		InitialContext ctx = new InitialContext();
		DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/mysql");
		con = ds.getConnection();

		String sql = "SELECT COUNT(*) FROM album";
		
		s = con.prepareStatement(sql);
		r = s.executeQuery();
		
		r.next();
		rows = Integer.parseInt(r.getString(1));
		
		final int START = rows - N * _page + 1;
		final int END	= rows - N * (_page - 1);
		
		// for spread
		sql = "SELECT * FROM album WHERE id BETWEEN ? AND ? ORDER BY id DESC";

		s = con.prepareStatement(sql);
		s.setString(1, "" + START);
		s.setString(2, "" + END);
		
		r = s.executeQuery();

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
	<title>album</title>
	<link rel="stylesheet" type="text/css" href="style/index.css">
	<link rel="stylesheet" type="text/css" href="style/album.css">
</head>
<body>
	<%@ include file="pages/header.jsp" %>
	<main>
		<jsp:include page="pages/loginBox.jsp" />
		
		<div id="write-box">
			<a href="/pages/create.jsp"><input type="button" value="글쓰기"></a>
		</div>
		<hr>
		<div id="albums">
			<%
				if(r != null) {
					while (r.next()) {
						String img    = r.getString("img");
						String artist = r.getString("artist");
						String title  = r.getString("title");
						String reco   = r.getString("recommend");
						String src = "/pages/album.jsp?artist=" + artist + "&title=" + title;
						
						String imgEl    = "<a href=\"" + src + "\"><img src=\"/images/" + img + "\"></a>";
						String artistEl = "<span class=\"artist\">" + artist + "</span>";
						String titleEl  = "<span class=\"title\">" + title + "</span>";
						String recoEl   = "<p class=\"album-reco\">" + reco + "</p>";

						out.print("<span class=\"album\">");
						out.println(imgEl);
						out.println("<p class=\"album-name\">");
						out.println(artistEl);
						out.println(titleEl);
						out.println("</p>");
						out.println(recoEl);
						out.println("<div class=\"album-btns\">");
						out.println("<input type=\"button\" value=\"추천\">");
						out.println("<input type=\"button\" value=\"들었음\">");
						out.println("</div>");
						out.println("</span>");
					}

					r.close();
				}
			
				if(s != null)
					s.close();
				if(con != null)
					con.close();
			%>
		</div>
		<div id="album-nav">
			<%
				int pageNums = rows / N + (int)Math.ceil((rows % N) / (double)N);
			%>
			<span><a href="album.jsp?page=1">prev</a></span>
			<%
				for(int i = 1; i <= pageNums; i++) {
					out.println("<span><a href=\"album.jsp?page=" + i + "\">" + i + "</a></span>");
				}
			%>
			<span><a href="album.jsp?page=100">next</a></span>
		</div>
	</main>
</body>
</html>