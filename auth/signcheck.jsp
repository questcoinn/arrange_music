<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	request.setCharacterEncoding("utf-8");

	String val = request.getParameter("val");
	
	try {
		String driverName = "org.gjt.mm.mysql.Driver";
//		String driverName = "com.mysql.jdbc.Driver";
		String dbUrl = "jdbc:mysql://localhost:3309/webpj";

		Class.forName(driverName);
		Connection con = DriverManager.getConnection(dbUrl, "root", "1234");
		
		Statement stmt = con.createStatement();
		
		ResultSet r = stmt.executeQuery("SELECT * FROM webuser WHERE id='" + val + "';");
		
		if(r.next()) {
			out.println("이미 아이디가 존재합니다.");
		} else {
			String input = "<input type=\"button\" value=\"여기를 눌러주세요.\" id=\"use-btn\" onclick=\"useId()\">";
			out.println("사용 가능한 아이디입니다." + input);
		}
		
		r.close();
		stmt.close();
		con.close();

	} catch (Exception e) {
		out.println("Connection Failed..");
		out.println(e.getMessage());
		e.printStackTrace();
	}
%>