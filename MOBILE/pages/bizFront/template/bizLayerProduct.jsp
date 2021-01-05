<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<div class="pd_list">
	<ul>
    <c:if test="${empty list}">
        <li>해당 분류의 상품이 존재하지 않습니다.</li>
    </c:if>
    <c:forEach items="${list}" var="l" varStatus="st">
	    <li <c:if test="${l.prdtStatCode ne 'C0312' && l.prdtStatCode ne 'C0313'}">class="sold_out"</c:if><c:if test="${l.prdtStatCode ne 'C0312' && l.prdtStatCode eq 'C0313'}">class="sold_out-t"</c:if>>
	    		<c:choose>
	    			<c:when test="${l.prdtStatCode ne 'C0312'}">
	    				<c:choose>
		    				<c:when test="${l.sellPrdtGbn eq 'R' || l.sellPrdtGbn eq 'D'}"><a href="/p/${l.sellPrdtBcode}"></c:when>
		    				<c:otherwise><a href="#none"></c:otherwise>
	    				</c:choose>
	    			</c:when>
	    			<c:otherwise><a href="/p/${l.sellPrdtBcode}"></c:otherwise>
	    		</c:choose>
	    		<div class="thum">
	    			<c:choose>
	    				<c:when test="${l.sellPrdtGbn eq 'R' || l.sellPrdtGbn eq 'D'}">
	    					<ui:image rcrdCd="${l.rcrdCd}" size="400" prdtGbn="R" ratingCode="${l.rtngCode }" alt="${l.prdtName}"/>
							<c:if test="${l.prdtStatCode ne 'C0312'}">
								<div class="soldout-wrap">
                                    <div class="absol-center">
                                        <p>아쉽지만!</p>
                                        <p><b></b>이에요</p>
                                    </div>
                                </div>
                            </c:if>    
	    				</c:when>
	    				<c:otherwise>
	    					<ui:image src="${l.productImageUrl}" size="400" server="product" alt="${fn:escapeXml(l.prdtName)}"/>
	    					<c:if test="${l.prdtStatCode ne 'C0312'}">
								<div class="soldout-wrap">
                                    <div class="absol-center">
                                        <p>아쉽지만!</p>
                                        <p><b></b>이에요</p>
                                        <button type="button" class="replace-stuff-btn" id="replaceBtnId" code="${l.sellPrdtBcode}">대체상품</button>
                                    </div>
                                </div>
                            </c:if> 
					    </c:otherwise>       
	               	</c:choose>
	            </div>
	        </a>
	        <!-- 클릭시 active : class 추가 -->
	        <a href="javascript:" onclick="addBizWishProduct(this);return false;" class="btn_like<c:if test="${l.wishUserPrdtCnt > 0}"> active</c:if>" prdtId="${l.sellPrdtBcode}"><span>좋아요</span></a>
	        <a href="/p/${l.sellPrdtBcode}">
	        	<div class="cont">
	            	<p class="brand">${l.brandEngName}</p>
					<p class="tit">${l.prdtName}</p>
					<p class="price font_t">
	                	<fmt:parseNumber var="rate" type="number" value="${hfn:rate(l.prdtSellPrice,l.lastCpnPrice)}"/>
						<c:if test="${rate > 0}"><span class="percent"><fmt:parseNumber integerOnly="true" value="${rate}"/>%</span></c:if>
						<span><fmt:formatNumber type="number">${l.lastCpnPrice}</fmt:formatNumber></span>																								
						<c:if test="${rate > 0}"><span class="discount"><fmt:formatNumber type="number">${l.prdtSellPrice}</fmt:formatNumber></span></c:if>
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
    </c:forEach>
    </ul>
</div>    	
