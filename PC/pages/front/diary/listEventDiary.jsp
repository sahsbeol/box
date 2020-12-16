<%@ page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="diary"/>
<html>
<head>
<title>다이어리 이벤트 - NEW ME HOTTRACKS</title>
</head>
<body>
<div class="welcom_top">
    <h2 class="title"><img src="${imageServer}/images/renewal/common/tit_hot_event.gif" alt="HOT EVENT" /></h2>
</div>
<div class="welcom_conts" style="background-image: url('http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/diary/2018/line.jpg'); padding-top: 30px;">
    <div class="event_list">
        <ul class="list">
            <c:forEach items="${listEvent}" var="l" varStatus="st">
                <li>
                    <a href="/ht/biz/eventDetail?eventId=${l.eventId}">
                        <span class="img"><ui:image src="${l.imageUrl}" alt="${l.eventTitle}" /></span>
                        <span class="tit">
                            <strong class="txt_line1">${l.eventTitle}</strong>
                            <em class="txt_line1">${l.eventDtlCont}</em>
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
            <ui:pagination url="/ht/diary/listEventDiary" name="pageHolder" parameters=""/>
        </div>
        <!-- //paging -->
    </div>
</div>
</body>
</html>