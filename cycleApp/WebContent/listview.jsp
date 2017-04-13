<%@page import="java.sql.Timestamp"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>MY RECORDS</title>
<style type="text/css">
body{
	width:1080px;
	height:1920px;
	margin:10px;
	border:1px solid black;	
	font-family: 'Nanum Gothic' , Sans-serif;
}
#background {
	width: 1080px;
	height: 1920px;
	padding:28px;
	background: no-repeat url("img/bg.png");
}
#list{
	margin:10px;
	width:1000px;
	height:1500px;
	overflow:auto;
}
tr {
	border-bottom:1px solid #A2A2A2;
	background:rgba(255,255,255,0.8);
}
tr:nth-child(even) {
	background:rgba(255,168,0,0.8);
}
td {
	padding:40px;
}
table {
	width:100%;
	margin:auto;
}
#title {
	margin:10px;
	padding:30px 0;
	width:997px;
	text-align:center;
	font-size:4.5em;
	font-weight:bold;
	border:3px solid #fff;
	color:#fff;
	background:rgba(0,0,0,0.4);
}
#time {
	font-size:3em;
	font-weight:bold;
}
#content {
	color:#787878;
	font-size:2.5em;
}
#content img {
	height: 50px;
	vertical-align: middle;
	margin-right: 10px; 
}
#btnarea {
	text-align:center;
	
}
.btn {
	padding:40px 80px;
	margin-right:30px;
	font-size:3em;
	font-family: 'Nanum Gothic' , Sans-serif;
	background: #FFA800;
	border:0 none;
	border-radius: 25px;
	color:#fff;
}
input[type="checkbox"] {
    display:none;
}
input[type="checkbox"] + label span {
    display:inline-block;
    width:50px;
    height:50px;
    margin:0 -40px 0 40px;
    vertical-align:middle;
    background:url("img/check.png") left top no-repeat;
    cursor:pointer;
}
input[type="checkbox"]:checked + label span {
    background:url("img/checked.png") left top no-repeat;
}
</style>
<%

String id = "";
try {
	Cookie[] cookies = request.getCookies();
	if (cookies != null) {
		for (int i = 0; i < cookies.length; i++) {
			if(cookies[i].getName().equals("id")){
			id = cookies[i].getValue();
			}

		}
		
		if (id.equals("")){
			response.sendRedirect("");
		}
		
	} else {
		response.sendRedirect("");
	}
	
} catch (Exception e) {

}
%>

</head>
<body>
<script>
function mySubmit(index){
	if (index == 1){
		document.gForm.action='graph.jsp';
	}
	if (index == 2){
		document.gForm.action='delete.jsp';
	}
	document.gForm.submit();
}
</script>
<div id="background">
<div id="title">MY RECORDS</div>

<form name="gForm" method="post">
<div id="list">
<table id="table">


<%
	Connection conn=null;
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	
	try{
		Class.forName("org.gjt.mm.mysql.Driver");
		String url="jdbc:mysql://localhost:3306/bicycle";
		String user="root";
		String password="apmsetup";
		conn = DriverManager.getConnection(url, user, password);
		String sql2 = "select * from submit where id=?";
		pstmt = conn.prepareStatement(sql2);
		pstmt.setString(1, id); 
		rs = pstmt.executeQuery();
		int i = 0;
		
		while(rs.next()){
			
			String distance = rs.getString("distance");
			String run = rs.getString("run");
			String avg = rs.getString("avg");
			String time = rs.getString("time");
			
			%>
			
			<tr>
			<td>
				<input type="checkbox" id="c<%=i %>" name="cc" value="<%=time%>" />
				<label for="c<%=i%>"><span></span></label>
			</td>
			<td >
				<label for="d<%=i%>"><span></span></label>
				<span id="time"><%=time %></span><br>
				<span style="float:right; padding:0 40px 0 0;">
				<input type="image" id="detail" src="img/detail.png" name="time" value="<%=time %>" onclick='mySubmit(1)'/></span><br>
				<div id="content">
					<img id="bicycle" src="img/cycle.png"><%=distance %>km 
					<img id="time" src="img/time.png"><%=run %>
				</div>
			</td>
			</tr>
		
		<% i++;}
	} catch(Exception e){
		e.printStackTrace();
	}
%>
</table>
</div>
<div id="btnarea">
	<input type="button" class="btn" value="DELETE" onclick='mySubmit(2)'/> 
	<input type="button" class="btn" value="BACK" onclick="location.href='main.html'"/>
</div>
</form>
</div>

</body>
</html>