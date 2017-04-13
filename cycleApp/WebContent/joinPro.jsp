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
	String name = request.getParameter("name");
	String sex=request.getParameter("sex");
	String height=request.getParameter("height");
	String weight=request.getParameter("weight");
%>



</head>

<body>

	<%
	PreparedStatement pstmt = null;
	String str=null;
	
	try{
		Class.forName("org.gjt.mm.mysql.Driver");
		String url="jdbc:mysql://localhost:3306/bicycle";
		String user="root";
		String password="apmsetup";
		Connection conn = DriverManager.getConnection(url, user, password);
		String sql = "insert into enter values(?,?,?,?,?,?)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id); 
		pstmt.setString(2, passwd);
		pstmt.setString(3, name);
		pstmt.setString(4, sex);
		pstmt.setString(5, height);
		pstmt.setString(6, weight);
		pstmt.executeUpdate();
%>
		<script type="text/javascript">
		alert("회원가입완료");
		location.href='home.html';
		</script>
		<%
	}catch(Exception e){
		e.printStackTrace();%>
		<script type="text/javascript">
		alert("회원가입실패");
		history.go(-1);
		</script>
		<%
	}
	%>
	
</body>
</html>