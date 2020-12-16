<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:if test="${pageInfo.totalPage > 0}">
    <a title="맨 처음 페이지로 이동" href="javascript:${pageInfo.scriptName}('1', '${pageInfo.paramString}')" class="first">처음</a>
    <c:if test="${pageInfo.startPage > 1}">
        <a title="${pageInfo.previousScalePage}페이지로 이동" href="javascript:${pageInfo.scriptName}('${pageInfo.previousScalePage}', '${pageInfo.paramString}')" class="prev02">이전</a>
    </c:if>
    <ul>
        <c:forEach items="${pageInfo.pages}" var="page" varStatus="status">
            <c:if test="${pageInfo.currentPage != page}">
                <li><a title="${page}페이지로 이동" href="javascript:${pageInfo.scriptName}('${page}', '${pageInfo.paramString}')" class="number">${page}</a></li>
            </c:if>
            <c:if test="${pageInfo.currentPage == page}">
                <li class="active"><a href="javascript://">${page}</a></li>
            </c:if>
        </c:forEach>
    </ul>
    <c:if test="${pageInfo.nextScalePage <= pageInfo.totalPage}">
        <a href="javascript:${pageInfo.scriptName}('${pageInfo.nextScalePage}', '${pageInfo.paramString}')" class="next02">다음</a>
    </c:if>
</c:if>