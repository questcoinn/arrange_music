<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement,
				 javax.sql.DataSource, javax.naming.InitialContext" %>
<%
	request.setCharacterEncoding("utf-8");

	String id    = request.getParameter("uid");
	String pwd   = request.getParameter("upwd");
	String nick  = request.getParameter("unick");
	String birth = request.getParameter("ubirth");
	
	if(birth == "") {
		birth = null;
	}
	
	Connection con = null;
	PreparedStatement s = null;
	int n = 0;
	
	try {
		InitialContext ctx = new InitialContext();
		DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/mysql");
		con = ds.getConnection();
		
		String sql = "INSERT INTO webuser VALUES(?, ?, ?, ?)";
		
		s = con.prepareStatement(sql);
		s.setString(1, id);
		s.setString(2, pwd);
		s.setString(3, nick);
		s.setString(4, birth);
		
		n = s.executeUpdate();

	} catch (Exception e) {
		out.println("Connection Failed..");
		out.println(e.getMessage());
		e.printStackTrace();
	}
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8" http-equiv="Refresh" content="1.5;url=/index.jsp">
	<title>completed!</title>
</head>
<body>
	<p>
		<%
			if (n == 0) {
				out.println("가입도중 오류가 발생했습니다.");

			} else if (n == 1) {
				out.println("가입 완료");

			} else {
				out.println("예기치 못한 오류 발생");
			}

			if (s != null)
				s.close();
			if (con != null)
				con.close();
		%>
	</p>
	<p>잠시후 메인 페이지로 돌아갑니다.</p>
</body>
</html>