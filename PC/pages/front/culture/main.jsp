<%@ page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<html>
<head>
<title>컬처존메인 - HOTTRACKS</title>
<script type="text/javascript" src="/js/owl.carousel.min.js"></script>
<script>
    $(document).ready(function() {
      $("#record_carousel").owlCarousel({
          navigation : true,
          slideSpeed : 0,
          paginationSpeed : 0,
          singleItem : true,
          rewindSpeed :  0
      });
    });
</script>
</head>
<body>
<!-- culture zone -->
<div class="brand_in_banner tab_wrap">
    <h2 class="tit"><img src="${imageServer}/images/renewal/common/tit_culture_zone.gif" alt="CULTURE ZONE" /></h2>
    <p class="tit_comt">댓글만 달아도 공연티켓의 행운이 기다립니다.</p>
    <ul class="prod_tab tab_btn">
        <c:forEach items="${mainBigList}" var="l" varStatus="st">
            <li><a href="#hbi0${st.count}"<c:if test="${st.first}">class="on"</c:if>><span>${l.bnrTitle}</span></a></li>
        </c:forEach>
    </ul>
    <div class="brand_in_list_wrap tp2 tab_pannels">
        <div class="brand_in_list" style="display:block;">
            <c:forEach items="${mainBigList}" var="l" varStatus="st">
                <div id="hbi0${st.count}" class="pdb10 pannel" style="display:${st.first?'block':'none'};">
                    <a href="${l.bnrLnkUrl}"<c:if test="${l.bnrNewWinYn eq 'Y'}"> target="_blank"</c:if>><ui:image src="${l.bnrImgUrl}" alt="${l.bnrImgAlt}" width="950" height="370"/></a>
                </div>
            </c:forEach>
            <div class="brand_notice">
                <strong>NOTICE</strong>
                <ul>
                    <c:if test="${empty winnerList}"><li>당첨자 발표 내용이 없습니다</li></c:if>
                    <c:forEach items="${winnerList}" var="l" varStatus="s" end="3">
                        <li><a href="/ht/help/eventPrizeList?eventId=${l.eventId}" title="${l.eventTitle}"><ui:cut isStripHtml="true" limit="15" tail="...">${l.eventTitle}</ui:cut></a></li>
                    </c:forEach>
                </ul>
                <a href="/ht/help/eventPrizeList" class="more"><img src="${imageServer}/images/renewal/common/btn_brand_notice_more.gif" alt="전체보기"></a>
            </div>

            <div class="event_list mgt40">
                <c:forEach items="${eventList}" varStatus="s1" step="3">
                    <ul class="list">
                        <c:forEach items="${eventList}" var="l" varStatus="st" begin="${s1.index}" end="${s1.index+2}">
                            <li style="min-height:200px;">
                                <a href="/ht/biz/eventDetail?eventId=${l.eventId}">
                                    <span class="img"><ui:image src="${l.thumImageUrl}" width="290px" height="140px" alt="${l.eventTitle}"/></span>
                                    <span class="tit">
                                        <strong>${l.eventTitle}</strong>
                                        <em>
                                            <c:if test="${empty l.eventRangeInfo}"><ui:mask pattern="####.##.##">${l.eventStartDt}</ui:mask> ~ <ui:mask pattern="####.##.##">${l.eventEndDt}</ui:mask></c:if>
                                            <c:if test="${not empty l.eventRangeInfo}">${l.eventRangeInfo}</c:if>
                                        </em>
                                    </span>
                                </a>
                            </li>
                        </c:forEach>
                    </ul>
                </c:forEach>
            </div>
        </div>
    </div>
</div>
<!-- //culture zone -->
</body>
</html>