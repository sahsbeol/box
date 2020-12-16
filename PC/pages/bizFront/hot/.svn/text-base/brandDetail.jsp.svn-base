<%@ page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<!-- 태그 라이브러리 -->
<%@ include file="/pages/decorators/biz/tagHeader.jsp" %>

<!--  SNS 공유 내용 -->
<meta property="og:type" content="website"/>
<meta property="og:title" content="${brand.brandEngName}"/>
<meta property="og:url" content="${defaultHost}/ht/hot/brandDetail?brandId=${brand.brandId}"/>
<meta property="og:image" content="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/renewal/common/logo_over.gif"/>

<script type="text/javascript">
	$(document).ready(function() {
		obj.init();		
	});
	
	var obj = {
		init : function(){
			brandTit();//titArrow
			
			$("#width_option").html($('#resizing_select option:selected').text());
	        $("#resizing_select").width($("#width_select").width());
			
			if($('.event_list .swiper-container').length > 0){
				eventFn();//slide
			}
		}
	};
	
	jQuery(function($){
	    $("img.lazy").lazyload({placeholder:'/images/no_image2.gif',effect : "fadeIn"});
	    
	    $(".like_img").show();
	});
	function goList(page){
	    location.href="?brandId=${c.brandId}&ctgrId=${c.ctgrId}&productOrderBy=${c.productOrderBy}&page="+page;
	}
</script>

<div id="content">
	<div class="brand_wrap category_wrap">
		<div class="topTit_brand clear">
			<div class="tit_round<c:if test='${not empty brand.brandImageUrl}'> img</c:if>"><!-- 이미지가 있으면, tit_round에 img : class 추가 -->
				<c:if test='${not empty brand.brandImageUrl}'>
					<ui:image src="${brand.brandImageUrl}" server="brand" alt="${brand.brandName}"/>
				</c:if>
			</div>
			<div class="tit_brand">
				<h2 class='brand_en'>${brand.brandEngName}</h2>
				<p class='h2_line'></p>
				<h3 class='brand_ko'>${brand.brandName}</h3>
				<p class='h3_line'></p>
			</div>
			<div class="tit_like">
				<a href="javascript:" id="${brand.brandId}" onclick="addBizWishBrand('${brand.brandId}')" class='btn_like<c:if test="${brand.wishUserBrandCnt ne '0'}"> on</c:if>'><!-- 활성화시 on : class 추가 -->
					<i></i>
					<c:set var="wishBrandCnt" value="${brand.wishBrandCnt}"/>	
					<c:if test="${brand.wishBrandCnt > 999}"><c:set var="wishBrandCnt" value="999+"/></c:if>
					<span class='font_t brandTxt' code="${brand.brandId}">${wishBrandCnt}</span>
				</a>
			</div>
			<div class="tit_text">
				<p class=''>${brand.brandDesc}</p>
			</div>
			<div class="tit_arr">
				<a href="javascript:"><img src="/images/biz/sub/icon_select_arrow.png" alt="더보기"></a>
			</div>
		</div>

		<!-- //////이벤트 영역////// -->
		<c:if test="${not empty eventList}">
			<div class="event_list <c:if test='${fn:length(eventList) == 1}'>case1</c:if><c:if test='${fn:length(eventList) > 1}'>case2</c:if>"><!-- 이미지 1개는 case1, 그 이상 case2 : class 추가 -->
				<div class="event_top">
					<c:choose>
						<c:when test='${fn:length(eventList) > 1}'>
							<div class="swiper-container"><!-- 이미지가 2개 이상인 경우 -->
								<div class="swiper-wrapper">
									<c:forEach items="${eventList}" var="l">
										<div class="swiper-slide">
											<a href="/m/hot/eventDetail?eventId=${l.eventId}">
												<div class="thum">
													<ui:image src="${l.eventImageUrl}" alt="${l.eventTitle}"/>
												</div>
												<c:if test="${not empty l.discRate && l.discRate > 0}">
					                       			<span class="font_t percent">${l.discRate}%</span>
					                       		</c:if>
												<strong>${l.eventTitle}</strong>
												<p>${l.eventDtlCont}</p>
											</a>
										</div>
									</c:forEach>
								</div>
								<!-- 스크롤바 -->
								<div class="swiper-scrollbar"></div>
							</div>
						</c:when>
						<c:otherwise>
							<div class="event_banner"><!-- 이미지가 1개인 경우 -->
								<ul>
									<li>
										<c:forEach items="${eventList}" var="l">
											<a href="/m/hot/eventDetail?eventId=${l.eventId}">
												<div class="thum">
													<ui:image src="${l.eventImageUrl}" alt="${l.eventTitle}"/>
												</div>
												<c:if test="${not empty l.discRate && l.discRate > 0}">
					                       			<span class="font_t percent">${l.discRate}%</span>
					                       		</c:if>
												<strong>${l.eventTitle}</strong>
												<p>${l.eventDtlCont}</p>
											</a>
										</c:forEach>
									</li>
								</ul>
							</div>
						</c:otherwise>
					</c:choose>	
				</div>
				
				<c:if test='${fn:length(eventList) > 1}'>
					<!-- swiper-pagination -->
					<div class="pagination_wrap">
						<div class="swiper-pagination"></div>
					</div>
				</c:if>
			</div>
		</c:if>
		<!-- //이벤트 영역 -->

		<div class="choice_wrap">
			<select id="resizing_select" name="ctgrId" class='tit_sales' title="상품 분류 선택" onchange="location.href='/m/biz/hot/brandDetail?brandId=${c.brandId}&productOrderBy=${c.productOrderBy}&ctgrId='+this.value;">
				<option value="">전체</option>
	            <c:forEach items="${listCateogry}" var="l" varStatus="st">
	                <option value="${l.ctgrId}"<c:if test="${c.ctgrId eq l.ctgrId}"> selected="selected"</c:if>>${l.ctgrName}</option>
	            </c:forEach>
			</select>
			<select id="width_select">
			  <option id="width_option"></option>
			</select>
			<div class="pd_filter">
				<p class="pd_total"><em class="font_t">${pageHolder.totalRows}</em>건</p>
				<div class="form_select">
					<select name="productOrderBy" title="정렬 순서 선택" onchange="location.href='/m/biz/hot/brandDetail?brandId=${c.brandId}&ctgrId=${c.ctgrId}&productOrderBy='+this.value;">
						<option value="R"<c:if test="${c.productOrderBy eq 'R'}"> selected="selected"</c:if>>신상품순</option>
						<option value="P"<c:if test="${c.productOrderBy eq 'P'}"> selected="selected"</c:if>>판매량순</option>
						<option value="L"<c:if test="${c.productOrderBy eq 'L'}"> selected="selected"</c:if>>낮은가격순</option>
			            <option value="H"<c:if test="${c.productOrderBy eq 'H'}"> selected="selected"</c:if>>높은가격순</option>
			            <option value="T"<c:if test="${c.productOrderBy eq 'T'}"> selected="selected"</c:if>>높은할인율순</option>
			            <option value="W"<c:if test="${c.productOrderBy eq 'W'}"> selected="selected"</c:if>>좋아요순</option>
			            <option value="C"<c:if test="${c.productOrderBy eq 'C'}"> selected="selected"</c:if>>상품평순</option>   
					</select>
				</div>
			</div>
		</div>

		<!-- 제품 -->
		<!-- prod -->
        <c:import url="../template/bizLayerProduct.jsp" charEncoding="UTF-8">	  
        	<c:param name="lazy" value="Y"/>          
        </c:import>
        <!-- //prod -->
		<!--// 제품 -->

		<div class="pagination">	        	   
           <ui:bizpaginationScript name="pageHolder" scriptName="goList"/>
       </div>		
	</div>
</div>