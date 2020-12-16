<%@ page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<!-- 태그 라이브러리 -->
<%@ include file="/pages/decorators/biz/tagHeader.jsp" %>

<script type="text/javascript">
	$(document).ready(function(){
		obj.init();

	});
	
	var obj = {
		 today : new Date()
		,init : function(){			
			categoryFn();
		}
	};
</script>

<div class="coupon_wrap category_wrap">
	<div class="coupon_zone pd_unit">
		<h2>쿠폰존</h2>
		<div class="tab">
			<ul class="col03">
				<li<c:if test="${empty c.tabType or c.tabType eq 'PD'}"> class="active"</c:if>>
					<a href="javascript:;" onclick="location.href='/ht/biz/mypage/nowDownloadCoupon?tabType=PD'"><span>상품쿠폰</span></a>
				</li>
				<li<c:if test="${c.tabType eq 'BR' or c.tabType eq 'BP'}"> class="active"</c:if>>
					<a href="javascript:;" onclick="location.href='/ht/biz/mypage/nowDownloadCoupon?tabType=BR'"><span>브랜드 쿠폰</span></a>
				</li>
				<li<c:if test="${c.tabType eq 'PM'}"> class="active"</c:if>>
					<a href="javascript:;" onclick="location.href='/ht/biz/mypage/nowDownloadCoupon?tabType=PM'"><span>프로모션</span></a>
				</li>
			</ul>
		</div>
		<div class="coupon_guide">
			<img src="/images/biz/sub/benefit/ic_coupon.png" alt="쿠폰 이미지">
			<ul class='clear'>
				<li>할인 쿠폰은 상품 상세 페이지에서 발급 가능합니다.</li>
				<li>쿠폰 적용불가 상품의 경우 할인 적용 대상에서 제외합니다.</li>
				<li>하나의 상품에는 하나의 쿠폰만 사용하실 수 있습니다.</li>
				<li>이미 보유 중인 쿠폰은 추가발급되지 않습니다.</li>
			</ul>
		</div>
		
		<!-- 쿠폰존 배너 -->
		<c:if test="${not empty brData}">
			<c:if test="${not empty brData.cpnDscntRate && brData.cpnDscntRate > 0}">
				<div class="bnr_coupon">
					<div class="desc_coupon">
						<c:choose>
	                        <c:when test="${not empty brData.cpnDscntRate && brData.cpnDscntRate > 0}">
	                        	<h4 class='font_t'>${brData.cpnDscntRate}%</h4>
	                        </c:when>
	                        <c:otherwise>
	                            <h4 class='font_t'><fmt:formatNumber type="number">${brData.cpnDscntAmt}</fmt:formatNumber>원</h4>
	                        </c:otherwise>
	                    </c:choose>
						<p class='font_t'>
							<c:if test='${not empty brData.brandEngName}'>
								${brData.brandEngName}
							</c:if>
							<c:if test='${empty brData.brandEngName}'>
								${brData.brandName}
							</c:if>
						</p>
						<fmt:parseDate value="${brData.cpnApplyStartDt}" var="sDate" pattern="yyyyMMdd"/>
						<fmt:parseDate value="${brData.cpnApplyEndDt}" var="eDate" pattern="yyyyMMdd"/>	
						<span class='font_t'><fmt:formatDate value="${sDate}" pattern="yyyy.MM.dd"/>~<fmt:formatDate value="${eDate}" pattern="yyyy.MM.dd"/></span>
					</div>
					<a href="/ht/product/detail?barcode=${brData.sellPrdtBcode}"></a>
				</div>
			</c:if>
		</c:if>
		<!--// 쿠폰존 배너 -->		
	</div>
	<div class="new_event<c:if test="${c.tabType == 'BP'}"> brand_coupon type01</c:if><c:if test="${c.tabType == 'BR'}"> brand_coupon type02</c:if>">
		<div class="pd_filter">
			<p class="pd_total">
				<c:choose>
					<c:when test="${c.tabType == 'BR'}">
						<em class="font_t"><fmt:formatNumber type="number" value="${totalCnt}"/></em>개
					</c:when>
					<c:when test="${c.tabType == 'BP'}">
						쿠폰적용상품 <em class="font_t"><fmt:formatNumber type="number" value="${totalCnt}"/></em>개
					</c:when>
					<c:otherwise>
						<em class="font_t"><fmt:formatNumber type="number" value="${totalCnt}"/></em>건
					</c:otherwise>
				</c:choose>
			</p>
			<c:if test="${c.tabType == 'PD' or c.tabType == 'BP'}">
				<div class="form_select">
					<select id="orderBySelect" onchange="location.href='/ht/biz/mypage/nowDownloadCoupon?productOrderBy='+this.value+'&tabType=${c.tabType}&brandId=${c.brandId}';">
						<option value="R"<c:if test="${empty c.productOrderBy or c.productOrderBy eq 'R'}"> selected="selected"</c:if>>최근순</option>
						<option value="T"<c:if test="${c.productOrderBy eq 'T'}"> selected="selected"</c:if>>할인율순</option>
						<option value="P"<c:if test="${c.productOrderBy eq 'P'}"> selected="selected"</c:if>>인기순</option>
						<option value="L"<c:if test="${c.productOrderBy eq 'L'}"> selected="selected"</c:if>>낮은가격순</option>
						<option value="H"<c:if test="${c.productOrderBy eq 'H'}"> selected="selected"</c:if>>높은가격순</option>
					</select>
				</div>
			</c:if>
		</div>
		<c:choose>
			<c:when test="${c.tabType == 'BR'}">
				<div class="coupon_list">
					<ul class='clear'>
						<c:forEach items="${list}" var="l" varStatus="st">
							<li>
								<div class="img_zone">
									<c:if test='${not empty l.brandImageC0292}'>
										<ui:image src="${l.brandImageC0292}" server="brand" alt="${l.brandName}"/>
									</c:if>
									<c:if test='${empty l.brandImageC0292}'>
										<img src="/images/biz/sub/benefit/img_brand.png" alt="${l.brandName}">
									</c:if>	
								</div>
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
								<em>적용 상품보기</em>
								<a href="javascript:;" onclick="location.href='/ht/biz/mypage/nowDownloadCoupon?tabType=BP&brandId=${l.brandId}'"></a>
							</li>
						</c:forEach>
					</ul>
				</div>
			</c:when>
			<c:when test="${c.tabType == 'PM'}">
				<div class="event_banner">
					<ul>
						<c:forEach items="${list}" var="l" varStatus="st">
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
								</a>
							</li>
						</c:forEach>
					</ul>
				</div>
			</c:when>
			<c:otherwise>
				<!-- 상품 type1 -->
				<div class="pd_list dvd">
					<ul>
						<!-- prod -->
						<c:import url="/pages/bizFront/template/bizLayerProduct.jsp" charEncoding="UTF-8">
							<c:param name="paramList" value="list"/>
						</c:import>
						<!-- //prod -->
					</ul>
				</div>
				<!--// 상품 -->
			</c:otherwise>
		</c:choose>
		
		<!-- pagination -->
		<c:if test="${c.tabType != 'PM'}">
			<div class="pagination_v2">	        	   
	           <ui:bizPagination name="pageHolder" url="?" parameters="productOrderBy"/>
	       	</div>
       	</c:if>
		<!--// pagination -->
	</div>
</div>