<%@ page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<!-- 태그 라이브러리 -->
<%@ include file="/pages/decorators/biz/tagHeader.jsp" %>
<ui:decorator name="bizFull"/>
<%
 response.setHeader("Cache-Control","no-store");
%>
<!--  SNS 공유 내용 -->
<meta property="og:type" content="website"/>
<meta property="og:title" content="${brand.brandEngName}"/>
<meta property="og:url" content="${defaultHost}/ht/biz/hot/brandDetail?brandId=${brand.brandId}"/>
<meta property="og:image" content="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/renewal/common/logo_over.gif"/>

<script type="text/javascript">
	$(document).ready(function() {
		obj.init();		
	
	});
	
	$(document).on("touchend","#replaceBtnId",function() {
	    replaceBtn($('#replaceBtnId').attr("code"));
	});
	
	function replaceBtn(bcode){
		setRecobellRelationList(bcode);
		$('.replace-modal').show();
//	 	$('html,body').addClass('noscroll');
	}
	
	var obj = {
		init : function(){
			brandTit();//titArrow
			categoryFn();
			$("#subTitle").text("브랜드");
			
			var text = $('#selectOption').find('option:selected').text();
			var $aux = $('<select/>').append($('<option/>').text(text));
			$('#selectOption').after($aux);
			$('#selectOption').width($aux.width()+10);
			$aux.remove();

			if($('.event_list .swiper-container').length > 0){
				var eventBannerSwiper01 = new Swiper('.event_list .event_top .swiper-container', {
					slidesPerView: 'auto',
					spaceBetween: 8,
					speed: 1000,
					freeMode: true,
					slidesOffsetBefore: 40,
					scrollbar: '.swiper-scrollbar',
					pagination: '.swiper-pagination',
					paginationType: 'fraction',
					draggable: true
				});

				var locationIdx = $('.event_list .category_nav_wrap .swiper-slide.active').index();
				var eventNavSwiper = new Swiper('.event_list .category_nav_wrap .swiper-container', {
			   		 slidesPerView: 'auto',
					 initialSlide : locationIdx,
					 slidesOffsetBefore: 40,
			   		 freeMode: true
			    });
			}
		}
	};
	
	jQuery(function($){
	    $("img.lazy").lazyload({placeholder:'/images/no_image2.gif',effect : "fadeIn"});
	    
	    $(".like_img").show();
	});
	function goList(page){
	    location.href="?brandId=${c.brandId}&ctgrId=${c.ctgrId}&productOrderBy=${c.productOrderBy}&saleYn=${c.saleYn}&page="+page;
	}
	
	
	$(function(){
	    $('.replace-modal .close-btn').click(function(){
	        $('.replace-modal').hide();
//	         $('html,body').removeClass('noscroll');
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
//	 							if(i < 4){
									append += '	<li>';
//	 							}else{
//	 								append += '	<li style="display:none;">';
//	 							}
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

<div id="content">
	<div class="brand_wrap category_wrap">
		<div class="topTit_brand clear">
			<div class="tit_round<c:if test='${not empty brand.brandImageUrl}'> img</c:if>"><!-- 이미지가 있으면, tit_round에 img : class 추가 -->
				<c:if test='${not empty brand.brandImageUrl}'>
					<ui:image src="${brand.brandImageUrl}" server="brand" alt="${brand.brandName}"/>
				</c:if>
			</div>
			<div class="tit_brand">
				<c:if test="${!empty brand.brandEngName}">
					<h2 class='brand_en'>
						<c:choose>
							<c:when test="${fn:length(brand.brandEngName) > 20}">
								${fn:substring(brand.brandEngName,0,18)}...
							</c:when>
							<c:otherwise>
								${brand.brandEngName}
							</c:otherwise>
						</c:choose>
					</h2>
					<p class='h2_line'></p>
				</c:if>
				<h3 class='brand_ko'>${brand.brandName}</h3>
				<p class='h3_line'></p>
			</div>
			<div class="tit_like">
				<a href="javascript:" onclick="addBizWishBrand('${brand.brandId}')" class='btn_like<c:if test="${brand.wishUserBrandCnt ne '0'}"> on</c:if> ${brand.brandId}'><!-- 활성화시 on : class 추가 -->
					<i></i>
					<c:set var="wishBrandCnt" value="${brand.wishBrandCnt}"/>	
					<c:if test="${brand.wishBrandCnt > 999}"><c:set var="wishBrandCnt" value="999+"/></c:if>
					<span class='font_t brandTxt' code="${brand.brandId}">${wishBrandCnt}</span>
				</a>
			</div>
			<div class="tit_text">
				<p class=''>${brand.brandDesc}</p>
			</div>
			<c:if test='${fn:length(fn:trim(brand.brandDesc)) > 50}'>
				<div class="tit_arr">
					<a href="javascript:"><img src="/images/biz/sub/icon_select_arrow.png" alt="더보기"></a>
				</div>
			</c:if>
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
											<a href="/m/biz/eventDetail?eventId=${l.eventId}">
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
								
								<!-- swiper-pagination -->
								<div class="pagination_wrap">
									<div class="swiper-pagination"></div>
								</div>
							</div>
						</c:when>
						<c:otherwise>
							<div class="event_bnr"><!-- 이미지가 1개인 경우 -->
								<ul>
									<li>
										<c:forEach items="${eventList}" var="l">
											<a href="/m/biz/eventDetail?eventId=${l.eventId}">
												<div class="img_wrap">
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
		<div class="viewer-wrap">
			<div class="content-wrap">
				<div class="title-wrap">
					<h2>Viewer</h2>
					<p>핫트랙스의 시선으로 브랜드를 바라보다</p>
				</div>
				<div class="youtube-wrap" id="viewerApi"></div>
			</div>
		</div>
		<!-- 판매베스트 추가 -->
		<c:if test="${not empty listBestProduct}">
		<div class="pd_unit">
			<div class="btit">
				<h3><strong>판매베스트</strong></h3>
			</div>
			<div class="swiper-container">
				<div class="swiper-wrapper">
					<c:forEach items="${listBestProduct}" var="l" varStatus="st">
					<div class="swiper-slide">
						<a href="javascript:;" onclick="location.href='/p/${l.sellPrdtBcode}';return false;">
							<div class="thum<c:if test="${not empty param.imgRound && param.imgRound eq 'Y'}"> round</c:if>">
								<c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G' || l.sellPrdtGbn eq 'S'}">
				                    <ui:image src="${l.productImageUrl}" src2="${l.productImageUrl2}" size="400" server="product" alt="${fn:escapeXml(l.prdtName)}"/>
				                  </c:if>
								<c:if test="${l.sellPrdtGbn eq 'R'}">
									<ui:image rcrdCd="${l.rcrdCd}" size="400" prdtGbn="${l.sellPrdtGbn}" alt="${fn:escapeXml(l.prdtName)}" rcrdImgType="large" ratingCode="A"/>
								</c:if>
				             	<c:if test="${l.sellPrdtGbn eq 'D'}">
				               		<ui:image rcrdCd="${l.rcrdCd}" size="400" prdtGbn="${l.sellPrdtGbn}" alt="${fn:escapeXml(l.prdtName)}" rcrdImgType="large" ratingCode="A"/>
				              	</c:if>
							</div>
						</a>
						<!-- 클릭시 active : class 추가 -->
						<a href="javascript:" onclick="addBizWishProduct(this);return false;" class="btn_like<c:if test="${l.wishUserPrdtCnt > 0}"> active</c:if>" prdtId="${l.sellPrdtBcode}"><span>좋아요</span></a>
						<a href="javascript:;" onclick="location.href='/p/${l.sellPrdtBcode}';return false;">
							<div class="cont">
								<p class="brand">${l.brandName}</p>
								<p class="tit">${l.prdtName}</p>
								<p class="price font_t">
                                       <c:if test="${l.prdtSellPrice > l.lastCpnPrice}">
											<fmt:parseNumber var="rate" integerOnly="true" value="${hfn:rate(l.prdtSellPrice, l.lastCpnPrice)}"/>
											<span class="percent">${rate}%</span>
										</c:if>
										<span><fmt:formatNumber value="${l.lastCpnPrice}" pattern="#,###"/></span>
										<c:if test="${l.prdtSellPrice > l.lastCpnPrice}">
											<span class="discount"><fmt:formatNumber value="${l.prdtSellPrice}" pattern="#,###"/></span>
										</c:if>
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
					                   <c:if test="${fn:substring(l.prdtIcon,0,1) eq '1'}">
											<span class="badge01">쿠폰</span>
					                   </c:if>
					                   <c:if test="${fn:substring(l.prdtIcon,2,3) eq '1'}">
					                   		<span class="badge02">사은품</span>
					                   	</c:if>
					                   <c:if test="${fn:substring(l.prdtIcon,8,9) eq '1'}">
					                   		<span class="badge02">무료배송</span>
					                   </c:if>
                                   </div>
							</div>
						</a>
					</div>
					</c:forEach>
				</div>
				<!-- 스크롤바 -->
				<div class="swiper-scrollbar"></div>
			</div>
		</div>
		</c:if>
        <!--/ 판매베스트 추가 -->

		<div class="choice_wrap">
			<div class="pd_filter">
				<div class="form_select">
					<select id="selectOption" name="ctgrId" class='resize_select' title="상품 분류 선택" onchange="location.href='/m/biz/hot/brandDetail?brandId=${c.brandId}&productOrderBy=${c.productOrderBy}&ctgrId='+this.value;">
						<option value="">전체</option>
			            <c:forEach items="${listCateogry}" var="l" varStatus="st">
			                <option value="${l.ctgrId}"<c:if test="${c.ctgrId eq l.ctgrId}"> selected="selected"</c:if>>${l.ctgrName}</option>
			            </c:forEach>
					</select>
				</div>
			</div>
			<div class="pd_filter">
				<p class="pd_total"><em class="font_t"><fmt:formatNumber type="number">${totalListCount}</fmt:formatNumber></em>건
					<a href="javascript:">
						<label class="form_checkbox ${c.saleYn}">
						<c:set var="orderLink" value="/m/biz/hot/brandDetail?brandId=${brand.brandId}&ctgrId=${c.ctgrId}&page=1&productListType=${c.productListType}&listSize=${c.listSize}&productOrderBy=${c.productOrderBy}"/>
							<input type="checkbox" name="saleYn" <c:if test="${c.saleYn eq 'N'}"> checked="true"</c:if> onclick="$('.pd_total [type=checkbox]').attr('checked')?location.href='${orderLink}&saleYn=Y':location.href='${orderLink}&saleYn=N';">
							<span class="icon"></span>
							품절포함
						</label>
					</a>
				</p>
				<div class="form_select">
					<select name="productOrderBy" title="정렬 순서 선택" onchange="location.href='/m/biz/hot/brandDetail?brandId=${c.brandId}&ctgrId=${c.ctgrId}&saleYn=${c.saleYn}&productOrderBy='+this.value;">
						<option value="R"<c:if test="${c.productOrderBy eq 'R'}"> selected="selected"</c:if>>신상품순</option>
						<option value="P"<c:if test="${c.productOrderBy eq 'P'}"> selected="selected"</c:if>>판매량순</option>
						<option value="L"<c:if test="${c.productOrderBy eq 'L'}"> selected="selected"</c:if>>낮은가격순</option>
			            <option value="H"<c:if test="${c.productOrderBy eq 'H'}"> selected="selected"</c:if>>높은가격순</option>
			            <option value="T"<c:if test="${c.productOrderBy eq 'T'}"> selected="selected"</c:if>>높은할인율순</option>
			            <option value="W"<c:if test="${c.productOrderBy eq 'W'}"> selected="selected"</c:if>>좋아요순</option>
			            <option value="Q"<c:if test="${c.productOrderBy eq 'Q'}"> selected="selected"</c:if>>상품평순</option>   
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

		<div class="pagination_v2">	        	   
           <ui:bizpaginationScript name="pageHolder" scriptName="goList"/>
       </div>
		<script>
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
	                width: '100',
	                height: '',
	                videoId: videoId["${brand.brandId}"],
					playerVars: {
						rel: 0,
		                showinfo: 0,
		                fs: 0,
		                playsinline: 1
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
</div>
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