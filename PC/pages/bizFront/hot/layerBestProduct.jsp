<%@ page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<%@ include file="/pages/decorators/biz/tagHeader.jsp" %>
<ui:decorator name="none"/>

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
	   	<li>
	        <a href="/p/${l.sellPrdtBcode}">
				<div class="thum">
		            <c:choose>
		                <c:when test="${param.lazy eq 'Y' && st.index > 7}">
		                    <c:choose>
		                        <c:when test="${l.sellPrdtGbn eq 'R' or l.sellPrdtGbn eq 'D'}">
		                        	<ui:image rcrdCd="${l.rcrdCd}" prdtGbn="R" ratingCode="${l.rtngCode }" alt="${l.prdtName}" lazy="Y" clazz="lazy"/>
		                        </c:when>
		                        <c:otherwise>
		                            <ui:image src="${l.productImageUrl}" server="product" alt="${fn:escapeXml(l.prdtName)}" lazy="Y" clazz="lazy"/>
		                        </c:otherwise>
		                    </c:choose>
		                </c:when>
		                <c:otherwise>
		                    <c:choose>
		                        <c:when test="${l.sellPrdtGbn eq 'R' or l.sellPrdtGbn eq 'D'}">
		                        	<ui:image rcrdCd="${l.rcrdCd}" prdtGbn="R" ratingCode="${l.rtngCode }" alt="${l.prdtName}"/>
		                        </c:when>
		                        <c:otherwise>
		                            <ui:image src="${l.productImageUrl}" server="product" alt="${fn:escapeXml(l.prdtName)}"/>
		                        </c:otherwise>
		                    </c:choose>
		                </c:otherwise>
		            </c:choose>
	            </div>
	            
	            <c:if test="${param.dispMstrId eq 'CATE_GFT_NEW' or param.dispMstrId eq 'CATE_GFT_SALE' or param.dispMstrId eq 'FREE_DELIVERY_BEST'}">
	            	<a href="javascript:" onclick="addBizWishProduct(this);return false;" class="btn_like<c:if test="${l.wishUserPrdtCnt eq '1'}"> active</c:if>" prdtId="${l.sellPrdtBcode}"><span>좋아요</span></a>
	            </c:if>
	            
	            <div class="cont">
	            	<p class="brand">${l.brandEngName}</p>
					<p class="tit">${fn:escapeXml(l.prdtName)}</p>
					<p class="price font_t">
						<c:if test="${l.prdtSellPrice ne l.lastCpnPrice}">
							<span class="percent"><fmt:formatNumber type="number">${hfn:rate(l.prdtSellPrice, l.lastCpnPrice)}</fmt:formatNumber>%</span>
							<span><fmt:formatNumber type="number" value="${l.lastCpnPrice}"/></span>
						</c:if>
						<span class="<c:if test='${l.prdtSellPrice ne l.lastCpnPrice}'>discount</c:if>">
							<fmt:formatNumber type="number" value="${l.prdtSellPrice}"/>
						</span>
					</p>
	
		           	<c:set var="reviewCount" value="${l.reviewCount}"/>
					<c:set var="wishPrdtCnt" value="${l.wishPrdtCnt}"/>	
					<c:if test="${l.reviewCount > 999}"><c:set var="reviewCount" value="999+"/></c:if>
		            <c:if test="${l.wishPrdtCnt > 999}"><c:set var="wishPrdtCnt" value="999+"/></c:if>
		            
		           	<c:choose>
		           		<c:when test="${param.dispMstrId eq 'CATE_GFT_NEW' or param.dispMstrId eq 'CATE_GFT_SALE' or param.dispMstrId eq 'FREE_DELIVERY_BEST'}">
		            		<div class="info">
	            				<span class="reply">${reviewCount}</span>
	            				<span class="like" code="${l.sellPrdtBcode}">${wishPrdtCnt}</span>
		            		</div>
		            		<div class="badge">
				                <c:choose>
				                    <c:when test="${l.prdtStatCode ne 'C0312'}"><em class="ico_soldout">품절</em></c:when>
				                    <c:otherwise>
				                    	<c:if test="${fn:substring(l.prdtIcon,0,1) eq \'1\'}">
				                    		<span class='badge01 on'>쿠폰</span>
				                    	</c:if>
				                    	<c:if test="${fn:substring(l.prdtIcon,2,3) eq \'1\'}">
											<span class='badge02'>사은품</span>
										</c:if>
										<c:if test="${fn:substring(l.prdtIcon,8,9) eq \'1\'}">
											<span class='badge03'>무료배송</span>
										</c:if>
				                    </c:otherwise>
				                </c:choose>
				            </div>
		           		</c:when>
		           		<c:otherwise>
		           			<div class="badge">
				                <c:choose>
				                    <c:when test="${l.prdtStatCode ne 'C0312'}"><em class="ico_soldout">품절</em></c:when>
				                    <c:otherwise>
				                    	<c:if test="${fn:substring(l.prdtIcon,0,1) eq \'1\'}">
				                    		<span class='badge01 on'>쿠폰</span>
				                    	</c:if>
				                    	<c:if test="${fn:substring(l.prdtIcon,2,3) eq \'1\'}">
											<span class='badge02'>사은품</span>
										</c:if>
										<c:if test="${fn:substring(l.prdtIcon,8,9) eq \'1\'}">
											<span class='badge03'>무료배송</span>
										</c:if>
				                    </c:otherwise>
				                </c:choose>
				            </div>
		           			<div class="info">
	            				<span class="reply">${reviewCount}</span>
	            				<span class="like" code="${l.sellPrdtBcode}">${wishPrdtCnt}</span>
		           			</div>
		           		</c:otherwise>
		           	</c:choose>
					</div>
				</div>
	        </a>
		</li>
	</c:if>
</c:forEach>