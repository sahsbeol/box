<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="none"/>
<c:if test="${not empty bestSellers}">
	<c:forEach items="${bestSellers}" var="l" varStatus="st">		
		<!-- 이미지 원형인 경우 round : class 추가 -->		
		<div class="swiper-slide <c:if test="${prdtStatCode ne 'C0312'}">sold_out</c:if>">
			<a href="/ht/record/detail/${l.sellPrdtBcode}">
				<div class="thum">
					<ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" width="${l.sellPrdtGbn eq 'R'?'145':'95'}" alt="${l.prdtName}" ratingCode="A" style="width:${l.sellPrdtGbn eq 'R'?'145px':'95px'};height:145px;"/>
				</div>
			</a>
			<!-- 클릭시 active : class 추가 -->			
			<a href="javascript:" onclick="addBizWishProduct(this);return false;" class="btn_like<c:if test="${l.wishUserPrdtCnt eq '1'}"> active</c:if>" prdtId="${l.sellPrdtBcode}"><span>좋아요</span></a>					
			<a href="/ht/record/detail/${l.sellPrdtBcode}">
				<div class="cont">
					<p class="brand">${l.makerName }</p>
					<p class="tit">${l.artiName} - ${l.rcrdName}</p>
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
						<c:if test="${l.hasPosterCaseYn eq 'Y'}"><span class="badge01">지관통포스터</span></c:if>
						<c:if test="${fn:substring(l.prdtIcon,0,1) eq '1'}"><span class="badge01">쿠폰</span></c:if>
						<c:if test="${l.impYn eq 'Y'}"><span class="badge02">수입</span></c:if>
						<c:if test="${l.rcrdStat eq '9'}"><span class="badge02">예약</span></c:if>								
						<c:if test="${l.prdtStatCode ne 'C0312'}">
							<c:choose>
								<c:when test="${l.rcrdStat eq '3' || l.rcrdStat eq '4'}">
									<span class="badge03">품절</span>
								</c:when>
								<c:otherwise>
									<span class="badge03">일시품절</span>
								</c:otherwise>
							</c:choose>	
						</c:if>								
					</div>
				</div>
			</a>
		</div>			
	</c:forEach>
</c:if>	
			