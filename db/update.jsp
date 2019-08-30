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
	
	String orgArtist = multi.getParameter("orgArtist");
	String orgTitle = multi.getParameter("orgTitle");
	
	String artist = multi.getParameter("artist");
	String title  = multi.getParameter("title");
	String rDate  = multi.getParameter("r_date");
	String img    = "";
	String dsc    = multi.getParameter("dsc");
	
	Enumeration files = multi.getFileNames();
	
	String f = "";
	String originalName = "";
	String fileName1 = "";
//	String fileType = "";
	File file = null;
	long fileSize = 0;
	
	while(files.hasMoreElements()) {
		f = (String)files.nextElement(); // 파일 input에 지정한 이름(img)
        originalName = multi.getOriginalFileName(f); // 그에 해당하는 실재 파일 이름(sample.jpeg)
		fileName1 = multi.getFilesystemName(f); // 중복정책이름(sample1.jpeg)
        
//		fileType = multi.getContentType(f);
		file = multi.getFile(f);
		try {
        	fileSize = file.length();
		} catch(NullPointerException e_np) {
			fileSize = 0;
		}
	}
	// 첨부안되면 아무 처리 안하고 그대로
	if(originalName == null || file == null) {
		img = multi.getParameter("curImg");
	
	} else {
		// 이미지가 교체되면 원래파일 지우기
		String imgDir = request.getRealPath("/images");
		File originalFile = new File(imgDir + "/" + originalName);
		if(originalFile.exists()) {
			originalFile.delete();
		}
		
		img = originalName.equals(fileName1) ? originalName : fileName1;
	}
	
	int n = 0;

	try {
		InitialContext ctx = new InitialContext();
		DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/mysql");
		Connection con = ds.getConnection();

		// album 테이블
		String sql = "UPDATE album SET "
			+ "artist=\"" + escapeQuotes(artist) + "\", "
			+ "title=\"" + escapeQuotes(title) + "\", "
			+ "r_date=\"" + rDate + "\", "
			+ "img=\"" + img + "\", "
			+ "dsc=\"" + escapeQuotes(dsc) + "\" "
			+ "WHERE artist=\"" + escapeQuotes(orgArtist) + "\" AND title=\"" + escapeQuotes(orgTitle) + "\"";
		
		PreparedStatement s = con.prepareStatement(sql);
		
		n = s.executeUpdate();

		// webuser_info 테이블
		if(!artist.equals(orgArtist) || !title.equals(orgTitle)) {
			sql = "UPDATE webuser_info SET "
				+ "artist='" + escapeQuotes(artist) + "', "
				+ "title='" + escapeQuotes(title) + "' "
				+ "WHERE artist='" + escapeQuotes(orgArtist) + "' AND title='" + escapeQuotes(orgTitle) + "'";
		
			s = con.prepareStatement(sql);
			
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
	<meta charset="UTF-8" http-equiv="Refresh" content="1.5;url=/album.jsp">
	<title>completed!</title>
</head>
<body>
	<p>
		<%
			if (n == 0) {
				out.println("");

			} else if (n == 1) {
				out.println("저장 완료");

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