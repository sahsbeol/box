<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<ui:decorator name="none" />
<c:set var="apiKey">c037465528324275bf246e9866de6151</c:set>
<c:set var="storeMapAddr">${store.rdpAddr}</c:set>
<c:set var="storeMapName">핫트랙스 ${store.deptname}</c:set>
<html>
<head>
<title>${store.deptname} | 영업점 - New Me Hottracks</title>
<style type="text/css">
* { font-size:12px;font-family:Malgun-Gothic; }
</style>
</head>
<body style="margin: 0;padding:0;">
<div id="map" style="width:100%;height:350px;"></div>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${apiKey}&libraries=services"></script>
<script>
    // 주소-좌표 변환 객체를 생성한다
    var geocoder = new daum.maps.services.Geocoder();
    // 주소로 좌표를 검색한다
    geocoder.addressSearch('${storeMapAddr}', function(result, status) {
        // 정상적으로 검색이 완료됐으면
         if (status === daum.maps.services.Status.OK) {
            var coords = new daum.maps.LatLng(result[0].y, result[0].x);
            var lat = result[0].y;
            var lng = result[0].x;
            var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
            mapOption = {
                center: new daum.maps.LatLng(result[0].y, result[0].x), // 지도의 중심좌표
                level: 4, // 지도의 확대 레벨
                mapTypeId : daum.maps.MapTypeId.ROADMAP // 지도종류
            }; 
            
            // 지도를 생성한다 
            var map = new daum.maps.Map(mapContainer, mapOption); 
            
            //마우스 드래그와 모바일 터치를 이용한 지도 이동을 막지않는다
            map.setDraggable(true);
            
            // 지도에 확대 축소 컨트롤을 생성한다
            var zoomControl = new daum.maps.ZoomControl();
            
            // 지도의 우측에 확대 축소 컨트롤을 추가한다
            map.addControl(zoomControl, daum.maps.ControlPosition.RIGHT);
            
            // 마커가 표시될 위치
            var markerPosition  = new daum.maps.LatLng(lat, lng); 
        
            // 마커를 생성한다
            var marker = new daum.maps.Marker({
                position: markerPosition
            });
        
            // 마커가 지도 위에 표시되도록 설정한다
            marker.setMap(map);
        
            var iwContent = '<div style="padding:5px;"><b>${storeMapName}</b> <br><a href="http://map.daum.net/link/map/${storeMapName},'+lat+','+lng+'" style="color:blue" target="_blank">큰지도보기</a> <a href="http://map.daum.net/link/to/${storeMapName},'+lat+','+lng+'" style="color:blue" target="_blank">길찾기</a></div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
                iwPosition = new daum.maps.LatLng(lat, lng); //인포윈도우 표시 위치
            
            // 인포윈도우를 생성한다
            var infowindow = new daum.maps.InfoWindow({
                position : iwPosition, 
                content : iwContent 
            });
              
            // 마커 위에 인포윈도우를 표시한다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시된다
            infowindow.open(map, marker); 
       }else{
            alert("${storeMapName} 지도를 불러올 수 없습니다.");
        }
    });
</script>
</body>
</html>