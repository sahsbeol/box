<%@ page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<html>
<head>
<!-- 태그 라이브러리 -->
<%@ include file="/pages/decorators/biz/tagHeader.jsp" %>
<ui:decorator name="bizFull"/>
	
<!-- 데이타 스토리  script start-->
<script type="text/javascript">
var ctgrPath = [];
</script>

<c:forEach items="${categoryNavList}" var="l" varStatus="status">
<script type="text/javascript">
	ctgrPath.push('${l.ctgrName}');
</script>
</c:forEach>

<script type="text/javascript">
var ctgrName = '${subTitle}'.trim();

if(ctgrPath.length == 0){
	ctgrPath.push(ctgrName);	
}

_n_p1=ctgrPath[0]; 			// 대카테고리명
_n_p2=ctgrPath[1]; 			// 중카테고리명
_n_p3=ctgrPath[2]; 			// 소카테고리명 
_n_p4=ctgrPath[3]; 			// 세카테고리명
</script>	
<!-- 데이타 스토리  script end-->
	
<script>
var page = 1;
// var validPage = true;
var categorySwiper02 = null;

$(document).ready(function(){
	topMenu();//gnb	
 	sideMenu();//side menu	
//  	footerFn();//footer
	
	$("#layer_banner").appendTo("body");
	
	//배너 레이어 팝업
	subFn();
			
	$fn.getGiftList();
	
	$('.category_wrap .btn_all').on('click', function(){ // 전체보기버튼
		if($(this).hasClass('on')){
			$(this).parent('div').find('.more').attr('style','display:none;');
			$(this).removeClass('on');
			$(this).children('span').text("전체보기");
		}else{
			$(this).parent('div').find('.more').attr('style','display:block;');
			$(this).addClass('on');
			$(this).children('span').text("접어두기");
		}
	});
	
	$('.category_wrap .btn_like').on('click', function(){ //좋아요 버튼
		if($(this).hasClass('active')){
			$(this).removeClass('active');
		}else{
			$(this).addClass('active');
		}
	});
	
	var locationIdx = $('.category_wrap .location_nav_wrap .swiper-slide.active').index();
	
	var categoryNavSwiper = new Swiper('.category_wrap .location_nav_wrap .swiper-container', {
  		 slidesPerView: 'auto',
		 initialSlide : locationIdx,
  		 freeMode: true
    });
	
	var categorySwiper = new Swiper('.category_wrap .category_banner .swiper-container', {
		autoplayDisableOnInteraction: false, //터치후에 멈춤방지
		slidesPerView: 'auto',
		speed: 1500,
		loop: true,
		autoplay: 3000,
		pagination: '.swiper-pagination',
		paginationType: 'fraction'
	});	
	
	
	loadTemplate("recobell");	// 레코벨, 베스트, 할인 상품 조회
	
	$('.pd_unit .tab a').click(function(){	
        $(this).parents('.pd_unit').find('.tab ul li').removeClass('active');
        $(this).parents('li').addClass('active');
	    
	    return false;
	});
	
	$('.pd_filter .tag_list li').click(function(){	        
		$(this).toggleClass('active');        
		
		var strTmp = "?ctgrId=${c.ctgrId}&page=1";
		var strId = "";
		                
		var len = $('div#searchcdt li').length;
		for(var i=0; i<len; i++){
			if($('div#searchcdt li:eq('+i+')').hasClass("active")){
				strId = $('div#searchcdt li:eq('+i+')').attr('id');				
		    	if (strId=="saleYn") {
		    		strTmp += "&"+strId+"=N"; 
				}else{
					strTmp += "&"+strId+"=Y"; 
				}
		    }else{
		    	strId = $('div#searchcdt li:eq('+i+')').attr('id');
		    	if (strId=="saleYn") {
		    		strTmp += "&"+strId+"=Y"; 
				}else{
					strTmp += "&"+strId+"=N"; 
				}
		    }
		}
				
		var sortVal = $("#ulSort option:selected").val();
		strTmp += "&productOrderBy="+sortVal;
		
		location.href=strTmp;
		
		return false;
	});	
	
	$(".layer_banner_top").bind("touchmove", function(e) {
    	e.preventDefault();
    });
});

$(document).on("touchend","#replaceBtnId",function() {
    replaceBtn($('#replaceBtnId').attr("code"));
});

function replaceBtn(bcode){
	setRecobellRelationList(bcode);
	$('.replace-modal').show();
// 	$('html,body').addClass('noscroll');
}

$fn = {
	getGiftList:function() {
		$('.loadinglist').show();

		var ctgrId = "${c.ctgrId}";
		var saleYn = "${c.saleYn}";
		var freeDlvYn = "${c.freeDlvYn}";
		var hotDlvYn = "${c.hotDlvYn}";
		var cpYn = "${c.cpYn}";
		var dcYn = "${c.dcYn}";
		var rsvYn = "${c.rsvYn}";
		var productOrderBy = "${c.productOrderBy}";
		var page = "${c.page}";
		$.ajax({
			url: "/m/biz/category/getGiftList"
			, data: {
				ctgrId : ctgrId,
				saleYn : saleYn,
				freeDlvYn : freeDlvYn,
				hotDlvYn : hotDlvYn,
				cpYn : cpYn,
				dcYn : dcYn,
				rsvYn : rsvYn,
				productOrderBy : productOrderBy,
				page : page
			}
			, type:"POST"
	        ,dataType: "json"
	        ,success : function(data){
	        	var append = '';
	        	$('#dvdList').empty();
                if(!isEmpty(data)) {
					var list = data.list;
					var pageHolder = data.pageHolder;
					if(!isEmpty(list)) {
						append += '<ul>';
						for(var i=0; i < list.length; i++) {
							var rate = 0;
							/* rate = 100 - Math.ceil(((list[i].lastCpnPrice / list[i].prdtSellPrice) * 100)); */
							rate = ((list[i].prdtSellPrice - list[i].lastCpnPrice) / list[i].prdtSellPrice) * 100;
							rate = Math.round(rate * 10);
							rate = Math.floor(rate / 10);
							
							if(list[i].prdtStatCode == 'C0312'){
								append += '<li>';
	                	    }else{
	                	    	if(list[i].prdtStatCode == 'C0313'){
									append += '<li class="sold_out-t">';
	                	    	}else{
	                	    		append += '<li class="sold_out">';
	                	    	}
	                	    }
							if(list[i].prdtStatCode == 'C0312'){
								append += '        <a href="/p/'+list[i].sellPrdtBcode+'">';
							}else{
								if(list[i].sellPrdtGbn == 'R' || list[i].sellPrdtGbn == 'D'){
									append += '        <a href="/p/'+list[i].sellPrdtBcode+'">';
								}else{
									append += '        <a href="#none">';	
								}
							}
							append += '        	<div class="thum">';
							if(list[i].sellPrdtGbn == 'R' || list[i].sellPrdtGbn == 'D'){
								if(list[i].rtngCode == 'C0845' && adultYn != 'Y'){
		                	    	if(list[i].sellPrdtGbn == 'R'){
		                	    		append += '<img src="http://image.kyobobook.co.kr/newimages//giftshop_new/common/images/music/img_19product.jpg" alt="'+list[i].prdtName+'">';	
		                	    	}else{
		                	    		append += '<img src="http://image.kyobobook.co.kr/newimages//giftshop_new/common/images/dvd/img_19product.jpg" alt="'+list[i].prdtName+'">';
		                	    	}
								}else{
		                	    	append += '			<img src="http://image.kyobobook.co.kr/newimages/music/large/'+list[i].rcrdCd.substring( 1, 5 ).split("").reverse().join("")+'/'+list[i].rcrdCd+'.jpg" alt="'+list[i].prdtName+'" class="photo" width="200" height="200" onerror="this.src=\'http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/no_image2.gif\';">';
								}
	                	    }else{
	                	    	if (list[i].nyoSellBanYn) {
	                	    		append += '<img src="http://image.kyobobook.co.kr/newimages//giftshop_new/common/images/music/img_19product.jpg" alt="'+list[i].prdtName+'">';
								} else {
		                	    	append += '			<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/goods/400/'+list[i].productImageUrl+'" alt="'+list[i].prdtName+'" class="photo" width="200" height="200" onerror="this.src=\'http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/no_image2.gif\';">';
								}
	                	    }
							if(list[i].prdtStatCode != 'C0312'){
								append += '	<div class="soldout-wrap">';
								append += '		<div class="absol-center">';
								append += '			<p>'+'아쉽지만!'+'</p>';
								append += '			<p><b></b>'+'이에요'+'</p>';
								append += '			<button type="button" class="replace-stuff-btn" id="replaceBtnId" code="'+list[i].sellPrdtBcode+'">'+'대체상품'+'</button>';
								append += '		</div>';
								append += ' </div>';
							}
							append += '        	</div>';
							append += '		</a>';
							if(list[i].wishUserPrdtCnt > 0){
								append += '		<a href="javascript:" onclick="addBizWishProduct(this);return false;" class="btn_like active" prdtId="'+list[i].sellPrdtBcode+'"><span>좋아요</span></a>';
	                	    }else{
								append += '		<a href="javascript:" onclick="addBizWishProduct(this);return false;" class="btn_like" prdtId="'+list[i].sellPrdtBcode+'"><span>좋아요</span></a>';
	                	    }
							append += '		<a href="/p/'+list[i].sellPrdtBcode+'">';
							append += '			<div class="cont">';
							append += '				<p class="brand">'+list[i].brandEngName+'</p>';
							append += '				<p class="tit">'+list[i].prdtName+'</p>';
							append += '				<p class="price font_t">';
							if(rate != 0){
		                	    append += '				<span class="percent">'+rate+'%</span>';
	                	    }
							append += '					<span>'+price_format(list[i].lastCpnPrice)+'</span>';
							if(rate != 0){
								append += '					<span class="discount">'+price_format(list[i].prdtSellPrice)+'</span>';
	                	    }
							append += '				</p>';
							append += '				<div class="info">';
							if(list[i].reviewCount > 999){
								append += '					<span class="reply">999+</span>';
	                	    }else{
								append += '					<span class="reply">'+list[i].reviewCount+'</span>';
	                	    }
							if(list[i].wishPrdtCnt > 999){
								append += '					<span class="like" code="'+list[i].sellPrdtBcode+'">999+</span>';
	                	    }else{
								append += '					<span class="like" code="'+list[i].sellPrdtBcode+'">'+list[i].wishPrdtCnt+'</span>';
	                	    }
							append += '				</div>';
							append += '				<div class="badge">';
							if(list[i].prdtStatCode != 'C0312'){
								if(list[i].prdtStatCode == 'C0313'){
									append += '				<span class="badge03">일시품절</span>';
								}else{
									append += '				<span class="badge03">품절</span>';
								}
							}else{
								if(list[i].prdtIcon.substring(0,1) == '1'){
									append += '				<span class="badge01">쿠폰</span>';
								}else if(list[i].prdtIcon.substring(2,3) == '1'){
									append += '				<span class="badge02">사은품</span>';
								}else if(list[i].prdtIcon.substring(8,9) == '1'){
									append += '				<span class="badge02">무료배송</span>';
								}
							}
							append += '				</div>';
							append += '			</div>';		
							append += '        </a>';
							append += '	</li>';
						}
						append += '</ul>';
					}else{
						append += '<ul>';
						append += '		<p class="info t_c">해당 분류의 상품이 존재하지 않습니다.</p>';
						append += '</ul>';
	                }
					
	                var obj = document.getElementById("giftPaging");
	                var hndl = function(page){ return function(e){ 
                			e.preventDefault();
                			$('#gift_curPage').val($(this).attr("href").replace("#",""));
                			goList($('#gift_curPage').val());
                		};
                	};
	                obj.appendChild(_getNewPager(pageHolder, hndl));
					
					$('#giftList').html(append);
                }
                
                $('.loadinglist').hide();
	        }
	        ,error: function(request, status, error) {
	            if(request.status != 0){
	                alert('서비스 수행도중 오류가 발생하였습니다. 잠시후 다시 이용해주세요.\n(※ 지속적으로 오류가 나는 경우 고객센터에 문의바랍니다.)');
	            }
	            $('.loadinglist').hide();
	        }
	    });
	}
};

// 추천 / 베스트 / 할인 상품 조회
function loadTemplate(rbsNm){
	
	var ctgrId = "${ctgrId}";
	
	$.ajax({
        type: "POST"
        ,url: "/m/gift/biz/category/recobellTemplate"
        ,data: {  ctgrId : ctgrId, reqParam : rbsNm }
        ,dataType: "html"
        ,success : function(data){
                    	
      		$("#RBSList").empty();
        	$("#RBSList").append(data);
        	
        	if(categorySwiper02 != null) {
	       		//맨 앞으로 스와이퍼 이등
				categorySwiper02.slideTo(0.1);
	       		//스와이퍼 삭제
				categorySwiper02.destroy();
	       	}        	
        	        	
//         	categoryFn(); //category - 추천 상품 스와이프 관련 스크립트 때문에 늦게 호출함.
        	categorySwiper02 = new Swiper('.category_wrap .pd_unit .swiper-container', {
        		slidesPerView: 'auto',
        		spaceBetween: 24,
        		freeMode: true,
        		slidesOffsetBefore: 30,
        		scrollbar: '.swiper-scrollbar',
        		draggable: true
        	});        	
        	
        }
        ,error: function(data) {        	
            alert('<fmt:message key="error.common.system"/>');
        }
    });
}


//페이지 이동
function goList(page){
    location.href="?ctgrId=${c.ctgrId}&saleYn=${c.saleYn}&freeDlvYn=${c.freeDlvYn}&hotDlvYn=${c.hotDlvYn}&cpYn=${c.cpYn}&dcYn=${c.dcYn}&rsvYn=${c.rsvYn}&productOrderBy=${c.productOrderBy}&page="+page;   
}


$(function(){
    $('.replace-modal .close-btn').click(function(){
        $('.replace-modal').hide();
//         $('html,body').removeClass('noscroll');
    });
});


function setRecobellRelationList(bcode) {
	$.ajax({
		url: "/m/biz/personal/getRecobellRelationList"
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
// 							if(i < 4){
								append += '	<li>';
// 							}else{
// 								append += '	<li style="display:none;">';
// 							}
							append += '	<a href="/p/'+list[i].sellPrdtBcode+'?foo=bar&rccode=mo_soldout">';
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
    });
}
</script>	
</head>

<body>
	<input type="hidden" id="gift_curPage" value="1">
	<!-- content -->
	<div id="content">
		<div class="category_wrap">

			<c:if test="${not empty categoryNavList}">
				<div class="location_nav_wrap">
					<div class="swiper-container">
						<div class="swiper-wrapper">
							<c:forEach items="${categoryNavList}" var="l" varStatus="status">
								<div class="swiper-slide <c:if test="${status.last}">active</c:if>">
	                        		<a href="/m/gift/biz/category/${l.ctgrId}">${l.ctgrName}</a>
	                        	</div>	
	                        	<c:set var="oCtgrId" value="${l.ctgrId}"></c:set>
	                        </c:forEach>
	                        <c:forEach items="${childCategory}" var="l" varStatus="status">
	                        	<c:if test="${oCtgrId eq l.ctgrId}"><c:set var="cCtgrId" value="${l.ctgrId}"></c:set></c:if>
	                        </c:forEach>
						</div>
					</div>
	            </div>
            </c:if>

			<div class="category_list">
				<ul>
					<li <c:if test="${(oCtgrId eq ctgrId && ctgrId ne cCtgrId) || oCtgrId eq null}">class="active"</c:if>><a href="/m/gift/biz/category/${ctgrId}">전체보기</a></li>
					<c:forEach items="${childCategory}" var="l" varStatus="status">
						<li class="<c:if test="${status.count > 5}">more</c:if><c:if test="${oCtgrId eq l.ctgrId}"> active</c:if>" <c:if test="${status.count > 5}">style="display:none"</c:if>><a href="/m/gift/biz/category/${l.ctgrId}">${l.ctgrName}</a></li>
					</c:forEach>					
				</ul>
				<c:if test="${fn:length(childCategory) > 5}">
					<a href="javascript:;" class="btn_all"><span>전체보기</span></a>
				</c:if>
			</div>

			<!-- 배너 -->
			<c:if test="${not empty depth1BrnList}">
			<div class="category_banner">
				<div class="swiper-container">
					<div class="swiper-wrapper">
						<c:forEach items="${depth1BrnList}" var="l" varStatus="status">
							<c:choose>
								<c:when test="${l.signWayGbn == 'C1451'}">							
									<div class="swiper-slide type02">
										<a href="${l.bnrLinkUrl}" class="MB_SIDE_CATE_1_IMG">									
											<ui:image src="${l.imageUrlMo}"  alt="${fn:escapeXml(l.imageAlt)}"/>
										</a>
									</div>
								</c:when>
								<c:otherwise>
									<div class="swiper-slide type01">
										<a href="${l.bnrLinkUrl}" class="MB_SIDE_CATE_1_IMG">
											<ui:image src="${l.imageUrlMo}"  alt="${fn:escapeXml(l.imageAlt)}"/>
											<div class="info">
												<p class="tit">${l.mainText}</p>
												<p class="txt">${l.subText}</p>
											</div>
										</a>
									</div>
								
								</c:otherwise>
							</c:choose>
						</c:forEach>					
					</div>					
					<!-- swiper-pagination -->
					<div class="pagination_wrap">
						<a href="javascript:" class='paging_link'>
							<div class="swiper-pagination"></div>
							<div class="plus_inner">
								<a href="#" class="btn_plus"></a>
							</div>
						</a>
					</div>
				</div>
			</div>
			</c:if>
			<!--// 배너 -->
		
			<!-- 추천/베스트/할인 -->
			<div class="pd_unit">
				<div class="tab">
					<ul>
						<li class="MB_SIDE_CATE_1_REC active"><a href="javascript:;" onclick="loadTemplate('recobell'); return false;">추천</a></li>
						<li class="MB_SIDE_CATE_1_BEST"><a href="javascript:;" onclick="loadTemplate('best'); return false;">베스트</a></li>
						<li class="MB_SIDE_CATE_1_SALE"><a href="javascript:;" onclick="loadTemplate('sale'); return false;">할인</a></li>
					</ul>
				</div>
				<div class="swiper-container">
					<div class="swiper-wrapper" id="RBSList">						
					</div>
					<!-- 스크롤바 -->
					<div class="swiper-scrollbar"></div>
				</div>
			</div>

			<div class="pd_filter" id="cateProductList">
				<div class="form_select" >
					<c:set var="baseLink" value="?ctgrId=${c.ctgrId}&page=1&saleYn=${c.saleYn}&freeDlvYn=${c.freeDlvYn}&hotDlvYn=${c.hotDlvYn}&cpYn=${c.cpYn}&dcYn=${c.dcYn}&rsvYn=${c.rsvYn}"/>				
					<select id="ulSort" onchange="location.href='${baseLink}&productOrderBy='+this.value+'';return false;">
						<option value="R" <c:if test="${c.productOrderBy eq 'R'}"> selected="selected"</c:if>>신상품순</option>						
						<option value="P" <c:if test="${c.productOrderBy eq 'P'}"> selected="selected"</c:if>>판매량순</option>
						<c:if test="${c.ctgrId ne '000020'&& c.ctgrId ne '000022' && c.ctgrId ne '000007' && c.ctgrId ne '000021' && c.ctgrId ne '000025' && c.ctgrId ne '000026' && c.ctgrId ne '000024' && c.ctgrId ne '000028' && c.ctgrId ne '000006' && c.ctgrId ne '000027' && c.ctgrId ne '000023' && c.ctgrId ne '000029'}">
							<option value="L" <c:if test="${c.productOrderBy eq 'L'}"> selected="selected"</c:if>>낮은가격순</option>
							<option value="H" <c:if test="${c.productOrderBy eq 'H'}"> selected="selected"</c:if>>높은가격순</option>
							<option value="T" <c:if test="${c.productOrderBy eq 'T'}"> selected="selected"</c:if>>높은할인율순</option>
							<option value="Q" <c:if test="${c.productOrderBy eq 'Q'}"> selected="selected"</c:if>>리뷰순</option>
							<option value="W" <c:if test="${c.productOrderBy eq 'W'}"> selected="selected"</c:if>>좋아요순</option>
						</c:if>
					</select>
				</div>
				<div class="tag_list" id="searchcdt">					
					<ul>
						<!-- 활성화 active : class 추가 -->
						<c:if test="${c.ctgrId ne '000020'&& c.ctgrId ne '000022' && c.ctgrId ne '000007' && c.ctgrId ne '000021' && c.ctgrId ne '000025' && c.ctgrId ne '000026' && c.ctgrId ne '000024' && c.ctgrId ne '000028' && c.ctgrId ne '000006' && c.ctgrId ne '000027' && c.ctgrId ne '000023' && c.ctgrId ne '000029'}">
						<li class="b_dummy"></li>
						</c:if>
<%-- 						<c:set var="baseLink" value="?ctgrId=${c.ctgrId}&page=1"/> --%>
						<li id="saleYn" class="one_tag<c:if test="${c.saleYn eq 'N'}"> active</c:if>"><a href="javascript:;">품절포함</a></li>
						<c:if test="${c.ctgrId ne '000020'&& c.ctgrId ne '000022' && c.ctgrId ne '000007' && c.ctgrId ne '000021' && c.ctgrId ne '000025' && c.ctgrId ne '000026' && c.ctgrId ne '000024' && c.ctgrId ne '000028' && c.ctgrId ne '000006' && c.ctgrId ne '000027' && c.ctgrId ne '000023' && c.ctgrId ne '000029'}">
						<li id="freeDlvYn" <c:if test="${c.freeDlvYn eq 'Y'}">class="active"</c:if>><a href="javascript:;">무료배송</a></li>
						<li id="hotDlvYn" <c:if test="${c.hotDlvYn eq 'Y'}">class="active"</c:if>><a href="javascript:;">핫트랙스배송</a></li>
						<li id="cpYn" <c:if test="${c.cpYn eq 'Y'}">class="active"</c:if>><a href="javascript:;">쿠폰</a></li>
						<li id="dcYn" <c:if test="${c.dcYn eq 'Y'}">class="active"</c:if>><a href="javascript:;">할인</a></li>
<%-- 						<li id="rsvYn" <c:if test="${c.rsvYn eq 'Y'}">class="active"</c:if>><a href="javascript:;">예약</a></li> --%>
						</c:if>
					</ul>
				</div>
			</div>
			<div class="loadinglist" style="display:none;"><img src="/images/common/ajax-loader.gif"></div>
			<div class="pd_list" id="giftList"></div>
	        <div id="giftPaging"></div>		
		</div>
	</div>
	<!--// content -->
	
	
	<!-- /////////상단 롤링 배너 레이어///////// -->
	<c:if test="${not empty depth1BrnList and fn:length(depth1BrnList) > 0}">
		<div id="layer_banner">
			<div class="layer_banner_top">
				<h2>전체보기</h2>
				<a href="javascript:;" class="btn_close">닫기</a>
			</div>
			<div class="layer_wrap">
				<div class="layer_cont">
					<ul>
						<c:forEach items="${depth1BrnList}" var="l" varStatus="st">
							<li class="${l.signWayGbn eq 'C1451' ? 'type02' : 'type01'}">
								<a href="javascript:;" onclick="location.href='${l.bnrLinkUrl}';return false;">
									<ui:image src="${l.imageUrlMo}" alt="${l.imageAlt}"/>
									<c:if test="${l.signWayGbn ne 'C1451'}">
										<div class="info sub">
											<p class="tit">${l.mainText}</p>
											<c:if test="${l.signWayGbn eq 'C1453'}">
												<p class="txt">${l.subText}</p>
											</c:if>
										</div>
									</c:if>
								</a>
							</li>
						</c:forEach>								
					</ul>
				</div>
			</div>
		</div>
	</c:if>
	<!--// 상단 롤링 배너 레이어 -->	
	
	<!-- replaced stuff modal -->
    <div class="replace-modal">
        <button type="button" class="close-btn"></button>
        <div class="title-wrap">
            <h2>하필 딱! 품절이지만<br>괜찮아요</h2>
            <p>찾으시는 상품과 비슷한 상품이 여기 있어요!</p>
        </div>
        <div class="category_wrap">
            <div class="pd_list">
                <ul id="recobellRelationList"> 
                </ul>
            </div>
        </div>
    </div>
</body>
</html>