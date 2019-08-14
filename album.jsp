<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
			<a href=""><input type="button" value="글쓰기"></a>
		</div>
		<hr>
		<div id="albums">
			<span class="album">
				<img src="images/sample.jpeg" alt="앨범이미지">
				<p class="album-name">
					<span class="artist">Black Milk</span>
					<span class="title">DIVE (EP)</span>
				</p>
				<p class="album-reco">1</p>
				<div class="album-btns">
					<input type="button" value="추천">
					<input type="button" value="들었음">
				</div>
			</span>
		</div>
		<div id="album-nav">
			<span>prev</span>
			<span>1</span>
			<span>2</span>
			<span>3</span>
			<span>4</span>
			<span>5</span>
			<span>next</span>
		</div>
	</main>
</body>
</html>