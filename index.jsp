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
	ResultSet rH = null;
	
	String sql = "";

	try {
		InitialContext ctx = new InitialContext();
		DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/mysql");
		con = ds.getConnection();
		
		sql = "SELECT COUNT(*) FROM album";
		
		s = con.prepareStatement(sql);
		r = s.executeQuery();
		
		r.next();
		rows = Integer.parseInt(r.getString(1));
		
		final int START = rows - N * _page + 1;
		final int END	= rows - N * (_page - 1);
		
		// for spread
		final int RAND = (int)(Math.random() * Math.min(rows, 10)) + 1;
		
		sql = "SET @CNT=0";
		
		s = con.prepareStatement(sql);
		s.execute();
		
		sql = "SELECT * FROM "
			+ "(SELECT *, IF(true, @CNT:=@CNT+1, 0) AS count FROM album ORDER BY recommend DESC)t "
			+ "WHERE count=" + Math.min(RAND, rows);

		s = con.prepareStatement(sql);
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
	<title>index</title>
	<link rel="stylesheet" type="text/css" href="style/index.css">
</head>
<body>
	<%@ include file="pages/header.jsp" %>
	<main>
		<jsp:include page="pages/loginBox.jsp" />
		
		<%
			if(r != null)
				r.next();
		
			String artist = r.getString("artist");
			String title  = r.getString("title");
			String img    = r.getString("img");
			String dsc    = r.getString("dsc").trim();
			
			String artistPara = parseParameter(artist);
			String titlePara  = parseParameter(title);
			String subDsc     = dsc.substring(0, 100).replaceAll("[\n]", "<br>");
			
		%>
		<article id="random-article">
			<h2>&lt;&nbsp;추천 앨범&nbsp;&gt;</h2>
			<%= "<a href='/pages/album.jsp?artist=" + artistPara + "&title=" + titlePara + "'>" %>
			<%= "<img src='/images/" + img + "'></a>" %>
			<h3 id="title"><%= artist + " - " + title %></h3>
			<p id="desc"><%= subDsc + "...<br>..." %></p>
		</article>
		<%
			if(r != null)
				r.close();
			
			if(s != null)
				s.close();
			
			if(con != null)
				con.close();
		%>
	</main>
</body>
</html>

<%!
	private String parseParameter(String str) {
		String result = str
			.replaceAll("[#]", "%23")
			.replaceAll("[%]", "%25")
			.replaceAll("[&]", "%26")
			.replaceAll("[/]", "%2F")
			.replaceAll("[=]", "%3D")
			.replaceAll("[?]", "%3F")
			.replaceAll("[\\\\]", "%5C");
		
		return result;
	}
%>