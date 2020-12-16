<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="none"/>
<c:if test="${not empty list}">
	<c:forEach items="${list}" var="l" varStatus="status">
		<c:if test="${l.prdtStatCode eq 'C0312'}">
		<li class="<c:if test="${status.count%2 eq 0}">round </c:if><c:if test="${l.prdtStatCode ne 'C0312'}">sold_out</c:if>">	  
			<c:if test="${l.sellPrdtGbn eq 'R' || l.sellPrdtGbn eq 'D'}"><a title="${l.prdtName}" href="/ht/record/detail/${l.sellPrdtBcode}<c:if test="${reqParam eq 'recobell'}">?foo=bar<c:if test="${fn:length(c.ctgrId) eq 6}">&rccode=pc_category1</c:if><c:if test="${fn:length(c.ctgrId) eq 8}">&rccode=pc_category2</c:if><c:if test="${fn:length(c.ctgrId) eq 10}">&rccode=pc_category3</c:if><c:if test="${fn:length(c.ctgrId) eq 12}">&rccode=pc_category4</c:if></c:if>"></c:if>
			<c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G' || l.sellPrdtGbn eq 'S'}"><a title="${l.prdtName}" href="/ht/product/detail?barcode=${l.sellPrdtBcode}<c:if test="${reqParam eq 'recobell'}">&foo=bar<c:if test="${fn:length(c.ctgrId) eq 6}">&rccode=pc_category1</c:if><c:if test="${fn:length(c.ctgrId) eq 8}">&rccode=pc_category2</c:if><c:if test="${fn:length(c.ctgrId) eq 10}">&rccode=pc_category3</c:if><c:if test="${fn:length(c.ctgrId) eq 12}">&rccode=pc_category4</c:if></c:if>"></c:if>	
				<div class="thum">
					<c:if test="${l.sellPrdtGbn eq 'R' || l.sellPrdtGbn eq 'D'}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" ratingCode="A" rcrdImgType="large" width="${l.sellPrdtGbn eq 'R'?'200':'132'}" clazz="photo" alt="${fn:escapeXml(l.prdtName)}"/></c:if>
					<c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G' || l.sellPrdtGbn eq 'S'}"><ui:image src="${l.prdtImgUrl}" src2="${l.productImageUrl2}" alt="${l.prdtName}" server="product" ratingCode="${l.nyoSellBanYn}" size="400"/></c:if>			
				</div>
			</a>		
			<!-- 클릭시 active : class 추가 -->
			<!-- 클릭한  상품일 경우 누른 표시 해야함 -->
			<a href="javascript:" onclick="addBizWishProduct(this);return false;" class="btn_like<c:if test="${l.wishUserPrdtCnt > 0}"> active</c:if>" prdtId="${l.sellPrdtBcode}"><span>좋아요</span></a>
			<c:if test="${l.sellPrdtGbn eq 'R' || l.sellPrdtGbn eq 'D'}"><a href="/ht/record/detail/${l.sellPrdtBcode}<c:if test="${reqParam eq 'recobell'}">?foo=bar<c:if test="${fn:length(c.ctgrId) eq 6}">&rccode=pc_category1</c:if><c:if test="${fn:length(c.ctgrId) eq 8}">&rccode=pc_category2</c:if><c:if test="${fn:length(c.ctgrId) eq 10}">&rccode=pc_category3</c:if><c:if test="${fn:length(c.ctgrId) eq 12}">&rccode=pc_category4</c:if></c:if>"></c:if>
			<c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G' || l.sellPrdtGbn eq 'S'}"><a href="/ht/product/detail?barcode=${l.sellPrdtBcode}<c:if test="${reqParam eq 'recobell'}">&foo=bar<c:if test="${fn:length(c.ctgrId) eq 6}">&rccode=pc_category1</c:if><c:if test="${fn:length(c.ctgrId) eq 8}">&rccode=pc_category2</c:if><c:if test="${fn:length(c.ctgrId) eq 10}">&rccode=pc_category3</c:if><c:if test="${fn:length(c.ctgrId) eq 12}">&rccode=pc_category4</c:if></c:if>"></c:if>									
				<div class="cont">
					<p class="brand">${l.brandEngName}</p>
					<p class="tit">${l.prdtName}</p>
					<p class="price font_t">
						<span class="percent"><c:if test="${l.prdtStatCode eq 'C0312' && l.basePrdtSellPrice > l.lastCpnPrice}"><fmt:parseNumber integerOnly="true" value="${hfn:rate(l.basePrdtSellPrice, l.lastCpnPrice)}"/>%</c:if></span>
						<span><fmt:formatNumber type="number">${l.lastCpnPrice}</fmt:formatNumber></span>																								
						<c:if test="${l.basePrdtSellPrice > l.lastCpnPrice}"><span class="discount"><fmt:formatNumber type="number">${l.basePrdtSellPrice}</fmt:formatNumber></span></c:if>
					</p>
					<div class="info">
						<c:set var="reviewCount" value="${l.reviewCount}"/>
						<c:set var="wishPrdtCnt" value="${l.wishPrdtCnt}"/>												
						<c:if test="${l.reviewCount > 999}"><c:set var="reviewCount" value="999+"/></c:if>
		                <c:if test="${l.wishPrdtCnt > 999}"><c:set var="wishPrdtCnt" value="999+"/></c:if>
		                <span class="reply">${reviewCount}</span>
		                <span class="like" code="${l.sellPrdtBcode}">${wishPrdtCnt}</span>												
					</div>
					<div class="badge">
						<c:choose>							
							<c:when test="${l.prdtStatCode ne 'C0312'}">
								<c:if test="${l.prdtStatCode eq 'C0313'}"><span class="badge03">일시품절</span></c:if>
								<c:if test="${l.prdtStatCode ne 'C0313'}"><span class="badge03">품절</span></c:if>
							</c:when>														
							<c:otherwise>					
								<c:if test="${fn:substring(l.prdtIcon,0,1) eq '1'}"><span class="badge01">쿠폰</span></c:if>
								<c:if test="${fn:substring(l.prdtIcon,2,3) eq '1'}"><span class="badge02">사은품</span></c:if>
								<c:if test="${fn:substring(l.prdtIcon,8,9) eq '1'}"><span class="badge02">무료배송</span></c:if>
							</c:otherwise>
						</c:choose>		
					</div>				
				</div>
			</a>
		</li>
		</c:if>
	</c:forEach>							
</c:if>			