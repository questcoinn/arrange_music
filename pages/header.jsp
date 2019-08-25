<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<header>
	<a href="/index.jsp" id="logo"><img src="" alt="logo"></a>
	<nav>
		<ul>
			<li><a href="/album.jsp">앨범들</a></li>
			<li><a href="/newalbums.jsp">신규앨범</a></li>
			<li><a href="/mypage.jsp">마이페이지</a></li>
		</ul>
	</nav>
	<form action="/album.jsp" method="post">
		<input type="hidden" name="mode" value="search">
		<select name="search-cls" id="search-cls">
			<option value="tl">아티스트, 앨범명</option>
			<option value="t">아티스트</option>
			<option value="l">앨범명</option>
		</select>
		<input type="text" name="search-word" placeholder="검색" id="search-box">
		<input type="submit" value="" id="search-submit">
	</form>
</header>