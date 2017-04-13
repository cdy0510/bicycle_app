<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>

</head>
<body>
<%
	request.setCharacterEncoding("euc-kr");
	String id = request.getParameter("id");
	String passwd = request.getParameter("passwd");
	String distance = request.getParameter("distance");
	String avg = request.getParameter("avg");
	String maxspeed = request.getParameter("maxspeed");
	String run = request.getParameter("run");
	String pause = request.getParameter("pause");
	String time = request.getParameter("time");
	
	try {
		Cookie[] cookies = request.getCookies();
		if (cookies != null) {
			for (int i = 0; i < cookies.length; i++) {
				if(cookies[i].getName().equals("id")){
					id = cookies[i].getValue();
				}
			}
			if (id.equals("")){%>
				<script>
				if(confirm("기록을 저장하시려면 로그인이 필요합니다.")) {
					window.location.href='login_none.html';
				}else if(confirm("저장하지 않고 끝내시겠습니까?")){
					window.location.href='main_none.html';
				}else {
					history.go(-1);
				}
				</script>
<%			}else {
				PreparedStatement pstmt = null;
				String str=null;
				
				try{
					Class.forName("org.gjt.mm.mysql.Driver");
					String url="jdbc:mysql://localhost:3306/bicycle";
					String user="root";
					String password="apmsetup";
					Connection conn = DriverManager.getConnection(url, user, password);
					String sql = "insert into submit values(?,?,?,?,?,?,?,?)";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, id); 
					pstmt.setString(2, passwd);
					pstmt.setString(3, distance);
					pstmt.setString(4, avg);
					pstmt.setString(5, maxspeed);
					pstmt.setString(6, run);
					pstmt.setString(7, pause);
					pstmt.setString(8, time);
					pstmt.executeUpdate();
					str="submit 테이블에 새로운 레코드가 추가되었습니다";%>
					
					<script type="text/javascript">
						alert("저장되었습니다.");
						location.href="listview.jsp";
					</script>
					
					<% 
				}catch(Exception e){
					e.printStackTrace();
					str="submit 테이블에 새로운 레코드 추가 실패";
				}
				out.print(str);
			}
		}else {%>
			<script>
			if(confirm("기록을 저장하시려면 로그인이 필요합니다.")) {
				window.location.href='login.html';
			}else if(confirm("저장하지 않고 끝내시겠습니까?")){
				window.location.href='main_none.html';
			}
			</script>
	<%	}
	} catch (Exception e) {%>
		<script>
			alert("에러 코드 : " + e);
		</script>
<%  }%>
</body>
</html>