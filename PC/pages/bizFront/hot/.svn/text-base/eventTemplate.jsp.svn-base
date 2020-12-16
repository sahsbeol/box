<%@ page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<%@ include file="/pages/decorators/biz/tagHeader.jsp" %>
<ui:decorator name="none"/>
<c:choose>
	<c:when test="${type eq 'type01'}">
		<c:forEach items="${list}" var="l" varStatus="st">
			<li <c:if test="${listCount ne null && st.index eq '0'}">listCount="${listCount}"</c:if>>
				<a href="/m/biz/hot/eventDetail?eventId=${l.eventId}">
					<div class="img_wrap">
						<ui:image src="${l.imageUrl}" alt="${l.eventTitle}" />
					</div>
					<span class="font_t percent">10%(할인율 넣는곳)</span>
					<strong>${fn:escapeXml(l.eventTitle)}</strong>
					<p>${fn:escapeXml(l.eventDtlCont)}</p>
					<span class="date font_t"><ui:mask pattern="####.##.##">${l.eventStartDt}</ui:mask> ~ <ui:mask pattern="####.##.##">${l.eventEndDt}</ui:mask></span>
				</a>
			</li>
		</c:forEach>
	</c:when>
	<c:when test="${type eq 'type02'}">
		<c:forEach items="${list}" var="l" varStatus="st">
			<li <c:if test="${listCount ne null && st.index eq '0'}">listCount="${listCount}"</c:if>>
				<a href="/m/biz/hot/eventDetail?eventId=${l.eventId}">
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