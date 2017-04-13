<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>데이터삭제</title>
<%
	request.setCharacterEncoding("euc-kr");
	String time = request.getParameter("cc");
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
		String sql =  "delete from submit where time=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, time); 
		pstmt.executeUpdate();
		response.sendRedirect("listview.jsp");

	}catch(Exception e){
		e.printStackTrace();
	}
	
	%>
</body>
</html>