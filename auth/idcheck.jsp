<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet,
				 javax.sql.DataSource, javax.naming.InitialContext" %>
<%
	request.setCharacterEncoding("utf-8");

	String id  = request.getParameter("uid");
	String pwd = request.getParameter("upwd");
	
	try {
		InitialContext ctx = new InitialContext();
		DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/mysql");
		Connection con = ds.getConnection();
		
		String sql = "SELECT id, pwd FROM webuser WHERE id=?";
		
		PreparedStatement s = con.prepareStatement(sql);
		s.setString(1, id);
		
		ResultSet r = s.executeQuery();
		
		// id 존재
		if(r.next()) {
			// pwd 일치
			if(pwd.equals(r.getString(2))) {
				out.println("successed");
			// pwd 불일치
			} else {
				out.println("failed_pwd");
			}
			
		// id 없음
		} else {
			out.println("failed_id");
		}
		
		r.close();
		s.close();
		con.close();

	} catch (Exception e) {
		out.println("failed_con");
		
	} finally {
		id = null;
		pwd = null;
	}
%>