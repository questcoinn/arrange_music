<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<header>
	<a href="/index.jsp" id="logo">
		<img src="https://image.flaticon.com/icons/svg/148/148722.svg" alt="logo">
		<span>MUSIC</span>
	</a>
	<nav>
		<ul>
			<li><a href="/album.jsp">앨범들</a></li>
			<li><a href="/newalbums.jsp">신규앨범</a></li>
			<li><a href="/mypage.jsp">마이페이지</a></li>
		</ul>
	</nav>
	<form action="/album.jsp" method="post">
		<input type="hidden" name="mode" value="search">
		<input type="button" value="크게" id="toggle-size">
		<select name="search-cls" id="search-cls">
			<option value="tl">전체</option>
			<option value="t">아티스트</option>
			<option value="l">앨범명</option>
		</select>
		<input type="text" name="search-word" placeholder="검색" id="search-box">
		<input type="submit" value="" id="search-submit">
	</form>
	<script src="/script/searchbox.js"></script>
</header>