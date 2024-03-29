<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet,
				 javax.sql.DataSource, javax.naming.InitialContext" %>
<%
	request.setCharacterEncoding("utf-8");

	String val = request.getParameter("val");
	
	try {
		InitialContext ctx = new InitialContext();
		DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/mysql");
		Connection con = ds.getConnection();
		
		PreparedStatement s = con.prepareStatement("SELECT * FROM webuser WHERE id=?");
		s.setString(1, val);
		
		ResultSet r = s.executeQuery();
		
		if(r.next()) {
			out.println("이미 아이디가 존재합니다.");
		} else {
			String input = "<input type=\"button\" value=\"여기를 눌러주세요.\" id=\"use-btn\" onclick=\"useId()\">";
			out.println("사용 가능한 아이디입니다." + input);
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