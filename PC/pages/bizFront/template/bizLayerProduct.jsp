<%@ page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<!-- 태그 라이브러리 -->
<%@ include file="/pages/decorators/biz/tagHeader.jsp" %>

<c:forEach items="${requestScope[param.paramList]}" var="l" varStatus="st">
    <li class="<c:if test="${l.prdtStatCode ne 'C0312' && l.prdtStatCode ne 'C0313'}">sold_out</c:if><c:if test="${l.prdtStatCode ne 'C0312' && l.prdtStatCode eq 'C0313'}">sold_out-t</c:if>">
    	<c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G' || l.sellPrdtGbn eq 'S'}">
    		<c:choose>
    			<c:when test="${l.prdtStatCode ne 'C0312'}"><a href="#none"></c:when>
    			<c:otherwise><a href="javascript:;" onclick="location.href='/ht/product/detail?barcode=${l.sellPrdtBcode}';return false;"></c:otherwise>
    		</c:choose>
		</c:if>
		<c:if test="${l.sellPrdtGbn eq 'R' || l.sellPrdtGbn eq 'D'}">
			<a href="javascript:;" onclick="location.href='/ht/record/detail/${l.sellPrdtBcode}';return false;">
		</c:if>
			<div class="thum<c:if test="${not empty param.imgRound && param.imgRound eq 'Y'}"> round</c:if>">
				<c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G' || l.sellPrdtGbn eq 'S'}">
                    <ui:image src="${l.productImageUrl}" src2="${l.productImageUrl2}" size="400" server="product" alt="${fn:escapeXml(l.prdtName)}"/>
                 	<c:if test="${l.prdtStatCode ne 'C0312'}">
						<div class="soldout-wrap">
	                         <div class="absol-center">
	                             <p>아쉽지만!</p>
	                             <p><b></b>이에요</p>
	                             <button type="button" class="replace-stuff-btn" onclick="replaceBtn('${l.sellPrdtBcode}');return false;">대체상품</button>
	                         </div>
                     	</div>
                    </c:if>
                </c:if>
				<c:if test="${l.sellPrdtGbn eq 'R'}">
					<ui:image rcrdCd="${l.rcrdCd}" size="400" prdtGbn="${l.sellPrdtGbn}" alt="${fn:escapeXml(l.prdtName)}" rcrdImgType="large" ratingCode="A"/>
					<c:if test="${l.prdtStatCode ne 'C0312'}">
						<div class="soldout-wrap">
	                         <div class="absol-center">
	                             <p>아쉽지만!</p>
	                             <p><b></b>이에요</p>
	                         </div>
                     	</div>
                    </c:if>
				</c:if>
             	<c:if test="${l.sellPrdtGbn eq 'D'}">
               		<ui:image rcrdCd="${l.rcrdCd}" size="400" prdtGbn="${l.sellPrdtGbn}" alt="${fn:escapeXml(l.prdtName)}" rcrdImgType="large" ratingCode="A"/>
              		<c:if test="${l.prdtStatCode ne 'C0312'}">
						<div class="soldout-wrap">
	                         <div class="absol-center">
	                             <p>아쉽지만!</p>
	                             <p><b></b>이에요</p>
	                         </div>
                     	</div>
                    </c:if>
              	</c:if>
			</div>
		</a>
		<!-- 클릭시 active : class 추가 -->
		<a href="javascript:" onclick="addBizWishProduct(this);return false;" class="btn_like<c:if test="${l.wishUserPrdtCnt > 0}"> active</c:if>" prdtId="${l.sellPrdtBcode}"><span>좋아요</span></a>
		<c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G' || l.sellPrdtGbn eq 'S'}">
			<a href="javascript:;" onclick="location.href='/ht/product/detail?barcode=${l.sellPrdtBcode}';return false;">
		</c:if>
		<c:if test="${l.sellPrdtGbn eq 'R' || l.sellPrdtGbn eq 'D'}">
			<a href="javascript:;" onclick="location.href='/ht/record/detail/${l.sellPrdtBcode}';return false;">
		</c:if>
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
</c:forEach>