var position = new daum.maps.LatLng(37.484399935513736, 126.91644415736222);
var startPos;
var oldPos;
var map;

$(document).ready(function() {
	map = new daum.maps.Map(document.getElementById('map'), {
		center : position,
		level : 1
	});
	navigator.geolocation.getCurrentPosition(function(position) {
		var lat = position.coords.latitude;
		var lng = position.coords.longitude;

		startposition(lat, lng);
	});
	
	callposition();
		
	var marker = new daum.maps.Marker({
		position : position
	});
	marker.setMap(map);
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
		var bounds = new daum.maps.LatLngBounds();
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
	});
}