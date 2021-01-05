<%@ page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<%@ include file="/pages/decorators/biz/tagHeader.jsp" %>
<ui:decorator name="none"/>
<c:choose>
	<c:when test="${codeNum ne 'C1533'}">
		<c:forEach items="${list}" var="l" varStatus="st">
			<li <c:if test="${listCount ne null && st.index eq '0'}">listCount="<fmt:formatNumber type="number">${listCount}</fmt:formatNumber>"</c:if>>
				<a href="/m/biz/eventDetail?eventId=${l.eventId}">
					<div class="img_wrap">
						<ui:image src="${l.imageUrl}" alt="${l.eventTitle}" />
					</div>
					<c:if test="${not empty l.dispDscntRate}">
						<span class="font_t percent">${l.dispDscntRate}%</span>
					</c:if>
					<strong>${fn:escapeXml(l.eventTitle)}</strong>
					<p>${fn:escapeXml(l.eventDtlCont)}</p>
					<span class="date font_t"><ui:mask pattern="####.##.##">${l.eventStartDt}</ui:mask> ~ <ui:mask pattern="####.##.##">${l.eventEndDt}</ui:mask></span>
				</a>
			</li>
		</c:forEach>
	</c:when>
	<c:when test="${codeNum eq 'C1533'}">
		<c:forEach items="${list}" var="l" varStatus="st">
			<li <c:if test="${listCount ne null && st.index eq '0'}">listCount="<fmt:formatNumber type="number">${listCount}</fmt:formatNumber>"</c:if>>
				<a href="/m/biz/eventDetail?eventId=${l.eventId}">
					<div class="img_wrap">
						<ui:image src="${l.imageUrl}" alt="${l.eventTitle}" />
					</div>
					<p>${fn:escapeXml(l.eventTitle)}</p>
					<span class="date font_t"><ui:mask pattern="####.##.##">${l.eventStartDt}</ui:mask> ~ <ui:mask pattern="####.##.##">${l.eventEndDt}</ui:mask></span>
				</a>
			</li>
		</c:forEach>
	</c:when>
</c:choose>
<div id="pagination_v2">	        	   
    <ui:bizpaginationScript name="pageHolder" scriptName="goList"/>
</div>