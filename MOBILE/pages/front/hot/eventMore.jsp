<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="none"/>
<c:forEach items="${list}" var="l" varStatus="st">
    <li>
        <a href="/m/biz/eventDetail?eventId=${l.eventId}" class="full js-pjax" title="${l.eventTitle}">
            <p class="pic_full"><ui:image src="${l.imageUrl}" alt="${l.eventTitle}" /></p>
            <p class="tit t_l"><strong>${fn:escapeXml(l.eventTitle)}</strong></p>
            <p class="txt t_l">${fn:escapeXml(l.eventDtlCont)}</p>
        </a>
    </li>
</c:forEach>