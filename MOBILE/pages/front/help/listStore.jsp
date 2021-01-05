<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<html>
<head>
<title>매장안내 - NEW ME HOTTRACKS</title>
<script type="text/javascript">
var iosCnt = 0;
jQuery(function($){
    $(document).ready(function(){
        if(window.HybridApp != undefined && window.HybridApp.enhanceLocation != undefined){
            var data = window.HybridApp.enhanceLocation();
            var json = JSON.parse(data);
            var lat = json["LOC_LATITUDE"];
            var long = json["LOC_LONGITUDE"];
            if(lat == undefined || lat == null){
                loadStore("", "");
            } else{
                loadStore(lat, long);
            }
        }else{
            if(navigator && "geolocation" in navigator){
                // var timecheck = setTimeout('loadStore("${latitude}", "${latitude}")', 5000);
                
                var geo_success = (function (position) {
                    loadStore(position.coords.latitude, position.coords.longitude);
                });
                
                var tryAPIGeolocation = function() {
                    jQuery.post( "https://www.googleapis.com/geolocation/v1/geolocate?key=AIzaSyDCa1LUe1vOczX1hO_iGYgyo8p_jYuGOPU", function(success) {
                        geo_success({coords: {latitude: success.location.lat, longitude: success.location.lng}});
                    })
                    .fail(function(err) {
                        // showMsg("위치 정보를 불러오는데 실패하였습니다.[API Fail]");
                        loadStore("${latitude}", "${latitude}");
                        // alert("API Geolocation error! \n\n"+err);
                    });
                };
                
                var geo_error = function(error) {
                    switch (error.code) {
                    case error.TIMEOUT:
                        showMsg("위치 정보를 불러오는데 실패하였습니다.[Timeout]");
                        loadStore("${latitude}", "${latitude}");
                        break;
                    case error.PERMISSION_DENIED:
                        if(error.message.indexOf("Only secure origins are allowed") == 0) {
                            tryAPIGeolocation();
                        }
                        break;
                    case error.POSITION_UNAVAILABLE:
                        // dirty hack for safari
                        if(error.message.indexOf("Origin does not have permission to use Geolocation service") == 0) {
                            tryAPIGeolocation();
                        } else {
                            showMsg("위치 정보를 불러오는데 실패하였습니다.[Position unavailable]");
                            loadStore("${latitude}", "${latitude}");
                        }
                        break;
                }
                };
                var geo_options = {
                  enableHighAccuracy: true, 
                  maximumAge        : 50000, 
                  timeout           : 20000
                };
                var wpid = navigator.geolocation.watchPosition(geo_success, geo_error, geo_options);
            }else{
                loadStore("${latitude}", "${longitude}");
            }
        }
    });
    $('#subTitle').html('매장안내');
    $("#wrap").addClass("mypage_v1");
    $("#locStore1").addClass("active");
    
    function loadStore(latitude, longitude){
        $("#shopinfo_basic").load("/m/help/layerStore?locLat="+latitude+"&locLong="+longitude);
    }
    
});

function showMsg(msg){
    $("#ly_message").text(msg);
    $("#ly_message").fadeIn();
    setTimeout(function(){ $("#ly_message").fadeOut(); }, 2000);
}

function sendGeoLocationiOS2(latitude,longitude){
	if(iosCnt == 0){
	    loadStoreIos(latitude, longitude);
	}
	iosCnt ++;
}

function loadStoreIos(latitude, longitude){
    $("#shopinfo_basic").load("/m/help/layerStore?locLat="+latitude+"&locLong="+longitude);
}

function loadEvent(btnId){
    if($(".banner_basic").hasClass("active")){
        $(".banner_basic").removeClass("active");
        $(document).find(btnId).text("이벤트 더보기 +");
    }else{
        $(".banner_basic").addClass("active");
        $(document).find(btnId).text("이벤트 더보기 -");
    }
}
</script>
</head>
<body>
<div class="gray_box">
    <div id="shopinfo_basic"><img src="${imageServer}/images/mobile/common/ic_store_load.gif" alt="매장찾는중" style="width:200px;margin:20px auto;display:block;"/></div>
</div>
<div id="ly_message" class="ly_base" style="display:none;background: url('/images/season01/bg_layer02.png');position: fixed;top: 50%;left:0;z-index: 999;border-radius: 5px;color: #fff;padding:10px;margin: 10px;width: calc(100% - 40px);text-align: center;font-weight: bold;"></div>
</body>
</html>
