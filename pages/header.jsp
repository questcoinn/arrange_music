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
	<form action="" method="post">
		<select name="search-cls" id="search-cls">
			<option>아티스트, 본문</option>
			<option>아티스트</option>
			<option>본문</option>
		</select>
		<input type="text" name="search-word" placeholder="검색" id="search-box">
		<input type="submit" value="" id="search-submit">
	</form>
</header>