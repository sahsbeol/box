<%@ page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<%@ include file="/pages/decorators/biz/tagHeader.jsp" %>
<ui:decorator name="none"/>

<c:if test="${empty list}">
    <p class="info t_c">해당 분류의 상품이 존재하지 않습니다.</p>
</c:if>

<c:forEach items="${list}" var="l" varStatus="st">
	<c:choose>
		<c:when test="${c.tabType eq 'BR'}">
   			<li>
				<div class="img_zone">
		            <c:choose>
		                <c:when test="${param.lazy eq 'Y' && st.index > 7}">
		                    <c:choose>
		                        <c:when test='${not empty l.brandImageUrl}'>
		                        	<ui:image src="${l.brandImageUrl}" server="brand" alt="${brand.brandName}"/>
		                        </c:when>
		                        <c:otherwise>
		                            <img src="/images/biz/sub/benefit/img_brand.png" alt="브랜드 이미지">
		                        </c:otherwise>
		                    </c:choose>
		                </c:when>
		                <c:otherwise>
		                    <c:choose>
		                        <c:when test='${not empty l.brandImageUrl}'>
		                        	<ui:image src="${l.brandImageUrl}" server="brand" alt="${brand.brandName}"/>
		                        </c:when>
		                        <c:otherwise>
		                            <img src="/images/biz/sub/benefit/img_brand.png" alt="브랜드 이미지">
		                        </c:otherwise>
		                    </c:choose>
		                </c:otherwise>
		            </c:choose>
	            </div>
				<div class="txt_zone">
					<h2 class='font_t'>
						<c:if test='${not empty l.brandEngName}'>
							${l.brandEngName}
						</c:if>
						<c:if test='${empty l.brandEngName}'>
							${l.brandName}
						</c:if>
					</h2>
                    <c:choose>
                        <c:when test="${not empty l.cpnDscntRate && l.cpnDscntRate > 0}">
                        	<h3>지금 구매하면 ${l.cpnDscntRate}% 할인</h3>
                        </c:when>
                        <c:otherwise>
                            <h3>지금 구매하면 <fmt:formatNumber type="number">${l.cpnDscntAmt}</fmt:formatNumber>원 할인</h3>
                        </c:otherwise>
                    </c:choose>
					<fmt:parseDate value="${l.cpnApplyStartDt}" var="sDate" pattern="yyyyMMdd"/>
					<fmt:parseDate value="${l.cpnApplyEndDt}" var="eDate" pattern="yyyyMMdd"/>								
					<p class='font_t'><fmt:formatDate value="${sDate}" pattern="yyyy.MM.dd"/>~<fmt:formatDate value="${eDate}" pattern="yyyy.MM.dd"/></p>
				</div>
				<em>적용 상품보기</em>
				<a href="javascript:;" onclick="location.href='/m/biz/mypage/nowDownloadCoupon?tabType=BP&brandId=${l.brandId}'"></a>
			</li>
		</c:when>
		<c:otherwise>
			<li>
				<a href="javascript:;" onclick="location.href='/ht/biz/eventDetail?eventId=${l.eventId}';return false;">
					<div class="img_wrap">
						<ui:image src="${l.eventImageUrl}" alt="${l.eventTitle}"/>
					</div>
					<c:if test="${not empty l.discRate && l.discRate > 0}">
                       	<span class="font_t percent">${l.discRate}%</span>
                    </c:if>
					<strong>${l.eventTitle}</strong>
					<p>${l.eventDtlCont}</p>
					<span class="date font_t">
						<c:choose>        
							<c:when test="${not empty l.eventRangeInfo}">
								${l.eventRangeInfo}
							</c:when>        
                           	<c:when test="${l.eventEndDt eq '99991231' || l.eventEndDt eq '99999999'}">
                           		<ui:mask pattern="####.##.##">${l.eventStartDt}</ui:mask> ~ 
                           	</c:when>
                           	<c:otherwise>
                           		<ui:mask pattern="####.##.##">${l.eventStartDt}</ui:mask> ~ <ui:mask pattern="####.##.##">${l.eventEndDt}</ui:mask>
                           	</c:otherwise>
                       	</c:choose>
	     			</span>
				</a>
			</li>
		</c:otherwise>
	</c:choose>
</c:forEach>

<script>
	$("#totalCnt").text("<fmt:formatNumber type='number' value='${totalCnt}'/>");
</script>

<c:if test="${drawPage == 'Y'}">
	<div class="pagination_v2">
	    <ui:bizpaginationScript name="pageHolder" scriptName="goList"/>
	</div>
</c:if>