<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
<title>${store.deptname} | 매장안내 - NEW ME HOTTRACKS</title>
<script type="text/javascript">
jQuery(function($){
    $('#subTitle').html('매장안내');
    $("#wrap").addClass("mypage_v2");
    $("#locStore1").addClass("active");
    
    //$("body").addClass("bg_gray");
});

function loadEvent(){
    if($(".banner_basic").hasClass("active")){
        $(".banner_basic").removeClass("active");
    }else{
        $(".banner_basic").addClass("active");
    }
}
</script>
<style>
.w_top {
    margin: 0;
    padding: 0px 5px 10px 5px;
    border-bottom: none;
    background: #fff;
}
#shopinfo_event {
    padding: 0px;
}
</style>
</head>
<body>
<div class="w_top">
    <h2 class="tit_type1">${store.deptname}</h2>
    <p class="">${store.rdpAddr}</p>
</div>
<div class="gray_box  mt10">
    <div id="shopinfo_event">
        <div class="hotevent">
            <div class="banner_basic t_c active">
                <ul id="eventList">
                    <c:forEach items="${listEvent}" var="l" varStatus="st">
                        <li>
                            <a href="/m/help/storeBoard?bbsRegType=${l.bbsRegType}&boardseq=${l.boardseq}&rdpCode=${store.rdpCode}">
                                <c:if test="${not empty l.imgurl}">
                                    <c:if test="${l.bbsRegType eq 'M'}">
                                       <p style="max-height:150px;overflow:hidden;"><ui:image src="${l.imgurl}" alt="${l.title}" style="max-height:initial;border-radius:2px;"/></p>
                                    </c:if>
                                    <c:if test="${l.bbsRegType eq 'H'}">
                                        <p><img src="http://info.hottracks.co.kr${l.imgurl}"  alt="${l.title}" style="border-radius:2px;"/></p>
                                    </c:if>
                                </c:if>
                                <p class="tit"><strong>행사명 : ${l.title}</strong></p>
                                <c:choose>
                                    <c:when test="${l.enddate eq '20180101' && l.bbsRegType eq 'M'}">
                                        <p class="txt">이벤트 기간 : <ui:mask pattern="####.##.##">${l.startdate}</ui:mask> ~ 재고소진시까지</p>
                                    </c:when>
                                    <c:otherwise>
                                        <p class="txt">이벤트 기간 : <ui:mask pattern="####.##.##">${l.startdate}</ui:mask> ~ <ui:mask pattern="####.##.##">${l.enddate}</ui:mask></p>
                                    </c:otherwise>
                                </c:choose>
                            </a>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </div>
    </div>
</div>
<div class="store_list roundbox pd10_0 mt10">
    <ul class="br_list" style="line-height:20px;text-align:left;">
        <li class="border_none">
            <strong class="fl_l">대표전화</strong>
            <span class="fl_r ta_l">
                ${store.rdpTlnm} <a href="tel:${store.rdpTlnm}" class="btn btn_tel">전화걸기</a>
                <br/>교보문고 관련 문의는<br/>(도서 및 기타 문고상품 포함)<br/>1544-1900으로 문의바랍니다.
            </span>
        </li>
        <li>
            <strong class="fl_l">영업시간</strong>
            <span class="fl_r"><ui:br>${store.rdpTime}</ui:br></span>
        </li>
        <li>
            <strong class="fl_l">정기휴일</strong>
            <span class="fl_r"><ui:br>${store.rdpOffday}</ui:br></span>
        </li>
        <li>
            <div id="map" style="width:100%;height:350px;margin-top:20px;"></div>
        </li>
        <li>
            <strong>교통편안내</strong><br/>
            <ui:br>${store.rdpTraffic}</ui:br>
        </li>
        <li>
            <strong>주차안내</strong><br/>
            <ui:br>${store.rdpParking}</ui:br>
        </li>
    </ul>
</div>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=fcb0fcf1b62584364d5853ff4c6b56c7&libraries=services"></script>
<script type="text/javascript">
var map;

// 주소-좌표 변환 객체를 생성한다
var geocoder = new daum.maps.services.Geocoder();
// 주소로 좌표를 검색한다
geocoder.addressSearch('${store.rdpAddr}', function(result, status) {
    // 정상적으로 검색이 완료됐으면 
     if (status === daum.maps.services.Status.OK) {
        var coords = new daum.maps.LatLng(result[0].y, result[0].x);
        var lat = result[0].y;
        var lng = result[0].x;
        var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
        mapOption = {
        	center: new daum.maps.LatLng(result[0].y, result[0].x), // 지도의 중심좌표
            level: 3, // 지도의 확대 레벨
            mapTypeId : daum.maps.MapTypeId.ROADMAP // 지도종류
        }; 
        
        // 지도를 생성한다 
        map = new daum.maps.Map(mapContainer, mapOption); 
        
        //마우스 드래그와 모바일 터치를 이용한 지도 이동을 막지않는다
        map.setDraggable(false);
        map.setZoomable(false);
        
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
    
        var iwContent = '<div style="padding:5px;"><b>${store.deptname}</b> <br><a href="http://map.daum.net/link/map/${store.deptname},'+lat+','+lng+'" style="color:blue" target="_blank">큰지도보기</a> <a href="http://map.daum.net/link/to/${store.deptname},'+lat+','+lng+'" style="color:blue" target="_blank">길찾기</a></div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
            iwPosition = new daum.maps.LatLng(lat, lng); //인포윈도우 표시 위치
        
        // 인포윈도우를 생성한다
        var infowindow = new daum.maps.InfoWindow({
            position : iwPosition, 
            content : iwContent 
        });
          
        // 마커 위에 인포윈도우를 표시한다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시된다
        infowindow.open(map, marker); 
    }else{
        alert("${store.deptname} 지도를 불러올 수 없습니다.");
    }
});

// 버튼 클릭에 따라 지도 이동 기능을 막거나 풀고 싶은 경우에는 map.setDraggable 함수를 사용합니다
function setMapToggle() {
    // 마우스 드래그로 지도 이동 가능여부를 설정합니다
    var isToggle = map.getDraggable();
    map.setDraggable(!isToggle);
    map.setZoomable(!isToggle);
}
</script>
</body>
</html>