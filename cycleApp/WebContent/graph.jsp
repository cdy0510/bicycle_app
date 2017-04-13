<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>그래프</title>
<%
	request.setCharacterEncoding("euc-kr");
	String time = request.getParameter("time");
%>
<style type="text/css">
body{
	width:1080px;
	height:1920px;
	margin:10px;
	border:1px solid black;	
	font-family: 'Nanum Gothic' , Sans-serif;;
}
#detail{
	margin:auto;
	position:relative;
	padding:70px 40px 30px 30px;
	border:1px solid black;
	width:910px;
	height:800px;
	top:40px;
	font-size:3em;
	line-height: 3em;
}
#detail input[type="text"] {
	font-size: 1em;
	text-align:right;
	padding:40px 5px 40px 40px;
	border:0 none;
	margin-right:10px;
}
#left {
	float: left;
}
#right {
	text-align: right;
}
#btnarea {
	text-align:center;
	
}
.btn {
	padding:40px 80px;
	margin-right:30px;
	margin-top:170px;
	font-size:3em;
	font-family: 'Nanum Gothic' , Sans-serif;
	background: #FFA800;
	border:0 none;
	border-radius: 25px;
	color:#fff;
}
</style>

	<script type="text/javascript" src="https://www.google.com/jsapi"></script>
	    <script type="text/javascript">
	      google.load("visualization", "1", {packages:["corechart"]});
	      google.setOnLoadCallback(drawChart);
	      function drawChart() {
	        var data = google.visualization.arrayToDataTable([
	          ['Distance', 'altitude', 'speed'],
	          ['0',  20,   0],
	          [,  14,  27],
	          ['3', 18,   40],
	          [,  32,   67],
	          ['6', 5,    50],
	          [,  12,   70],
	          ['9',  32,   43],
	          [,  54,   40],
	          ['12',  43,   55],
	          [,  70,   31],
	          ['15',  22,   20],
	          [,  5,   22],
	          ['18',  2,   15],
	          [,  8,   7],
	          ['km', '', '']
	        ]);
	
	        var options = {
	          title: '주행속도 그래프'
	        };
	
	        var chart = new google.visualization.LineChart(document.getElementById('chart_div'));
	        chart.draw(data, options);
	      }
	    </script>
</head>
<body>
<br><br><center>
<div id="chart_div" style="width: 900px; height: 500px;"></div>
</center><br>
		
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
		String sql =  "select * from submit where time=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, time); 
		rs = pstmt.executeQuery();
		
		while(rs.next()){
			String distance = rs.getString("distance");
			String run = rs.getString("run");
			String avg = rs.getString("avg");
			String maxspeed = rs.getString("maxspeed");
			String pause = rs.getString("pause");	
			%>
			<script type="text/javascript">
			window.onload = function() {
				var a = <%=avg %>;
				document.getElementsByName("avg")[0].value = a;
			};
			</script>
		
		<div id="detail">
		<div id="left">
		<label>주행거리</label><br>
		<label>주행시간</label><br>
		<label>평균속도</label><br>
		<label>최대속도</label><br>
		<label>일시정지</label><br>
		</div>
		<div id="right">
		<input type="text" name="distance" value="0.2" size="3">km<br>
		<input type="text" name="run" value="<%=run %>" size="5"><br>
		<input type="text" name="avg" value="0.0" size="3">km/h<br>
		<input type="text" name="maxspeed" value="<%=maxspeed %>" size="3">km/h<br>
		<input type="text" name="ph" value="<%=pause %>" size="5"><br>
		</div>
		</div>
		
		<% 
		
		}
		
	}catch(Exception e){
		e.printStackTrace();
	}

	%>
	
<div id="btnarea">
	<input type="button" class="btn" value="BACK" onclick="location.href='listview.jsp'"/>
</div>

</body>
</html>