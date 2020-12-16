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
<!-- <script type="text/javascript" src="/js/biz/jquery/jquery.bxslider.min.js"></script> -->
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

	loadTemplate("recobell");	// 레코벨, 베스트, 할인 상품 조회
	
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
	
	// 레코벨, 베스트, 할인 상품 active 처리
	$('.pd_unit .tab a').click(function(){	
        $(this).parents('.pd_unit').find('.tab ul li').removeClass('active');
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
	
	// 상품 조회 필터 active 처리
	$('.category_wrap .tag_list ul li').on('click', function(){
		if($(this).hasClass('active')){
			$(this).removeClass('active');
		}else{
			$(this).addClass('active');
		}
	});
	
	$('.btn_fullmore').click(function(){
		$('.layer_fullban').addClass('active');
		$('html,body').addClass('noscroll');
	});
	$('.btn_fullclose').click(function(){
		$('.layer_fullban').removeClass('active');
		$('html,body').removeClass('noscroll');
	});
});

// 추천 / 베스트 / 할인 상품 조회
function loadTemplate(rbsNm){
	
	var ctgrId = "${subCategory.cateId}";
	
	$.ajax({
        type: "POST"
        ,url: "/ht/biz/gift/getRecobellTemplate"
        ,data: {  ctgrId : ctgrId, reqParam : rbsNm }
        ,dataType: "html"
        ,success : function(data){            
        	
        	$("#RBSList").empty();
        	$("#RBSList").append(data);
        	
        	if(categorySwiper02 != null) {
                //맨 앞으로 스와이퍼 이등
                categorySwiper02.goToSlide(1);
                //스와이퍼 삭제 
        		categorySwiper02.destroySlider();
			}
        	
        	categorySwiper02 = $('.category_wrap .pd_unit01 .category_slide ul').bxSlider({
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
        	        	
        }
    });
}	

function replaceBtn(bcode){
	$fn.setRecobellRelationList(bcode);
	$('.dim, .replace-modal').css('visibility','visible');
}
$(function(){
    $('.replace-modal .close-btn').click(function(){
        $fn.init();
    	$('.dim, .replace-modal').css('visibility','hidden');
    });
});

$fn = {
		init:function(){
			$('#recobellRelationList').empty();
			
		}
		

		, setRecobellRelationList:function(bcode) {
			
			$.ajax({
				url: "/ht/biz/personal/getRecobellRelationList"
				, data: {
					code : bcode
				}
				, type:"POST"
		        ,dataType: "json"
		        ,success : function(data){
		        	var append = "";
		           	$('#recobellRelationList').empty();
		        	
		            if (data) {
		                if(!isEmpty(data)) {
							var list = data.recobellRelationList;
							if(!isEmpty(list)) {
								for(var i=0; i < list.length; i++) {
									var rate = 0;
									/* rate = 100 - Math.ceil(((list[i].lastCpnPrice / list[i].prdtSellPrice) * 100)); */
									rate = ((list[i].prdtSellPrice - list[i].lastCpnPrice) / list[i].prdtSellPrice) * 100;
									rate = Math.round(rate * 10);
									rate = Math.floor(rate / 10);
									append += '	<li>';
									append += '	<a href="/p/'+list[i].sellPrdtBcode+'?foo=bar&rccode=pc_soldout">';
									append += '		<div class="thum">';
									if(list[i].sellPrdtGbn == 'R' || list[i].sellPrdtGbn == 'D'){
				                	    append += '		<img src="http://image.kyobobook.co.kr/newimages/music/midi/'+list[i].rcrdCd.substring( 1, 5 ).split("").reverse().join("")+'/'+list[i].rcrdCd+'.jpg" alt="'+list[i].prdtName+'" class="photo" >';
			                	    }else{
				                	    append += '		<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/goods/400/'+list[i].productImageUrl+'" alt="'+list[i].prdtName+'" class="photo" onerror="this.src=\'http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/no_image2.gif\';">';
			                	    }
									append += '		</div>';
									append += '	</a>';
									if(list[i].wishUserPrdtCnt > 0){
										append += '	<a href="javascript:" onclick="addBizWishProduct(this);return false;" class="btn_like active" prdtId="'+list[i].sellPrdtBcode+'">';
									}else{
										append += '	<a href="javascript:" onclick="addBizWishProduct(this);return false;" class="btn_like" prdtId="'+list[i].sellPrdtBcode+'">';
									}
									append += '		<span>'+'좋아요'+'</span>';
									append += '	</a>';
									append += '	<a href="/ht/product/detail?barcode='+list[i].sellPrdtBcode+'">';
									append += '	<div class="cont">';
									append += '		<p class="brand">'+list[i].brandName+'</p>';
									append += '		<p class="tit">'+list[i].prdtName+'</p>';
									append += '		<p class="price font_t">';
									if(rate != 0){
				                	    append += '				<span class="percent">'+rate+'%</span>';
			                	    }
									append += '					<span>'+price_format(list[i].lastCpnPrice)+'</span>';
									if(rate != 0){
										append += '					<span class="discount">'+price_format(list[i].prdtSellPrice)+'</span>';
			                	    }
									append += '		</p>';
									append += ' <div class="info">';
									if(list[i].reviewCount > 999){
										append += '<span class="reply">'+'999+'+'</span>';
									}else{
										append += '<span class="reply">'+list[i].reviewCount+'</span>';
									}
									if(list[i].wishPrdtCnt > 999){
										append += '<span class="like">'+'999+'+'</span>';
									}else{
										append += '<span class="like">'+list[i].wishPrdtCnt+'</span>';
									}
									append += ' </div>';
									append += ' <div class="badge">';
										if(list[i].prdtStatCode != 'C0312'){
											if(list[i].prdtStatCode == 'C0313'){
												append += ' <span class="badge03">'+'일시품절'+'</span>';
											}
											if(list[i].prdtStatCode != 'C0313'){
												append += ' <span class="badge03">'+'품절'+'</span>';
											}
										}else{
											if(list[i].prdtIcon.substring(0,1) == '1'){
												append += ' <span class="badge01">'+'쿠폰'+'</span>';
											}
											if(list[i].prdtIcon.substring(2,3) == '1'){
												append += ' <span class="badge01">'+'사은품'+'</span>';
											}
											if(list[i].prdtIcon.substring(8,9) == '1'){
												append += ' <span class="badge01">'+'무료배송'+'</span>';
											}
										}
									append += ' </div>';
								append += ' </div>';
							append += ' </a>';
						append += '</li>';
									
									if (i == 19)	break;
			                	}
							}
		                	
							$('#recobellRelationList').html(append);
							
		                }
		            }
		        }
		        ,error: function(request, status, error) {
		            if(request.status != 0){
		                alert('서비스 수행도중 오류가 발생하였습니다. 잠시후 다시 이용해주세요.\n(※ 지속적으로 오류가 나는 경우 고객센터에 문의바랍니다.)');
		            }
		        }
		        ,complete : function() {
		        	
		        	if(categorySwiper03 != null) {
		                //맨 앞으로 스와이퍼 이등
		                categorySwiper03.goToSlide(1);
		                //스와이퍼 삭제 
		        		categorySwiper03.destroySlider();
					}
		        	categorySwiper03 = $('.replace-modal .pd_list ul').bxSlider({
		        		touchEnabled: false,
		        		speed: 1000,
		        		minSlides: 4,
		        		maxSlides: 4,
		        		moveSlides: 4,
		        		slideWidth: 205,
		        		pager: true,
		        		pagerType: 'short',
		        		pagerShortSeparator: ''
		        	});
		        }
		    });
		}
};
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
						<div class="slide-item type01 PC_SIDE_CATE_1_IMG">
							<a href="javascript:;" onclick="location.href='${l.bnrLinkUrl}';return false;">
								<ui:image src="${l.imageUrlPc}" alt="${l.imageAlt}"/>						
							</a>
						</div>											
					</c:when>
					<c:otherwise>
						<div class="slide-item type02 PC_SIDE_CATE_1_IMG">
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
			<div class="btn_fullbox">
				<a href="#n" class="btn_fullmore">전체보기</a>
			</div>		
		</div>		
	</div>
</c:if>
<!--// 배너 -->

<c:if test="${not empty depth1BrnList}">
<div class="layer_fullban category-fullban">
	<div class="list_fullbox">
		<a href="#n" class="btn_fullclose"><span>닫기</span></a>
		
		<c:forEach items="${depth1BrnList}" var="l" varStatus="st">
			<div class="list_fullban_a">
            	<div class="list_fullban">
              		<a href="javascript:;" onclick="location.href='${l.bnrLinkUrl}';return false;">
						<div class="thum">
							<ui:image src="${l.imageUrlPc}" alt="${l.imageAlt}"/>
						</div>
                        <div class="desc">
                            <p class="tit">${l.mainText}</p>
                            <c:if test="${l.signWayGbn eq 'C1453'}">
                            	<p class="txt">${l.subText}</p>
                            </c:if>
                        </div>
			 		</a>
               </div>
           </div>
        </c:forEach>
	</div>
</div>
</c:if>

<div class="lower_content">
	<!-- location -->
	<div class="location_wrap">
		<button type="button" class="btn_home" onclick="location.href='${defaultHost}/ht/biz/welcomeMain'">홈으로</button>
		<c:if test="${not empty cate1DepthList}">
			<div class="location_nav_wrap">
				<a href="/ht/biz/gift/giftCategoryMain?ctgrId=${cate1DepthLoc.cateId}" class="location_1 <c:if test="${cateDepthInfo eq '1'}">on</c:if>">${cate1DepthLoc.cateName}</a>
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
				<a href="/ht/biz/gift/giftCategoryMain?ctgrId=${cate2DepthLoc.cateId}" class="location_1 <c:if test="${cateDepthInfo eq '2'}">on</c:if>">${cate2DepthLoc.cateName}</a>
				<ul class="location_nav">	
					<c:forEach items="${cate2DepthList}" var="l" varStatus="st">				
						<li><a href="/ht/biz/gift/giftCategoryMain?ctgrId=${l.cateId}">${l.cateName}</a></li>            		       		
					</c:forEach>
				</ul>	
			</div>		
		</c:if>
		
		<c:if test="${not empty cate3DepthList}">
			<div class="location_nav_wrap">
				<a href="/ht/biz/gift/giftCategoryMain?ctgrId=${cate3DepthLoc.cateId}" class="location_1 <c:if test="${cateDepthInfo eq '3'}">on</c:if>">${cate3DepthLoc.cateName}</a>
				<ul class="location_nav">	
					<c:forEach items="${cate3DepthList}" var="l" varStatus="st">				
						<li><a href="/ht/biz/gift/giftCategoryMain?ctgrId=${l.cateId}">${l.cateName}</a></li>            		       		
					</c:forEach>
				</ul>	
			</div>		
		</c:if>
		<!-- 
		<c:if test="${not empty cate4DepthList}">
			<div class="location_nav_wrap">
				<a href="/ht/biz/gift/giftCategoryMain?ctgrId=${cate4DepthLoc.cateId}" class="location_1 <c:if test="${cateDepthInfo eq '4'}">on</c:if>">${cate4DepthLoc.cateName}</a>
				<ul class="location_nav">	
					<c:forEach items="${cate4DepthList}" var="l" varStatus="st">				
						<li><a href="#">${l.cateName}</a></li>            		       		
					</c:forEach>
				</ul>	
			</div>		
		</c:if>
		 -->	
	</div>
	<!--// location -->
	
	<h2 class="sub_title">${subCategory.cateName}</h2>
	<div class="category_list">
		<ul>
			<li><a href="javascript:;" class="all" <c:if test="${lastDepthYn eq 'N'}">style="color:#DA2128;"</c:if>>전체보기</a></li>
			
			<c:if test="${not empty subCateList}">
				<c:forEach items="${subCateList}" var="l" varStatus="st">
					<li><a href="/ht/biz/gift/giftCategoryMain?ctgrId=${l.cateId}" <c:if test="${c.ctgrId eq l.cateId}">style="color:#DA2128;"</c:if>>${l.cateName}</a></li>
				</c:forEach>
			</c:if>		
		</ul>
		<c:if test="${c.ctgrId eq '000007'}">
			<div class="type02">
				<ul>				
					<li><a href="/ht/brandStory?type=1" onclick="window.open(this.href,'popBrandStory','width=849,height=700,scrollbars=yes');return false;">브랜드 스토리</a></li>
					<li><a href="/ht/fountainPen?type=1" onclick="window.open(this.href,'popFountainPen','width=849,height=700,scrollbars=yes');return false;">만년필 사용법</a></li>
					<li><a href="/ht/carvingService" onclick="window.open(this.href,'popCarvingSevice','width=849,height=700,scrollbars=yes');return false;">각인 서비스</a></li>
					<li><a href="/ht/fountainPenFaq?type=1" onclick="window.open(this.href,'popFaq','width=849,height=700,scrollbars=yes');return false;">자주 묻는 질문</a></li>
				</ul>
			</div>		
		</c:if>		
	</div>
	
	<!-- 추천/베스트/할인 -->
	<div class="pd_unit pd_unit01">
		<div class="tab">
			<ul class="col03">
				<li class="active"><a href="javascript:;" onclick="loadTemplate('recobell'); return false;"><span>추천</span></a></li>
				<li><a href="javascript:;" onclick="loadTemplate('best'); return false;"><span>베스트</span></a></li>
				<li><a href="javascript:;" onclick="loadTemplate('sale'); return false;"><span>할인</span></a></li>
			</ul>
		</div>
		<div class="category_slide">
			<ul id="RBSList">
			</ul>		
		</div>
	</div>
	<!--// 추천/베스트/할인 -->
	
	<div class="tab">
		<ul class="col07">
			<c:set var="baseLink" value="?ctgrId=${c.ctgrId}&page=1&saleYn=${c.saleYn}&freeDlvYn=${c.freeDlvYn}&hotDlvYn=${c.hotDlvYn}&cpYn=${c.cpYn}&dcYn=${c.dcYn}"/>
			<li <c:if test="${c.productOrderBy eq 'R'}"> class="active"</c:if>><a href="${baseLink}&productOrderBy=R"><span>신상품순</span></a></li>
			<li <c:if test="${c.productOrderBy eq 'P'}"> class="active"</c:if>><a href="${baseLink}&productOrderBy=P"><span>판매량순</span></a></li>
			<c:if test="${c.ctgrId ne '000020'&& c.ctgrId ne '000022' && c.ctgrId ne '000007' && c.ctgrId ne '000021' && c.ctgrId ne '000025' && c.ctgrId ne '000026' && c.ctgrId ne '000024' && c.ctgrId ne '000028' && c.ctgrId ne '000006' && c.ctgrId ne '000027' && c.ctgrId ne '000023' && c.ctgrId ne '000029'}"> 
			<li <c:if test="${c.productOrderBy eq 'L'}"> class="active"</c:if>><a href="${baseLink}&productOrderBy=L"><span>낮은가격순</span></a></li>
			<li <c:if test="${c.productOrderBy eq 'H'}"> class="active"</c:if>><a href="${baseLink}&productOrderBy=H"><span>높은가격순</span></a></li>
			<li <c:if test="${c.productOrderBy eq 'T'}"> class="active"</c:if>><a href="${baseLink}&productOrderBy=T"><span>높은할인율순</span></a></li>
			<li <c:if test="${c.productOrderBy eq 'W'}"> class="active"</c:if>><a href="${baseLink}&productOrderBy=W"><span>좋아요순</span></a></li>
			<li <c:if test="${c.productOrderBy eq 'Q'}"> class="active"</c:if>><a href="${baseLink}&productOrderBy=Q"><span>리뷰순</span></a></li>
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
				<c:if test="${c.ctgrId ne '000020'&& c.ctgrId ne '000022' && c.ctgrId ne '000007' && c.ctgrId ne '000021' && c.ctgrId ne '000025' && c.ctgrId ne '000026' && c.ctgrId ne '000024' && c.ctgrId ne '000028' && c.ctgrId ne '000006' && c.ctgrId ne '000027' && c.ctgrId ne '000023' && c.ctgrId ne '000029'}">
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
				<!-- 
				<li id="rsvYn" <c:if test="${c.rsvYn eq 'Y'}">class="active"</c:if>>
					<label class="form_checkbox">
						<input type="checkbox" <c:if test="${c.rsvYn eq 'Y'}">checked="checked"</c:if>>
						<span class="icon">예약</span>
					</label>
				</li>
				 -->
				</c:if>
			</ul>
		</div>
	</div>
	
	
		<div class="dim"></div>
        <div class="replace-modal">
            <button type="button" class="close-btn"></button>
            <div class="title-wrap">
                <h2>하필 딱! 품절이지만 <b>괜찮아요</b></h2>
                <p>찾으시는 상품과 비슷한 상품이 여기 있어요!</p>
            </div>
            <div class="content-wrap">
	            <div class="pd_list prod_list_normal">
				<ul id="recobellRelationList">
				</ul>
				</div>
     		</div>
     	</div>
        
	<c:if test="${not empty productList }">
		<!-- 상품 -->
		<div class="pd_list">
			<ul>
				<c:forEach items="${productList}" var="l" varStatus="st">						
					<li <c:if test="${l.prdtStatCode ne 'C0312' && l.prdtStatCode eq 'C0313'}">class="sold_out-t"</c:if><c:if test="${l.prdtStatCode ne 'C0312' && l.prdtStatCode ne 'C0313'}">class="sold_out"</c:if>>
						<c:choose>
							<c:when test="${l.prdtStatCode ne 'C0312'}">
								<a href="#none">
									<div class="thum">
										<ui:image src="${l.productImageUrl}" src2="${l.nyoSellBanYn eq 'Y' ? null : l.productImageUrl2}" alt="${fn:escapeXml(l.prdtName)}" server="product" ratingCode="${l.nyoSellBanYn}" size="400"/>
										<c:if test="${l.prdtStatCode ne 'C0312'}">
											<div class="soldout-wrap">
			                                    <div class="absol-center">
			                                        <p>아쉽지만!</p>
			                                        <p><b></b>이에요</p>
			                                        <button type="button" class="replace-stuff-btn" onclick="replaceBtn('${l.sellPrdtBcode}');return false;">대체상품</button>
			                                    </div>
			                                </div>
		                                </c:if>
									</div>
								</a>
							</c:when>
							<c:otherwise>
								<a title="${l.prdtName}" href="/ht/product/detail?barcode=${l.sellPrdtBcode}&ctgrId=${c.ctgrId}">
									<div class="thum">
										<ui:image src="${l.productImageUrl}" src2="${l.nyoSellBanYn eq 'Y' ? null : l.productImageUrl2}" alt="${fn:escapeXml(l.prdtName)}" server="product" ratingCode="${l.nyoSellBanYn}" size="400"/>
									</div>
								</a>
							</c:otherwise>
						</c:choose>
						<!-- 클릭시 active : class 추가 -->					
						<a href="javascript:" onclick="addBizWishProduct(this);return false;" class="btn_like<c:if test="${l.wishUserPrdtCnt > 0}"> active</c:if>" prdtId="${l.sellPrdtBcode}"><span>좋아요</span></a>
						<a href="/ht/product/detail?barcode=${l.sellPrdtBcode}">
							<div class="cont">
								<p class="brand">${l.brandName}</p>
								<p class="tit">${l.prdtName}</p>
								<p class="price font_t">
									<c:if test="${l.prdtStatCode eq 'C0312' && l.prdtSellPrice > l.lastCpnPrice}"><span class="percent"><fmt:parseNumber integerOnly="true" value="${hfn:rate(l.prdtSellPrice, l.lastCpnPrice)}"/>%</span></c:if>
									<span><fmt:formatNumber value="${l.lastCpnPrice}" pattern="#,###"/></span>
									<c:if test="${l.prdtSellPrice > l.lastCpnPrice}"><span class="discount"><fmt:formatNumber value="${l.prdtSellPrice}" pattern="#,###"/></span></c:if>					
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
		<!--//상품 -->
	</c:if>
	<div class="pagination_v2"><ui:bizPagination name="pageHolder" url="/ht/biz/gift/giftCategoryMain?" parameters="ctgrId,productOrderBy,saleYn,freeDlvYn,hotDlvYn,cpYn,dcYn"/></div>
	<c:import url="/menu/biz/quickMenu"/>
</div>
</body>
</html>