<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet,
				 javax.sql.DataSource, javax.naming.InitialContext" %>
<%
	request.setCharacterEncoding("utf-8");

	String id  = request.getParameter("uid");
	String pwd = request.getParameter("upwd");
	
	/*
	id 존재하면 ---- SELECT id FROM webuser -> id 존재?
		패스워드확인 ---- pwd 존재?
		맞으면
			(id) session 설정
			redirect to index
		아니면
			패스워드 오류
	없으면
		아이디 오류
	*/
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
	}
	
	// finally
	id = null;
	pwd = null;
%>