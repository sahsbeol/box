<%@ page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<%@ include file="/pages/decorators/biz/tagHeader.jsp" %>
<ui:decorator name="none"/>

<c:choose>
	<c:when test="${fn:contains(type, 'Best')}">
		<c:forEach items="${list}" var="l" varStatus="st">
			<li>
				<c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G' || l.sellPrdtGbn eq 'S'}">
					<a href="javascript:;" onclick="location.href='/ht/product/detail?barcode=${l.sellPrdtBcode}';return false;">
				</c:if>
				<c:if test="${l.sellPrdtGbn eq 'R' || l.sellPrdtGbn eq 'D'}">
					<a href="javascript:;" onclick="location.href='/ht/record/detail/${l.sellPrdtBcode}';return false;">
				</c:if>
					<em class="font_t">${st.count}</em>
					<div class="thum">
						<c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G' || l.sellPrdtGbn eq 'S'}">
                      		<ui:image src="${l.productImageUrl}" src2="${l.productImageUrl2}" size="100" server="product" alt="${fn:escapeXml(l.prdtName)}"/>
                      	</c:if>
						<c:if test="${l.sellPrdtGbn eq 'R'}">
							<ui:image rcrdCd="${l.rcrdCd}" size="100" prdtGbn="${l.sellPrdtGbn}" alt="${l.commTitle}" rcrdImgType="large" ratingCode="A"/>
						</c:if>
               			<c:if test="${l.sellPrdtGbn eq 'D'}">
                   			<ui:image rcrdCd="${l.rcrdCd}" size="100" prdtGbn="${l.sellPrdtGbn}" alt="${l.commTitle}" rcrdImgType="large" ratingCode="A"/>
                		</c:if>
					</div>
					<div class="desc">
						<p class="tit">
							<c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G' || l.sellPrdtGbn eq 'S'}">
                           		${l.prdtName}
                           	</c:if>
							<c:if test="${l.sellPrdtGbn eq 'R' || l.sellPrdtGbn eq 'D'}">
								${l.commTitle}
							</c:if>
						</p>
						<p class="price font_t">
							<c:if test="${l.prdtSellPrice > l.lastCpnPrice}">
                      			<fmt:parseNumber var="rate" integerOnly="true" value="${hfn:rate(l.prdtSellPrice,l.lastCpnPrice)}" />
                  				<span class="percent">${rate}%</span>
							</c:if>
							<fmt:formatNumber type="number">${l.lastCpnPrice}</fmt:formatNumber>
						</p>
					</div>
				</a>
			</li>
		</c:forEach>
	</c:when>
	<c:when test="${fn:contains(type, 'Reserve')}">
		<c:forEach items="${list}" var="l" varStatus="st">
			<li>
				<a href="javascript:;" onclick="location.href='/ht/record/detail/${l.sellPrdtBcode}';return false;">
					<div class="thum">
						<ui:image rcrdCd="${l.rcrdCd}" width="400" prdtGbn="${l.sellPrdtGbn}" alt="${l.prdtName}" ratingCode="A"/>
						<c:if test="${l.preDay > 0}">
							<span class="font_t">D-${l.preDay}</span>
						</c:if>
					</div>
					<p class="date">발매일<strong class="mgl5 font_t"><ui:mask pattern="####.##.##">${l.rlseDt}</ui:mask></strong></p>
					<p class="tit">${l.prdtName}</p>
					<p class="price font_t">
						<c:if test="${l.prdtSellPrice ne l.dscntPrice}">
							<span class='percent'>
								<fmt:parseNumber integerOnly="true">${hfn:rate(l.prdtSellPrice, l.dscntPrice)}</fmt:parseNumber>%
							</span>
						</c:if>
						<fmt:formatNumber type="number">${l.dscntPrice}</fmt:formatNumber>
					</p>
				</a>
			</li>
		</c:forEach>
	</c:when>
	<c:when test="${fn:contains(type, 'ctgr')}">
		<div class="cont_left">
			<div class="category_banner<c:if test="${ctgryData.imgType eq 'C1501'}"> type02</c:if><c:if test="${ctgryData.imgType eq 'C1502'}"> type01</c:if>">
				<a href="javascript:;" class="PC_MAIN_CATE_1_1" onclick="location.href='/ht/biz/eventDetail?eventId=${ctgryData.eventId}';return false;">
					<c:if test="${not empty ctgryData.discRate and ctgryData.discRate ne '0'}">
						<span class="font_t percent">${ctgryData.discRate}%</span>
					</c:if>
					
					<strong>${ctgryData.eventTitle}</strong>
					<c:if test="${not empty ctgryData.eventDtlCont}">
						<p>${ctgryData.eventDtlCont}</p>
					</c:if>
					
					<span class="date font_t">
						<c:choose>        
							<c:when test="${not empty ctgryData.eventRangeInfo}">
								${ctgryData.eventRangeInfo}
							</c:when>        
                           	<c:when test="${ctgryData.eventEndDt eq '99991231' || ctgryData.eventEndDt eq '99999999'}">
                           		<ui:mask pattern="####.##.##">${ctgryData.eventStartDt}</ui:mask> ~ 
                           	</c:when>
                           	<c:otherwise>
                           		<ui:mask pattern="####.##.##">${ctgryData.eventStartDt}</ui:mask> ~ <ui:mask pattern="####.##.##">${ctgryData.eventEndDt}</ui:mask>
                           	</c:otherwise>
                       	</c:choose>
					</span>
					
					<div class="thum">
						<ui:image src="${ctgryData.bnrImgUrl}" alt="${ctgryData.bnrImgAlt}"/>
					</div>
				</a>
			</div>
		</div>
		<c:forEach items="${list}" var="l" varStatus="st">	
			<c:if test="${st.count == 1}">	
				<div class="cont_right">
					<ul>
			</c:if>
						<li class="PC_MAIN_CATE_1_2">
							<c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G' || l.sellPrdtGbn eq 'S'}">
								<a href="javascript:;" onclick="location.href='/ht/product/detail?barcode=${l.sellPrdtBcode}';return false;">
							</c:if>
							<c:if test="${l.sellPrdtGbn eq 'R' || l.sellPrdtGbn eq 'D'}">
								<a href="javascript:;" onclick="location.href='/ht/record/detail/${l.sellPrdtBcode}';return false;">
							</c:if>
								<div class="thum">
									<c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G'}">
										<ui:image src="${l.productImageUrl}" size="400" server="product" alt="${fn:escapeXml(l.prdtName)}"/>
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
									<fmt:parseNumber var="rate" type="number" integerOnly="true" value="${hfn:rate(l.prdtSellPrice,l.lastCpnPrice)}"/>
	                               	<c:if test="${rate > 0}">
	                               		<span class="percent">${rate}%</span>
	                               	</c:if>
	                               	<fmt:formatNumber type="number">${l.lastCpnPrice}</fmt:formatNumber>
								</p>
							</a>
						</li>
			<c:if test="${st.last}">
					</ul>
				</div>
			</c:if>
		</c:forEach>
	</c:when>
	<c:when test="${fn:contains(type, 'pd')}">
		<c:forEach items="${list}" var="l" varStatus="st" begin="0" end="4">
			<c:if test="${st.count == 1}">
				<c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G' || l.sellPrdtGbn eq 'S'}">
					<a href="javascript:;" class="PC_MAIN_MENU_15_1" onclick="location.href='/ht/product/detail?barcode=${l.sellPrdtBcode}';return false;">
				</c:if>
				<c:if test="${l.sellPrdtGbn eq 'R' || l.sellPrdtGbn eq 'D'}">
					<a href="javascript:;" class="PC_MAIN_MENU_15_1" onclick="location.href='/ht/record/detail/${l.sellPrdtBcode}';return false;">
				</c:if>
					<div class="thum">
						<c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G'}">
							<ui:image src="${l.productImageUrl}" size="400" server="product" alt="${fn:escapeXml(l.prdtName)}"/>
						</c:if>
						<c:if test="${l.sellPrdtGbn eq 'R'}">
							<ui:image rcrdCd="${l.rcrdCd}" prdtGbn="R" ratingCode="A" alt="${fn:escapeXml(l.prdtName)}"/>
						</c:if>
						<c:if test="${l.sellPrdtGbn eq 'D'}">
							<ui:image rcrdCd="${l.rcrdCd}" prdtGbn="D" ratingCode="A" alt="${fn:escapeXml(l.prdtName)}"/>
						</c:if>
					</div>
					<div class="desc">
						<p class="price font_t">
							<fmt:parseNumber var="rate" type="number" integerOnly="true" value="${hfn:rate(l.prdtSellPrice,l.lastCpnPrice)}"/>
							<c:if test="${rate > 0}">
								<span class="percent">${rate}%</span>
							</c:if><fmt:formatNumber type="number">${l.lastCpnPrice}</fmt:formatNumber>
						</p>
						<p class="tit">${l.prdtName}</p>
					</div>
				</a>
				<div class="thum_list">
					<ul>
			</c:if>
					<c:if test="${st.count > 1}">
						<li class="PC_MAIN_MENU_15_2">
							<c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G' || l.sellPrdtGbn eq 'S'}">
								<a href="javascript:;" onclick="location.href='/ht/product/detail?barcode=${l.sellPrdtBcode}';return false;">
							</c:if>
							<c:if test="${l.sellPrdtGbn eq 'R' || l.sellPrdtGbn eq 'D'}">
								<a href="javascript:;" onclick="location.href='/ht/record/detail/${l.sellPrdtBcode}';return false;">
							</c:if>
									<c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G'}">
										<ui:image src="${l.productImageUrl}" size="100" server="product" alt="${fn:escapeXml(l.prdtName)}"/>
									</c:if>
									<c:if test="${l.sellPrdtGbn eq 'R'}">
										<ui:image rcrdCd="${l.rcrdCd}" prdtGbn="R" ratingCode="A" alt="${fn:escapeXml(l.prdtName)}"/>
									</c:if>
									<c:if test="${l.sellPrdtGbn eq 'D'}">
										<ui:image rcrdCd="${l.rcrdCd}" prdtGbn="D" ratingCode="A" alt="${fn:escapeXml(l.prdtName)}"/>
									</c:if>
								</a>
						</li>
					</c:if>
				<c:if test="${st.last}">		
					</ul>
				</div>
			</c:if>
		</c:forEach>
	</c:when>
</c:choose>