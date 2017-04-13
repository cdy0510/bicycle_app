<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<script src="js/jquery-2.1.0.min.js"></script>
<%
	String id = "";
	String passwd = "";
	try {
		Cookie[] cookies = request.getCookies();
		if (cookies != null) {
			for (int i = 0; i < cookies.length; i++) {
				if(cookies[i].getName().equals("id")){
				id = cookies[i].getValue();
				}
				if(cookies[i].getName().equals("passwd")){
					passwd = cookies[i].getValue();
				}
			}
			if (id.equals("")){%>
				<script>
				if(confirm("비회원으로 주행시엔 기록이 저장되지 않습니다. 확인 버튼을 누르면 회원가입 페이지로 이동합니다.")) {
					window.location.href='join.html';
				}else if(confirm("비회원으로 이용하시겠습니까?")) {
					window.location.href='main_none.html';
				}else {
					window.location.href='home.html';
				}
				</script>
		<%	}
		} else if (passwd.equals("")){%>
			<script>
			alert("비밀번호가 틀렸습니다. 다시 로그인해 주세요.");
			window.location.href="login.html";
			</script>
<%		}
		
	} catch (Exception e) {

	}	
%>