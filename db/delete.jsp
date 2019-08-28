<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.File, java.sql.Connection, java.sql.PreparedStatement,
				 javax.sql.DataSource, javax.naming.InitialContext" %>
<%
	request.setCharacterEncoding("utf-8");

	String artist  = request.getParameter("artist");
	String title   = request.getParameter("title");
	String img	   = request.getParameter("img");
	
	int m = 0;
	int n = 0;
	boolean deleted = false;
	String sql = "";
	try {
		InitialContext ctx = new InitialContext();
		DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/mysql");
		Connection con = ds.getConnection();
		
		sql = "DELETE FROM album WHERE "
			+ "artist=\"" + escapeQuotes(artist) + "\" AND "
			+ "title=\"" + escapeQuotes(title) + "\"";
		
		// album 테이블
		PreparedStatement s = con.prepareStatement(sql);
		
		m = s.executeUpdate();
		
		if(img.equals("nothing.png")) {
			deleted = true;
			
		} else if(m == 1) {
			// 파일 지우기
			String imgDir = request.getRealPath("/images");
			File file = new File(imgDir + "/" + img);
			if(file.exists()) {
				deleted = file.delete();
			}
		}
		
		// webuser_info 테이블
		sql = "DELETE FROM webuser_info WHERE "
			+ "artist=\"" + escapeQuotes(artist) + "\" AND "
			+ "title=\"" + escapeQuotes(title) + "\"";
		
		s = con.prepareStatement(sql);
		
		n = s.executeUpdate();
		
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
	<meta charset="UTF-8" http-equiv="Refresh" content="1.5;url=/album.jsp">
	<title>completed!</title>
</head>
<body>
	<p>
		<%
			if (m == 0) {
				out.println("삭제중 오류가 발생했습니다.");

			} else if (m == 1 && deleted) {
				out.println("삭제 완료");

			} else {
				out.println("예기치 못한 오류 발생");
			}
		%>
	</p>
	<p>잠시후 앨범 페이지로 돌아갑니다.</p>
</body>
</html>

<%!
	private String escapeQuotes(String str) {
		if(str == null) return null;
	
		String result = str
			.replaceAll("'", "\\\\'")
			.replaceAll("\"", "\\\\\"");
	
		return result;
	}
%>