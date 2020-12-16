<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<c:set value="${fn:length(listEvent)}" var="listCnt"/>
<c:set value="${fn:length(listEventChoice)}" var="listChoiceCnt"/>
<input id="listCnt" type="hidden" value="${listCnt}"></input>
<input id="listChoiceCnt" type="hidden" value="${listChoiceCnt}"></input>
<c:if test="${(listCnt+listChoiceCnt)!=1}">
	<div class="swiper-container">
		<div class="swiper-wrapper">
		<c:forEach items="${listEvent}" varStatus="s1" step="3">
			<c:forEach items="${listEvent}" var="l" varStatus="st" begin="${s1.index}" end="${s1.index + 2}">
			<div class="swiper-slide">
				<a href="/m/biz/eventDetail?eventId=${l.eventId}">
					<c:if test="${not empty listEventChoice}"><span class="badge badge01">관련이벤트</span></c:if>
					<div class="thum">
						<ui:image src="${l.imageUrl}" alt="${fn:escapeXml(l.eventTitle)}"/>
					</div>
					<strong>${l.eventTitle}</strong>
					<p>${l.eventDtlCont} </p>
				</a>
			</div>
                  </c:forEach>
			<c:if test="${s1.first && not empty listEventChoice}">
				<div class="swiper-slide">
                       <c:forEach items="${listEventChoice}" var="l" varStatus="st">
                            <a href="/m/biz/eventDetail?eventId=${l.eventId}">
							<span class="badge badge02">인기이벤트</span>
							<div class="thum">
								<ui:image src="${l.imageUrl}" alt="${fn:escapeXml(l.eventTitle)}"/>
							</div>
							<strong>${l.eventTitle}</strong>
							<p>${l.eventDtlCont} </p>
						</a>
				</c:forEach>
				</div>
			</c:if>
		</c:forEach>
		<c:if test="${empty listEvent}">
			<c:forEach items="${listEventChoice}" var="l" varStatus="st">
			<!--TODO:롤링해야함 -->
			<div class="swiper-slide">
				<a href="/m/biz/eventDetail?eventId=${l.eventId}">
					<span class="badge badge02">인기이벤트</span>
					<div class="thum">
						<ui:image src="${l.imageUrl}" alt="${fn:escapeXml(l.eventTitle)}"/>
					</div>
					<strong>${l.eventTitle}</strong>
					<p>${l.eventDtlCont} </p>
				</a>
			</div>
			</c:forEach>
		</c:if>
		</div>
		<!-- 스크롤바 -->
		<div class="swiper-scrollbar"></div>
		<!-- swiper-pagination -->
		<div class="pagination_wrap">
			<div class="swiper-pagination"></div>
		</div>
	</div>
	</c:if>
	<c:if test="${(listCnt+listChoiceCnt)==1}">
	<div class="event_banner"><!-- 이미지가 1개인 경우 -->
		<ul>
			<li>
			<c:if test="${not empty listEvent}">
			<c:forEach items="${listEvent}" var="l"> 
				<a href="/m/biz/eventDetail?eventId=${l.eventId}">
					<span class="badge badge01">관련이벤트</span>
					<div class="img_wrap">
						<ui:image src="${l.imageUrl}" alt="${fn:escapeXml(l.eventTitle)}"/>
					</div>
					<strong>${l.eventTitle}</strong>
					<p>${l.eventDtlCont} </p>
				</a>
			</c:forEach>
			</c:if>
			<c:if test="${empty listEvent}">
			<c:forEach items="${listEventChoice}" var="l" varStatus="st">
			<!--TODO:롤링해야함 -->
				<a href="/m/biz/eventDetail?eventId=${l.eventId}">
					<span class="badge badge02">인기이벤트</span>
					<div class="img_wrap">
						<ui:image src="${l.imageUrl}" alt="${fn:escapeXml(l.eventTitle)}"/>
					</div>
					<strong>${l.eventTitle}</strong>
					<p>${l.eventDtlCont} </p>
				</a>
			</c:forEach>
			</c:if>
			</li>
		</ul>
	</div>
</c:if>    	
