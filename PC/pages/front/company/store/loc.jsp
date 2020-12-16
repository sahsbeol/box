<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
<style type="text/css">
#mapLayer { width : 455px; height:250px; margin: 10px 0 10px;}
iframe{height : 100%; width : 100%; } 
.storeInfoWrap{ width : 719px;position: relative; top: 10px; }
.storeInfoWrapRight div{ background-color: #f4f4f4; padding: 10px 0; position: absolute; top: 194px; left: 693px; height:228px; width: 255px; border: 1px solid #d3d6d9;}
.storeInfoWrapRight dl dd.w240{width : 150px;} 
</style>
</head>
<body>
<div id="container">
<p class="cont_topBg_recruit"><img src="http://image.hottracks.co.kr/info/layout/bg_snb_shop.png" alt="핫트랙스 영업점의 여러가지 소식을 알려드립니다"/></p>
<c:import url="/company/store/lnb?deptcode=${c.deptcode}"/>
<!-- contents area -->
<div id="contents_area">
<h3 class="hidden">영업지점별 안내</h3>
    <div id="location">
        <h2>${store.deptname}</h2>
        <em class="location">HOME &gt; 영업점 &gt; ${store.deptname} &gt; <strong>행사안내</strong></em>
    </div>
    <div id="mapLayer">
        <iframe src="/company/store/map?rdpAddr=${store.rdpAddr}&deptname=${store.deptname}"></iframe>
    </div>
    
    <!--  지도 옆에 만들어질 화면 -->
    <div class="storeInfoWrapRight">
        <div class="storeInfo"><!-- 지점별 정보입력 -->
            <dl>
                <dt><img src="http://image.hottracks.co.kr/info/shop/txt_info_location.png" alt="소재지" /></dt>
                <dd class="w240">${store.rdpAddr }</dd>
                
            </dl>
            <dl>
                <dt><img src="http://image.hottracks.co.kr/info/shop/txt_info_num.png" alt="대표전화" /></dt>
                <dd class="w240">${store.rdpTlnm}</dd>
            </dl>
            <c:if test="${not empty store.rdpTime && not empty store.rdpOffday}">
                <dl>
                    <c:if test="${not empty store.rdpTime}">
                        <dt><img src="http://image.hottracks.co.kr/info/shop/txt_info_time.png" alt="영업시간" /></dt>
                        <dd class="w240">${store.rdpTime}</dd>
                    </c:if>
                </dl>
                <dl>
                    <c:if test="${not empty store.rdpOffday}">
                        <dt><img src="http://image.hottracks.co.kr/info/shop/txt_info_offday.png" alt="정기휴일" /></dt>
                        <dd class="w240">${store.rdpOffday}</dd>
                    </c:if>
                </dl>
            </c:if>
    </div>
    </div>
    <div class="storeInfoWrap">
        <!-- <div class="guide"><span class="TL"></span><span class="TR"></span></div>connering 공통 -->
        <div class="storeInfo"><!-- 지점별 정보입력 -->
            <c:if test="${not empty store.rdpTraffic}">
                <dl>
                    <dt class="w600"><img src="http://image.hottracks.co.kr/info/shop/txt_info_traffic.png" alt="교통편안내" /></dt>
                    <dd class="w600">${store.rdpTraffic}</dd>
                </dl>
            </c:if>
            <c:if test="${not empty store.rdpParking}">
                <dl>
                    <dt class="w600"><img src="http://image.hottracks.co.kr/info/shop/txt_info_parking.png" alt="주차안내" /></dt>
                    <dd class="w600">${store.rdpParking}</dd>
                </dl>
            </c:if>
            <div class="clear"></div><!-- browserBug-->
        </div><!-- //지점별 정보입력 -->
        <div class="guide"><span class="BL"></span><span class="BR"></span></div><!-- //connering 공통 -->
    </div><!-- storeInfoWrap:지점별 영업점 안내 -->
    </div>
</div>
<!-- //contents area -->
</body>
</html>