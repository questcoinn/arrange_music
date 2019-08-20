<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>create</title>
	<link rel="stylesheet" type="text/css" href="/style/index.css">
</head>
<body>
	<%@ include file="/pages/header.jsp" %>
	<main>
		<form action="/db/create.jsp" enctype="multipart/form-data" method="post">
			<div>
				<input type="text" name="artist" placeholder="아티스트*">
				<input type="text" name="title" placeholder="앨범이름*">
			</div>
			<div>
				<label for="r_date">발매일</label>
				<input type="date" name="r_date">
			</div>
			<div>
				<textarea name="dsc" placeholder="상세"></textarea>
			</div>
			<div>
				<div>
					<label for="img">앨범커버</label>
				</div>
				<input type="file" name="img">
			</div>
			<div>
				<input type="submit" value="저장">
			</div>
		</form>
	</main>
</body>
</html>