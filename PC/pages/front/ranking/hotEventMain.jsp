<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
<head>
<title><c:if test="${c.ctgrId ne '0000'}"><ui:category id="${c.ctgrId}" full="false"/> | </c:if>HOT 이벤트 - NEW ME HOTTRACKS</title>
</head>
<body>
<div class="welcom_top">
    <h2 class="title"><img src="${imageServer}/images/renewal/common/tit_hot_event.gif" alt="HOT EVENT" /></h2>
    <ul class="tab_cate01">
        <li<c:if test="${fn:startsWith(c.ctgrId, '0000')}"> class="on"</c:if>><a href="/ht/welcome/hotEventMain?ctgrId=0000"><img src="${imageServer}/images/renewal/common/tab_gift.gif" alt="GIFT" class="PC_TOP_1_1"/></a></li>
        <li<c:if test="${fn:startsWith(c.ctgrId, '0003')}"> class="on"</c:if>><a href="/ht/welcome/hotEventMain?ctgrId=0003"><img src="${imageServer}/images/renewal/common/tab_cd.gif" alt="CD" class="PC_TOP_1_2"/></a></li>
        <li<c:if test="${fn:startsWith(c.ctgrId, '0004')}"> class="on"</c:if>><a href="/ht/welcome/hotEventMain?ctgrId=0004"><img src="${imageServer}/images/renewal/common/tab_dvd.gif" alt="BLU-RAY/DVD" class="PC_TOP_1_3"/></a></li>
    </ul>
</div>
<div class="welcom_conts">
    <c:if test="${fn:startsWith(c.ctgrId, '0000')}"> 
        <ul class="tab_cate02">
            <li<c:if test="${c.ctgrId eq '0000'}"> class="on"</c:if>><a href="/ht/welcome/hotEventMain?ctgrId=0000" class="PC_TOP_1_1">전체</a></li>
            <li<c:if test="${c.ctgrId eq '000020'}"> class="on"</c:if>><a href="/ht/welcome/hotEventMain?ctgrId=000020" class="PC_TOP_1_1_1">디자인문구</a></li>
            <li<c:if test="${c.ctgrId eq '000022'}"> class="on"</c:if>><a href="/ht/welcome/hotEventMain?ctgrId=000022" class="PC_TOP_1_1_2">디지털</a></li>
            <li<c:if test="${c.ctgrId eq '000007'}"> class="on"</c:if>><a href="/ht/welcome/hotEventMain?ctgrId=000007" class="PC_TOP_1_1_3">고급필기구</a></li>
            <li<c:if test="${c.ctgrId eq '000021'}"> class="on"</c:if>><a href="/ht/welcome/hotEventMain?ctgrId=000021" class="PC_TOP_1_1_4">오피스</a></li>
            <li<c:if test="${c.ctgrId eq '000025'}"> class="on"</c:if>><a href="/ht/welcome/hotEventMain?ctgrId=000025" class="PC_TOP_1_1_5">리빙/생활가전</a></li>
            <li<c:if test="${c.ctgrId eq '000026'}"> class="on"</c:if>><a href="/ht/welcome/hotEventMain?ctgrId=000026" class="PC_TOP_1_1_6">키친/푸드</a></li>
            <li<c:if test="${c.ctgrId eq '000024'}"> class="on"</c:if>><a href="/ht/welcome/hotEventMain?ctgrId=000024" class="PC_TOP_1_1_7">가구/수납</a></li>
            <li<c:if test="${c.ctgrId eq '000028'}"> class="on"</c:if>><a href="/ht/welcome/hotEventMain?ctgrId=000028" class="PC_TOP_1_1_8">패션잡화</a></li>
            <li<c:if test="${c.ctgrId eq '000006'}"> class="on"</c:if>><a href="/ht/welcome/hotEventMain?ctgrId=000006" class="PC_TOP_1_1_9">뷰티/헬스</a></li>
            <li<c:if test="${c.ctgrId eq '000027'}"> class="on"</c:if>><a href="/ht/welcome/hotEventMain?ctgrId=000027" class="PC_TOP_1_1_10">여행/자동차</a></li>
            <li<c:if test="${c.ctgrId eq '000023'}"> class="on"</c:if>><a href="/ht/welcome/hotEventMain?ctgrId=000023" class="PC_TOP_1_1_11">취미/펫</a></li>
            <li<c:if test="${c.ctgrId eq '000029'}"> class="on"</c:if>><a href="/ht/welcome/hotEventMain?ctgrId=000029" class="PC_TOP_1_1_12">유아동</a></li>
        </ul>
        <div class="mds_pick">
            <ul class="mds_tab">
                <li><a href="/ht/welcome/hotEventMain?ctgrId=${c.ctgrId}"<c:if test="${empty c.eventDispTypeCode}"> class="on"</c:if>><span>전체 이벤트</span></a></li>
                <li><a href="/ht/welcome/hotEventMain?ctgrId=${c.ctgrId}&eventDispTypeCode=C0211"<c:if test="${c.eventDispTypeCode eq 'C0211'}"> class="on"</c:if>><span>감성충전 이벤트</span></a></li>
                <li><a href="/ht/welcome/hotEventMain?ctgrId=${c.ctgrId}&eventDispTypeCode=C0214"<c:if test="${c.eventDispTypeCode eq 'C0214'}"> class="on"</c:if>><span>할인 이벤트</span></a></li>
                <li><a href="/ht/welcome/hotEventMain?ctgrId=${c.ctgrId}&eventDispTypeCode=C0212"<c:if test="${c.eventDispTypeCode eq 'C0212'}"> class="on"</c:if>><span>사은품 이벤트</span></a></li>
                <li><a href="/ht/welcome/hotEventMain?ctgrId=${c.ctgrId}&eventDispTypeCode=C0213"<c:if test="${c.eventDispTypeCode eq 'C0213'}"> class="on"</c:if>><span>참여 이벤트</span></a></li>
            </ul>
        </div>
    </c:if>
    
    <div class="event_list">
        <ul class="list">
            <c:forEach items="${list}" var="l" varStatus="st">
                <li>
                    <a href="/ht/biz/eventDetail?eventId=${l.eventId}">
                        <span class="img"><ui:image src="${l.imageUrl}" alt="${l.eventTitle}" style="width:100%;"/></span>
                        <span class="tit">
                            <strong class="txt_line1">${l.eventTitle}</strong>
                            <em class="txt_line1" style="width:290px;display:block;">${l.eventDtlCont}</em>
                        </span>
                        <c:choose>
                            <c:when test="${not empty l.eventRangeInfo}"><span class="date">${l.eventRangeInfo}</span></c:when>
                            <c:when test="${l.eventEndDt eq '99991231' || l.eventEndDt eq '99999999'}"><span class="date"><ui:mask pattern="####.##.##">${l.eventStartDt}</ui:mask> ~ </span></c:when>
                            <c:otherwise><span class="date"><ui:mask pattern="####.##.##">${l.eventStartDt}</ui:mask> ~ <ui:mask pattern="####.##.##">${l.eventEndDt}</ui:mask></span></c:otherwise>
                        </c:choose>
                    </a>
                </li>
            </c:forEach>
        </ul>
        <!-- paging -->
        <div class="paging">
            <ui:pagination url="/ht/welcome/hotEventMain" name="pageHolder" parameters="ctgrId,eventDispTypeCode"/>
        </div>
        <!-- //paging -->
    </div>
</div>
</body>
</html>