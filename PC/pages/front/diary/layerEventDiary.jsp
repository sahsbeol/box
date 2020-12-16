<%@ page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="none"/>
<h2 class="tit mgb20"><strong>DIARY EVENT</strong></h2>
<ul class="list" style="padding-top:23px;">
    <c:forEach items="${listEvent}" var="l" varStatus="st">
        <li style="min-height:250px;">
            <a href="/ht/biz/eventDetail?eventId=${l.eventId}">
                <span class="img"><ui:image src="${l.imageUrl}" alt="${l.eventTitle}" /></span>
                <span class="tit">
                    <strong class="txt_line1">${l.eventTitle}</strong>
                    <em class="txt_line1">${l.eventDtlCont}</em>
                </span>
                <span class="date">
                    <em class="txt_line1"><ui:mask pattern="####.##.##">${l.eventStartDt }</ui:mask> ~ <ui:mask pattern="####.##.##">${l.eventEndDt }</ui:mask></em>
                </span>
            </a>
        </li>
    </c:forEach>
</ul>
<!-- paging -->
<div class="paging"><ui:paginationScript name="pageHolder" scriptName="goPage"/></div>
<!-- //paging -->