<%@ page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<%@ include file="/pages/decorators/biz/tagHeader.jsp" %>
<ui:decorator name="none"/>

<c:choose>
	<c:when test="${type eq 'liveOn' or type eq 'best'}">
		<c:forEach items="${list}" var="l" varStatus="st">
			<div class="swiper-slide">
				<a href="javascript:;" onclick="location.href='/p/${l.sellPrdtBcode}';return false;">
					<div class="thum">
						<c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G'}">
							<ui:image src="${l.productImageUrl}" server="product" alt="${fn:escapeXml(l.prdtName)}"/>
						</c:if>
						<c:if test="${l.sellPrdtGbn eq 'R'}">
							<ui:image rcrdCd="${l.rcrdCd}" prdtGbn="R" ratingCode="A" alt="${fn:escapeXml(l.prdtName)}"/>
						</c:if>
						<c:if test="${l.sellPrdtGbn eq 'D'}">
							<ui:image rcrdCd="${l.rcrdCd}" prdtGbn="D" ratingCode="A" alt="${fn:escapeXml(l.prdtName)}"/>
						</c:if>
					</div>
					<p class="tit">${l.prdtName}</p>
					<p class="price font_t">
						<fmt:formatNumber type="number">${l.lastCpnPrice}</fmt:formatNumber>
						<fmt:parseNumber var="rate" type="number" integerOnly="true" value="${hfn:rate(l.prdtSellPrice,l.lastCpnPrice)}"/>
						<c:if test="${rate > 0}">
							<span class="percent">${rate}%</span>
						</c:if>
					</p>
				</a>
			</div>
		</c:forEach>
	</c:when>
	<c:when test="${fn:contains(type, 'pd')}">
		<c:forEach items="${list}" var="l" varStatus="st">
			<li class="MB_MAIN_GIFT_11">
				<a href="javascript:;" onclick="location.href='/m/gift/detail/${l.sellPrdtBcode}';return false;">
					<div class="thum">
						<c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G'}">
							<ui:image src="${l.productImageUrl}" server="product" alt="${fn:escapeXml(l.prdtName)}"/>
						</c:if>
						<c:if test="${l.sellPrdtGbn eq 'R'}">
							<ui:image rcrdCd="${l.rcrdCd}" prdtGbn="R" ratingCode="A" alt="${fn:escapeXml(l.prdtName)}"/>
						</c:if>
						<c:if test="${l.sellPrdtGbn eq 'D'}">
							<ui:image rcrdCd="${l.rcrdCd}" prdtGbn="D" ratingCode="A" alt="${fn:escapeXml(l.prdtName)}"/>
						</c:if>
					</div>
					<p class="tit">${l.prdtName}</p>
					<p class="price font_t">
						<fmt:formatNumber type="number">${l.lastCpnPrice}</fmt:formatNumber>
						<fmt:parseNumber var="rate" type="number" integerOnly="true" value="${hfn:rate(l.prdtSellPrice,l.lastCpnPrice)}"/>
						<c:if test="${rate > 0}">
							<span class="percent">${rate}%</span>
						</c:if>
					</p>
				</a>
			</li>
		</c:forEach>
	</c:when>
</c:choose>