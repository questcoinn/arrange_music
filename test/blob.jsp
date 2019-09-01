<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.File, java.nio.file.Files" %>
<%
	String path = request.getRealPath("/images");
	String imageName = "nothing.png";
	String buffer = "";
	
	File img = new File(path + "/" + imageName);
	byte[] fileContent = Files.readAllBytes(img.toPath());
	int length = fileContent.length;
	
	for(byte imagebyte: fileContent) {
		buffer += imagebyte + " ";
	}
%>
<div id="data" style="display: none;"><%= buffer %></div>
<script>
	let bytes, blob;

	const image = {
		length: <%= length %>,
		data: document.querySelector("#data").innerHTML.trim().split(" ").map(x => parseInt(x))
	};
	
	bytes = new Uint8Array(image.data);
	blob = new Blob([bytes], {type:'image/png'});
	image['imgSrc'] = URL.createObjectURL(blob);
</script>
<img id="img">
<script>
	document.querySelector("#img").src = image.imgSrc;
</script>