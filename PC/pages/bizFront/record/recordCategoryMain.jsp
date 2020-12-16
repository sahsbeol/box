<%@page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<!-- 태그 라이브러리 -->
<%@ include file="/pages/decorators/biz/tagHeader.jsp" %>
<!DOCTYPE ui:decorator PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
 response.setHeader("Cache-Control","no-store");
%>
<head>
<c:set var="ctgrName"><ui:category id="${c.ctgrId}" full="false"/></c:set>
<title>${ctgrName} - HOTTRACKS</title>
﻿
<!-- 데이타 스토리  script start-->
<script type="text/javascript">
_n_p1='${cate1DepthLoc.cateName}'.trim(); 			// 대카테고리명
_n_p2='${cate2DepthLoc.cateName}'.trim(); 			// 중카테고리명
_n_p3='${cate3DepthLoc.cateName}'.trim(); 			// 소카테고리명 
_n_p4='${cate4DepthLoc.cateName}'.trim(); 			// 세카테고리명
</script>	
<!-- 데이타 스토리  script end-->

<script type="text/javascript">
var categorySwiper02 = null;
var categorySwiper03 = null;

$(document).ready(function() {
	setTimeout(function(){
		$(".category_banner_wrap").attr("style","visibility: visible;");
    },100);
	
	
	$('.category_banner').on('init reInit afterChange', function(event, slick, currentSlide, nextSlide){
	    var i = (currentSlide ? currentSlide : 0) + 1;
	    $('.category_banner_wrap .custom_paging').html('<strong>'+ i + '</strong>'+ slick.slideCount);
	});
	
	var categorySwiper = $('.category_banner').slick({
		slidesToShow: 1,
		slidesToScroll: 1,
		autoplay: true,
		speed: 1000,
		centerMode: true,
		arrows: true,
		infinite: true,
		centerPadding: '485px',
		variableWidth: true,
		variableHeight: true,
		dots: false,
		swipe: false,
	});	
	
	var cateDepthInfo = "${cateDepthInfo}";
	if("1" == cateDepthInfo){
		loadRecordTemplate("preOrder","kpop","N");		// 예약상품
		loadRecordTemplate("newReleases","kpop","N");		// 새로 나온 상품	
	}
	
	// 예약상품 [가요/팝/클래식] active 처리
	$('.pd_unit02 .category_tab a').click(function(){		
        $(this).parents('.pd_unit').find('.category_tab ul li').removeClass('active');
        $(this).parents('li').addClass('active');
	    
	    return false;
	});
	
	// 새로 나온 상품 [가요/팝/클래식] active 처리
	$('.pd_unit03 .category_tab a').click(function(){		
        $(this).parents('.pd_unit').find('.category_tab ul li').removeClass('active');
        $(this).parents('li').addClass('active');
	    
	    return false;
	});	
	
	// 상품 리스트 필터 처리
	$('.pd_filter .tag_list li').click(function(){	        
		$(this).toggleClass('active');        
		
		if($(this).hasClass('active')){
			$(this).find('input').prop('checked', true);	
		}else{
			$(this).find('input').prop('checked', false);
		}
		
		var strTmp = "?ctgrId=${c.ctgrId}&page=1";
		var strId = "";
		                
		var len = $('div#searchcdt li').length;
		for(var i=0; i<len; i++){
			if($('div#searchcdt li:eq('+i+')').hasClass("active")){
				strId = $('div#searchcdt li:eq('+i+')').attr('id');				
		    	strTmp += "&"+strId+"=Y"; 
		    }else{
		    	strId = $('div#searchcdt li:eq('+i+')').attr('id');
		    	strTmp += "&"+strId+"=N";
		    }
		}
						
		strTmp += "&productOrderBy="+"${c.productOrderBy}";		
		location.href=strTmp;
		
		return false;
	});
	
	$('.category_wrap .tag_list ul li').on('click', function(){
		if($(this).hasClass('active')){
			$(this).removeClass('active');
		}else{
			$(this).addClass('active');
		}
	});
	
	// 베스트 리스트
	var categorySwiper04 = $('.category_wrap .pd_unit04 .category_slide ul').bxSlider({
		auto: false,
		pause: 3000,
		speed: 1000,
		hideControlOnEnd: true,
		minSlides: 4,
		maxSlides: 4,
        slideWidth: 215,
		slideMargin: 30,
		infiniteLoop: false,
		touchEnabled: false,
		pager: true,
		pagerType: 'short',
		pagerShortSeparator: '',
	});	
});

// 예약상품 [가요/팝/클래식] 조회
function loadRecordTemplate(listGbn, genre, clickGbn){	// listGbn : [예약상품, 새로나온 상품], genre : [가요, 팝, 클래식]   
	var ctgrId = "${c.ctgrId}";
	if(clickGbn != "N"){
		if ($(clickGbn).parents().hasClass("active")) {
			return false;
		}
	}
	$.ajax({
        type: "POST"
        ,url: "/ht/biz/record/getRecordTemplate"
        ,data: {  ctgrId : ctgrId, listGbn : listGbn, genre : genre }
        ,dataType: "html"
        ,success : function(data){            
        	
        	if("preOrder" == listGbn){
        		$("#preOrderList").empty();
            	$("#preOrderList").append(data);
            	
            	if(categorySwiper02 != null) {                    
                    //맨 앞으로 스와이퍼 이등
                    categorySwiper02.goToSlide(1);
                    //스와이퍼 삭제 
            		categorySwiper02.destroySlider();                    
    			}
            	
            	categorySwiper02 = $('.category_wrap .pd_unit02 .category_slide ul').bxSlider({
            		auto: false,
            		pause: 3000,
            		speed: 1000,
            		hideControlOnEnd: true,
            		minSlides: 4,
            		maxSlides: 4,
                    slideWidth: 215,
            		slideMargin: 30,
            		infiniteLoop: false,
            		touchEnabled: false,
            		pager: true,
            		pagerType: 'short',
            		pagerShortSeparator: '',
            	});            
            	$(".bx-pager-link").attr("style","color:#2b2e3d;");

        	}else{
        		$("#newReleases").empty();
            	$("#newReleases").append(data);
            	
            	if(categorySwiper03 != null) {
            		//맨 앞으로 스와이퍼 이등
                    categorySwiper03.goToSlide(1);
                    //스와이퍼 삭제 
            		categorySwiper03.destroySlider();
    			}

            	categorySwiper03 = $('.category_wrap .pd_unit03 .category_slide ul').bxSlider({
            		auto: false,
            		pause: 3000,
            		speed: 1000,
            		hideControlOnEnd: true,
            		minSlides: 3,
            		maxSlides: 3,
                    slideWidth: 310,
            		slideMargin: 10,
            		infiniteLoop: false,
            		touchEnabled: false,
            		pager: true,
            		pagerType: 'short',
            		pagerShortSeparator: '',
            	});  
            	$(".bx-pager-link").attr("style","color:#2b2e3d;");
        	}        	        	        	
        }
    });	
}	
</script>
</head>
<body>
<script type="text/javascript">
	$('#content').addClass('category_wrap');
</script>
<!-- 배너 -->
<c:if test="${not empty depth1BrnList}">
	<div class="category_banner_wrap" style="visibility:hidden;">
		<div class="category_banner">			
			<c:forEach items="${depth1BrnList}" var="l" varStatus="st">
				<c:choose>
					<c:when test="${l.signWayGbn == 'C1451'}">
						<div class="slide-item type01">
							<a href="javascript:;" onclick="location.href='${l.bnrLinkUrl}';return false;">
								<ui:image src="${l.imageUrlPc}" alt="${l.imageAlt}"/>						
							</a>
						</div>											
					</c:when>
					<c:otherwise>
						<div class="slide-item type02">
							<a href="javascript:;" onclick="location.href='${l.bnrLinkUrl}';return false;">
								<ui:image src="${l.imageUrlPc}" alt="${l.imageAlt}"/>
								<div class="desc">
									<p class="tit">${l.mainText}</p>
									<c:if test="${l.signWayGbn eq 'C1453'}">
										<p class="txt">${l.subText}</p>
									</c:if>	
								</div>
							</a>
						</div>
					</c:otherwise>
				</c:choose>	
			</c:forEach>							
		</div>
		<div class="custom_paging_wrap">
			<div class="custom_paging"></div>
		</div>		
	</div>
</c:if>
<!--// 배너 -->

<div class="lower_content">
	<!-- location -->
	<div class="location_wrap">
		<button type="button" class="btn_home" onclick="location.href='${defaultHost}/ht/biz/welcomeMain'">홈으로</button>
		<c:if test="${not empty cate1DepthList}">
			<div class="location_nav_wrap">
				<a href="/ht/biz/record/recordCategoryMain?ctgrId=${cate1DepthLoc.cateId}" class="location_1 <c:if test="${cateDepthInfo eq '1'}">on</c:if>">${cate1DepthLoc.cateName}</a>
				<ul class="location_nav">	
					<c:forEach items="${cate1DepthList}" var="l" varStatus="st">				
						<li><a href="/ht/biz/gift/giftCategoryMain?ctgrId=${l.cateId}">${l.cateName}</a></li>            		       		
					</c:forEach>
					<li><a href="/ht/biz/record/recordCategoryMain?ctgrId=0003">CD/LP</a></li>
					<li><a href="/ht/biz/eventDetail?eventId=47389">직수입/PB</a></li>
					<li><a href="/ht/biz/record/dvdCategoryMain?ctgrId=000401">DVD/BLU-RAY</a></li>	
				</ul>	
			</div>		
		</c:if>
	
		<c:if test="${not empty cate2DepthList}">
			<div class="location_nav_wrap">
				<a href="/ht/biz/record/recordCategoryMain?ctgrId=${cate2DepthLoc.cateId}" class="location_1 <c:if test="${cateDepthInfo eq '2'}">on</c:if>">${cate2DepthLoc.cateName}</a>
				<ul class="location_nav">	
					<c:forEach items="${cate2DepthList}" var="l" varStatus="st">				
						<li><a href="/ht/biz/record/recordCategoryMain?ctgrId=${l.cateId}">${l.cateName}</a></li>            		       		
					</c:forEach>
				</ul>	
			</div>		
		</c:if>
	
		<c:if test="${not empty cate3DepthList}">
			<div class="location_nav_wrap">
				<a href="/ht/biz/record/recordCategoryMain?ctgrId=${cate3DepthLoc.cateId}" class="location_1 <c:if test="${cateDepthInfo eq '3'}">on</c:if>">${cate3DepthLoc.cateName}</a>
				<ul class="location_nav">	
					<c:forEach items="${cate3DepthList}" var="l" varStatus="st">				
						<li><a href="/ht/biz/record/recordCategoryMain?ctgrId=${l.cateId}">${l.cateName}</a></li>            		       		
					</c:forEach>
				</ul>	
			</div>		
		</c:if>	
		
	</div>
	<!--// location -->
	
	<h2 class="sub_title">${subCategory.cateName}</h2>
	<div class="category_list">
		<ul>
			<li><a href="javascript:;" class="all" <c:if test="${lastDepthYn eq 'N'}">style="color:#DA2128;"</c:if>>전체보기</a></li>
			
			<c:if test="${not empty subCateList}">
				<c:forEach items="${subCateList}" var="l" varStatus="st">
					<li><a href="/ht/biz/record/recordCategoryMain?ctgrId=${l.cateId}" <c:if test="${c.ctgrId eq l.cateId}">style="color:#DA2128;"</c:if>>${l.cateName}</a></li>				
				</c:forEach>
			</c:if>		
		</ul>
		<c:if test="${c.ctgrId eq '0003'}">
			<div class="type02">
				<ul>
					<li><a href="/ht/record/bestList/0003?bestRangeType=C1002" target="_blank">베스트</a></li>
					<li><a href="/ht/record/newRecord/0003" target="_blank">새로나온상품</a></li>
					<li><a href="/ht/record/reserve/0003" target="_blank">예약상품</a></li>
					<li><a href="/ht/record/lp" target="_blank">LP SHOP</a></li>
					<li><a href="/ht/record/audio" target="_blank">AUDIO FILE</a></li>
					<li><a href="/ht/search/searchDetail/Record" target="_blank">음반 상세 검색</a></li>				
				</ul>
			</div>		
		</c:if>	
	</div>
	
	<c:if test="${cateDepthInfo eq '1'}">
		<!-- 예약상품 -->
		<div class="pd_unit pd_unit02">
			<h3 class="category_tit">예약상품</h3>
			<div class="category_tab">
				<ul>
					<li class="active"><a href="javascript:;" onclick="loadRecordTemplate('preOrder','kpop',this); return false;">가요</a></li>
					<li><a href="javascript:;" onclick="loadRecordTemplate('preOrder','pop',this); return false;">팝</a></li>
					<li><a href="javascript:;" onclick="loadRecordTemplate('preOrder','classic',this); return false;">클래식</a></li>
				</ul>
			</div>
			
			<div class="category_slide">
				<ul id="preOrderList">
				</ul>
			</div>		
		</div>
		<!--// 예약상품 -->
		
		<!-- 최근발매 -->
		<div class="pd_unit pd_unit03">
			<h3 class="category_tit">새로 나온 상품</h3>
			<div class="category_tab">
				<ul>
					<li class="active"><a href="javascript:;" onclick="loadRecordTemplate('newReleases','kpop',this); return false;">가요</a></li>
					<li><a href="javascript:;" onclick="loadRecordTemplate('newReleases','pop',this); return false;">팝</a></li>
					<li><a href="javascript:;" onclick="loadRecordTemplate('newReleases','classic',this); return false;">클래식</a></li>
				</ul>
			</div>
			<div class="category_slide">
				<ul id="newReleases">
				</ul>
			</div>
		</div>
		<!--// 최근발매 -->
	</c:if>
	
	<!-- 베스트 -->
	<c:if test="${empty bestSellers }"><c:set var="bestSellers" value="${bestSellersNone}"/><div id="${bestSellersNone}"> </div></c:if>
	<c:if test="${not empty bestSellers }">	
		<div class="pd_unit pd_unit04">
			<h3 class="category_tit">베스트</h3>
			<div class="category_slide">		
				<ul>						
				<c:forEach items="${bestSellers}" var="l" varStatus="st">					
					<!-- 이미지 원형인 경우 round : class 추가 -->
					<li class="<c:if test="${l.rcrdStat eq '2'}">sold_out-t-m</c:if><c:if test="${l.rcrdStat eq '3' || l.rcrdStat eq '4'}">sold_out-m</c:if>">
						<c:choose>
							<c:when test="${l.rcrdStat eq '2' || l.rcrdStat eq '3' || l.rcrdStat eq '4'}">
								<a href="/ht/record/detail/${l.sellPrdtBcode}" title="${l.rcrdName}">
									<div class="thum">
										<ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" width="${l.sellPrdtGbn eq 'R'?'145':'95'}" alt="${l.prdtName}" ratingCode="A" />
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
								<a href="/ht/record/detail/${l.sellPrdtBcode}" title="${l.rcrdName}">
									<div class="thum">
										<ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" width="${l.sellPrdtGbn eq 'R'?'145':'95'}" alt="${l.prdtName}" ratingCode="A" />
									</div>
								</a>
							</c:otherwise>
						</c:choose>
						<!-- 클릭시 active : class 추가 -->					
						<a href="javascript:" onclick="addBizWishProduct(this);return false;" class="btn_like<c:if test="${l.wishUserPrdtCnt > 0}"> active</c:if>" prdtId="${l.sellPrdtBcode}"><span>좋아요</span></a>					
						<a href="/ht/record/detail/${l.sellPrdtBcode}">
							<div class="cont">
								<p class="brand">${l.artiName}</p>
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
									<c:if test="${l.hasPosterCaseYn eq 'Y'}"><span class="badge01">포스터</span></c:if>
									<c:if test="${fn:substring(l.prdtIcon,0,1) eq '1'}"><span class="badge01">쿠폰</span></c:if>
									<c:if test="${l.impYn eq 'Y'}"><span class="badge02">수입</span></c:if>
									<c:if test="${l.rcrdStat eq '9'}"><span class="badge02">예약</span></c:if>								
									<c:if test="${l.rcrdStat eq '2'}"><span class="badge02">일시품절</span></c:if>
									<c:if test="${l.rcrdStat eq '3' || l.rcrdStat eq '4'}"><span class="badge02">품절</span></c:if>							
								</div>
							</div>
						</a>
					</li>				
				</c:forEach>											
				</ul>			
			</div>
		</div>
		<!--// 베스트 -->
	</c:if>
	
	<div class="tab">
		<ul class="col05">
			<c:set var="baseLink" value="?ctgrId=${c.ctgrId}&page=1&saleYn=${c.saleYn}&freeDlvYn=${c.freeDlvYn}&hotDlvYn=${c.hotDlvYn}&cpYn=${c.cpYn}&dcYn=${c.dcYn}&rsvYn=${c.rsvYn}"/>
			<li <c:if test="${c.productOrderBy eq 'R'}"> class="active"</c:if>><a href="${baseLink}&productOrderBy=R"><span>신상품순</span></a></li>
			<li <c:if test="${c.productOrderBy eq 'P'}"> class="active"</c:if>><a href="${baseLink}&productOrderBy=P"><span>판매량순</span></a></li>
			<c:if test="${c.ctgrId ne '0003'}">
			<li <c:if test="${c.productOrderBy eq 'L'}"> class="active"</c:if>><a href="${baseLink}&productOrderBy=L"><span>낮은가격순</span></a></li>
			<li <c:if test="${c.productOrderBy eq 'H'}"> class="active"</c:if>><a href="${baseLink}&productOrderBy=H"><span>높은가격순</span></a></li>
			<li <c:if test="${c.productOrderBy eq 'T'}"> class="active"</c:if>><a href="${baseLink}&productOrderBy=T"><span>높은할인율순</span></a></li>
			</c:if>		
		</ul>
	</div>
	
	<div class="pd_filter">
		<p class="pd_total"><!-- <em class="font_t"><fmt:formatNumber type="number">${totalListCount}</fmt:formatNumber></em>건의 검색결과 --></p>
		<div class="tag_list" id="searchcdt">
			<ul>
				<li id="saleYn" <c:if test="${c.saleYn eq 'Y'}">class="active"</c:if>>
					<label class="form_checkbox">
						<input type="checkbox" <c:if test="${c.saleYn eq 'Y'}">checked="checked"</c:if>>
						<span class="icon">품절포함</span>
					</label>
				</li>
				<c:if test="${c.ctgrId ne '0003'}">
				<li id="freeDlvYn" <c:if test="${c.freeDlvYn eq 'Y'}">class="active"</c:if>>
					<label class="form_checkbox">
						<input type="checkbox" <c:if test="${c.freeDlvYn eq 'Y'}">checked="checked"</c:if>>
						<span class="icon">무료배송</span>
					</label>
				</li>
				<li id="hotDlvYn" <c:if test="${c.hotDlvYn eq 'Y'}">class="active"</c:if>>
					<label class="form_checkbox">
						<input type="checkbox" <c:if test="${c.hotDlvYn eq 'Y'}">checked="checked"</c:if>>
						<span class="icon">핫트랙스배송</span>
					</label>
				</li>
				<li id="cpYn" <c:if test="${c.cpYn eq 'Y'}">class="active"</c:if>>
					<label class="form_checkbox">
						<input type="checkbox" <c:if test="${c.cpYn eq 'Y'}">checked="checked"</c:if>>
						<span class="icon">쿠폰</span>
					</label>
				</li>
				<li id="dcYn" <c:if test="${c.dcYn eq 'Y'}">class="active"</c:if>>
					<label class="form_checkbox">
						<input type="checkbox" <c:if test="${c.dcYn eq 'Y'}">checked="checked"</c:if>>
						<span class="icon">할인</span>
					</label>
				</li>
				<li id="rsvYn" <c:if test="${c.rsvYn eq 'Y'}">class="active"</c:if>>
					<label class="form_checkbox">
						<input type="checkbox" <c:if test="${c.rsvYn eq 'Y'}">checked="checked"</c:if>>
						<span class="icon">예약</span>
					</label>
				</li>
				</c:if>
			</ul>
		</div>
	</div>
	
	<c:if test="${not empty productList }">
		<!-- 상품 -->
		<div class="pd_list">
			<ul>
				<c:forEach items="${productList}" var="l" varStatus="st">							
					<li <c:if test="${l.saleYn ne 'Y'}"><c:choose><c:when test="${l.rcrdStat eq '3' || l.rcrdStat eq '4'}">class="sold_out-m"</c:when><c:otherwise>class="sold_out-t-m"</c:otherwise></c:choose></c:if>>
						<c:choose>
							<c:when test="${l.saleYn ne 'Y'}">
								<a href="/ht/record/detail/${l.sellPrdtBcode}" title="${l.rcrdName}">
									<div class="thum">
										<ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" ratingCode="${l.rtngCode }" rcrdImgType="large" height="96" alt="${l.rcrdName}" />
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
								<a href="/ht/record/detail/${l.sellPrdtBcode}" title="${l.rcrdName}">
									<div class="thum">
										<ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" ratingCode="${l.rtngCode }" rcrdImgType="large" height="96" alt="${l.rcrdName}" />											
									</div>
								</a>
							</c:otherwise>
						</c:choose>
						<!-- 클릭시 active : class 추가 -->					
						<a href="javascript:" onclick="addBizWishProduct(this);return false;" class="btn_like<c:if test="${l.wishUserPrdtCnt > 0}"> active</c:if>" prdtId="${l.sellPrdtBcode}"><span>좋아요</span></a>
						<a href="/ht/record/detail/${l.sellPrdtBcode}">
							<div class="cont">
								<p class="brand">${l.artiName}</p>
								<p class="tit">${l.rcrdName}</p>
								<p class="price font_t">
									<c:if test="${l.saleYn eq 'Y' && l.prdtSellPrice > l.lastDcPrice}"><span class="percent"><fmt:parseNumber integerOnly="true" value="${hfn:rate(l.prdtSellPrice, l.lastDcPrice)}"/>%</span></c:if>
									<span><fmt:formatNumber value="${l.lastDcPrice}" pattern="#,###"/></span>
									<c:if test="${l.prdtSellPrice > l.lastDcPrice}"><span class="discount"><fmt:formatNumber value="${l.prdtSellPrice}" pattern="#,###"/></span></c:if>										
								</p>
								<div class="badge">								
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
		<!--//상품 -->
	</c:if>
	<div class="pagination_v2"><ui:bizPagination name="pageHolder" url="/ht/biz/record/recordCategoryMain?" parameters="ctgrId,productOrderBy,saleYn,freeDlvYn,hotDlvYn,cpYn,dcYn,rsvYn"/></div>
	<c:import url="/menu/biz/quickMenu"/>
</div>
</body>
</html>