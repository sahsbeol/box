<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<div class="pd_list">
	<ul>
    <c:if test="${empty list}">
        <p class="info t_c">해당 분류의 상품이 존재하지 않습니다.</p>
    </c:if>
    <c:forEach items="${list}" var="l" varStatus="st">
    	<li <c:if test="${l.saleYn ne 'Y' && (l.rcrdStat eq '3' || l.rcrdStat eq '4')}">class="sold_out-m"</c:if><c:if test="${l.saleYn ne 'Y' && (l.rcrdStat ne '3' || l.rcrdStat ne '4')}">class="sold_out-t-m"</c:if>>
	       <c:choose>
	       	   <c:when test="${l.saleYn ne 'Y'}"><a href="/m/record/detail/${l.sellPrdtBcode}"></c:when>
	       	   <c:otherwise><a href="/m/record/detail/${l.sellPrdtBcode}"></c:otherwise>
	       </c:choose>
	        	<div class="thum">
		        	<c:choose>
						<c:when test="${l.sellPrdtGbn eq 'R' || l.sellPrdtGbn eq 'D'}">
							<c:if test="${l.saleYn ne 'Y'}">
							<ui:image rcrdCd="${l.rcrdCd}" prdtGbn="R" rcrdImgType="large" ratingCode="${l.rtngCode }" alt="${l.prdtName}"/>
								<div class="soldout-wrap">
		                            <div class="absol-center">
		                                <p>아쉽지만!</p>
		                                <p><b></b>이에요</p>
		                            </div>
                            	</div>
							</c:if>
							<c:if test="${l.saleYn eq 'Y'}">
								<ui:image rcrdCd="${l.rcrdCd}" prdtGbn="R" rcrdImgType="large" ratingCode="${l.rtngCode }" alt="${l.prdtName}"/>
							</c:if>
						</c:when>						
						<c:otherwise>
							<c:if test="${l.saleYn ne 'Y'}">
							<ui:image src="${l.productImageUrl}" server="product" alt="${fn:escapeXml(l.prdtName)}"/>
								<div class="soldout-wrap">
		                            <div class="absol-center">
		                                <p>아쉽지만!</p>
		                                <p><b></b>이에요</p>
                                        <button type="button" class="replace-stuff-btn" onclick="replaceBtn('${l.sellPrdtBcode}');return false;">대체상품</button>
		                            </div>
                            	</div>
							</c:if>
							<c:if test="${l.saleYn eq 'Y'}">
						    	<ui:image src="${l.productImageUrl}" server="product" alt="${fn:escapeXml(l.prdtName)}"/>
						    </c:if>
						</c:otherwise>
					</c:choose>
	        	</div>          
			</a>
			<!-- 클릭시 active : class 추가 -->
			<a href="javascript:" onclick="addBizWishProduct(this);return false;" class="btn_like<c:if test="${l.wishUserPrdtCnt > 0}"> active</c:if>" prdtId="${l.sellPrdtBcode}"><span>좋아요</span></a>			
			<a href="/m/record/detail/${l.sellPrdtBcode}">
				<div class="cont">
					<p class="brand">${l.artiName}</p>
					<p class="tit">${fn:escapeXml(l.prdtName)}</p>
					<p class="price font_t">
	                	<fmt:parseNumber var="rate" type="number" value="${hfn:rate(l.prdtSellPrice,l.lastCpnPrice)}"/>
						<c:if test="${rate > 0}"><span class="percent"><fmt:parseNumber integerOnly="true" value="${rate}"/>%</span></c:if>
						<span><fmt:formatNumber type="number">${l.lastCpnPrice}</fmt:formatNumber></span>																								
						<c:if test="${rate > 0}"><span class="discount"><fmt:formatNumber type="number">${l.prdtSellPrice}</fmt:formatNumber></span></c:if>
					</p>
					<!-- 
					<div class="info">
						<c:set var="reviewCount" value="${l.reviewCount}"/>
						<c:set var="wishPrdtCnt" value="${l.wishPrdtCnt}"/>												
						<c:if test="${l.reviewCount > 999}"><c:set var="reviewCount" value="999+"/></c:if>
		                <c:if test="${l.wishPrdtCnt > 999}"><c:set var="wishPrdtCnt" value="999+"/></c:if>
		                <span class="reply">${reviewCount}</span>
		                <span class="like" code="${l.sellPrdtBcode}">${wishPrdtCnt}</span>											
					</div>
					 -->
					<div class="badge">
						<c:if test="${l.mediaName ne 'VCD' && fn:startsWith(l.ctgrId, '000400')}"><span class="badge02">블루레이</span></c:if>
						<c:if test="${l.mediaName ne 'VCD' && fn:startsWith(l.ctgrId, '000401')}"><span class="badge02">DVD</span></c:if>
						<c:if test="${l.hasPosterCaseYn eq 'Y'}"><span class="badge01">포스터</span></c:if>
						<c:if test="${fn:substring(l.prdtIcon,0,1) eq '1'}"><span class="badge01">쿠폰</span></c:if>
						<c:if test="${l.impYn eq 'Y'}"><span class="badge02">수입</span></c:if>
						<c:if test="${l.rcrdStat eq '9'}"><span class="badge02">예약</span></c:if>
						<c:if test="${l.saleYn ne 'Y'}">
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
		</li>        
    </c:forEach>
    </ul>
</div>