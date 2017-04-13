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
<title>Insert title here</title>
<%
	request.setCharacterEncoding("euc-kr");
	String name = request.getParameter("name");
	String id = request.getParameter("id");
%>
</head>
<body>
<%
	PreparedStatement pstmt = null;
	String str=null;
	ResultSet rs = null;
	try{
		Class.forName("org.gjt.mm.mysql.Driver");
		String url="jdbc:mysql://localhost:3306/bicycle";
		String user="root";
		String password="apmsetup";
		Connection conn = DriverManager.getConnection(url, user, password);
		String sql =  "select * from enter where id=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id); 
		rs = pstmt.executeQuery();
		
		while(rs.next()){
			String passwd = rs.getString("passwd");
			%>
			<script type="text/javascript">
				alert("비밀번호는 "+<%=passwd %>+" 입니다.");
				window.close();
			</script>
			<% 
		}
		
	}catch(Exception e){
		e.printStackTrace();
	}

	%>
</body>
</html>