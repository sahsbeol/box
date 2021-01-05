<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now }" pattern="yyyyMMdd" var="thisYmd"/>
<html>
<head>
<title>${detail.eventTitle} - NEW ME HOTTRACKS</title>
<meta property="fb:app_id" content="981386905311018" />
<meta property="og:type" content="shopping" />
<meta property="og:title" content="HOTTRACKS - ${detail.eventTitle}" />
<meta property="og:url" content="http://m.hottracks.co.kr/e/${detail.eventId}" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=2.0">
<c:choose>
    <c:when test="${not empty detail.eventRangeInfo}"><meta property="og:description" content="${detail.eventRangeInfo}"/></c:when>
    <c:otherwise><meta property="og:description" content="<ui:mask pattern="####.##.##">${detail.eventStartDt}</ui:mask> ~ <ui:mask pattern="####.##.##">${detail.eventEndDt}</ui:mask>"/></c:otherwise>
</c:choose>
<meta property="og:image" content="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${detail.thumUrl}" />
<link rel="image_src" href="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${detail.thumUrl}" />
<script type="text/javascript" src="/js/jquery.rwdImageMaps.min.js?20170727"></script>
<script type="text/javascript" src="/js/jquery.form.js"></script>
<style type="text/css">
.timetable .timetable_top img, .timetable .timetable_header img, .timetable .timetable_bottom img, .timetable .checkTable { width:100%; }
.timetable .checkTable div {text-align: center;}
.timetable .checkTable div div{display: inline-block; width : 30%; }
.timetable .checkTable div div a {display: inline-block;}
.timetable .checkTable div div a img{text-align: center; width : 100%;display: inline-block;}

</style> 
<script type="text/javascript">
isLogin = ${isLogin};
jQuery(function($){
    $(window).load(function(){
        if('${skip}' == 'skipEvent'){
            $(".ly_box_skip").addClass("active");
            $(".ly_box_skip.active").css("height", $(".event_cont").height());
        }
    });
});
function successProc2(index){
    if (!isLogin) {
        needLogin();
    } else{
        $.ajax({
            type: 'POST'
            ,url: '/m/hot/saveEventStepInit'
            ,data: {eventId:"${detail.eventId}", step : index}
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
<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${detail.thumUrl}" class="sns_img" style="display:none;"/>
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
<div class="w_top event_sub_info">
    <c:choose>
        <c:when test="${not empty detail.eventRangeInfo}"><p>${detail.eventRangeInfo}</p></c:when>
        <c:otherwise><p>(<ui:mask pattern="####.##.##">${detail.eventStartDt}</ui:mask> ~ <ui:mask pattern="####.##.##">${detail.eventEndDt}</ui:mask>)</p></c:otherwise>
    </c:choose>
    <div class="sns">
        <a href="javascript:goTwitter('${detail.eventTitle}', 'http://m.hottracks.co.kr/e/${detail.eventId}')" class="ic_twitter">트위터</a>
        <a href="javascript:goFaceBook('${detail.eventTitle}', 'http://m.hottracks.co.kr/e/${detail.eventId}')" class="ic_facebook">페이스북</a>
        <a href="javascript:sendKakao('[핫트랙스] ${detail.eventTitle}', 'http://m.hottracks.co.kr/e/${detail.eventId}')" class="ic_kakaotalk">카카오톡</a>
    </div>
</div>
<div class="event_info">
<!-- <div class="ly_box_skip">
    <p>종료된 이벤트 입니다.</p>
</div> -->
<div class="event_cont">
    <div class="event_info">
    <div class="timetable">
        <div class="timetable_header">
            <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${headerImg}" />
        </div>
        <c:if test="${detail.userTmplUseYn eq 'Y'}"><div>${detail.userTmpl}</div></c:if>
        <div class="timetable_top">
            <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${topImg}" usemap="#eventImageMap"/>
        </div>
        <div class="checkTable">
            <c:forEach items="${history}" varStatus="s1" step="3">
                <div>
                    <c:forEach items="${history}" var="l" varStatus="st" begin="${s1.index}" end="${s1.index +2}">
                    <div id="${st.index+1}">
                         <a href="javascript://" onclick="successProc2('${l.step}');return false;">
                             <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${ranImg[st.index].ranImg }" alt="${st.index+1 } 단계"/>
                         </a>
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
</body>
</html>