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
				if(confirm("��ȸ������ ����ÿ� ����� ������� �ʽ��ϴ�. Ȯ�� ��ư�� ������ ȸ������ �������� �̵��մϴ�.")) {
					window.location.href='join.html';
				}else if(confirm("��ȸ������ �̿��Ͻðڽ��ϱ�?")) {
					window.location.href='main_none.html';
				}else {
					window.location.href='home.html';
				}
				</script>
		<%	}
		} else if (passwd.equals("")){%>
			<script>
			alert("��й�ȣ�� Ʋ�Ƚ��ϴ�. �ٽ� �α����� �ּ���.");
			window.location.href="login.html";
			</script>
<%		}
		
	} catch (Exception e) {

	}	
%>