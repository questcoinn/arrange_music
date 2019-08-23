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
			+ "artist=\"" + artist + "\" AND "
			+ "title=\"" + title + "\"";
		
		PreparedStatement s = con.prepareStatement(sql);
		ResultSet r = s.executeQuery();
		int m = 0;
		int n = 0;
		
		// 엔티티가 있으면
		if(r.next()) {
			String recommended = r.getString("recommended");
			
			if(recommended.equals("1")) {
				// 이미 추천돼있으면
				out.println("failed_already");
				
			} else if(recommended.equals("0")) {
				// 아니면 추천
				// album 테이블
				sql = "SELECT recommend FROM album WHERE "
					+ "artist=\"" + artist + "\" AND "
					+ "title=\"" + title + "\"";
				
				s = con.prepareStatement(sql);
				r = s.executeQuery();
				
				int recommend = 0;
				
				if(r.next())
					recommend = Integer.parseInt(r.getString(1)) + 1;
				
				sql = "UPDATE album SET recommend=" + recommend + " WHERE "
					+ "artist=\"" + artist + "\" AND "
					+ "title=\"" + title + "\"";
				
				s = con.prepareStatement(sql);
				m = s.executeUpdate();
				
				// webuser_info 테이블
				sql = "UPDATE webuser_info SET recommended=1 WHERE "
					+ "userid=\"" + id + "\" AND "
					+ "artist=\"" + artist + "\" AND "
					+ "title=\"" + title + "\"";
				
				s = con.prepareStatement(sql);
				n = s.executeUpdate();
				
				if (m == 0 || n == 0) {
					out.println("failed_sql");

				} else if (m == 1 && n == 1) {
					out.println("successed");

				} else {
					out.println("failed_con");
				}
				
			} else {
				out.println("failed_con");
			}
			
		} else {
			// 엔티티가 없으면 새로 쓰기
			// album 테이블
			sql = "SELECT recommend FROM album WHERE "
				+ "artist=\"" + artist + "\" AND "
				+ "title=\"" + title + "\"";
				
			s = con.prepareStatement(sql);
			r = s.executeQuery();
			
			int recommend = 0;
				
			if(r.next())
				recommend = Integer.parseInt(r.getString(1)) + 1;
				
			sql = "UPDATE album SET recommend=" + recommend + " WHERE "
				+ "artist=\"" + artist + "\" AND "
				+ "title=\"" + title + "\"";
				
			s = con.prepareStatement(sql);
			m = s.executeUpdate();
				
			// webuser_info 테이블
			sql = "INSERT INTO webuser_info(userid, artist, title, recommended) VALUES("
				+ "\"" + id + "\", "
				+ "\"" + artist + "\", "
				+ "\"" + title + "\", "
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