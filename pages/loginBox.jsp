<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");

	String id	= (String) session.getAttribute("id");
	String nick = (String) session.getAttribute("nick");

	out.println("<div id=\"login-box\" uid=\"" + id + "\">");

	if (nick != null) {
		String userMessage = nick + "님, 환영합니다.";
		String logoutBtn = "<a href=\"/pages/sessionOut.jsp\" id=\"logout-link\"><input type=\"button\" value=\"logout\"></a>";

		out.println("<p>" + userMessage + "</p>");
		out.println(logoutBtn);

	} else {
		String form = "<form action=\"/auth/session.jsp\" method=\"post\">";
		String idInput = "<input type=\"text\" name=\"uid\" placeholder=\"id\" id=\"uid-box\">";
		String pwdInput = "<input type=\"password\" name=\"upwd\" placeholder=\"password\" id=\"upwd-box\">";
		String submitBtn = "<input type=\"submit\" value=\"로그인\" id=\"login-btn\">";
		String signinBtn = "<a href=\"/auth/signin.jsp\"><input type=\"button\" value=\"회원가입\" id=\"signin-btn\"></a>";

		out.println(form);
		out.println("<div>" + idInput + "</div>");
		out.println("<div>" + pwdInput + "</div>");
		out.println("<div id=\"login-btns\">" + submitBtn + signinBtn + "</div>");
		out.println("</form>");
	}
%>
</div>

<script src="/script/ajax.js"></script>
<script src="/script/logincheck.js"></script>