<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet,
				 javax.sql.DataSource, javax.naming.InitialContext" %>
<%
	request.setCharacterEncoding("utf-8");

	String artist = request.getParameter("artist");
	String title  = request.getParameter("title");
	String imgSrc = "";
	String dsc    = "";

	try {
		InitialContext ctx = new InitialContext();
		DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/mysql");
		Connection con = ds.getConnection();

		String sql = "SELECT * FROM album WHERE "
			+ "artist='" + artist + "' AND "
			+ "title='" + title + "'";

		PreparedStatement s = con.prepareStatement(sql);

		ResultSet r = s.executeQuery();
		
		while(r.next()) {
			imgSrc = r.getString("img");
			dsc = r.getString("dsc").trim().replaceAll("[\n]", "<br>");
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
<div id='img-container'>
	<%= "<img src='/images/" + imgSrc + "'>" %>
	<span class='tooltip'>tooltip</span>
</div>
<p><%= dsc %></p>