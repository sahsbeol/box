<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<html>
<head>
<style type="text/css">
.option_box_white {background: white; padding: 10px 0 0; margin: 0;}
.option_box_white p { display: flex; }
.option_box_white p span a { border: 1px solid #ddd; border-radius: 5px; text-align: center; height: 34px; display: block; margin: 2px; line-height: 34px;}
.option_box_white p span a.active {border: 1px solid #fe5f01; background : #fe5f01; color: #fff;}
</style>
<script type="text/javascript">
jQuery(function($){
    $("#wrap").removeClass("mini");
    $("#locEvent").addClass("active");
    
    // 메인배너
    var welcomeSwiper = new Swiper('.swipe-main .swiper-container',{
        pagination: '.swipe-main div.pagination',
        loop:true,
        grabCursor: true,
        paginationClickable: true
    });
    
    $(window).scroll(function(){
        if ($(window).scrollTop() >= $(document).height() - $(window).height() - 100){
            loadEvent();
        }
    });
    
    if ($.support.pjax) {
        $(document).on("click", "a", function(event) {
            var container = $("#pjax-container");
            $.pjax.click(event, {container: container});
        });
    }
});

var page = 2;
function loadEvent(){
    if(_isEmpty(page))    page = 2;
    if($("[name=eof]").val() == "0"){
        $("#loading").show();
        $("input[name=eof]").val("1");
        $.ajax({
            type: "GET"
           ,async:false
           ,url: "/m/hot/eventMore?orderBy=${c.orderBy}&ctgrId=${c.ctgrId}&eventDispTypeCode=${c.eventDispTypeCode}&page="+page
           ,dataType: "html"
           ,success : function(htmlStr){
               $("#eventList").append(htmlStr);
               $("#loading").hide();
               if($.trim(htmlStr) != ""){
                   page++;
                   $("input[name=eof]").val("0");
               }
           }
           ,error: function(data) {
               alert('<fmt:message key="error.common.system"/>');
               $("#loading").hide();
           }
       });
    }
}
</script>
</head>
<body>
<c:if test="${not empty evtBnrList}">
<div class="event_wrap">
<!-- swiper -->
<div class="visual swipe-main">
    <div class="swiper-container">
        <ul class="swiper-wrapper">
            <c:forEach items="${evtBnrList}" var="l" varStatus="st" end="4">
                <li class="swiper-slide">
                    <a href="/m/biz/eventDetail?eventId=${l.eventId}" class="full" title="${l.eventTitle}">
                        <p class="pic_full"><ui:image src="${l.imageUrl}" alt="${l.eventTitle}" /></p>
                        <p class="tit t_l"><strong>${fn:escapeXml(l.eventTitle)}</strong></p>
                        <p class="txt t_l">${fn:escapeXml(l.eventDtlCont)}</p>
                    </a>
                </li>
            </c:forEach>
        </ul>
    </div>
    <div class="pagination"></div>
</div>
<!-- //swiper -->
</div>
</c:if>
<input type="hidden" name="eof" value="0"/>
<!-- 정렬 -->
<div class="option_box t_select">
    <div class="select_box">
        <c:if test="${c.ctgrId eq '0000'}"><p>전체 카테고리</c:if>
        <c:if test="${c.ctgrId eq '000020'}"><p>디자인문구</c:if>
        <c:if test="${c.ctgrId eq '000007'}"><p>고급필기구</c:if>
        <c:if test="${c.ctgrId eq '000021'}"><p>오피스</c:if>
        <%-- <c:if test="${c.ctgrId eq '000018'}"><p>화방</c:if> --%>
        <c:if test="${c.ctgrId eq '000022'}"><p>디지털</c:if>
        <c:if test="${c.ctgrId eq '000023'}"><p>취미/펫</c:if>
        <c:if test="${c.ctgrId eq '000024'}"><p>가구/수납</c:if>
        <c:if test="${c.ctgrId eq '000025'}"><p>리빙/생활가전</c:if>
        <c:if test="${c.ctgrId eq '000026'}"><p>키친/푸드</c:if>
        <c:if test="${c.ctgrId eq '000027'}"><p>여행/자동차</c:if>
        <c:if test="${c.ctgrId eq '000028'}"><p>패션잡화</c:if>
        <c:if test="${c.ctgrId eq '000006'}"><p>뷰티/헬스</c:if>
        <c:if test="${c.ctgrId eq '000029'}"><p>유아동</c:if>
        <c:if test="${c.ctgrId eq '0003'}"><p>CD</c:if>
        <c:if test="${c.ctgrId eq '0004'}"><p>DVD/BD</c:if>
        <div class="option_box twice">
            <dl>
                <dd>
                    <a href="/m/hot/eventMain?orderBy=${c.orderBy}&ctgrId=0000&eventDispTypeCode=${c.eventDispTypeCode}"<c:if test="${c.ctgrId eq '0000'}"> class="active"</c:if>>전체 카테고리</a>
                    <a href="/m/hot/eventMain?orderBy=${c.orderBy}&ctgrId=000020&eventDispTypeCode=${c.eventDispTypeCode}"<c:if test="${c.ctgrId eq '000020'}"> class="active"</c:if>>디자인문구</a>
                </dd>
                <dd>
                    <a href="/m/hot/eventMain?orderBy=${c.orderBy}&ctgrId=000022&eventDispTypeCode=${c.eventDispTypeCode}"<c:if test="${c.ctgrId eq '000022'}"> class="active"</c:if>>디지털</a>
                    <a href="/m/hot/eventMain?orderBy=${c.orderBy}&ctgrId=000007&eventDispTypeCode=${c.eventDispTypeCode}"<c:if test="${c.ctgrId eq '000007'}"> class="active"</c:if>>고급필기구</a>
                </dd>
                <dd>
                    <a href="/m/hot/eventMain?orderBy=${c.orderBy}&ctgrId=000021&eventDispTypeCode=${c.eventDispTypeCode}"<c:if test="${c.ctgrId eq '000021'}"> class="active"</c:if>>오피스</a>
                    <a href="/m/hot/eventMain?orderBy=${c.orderBy}&ctgrId=000025&eventDispTypeCode=${c.eventDispTypeCode}"<c:if test="${c.ctgrId eq '000025'}"> class="active"</c:if>>리빙/생활가전</a>
                </dd>
                <dd>
                    <a href="/m/hot/eventMain?orderBy=${c.orderBy}&ctgrId=000026&eventDispTypeCode=${c.eventDispTypeCode}"<c:if test="${c.ctgrId eq '000026'}"> class="active"</c:if>>키친/푸드</a>
                    <a href="/m/hot/eventMain?orderBy=${c.orderBy}&ctgrId=000024&eventDispTypeCode=${c.eventDispTypeCode}"<c:if test="${c.ctgrId eq '000024'}"> class="active"</c:if>>가구/수납</a>
                </dd>
                <dd>
                    <a href="/m/hot/eventMain?orderBy=${c.orderBy}&ctgrId=000028&eventDispTypeCode=${c.eventDispTypeCode}"<c:if test="${c.ctgrId eq '000028'}"> class="active"</c:if>>패션잡화</a>
                    <a href="/m/hot/eventMain?orderBy=${c.orderBy}&ctgrId=000006&eventDispTypeCode=${c.eventDispTypeCode}"<c:if test="${c.ctgrId eq '000006'}"> class="active"</c:if>>뷰티/헬스</a>
                </dd>
                <dd>
                    <a href="/m/hot/eventMain?orderBy=${c.orderBy}&ctgrId=000027&eventDispTypeCode=${c.eventDispTypeCode}"<c:if test="${c.ctgrId eq '000027'}"> class="active"</c:if>>여행/자동차</a>
                    <a href="/m/hot/eventMain?orderBy=${c.orderBy}&ctgrId=000023&eventDispTypeCode=${c.eventDispTypeCode}"<c:if test="${c.ctgrId eq '000023'}"> class="active"</c:if>>취미/펫</a>
                </dd>
                <dd>
                    <a href="/m/hot/eventMain?orderBy=${c.orderBy}&ctgrId=000029&eventDispTypeCode=${c.eventDispTypeCode}"<c:if test="${c.ctgrId eq '000029'}"> class="active"</c:if>>유아동</a>
                    <a href="/m/hot/eventMain?orderBy=${c.orderBy}&ctgrId=0003&eventDispTypeCode=${c.eventDispTypeCode}"<c:if test="${c.ctgrId eq '0003'}"> class="active"</c:if>>CD</a>
                </dd>
                <dd>
                    <a href="/m/hot/eventMain?orderBy=${c.orderBy}&ctgrId=0004&eventDispTypeCode=${c.eventDispTypeCode}"<c:if test="${c.ctgrId eq '0004'}"> class="active"</c:if>>DVD/BD</a>
                </dd>
            </dl>
        </div>
    </div>
    <div class="select_box">
        <p>
            <c:choose>
                <c:when test ="${ empty c.orderBy}">신규 기획전</c:when>
                <c:otherwise>
                    <c:if test="${c.orderBy eq 'P' }">인기 기획전</c:if>
                    <c:if test="${c.orderBy eq 'N' }">신규 기획전</c:if>
                    <c:if test="${c.orderBy eq 'O' }">마감 임박순</c:if>
                </c:otherwise>
            </c:choose>
        <div class="option_box">
            <dl>
                <dd><a href="/m/hot/eventMain?orderBy=P&ctgrId=${c.ctgrId}&eventDispTypeCode=${c.eventDispTypeCode}"<c:if test="${c.orderBy eq 'P'}"> class="active"</c:if>>인기 기획전</a></dd>
                <dd><a href="/m/hot/eventMain?orderBy=N&ctgrId=${c.ctgrId}&eventDispTypeCode=${c.eventDispTypeCode}"<c:if test="${c.orderBy eq 'N' || empty c.orderBy}"> class="active"</c:if>>신규 기획전</a></dd>
                <dd><a href="/m/hot/eventMain?orderBy=O&ctgrId=${c.ctgrId}&eventDispTypeCode=${c.eventDispTypeCode}"<c:if test="${c.orderBy eq 'O'}"> class="active"</c:if>>마감 임박순</a></dd>
            </dl>
        </div>
    </div>
</div>
<div class="option_box_white">
    <p><span style="flex-grow: 2;"><a href="/m/hot/eventMain?orderBy=${c.orderBy}&ctgrId=${c.ctgrId }" <c:if test="${empty c.eventDispTypeCode}"> class="active"</c:if>>전체</a></span>
       <span style="flex-grow: 5;"><a href="/m/hot/eventMain?orderBy=${c.orderBy}&ctgrId=${c.ctgrId }&eventDispTypeCode=C0213" <c:if test="${c.eventDispTypeCode eq 'C0213'}"> class="active"</c:if>>참여 이벤트</a></span>
    </p>
    <p><span style="flex-grow: 3;"><a href="/m/hot/eventMain?orderBy=${c.orderBy}&ctgrId=${c.ctgrId }&eventDispTypeCode=C0214" <c:if test="${c.eventDispTypeCode eq 'C0214'}"> class="active"</c:if>>할인</a></span>
       <span style="flex-grow: 3;"><a href="/m/hot/eventMain?orderBy=${c.orderBy}&ctgrId=${c.ctgrId }&eventDispTypeCode=C0211" <c:if test="${c.eventDispTypeCode eq 'C0211'}"> class="active"</c:if>>감성충전</a></span>
       <span style="flex-grow: 3;"><a href="/m/hot/eventMain?orderBy=${c.orderBy}&ctgrId=${c.ctgrId }&eventDispTypeCode=C0212" <c:if test="${c.eventDispTypeCode eq 'C0212'}"> class="active"</c:if>>사은품</a></span>
    </p>
</div>
<!-- //정렬 -->

<!-- prod -->
<div class="banner_basic02" id="pjax-container">
    <ul id="eventList">
        <c:forEach items="${list}" var="l" varStatus="st">
            <li>
                <a href="/m/biz/eventDetail?eventId=${l.eventId}" class="full js-pjax" title="${l.eventTitle}">
                    <p class="pic_full"><ui:image src="${l.imageUrl}" alt="${l.eventTitle}" /></p>
                    <p class="tit t_l"><strong>${fn:escapeXml(l.eventTitle)}</strong></p>
                    <p class="txt t_l">${fn:escapeXml(l.eventDtlCont)}</p>
                </a>
            </li>
        </c:forEach>
    </ul>
<!--     <div class="btn_area box_flex mt30"><a class="btn btn_orange" href="javascript:loadEvent();"><span class="more">이벤트 더보기</span></a></div> -->
</div>
<!-- //prod -->
</body>
</html>