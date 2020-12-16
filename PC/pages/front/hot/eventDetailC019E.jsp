<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<jsp:useBean id="now" class="java.util.Date" />
<html>
<head>
<title>${detail.eventTitle} - NEW ME HOTTRACKS</title>
<meta property="fb:app_id" content="981386905311018" />
<!--  SNS 공유 내용 -->
<meta property="og:type" content="website"/>
<meta property="og:title" content="${fn:escapeXml(detail.eventTitle)}"/>
<meta property="og:url" content="${defaultHost}/ht/biz/eventDetail?eventId=${detail.eventId}"/>
<c:choose>
    <c:when test="${not empty detail.eventRangeInfo}"><meta property="og:description" content="${detail.eventRangeInfo}"/></c:when>
    <c:otherwise><meta property="og:description" content="<ui:mask pattern="####.##.##">${detail.eventStartDt}</ui:mask> ~ <ui:mask pattern="####.##.##">${detail.eventEndDt}</ui:mask>"/></c:otherwise>
</c:choose>
<meta property="og:image" content="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${detail.thumUrl}" />
<link rel="image_src" href="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${detail.thumUrl}" />
<script type="text/javascript" src="/js/jquery.form.js"></script>
<style type="text/css">
.timetable { margin:-40px 0 -11px;overflow:hidden; width :950px;}
.timetable .timetable_top img { width:100%; }
.timetable .timetable_bottom img { width:100%; }
.timetable .checkTable{width : 100%; text-align: center;}
.timetable .checkTable div {text-align: center;}
.timetable .checkTable div div { display:inline-block; height: auto;}
.timetable .checkTable div div a img { width:100%; }
</style> 

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

<script type="text/javascript">
isLogin = ${isLogin};
jQuery(function($){
    if('${skip}' == 'skipEvent'){
        $(".ly_box_skip").addClass("active");
    }
    
    $("area").attr("onfocus","this.blur();");
});
function successProc(step){
    if (!isLogin) {
        needLogin();
    }else{
        $.ajax({
            type: 'POST'
            ,url: '/ht/event/saveEventAttendStep'
            ,data: {eventId:"${detail.eventId}", step : step}
            ,dataType: 'json'
            ,async: false
            ,success: function(data) {
                alert(data.alert);
                if (data.save) {
                    location.reload(true);
                }
            }
            ,error: function(data) {
                alert('이벤트 진행 중 오류가 발생하였습니다. 잠시 후 다시 이용해주세요');
            }
        });
    }
}

</script>
</head>
<body>
<c:if test="${detail.eventDispScrnCode eq 'C0201' || detail.cultZoneYn eq 'Y'}"><c:set var="isFull" value="N"/></c:if>
<c:if test="${detail.eventDispScrnCode ne 'C0201' && detail.cultZoneYn ne 'Y'}"><c:set var="isFull" value="Y"/></c:if>
<div class="event_wrap ${isFull ne 'Y'?'w755':'w950'}">
    <c:if test="${isFull ne 'Y'}">
        <c:if test="${detail.cultZoneYn eq 'Y'}"><div style="border: 5px solid #f5f5f1;float:left;padding: 45px 0 50px;text-align: center;width: 170px;margin-right:15px;"><a href="/ht/culture/main"><img src="${imageServer}/images/renewal/common/tit_culture_zone02.gif" alt="CULTURE ZONE"/></a></div></c:if>
        <c:if test="${detail.cultZoneYn ne 'Y' && not empty detail.brandId}"><div class="brand_name"><a href="/ht/hot/brandDetail?brandId=${detail.brandId}"><ui:image src="${detail.brandImageUrl}" server="brand" width="170" height="170" alt="${detail.brandName}"/></a></div></c:if>
        <c:if test="${detail.cultZoneYn ne 'Y' && empty detail.brandId}"><div class="brand_name"><a style="cursor: default;" href="javascript://"><ui:image src="${detail.brandImageUrl}" server="brand" width="170" height="170"/></a></div></c:if>
    </c:if>
    <div class="ly_box_skip">
        <p>종료된 이벤트 입니다.</p>
    </div>
    <div class="event_info">
        <c:if test="${detail.eventDispTypeCode ne 'C0219'}">
            <div class="h_section">
                <c:if test="${empty listDiary}">
                    <div class="c_select">
                        <strong class="c_txt">전체</strong>
                        <ul>
                            <li><a href="">전체</a></li>
                            <c:forEach items="${listCtgr}" var="l">
                                <li class="item${l.cateId}"><a href=".list${l.cateId}">${l.cateName}</a></li>
                            </c:forEach>
                        </ul>
                    </div>
                    <div class="e_select">
                        <strong class="e_txt"><a href="/ht/biz/eventDetail?eventId=${detail.eventId}">${detail.eventTitle}</a></strong>
                        <ul>
                            <li><a href="/ht/welcome/hotEventMain?eventDispTypeCode=${detail.eventDispTypeCode}"><ui:code codeId="${detail.eventDispTypeCode}"/> 전체보기</a></li>
                            <c:forEach items="${listEvent}" var="l">
                                <li class="list${l.ctgrId}" title="${l.eventTitle}"><a href="/ht/biz/eventDetail?eventId=${l.eventId}">${l.eventTitle}</a></li>
                            </c:forEach>
                        </ul>
                    </div>
                    <span class="e_select_btn"><a href="javascript://" onclick="goEvent()">GO</a></span>
                </c:if>
                <div class="sns">
                    <a href="javascript://" onclick="goTwitter('${detail.eventTitle}', '${defaultHost}/ht/biz/eventDetail?eventId=${detail.eventId}')"><img src="${imageServer}/images/renewal/common/ico_sns_twitter.png" alt="twitter"/></a>
                    <a href="javascript://" onclick="goFaceBook('${detail.eventTitle}', '${defaultHost}/ht/biz/eventDetail?eventId=${detail.eventId}')"><img src="${imageServer}/images/renewal/common/ico_sns_facebook.png" alt="facebook"/></a>
                    <a href="javascript://" onclick="goPinterest('${detail.eventTitle}', '${defaultHost}/ht/biz/eventDetail?eventId=${detail.eventId}')"><img src="${imageServer}/images/renewal/common/ico_sns_pinterest.png" alt="pinterest" style="width:28px;height:28px;" nopin="true"/></a>
                </div>
                <span class="date">
                    <c:choose>
                        <c:when test="${not empty detail.eventRangeInfo}">${detail.eventRangeInfo}</c:when>
                        <c:otherwise><ui:mask pattern="####.##.##">${detail.eventStartDt}</ui:mask> ~ <ui:mask pattern="####.##.##">${detail.eventEndDt}</ui:mask></c:otherwise>
                    </c:choose>
                </span>
            </div>
        </c:if>
        <c:forEach items="${imageList }" var="dImg">
            <c:if test="${dImg.eventImageCode eq 'C038C'}">
                <c:set var="headerImg">${ dImg.imageUrl}</c:set>
            </c:if>
            <c:if test="${dImg.eventImageCode eq 'C038D'}">
                <c:set var="footerImg">${ dImg.imageUrl}</c:set>
            </c:if>
            <c:if test="${dImg.eventImageCode eq 'C038E' }">
                <c:set var="topImg">${ dImg.imageUrl}</c:set>
            </c:if>
        </c:forEach>
        <div class="event_wrap">
            <div class="event_info">
            <c:if test="${not empty detail.imageUrl950 }">
                        <c:choose>
                            <c:when test="${fn:startsWith(detail.ctgrId, '00002000')}">
                                <div> <!-- 이벤트 튼 배경화면 -->
                                    <script type="text/javascript">
                                    $("#container").css("background", "url('http://image.kyobobook.co.kr/newimages/giftshop_new/work/${detail.imageUrl950}') no-repeat 50% 587px");
                                    </script>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div> <!-- 이벤트 튼 배경화면 -->
                                    <script type="text/javascript">
                                    $("#container").css("background", "url('http://image.kyobobook.co.kr/newimages/giftshop_new/work/${detail.imageUrl950}') no-repeat 50% 80px");
                                    </script>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </c:if>
                <div class="timetable">
                    <div class="timetable_header">
                        <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${headerImg}" />
                    </div>
                    <c:if test="${detail.userTmplUseYn eq 'Y'}"><div>${detail.userTmpl}</div></c:if>
                    <div class="timetable_top">
                        <c:if test="${ history[0].nextStep eq 0 }">
                            <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${topImg}" usemap="#eventImageMap"/>
                        </c:if>
                        <c:if test="${history[0].nextStep > 0}" >
                            <c:forEach items="${history}" begin="${ history[0].nextStep-1}" end="${history[0].nextStep-1}" var="h">
                                <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${h.topImage}" usemap="#eventImageMap"/>
                            </c:forEach>
                        </c:if>
                    </div>
                    <div class="checkTable">
                        <c:forEach items="${history}" varStatus="s1" step="5">
                            <div>
                                <c:forEach items="${history}" var="l" varStatus="st" begin="${s1.index}" end="${s1.index +4}">
                                    <div id="${st.index+1}" >
                                        <c:choose>
                                            <c:when test="${isLogin eq true && history[0].maxDay eq 'N'}">
                                                <a href="javascript://" onclick="successProc('${l.step}');return false;">
                                                    <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${l.setImage }" alt="${l.step} 단계"/>
                                                </a>
                                            </c:when>
                                            <c:when test="${isLogin eq true && history[0].maxDay eq 'Y'}">
                                                <a href="javascript://" onclick="alert('오늘 이미 참여하셨습니다.');">
                                                    <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${l.setImage }" alt="${l.step} 단계"/>
                                                </a>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="javascript://" onclick="successProc('${l.step}');return false;">
                                                    <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${l.setImage }" alt="${l.step} 단계"/>
                                                </a>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:forEach>
                    </div>
                    <div class="timetable_bottom">
                        <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${ footerImg}" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>