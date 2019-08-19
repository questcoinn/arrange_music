<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet,
				 javax.sql.DataSource, javax.naming.InitialContext" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>test</title>
</head>
<body>
	<%
		InitialContext ctx = new InitialContext();
		DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/mysql");
		Connection con = ds.getConnection();

		out.println("접속 성공");
		
		PreparedStatement s = con.prepareStatement("SELECT * FROM webuser");
		ResultSet r = s.executeQuery();
		
		while(r.next()) {
			String str = "";
			
			out.println("<p>");
			for(int i = 1; i <= 4; i++) {
				str += r.getString(i) + " ";
			}
			out.println(str);
			
			out.println("</p>");
		}
		
		r.close();
		s.close();
		con.close();
	%>
</body>
</html>