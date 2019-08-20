<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet,
				 javax.sql.DataSource, javax.naming.InitialContext" %>
<%
	request.setCharacterEncoding("utf-8");

	String artist = "";
	String title = "";
	
	try {
		artist = request.getParameter("artist");
		title  = request.getParameter("title");
	
	} catch(Exception e) {
		artist = null;
		title = null;
	}
	
	Connection con = null;
	PreparedStatement s = null;
	ResultSet r = null;
	
	try {
		InitialContext ctx = new InitialContext();
		DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/mysql");
		con = ds.getConnection();
		
		String sql = "SELECT * FROM album WHERE artist=? AND title=?";

		s = con.prepareStatement(sql);
		s.setString(1, artist);
		s.setString(2, title);
		
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
	<title>1</title>
	<link rel="stylesheet" type="text/css" href="/style/index.css">
</head>
<body>
	<%@ include file="/pages/header.jsp" %>
	<main>
		pre? 써서 \n 보존
		<br>
		<%
			if(r != null) {
				while(r.next()) {
					out.println(r.getString(1));
					out.println(r.getString(2));
					out.println(r.getString(3));
					out.println(r.getString(4));
					out.println(r.getString(5));
					out.println(r.getString(6));
					out.println(r.getString(7));
					out.println("<br>");
				}
				
				r.close();
			}
				
			if(s != null)
				s.close();
			if (con != null)
				con.close();
		%>
	</main>
</body>
</html>