<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:if test="${pageInfo.totalPage > 0}">
<%--     <a title="맨 처음 페이지로 이동" href="${pageInfo.url}${pageInfo.separator}${pageInfo.pageParam}=1${pageInfo.paramString}" class="arr prev first"></a> --%> 
	<c:choose>
	  	<c:when test="${pageInfo.startPage > 1}">
			<a title="${pageInfo.previousScalePage}페이지로 이동" href="${pageInfo.url}${pageInfo.separator}${pageInfo.pageParam}=${pageInfo.previousScalePage}${pageInfo.paramString}" class="arr prev"></a>						
		</c:when>
		<c:otherwise>
			<a title="" href="javascript:" class="arr prev first"></a>
		</c:otherwise>
	</c:choose> 
    <c:forEach items="${pageInfo.pages}" var="page" varStatus="status">
        <c:if test="${pageInfo.currentPage != page}">
            <a title="${page}페이지로 이동" href="${pageInfo.url}${pageInfo.separator}${pageInfo.pageParam}=${page}${pageInfo.paramString}">${page}</a>
        </c:if>
        <c:if test="${pageInfo.currentPage == page}">
            <a href="javascript://" class="active">${page}</a>
        </c:if>
    </c:forEach>
	<c:choose>
	  	<c:when test="${pageInfo.nextScalePage <= pageInfo.totalPage}">
			<a title="${pageInfo.nextScalePage}페이지로 이동" href="${pageInfo.url}${pageInfo.separator}${pageInfo.pageParam}=${pageInfo.nextScalePage}${pageInfo.paramString}" class="arr next"></a>						
		</c:when>
		<c:otherwise>
			<a title="" href="javascript:" class="arr next last"></a>
		</c:otherwise>
	</c:choose>    
</c:if>