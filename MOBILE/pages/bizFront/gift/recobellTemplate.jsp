<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="none"/>

<c:if test="${not empty list}">
<c:if test="${not empty c.ctgrId}"><c:set var="ctgrLength" value="${fn:length(c.ctgrId)}"/></c:if>
<c:forEach items="${list}" var="l" varStatus="status">
	<c:if test="${l.prdtStatCode eq 'C0312'}">
	<div class="swiper-slide">
		<a href="#" class="MB_SIDE_CATE_1_ITEM" onclick="location.href='/p/${l.sellPrdtBcode}?foo=bar<c:if test="${ctgrLength eq 6}">&rccode=mo_category1</c:if><c:if test="${ctgrLength eq 8}">&rccode=mo_category2</c:if><c:if test="${ctgrLength eq 10}">&rccode=mo_category3</c:if><c:if test="${ctgrLength eq 12}">&rccode=mo_category4</c:if>';return false;" >
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
		</a>
		<!-- 클릭시 active : class 추가 -->
		<!-- 클릭한  상품일 경우 누른 표시 해야함 -->
		<a href="javascript:" onclick="addBizWishProduct(this);return false;" class="btn_like<c:if test="${l.wishUserPrdtCnt > 0}"> active</c:if>" prdtId="${l.sellPrdtBcode}"><span>좋아요</span></a>
		<a href="#" class="MB_SIDE_CATE_1_ITEM" onclick="location.href='/p/${l.sellPrdtBcode}?foo=bar<c:if test="${ctgrLength eq 6}">&rccode=mo_category1</c:if><c:if test="${ctgrLength eq 8}">&rccode=mo_category2</c:if><c:if test="${ctgrLength eq 10}">&rccode=mo_category3</c:if><c:if test="${ctgrLength eq 12}">&rccode=mo_category4</c:if>';return false;">
			<div class="cont">
				<p class="brand">${l.brandEngName}</p>
				<p class="tit">${l.prdtName}</p>
				<p class="price font_t">
					<fmt:parseNumber var="rate" type="number" value="${hfn:rate(l.prdtSellPrice,l.lastCpnPrice)}"/>
					<span class="percent"><c:if test="${rate > 0}"><fmt:parseNumber integerOnly="true" value="${rate}"/>%</c:if></span>
					<span><fmt:formatNumber type="number">${l.lastCpnPrice}</fmt:formatNumber></span>																								
					<c:if test="${rate > 0}"><span class="discount"><fmt:formatNumber type="number">${l.prdtSellPrice}</fmt:formatNumber></span></c:if>
				</p>
			</div>
		</a>
	</div>
	</c:if>
</c:forEach>							
</c:if>

			