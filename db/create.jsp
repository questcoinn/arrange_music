<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.File, java.util.Enumeration,
				 java.sql.Connection, java.sql.PreparedStatement,
				 javax.sql.DataSource, javax.naming.InitialContext" %>
<%@ page import="com.oreilly.servlet.MultipartRequest,
				 com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%
	request.setCharacterEncoding("utf-8");
	
	String uploadPath = request.getRealPath("/images");
	int maxSize = 1024 * 1024 * 10; // 10M
	
	MultipartRequest multi = new MultipartRequest(
			request, uploadPath, maxSize, "utf-8", new DefaultFileRenamePolicy());
	
	String artist = multi.getParameter("artist");
	String title  = multi.getParameter("title");
	String rDate  = multi.getParameter("r_date");
	String dsc    = multi.getParameter("dsc");
	
	Enumeration files = multi.getFileNames();
	
	String f = "";
	String originalName = "";
//	String fileName1 = "";
//	String fileType = "";
	File file = null;
	long fileSize = 0;
	
	while(files.hasMoreElements()) {
		f = (String)files.nextElement(); // 파일 input에 지정한 이름(img)
        originalName = multi.getOriginalFileName(f); // 그에 해당하는 실재 파일 이름(sample.jpeg)
//		fileName1 = multi.getFilesystemName(f); // 중복정책이름(sample1.jpeg)
        
//		fileType = multi.getContentType(f);
		file = multi.getFile(f);
        fileSize = file.length();
	}
	
	int n = 0;

	try {
		InitialContext ctx = new InitialContext();
		DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/mysql");
		Connection con = ds.getConnection();

		String sql = "INSERT INTO album(artist, title, r_date, img, dsc) VALUES("
			+ "\"" + artist + "\", "
			+ "\"" + title + "\", "
			+ "\"" + rDate + "\", "
			+ "\"" + originalName + "\", "
			+ "\"" + dsc + "\")";
		
		PreparedStatement s = con.prepareStatement(sql);
		
		n = s.executeUpdate();
		
		if(n == 1) {
			s = con.prepareStatement("SET @CNT=0");
			s.execute();
			
			s = con.prepareStatement("UPDATE album SET id=@CNT:=@CNT+1");
			s.executeUpdate();
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
				out.println("저장중 오류가 발생했습니다.");

			} else if (n == 1) {
				out.println("저장 완료");

			} else {
				out.println("예기치 못한 오류 발생");
			}
		%>
	</p>
	<p>잠시후 메인 페이지로 돌아갑니다.</p>
</body>
</html>