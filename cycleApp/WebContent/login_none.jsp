<%@page import="app.login.LogonDBBean"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<%

	request.setCharacterEncoding("euc-kr");
	String id = request.getParameter("id");
	String passwd = request.getParameter("passwd");
	LogonDBBean logonDB=LogonDBBean.getInstance();
	
	int result=logonDB.userCheck(id, passwd);
	if(result==1){
		Cookie cookie = new Cookie("id", id);
		Cookie cookie2 = new Cookie("passwd", passwd);
		cookie.setMaxAge(20*60);
		cookie2.setMaxAge(20*60);
		response.addCookie(cookie);
		response.addCookie(cookie2);
		%>
		<script type="text/javascript">
		history.go(-2);
		</script>
		<%
	}else{
	%>
		<script type="text/javascript">
			alert("id 또는 비밀번호가 일치하지 않습니다.");
			history.go(-1);
		</script>
	<%
	}
	
	
	
%>

</head>

<body>
	
</body>
</html>