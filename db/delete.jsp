<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.File, java.sql.Connection, java.sql.PreparedStatement,
				 javax.sql.DataSource, javax.naming.InitialContext" %>
<%
	request.setCharacterEncoding("utf-8");

	String artist  = request.getParameter("artist");
	String title   = request.getParameter("title");
	String img	   = request.getParameter("img");
	
	int n = 0;
	boolean deleted = false;
	
	try {
		InitialContext ctx = new InitialContext();
		DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/mysql");
		Connection con = ds.getConnection();
		
		PreparedStatement s = con.prepareStatement("DELETE FROM album WHERE artist=? AND title=?");
		s.setString(1, artist);
		s.setString(2, title);
		
		n = s.executeUpdate();
		
		if(n == 1) {
			s = con.prepareStatement("SET @CNT=0");
			s.execute();
			
			s = con.prepareStatement("UPDATE album SET id=@CNT:=@CNT+1");
			s.executeUpdate();
			
			// 파일 지우기
			String imgDir = request.getRealPath("/images");
			File file = new File(imgDir + "/" + img);
			if(file.exists()) {
				deleted = file.delete();
			}
		}
		
		s.close();
		con.close();

	} catch (Exception e) {
		out.println("Connection Failed..");
		out.println(e.getMessage());
		e.printStackTrace();
	}
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8" http-equiv="Refresh" content="2;url=/album.jsp">
	<title>completed!</title>
</head>
<body>
	<p>
		<%
			if (n == 0) {
				out.println("삭제중 오류가 발생했습니다.");

			} else if (n == 1 && deleted) {
				out.println("삭제 완료");

			} else {
				out.println("예기치 못한 오류 발생");
			}
		%>
	</p>
	<p>잠시후 메인 페이지로 돌아갑니다.</p>
</body>
</html>