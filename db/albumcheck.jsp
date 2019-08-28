<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet,
				 javax.sql.DataSource, javax.naming.InitialContext" %>
<%
	request.setCharacterEncoding("utf-8");

	String artist = request.getParameter("artist");
	String title  = request.getParameter("title");
	
	try {
		InitialContext ctx = new InitialContext();
		DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/mysql");
		Connection con = ds.getConnection();
		
		String sql = "SELECT artist, title FROM album "
			+ "WHERE artist=\"" + escapeQuotes(artist) + "\" AND title=\"" + escapeQuotes(title) + "\"";
		
		PreparedStatement s = con.prepareStatement(sql);
		
		ResultSet r = s.executeQuery();
		
		if(r.next()) {
			out.println("failed_exist");
		} else {
			out.println("successed");
		}
		
		r.close();
		s.close();
		con.close();

	} catch (Exception e) {
		out.println("failed_con");
	}
%>

<%!
	private String escapeQuotes(String str) {
		if(str == null) return null;
	
		String result = str
			.replaceAll("'", "\\\\'")
			.replaceAll("\"", "\\\\\"");
	
		return result;
	}
%>