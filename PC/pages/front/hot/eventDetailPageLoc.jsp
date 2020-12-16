<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<div class="page-location">
    <p>현재 페이지 위치</p>
    <ul>
        <c:if test="${fn:startsWith(eventDetail.categoryId, '0000')}">
            <li>디자인  <span>&gt;</span></li>
        </c:if>
        <c:if test="${fn:startsWith(eventDetail.categoryId, '0001')}">
            <li><a href="/ht/officeMain">오피스</a> <span>&gt;</span></li>
        </c:if>
        <c:if test="${fn:startsWith(eventDetail.categoryId, '0003')}">
            <li><a href="/ht/recordMain">CD</a> <span>&gt;</span></li>
        </c:if>
        <c:if test="${fn:startsWith(eventDetail.categoryId, '0004')}">
            <li><a href="/ht/dvdMain">BLU-RAY/DVD</a> <span>&gt;</span></li>
        </c:if>
        <li><a href="/ht/welcome/hotEventMain?categoryId=${fn:substring(eventDetail.categoryId, 0, 4)}">HOT이벤트</a> <span>&gt;</span></li>
        <li><strong>${eventDetail.title}</strong></li>
    </ul>
</div><!-- end page-location -->