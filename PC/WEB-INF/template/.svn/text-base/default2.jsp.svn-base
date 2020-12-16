<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:if test="${pageInfo.totalPage > 0}">
    <a class="prevEnd" href="<c:out value="${pageInfo.url}"/><c:out value="${pageInfo.separator}"/><c:out value="${pageInfo.pageParam}"/>=1<c:out value="${pageInfo.paramString}"/>">처음</a>
    <c:if test="${pageInfo.startPage > 1}">
    <a class="pre" href="<c:out value="${pageInfo.url}"/><c:out value="${pageInfo.separator}"/><c:out value="${pageInfo.pageParam}"/>=<c:out value="${pageInfo.previousScalePage}"/><c:out value="${pageInfo.paramString}"/>">이전</a>
    </c:if>
    <c:forEach items="${pageInfo.pages}" var="page" varStatus="status">
        <c:if test="${pageInfo.currentPage != page}">
            <a href="<c:out value="${pageInfo.url}"/><c:out value="${pageInfo.separator}"/><c:out value="${pageInfo.pageParam}"/>=<c:out value="${page}"/><c:out value="${pageInfo.paramString}"/>"><c:out value="${page}"/></a>
        </c:if>
        <c:if test="${pageInfo.currentPage == page}">
            <strong><c:out value="${page}"/></strong>
        </c:if>
    </c:forEach>
    <c:if test="${pageInfo.nextScalePage <= pageInfo.totalPage}">
    <a class='next' href="<c:out value="${pageInfo.url}"/><c:out value="${pageInfo.separator}"/><c:out value="${pageInfo.pageParam}"/>=<c:out value="${pageInfo.nextScalePage}"/><c:out value="${pageInfo.paramString}"/>">다음</a>
    </c:if>
</c:if>