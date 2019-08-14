<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>index</title>
	<link rel="stylesheet" type="text/css" href="style/index.css">
</head>
<body>
	<%@ include file="pages/header.jsp" %>
	<main>
		<jsp:include page="pages/loginBox.jsp" />
		
		<article id="random-article">
			<img src="/images/sample.jpeg" alt="앨범이미지">
			<p id="title">Black Milk - DIVE (EP)</p>
			<p id="desc">(앨범 설명 요약)<br>...<br>...</p>
		</article>
	</main>
</body>
</html>