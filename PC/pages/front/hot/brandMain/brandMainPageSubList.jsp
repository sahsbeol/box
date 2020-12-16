<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="none"/>
<c:if test="${not empty c.koreanCode}"><div class="alpha"><ui:code codeId="${c.koreanCode}"/></div></c:if>
<c:if test="${not empty c.englishCode}"><div class="alpha"><ui:code codeId="${c.englishCode}"/></div></c:if>
<div class="list">
    <c:forEach items="${brandNameList}" varStatus="s1" step="10">
        <ul>
            <c:forEach items="${brandNameList}" var="l" varStatus="st" begin="${s1.index}" end="${s1.index+9}">
                <li class="txt_line1 mgr5">
                    <c:if test="${not empty c.koreanCode}"><c:set var="brandName" value="${l.koreanName}"/></c:if>
                    <c:if test="${not empty c.englishCode}"><c:set var="brandName" value="${l.englishName}"/></c:if>
                    <a href="/ht/hot/brandDetail?brandId=${l.id}" title="${brandName}" class="txt_line1">${brandName}</a>
                </li>
            </c:forEach>
        </ul>
    </c:forEach>
</div>