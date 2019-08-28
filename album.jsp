<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet,
				 javax.sql.DataSource, javax.naming.InitialContext" %>
<%
	final int N = 8;
	int _page = 1;	

	try {
		_page = Integer.parseInt(request.getParameter("page"));
	} catch(Exception e) {
		_page = 1;
	}
	
	int rows = 0;
	
	String mode = request.getParameter("mode");
	String word = request.getParameter("search-word");
	String _cls  = request.getParameter("search-cls");
	String cls = "";
	
	if(mode == null) {
		mode = "normal";
		
	} else {
		if(_cls.equals("tl")) {
			cls = "artist, title";
		} else if(_cls.equals("t")) {
			cls = "artist";
		} else if(_cls.equals("l")) {
			cls = "album";
		}
	}

	Connection con = null;
	
	PreparedStatement s = null;
	ResultSet r = null;
	ResultSet rH = null;
	
	String sql = "";

	try {
		InitialContext ctx = new InitialContext();
		DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/mysql");
		con = ds.getConnection();
		
		if(mode.equals("normal")) {
			sql = "SELECT COUNT(*) FROM album";
			
		} else if(mode.equals("search")) {
			sql = "SELECT COUNT(*) FROM album WHERE MATCH("
				+ cls + ") AGAINST("
				+ "'" + escapeQuotes(word) + "*' IN BOOLEAN MODE);";
				
		}
		
		s = con.prepareStatement(sql);
		r = s.executeQuery();
		
		r.next();
		rows = Integer.parseInt(r.getString(1));
		
		final int START = rows - N * _page + 1;
		final int END	= rows - N * (_page - 1);
		
		// for spread
		sql = "SET @CNT=0";
		
		s = con.prepareStatement(sql);
		s.execute();
		
		if(mode.equals("normal")) {
			sql = "SELECT * FROM "
				+ "(SELECT *, IF(true, @CNT:=@CNT+1, 0) AS count FROM album ORDER BY id)t "
				+ "WHERE count BETWEEN " + START + " AND " + END + " "
				+ "ORDER BY count DESC";
			
		} else if(mode.equals("search")) {
			sql = "SELECT * FROM "
				+ "(SELECT *, IF(true, @CNT:=@CNT+1, 0) AS count FROM album "
				+ "WHERE MATCH(" + cls + ") AGAINST("
				+ "'" + escapeQuotes(word) + "*' IN BOOLEAN MODE) "
				+ "ORDER BY id)t "
				+ "WHERE count BETWEEN " + START + " AND " + END + " "
				+ "ORDER BY count DESC";
			
		}

		s = con.prepareStatement(sql);
		r = s.executeQuery();

	} catch (Exception e) {
		out.println("Connection Failed..");
		out.println(e.getMessage());
		e.printStackTrace();
	}
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>album</title>
	<link rel="stylesheet" type="text/css" href="style/index.css">
	<link rel="stylesheet" type="text/css" href="style/album.css">
</head>
<body>
	<%@ include file="pages/header.jsp" %>
	<main>
		<jsp:include page="pages/loginBox.jsp" />
		
		<div id="write-box">
			<a href="/pages/create.jsp"></a>
			<input type="button" value="글쓰기">
		</div>
		<hr>
		<div id="albums">
			<%
				if(r != null) {
					while (r.next()) {
						String img    = r.getString("img");
						String artist = r.getString("artist");
						String title  = r.getString("title");
						String reco   = r.getString("recommend");
						
						String artistPara = parseParameter(artist);
						String titlePara  = parseParameter(title);
						String src = "/pages/album.jsp?artist=" + artistPara + "&title=" + titlePara;
						
						String imgEl    = "<a href=\"" + src + "\"><img src=\"/images/" + img + "\"></a>";
						String artistEl = "<span class=\"artist\">" + artist + "</span>";
						String titleEl  = "<span class=\"title\">" + title + "</span>";
						String recoEl   = "<p class=\"album-reco\"><strong class=\"reco\">" + reco + "</strong></p>";
						
						// heard
						String user = (String) session.getAttribute("id");
						sql = "SELECT * FROM webuser_info WHERE "
							+ "userid='" + user + "' AND "
							+ "artist='" + escapeQuotes(artist) + "' AND "
							+ "title='" + escapeQuotes(title) + "'";
						
						s = con.prepareStatement(sql);
						rH = s.executeQuery();
						
						String heard = rH.next()
							? rH.getInt("heard") == 1
								? "heard"
								: "not-heard"
							: "not-heard";
						
						out.print("<span class=\"album\">");
						out.println(imgEl);
						out.println("<p class=\"album-name\">");
						out.println(artistEl);
						out.println(titleEl);
						out.println("</p>");
						out.println(recoEl);
						out.println("<div class=\"album-btns\">");
						out.println("<input type=\"button\" value=\"추천\" class=\"reco-btn\">");
						out.println("<input type=\"button\" value=\"들었음\" class=\"heard-btn " + heard + "\">");
						
						out.println("</div>");
						out.println("</span>");
					}

					r.close();
				}
			
				if(rH != null)
					rH.close();
				if(s != null)
					s.close();
				if(con != null)
					con.close();
			%>
		</div>
		<hr>
		<div id="album-nav">
			<%
				int pageNums = rows / N + (int)Math.ceil((rows % N) / (double)N);
			
				final int PAGE_START = _page / 10 + 1;
				final int PAGE_END   = Math.min(PAGE_START + 9, pageNums);
				
				int prev = PAGE_START == 1 ? 1 : PAGE_START - 10;
				int next = PAGE_END == pageNums ? pageNums : PAGE_END + 1;
			%>
			<%= "<span><a href=\"album.jsp?page=" + prev + "\">prev</a></span>" %>
			<%
				for(int i = PAGE_START; i <= PAGE_END; i++) {
					if(i != _page) {
						out.println("<span><a href=\"album.jsp?page=" + i + "\">" + i + "</a></span>");
					} else {
						out.println("<span><strong>" + i + "</strong></span>");
					}
				}
			%>
			<%= "<span><a href=\"album.jsp?page=" + next + "\">next</a></span>" %>
		</div>
	</main>
	
	<script src="/script/albumbtns.js"></script>
	<script src="/script/validwritercheck.js"></script>
</body>
</html>

<%!
	private String parseParameter(String str) {
		String result = str
			.replaceAll("[#]", "%23")
			.replaceAll("[%]", "%25")
			.replaceAll("[&]", "%26")
			.replaceAll("[/]", "%2F")
			.replaceAll("[=]", "%3D")
			.replaceAll("[?]", "%3F")
			.replaceAll("[\\\\]", "%5C");
		
		return result;
	}

	private String escapeQuotes(String str) {
		if(str == null) return null;
		
		String result = str
			.replaceAll("'", "\\\\'")
			.replaceAll("\"", "\\\\\"");
		
		return result;
	}
%>