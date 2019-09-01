<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.File, java.nio.file.Files" %>
<%
	request.setCharacterEncoding("utf-8");

	String path = request.getRealPath("/images");
	String imageName = request.getParameter("file");
	String buffer = "";
	
	File img = new File(path + "/" + imageName);
	byte[] fileContent = Files.readAllBytes(img.toPath());
	int length = fileContent.length;
	
	for(byte imagebyte: fileContent) {
		buffer += imagebyte + " ";
	}
	
	out.println(buffer.trim());
%>