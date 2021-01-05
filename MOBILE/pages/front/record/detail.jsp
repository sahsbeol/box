<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="bizFull"></ui:decorator>
<html>
<head>
<title>[NEW ME 핫트랙스] ${ext.prdtName}</title>
<!--  SNS 공유 내용 -->
<meta property="og:type" content="website">
<meta property="og:title" content="${fn:escapeXml(p.commTitle)}">
<meta property="og:url" content="http://m.hottracks.co.kr/p/${p.sellPrdtBcode}">
<meta property="og:description" content="${fn:escapeXml(p.artiName)}">
<meta property="og:image" content="${productImageUrl}">
<!--  SNS 공유 내용 -->

<!-- 레코벨 스크립트 -->
<meta property="eg:type" content="product" />
<meta property="eg:cuid" content="e15e978e-3623-4892-bf0a-485b9f8196ee" />
<meta property="eg:itemId" content="${ext.sellPrdtBcode}" />
<meta property="eg:itemName" content="${ext.prdtName}" />
<meta property="eg:itemImage" content="${productImageUrl}" />
<meta property="eg:itemUrl" content="http://m.hottracks.co.kr/p/${ext.sellPrdtBcode}" />
<meta property="eg:originalPrice" content="${ext.prdtSellPrice}" />
<meta property="eg:salePrice" content="${ext.lastCpnPrice}" />
<c:set var="ctgrNavi" value="${fn:split(fn:replace(category.ctgrNamePath, ' ', ''), '>')}"/>
<c:if test="${fn:startsWith(category.ctgrId, '0003')}">
	<meta property="eg:category1" content="0003" />
	<c:forEach items="${ctgrNavi}" var="l" varStatus="st" begin="2">
		<meta property="eg:category${st.index}" content="${fn:substring(category.ctgrId, 0, (st.count+2)*2)}" />
		<c:if test="${st.last}">
			<meta property="eg:category${st.index+1}" content="${category.ctgrId}" />
		</c:if>
	</c:forEach>
</c:if>
<c:if test="${fn:startsWith(category.ctgrId, '0004')}">
    <meta property="eg:category1" content="0004" />
    <c:forEach items="${ctgrNavi}" var="l" varStatus="st" begin="2">
        <meta property="eg:category${st.index}" content="${fn:substring(category.ctgrId, 0, (st.count+2)*2)}" />
        <c:if test="${st.last}">
	    	<meta property="eg:category${st.index+1}" content="${category.ctgrId}" />
	    </c:if>
    </c:forEach>
</c:if>
<meta property="eg:brandId" content="" />
<meta property="eg:brandName" content="${ext.labelName}" />
<meta property="eg:regDate" content="${ext.regDate}" />
<meta property="eg:updateDate" content="" />
<meta property="eg:stock" content="" />
<meta property="eg:state" content="" />
<c:choose>
    <c:when test="${ext.sellPrdtGbn == 'R'}">
        <meta property="eg:description" content="음반" />
    </c:when>
    <c:when test="${ext.sellPrdtGbn == 'D'}">
        <meta property="eg:description" content="DVD" />
    </c:when>
    <c:otherwise>
        <meta property="eg:description" content="기프트" />
    </c:otherwise>
</c:choose>
<meta property="eg:extraImage" content="" />
<meta property="eg:locale" content="KR" />
<c:choose>
    <c:when test="${ext.lastCpnPrice >= 20000}">
    	<meta property="eg:freeShipping" content="Y" />
    </c:when>
    <c:otherwise>
    	<meta property="eg:freeShipping" content="N" />
    </c:otherwise>
</c:choose>
<c:choose>
    <c:when test="${ext.lastCpnPrice < 10000}">
        <meta property="eg:priceRange" content="1" />
    </c:when>
    <c:when test="${ext.lastCpnPrice < 20000}">
        <meta property="eg:priceRange" content="2" />
    </c:when>
    <c:when test="${ext.lastCpnPrice < 30000}">
        <meta property="eg:priceRange" content="3" />
    </c:when>
    <c:otherwise>
        <meta property="eg:priceRange" content="" />
    </c:otherwise>
</c:choose>

<!-- 데이타 스토리  script-->
<script type="text/javascript">
var ctgrId = '${category.ctgrId}';
var ctgrName = '${category.ctgrName}'.trim();
var ctgrPath = '${category.ctgrNamePath}'.replace(/ /gi, "").split('>');
ctgrPath.push(ctgrName);

if(ctgrId.startsWith('0003')){
	_n_p1='CD'; 			// 대카테고리명	
}else{
	_n_p1='DVD'; 			// 대카테고리명
}
_n_p2=ctgrPath[2]; 			// 중카테고리명
_n_p3=ctgrPath[3]; 			// 소카테고리명 
_n_p4=ctgrPath[4]; 			// 세카테고리명
_n_p5='${ext.prdtName}'; 	// 상품명 
</script>
<!-- 데이타 스토리  script end-->

<script type="text/javascript" src="/js/jquery.form.js"></script>
<script type='text/javascript' src='//logger.eigene.io/js/logger.min.js'></script>
<script type="text/javascript" src="/js/mOrder.js?201703151633"></script>
<style type="text/css">
.sns input{border : 0px; line-height: 35px; width : 25px; color :#898989; }
.like_cnt{ outline:none; }
.like_img{ position: fixed; top: 35%; z-index: 999; overflow: initial; width: 100%; text-align: center;}
.like_img img{width : 200px; }
</style>
<script type="text/javascript">
var histSwiper = null;
var isSpec = false;
var isOption = false;
var isOrderMake = false;
jQuery(function($){
    $(document).ready(function(){
    	$('#loading').remove();	
    	$('#subTitle').html('상품상세');
    	
        $("#wrap").addClass("content_new");
        $(".like_img").show();
        goReviewList('1');
        goQnaList('1');
        
        var userAgent = navigator.userAgent.toUpperCase();
        var prdtName = '${ext.prdtName}';
        prdtName = prdtName.replace(/&/g, ' and ');
        
        // 문자보내기 ios/android 에 따라서 바꿈
        if(userAgent.match(/IPHONE/) || userAgent.match(/IPAD/)){
            
            var version = navigator.appVersion.toUpperCase();
            $(".share_box .sms").removeAttr('href');
            
            if(version.match(/8./) || version.match(/9./)|| version.match(/10./)|| version.match(/11./))
                $(".share_box .sms").attr('href' , 'sms:&body='+prdtName +' http://m.hottracks.co.kr/p/${ext.sellPrdtBcode}');
            else
                $(".share_box .sms").attr('href' , 'sms:;body='+prdtName +' http://m.hottracks.co.kr/p/${ext.sellPrdtBcode}');
            
            $(".share_box .sms").show();
            $(".copy").hide();
            
        }else if(userAgent.match(/ANDROID/)){
            $(".share_box .sms").removeAttr('href');
            $(".share_box .sms").attr("href","sms://?body="+prdtName+" http://m.hottracks.co.kr/p/${ext.sellPrdtBcode}");
            $(".share_box .sms").show();
            $(".copy").show();
        }else{
            $(".share_box .kakao").hide();
            $(".share_box .sms").hide();
        }
        
        $("#prodDesc").load("/m/record/detail/desc/${ext.rcrdCd}?sellPrdtBcode=${ext.sellPrdtBcode}");
                
        if(getToday('${ext.okdate}'))
            $(".reserve").show();
        else
            $(".reserve").hide();
        
        // 최근본상품 등록
        //saveRecentProduct("${ext.sellPrdtBcode}");
        
        //정보고시 품명 및 모델명 삭제
        $('#notiPrdtName').hide();
    });
    
    // 상세이미지
    var detailImage = new Swiper('.detail_image .swiper-container',{
        speed: 1000,
        watchOverflow: true,            
        pagination: '.detail_image .swiper-pagination',
        paginationType: 'fraction'
    });
    
    // 카테고리 베스트
    var cateBest = new Swiper('.detail_best .swiper-container',{
        slidesPerView: 'auto',
        speed: 1000,
        freeMode: true,
        scrollbar: '.detail_best .swiper-scrollbar',
        draggable: true
    });
    
    // 카테고리 신상품
    var cateNew = new Swiper('.detail_new .swiper-container',{
        slidesPerView: 'auto',
        speed: 1000,
        freeMode: true,
        scrollbar: '.detail_new .swiper-scrollbar',
        draggable: true
    });
    
    $("#btnDetailMore").click(function(){
        var detail = $(document).find(".product-detail");
        if(detail.hasClass("active")){
            detail.removeClass("active");
            $(this).find("span").text("상세 이미지 더보기");
        }else{
            detail.addClass("active");
            $(this).find("span").text("상세 이미지 접기");
        }
    });
    
    $("button.up").click(function(){
        var productCount = $(".prdtCnt");
        productCount.val(parseInt(productCount.val()) + 1);
        $(".count [type=number]").val(productCount.val()); 
        calcTotPrice();
    });
    
    $("button.down").click(function(){
        var productCount = $(".prdtCnt");
        if(parseInt(productCount.val()) > 1){
            productCount.val(parseInt(productCount.val()) - 1);
            $(".count [type=number]").val(productCount.val()); 
        }else{
            alert("최소 1개 이상 구매 가능합니다.");
        }
        calcTotPrice();
    });
    
    function calcTotPrice(){
        price = parseInt("${ext.lastCpnPrice}");
        cnt = parseInt($(".prdtCnt").val());
        $(".amount").text(price_format(price * cnt) + "원");
    }
    
    $(".count [type=number]").change(function(){
        if($(this).val() < 1){
            alert("최소 1개 이상 구매 가능합니다.");
            $(this).val("1"); 
        }
        $(".prdtCnt").val($(this).val()); 
        calcTotPrice();
    });
});

function goBuyProudct(){
    if($(".detail_input").hasClass("active")){
        onClickBuyNow();
    }else{
        $(".detail_input").addClass("active");
    }
}

function goCartProudct(){
    if($(".detail_input").hasClass("active")){
        cartAdd();
    }else{
        $(".detail_input").addClass("active");
    }
}

function toggleInput(){
    if($(".detail_input").hasClass("active")){
        $(".detail_input").removeClass("active");
    }else{
        $(".detail_input").addClass("active");
    }
}

function goReviewList(page){
    if($.trim(page) == "")    page = 1;
    $('#detail_cont02').load('/m/gift/detail/review/${ext.sellPrdtBcode}?rcrdCd=${ext.rcrdCd}&page=' + page);
}
function goQnaList(page){
    if($.trim(page) == "")    page = 1;
    $('#detail_cont03').load('/m/gift/detail/qna/${ext.sellPrdtBcode}?rcrdCd=${ext.rcrdCd}&page=' + page);
}

function getToday(okdate){
    var okdate = new Date((okdate).substr(0,4),(okdate).substr(4,2)-1, (okdate).substr(6,2));
    okdate = okdate.getTime();
    
    var today = new Date();
    today = today.getTime();
    
    if(okdate < today){
        return false;
    }else{
        return true;
    }
}

function dwonProductCoupon(){
    var barcode = "${ext.sellPrdtBcode}";
    if (isSpec) {
        if ($('select[name="specGroup"]').val() == '') {
            alert('옵션값은 생략 할 수 없습니다');
            return;
        }else{
            barcode = $('select[name="specGroup"]').val();
        }
    }
    
    if (isEmpty(barcode))    alert("오류가 발생하였습니다.");
    else {
        <c:if test='${!isLogin}'>
            needLogin();
        </c:if>
        <c:if test='${isLogin}'>
            location.href="/m/coupon/couponList4Prdt?sellPrdtBcode="+barcode;
        </c:if>
    }
}

function addWishProduct2(sellPrdtBcode, prdtName) {
    <c:if test='${!isLogin}'>
        needLogin();
    </c:if>
    <c:if test='${isLogin}'>
        $.ajax({
            type: 'GET'
            ,url: '/m/gift/addWishProduct'
            ,data: 'sellPrdtBcode=' + sellPrdtBcode
            ,dataType: 'json'
            ,async: false
            ,success: function(data) {
                var size = data.errorMessages.length;
                if (size == 0) {                    
                    var l = parseInt($(".like_cnt").val());
                    if(l != 999){
	                    l = l+1;
	                    $(".like_cnt").val(l);
                    }
                    
                    $(".sns a.like").attr('onclick','').unbind('click');
                    $(".sns a.like").attr('class','like_full');
                    $(".sns a.like_full").attr("onclick",'removeWishProduct2(\''+sellPrdtBcode+'\',\''+prdtName+'\'); return false;');
                    
                } else {
                    alert('<fmt:message key="error.common.system"/>');
                    location.reload();
                }
            }
            ,error: function(data) {
                alert('<fmt:message key="error.common.system"/>');
            }
        });
    </c:if>
}

function removeWishProduct2(sellPrdtBcode, prdtName) {
    <c:if test='${!isLogin}'>
        needLogin();
    </c:if>
    <c:if test='${isLogin}'>
        $.ajax({
            type: 'GET'
            ,url: '/m/gift/removeWishProduct'
            ,data: 'sellPrdtBcode=' + sellPrdtBcode
            ,dataType: 'json'
            ,async: false
            ,success: function(data) {
                var size = data.errorMessages.length;
                if (size == 0) {
                    $(".sns a.like_full").attr('onclick','').unbind('click');
                    $(".sns a.like_full").attr('class','like');
                    
                    var l = parseInt($(".like_cnt").val());
                    if(l != 999){
	                    l = l-1;
	                    $(".like_cnt").val(l);
                    }
                    
                    $(".sns a.like").attr("onclick",'addWishProduct2(\''+sellPrdtBcode+'\',\''+prdtName+'\'); return false;');
                } else {
                    alert(data.errorMessages);
                }
            }
            ,error: function(data) {
                alert('<fmt:message key="error.common.system"/>');
            }
        });
    </c:if>
}

function getHistory() {
	if(histSwiper == null){
		$.ajax({
	        type: "POST"
	        ,url: "/m/biz/history"
	        ,dataType: "html"
	        ,success : function(html){		        	
	            $("#ly_biz_recent").append(html);         
	            histSwiper = new Swiper('#history_wrapper > .swiper-container', {
	                direction: 'vertical',
	                slidesPerView: 'auto',
	                mousewheelControl: true,
	                freeMode: true
	           });
	            historyOpen();
	        }
	        ,error: function(data) {
	        	console.log('on error!');
	        }
	    });
	} else {
		historyOpen();
	}
}

function historyOpen(){
	$('body').addClass('fixed').on('touchmove', function(e){e.preventDefault();return false;});
    $('#header').append('<div class="dim"></div>').css({zIndex:98});
    gnbClose();
    TweenLite.to($('#header .dim'),0.7,{ease:Power4.easeOut,opacity:0.8});
    TweenLite.to($('#history_wrapper'),0.6,{ease:Power4.easeOut,left:0,onComplete:function(){
        histSwiper.onResize();
    }});
}

$(window).load(function() {
	var userId= getCookie("UserCookieKey");

	window._eglqueue = window._eglqueue || [];
	_eglqueue.push(['setVar','cuid','e15e978e-3623-4892-bf0a-485b9f8196ee']);
	_eglqueue.push(['setVar','itemId','${ext.sellPrdtBcode}']);
	_eglqueue.push(['setVar','userId',SHA256(userId)]);
	_eglqueue.push(['setVar','searchTerm','']); 
	_eglqueue.push(['setVar','brandId','']); 
	_eglqueue.push(['setVar','categoryId','${fn:substring(category.ctgrId, 0, 8)}']);	
	_eglqueue.push(['track','view']);
	_eglqueue.push(['track','product']);  /* -- IMPORTANT -- */
	(function(s,x){s=document.createElement('script');s.type='text/javascript';
	s.async=true;s.defer=true;s.src=(('https:'==document.location.protocol)?'https':'http')+'://logger.eigene.io/js/logger.min.js';
	x=document.getElementsByTagName('script')[0];x.parentNode.insertBefore(s, x);})();
});
</script>
<style>
#app_bar {display:none !important;}
#btn_top {display:none !important;}
#btn_down {display:none !important;}
.foot_btn.btn_top {display:none !important;}
.foot_btn.btn_down {display:none !important;}
</style>
</head>
<body>
<div id="content">
<input type="hidden" id="prdtGbn" value="${ext.sellPrdtGbn}">

<!-- .nav -->
<div class="nav_v2">
	<div class="location_nav_wrap pd10_0">
		<div class="ichome_a">
	    	<a href="/"><div class="ichome">HOME</div></a>
	    </div>
    <c:set var="ctgrNavi" value="${fn:split(fn:replace(category.ctgrNamePath, ' ', ''), '>')}"/>
    <div class="swiper-container">
	    <div class="swiper-wrapper">
	        <c:if test="${fn:startsWith(category.ctgrId, '0003')}">
	            <div class="swiper-slide"><a href="/m/record/biz/category/0003">CD</a></div>
	            <c:forEach items="${ctgrNavi}" var="l" varStatus="st" begin="2">
	                <div class="swiper-slide"><a href="/m/record/biz/category/${fn:substring(category.ctgrId, 0, (st.count+2)*2)}">${l}</a></div>
	            </c:forEach>
	        </c:if>
	        <c:if test="${fn:startsWith(category.ctgrId, '0004')}">
	            <div class="swiper-slide"><a href="/m/dvd/biz/category/000401">DVD</a></div>
	            <c:forEach items="${ctgrNavi}" var="l" varStatus="st" begin="2">
	                <div class="swiper-slide"><a href="/m/dvd/biz/category/${fn:substring(category.ctgrId, 0, (st.count+2)*2)}">${l}</a></div>
	            </c:forEach>
	        </c:if>
	        <div class="swiper-slide active"><a href="/m/dvd/biz/category/${category.ctgrId}">${category.ctgrName}</a></div>
	    </div>
    </div>
    </div>
</div>
<!-- //.nav -->
<!-- 상세 -->
<div class="detail_wrap">
    <!-- swiper -->
    <div class="detail_image media">
        <div class="swiper-container">
            <ul class="swiper-wrapper">
                <li class="swiper-slide">
                    <ui:image prdtGbn="${ext.sellPrdtGbn}" rcrdCd="${ext.rcrdCd}" rcrdImgType="large" ratingCode="${ext.rtngCode}" alt="${fn:escapeXml(ext.prdtName)}" clazz="prdt-photo sns_img kakao-img"/>
                    <c:if test="${posterCaseCnt>0}"><span class="ico_event gift">GIFT</span></c:if>
                </li>
            </ul>
            <!-- Add Pagination -->
        	<div class="swiper-pagination"></div>
        </div>
    </div>
    <!-- //swiper -->
    
    <!-- 상품 정보 -->
    <div class="detail_info nb_line">
        <div class="top_tit">
            <div class="badge">
                <c:set var="ico_cnt" value="0"/>
                <c:if test="${ext.mediaName ne 'VCD' && fn:startsWith(ext.ctgrId, '000400') && ico_cnt < 4}"><c:set var="ico_cnt" value="${ico_cnt+1}"/><span class="badge02">블루레이</span></c:if>
                <c:if test="${ext.mediaName ne 'VCD' && fn:startsWith(ext.ctgrId, '000401') && ico_cnt < 4}"><c:set var="ico_cnt" value="${ico_cnt+1}"/><span class="badge02">DVD</span></c:if>
                <c:if test="${posterCaseCnt>0 && ico_cnt < 4}"><c:set var="ico_cnt" value="${ico_cnt+1}"/><span class="badge01">지관통포스터</span></c:if>
                <c:if test="${not empty couponList && ico_cnt < 4}"><c:set var="ico_cnt" value="${ico_cnt+1}"/><span class="badge01">쿠폰</span></c:if>
                <c:if test="${freeGift && ico_cnt < 4}"><c:set var="ico_cnt" value="${ico_cnt+1}"/><span class="badge02">사은품</span></c:if>
                <c:if test="${ext.impYn && ico_cnt < 4}"><c:set var="ico_cnt" value="${ico_cnt+1}"/><span class="badge02">수입</span></c:if>
                <c:if test="${ext.rcrdStat eq '9' && ico_cnt < 4}"><c:set var="ico_cnt" value="${ico_cnt+1}"/><span class="badge02">예약</span></c:if>
                 <c:if test="${!ext.saleYn && ico_cnt < 4}">
                    <c:choose>
                        <c:when test="${ext.rcrdStat eq '0' || ext.rcrdStat eq '1' || ext.rcrdStat eq '6'}"><c:set var="ico_cnt" value="${ico_cnt+1}"/><span class="badge03">일시품절</span></c:when>
                        <c:when test="${ext.rcrdStat eq '3'}"><c:set var="ico_cnt" value="${ico_cnt+1}"/><span class="badge03">품절</span></c:when>
                        <c:otherwise><c:set var="ico_cnt" value="${ico_cnt+1}"/><span class="badge03">품절</span></c:otherwise>
                    </c:choose>
                </c:if>
            </div>
            <a class="brand_media"><span>${ext.labelName}</span></a>
            <h2>
                <c:if test="${!(ext.mediaName eq 'VCD' && fn:startsWith(ext.ctgrId, '0004') && ico_cnt < 4)}">${ext.artiName} - </c:if>
                ${ext.prdtName}
            </h2>
            <c:if test="${not empty ext.rcrdSubComments}"><span class="event">${ext.rcrdSubComments}</span></c:if>
            <c:if test="${empty ext.rcrdSubComments}">
                <c:forEach items="${eventList}" var="l" varStatus="st" end="0">
                    <a href="/m/biz/eventDetail?eventId=${l.eventId}"><span class="event">${l.eventTitle}</span></a>
                </c:forEach>
            </c:if>
        </div>

        <dl class="info">
            <!-- 최종판매가 -->
            <dt class="lastPrice"><span>최종판매가</span></dt>
            <dd class="lastPrice"><strong><fmt:formatNumber type="number">${ext.lastCpnPrice}</fmt:formatNumber></strong>원</dd>
            <!-- #최종판매가 -->
            
            <dt>판매가</dt>
            <dd><fmt:formatNumber type="number">${ext.prdtSellPrice}</fmt:formatNumber>원</dd>
            <c:if test="${ext.prdtSellPrice ne ext.lastDcPrice}">
                <dt>할인판매가</dt>
                <dd>
                    <em class="col_red"> 
                    	[                        		
                        <fmt:parseNumber var="pricePercent" value="${hfn:rate(ext.prdtSellPrice,ext.lastDcPrice)}" integerOnly="true" />
						${pricePercent}%
                        ]</em>
                    <fmt:formatNumber type="number">${ext.lastDcPrice}</fmt:formatNumber>원
                </dd>
            </c:if>
            
            <dt>배송비</dt>
            <dd class="t_r">
                <c:choose>
                    <c:when test="${ext.lastCpnPrice >= 20000}">핫트랙스 배송 무료배송</c:when>
                    <c:otherwise>
                        2,000원<br/>
                        20,000원 이상 구매시 무료
                    </c:otherwise>
                </c:choose>
            </dd>
            <c:if test="${ext.prdtSavedRate > 0 && ext.prdtSavedPrice > 0}">
                <dt>통합포인트</dt>
                <dd><fmt:formatNumber type="number">${ext.prdtSavedPrice}</fmt:formatNumber>원</dd>
            </c:if>
            <dt>카드혜택</dt>
                <dd>
                <a href="javascript:toggleLayer('#layerCard');" class="btn_tooltip bt_sbgr">신용카드 할인안내</a>
                <div id="layerCard" class="toggle-layer">
                    <div id="ly_header">
                        <h1>신용카드 할인안내</h1>
                    </div>
                    <div id="ly_content">
                        <div class="rating_star">
                            <p class="mt10">
                                <strong>신한카드</strong>
                                <p>2~6개월, 12개월(부분) 무이자</p>
                            </p>
                            <p class="mt10">
                                <strong>하나카드</strong>
                                <p>2~3개월 무이자</p>
                            </p>
                            <p class="mt10">
                                <strong>국민카드</strong>
                                <p>2~5개월 무이자</p>
                            </p>
                            <p class="mt10">
                                <strong>비씨, NH농협, 현대, 삼성카드</strong>
                                <p>2~6개월 무이자</p>
                            </p>
                            <p class="mt10">
                                <strong>유의사항</strong>
                                <p>법인,체크,선불,기프트,하이브리드 제외</p>
                                <p>무이자 적용 최소결제 금액 등 상세 내용은<br/>결제 팝업창에서 확인 요망</p>
                            </p>
                        </div>
                        <%-- <div class="rating_star mt20">
                            <p class="mt10"><img src="${imageServer}/images/order/txt_m_sscard2.png" alt="삼성카드"/></p>
                            <p class="mt10">
                                <strong>삼성카드 3만원 이상 결제 시 2,500원 즉시할인</strong>
                                <p>이벤트 기간 : 2020.03.16 ~ 소진 시</p>
                                <p>신용카드 결제 창에서 쿠폰 적용이 된 경우 해당되며, 쿠폰 적용이 되지 않을 경우 조건에 부합하지 않거나, 쿠폰 수량이 모두 소진된 경우입니다.</p>
                            </p>
                        </div> --%>
                        <a href="javascript:toggleLayer('#layerCard');" class="btn_cls">닫기</a>
                    </div>
                </div>
            </dd>
        </dl>
        <c:forEach items="${couponList}" var="l" varStatus="st" end="0">
            <div class="btn_area box_flex pd0_20 mb20">
                <a href="#" onclick="dwonProductCoupon();return false;" class="bt_mbgb">쿠폰받기</a>
            </div>
        </c:forEach>
        <div class="sns">
        <div class="like_img"></div>
            <c:if test="${not empty ext.offlineUrl}">
                <a href="${ext.offlineUrl}" class="offline">핫트픽업 매장수령</a>
            </c:if>
            <c:if test="${ext.sellPrdtBcode ne '8809646801369' && ext.sellPrdtBcode ne '8809646801345' && ext.sellPrdtBcode ne '8809646801352' }">
            	<a href="#" onclick="toggleSlide('.ly_stock_box');return false;" class="stock">매장 재고수량</a>
            </c:if>

			<c:choose>
		        <c:when test = "${ext.wishPrdtCnt > 999}">
		        	<c:set var="wishCnt" value="999+" />
		        </c:when>
		        <c:otherwise>
		         	<c:set var="wishCnt" value="${ext.wishPrdtCnt}" />
				</c:otherwise>
			</c:choose>

            <c:if test="${ext.wishUserPrdtCnt ne '0'}"><!-- 내가 클릭한 경우가 있으면 -->
                <a href="#" onclick="removeWishProduct2('${ext.sellPrdtBcode}', '${fn:escapeXml(ext.prdtName)}');return false;" class="like_full"  title="좋아요 추천수"><input class="like_cnt"  onfocus="this.blur();" value="${wishCnt}" readonly="readonly" size="3";/></a>
            </c:if>
            <c:if test="${ext.wishUserPrdtCnt eq '0'}"><!-- 내가 클릭한 경우가 없으면 -->
                <a href="#" onclick="addWishProduct2('${ext.sellPrdtBcode}', '${fn:escapeXml(ext.prdtName)}');return false;" prdtId="${ext.sellPrdtBcode}" class="like" title="좋아요 추천수">
                	<input class="like_cnt" value="${wishCnt}" readonly="readonly" size="3"; onfocus="this.blur();"/>
                </a>                
            </c:if>
        
            <a href="#" onclick="toggleSlide('.share_box');return false;" class="share">공유하기</a>
            <div class="share_box">
                <a href="#" onclick="goTwitter('${fn:escapeXml(ext.prdtName)}', 'http://m.hottracks.co.kr/p/${ext.sellPrdtBcode}');return false;" class="twitter"><span class="mlm2">트위터</span></a>
                <a href="#" onclick="goFaceBook('${fn:escapeXml(ext.prdtName)}', 'http://m.hottracks.co.kr/p/${ext.sellPrdtBcode}');return false;" class="facebook"><span>페이스북</span></a>
                <a href="#" onclick="sendKakao('[핫트랙스] ${fn:escapeXml(ext.prdtName)}', 'http://m.hottracks.co.kr/p/${ext.sellPrdtBcode}');return false;" class="kakao"><span>카카오톡</span></a>
                <a href="#" onclick="goPinterest('${ext.prdtName}', 'http://m.hottracks.co.kr/p/${ext.sellPrdtBcode}');return false;" class="pinterest"><span class="mlm3">핀터레스트</span></a>
                <a href="#" onclick="urlClipCopy('http://m.hottracks.co.kr/p/${ext.sellPrdtBcode}');return false;" class="copy"><span>상품복사</span></a>
                <a class="sms"><span class="mlm3">문자보내기</span></a>
            </div>
            <c:import url="/m/record/layerRecordStock?rcrdCd=${ext.rcrdCd}"/>
        </div>
        <div class="noti">
	        <p class="noti-ko">음반 판매자료는<br><span class="c_red">온/오프라인 동일하게&nbsp;</span>한터차트와<br>뮤직뱅크 차트, 가온차트 <span class="c_red">판매량 집계에 100%</span> 반영됩니다.</p>
	        <p>Music sales data from both ON&amp;OFF LINE STORES, Would be 100% counted for HANTEO CHART/MUSIC BANK CHART/GAON CHART.</p>
	    </div>
    </div>
    <!-- //상품 정보 -->
    <div class="giftStockedInfoRequest"></div>
    <!-- 주문 정보 -->
    <div class="detail_input">
        <a href="#" onclick="toggleInput();return false;" class="btn_toggle">토글버튼</a>
        <a href="#" onclick="locBack();return false;" class="btn_back">뒤로</a>
        <a href="/m/record/detail/desc/${ext.rcrdCd}?sellPrdtBcode=${ext.sellPrdtBcode}&sngl=Y" class="btn_detail">확대보기</a>
        <%-- <c:choose>
            <c:when test="${not empty listRecent}">
		       <a href="#" onclick="getHistory();return false;" class="btn_recent">
	              <c:forEach items="${listRecent}" var="l" varStatus="st" end="0">
	                  <c:if test="${l.sellPrdtGbn ne 'R' && l.sellPrdtGbn ne 'D'}"><ui:image src="${l.productImageUrl}" server="product" size="150" ssl="${pageContext.request.scheme eq 'http'?'N':'Y'}"/></c:if>
	                  <c:if test="${l.sellPrdtGbn eq 'R'}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="R" ratingCode="A" alt="${l.prdtName}" ssl="${pageContext.request.scheme eq 'http'?'N':'Y'}"/></c:if>
	                  <c:if test="${l.sellPrdtGbn eq 'D'}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="D" ratingCode="A" alt="${l.prdtName}" ssl="${pageContext.request.scheme eq 'http'?'N':'Y'}"/></c:if>
	              </c:forEach>
		       </a>
            </c:when>
            <c:otherwise><a href="#" onclick="getHistory();return false;" id="btnSidem" class="btn_history" /></c:otherwise>
        </c:choose> --%>
        <c:choose>
            <c:when test="${not empty listRecent}">
		       <a href="#" onclick="getHistory();return false;" class="btn_recent">
	               <c:forEach items="${listRecent}" var="l" varStatus="st" end="0">
	                   <c:if test="${l.sellPrdtGbn ne 'R' && l.sellPrdtGbn ne 'D'}"><ui:image src="${l.productImageUrl}" server="product" size="150" ssl="${pageContext.request.scheme eq 'http'?'N':'Y'}"/></c:if>
	                   <c:if test="${l.sellPrdtGbn eq 'R'}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="R" ratingCode="A" alt="${l.prdtName}" ssl="${pageContext.request.scheme eq 'http'?'N':'Y'}"/></c:if>
	                   <c:if test="${l.sellPrdtGbn eq 'D'}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="D" ratingCode="A" alt="${l.prdtName}" ssl="${pageContext.request.scheme eq 'http'?'N':'Y'}"/></c:if>
	               </c:forEach>
		       </a>
            </c:when>
            <c:otherwise><a href="#" onclick="getHistory();return false;" id="btnSidem" class="btn_history" /></c:otherwise>
        </c:choose>
        <a href="javascript:void(0)" class="btn_top">위로</a>
        <div class="order_input">
            <c:if test="${not empty options}">
                <c:forEach items="${options}" var="l" varStatus="st">
                    <ui:select clazz="select select_black options${!st.first?' mgt5':''}" iD="${l.optnName}" name="${l.optnKey}" key="${l.optnKey}" title="${l.optnName}">${l.optnName}<fmt:message key="label.select.required"/></ui:select>
                </c:forEach>
            </c:if>
            <c:if test="${ext.saleYn}">
                <div class="ord_price" id="ord${ext.sellPrdtBcode}">
                    <div class="count ml10">
                        <button type="button" title="1개씩 감소" class="down">감소</button>
                        <input type="number" name="prdtCnt" id="prdtCnt" number="prdtCnt" class="prdtCnt" min="0" max="" value="1" title="주문수량 입력" style="width: 100%;height: 30px;border: 1px solid #ccc; text-align: center;font-size: 16px;color: #000;"/>
                        <button type="button" title="1개씩 증가" class="up">증가</button>
                    </div>
                    <span class="amount mr10"><fmt:formatNumber type="number">${ext.lastDcPrice}</fmt:formatNumber><span>원</span></span>
                </div>
            </c:if>
            <dl class="amount_price">
                <dt>총합계</dt>
                <dd><fmt:formatNumber type="number">${ext.lastDcPrice}</fmt:formatNumber><span>원</span></dd>
            </dl>
        </div>
        <div class="detail_order">
            <c:choose>
                <c:when test="${ext.saleYn}">                    
                     <div class="btn_area box_flex bg_eeeeee">
                        <a href="#" onclick="goCartProudct();return false;" class="bt_mbrb">장바구니</a>
                        <a href="#" onclick="goBuyProudct();return false;" class="bt_mbgb ml10">바로구매</a>
                     </div>
                </c:when>
<%--                 <c:when test="${ext.outOfStockMailYn eq 'Y'}">
                    <div class="btn_area box_flex bg_eeeeee">
                        <a href="#" onclick="addGiftStockedInfoRequest('${ext.sellPrdtBcode}');return false;" class="bt_mbgb">알림 신청하기</a>
                    </div>
                </c:when> --%>
                <c:otherwise>
                    <p class="t_c col_salmon f14 pd10"><strong>현재 판매가 중지된 상품입니다.</strong></p>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
    <!-- //주문 정보 -->

    <!-- 상세 탭메뉴 -->
    <div class="detail_tab">
        <ul class="tab_btn">
            <li><a href="#detail_cont01" class="on">상품설명</a></li>
            <li><a href="#detail_cont02" id="detail_tab02">상품후기</a></li>
            <li><a href="#detail_cont03" id="detail_tab03">Q&amp;A</a></li>
        </ul>
    </div>
    <!-- //상세 탭메뉴 -->
    
    <div class="tab_pannels">
        <!-- 상품설명 -->
        <div class="tab_cont" id="detail_cont01">
            <h2 class="hid_obj">상품설명</h2>
            <c:if test="${not empty ext.offlineUrl}">
                <div class="pd0_20"><p class="tiptxt">※ 핫트픽업 예약주문이란?<br/>앨범 출시 전 예약주문 기간 내, 핫트랙스 온라인으로 예약주문을 하고, 공지되어있는 수령일에 핫트랙스 오프라인 매장으로 고객님께서 방문하여 수령하시는 주문방식입니다. 이 주문은 별도 배송이 되지 않으며, 선택하신 매장 외 다른 매장에서는 수령이 불가합니다.</p></div>
            </c:if>
            <c:if test="${not empty ext.rcrdMdMemo}">
                <div class="pd0_20"><p class="tiptxt">${ext.rcrdMdMemo}</p></div>
            </c:if>
            <c:if test="${not empty ext.okdate  }">
                <p class="reserve f14 col_black pd0_20 mb20">예약판매 : <ui:mask pattern="####.##.##">${ext.okdate}</ui:mask> 발매예정</p>
            </c:if>
                    
            <c:if test="${not empty prdtNotiInfo}">
                <c:import url="/pages/front/gift/import/layerDetail${prdtNotiInfo.gbnCode}.jsp" charEncoding="utf-8"/>
            </c:if>
            <c:if test="${empty prdtNotiInfo}">
                <ul class="txt_list">
                    <li>상품고시정보 준비중입니다.</li>
                </ul>
            </c:if>
            <ul class="accordion">
                <li>
                    <a href="#n">배송안내</a>
                    <div class="cont">
                        <p>
                            - 핫트랙스 배송 : 2만원 이상 구매 시 무료배송/ 2만원 미만 구매 시 배송비 2,000원<br/>
                            - 브랜드별 배송 : 브랜드 정책에 따라 무료배 혹은 배송비 부과 (상품상세정보에서 배송비 기준 확인가능)<br/>
                            <br/>
                            * 배송비<br/>
                            - 도서, 산간, 오지, 일부지역, 설치배송 상품 등은 배송비가 추가될 수 있습니다.<br/>
                            - 무료배송 상품과 함께 구입 시, 기준금액 미만으로 구입하시더라도 해당 브랜드 상품은 무료배송 됩니다.<br/>
                            - 핫트랙스 배송과 브랜드 개별 배송비는 별도로 부과 됩니다.<br/>
                            <br/>
                            * 배송기간 및 방법<br/>
                            - 결제 완료 후, 1~5일 이내에 배송 됩니다. (단, 상품의 재고 상황이나 배송 상황, 지역특성에 따라 배송이 지연될 수 있습니다.)<br/>
                            - 주문제작 상품 및 가구와 같은 업체 직배송 상품은 제작기간과 배송시기를 별도 확인하시기 바랍니다.
                        </p>
                    </div>
                </li>
                <li>
                    <a href="#n">반품교환</a>
                    <div class="cont">
                        <p>
                            -상품 설명에 반품/교환 관련 안내가 있는 경우 그 내용을 우선으로 합니다. (업체 사정에 따라 변경 될 수 있습니다.)<br/>
                            -브랜드별 배송 : 브랜드 정책에 따라 무료배송 혹은 배송비 부과 (상품상세정보에서 배송비 기준 확인가능)<br/>
                            <br/>
                            * 반품/교환 방법<br/>
                            -MY HOTTRACKS > 주문정보 > 반품/교환신청<br/>
                            -고객센터 > SOS상담<br/>
                            -고객센터 (1661-1112)<br/>
                            <br/>
                            * 반품/교환가능 기간<br/>
                            -변심반품의 경우 수령 후 7일 이내, 상품의 결함 및 계약내용과 다를 경우 문제점 발견 후 30일 이내<br/>
                            -상품불량 및 오배송 등의 이유로 반품/교환을 하실 경우 반품/교환비는 무료 입니다.<br/>
                            (단, 판매자가 반품된 상품 확인 후 상품불량이 아닌 것으로 확인 될 시 반송비를 고객님께 부과할 수 있습니다.)<br/>
                            -고객변심으로 인한 교환/반품의 배송비는 고객님 부담 입니다.<br/>
                            -고객변심으로 인한 교환/반품 시 주문에 사용된 할인쿠폰은 반환되지 않습니다.<br/>
                            <br/>
                            * 반품/교환 불가사유<br/>
                            -반품/교환 가능 기간을 초과한 경우<br/>
                            -소비자의 책임 있는 사유로 상품 등이 손실 또는 훼손된 경우 (단지 확인을 위한 포장 훼손은 제외)<br/>
                            -소비자의 사용, 포장 개봉에 의해 상품 등의 가치가 현저히 감소한 경우 (예: 밀봉상품, 제품 수선, 세탁, 기타 사용/분리/훼손)<br/>
                            -설치상품의 경우 설치가 완료되어 상품의 가치가 훼손된 경우 (예: 설치가전, 가구, 식품 등)<br/>
                            -소비자의 요청에 따라 개별적으로 주문 제작되는 상품의 경우<br/>
                            -시간의 경과에 의해 재판매가 곤란한 정도로 가치가 현저히 감소한 경우<br/>
                            -전자상거래 등에서의 소비자보호에 관한 법률이 정하는 소비자 청약철회 제한 내용에 해당되는 경우<br/>
                            -복제가 가능한 상품 등의 포장을 훼손한 경우 (예: 음반/DVD/비디오, 소프트웨어, 영상화보집)<br/>
                        </p>
                    </div>
                </li>
                <li>
                    <a href="#n">기타사항</a>
                    <div class="cont">
                        <p>
                            -상품의 불량에 의한 교환, A/S, 환불, 품질보증 및 피해보상 등에 관한 사항은 소비자분쟁해결 기준 (공정거래위원회 고시)에 준하여 처리됨<br/>
                            -대금 환불 및 환불지연에 따른 배상금 지급 조건, 절차 등은 전자상거래 등에서의 소비자 보호에 관한 법률에 따라 처리함<br/>                            
                        </p>
                    </div>
                </li>
            </ul>
            <!-- 상품 상세 배너   -->
            <c:if test="${not empty bnrPrdtDetail}">
                <c:forEach var="l" varStatus="st" items="${bnrPrdtDetail}">
                    <p style="text-align:center;margin:20px 0;">
                        <c:if test="${l.linkUrl ne '#'}"> 
                            <a href="${l.linkUrl }"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${l.imgUrl }" style="width:100%;"/></a>
                        </c:if>
                        <c:if test="${l.linkUrl eq '#'}"> 
                            <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${l.imgUrl }" style="width:100%;"/>
                        </c:if>
                    </p>
                </c:forEach>
            </c:if>
            <div id="prodDesc"></div>
        </div>
        <!-- //상품설명 -->

        <!-- 상품후기 -->
        <div class="tab_cont" id="detail_cont02"></div>
        <!-- //상품후기 -->

        <!-- QnA -->
        <div class="tab_cont" id="detail_cont03"></div>
        <!-- //QnA -->
    </div>

<div class="recobell_list_a">
    <div class="recobell_list">
        <!-- category best -->
        <h2>${category.ctgrName}베스트</h2>
        <div class="category detail_best">
            <div class="swiper-container">
                <div class="swiper-wrapper">
                    <c:forEach items="${bestList}" varStatus="s1" step="2" end="5">
                        <div class="swiper-slide" id="slide${s1.index}">
                            <c:forEach items="${bestList}" var="l" begin="${s1.index}" end="${s1.index+1}">
                                    <a href="/m/record/detail/${l.sellPrdtBcode}">
                                        <div class="thum">
                                        	<ui:image prdtGbn="${l.sellPrdtGbn}" rcrdCd="${l.rcrdCd}" ratingCode="${l.rtngCode}" style="height:${l.sellPrdtGbn eq 'R'?'138':'138'}px" alt="${fn:escapeXml(l.prdtName)}"/>
                                        </div>
                                        <div class="desc">
	                                        <div class="txt">${l.prdtName}</div>
	                                        <div class="price font_t">
	                                            <c:if test="${l.prdtSellPrice>l.lastCpnPrice}">
	                                            	<span class="percent">
	                                            		<fmt:parseNumber var="bestPercent" value="${hfn:rate(l.prdtSellPrice,l.lastCpnPrice)}" integerOnly="true" />
	                                        			${bestPercent}%
	                                            	</span>
	                                            </c:if>
	                                            <fmt:formatNumber type="number">${l.lastCpnPrice}</fmt:formatNumber>
	                                        </div>
                                        </div>
                                    </a>
                              </c:forEach>
                        </div>
                    </c:forEach>
                </div>
                <!-- 스크롤바 -->
                <div class="swiper-scrollbar"></div>
            </div>
        </div>
    </div>
        <!-- //category best -->

	<div class="recobell_list">
        <!-- new item -->
        <h2>${category.ctgrName}신상품</h2>
        <div class="category detail_new">
            <div class="swiper-container">
                <div class="swiper-wrapper">
                    <c:forEach items="${newList}" varStatus="s1" step="2" end="5">
                        <div class="swiper-slide" id="slide${s1.index}">
                            <c:forEach items="${newList}" var="l" begin="${s1.index}" end="${s1.index+1}">
                                    <a href="/m/record/detail/${l.sellPrdtBcode}">
                                        <div class="thum">
                                        	<ui:image prdtGbn="${l.sellPrdtGbn}" rcrdCd="${l.rcrdCd}" ratingCode="${l.rtngCode}" style="height:${l.sellPrdtGbn eq 'R'?'138':'138'}px" alt="${fn:escapeXml(l.prdtName)}"/>
                                        </div>
                                        <div class="desc">
	                                        <div class="txt">${l.prdtName}</div>
	                                        <div class="price font_t">
	                                            <c:if test="${l.prdtSellPrice>l.lastCpnPrice}">
	                                            	<span class="percent">
	                                            		<fmt:parseNumber var="newPercent" value="${hfn:rate(l.prdtSellPrice,l.lastCpnPrice)}" integerOnly="true" />
	                                        			${newPercent}%
	                                            	</span>
	                                            </c:if>
	                                            <fmt:formatNumber type="number">${l.lastCpnPrice}</fmt:formatNumber>
	                                        </div>
                                        </div>
                                    </a>
                            </c:forEach>
                        </div>
                    </c:forEach>
                </div>
                <!-- 스크롤바 -->
                <div class="swiper-scrollbar"></div>
            </div>
        </div>
    </div>
    <!-- //new item -->
</div>

</div>
<!-- //상세 -->

	<div id="formBaseHtml">
	    <input type="hidden" value="${ext.sellPrdtBcode}" name="sellPrdtBcode">
	    <input type="hidden" value="1" name="prdtCount" class="prdtCnt">
	</div>

	<FORM name="sForm" id="sFormDiv" method="post"></FORM>  <!-- 장바구니 담기 Form -->
</div>
</div>
</body>
</html>