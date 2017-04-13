//주행 시간 체크하는 변수
var currentsec = 0;
var currentmin = 0;
var currenthour = 0;
//휴식 시간 체크하는 변수
var pausesec = 0;
var pausemin = 0;
var pausehour = 0;
//주행 중/휴식 중
var keepgoin = 0;
function timer() {
	if (keepgoin == 1) {
		currentsec += 1;
		if (currentsec == 60) {
			currentsec = 0;
			currentmin += 1;
		}
		if (currentmin == 60) {
			currentmin = 0;
			currenthour += 1;
		}
		//초 누적
		Strsec = "" + currentsec;
		Strmin = "" + currentmin;
		Strhour = "" + currenthour;

		//십의 자리 수가 없을 때 십의 자리 수 위치에 0 표시
		if (Strsec.length != 2) {
			Strsec = "0" + currentsec;
		}
		if (Strmin.length != 2) {
			Strmin = "0" + currentmin;
		}
		if (Strhour.length != 2) {
			Strhour = "0" + currenthour;
		}

		//화면에 표시
		document.display.seconds.value = Strsec;
		document.display.minutes.value = Strmin;
		document.display.hour.value = Strhour;

		setTimeout("timer()", 1000); // waits one second and repeats
	}
}

function ptimer() {
	if (keepgoin == 2) { //멈췄을때
		pausesec += 1;
		if (pausesec == 60) {
			pausesec = 0;
			pausemin += 1;
		}
		if (pausemin == 60) {
			pausemin = 0;
			pausehour += 1;
		}
		//초 누적
		Strpsec = "" + pausesec;
		Strpmin = "" + pausemin;
		Strphour = "" + pausehour;

		//십의 자리 수가 없을 때 십의 자리 수 위치에 0 표시
		if (Strpsec.length != 2) {
			Strpsec = "0" + pausesec;
		}
		if (Strpmin.length != 2) {
			Strpmin = "0" + pausemin;
		}
		if (Strphour.length != 2) {
			Strphour = "0" + pausehour;
		}

		//화면에 표시
		document.display.ps.value = Strpsec;
		document.display.pm.value = Strpmin;
		document.display.ph.value = Strphour;

		setTimeout("ptimer()", 1000); // waits one second and repeats
	}
}

function startover() { // This function resets
	keepgoin = 0; // all the variables
	currentsec = 0;
	currentmin = 0;
	currentmil = 0;
	Strsec = "00";
	Strmin = "00";
	Strmil = "00";
}

var i = 0;
$(document).on('click','#start',function() {
	var rest = document.getElementById("rest");
	var cycle = document.getElementById("cycle");
	var img = new Array("img/pause.png", "img/running.png");
	if (i == 0) {
		keepgoin = 1;
		timer();
		i = 1;
		cycle.className = "divShow";
		rest.className = "divHide";
		document.getElementById('spbtn').src = img[0];

		var startPos;
		if (navigator.geolocation) {
			navigator.geolocation.getCurrentPosition(function(position) {
				startPos = position;
			}, function(error) {
				alert("Error occurred. Error code: " + error.code);
				// error.code는 다음을 의미함:
				//   0: 알 수 없는 오류
				//   1: 권한 거부
				//   2: 위치를 사용할 수 없음 (이 오류는 위치 정보 공급자가 응답)
				//   3: 시간 초과
			});
			
			var maxspeed = 0;
			navigator.geolocation.watchPosition(function(position) {
				//이동 거리 측정
				var d = calculateDistance(startPos.coords.latitude, startPos.coords.longitude,
                        position.coords.latitude, position.coords.longitude);
				document.getElementById('distance').value = d.toFixed(2);
				//이동 속도 측정
				var s = position.coords.speed * 3.6;
				if (s != null) {
					document.getElementById('speed').innerHTML = s;
					if(s > maxspeed) {
						maxspeed = s;
						document.getElementById('maxspeed').value = maxspeed;
					}
				}
			});
		}
	} else {
		keepgoin = 2;
		ptimer();
		i = 0;
		rest.className = "divShow";
		cycle.className = "divHide";
		document.getElementById('spbtn').src = img[1];
	}

});

//이동 거리 구하는 함수
function calculateDistance(lat1, lon1, lat2, lon2) {
  var R = 6371; // km
  var dLat = (lat2 - lat1).toRad();
  var dLon = (lon2 - lon1).toRad(); 
  var a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
          Math.cos(lat1.toRad()) * Math.cos(lat2.toRad()) * 
          Math.sin(dLon / 2) * Math.sin(dLon / 2); 
  var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a)); 
  var d = R * c;
  return d;
}

Number.prototype.toRad = function() {
  return this * Math.PI / 180;
};


function mapview() {
	$("#mapview").show();
	$("#cycleview").hide();
}

function cycleview() {
	$("#cycleview").show();
	$("#mapview").hide();
}

$(document).on('click','result',function() {
	keepgoin = 0;
	endposition();
});


//================================지도 JavaScript==============================
var map;

$(document).ready(function() {
		navigator.geolocation.getCurrentPosition(function(position) {
			var lat = position.coords.latitude;
			var lng = position.coords.longitude;

			document.getElementById('lat').value = lat;
			document.getElementById('lng').value = lng;

			startposition();
		}, function(error) {
			alert("Error occurred. Error code: " + error.code);
			// error.code는 다음을 의미함:
			//   0: 알 수 없는 오류
			//   1: 권한 거부
			//   2: 위치를 사용할 수 없음 (이 오류는 위치 정보 공급자가 응답)
			//   3: 시간 초과
		});
});
var watchId;
$(document).on('click', '#start', function() {
	//showAddress(position.latitude,position.longitude);	
	watchId = navigator.geolocation.watchPosition(function(position) {
		var lat = position.coords.latitude;
		var lng = position.coords.longitude;

		document.getElementById('lat').value = lat;
		document.getElementById('lng').value = lng;

		nowposition();		
	}, function(error) {},{enableHighAccuracy : true});
});

var startPos;
var bounds;
function startposition() {
	var lat = document.getElementById('lat').value;
	var lng = document.getElementById('lng').value;
	startPos = new daum.maps.LatLng(lat, lng);
	bounds = new daum.maps.LatLngBounds();

	map = new daum.maps.Map(document.getElementById('map'), {
		center : startPos,
		level : 3
	});

	var marker = new daum.maps.Marker({
		position : startPos
	});
	marker.setMap(map);
	bounds.extend(startPos);

	map.panTo(startPos);
}

function nowposition() {
	var lat = document.getElementById('lat').value;
	var lng = document.getElementById('lng').value;
	var position = new daum.maps.LatLng(lat, lng);
	var oldPos = startPos;

	var line = new daum.maps.Polyline();
	line.strokeWeight = 30;
	line.setPath([ oldPos, position ]);
	line.setMap(map);

	bounds.extend(position);
	map.panTo(position);
	map.setCenter(position);

	oldPos = position;
}

function endposition() {
	var lat = document.getElementById('lat').value;
	var lng = document.getElementById('lng').value;
	var position = new daum.maps.LatLng(lat, lng);
	var marker = new daum.maps.Marker({
		position : position
	});
	marker.setMap(map);
	map.setBounds(bounds);
	navigator.geolocation.clearWatch(watchId);
}

function zoomIn() {
	map.setLevel(map.getLevel() - 1);
}

function zoomOut() {
	map.setLevel(map.getLevel() + 1);
}

//좌표값 주소값 변환 코드
/*function showAddress(lat, lng){
	//$.getJSON('url', queryString, callback);
	$.getJSON('/coord2addr', {
		apikey: '8db30bf9a40346f09386dbf3e5d4c3441852dfa8',
		longitude: lng,
		latitude: lat,
		formatz: 'simple',
		output: 'json',
		inputCoordSystem: 'WGS84'
	}, function(data) {
		$('#address').text(data.name1+' '+data.name2+' '+data.name3);
	});	
};*/