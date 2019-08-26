<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList,
			 	 java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet,
				 javax.sql.DataSource, javax.naming.InitialContext" %>
<%
	request.setCharacterEncoding("utf-8");

	final int YEAR = Integer.parseInt(request.getParameter("year"));
	final int MONTH = Integer.parseInt(request.getParameter("month"));
	
	ArrayList<Album> albumList = new ArrayList<Album>();

	try {
		InitialContext ctx = new InitialContext();
		DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/mysql");
		Connection con = ds.getConnection();

		String sql = "SELECT artist, title, DAY(r_date) AS r_day FROM album WHERE "
	+ "YEAR(r_date)=" + YEAR + " AND "
	+ "MONTH(r_date)=" + MONTH + " ORDER BY r_date";

		PreparedStatement s = con.prepareStatement(sql);

		ResultSet r = s.executeQuery();
		
		while(r.next()) {
	Album album = new Album();
	
	album.artist = r.getString("artist");
	album.title = r.getString("title");
	album.day = r.getInt("r_day");
	
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
	
	if(albumList.size() == 0) {
		String date = String.format("%d.1.", MONTH);
		
		out.println("<span class=\"date\">" + date + "</span><p class=\"album\"></p>");
		
	} else {
		int targetDay = 0;

		for (Album album : albumList) {
			if (album.day > targetDay) {
				targetDay = album.day;
				String date = String.format("%d.%d.", MONTH, targetDay);

				out.println("<span class=\"date\">" + date + "</span>");
			}

			out.println("<p class=\"album\">");
			out.println("<span class=\"artist\">" + album.artist + "</span>");
			out.println("<span class=\"title\">" + album.title + "</span>");
			out.println("</p>");
		}
	}
%>

<%!
	private class Album {
		String artist;
		String title;
		int day;
	}
%>