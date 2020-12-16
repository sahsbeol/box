<%@ page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<%@ include file="/pages/decorators/biz/tagHeader.jsp" %>

<c:if test="${empty list}">
    <p class="info t_c">해당 분류의 상품이 존재하지 않습니다.</p>
</c:if>

<c:forEach items="${list}" var="l" varStatus="st">
	<c:set var="freeCheck" value="Y" />	
	<c:if test="${c.dispMstrId == 'FREE_DELIVERY_BEST'}">
    	<fmt:parseNumber var = "amtRange" type = "number" value = "${c.ctgrId}" />
    		<fmt:parseNumber var = "lastPrice" type = "number" value = "${l.lastCpnPrice}" />
           <c:choose>
               <c:when test="${lastPrice < amtRange * 10000}">
               	<c:choose>
	                <c:when test="${l.sellPrdtGbn == 'R' && l.sellPrdtGbn == 'D'}">
	                	<c:if test="${l.lastCpnPrice < 20000}">
	                		<c:set var="freeCheck" value="N" />
	                	</c:if>
	                </c:when>
	                <c:otherwise>
	                	<c:if test="${!(l.lastFreeDlvyYn == 'Y' && l.codDlvyAmtYn == 'N')}">
	                		<c:set var="freeCheck" value="N" />
	                	</c:if>
	                </c:otherwise>
	            </c:choose>
               </c:when>
               <c:otherwise>
               	<c:set var="freeCheck" value="N" />
               </c:otherwise>
           </c:choose>
   	</c:if>
   	<c:if test="${freeCheck == 'Y'}">
		<li <c:if test="${l.prdtStatCode ne 'C0312'}">class="sold_out"</c:if>>
			<a href="/ht/product/detail?barcode=${l.sellPrdtBcode}<c:if test="${c.dispMstrId == 'FREE_DELIVERY_BEST'}">&foo=bar&rccode=pc_free</c:if>" title="${l.prdtName}">
				<div class="thum<c:if test="${c.dispMstrId eq 'CATE_GFT_BEST' and st.count < 5}"> round</c:if>">
					<ui:image src="${l.productImageUrl}" src2="${l.productImageUrl2}" size="400" server="product" alt="${fn:escapeXml(l.prdtName)}"/>
				</div>
			</a>
			<!-- 클릭시 active : class 추가 -->
			<a href="javascript:" onclick="addBizWishProduct(this);return false;" class="btn_like<c:if test="${l.wishUserPrdtCnt eq '1'}"> active</c:if>" prdtId="${l.sellPrdtBcode}"><span>좋아요</span></a>
			<a href="/ht/product/detail?barcode=${l.sellPrdtBcode}<c:if test="${c.dispMstrId == 'FREE_DELIVERY_BEST'}">&foo=bar&rccode=pc_free</c:if>">
				<div class="cont">
					<p class="brand">${l.brandName}</p>
					<p class="tit">${l.prdtName}</p>
					<p class="price font_t">
						<c:if test="${l.prdtSellPrice > l.lastCpnPrice}">
							<fmt:parseNumber var="rate" integerOnly="true" value="${hfn:rate(l.prdtSellPrice, l.lastCpnPrice)}"/>
							<span class="percent">${rate}%</span>
						</c:if>
						<span><fmt:formatNumber value="${l.lastCpnPrice}" pattern="#,###"/></span>
						<c:if test="${l.prdtSellPrice > l.lastCpnPrice}">
							<span class="discount"><fmt:formatNumber value="${l.prdtSellPrice}" pattern="#,###"/></span>
						</c:if>
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
								<c:if test="${fn:substring(l.prdtIcon,0,1) eq '1'}">
			                   		<span class="badge01">쿠폰</span>
			                   </c:if>
			                   <c:if test="${fn:substring(l.prdtIcon,2,3) eq '1'}">
			                   		<span class="badge02">사은품</span>
			                   	</c:if>
			                   <c:if test="${fn:substring(l.prdtIcon,8,9) eq '1'}">
			                   		<span class="badge02">무료배송</span>
			                   </c:if>
							</c:otherwise>
						</c:choose>		  
					</div>
				</div>
			</a>
		</li>
	</c:if>
</c:forEach>