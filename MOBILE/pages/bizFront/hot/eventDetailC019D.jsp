<%@ page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<!-- 태그 라이브러리 -->
<%@ include file="/pages/decorators/biz/tagHeader.jsp" %>
<ui:decorator name="bizFull"/>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now}" pattern="yyyyMMdd" var="today" />
<head>
<title>${detail.eventTitle} - NEW ME HOTTRACKS</title>
<meta property="fb:app_id" content="981386905311018" />
<meta property="og:type" content="shopping" />
<meta property="og:title" content="HOTTRACKS - ${detail.eventTitle}" />
<meta property="og:url" content="http://m.hottracks.co.kr/e/${detail.eventId}" />
<c:choose>
    <c:when test="${not empty detail.eventRangeInfo}"><meta property="og:description" content="${detail.eventRangeInfo}"/></c:when>
    <c:otherwise><meta property="og:description" content="<ui:mask pattern="####.##.##">${detail.eventStartDt}</ui:mask> ~ <ui:mask pattern="####.##.##">${detail.eventEndDt}</ui:mask>"/></c:otherwise>
</c:choose>
<meta property="og:image" content="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${detail.thumUrl}" />
<link rel="image_src" href="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${detail.thumUrl}" />
<script type="text/javascript" src="/js/jquery.rwdImageMaps.min.js"></script>
<script type="text/javascript" src="/js/jquery.form.js"></script>

<!--  레코벨 스크립트 -->
<script type="text/javascript">
  var _recoUserId = getCookie('UserCookieKey');
  window._eglqueue = window._eglqueue || [];
  _eglqueue.push(['setVar','cuid','e15e978e-3623-4892-bf0a-485b9f8196ee']);
  _eglqueue.push(['setVar','planId','${detail.eventId}']);
  _eglqueue.push(['setVar','userId',SHA256(_recoUserId)]);  // optional
  _eglqueue.push(['track','view']); 
  setTimeout(function() {
    (function(s,x){s=document.createElement('script');s.type='text/x-x-javascript';
    s.async=true;s.defer=true;s.src=(('https:'==document.location.protocol)?'https':'http')+
    '://logger.eigene.io/js/logger.min.js';
    x=document.getElementsByTagName('script')[0];x.parentNode.insertBefore(s, x);})();
  }, 0);
</script>
<!--  레코벨 스크립트 끝-->

<style type="text/css">
.timetable { overflow:hidden; }
.timetable .timetable_top img { width:100%; }
.timetable .timetable_bottom img { width:100%; }
.timetable .sun { color:#e43724 !important; }
.timetable .sat { color:#2226e3 !important; }
.timetable .table { width:100%;border-collapse:separate;border-spacing:2px;background:none;padding:5px;border-radius:5px; }
.timetable .table thead th { color:#fff;font-family:Arial;line-height:40px;font-size:1rem;font-weight:bold;background-color:#ff8393 ; }
.timetable .table tbody td { position:relative;text-align:center;vertical-align:middle;height:90px; }
.timetable .table tbody td .date { position:absolute;left:0;top:0;text-align:left;padding:10px;font-size:10px;font-family:'돋움','Dotum';background:none;line-height:0.75rem;color:#666; }
.timetable .table tbody td .checked { display:block;text-indent:-999px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;width:100%;height:100%; }
/* .timetable .table tbody td .checked01 { background:url('http://image.kyobobook.co.kr/newimages/giftshop_new/work/1874/1522828543421_icon_1.png') no-repeat 50% 50%;background-size:100% auto; } */
.timetable .table tbody td .checked01 { background:url('http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/event/70972/check.png') no-repeat 50% 50%;background-size:100% auto; }
.timetable .table tbody td .checked02 { background:url('http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/event/67354/check_icon.png') no-repeat 50% 50%;background-size:100% auto; }
.timetable .table tbody td .checked03 { background:url('http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/event/70496/check.png') no-repeat 50% 50%;background-size:100% auto; }
.timetable .table tbody td a { padding-top: 1.3rem;font-size: 14px; text-align: center;font-family:'돋움','Dotum'; }
.timetable .table tbody td a.date02 { padding-top:10px;font-size:1.5rem;font-weight:bold;font-family:Arial; }
.timetable .table tbody td a span { color:#000;font-weight:bold; }
.timetable .table tbody td a span.G { color:#f25f2b; }
.timetable .table tbody td a span.C { color:#e4fce6; }
.timetable .table tbody td a span.txt01 { color:#6c3bda; }
.timetable .table tbody td a span.txt02 { color:#868686; }
.timetable .txt_cpn { color: #41b749; }
.timetable .txt_gift { color: #f47020; }

@media only screen and (min-width : 1024px) {
    .timetable .table thead th { font-size:1.5rem; }
    .timetable .table tbody td { height:160px; }
    .timetable .table tbody td .date { font-size:1.5rem; } 
    .timetable .table tbody td a { font-size:1.5rem; }
}
@media only screen and (max-width : 800px) {
    .timetable .table thead th { font-size:1rem; }
    .timetable .table tbody td { height:100px; }
    .timetable .table tbody td .date { padding:5px;font-size:1rem; } 
    .timetable .table tbody td a { font-size:1rem; }
}
@media only screen and (max-width : 500px) {
    .timetable .table thead th { font-size:0.78rem; }
    .timetable .table tbody td { height:90px; }
    .timetable .table tbody td .date { padding:0.3rem;font-size:0.75rem; } 
    .timetable .table tbody td a { font-size:0.78rem; }
}
@media only screen and (max-width : 370px) {
    .timetable .table thead th { font-size:0.65rem; }
    .timetable .table tbody td { height:80px; }
    .timetable .table tbody td .date { padding:0.3rem;font-size:0.75rem; } 
    .timetable .table tbody td a { font-size:0.65rem; }
}

.timetable .info_box { display:block;text-align: center;background:none;padding:10px 0 20px; }
.timetable .info_box .info_cnt { position:relative;line-height:25px;color:#fff;display:inline-block;font-family:Arial;font-size:15px; }
.timetable .info_box .info_cnt + .info_cnt { margin-left:20px; } 
.timetable .info_box .info_cnt.point { padding-left:67px;background:url('http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/event/44731/txt_point.png') no-repeat 0 50%;background-size:auto 100%; }
.timetable .info_box .info_cnt.coupon { padding-left:57px;background:url('http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/event/44731/txt_coupon.png') no-repeat 0 50%;background-size:auto 100%; }

div.visual.swipe-main div.pagination {background: transparent;text-align: center; position: relative; width: 100%; left: 0; bottom: 14px;}
.event_wrap .visual{margin : 0px; height : auto; width : 100%;}
div.event_cont div.event_wrap div.visual.swipe-main div.swiper-container{margin : 0; margin-bottom : -10px;}
</style>
<script type="text/javascript">
var itemList = new Array();
var date = new Date();

var yy = date.getFullYear();
var mm = date.getMonth()+1;
var dd = date.getDate();
var hh = date.getHours();
var chkCnt = 0;

if((mm+"").length < 2){
	mm = "0"+mm;
}
if((dd+"").length < 2){
	dd = "0"+dd;
}

today = yy+''+mm+''+dd;

jQuery(function($){
    $('img[usemap]').rwdImageMaps();
    $("#wrap").removeClass("mini");
    $("#locEvent").addClass("active");
    $(window).load(function(){
        if('${skip}' == 'skipEvent'){
            $(".ly_box_skip").addClass("active");
            $(".ly_box_skip.active").css("height", $(".event_info").height());
        }   
    });
    $("img.lazy").lazyload({placeholder:'/images/no_image2.gif',effect : "fadeIn"});
    
    $("area").attr("onfocus","this.blur();");
    
    var eventId = '${detail.eventId}';
	if(eventId == '68151'){
		for(var i=0; i < itemList.length; i++){
			alert(itemList[i])
			$('#'+itemList[i]).addClass('on');
		}
	}
});

$(document).ready(function() {
    if ("68151"=="${detail.eventId}" || "68152"=="${detail.eventId}" || "68153"=="${detail.eventId}" || "68154"=="${detail.eventId}") {
    	var menutap = $(".menutap").offset().top;
        $(window).scroll(function() {
            var window = $(this).scrollTop();

            if(menutap <= window) {
              $(".menutap").addClass("fixed");
            } else {
              $(".menutap").removeClass("fixed");
            }
        });
	};

});

isLogin = ${isLogin};
function onCalClick(giftType, couponId, eventDt){
    if (!isLogin) {
        needLogin();
    }else {
        if(giftType == 'C'){
            $.ajax({
                type: "POST"
                ,url:"/m/coupon/productCouponDown"
                ,dataType: 'json'
                ,data : {couponId : couponId}
                ,success: function(data) {
                    if (data.save) {
                        successProc(eventDt);
                    } else {
                        alert(data.errorMessage);
                    }
                }
                ,error: function() {
                    console.log('<fmt:message key="error.common.system"/>');
                }
            });
        }else{
        	if(chkCnt == 0){
            	successProc(eventDt);
        	}
        }
    }
}
function moveToLayer(preInseq, moveInseq){
    if(preInseq != moveInseq){
        $("#eventTypeInseq"+preInseq).find("option[value="+preInseq+"]").attr("selected", true);
        $("html,body").animate({scrollTop: $("#eventTypeInseq"+moveInseq).offset().top - $("#header").height()}, 500);
    }
}
function successProc(eventDt){
	chkCnt = 1;
    $.ajax({
        type: 'POST'
        ,url: '/m/hot/saveCheckEvent'
        ,data: {eventId:"${detail.eventId}",eventDt:eventDt}
        ,dataType: 'json'
        ,success: function(data) {
            alert(data.alert);
            if (data.save) {
                location.reload(true);
                chkCnt = 0;
            }
        }
        ,error: function(data) {
            alert('출석체크 중 오류가 발생하였습니다. 잠시 후 다시 이용해주세요');
            chkCnt = 0;
        }
    });
}
//68151 이벤트 1회용
function eventRequest_68151(eventNum) {
	var adAltRcvYn = '${device.adAltRcvYn}';
    if (!isLogin) {
        needLogin();
    } else {
        $.ajax({
            type: "GET"
            ,url: "/m/getEventRequest"
            ,data: 'eventNum=' + eventNum
            ,dataType: "json"
            ,success: function(data) {
                if (data.save) {
                	successProc(today);
                } else {
                    if(data.msg.indexOf('2day') != -1){
                    	if(adAltRcvYn == 'Y'){
                    		successProc(today);
                    	}else{
                    		alert('오늘의 미션을 수행하고 도전해주세요! (2day)');
                    		return false;
                    	}
                    }else if(data.msg.indexOf('5day') != -1){
                    	alert("마이페이지 회원정보 채우기를 완료한 경우에만 포인트가 적립되며, 미완료시 적립 취소됩니다.");
                    	successProc(today);
                    }else{
                    	alert(data.msg);
                    }
                }
            }
            ,error: function() {
                alert('<fmt:message key="error.common.system"/>');
            }
        });
    }
}

//68151 이벤트 1회용
function appCheck_68151(){
	if (!isLogin) {
        needLogin();
    } else {
    	var device = '${device.devId}';
    	if(!isEmpty(device)){
    		location.href = "/m/biz/hot/setting";
    	}else{
    		alert('모바일 앱에서만 신청가능합니다.');
    	}	
    }
}
</script>
</head>
<c:if test="${detail.eventId ne '68151'}">
	<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${detail.thumUrl}" class="sns_img" style="display:none;"/>
	<c:if test="${not empty detail.thumUrl}"><div style="display:none;"><ui:image src="${detail.thumUrl}" clazz="kakao-img"/></div></c:if>
</c:if>
<c:set var="checkYn" value="false"/>
<c:set var="giftType" value="N"/>
<c:set var="cpnId" value=""/>
<c:forEach items="${history}" var="l">
    <c:if test="${l.eventDt eq today}">
        <c:set var="giftType">${l.giftType}</c:set>
        <c:set var="checkYn">${l.checkYn}</c:set>
        <c:set var="cpnId">${l.cpnId}</c:set>
    </c:if>
</c:forEach>
<c:if test="${detail.eventId eq '68151'}">
	<c:forEach items="${history}" var="l">
		<c:if test="${l.checkYn}">
		    <script type="text/javascript">
		    	itemList.push('${l.eventDt}');
			</script>
		</c:if>
	</c:forEach>
</c:if>
<!-- content -->
<div id="content">
	<!-- event_view -->
	<div class="event_view">
		<!-- event_title -->
		<div class="event_title">
	        <h5>${detail.eventDtlCont}</h5>
	        <p class="date font_t ${detail.eventRangeInfo}">
	        <c:choose>
	        <c:when test="${not empty detail.eventRangeInfo && detail.eventRangeInfo != '' && detail.eventRangeInfo != ' ' }">${detail.eventRangeInfo}</c:when>
	        <c:otherwise><ui:mask pattern="####.##.##">${detail.eventStartDt}</ui:mask> ~ <ui:mask pattern="####.##.##">${detail.eventEndDt}</ui:mask></c:otherwise>
	        </c:choose>
	        </p>
	        <a href="javascript:layerPopup('.popup_sns');" class="share"><span>공유하기</span></a>
	    </div>
	    <!-- event_title -->
<!-- event_view_cont -->
	<div class="event_view_cont">
		<div>
<div class="ly_box_skip">
    <p>종료된 이벤트 입니다.</p>
</div>
<div class="event_info">
    <div class="event_cont">
        <div class="timetable">
            <div class="timetable_top">
                      <c:choose>
                          <c:when test="${not empty mobImage}">
                              <div><ui:image src="${mobImage.imageUrl}" id="eventImageUrl" usemap="#eventImageMap" clazz="detail-img"/></div>
                              <c:if test="${mobImage.userTmplUseYn}"><div>${mobImage.userTmpl}</div></c:if>
                          </c:when>
                          <c:otherwise>
                              <c:if test="${not empty detail.imageUrl}"><div><ui:image src="${detail.imageUrl}" id="eventImageUrl" usemap="#eventImageMap" clazz="detail-img"/></div></c:if>
                              <c:if test="${detail.userTmplUseYn eq 'Y'}"><div>${detail.userTmpl}</div></c:if>
                          </c:otherwise>
                      </c:choose>
            </div>
            <c:if test="${detail.eventId ne '68151'}">
            <table class="table checkTable">
                <colgroup>
                    <col width="14.3%"/>
                    <col width="14.3%"/>
                    <col width="14.3%"/>
                    <col width="14.3%"/>
                    <col width="14.3%"/>
                    <col width="14.3%"/>
                    <col width="14.2%"/>
                </colgroup>
                <thead>
                    <tr>
                       <th scope="row" class="sun">SUN</th>
                       <th scope="row">MON</th>
                       <th scope="row">TUE</th>
                       <th scope="row">WED</th>
                       <th scope="row">THU</th>
                       <th scope="row">FRI</th>
                       <th scope="row" class="sat">SAT</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${history}" varStatus="s1" step="7">
                        <tr>
                            <c:forEach items="${history}" var="l" varStatus="st" begin="${s1.index}" end="${s1.index + 6}">
                                <fmt:formatNumber var="dt" value="${fn:substring(l.eventDt, 6, 8)}"/>
                                <td id="${st.index+1}">
                                    <c:choose>
                                        <c:when test="${l.checkYn}">
                                            <c:choose>
                                                <c:when test="${l.giftType eq 'G' && l.giftName eq '출석체크' && l.eventId eq '70496'}"><span class="checked checked03">출석완료</span></c:when>
                                                <c:when test="${l.giftType eq 'G' && l.giftName eq '출석체크' && l.eventId eq '70972'}"><span class="checked checked01">출석완료</span></c:when>
                                                <c:when test="${l.giftType eq 'G' && l.giftName eq '출석체크'}"><span class="checked checked01">출석완료</span></c:when>
                                                <c:otherwise><span class="checked checked02">응모완료</span></c:otherwise>
                                            </c:choose>
                                        </c:when>
                                        <c:when test="${l.giftType eq 'G' && l.giftName eq '출석체크'}">
                                            <a href="#" onclick="onCalClick('${l.giftType}', '${l.cpnId}', '${l.eventDt}');return false;" class="date02 <c:if test="${st.count eq 1}"> sun</c:if><c:if test="${st.count eq 7}"> sat</c:if>" class="${l.giftType }">${dt}</a>
                                        </c:when>
                                        <c:when test="${l.giftType eq 'P'}">
                                            <a href="#" onclick="onCalClick('${l.giftType}', '${l.cpnId}', '${l.eventDt}');return false;" class="date02 <c:if test="${st.count eq 1}"> sun</c:if><c:if test="${st.count eq 7}"> sat</c:if>" class="${l.giftType }">${dt}</a>
                                        </c:when>
                                        <c:otherwise>
                                            <c:choose>
                                                <c:when test="${l.giftType eq 'N'}">
                                                    &nbsp;
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="date<c:if test="${st.first}"> sun</c:if><c:if test="${st.last}"> sat</c:if>" class="${l.giftType }">${dt}</span>
                                                    <c:set var="ment" value=""/>
                                                    <c:choose>
                                                        <%-- <c:when test="${l.giftType eq 'P'}">
                                                            <c:choose>
                                                                <c:when test="${l.limitCnt > 0}"><c:set var="ment"><span class="txt01">랜덤<br/>포인트</span></c:set></c:when>
                                                                <c:otherwise><c:set var="ment"><span class="txt02">${l.giftAmt}P</span></c:set></c:otherwise>
                                                            </c:choose>
                                                        </c:when> --%>
                                                        <c:when test="${l.giftType eq 'C'}">
                                                            <c:set var="ment">
                                                                <c:choose>
                                                                    <c:when test="${l.cpnAmt eq 1000}"><c:set var="couponAmt" value="천"/></c:when>
                                                                    <c:when test="${l.cpnAmt eq 2000}"><c:set var="couponAmt" value="2천"/></c:when>
                                                                    <c:when test="${l.cpnAmt eq 10000}"><c:set var="couponAmt" value="1만"/></c:when>
                                                                </c:choose>
                                                                <span class="txt_cpn ${l.giftType}">${couponAmt}원<br/> 쿠폰</span>
                                                            </c:set>
                                                        </c:when>
                                                        <c:when test="${l.giftType eq 'G'}">
                                                            <c:if test="${l.pwnrYn eq 'Y'}"><c:set var="ment"><span class="txt_gift ${l.giftType }">${l.limitCnt}명<br/><ui:br>${l.giftName}</ui:br></span></c:set></c:if>
                                                        </c:when>
                                                    </c:choose>
                                                    <a class="${l.giftType}" href="#" onclick="onCalClick('${l.giftType}', '${l.cpnId}', '${l.eventDt}'); return false;">${ment}</a>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </c:forEach>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            </c:if>
            <c:if test="${not empty detail.userTmplHtml}">
                <div class="event_wrap mt20">
                    <!--  header img -->
                    <textarea name="userTmplHtml" style="display : none;">${detail.userTmplHtml}</textarea>
                    <div id="header_userTemplate"></div>
                    <div class="visual swipe-main">
                        <div class="swiper-container"><ul class="swiper-wrapper"></ul></div>
                        <div class="pagination"></div>
                    </div>
                    <div id="footer_userTemplate" ></div>
                </div>
                <script src="/js/fn_htts_event_template.js?201810041523" type="text/javascript"></script>
                <script src="/js/jquery.rwdImageMaps.min.js?20170612" type="text/javascript"></script>
                <style type="text/css"> img[usemap] {border: none;height: auto;max-width: 100%; width: auto;}</style>
                <script type="text/javascript">
                // 메인배너
                $(document).ready(function(){
                    var welcomeSwiper = new Swiper('.swipe-main .swiper-container',{
                        pagination: '.swipe-main div.pagination',
                        loop:true,
                        grabCursor: true,
                        paginationClickable: true,
                        autoplay: 3000,
                        autoplayDisableOnInteraction: false
                    });
                    $('img[usemap]').rwdImageMaps();
                    
                });
                </script>
            </c:if>
            <c:if test="${detail.eventId eq '55447'}">
                <div class="timetable_bottom">
                    <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/1294/1535699598733_55447_750_03.gif" usemap="#eventImageMap2" />
                    <!-- 출석체크하기 버튼-->
                    <map name="eventImageMap2">
                        <area shape="rect" coords="109,29,673,201" href="#" onclick="onCalClick('${giftType}', '${cpnId}', '${today}');return false;" />
                    </map>
                </div>
            </c:if>
            <c:if test="${detail.eventId eq '56049'}">
                <div class="timetable_bottom">
                    <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/1325/1542356819845_56049_750_02.jpg" usemap="#eventImageMap2" />
                    <!-- 출석체크하기 버튼-->
                    <map name="eventImageMap2">
                        <area shape="rect" coords="109,29,673,201" href="#" onclick="onCalClick('${giftType}', '${cpnId}', '${today}');return false;" />
                    </map>
                </div>
            </c:if>
            <c:if test="${detail.eventId eq '56739'}">
                <div class="timetable_bottom">
                    <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/1906/1540970839798_950_2.jpg" usemap="#eventImageMap2" />
                    <!-- 출석체크하기 버튼-->
                    <map name="eventImageMap2">
                        <area shape="rect" coords="109,29,673,201" href="#" onclick="onCalClick('${giftType}', '${cpnId}', '${today}');return false;" />
                    </map>
                </div>
            </c:if>
            <c:if test="${detail.eventId eq '57396'}">
                <div class="timetable_bottom">
                    <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/1415/1545105734388_57396_950_mobile_bottomgift.jpg" usemap="#eventImageMap2"/>
                </div>
            </c:if>
            
            <c:if test="${detail.eventId eq '58371'}">
                <div class="timetable_bottom">
                    <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/1799/58371_1920_05_1.jpg" usemap="#eventImageMap2" />
                </div>
            </c:if>
            
            <c:if test="${detail.eventId eq '64044'}">
                <div class="timetable_bottom">
                    <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/event/64044/64044_750_mo_02.jpg" usemap="#eventImageMap2" />
                    <map name="eventImageMap2">
                        <area shape="rect" coords="109,29,673,201" href="#" onclick="onCalClick('${giftType}', '${cpnId}', '${today}');return false;" />
                    </map>
                </div>
            </c:if>
            
            <c:if test="${detail.eventId eq '65238'}">
                <div class="timetable_bottom">
                    <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/event/65238/65238_750_02.jpg" usemap="#eventImageMap2" />
                    <map name="eventImageMap2">
                        <area shape="rect" coords="109,29,673,201" href="#" onclick="onCalClick('${giftType}', '${cpnId}', '${today}');return false;" />
                    </map>
                </div>
            </c:if>
            
            <c:if test="${detail.eventId eq '65902'}">
                <div class="timetable_bottom">
                    <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/event/65902/65902_750_02.jpg" usemap="#eventImageMap2" />
                    <map name="eventImageMap2">
                        <area shape="rect" coords="109,29,673,201" href="#" onclick="onCalClick('${giftType}', '${cpnId}', '${today}');return false;" />
                    </map>
                </div>
            </c:if>
            
            <c:if test="${detail.eventId eq '66359'}">
                <div class="timetable_bottom">
                    <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/event/66359/66359_750_02.jpg" usemap="#eventImageMap2" />
                    <map name="eventImageMap2">
                        <area shape="rect" coords="109,29,673,201" href="#" onclick="onCalClick('${giftType}', '${cpnId}', '${today}');return false;" />
                    </map>
                </div>
            </c:if>
            
            <c:if test="${detail.eventId eq '66891'}">
                <div class="timetable_bottom">
                    <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/event/66891/66891_750_02.jpg" usemap="#eventImageMap2" />
                    <map name="eventImageMap2">
                        <area shape="rect" coords="109,29,673,201" href="#" onclick="onCalClick('${giftType}', '${cpnId}', '${today}');return false;" />
                    </map>
                </div>
            </c:if>
                        
            <c:if test="${detail.eventId eq '66321'}">
                <div class="timetable_bottom">
                    <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/event/66321/66321_bottom_1.jpg" usemap="#eventImageMap2" />
                    <map name="eventImageMap2">
                        <area shape="rect" coords="109,29,673,201" href="#" onclick="onCalClick('${giftType}', '${cpnId}', '${today}');return false;" />
                    </map>
                </div>
            </c:if>       
            
            <c:if test="${detail.eventId eq '67354'}">
                <div class="timetable_bottom">
                    <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/event/67354/67353_m_02.jpg" usemap="#eventImageMap2" />
                    <map name="eventImageMap2">
                        <area shape="rect" coords="109,29,673,201" href="#" onclick="onCalClick('${giftType}', '${cpnId}', '${today}');return false;" />
                    </map>
                </div>
            </c:if>
            
            <c:if test="${detail.eventId eq '67710'}">
                <div class="timetable_bottom">
                    <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/event/67710/67710_m_02.jpg" usemap="#eventImageMap2" />
                    <map name="eventImageMap2">
                        <area shape="rect" coords="109,29,673,201" href="#" onclick="onCalClick('${giftType}', '${cpnId}', '${today}');return false;" />
                    </map>
                </div>
            </c:if>   
            <c:if test="${detail.eventId eq '68182'}">
                <div class="timetable_bottom">
                    <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/event/68182/68182_m_02.jpg" usemap="#eventImageMap2" />
                    <map name="eventImageMap2">
                        <area shape="rect" coords="109,29,673,201" href="#" onclick="onCalClick('${giftType}', '${cpnId}', '${today}');return false;" />
                    </map>
                </div>
            </c:if>   
            <c:if test="${detail.eventId eq '68794'}">
                <div class="timetable_bottom">
                    <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/event/68794/68794_m_01.jpg" usemap="#eventImageMap2" />
                    <map name="eventImageMap2">
                        <area shape="rect" coords="109,29,673,201" href="#" onclick="onCalClick('${giftType}', '${cpnId}', '${today}');return false;" />
                    </map>
                </div>
            </c:if>  
            <c:if test="${detail.eventId eq '69239'}">
                <div class="timetable_bottom">
                    <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/1391/1596083011169_m_02.jpg" usemap="#eventImageMap2" />
                    <map name="eventImageMap2">
                        <area shape="rect" coords="109,29,673,201" href="#" onclick="onCalClick('${giftType}', '${cpnId}', '${today}');return false;" />
                    </map>
                </div>
            </c:if>
            <c:if test="${detail.eventId eq '69638'}">
                <div class="timetable_bottom">
                    <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/event/69638/69638_m_01.jpg" usemap="#eventImageMap2" />
                    <map name="eventImageMap2">
                        <area shape="rect" coords="109,29,673,201" href="#" onclick="onCalClick('${giftType}', '${cpnId}', '${today}');return false;" />
                    </map>
                </div>
            </c:if>  
            <c:if test="${detail.eventId eq '70109'}">
                <div class="timetable_bottom">
                    <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/event/70109/70109_m_01.jpg" usemap="#eventImageMap2" />
                    <map name="eventImageMap2">
                        <area shape="rect" coords="109,29,673,201" href="#" onclick="onCalClick('${giftType}', '${cpnId}', '${today}');return false;" />
                    </map>
                </div>
            </c:if>
            <c:if test="${detail.eventId eq '70496'}">
                <div class="timetable_bottom">
                    <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/event/70496/70496_m_01.jpg" usemap="#eventImageMap2" />
                    <map name="eventImageMap2">
                        <area shape="rect" coords="109,29,673,201" href="#" onclick="onCalClick('${giftType}', '${cpnId}', '${today}');return false;" />
                    </map>
                </div>
            </c:if>
            <c:if test="${detail.eventId eq '70972'}">
                <div class="timetable_bottom">
                    <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/event/70972/70972_m_01.jpg" usemap="#eventImageMap2" />
                    <map name="eventImageMap2">
                        <area shape="rect" coords="109,29,673,201" href="#" onclick="onCalClick('${giftType}', '${cpnId}', '${today}');return false;" />
                    </map>
                </div>
            </c:if>  
            
        </div><!-- //.timetable -->
    </div><!-- //.event_cont -->
    
    <!-- /link -->
    <c:choose>
        <c:when test="${detail.offLineYn eq 0}">
            <div class="evt_tab">
                <c:forEach items="${listType}" var="l">
                    <c:choose>
                        <c:when test="${not empty l.titleImageUrl}">
                            <a href="#event-link${l.eventTypeInseq}" title="${l.eventTitle}"><em class="ic_cover"></em><ui:image src="${l.titleImageUrl}"/></a>
                        </c:when>
                        <c:otherwise>
                            <a href="#event-link${l.eventTypeInseq}" title="${l.eventTitle}">${l.eventTitle}</a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </div>
            <script type="text/javascript">
                $(".evt_tab a").click(function(e){
                    e.preventDefault();
                    _eventTypeInseq = $(this).attr("href").replace("#event-link", "");
                    $(".evt_tab a.active").removeClass("active");
                    $(this).addClass("active");
                    loadProduct(1);
                    $(window).scrollTop($(".evt_tab").offset().top - $("#header").outerHeight() + 20);
                });
                
                var _eventTypeInseq;
                var _pageHolder;
                function loadProduct(page){
                    $.ajax({
                        url:"/m/hot/getEventProduct"
                      , async:false
                      , data: {eventId:"${detail.eventId}",eventTypeInseq:_eventTypeInseq,page:page}
                      , type:"POST"
                      , dataType:"json"
                      , success:function(data){
                            var obj = document.getElementById("listProduct");
                            _removeChild(obj);
                            
                            if(data && data.list){
                                var list = data.list;
                                
                                var div = _createSimpleElement("div", null, "prod_box");
                                obj.appendChild(div);
                                
                                for(var i = 0; i < list.length; i++){
                                    var product = list[i];
                                    var detailLink = "/p/" + product.sellPrdtBcode;
                                    var imgUrl;
                                    if(product.sellPrdtGbn == "R" || product.sellPrdtGbn == "D"){
                                        detailLink = "/m/record/detail/" + product.sellPrdtBcode;
                                        imgUrl = _imgRecordUrl(product.rcrdCd, product.sellPrdtGbn, "midi");
                                    }else{
                                        detailLink = "/m/gift/detail/" + product.sellPrdtBcode;
                                        imgUrl = _imgUrl(product.productImageUrl, "product", "200");
                                    }
                                    
                                    var anchor = _createSimpleElement("a");
                                    anchor.href = detailLink;
                                    div.appendChild(anchor);
                                    
                                    var pic = _createSimpleElement("span", null, "pic");
                                    if(product.sellPrdtGbn == "D")    pic.classList.add("dvd");
                                    pic.appendChild(_createSimpleImg("imgUrl", imgUrl));
                                    anchor.appendChild(pic);
                                    
                                    var txt_box = _createSimpleElement("span", null, "txt_box");
                                    anchor.appendChild(txt_box);
                                    txt_box.appendChild(_createSimpleElement("em", product.brandEngName, "brand"));
                                    txt_box.appendChild(_createSimpleElement("em", product.prdtName, "tit"));
                                    txt_box.appendChild(_createSimpleElement("em", _fmtNumber(product.lastCpnPrice), "price"));
                                    if(product.prdtSellPrice != product.lastCpnPrice){
                                        txt_box.appendChild(_createSimpleElement("em", "[" + _calDscntRate(product.prdtSellPrice, product.lastCpnPrice, 1) + "%]", "sale"));
                                    }
                                    
                                    var ico_box = _createSimpleElement("span", null, "ico_box");
                                    anchor.appendChild(ico_box);
                                    var reviewCount = product.reviewCount;
                                    var wishPrdtCnt = product.wishPrdtCnt;
                                    if(parseInt(reviewCount) > 99)    reviewCount = "99+";
                                    if(parseInt(wishPrdtCnt) > 99)    wishPrdtCnt = "99+";
                                    if(parseInt(product.reviewCount) >  0)   ico_box.appendChild(_createSimpleElement("em", reviewCount, "ico_review"));
                                    if(parseInt(product.wishPrdtCnt) >  0)   ico_box.appendChild(_createSimpleElement("em", wishPrdtCnt, "ico_like"));
                                    
                                    var bnf_box = _createSimpleElement("span", null, "bnf_box");
                                    anchor.appendChild(bnf_box);
                                    if(product.prdtIcon.charAt(8) == "1")    bnf_box.appendChild(_createSimpleElement("em", "무료배송", "ico_free"));
                                    if(product.prdtIcon.charAt(10) == "1")   bnf_box.appendChild(_createSimpleElement("em", "쿠폰", "ico_coupon"));
                                    if(product.prdtIcon.charAt(12) == "1")   bnf_box.appendChild(_createSimpleElement("em", "GIFT", "ico_gift"));
                                    if(product.dlvyVndrId == "0625")   bnf_box.appendChild(_createSimpleElement("em", "핫트랙스배송", "ico_hottracks"));
                                }
                            }
                      }
                      ,error: function(request, status, error) {
                            alert("상품로드 중 오류가 발생하였습니다. 잠시 후 다시 이용해주세요");
                            // alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
                        }
                    });
                }
                
                $(document).ready(function(){
                    _eventTypeInseq = $(".evt_tab a:first").attr("href").replace("#event-link", "");
                    $(".evt_tab a.active").removeClass("active");
                    $(".evt_tab a:first").addClass("active");
                    loadProduct(1);
                });
            </script>
            <div id="listProduct" class="mgt60"></div>
        </c:when>
        <c:otherwise>
            <c:forEach items="${listType}" var="lp" varStatus="st">
                <div id="event-link${lp.eventTypeInseq}" class="category_wrap">
                <c:if test="${lp.titleUseYn eq 'Y'}">
                    <div class="box_flex t_select" id="eventTypeInseq${lp.eventTypeInseq}">
                        <select class="select" title="정렬 순서 선택" class="eventTypeInseq" onchange="moveToLayer('${lp.eventTypeInseq}', this.value)">
                            <c:forEach items="${listType}" var="ls">
                                <c:if test="${ls.titleUseYn eq 'Y'}">
                                    <option value="${ls.eventTypeInseq}"<c:if test="${lp.eventTypeInseq eq ls.eventTypeInseq}"> selected="selected"</c:if>>${ls.eventTitle}</option>
                                </c:if>
                            </c:forEach>
                        </select>
                    </div>
                </c:if>
                <!-- prod -->
                <div id="eventPrdt${lp.eventTypeInseq}" class="event_prod_${lp.eventPrdtTypeCode}">
                    <c:import url="/m/biz/hot/event/prdtList?eventTypeInseq=${lp.eventTypeInseq}&eventPrdtTypeCode=${lp.eventPrdtTypeCode}"/>
                </div>
                <!-- //prod -->
                </div>
            </c:forEach>
        </c:otherwise>
    </c:choose>
</div><!-- //.event_info -->
</div>		
</div>
	</div>
<!-- event_view -->
</div>
<!-- content -->
<!-- 신규 레이어팝업 : start --> 
<div class="layer_popup popup_sns">
    <div class="inner_layer">
        <div class="sns_content">
            <ul>
                <li><a href="javascript:goTwitter('${detail.eventTitle}', 'http://m.hottracks.co.kr/e/${detail.eventId}')" class="ic_twitter sns01"></a></li>
                <li><a href="javascript:goFaceBook('${detail.eventTitle}', 'http://m.hottracks.co.kr/e/${detail.eventId}')" class="ic_facebook sns02"></a></li>
                <li><a href="javascript:sendKakao('[핫트랙스] ${detail.eventTitle}', 'http://m.hottracks.co.kr/e/${detail.eventId}')" class="ic_kakaotalk sns03"></a></li>
            </ul>
        </div>
    </div>
	<a href="#none" class="layer_close"><span>취소</span></a>
</div>
<!-- 신규 레이어팝업 : end -->
