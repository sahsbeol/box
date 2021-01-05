<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="none"/>
<c:if test="${empty bestSellers }"><c:set var="bestSellers" value="${bestSellersNone}"/><div id="${bestSellersNone}"> </div></c:if>
<c:if test="${not empty bestSellers}">
	<c:forEach items="${bestSellers}" var="l" varStatus="st">		
		<!-- 이미지 원형인 경우 round : class 추가 -->
		<div class="swiper-slide <c:if test="${l.rcrdStat eq '3' || l.rcrdStat eq '4'}">sold_out-m</c:if><c:if test="${l.rcrdStat eq '2'}">sold_out-t-m</c:if>">
			<c:choose>
				<c:when test="${l.rcrdStat eq '2' || l.rcrdStat eq '3' || l.rcrdStat eq '4'}">
					<a href="/ht/record/detail/${l.sellPrdtBcode}" class="MB_SIDE_CATE_14_ITEM_2">
						<div class="thum">
							<ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" rcrdImgType="large" alt="${l.prdtName}" ratingCode="A" />
							<div class="soldout-wrap">
	                            <div class="absol-center">
	                                <p>아쉽지만!</p>
	                                <p><b></b>이에요</p>
	                            </div>
                            </div>
						</div>
					</a>
				</c:when>
				<c:otherwise>
					<a href="/ht/record/detail/${l.sellPrdtBcode}" class="MB_SIDE_CATE_14_ITEM_2">
						<div class="thum">
							<ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" rcrdImgType="large" alt="${l.prdtName}" ratingCode="A" />							
						</div>
					</a>
				</c:otherwise>
			</c:choose>
			<!-- 클릭시 active : class 추가 -->			
			<a href="javascript:" onclick="addBizWishProduct(this);return false;" class="btn_like<c:if test="${l.wishUserPrdtCnt > 0}"> active</c:if>" prdtId="${l.sellPrdtBcode}"><span>좋아요</span></a>					
			<a href="/ht/record/detail/${l.sellPrdtBcode}" class="MB_SIDE_CATE_14_ITEM_2">
				<div class="cont">
					<p class="brand">${l.artiName }</p>
					<p class="tit">${l.rcrdName}</p>
					<p class="price font_t">
						<c:if test="${l.prdtSellPrice eq l.priceReal}">
							<span><fmt:formatNumber value="${l.prdtSellPrice}" pattern=",###"/></span>
						</c:if>
						<c:if test="${l.prdtSellPrice ne l.priceReal}">
							<span class="percent"><fmt:parseNumber integerOnly="true" value="${hfn:rate(l.prdtSellPrice, l.priceReal)}"/>%</span>
							<span><fmt:formatNumber value="${l.priceReal}" pattern=",###"/></span>
							<span class="discount"><fmt:formatNumber value="${l.prdtSellPrice}" pattern=",###"/></span>
						</c:if>							
					</p>
					<div class="badge">
						<c:if test="${l.mediaName ne 'VCD' && fn:startsWith(l.ctgrId, '000400')}"><span class="badge02">블루레이</span></c:if>
						<c:if test="${l.mediaName ne 'VCD' && fn:startsWith(l.ctgrId, '000401')}"><span class="badge02">DVD</span></c:if>																		
						<c:if test="${l.hasPosterCaseYn eq 'Y'}"><span class="badge01">포스터</span></c:if>
						<c:if test="${fn:substring(l.prdtIcon,0,1) eq '1'}"><span class="badge01">쿠폰</span></c:if>
						<c:if test="${l.impYn eq 'Y'}"><span class="badge02">수입</span></c:if>
						<c:if test="${l.rcrdStat eq '9'}"><span class="badge02">예약</span></c:if>
						<c:if test="${l.rcrdStat eq '2'}"><span class="badge03">일시품절</span></c:if>
						<c:if test="${l.rcrdStat eq '3' || l.rcrdStat eq '4'}"><span class="badge03">품절</span></c:if>												
					</div>						
				</div>
			</a>
		</div>				
	</c:forEach>
</c:if>	
			