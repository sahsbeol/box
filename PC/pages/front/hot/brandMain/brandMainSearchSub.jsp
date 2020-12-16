<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="none"/>
<ul>
    <c:if test="${empty brandNameList}">
        <li style="text-align:center;font-weight:bold;color:#ff6600;">조건에 맞는 브랜드가 없습니다.</li>
    </c:if>
    <c:forEach items="${brandNameList}" var="brand">
        <li>
            <c:set var="brandName"><c:out value="${brand.koreanName}"  escapeXml="ture"/></c:set>
            <c:if test="${isEnglish}"><c:set var="brandName"><c:out value="${brand.englishName}" escapeXml="ture"/></c:set></c:if>
            <c:set var="match"><strong>${c.searchStr}</strong></c:set>
            <a href="/ht/hot/brandDetail?brandId=${brand.id}">${fn:replace(brandName, c.searchStr, match)}</a>
        </li>
    </c:forEach>
</ul>
