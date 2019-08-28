<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet,
				 javax.sql.DataSource, javax.naming.InitialContext" %>
<%
	request.setCharacterEncoding("utf-8");

	String id     = request.getParameter("uid");
	String artist = request.getParameter("artist");
	String title  = request.getParameter("title");
	
	try {
		InitialContext ctx = new InitialContext();
		DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/mysql");
		Connection con = ds.getConnection();
		
		String sql = "SELECT * FROM webuser_info WHERE "
			+ "userid=\"" + id + "\" AND "
			+ "artist=\"" + escapeQuotes(artist) + "\" AND "
			+ "title=\"" + escapeQuotes(title) + "\"";
		
		PreparedStatement s = con.prepareStatement(sql);
		ResultSet r = s.executeQuery();
		int n = 0;
		
		// 엔티티가 있으면
		if(r.next()) {
			String heard = r.getString("heard");
			
			if(heard.equals("1")) {
				// 이미 들었으면
				out.println("failed_already");
				
			} else if(heard.equals("0")) {
				// 아니면 표시
				sql = "UPDATE webuser_info SET heard=1 WHERE "
					+ "userid=\"" + id + "\" AND "
					+ "artist=\"" + escapeQuotes(artist) + "\" AND "
					+ "title=\"" + escapeQuotes(title) + "\"";
				
				s = con.prepareStatement(sql);
				n = s.executeUpdate();
				
				if (n == 0) {
					out.println("failed_sql");

				} else if (n == 1) {
					out.println("successed");

				} else {
					out.println("failed_con");
				}
				
			} else {
				out.println("failed_con");
			}
			
		} else {
			// 엔티티가 없으면 새로 쓰기
			sql = "INSERT INTO webuser_info(userid, artist, title, heard) VALUES("
				+ "\"" + id + "\", "
				+ "\"" + escapeQuotes(artist) + "\", "
				+ "\"" + escapeQuotes(title) + "\", "
				+ "1)";
			
			s = con.prepareStatement(sql);
			n = s.executeUpdate();
			
			if (n == 0) {
				out.println("failed_sql");

			} else if (n == 1) {
				out.println("successed");

			} else {
				out.println("failed_con");
			}
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

<%!
	private String escapeQuotes(String str) {
		if(str == null) return null;
	
		String result = str
			.replaceAll("'", "\\\\'")
			.replaceAll("\"", "\\\\\"");
	
		return result;
	}
%>