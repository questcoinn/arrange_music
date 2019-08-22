<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>create</title>
	<link rel="stylesheet" type="text/css" href="/style/index.css">
	<link rel="stylesheet" type="text/css" href="/style/form.css">
</head>
<body>
	<%@ include file="/pages/header.jsp" %>
	<main>
		<form action="/db/create.jsp" enctype="multipart/form-data" method="post">
			<div id="title-container">
				<input type="text" name="artist" placeholder="아티스트*" id="artist-in">
				<input type="text" name="title" placeholder="앨범이름*" id="title-in">
			</div>
			<div id="date-container">
				<label for="r_date">발매일*</label>
				<input type="date" name="r_date" id="date-in">
			</div>
			<div id="dsc-container">
				<textarea name="dsc" placeholder="상세"></textarea>
			</div>
			<div id="file-container">
				<div>
					<label for="img">앨범커버</label>
				</div>
				<input type="file" name="img" accept=".jpg, .jpeg, .png">
			</div>
			<div>
				<input type="submit" value="저장" id="submit">
			</div>
		</form>
	</main>
	
	<script src="/script/ajax.js"></script>
	<script src="/script/albumcheck.js"></script>
</body>
</html>