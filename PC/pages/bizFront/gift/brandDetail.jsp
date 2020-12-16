<%@ page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<!-- 태그 라이브러리 -->
<%@ include file="/pages/decorators/biz/tagHeader.jsp" %>

<!-- 데코레이터에 있는 #container 요소에 클래스를 추가하기 위해 -->
<meta name="container" content="product"/>

<!--  SNS 공유 내용 -->
<meta property="og:type" content="website"/>
<meta property="og:title" content="${brand.brandEngName}"/>
<meta property="og:url" content="${defaultHost}/ht/biz/hot/brandDetail?brandId=${brand.brandId}"/>
<meta property="og:image" content="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/renewal/common/logo_over.gif"/>
<!--  SNS 공유 내용 -->

<script type="text/javascript">
	$(document).ready(function(){
		obj.init();
	});
	
	var obj = {
		 swiper : null
		,init : function(){			
			$("img.lazy").lazyload({placeholder:'/images/no_image2.gif',threshold:200});
			
		    $(".pagination a").click(function(e){
		        e.preventDefault();
		        location.href = $(this).attr("href") + "#pd_list";
		    });
 
			$('.tit_like .btn_like').unbind('click');

			categoryFn();
			
			var eventCls = "";
			if($("#eventArea").length > 0){
				eventCls = ($("#eventArea").attr("class")).replace(" clear", "");
				$(".brShop_wrap").addClass(eventCls);
				
				if(eventCls == "case3"){
					bradnSlider();
				}
			}
		}
	};
	
	
	var categorySwiper03 = null;
	
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

<div class='bg_brand'><!-- 브랜드 상단 배경 -->
	<div class="topTit_brand clear">
		<div class="tit_round<c:if test='${not empty brand.brandImageC0292}'> img</c:if>"><!-- 이미지가 있으면, tit_round에 img : class 추가 -->
			<c:if test='${not empty brand.brandImageC0292}'>
				<ui:image src="${brand.brandImageC0292}" server="brand" alt="${brand.brandName}"/>
			</c:if>
		</div>
		<div class="tit_brand">
			<c:if test="${!empty brand.brandEngName}">
				<h2 class='brand_en'>${brand.brandEngName}</h2>
				<p class='h2_line'></p>
			</c:if>
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
			<p class="open_t">
				${brand.brandDesc}
			</p>
			<c:if test="${not empty fn:trim(brand.brandDesc) && fn:length(fn:trim(brand.brandDesc)) > 82}">
			<a href="javascript:;" onclick="if($('.btn_more').hasClass('on')){$(this).removeClass('on');$('.open_t').removeClass('on');$('.more_txt').text('더보기');}else{$(this).addClass('on');$('.open_t').addClass('on');$('.more_txt').text('접기');}" class="btn_more">
                <span class="more_txt">더보기</span>
            </a>
            </c:if>
		</div>
	</div>
</div><!-- //브랜드 상단 배경 -->

<div class="brShop_wrap category_wrap"><!-- 브랜드 이미지 개수별 case1 ~ 3 -->
	<!-- //////이벤트 영역////// -->
	<c:if test="${not empty eventList}">
		<c:choose>
			<c:when test="${fn:length(eventList) == 1}">
				<c:set var="l" value="${eventList[0]}"/>
				<div id="eventArea" class="case1 clear">
					<div class='img_inner'>
						<a href="/ht/biz/eventDetail?eventId=${l.eventId}">
							<ui:image src="${l.imageUrl}" alt="${l.eventTitle}"/>
						</a>
					</div>
					<div class="txt_inner">
						<c:if test="${not empty l.discRate && l.discRate > 0}">
							<span class='font_t percent'>${l.discRate}%</span>
						</c:if>
						<strong>${l.eventTitle}</strong>
						<p>${l.eventDtlCont}</p>
						<a href="/ht/biz/eventDetail?eventId=${l.eventId}"></a>
					</div>
				</div>
			</c:when>
			<c:when test="${fn:length(eventList) == 2}">
				<div id="eventArea" class="case2 clear">
					<ul class='list_brand clear'>
						<c:forEach items="${eventList}" var="l">
							<li>
								<div class='img_inner'>
									<ui:image src="${l.imageUrl}" alt="${l.eventTitle}"/>
									<c:if test="${not empty l.discRate && l.discRate > 0}">
										<span class='font_t percent'>${l.discRate}%</span>
									</c:if>
								</div>
								<strong>${l.eventTitle}</strong>
								<p>${l.eventDtlCont}</p>
								<a href="/ht/biz/eventDetail?eventId=${l.eventId}"></a>
							</li>
						</c:forEach>
					</ul>
				</div>
			</c:when>
			<c:otherwise>
				<div id="eventArea" class="case3 clear">
					<div class="brand_slider">
						<ul>
							<c:forEach items="${eventList}" var="l">
								<li>
									<div class="img_inner">
										<ui:image src="${l.imageUrl}" alt="${l.eventTitle}"/>
									</div>
									<div class="brand_text">
										<c:if test="${not empty l.discRate && l.discRate > 0}">
											<span class='font_t percent'>${l.discRate}%</span>
										</c:if>
										<strong>${l.eventTitle}</strong>
										<p>${l.eventDtlCont}</p>
									</div>
									<a href="/ht/biz/eventDetail?eventId=${l.eventId}"></a>
								</li>
							</c:forEach>
						</ul>
					</div>
				</div>
			</c:otherwise>
		</c:choose>		
	</c:if>
	<!-- 프레임 비디오 -->
	<div class="viewer-wrap">
		<div class="content-wrap">
			<div class="title-wrap">
				<h2>Viewer</h2>
				<p>핫트랙스의 시선으로 브랜드를 바라보다</p>
				<div class="bar"></div>
			</div>
			<div class="youtube-wrap" id="viewerApi" name="viewerApi"></div>
		</div>
	</div>
	
	<!-- 판매베스트 -->
	<c:if test="${not empty listBestProduct}">
		<div class="best_selling">
			<h2 class='tit_sell'>판매베스트</h2>
			<!-- 상품 -->
			<div class="pd_list">
				<ul>
					<!-- prod -->
					<c:import url="/pages/bizFront/template/bizLayerProduct.jsp" charEncoding="UTF-8">
						<c:param name="paramList" value="listBestProduct"/>
						<c:param name="imgRound" value="Y"/>
					</c:import>
					<!-- //prod -->
				</ul>
			</div>
			<!-- //상품 -->
		</div>
	</c:if>
	
	<!-- 항목분류 -->
	<div class="sortItem_wrap" id="pd_list">
		<ul class='list_sortItem clear'>
			<c:forEach items="${listPrdtCntByCtgr}" var="l">
				<li<c:if test="${c.ctgrId eq l.ctgrId || (c.ctgrId eq '00'&& empty l.ctgrId)}"> class="active"</c:if>>
                    <a href="?brandId=${brand.brandId}&page=1&productOrderBy=${c.productOrderBy}&productListType=${c.productListType}&listSize=${c.listSize}&ctgrId=${l.ctgrId}#pd_list">${l.ctgrName}(<fmt:formatNumber value="${l.productCnt}" type="number"/>)</a>
                    <c:if test="${c.ctgrId eq l.ctgrId || (c.ctgrId eq '00'&& empty l.ctgrId)}"> <c:set var="selectCnt" value="${l.productCnt}"/></c:if>
                </li>
			</c:forEach>
			<c:set var="len" value="0"/>
			<c:choose>
				<c:when test="${fn:length(listPrdtCntByCtgr) < 5}">
					<c:set var="len" value="${5 - (fn:length(listPrdtCntByCtgr))}"/>
				</c:when>
				<c:when test="${(fn:length(listPrdtCntByCtgr) % 5) > 0 }">
					<c:set var="len" value="${5 - (fn:length(listPrdtCntByCtgr) % 5)}"/>
				</c:when>
			</c:choose>
			<c:forEach var="i" begin="1" end="${len}">				
			    <li><a href="javascript:"></a></li>
			</c:forEach>
		</ul>
	</div>
	<div class="tab">
		<ul class="col07">
			<c:set var="orderLink" value="?brandId=${brand.brandId}&ctgrId=${c.ctgrId}&page=1&productListType=${c.productListType}&listSize=${c.listSize}&saleYn=${c.saleYn}"/>
			<li value="R" <c:if test="${c.productOrderBy eq 'R'}"> class="active"</c:if> onclick="$('.tab .col07 li[value=R]').addClass('active');$('.tab .col07 li').not('[value=R]').removeClass('active');location.href='${orderLink}&productOrderBy=R';"><a href="#none"><span>신상품순</span></a></li>
			<li value="P" <c:if test="${c.productOrderBy eq 'P'}"> class="active"</c:if> onclick="$('.tab .col07 li[value=P]').addClass('active');$('.tab .col07 li').not('[value=P]').removeClass('active');location.href='${orderLink}&productOrderBy=P';"><a href="#none"><span>판매량순</span></a></li>
			<li value="L" <c:if test="${c.productOrderBy eq 'L'}"> class="active"</c:if> onclick="$('.tab .col07 li[value=L]').addClass('active');$('.tab .col07 li').not('[value=L]').removeClass('active');location.href='${orderLink}&productOrderBy=L';"><a href="#none"><span>낮은가격순</span></a></li>
			<li value="H" <c:if test="${c.productOrderBy eq 'H'}"> class="active"</c:if> onclick="$('.tab .col07 li[value=H]').addClass('active');$('.tab .col07 li').not('[value=H]').removeClass('active');location.href='${orderLink}&productOrderBy=H';"><a href="#none"><span>높은가격순</span></a></li>
			<li value="T" <c:if test="${c.productOrderBy eq 'T'}"> class="active"</c:if> onclick="$('.tab .col07 li[value=T]').addClass('active');$('.tab .col07 li').not('[value=T]').removeClass('active');location.href='${orderLink}&productOrderBy=T';"><a href="#none"><span>높은할인률순</span></a></li>
			<li value="W" <c:if test="${c.productOrderBy eq 'W'}"> class="active"</c:if> onclick="$('.tab .col07 li[value=W]').addClass('active');$('.tab .col07 li').not('[value=W]').removeClass('active');location.href='${orderLink}&productOrderBy=W';"><a href="#none"><span>좋아요순</span></a></li>
			<li value="C" <c:if test="${c.productOrderBy eq 'C'}"> class="active"</c:if> onclick="$('.tab .col07 li[value=C]').addClass('active');$('.tab .col07 li').not('[value=C]').removeClass('active');location.href='${orderLink}&productOrderBy=C';"><a href="#none"><span>리뷰순</span></a></li>
		</ul>
	</div>
	<div class="pd_filter">
		<p class="pd_total"><em class="font_t"><fmt:formatNumber value="${selectCnt}" type="number"/></em>건의 검색결과</p>
		<div class="tag_list brandshop">
			<ul>
				<li>
					<label class="form_checkbox">
					<c:set var="orderLink" value="?brandId=${brand.brandId}&ctgrId=${c.ctgrId}&page=1&productListType=${c.productListType}&listSize=${c.listSize}&productOrderBy=${c.productOrderBy}"/>
						<input type="checkbox" <c:if test="${c.saleYn eq 'Y'}"> checked="checked"</c:if> onclick="$('.tag_list [type=checkbox]').attr('checked')?location.href='${orderLink}&saleYn=N':location.href='${orderLink}&saleYn=Y';">
						<span class="icon">품절포함</span>
					</label>
				</li>
			</ul>
		</div>
	</div>
	
	<div class="pd_list">
		<ul>
			<!-- prod -->
			<c:import url="/pages/bizFront/template/bizLayerProduct.jsp" charEncoding="UTF-8">
				<c:param name="paramList" value="listProduct"/>
			</c:import>
			<!-- //prod -->
		</ul>
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

	<!-- pagination -->
	<div class="pagination_v2">	        	   
 		<ui:bizPagination name="pageHolder" url="?" parameters="brandId,ctgrId,productOrderBy,productListType,listSize,listLine,saleYn"/>
	</div>	
	<!--// pagination -->
	    <script>
	    /*
	    *
		var tag = document.createElement('script');
        tag.src = "https://www.youtube.com/player_api";
        var firstScriptTag = document.getElementsByTagName('script')[0];
        firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);
        var viewerApi
    
        function onYouTubeIframeAPIReady() {
            viewerApi = new YT.Player('viewerApi', {
                width: '950',
                height: '',
                videoId: 'ykhQGNV0tAo',
                playerVars: {rel: 0}
            });
        }
	    */
        var tag = document.createElement('script');
        tag.src = "https://www.youtube.com/player_api";
        var firstScriptTag = document.getElementsByTagName('script')[0];
        firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);
        var viewerApi
    	var videoId = {"31939":"yap7RvwUNgY"
        			  ,"28060":"2_gM7OB0Kcc"
        			  ,"32429":"40nxRD-cakU"
        			  ,"34366":"Zbu600qz3HQ"
        			  ,"33436":"ykhQGNV0tAo"
        			  ,"33658":"ykhQGNV0tAo"
        			  ,"16757":"v3jTXJ5oKp4"
        			  ,"91779":"kRr-BybaAbQ"
           			  ,"10019":"5JPBB1w3phA"
       				  ,"27540":"Uj2hBGjf3jo"};
        function onYouTubeIframeAPIReady() {
        	viewerApi = new YT.Player('viewerApi', {
                width: '950',
                height: '534',
                videoId: videoId["${brand.brandId}"],
                playerVars: {rel: 0},
                events: {
                'onReady': playVideo
                }
            });
        }
        function playVideo() {
        	viewerApi.mute();
            if($(window).scrollTop() !== 0) viewerApi.playVideo();
        }
        function stopVideo() {
        	viewerApi.stopVideo();
        }
        if(videoId["${brand.brandId}"] == undefined){
        	$(".viewer-wrap").html("");
        }
    </script>
</div>