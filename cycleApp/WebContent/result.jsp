<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link rel="stylesheet" type="text/css" href="css/page.css" />
<script src="js/jquery-2.1.0.min.js"></script>
<title>Result Page</title>
<%
	request.setCharacterEncoding("euc-kr");	
	String maxspeed = request.getParameter("maxspeed");	
	String hour = request.getParameter("hour");
	String minutes = request.getParameter("minutes");
	String seconds = request.getParameter("seconds");
	String ph = request.getParameter("ph");
	String pm = request.getParameter("pm");
	String ps = request.getParameter("ps");
	String distance = request.getParameter("distance");
	Timestamp register = new Timestamp(System.currentTimeMillis());
	
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
		}
	} catch (Exception e) {
		%>
		<script>
			alert("에러 코드: " + e);
		</script>
		<%
	}	
%>
<script>
(function(e, d) {
if (typeof d == "object") {
	for (var f in d) {
		if (d.hasOwnProperty(f)) {
			e[f] = e[f] || d[f], arguments.callee(e[f], d[f]);
		}
	}
}
})(this, {
daum: {
	maps: {
		VERSION: {
			ROADMAP: "502030road",
			HYBRID: "502030road",
			ROADVIEW: "1.00",
			ROADVIEW_FLASH: "140520a",
			ROADVIEW_AJAX: "140508"
		}
	}
}
});
</script>
<script src="http://apis.daum.net/maps/real/maps3.67.js"></script>
<script>
var position = new daum.maps.LatLng(37.4749181, 126.88202140000001);
var startPos;
var oldPos;
var bounds;

$(document).ready(function() {
	map = new daum.maps.Map(document.getElementById('map'), {
		center : position,
		level : 1
	});
	startposition(37.4749181, 126.88202140000001);
	
	callposition();
});


function startposition(lat, lng) {
	startPos = new daum.maps.LatLng(lat, lng);

	map.setCenter(startPos);

	var marker = new daum.maps.Marker({
		position : startPos
	});
	marker.setMap(map);

	oldPos = startPos;
}

function callposition() {
	$.get('position.xml', function(data){
		bounds = new daum.maps.LatLngBounds();
		var rows = $(data).find('position row');
		$.each(rows, function(index, element){
			var lat = $(this).find('lat').text();
			var lng = $(this).find('lng').text();
			
			position = new daum.maps.LatLng(lat, lng);
			bounds.extend(position);
			
			var line = new daum.maps.Polyline();
			line.strokeWeight = 30;
			line.setPath([ position, oldPos ]);
			line.setMap(map);
			oldPos = position;
		});
		map.setBounds(bounds);
		var marker = new daum.maps.Marker({
			position : position
		});
		marker.setMap(map);
	});
}
</script>
</head>
<body>
<div id="map"></div>

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
		String sql = "insert into result values(?,?,?,?,?,?,?,?)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, maxspeed);
		pstmt.setString(2, hour); 
		pstmt.setString(3, minutes);
		pstmt.setString(4, seconds);
		pstmt.setString(5, ph); 
		pstmt.setString(6, pm);
		pstmt.setString(7, ps);
		pstmt.setString(8, distance);
		
		pstmt.executeUpdate();

		String sql2 = "select weight from enter where id=?";
		pstmt = conn.prepareStatement(sql2);
		pstmt.setString(1, id); 
		rs = pstmt.executeQuery();
		
		while(rs.next()){
			String weight = rs.getString("weight");
			%>
			<script type="text/javascript">
			window.onload = function() {
			    var weight = <%=weight%>;

			  	var avg = 0.2/(<%=hour%>+(<%=minutes%>/60)+(<%=seconds%>/3600));
			  	document.getElementsByName("avg")[0].value = avg;
			  	document.getElementsByName("avg")[1].value = avg;
			  	var cal = 0;
			  	if(avg <= 13) {cal=0.0650;}
			  	else if(avg <= 16) {cal=0.0783;}
			  	else if(avg <= 19) {cal=0.0939;}
			  	else if(avg <= 22) {cal=0.113;}
			  	else if(avg <= 24) {cal=0.124;}
			  	else if(avg <= 26) {cal=0.136;}
			  	else if(avg <= 27) {cal=0.149;}
			  	else if(avg <= 29) {cal=0.163;}
			  	else if(avg <= 31) {cal=0.179;}
			  	else if(avg <= 32) {cal=0.196;}
			  	else if(avg <= 34) {cal=0.215;}
			  	else if(avg <= 37) {cal=0.259;}
			  	else if(avg > 37) {cal=0.311;}
			  	
			  	var kcal = avg * cal * weight;
			  	document.getElementsByName("kcal")[0].value = kcal;
			  };
			</script>
			
			<% 
			}		
	}catch(Exception e){
		e.printStackTrace();

	}
	
	
	%>


<div id="detail">
	<div id="left">
	<label>주행거리</label><br>
	<label>주행시간</label><br>
	<label>평균속도</label><br>
	<label>최대속도</label><br>
	<label>칼로리</label><br>
	<label>일시정지</label><br>
	</div>
	<div id="right">
	<input type="text" name="distance" value="0.2" size="1">km<br>
	<input type="text" name="hour" value="<%=hour %>" size="1">:
	<input type="text" name="minutes" value="<%=minutes %>" size="1">:
	<input type="text" name="seconds" value="<%=seconds %>" size="3"><br>
	<input type="text" name="avg" value="0.0" size="3">km/h<br>
	<input type="text" name="maxspeed" value="<%=maxspeed %>" size="3">km/h<br>
	<input type="text" name="kcal" value="0"size="3" >kcal<br>
	<input type="text" name="ph" value="<%=ph %>" size="1">:
	<input type="text" name="pm" value="<%=pm %>" size="1">:
	<input type="text" name="ps" value="<%=ps %>" size="1"><br>
	</div>
</div><br><br>

<form action="submit.jsp" method="post">
	<input type="hidden" name="id" value="<%=id %>" />
	<input type="hidden" name="passwd" value="<%=passwd %>" />
	<input type="hidden" name="distance" value="<%=distance %>" />
	<input type="hidden" name="avg" size="3"/>
	<input type="hidden" name="run" value="<%=hour %>:<%=minutes %>:<%=seconds %>"/>
	<input type="hidden" name="pause" value="<%=ph %>:<%=pm %>:<%=ps %>" />
	<input type="hidden" name="maxspeed" value="<%=maxspeed %>"/>
	<input type="hidden" name="time" value="<%=register %>" /><br><br>
	<div id="btnarea">
		<input type="submit" class="btn" value="SAVE"/>
		<input type="button" class="btn" value="BACK" onclick="location.href='main.html'"/>
	</div>
</form>

</body>
</html>