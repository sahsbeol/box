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
<c:if test="${ext.sellPrdtBcode eq '2310029966439' || ext.sellPrdtBcode eq '2310040221104'}">
    <!-- 네이버수집제외 -->
    <meta name="robots" content="noindex.nofollow">
</c:if>

<!--  SNS 공유 내용 -->
<meta property="og:type" content="website">
<meta property="og:title" content="${fn:escapeXml(ext.prdtName)}">
<meta property="og:url" content="http://m.hottracks.co.kr/p/${ext.sellPrdtBcode}">
<meta property="og:description" content="${fn:escapeXml(ext.brandEngName)}">
<meta property="og:image" content="${productImageUrl}">

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
<c:forEach items="${ctgrNavi}" var="l" varStatus="st" begin="2">
    <meta property="eg:category${st.index-1}" content="${fn:substring(category.ctgrId, 0, (st.count+2)*2)}" />
    <c:if test="${st.last}">
    	<meta property="eg:category${st.index}" content="${category.ctgrId}" />
    </c:if>
</c:forEach>
<meta property="eg:brandId" content="${ext.brandId}" />
<meta property="eg:brandName" content="${ext.brandEngName}" />
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
    <c:when test="${!ext.codDlvyAmtYn && ext.lastFreeDlvyYn}">
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
var ctgrName = '${category.ctgrName}'.trim();
var ctgrPath = '${category.ctgrNamePath}'.replace(/ /gi, "").split('>');
ctgrPath.push(ctgrName);

_n_p1=ctgrPath[2]; 			// 대카테고리명
_n_p2=ctgrPath[3]; 			// 중카테고리명
_n_p3=ctgrPath[4]; 			// 소카테고리명 
_n_p4=ctgrPath[5]; 			// 세카테고리명
_n_p5='${ext.prdtName}'; 	// 상품명 
</script>
<!-- 데이타 스토리  script end-->

<style type="text/css">
.like_cnt{ outline:none; }
</style>
<!--  SNS 공유 내용 -->
<c:set var="tmpKey" value="2017061611435"/>
<script type="text/javascript" src="/js/jquery.form.js?${tmpKey }"></script>
<script type='text/javascript' src='//logger.eigene.io/js/logger.min.js'></script> 
<script type="text/javascript" src="/js/mOrder.js?${tmpKey }"></script>

<%-- 상품 중요정보 세팅 --%>
<script type="text/javascript" src="/js/ht.product.detail.1.0.0.js?20190328"></script>

<script type="text/javascript">
var histSwiper = null;

jQuery(function($){
    $(document).ready(function(){
    	$('#loading').remove();	
    	$('#subTitle').html('상품상세');
    	
        $("#wrap").addClass("content_new");
        $("#likeLayer").show();
        goReviewList('1');
        goQnaList('1');
        
        _init("${ext.sellPrdtBcode}");
        
        $("select[name='specPrdtBcode']").find("option:first").attr('selected','selected');

        var userAgent = navigator.userAgent.toUpperCase();
        var prdtName = "${ext.prdtName}";
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
            
            var prdtName = "${ext.prdtName}";
            prdtName = prdtName.replace(/&/g, ' and ');
            $(".share_box .sms").attr("href","sms://?body="+prdtName+" http://m.hottracks.co.kr/p/${ext.sellPrdtBcode}");
            $(".share_box .sms").show();
            $(".copy").show();
        }else{
            $(".share_box .kakao").hide();
            $(".share_box .sms").hide();
        }
        
        $("#prodDesc").load("/m/gift/detail/desc/${ext.sellPrdtBcode}", function(){ $("#prodDesc *").css("max-width", "100%"); });
        $(".detail_product_img *").css("max-width", "100%");
        
        // nav
        var nav = new Swiper('.location_nav_wrap .swiper-container',{
            watchOverflow: true,
        });
        
     // 상세이미지
        var detailImage = new Swiper('.detail_image .swiper-container',{
            speed: 1000,
            watchOverflow: true,            
            pagination: '.detail_image .swiper-pagination',
            paginationType: 'fraction'
        });
        
        // 이 상품과 같이 본 상품
        var cateBest = new Swiper('.detail_recobell .swiper-container',{            
            slidesPerView: 'auto',
            speed: 1000,
            freeMode: true,
            scrollbar: '.detail_recobell .swiper-scrollbar',
            draggable: true
        });
        
        // 함께 구매하기 좋은상품
        var cateNew = new Swiper('.detail_recobell2 .swiper-container',{
            slidesPerView: 'auto',
            speed: 1000,
            freeMode: true,
            scrollbar: '.detail_recobell2 .swiper-scrollbar',
            draggable: true
        });

        // 브랜드 연관상품
        var cateNew = new Swiper('.detail_recobell3 .swiper-container',{
            slidesPerView: 'auto',
            speed: 1000,
            freeMode: true,
            scrollbar: '.detail_recobell3 .swiper-scrollbar',
            draggable: true
        });
        
        // 최근본상품 등록
        //saveRecentProduct("${ext.sellPrdtBcode}");
    });
    
    $(".prdtCnt").change(function(){
        var value = $(this).val();
        if (isEmpty(value))    $(this).val("1");
        else if ($product.isSpec) {
        } else {
            var rtnMsg = $cart.prdtCnt.update(value);
            if(rtnMsg)    alert(rtnMsg);
            
            $(this).val($cart.prdtCnt.value);
        }
        
        _calcTotalAmt();
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
    
    $('.accordion_q > li > a').click(function(){
        if($(this).hasClass("on")){
            $(this).removeClass('on');
        }else{
            $('.accordion_q > li a').removeClass('on');
            $(this).addClass('on');
        }
    });
    
    $("input[name=engracode]").click(function() {
        var engracode = $(this).val();
        var info = engracode.split("|") || [];
        var price = info[1];
        
        if(info.length >= 3) {
            var lastDiscountPrice = "${ext.lastCpnPrice}";
            if(!isNaN(lastDiscountPrice) && lastDiscountPrice >= 20000 && info.length == 4) {
                price = 0;
            }

            $("#carving-face").val(info[0]);
            $("#price").val(price);
            $("#carving-contents").focus();
        }
    });

    /* 탭메뉴:sub */
    $(".ctab_cont:not("+$(".ctab_btn a.on").attr("href")+")").hide();
    $(".ctab_btn li a").click(function(){
        $(".ctab_btn li a").removeClass("on");
        $(this).addClass("on");
        $(".ctab_cont").hide();
        $($(this).attr("href")).show();
        return false;
    });

    /* 탭메뉴:sub */
    $(".ftab_cont:not("+$(".ftab_btn a.on").attr("href")+")").hide();
    $(".ftab_btn li a").click(function(){
        $(".ftab_btn li a").removeClass("on");
        $(this).addClass("on");
        $(".ftab_cont").hide();
        $($(this).attr("href")).show();
        return false;
    });
    
    if("${tab}" == "detail_tab02"){
    	$("#detail_tab01").removeClass();
    	$("#detail_tab02").addClass("on");
    	$("#detail_tab01").removeClass();
    	$("#detail_cont01").css("display","none");
        $("#detail_cont02").css("display","block");
    	
        var scrollPosition = $("#detail_tab02").offset().top;
        
        moveScroll(scrollPosition-65);
    }
});

function calDist(touches){
    var x1 = touches[0].screenX;
    var y1 = touches[0].screenY;
    var x2 = touches[1].screenX;
    var y2 = touches[1].screenY;
    return Math.sqrt((x1-x2)*(x1-x2) + (y1-y2)*(y1-y2));
}

function goBuyProudct(){
    if($(".detail_input").hasClass("active")){
        $order.order('order');
        // onClickBuyNow();
    }else{
        toggleInput();
    }

}

function goCartProudct(){
    if($(".detail_input").hasClass("active")){
        $order.order('cart');
        // cartAdd();
    }else{
        toggleInput();
    }
}

function toggleInput(){
    if($(".detail_input").hasClass("active")){
        $(".detail_input").removeClass("active");
        $("body").removeClass("fixed");
    }else{
        $(".detail_input").addClass("active");
        $("body").addClass("fixed");
    }
}

function goReviewList(page){
    if($.trim(page) == "")    page = 1;
    $('#detail_cont02').load('/m/gift/detail/review/${ext.sellPrdtBcode}?page=' + page);
}
function goQnaList(page){
    if($.trim(page) == "")    page = 1;
    $('#detail_cont03').load('/m/gift/detail/qna/${ext.sellPrdtBcode}?page=' + page);
}

function incPrdtCnt(sellPrdtBcode){
    var rtnMsg = $cart.prdtCnt.increase();
    if(rtnMsg)    alert(rtnMsg);
    $("#prdtCnt").val($cart.prdtCnt.value);
    
    _calcTotalAmt();
}

function decPrdtCnt(sellPrdtBcode){
    var rtnMsg = $cart.prdtCnt.decrease();
    if(rtnMsg)    alert(rtnMsg);
    $("#prdtCnt").val($cart.prdtCnt.value);
    
    _calcTotalAmt();
}

function dwonProductCoupon(){
    var barcode = "${ext.sellPrdtBcode}";
    if ($product.isSpec) {
        if ($cart.option.list.length < 1) {
            alert('옵션값은 생략 할 수 없습니다');
            document.getElementById("specGroup").focus();
            return;
        }else{
            barcode = document.getElementById("specGroup").value;
            document.getElementById("specGroup").value = "";
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

function setParentWindowCarvedSealInfo() {
    if($("#carving-contents").val() == "") {
        alert("각인 내용을 입력해 주세요.");
        return false;
    } else {
        var str = $("#carving-contents").val();
        var len = 0;
        for(var i=0; i<str.length; i++) {
            len += str.charCodeAt(i) < 128? 1 : 2;
        }
        
        if(len > 20) {
            alert("한글 10자, 영문 20자까지 가능합니다.");
            return false;
        }
    }

    if($("input[name=engracode]:checked").length == 0) {
        alert("각인 서체를 선택해 주세요.");
        return false;
    }
    
    var engracode = $("input[name=engracode]:checked").val();
    var carvedSealInfoArr = engracode.split("|") || [];
    
    setCarvedSealInfo(carvedSealInfoArr, $("#carving-contents").val());
    toggleCvsl();
}

function toggleCvsl(){
    if(${!isLogin}){
        needLogin();
    }else{
        toggleLayerFull('#layerCvsl');
    }
}

function setCarvedSealInfo(info, cvslCont) {
    var addPrice = 5000;
    if(info.length >= 3) {
        var payYn = true;
        if($product && $product.lastDcPrice >= 20000 && info.length == 4) {
            payYn = false;
            addPrice = 0;
        }
        
        var cvslBcode = payYn?info[2]:"2300000032307";
        
        $cart.cvsl = { cvslBcode:cvslBcode, cvslCont:cvslCont, cvslFont:info[0] };
    }else{
        $cart.cvsl = null;
    }
    
    var obj = document.getElementById("cvslOrder");
    _removeChild(obj);
    
    if($cart.cvsl){
        var dl01 = _createSimpleElement("dl");
        dl01.appendChild(_createSimpleElement("dt", "각인서체"));
        dl01.appendChild(_createSimpleElement("dd", $cart.cvsl.cvslFont));
        obj.appendChild(dl01);
        
        var dl02 = _createSimpleElement("dl");
        dl02.appendChild(_createSimpleElement("dt", "각인내용"));
        dl02.appendChild(_createSimpleElement("dd", $cart.cvsl.cvslCont));
        obj.appendChild(dl02);
        
        var dl03 = _createSimpleElement("dl", null, "mb10");
        dl03.appendChild(_createSimpleElement("dt", "추가금액"));
        dl03.appendChild(_createSimpleElement("dd", price_format(addPrice), "col_red"));
        obj.appendChild(dl03);
    }
}

function toggleShareBox(){
    if($(".share_box").is(":visible")){
        $(".share_box").slideUp();
    }else{
        $(".share_box").slideDown();
    }
}

function checkOrderMakeCont(obj){
    var orderMakeCont = obj.value;
    var re1 = '\r\n';  //개행문자를 나타내는 정규표현식
    var re2 = '\n';    //개행문자를 나타내는 정규표현식
    var re3 = "'";     //아포스트로피 체크
    
    var errMsg;
    if(orderMakeCont.indexOf(re3) > -1){
        errMsg = "제작문구에 아포스트로피(')를 사용할수 없습니다.";
        orderMakeCont = orderMakeCont.split(re3).join(" ");
    }else if(orderMakeCont.indexOf(re1) > -1){
        errMsg = "제작문구에 줄바꿈을 사용할수 없습니다.";
        orderMakeCont = orderMakeCont.split(re1).join(" ");
    }else if(orderMakeCont.indexOf(re2) > -1){
        errMsg = "제작문구에 줄바꿈을 사용할수 없습니다.";
        orderMakeCont = orderMakeCont.split(re2).join(" ");
    }
    
    var chk = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ-_0123456789\~!@#$%^&*()_+| ";
    var length = 0;
    var lastIdx = 0;
    for(var i=0; i < orderMakeCont.length; i++){
        if(chk.indexOf(orderMakeCont.charAt(i)) >= 0 )   length++;
        else                                             length+=2;
        if(length < 202) lastIdx = i;
    }
    if(length > 200){
        errMsg = "제작문구는 200Byte(한글 100자, 영문 200자)이상 작성할 수 없습니다.";
        orderMakeCont.substring(0, lastIdx);
    }
    
    if(errMsg){
        alert(errMsg);
        obj.value = orderMakeCont;
    }
    
    $cart.orderMakeCont = orderMakeCont;
}
$(window).load(function() {
	$('iframe').css('height', '233px');
	
	var userId= getCookie("UserCookieKey");

	window._eglqueue = window._eglqueue || [];
	_eglqueue.push(['setVar','cuid','e15e978e-3623-4892-bf0a-485b9f8196ee']);
	_eglqueue.push(['setVar','itemId','${ext.sellPrdtBcode}']);
	_eglqueue.push(['setVar','userId',SHA256(userId)]);
	_eglqueue.push(['setVar','searchTerm','']); 
	_eglqueue.push(['setVar','brandId','${ext.brandId}']);
	_eglqueue.push(['setVar','categoryId','${fn:substring(category.ctgrId, 0, 8)}']);	
	_eglqueue.push(['track','view']);
	_eglqueue.push(['track','product']);  /* -- IMPORTANT -- */
	(function(s,x){s=document.createElement('script');s.type='text/javascript';
	s.async=true;s.defer=true;s.src=(('https:'==document.location.protocol)?'https':'http')+'://logger.eigene.io/js/logger.min.js';
	x=document.getElementsByTagName('script')[0];x.parentNode.insertBefore(s, x);})();
});

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

function goTest(sellPrdtBcode) {
	location.href="/m/gift/detailtest/"+sellPrdtBcode;
}
</script>
<style>
#app_bar {display:none !important;}
#btn_top {display:none !important;}
#btn_down {display:none !important;}
.foot_btn.btn_top {display:none !important;}
.foot_btn.btn_down {display:none !important;}

.gift_box_a {
    background-color: #f1f1f1;
    height: 70px;
    padding-right: 20px;
    font-family: 'Noto Sans KR', 'Apple SD Gothic Neo', sans-serif;
    overflow-x: hidden;
}
.gift_box_a .gift_tag_a {
    float: left;
    background-color: #da2128;
    height: 100%;
    color: #fff;
    width: 60px;
}
.gift_box_a .gift_tag_a strong {
    display: block;
    padding: 24px 10px 20px;
    font-size: 16px;
}
.gift_box_a a {
    display: flex;
    cursor: pointer;
}   
.gift_box_a a .gift_txt {
    float: left;
    padding: 5px 0px 6px 15px;
    font-size: 12px;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
    width:100%;
}
.gift_box_a a .gift_txt strong {
    font-size: 14px;
}
.gift_box_a a .gift_txt p {
    width: 100%;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
}
.gift_box_a a .gift_txt .date {
    margin-top: 3px;
}
.gift_box_a a .gift_click {
    background: url(http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/mobile/common/btn_right02.png)no-repeat;
    background-position-y: center;
    background-position-x: center;
    background-size: 12px;
    height: 70px;
    width: 20px;
    float: right;
}    
@keyframes txt_move {
    0%,60% {top:0;}
	30% {top:-0.1em;}
}
@-webkit-keyframes txt_move {
    0%,60% {top:0;}
	30% {top:-0.1em;}
}
.gift_box_a .gift_tag_a.txt_move strong i {
    position:relative; display:inline-block; animation:txt_move 1s infinite; font-style:normal; 
}
.gift_box_a .gift_tag_a.txt_move strong i:nth-child(1){animation-delay:0.1s;}
.gift_box_a .gift_tag_a.txt_move strong i:nth-child(2){animation-delay:0.2s;}
.gift_box_a .gift_tag_a.txt_move strong i:nth-child(3){animation-delay:0.3s;}
.gift_box_a .gift_tag_a.txt_move strong i:nth-child(4){animation-delay:0.4s;}
.gift_box_a .gift_tag_a.txt_move strong i:nth-child(5){animation-delay:0.5s;}
#footer {padding: 0 0 160px 40px;}
</style>

</head>
<body>
<div id="content">
	<!-- .nav -->
	<div class="nav_v2">
		<div class="location_nav_wrap pd10_0">
			<div class="ichome_a">
	        	<a href="/"><div class="ichome">HOME</div></a>
	    	</div>
		    <c:set var="ctgrNavi" value="${fn:split(fn:replace(category.ctgrNamePath, ' ', ''), '>')}"/>
		    <div class="swiper-container">
			    <div class="swiper-wrapper">
			        <c:forEach items="${ctgrNavi}" var="l" varStatus="st" begin="2">
			            <div class="swiper-slide"><a href="/m/gift/biz/category/${fn:substring(category.ctgrId, 0, (st.count+2)*2)}">${l}</a></div>
			        </c:forEach>
			        <div class="swiper-slide active"><a href="/m/gift/biz/category/${category.ctgrId}">${category.ctgrName}</a></div>
			    </div>
		    </div>
		</div>
	</div>
	<!-- //.nav -->

<c:forEach var="l" items="${freeGiftList}" varStatus="index">
     <c:if test="${index.last}">
     	<div class="gift_box_a">
		    <div class="gift_tag_a txt_move">
		        <strong><i>G</i><i>I</i><i>F</i><i>T</i></strong>
		    </div>
		    <c:if test="${not empty l.eventId}">
		    	<a href="/e/${l.eventId}">
		    </c:if>
		    <c:if test="${empty l.eventId}">
		    	<a href="#n">
		    </c:if>
		        <div class="gift_txt">
		           <strong>${l.freeGiftName}</strong>
		           <p>${l.freeGiftDesc}</p>
					<c:if test="${not empty l.eventId}">
						<p class="date">
			           		<fmt:parseDate value="${l.eventStartDate}" var="eventSdate" pattern="yyyyMMdd"/>
			           		<fmt:parseDate value="${l.eventEndDate}" var="eventEdate" pattern="yyyyMMdd"/>
			           		<fmt:formatDate value="${eventSdate}" pattern="yyyy.MM.dd"/> ~ <fmt:formatDate value="${eventEdate}" pattern="yyyy.MM.dd"/>
						</p>
				    </c:if>
				    <c:if test="${empty l.eventId}">
						<p class="date">
			           		<fmt:parseDate value="${l.giftPrdtPrsntStartDt}" var="eventSdate" pattern="yyyyMMdd"/>
			           		<fmt:parseDate value="${l.giftPrdtPrsntEndDt}" var="eventEdate" pattern="yyyyMMdd"/>
			           		<fmt:formatDate value="${eventSdate}" pattern="yyyy.MM.dd"/> ~ <fmt:formatDate value="${eventEdate}" pattern="yyyy.MM.dd"/>
						</p>
				    </c:if>
		        </div>
		        <c:if test="${not empty l.eventId}">
			        <div class="gift_click"></div>
			    </c:if>
		    </a>
		</div>
     </c:if>
</c:forEach>

<!-- 상세 -->
<div class="detail_wrap">
    <!-- 상세이미지 -->
    <div class="detail_image">
        <div class="swiper-container">
            <ul class="swiper-wrapper">
                <c:forEach items="${imageList}" var="l" varStatus="st">
                    <li class="swiper-slide">
                        <ui:image src="${l.prdtImageUrl}" server="product" alt="${fn:escapeXml(ext.prdtName)}" clazz="prdt-photo sns_img${st.first?' kakao-img':''}"/>
                    </li>
                </c:forEach>
            </ul>
            <!-- Add Pagination -->
        	<div class="swiper-pagination"></div>
        </div>
    </div>
    <!-- / 상세이미지 -->
    
    <!-- 상품 정보 -->
    <div class="detail_info">
        <div class="top_tit">
            <div class="badge">
                <c:set var="ico_cnt" value="0"/>
                <c:if test="${ext.prdtStatCode eq 'C0313' && ico_cnt < 4}"><c:set var="ico_cnt" value="${ico_cnt+1}"/><span class="badge03">일시품절</span></c:if>
                <c:if test="${ext.prdtStatCode ne 'C0312' && ext.prdtStatCode ne 'C0313' && ico_cnt < 4}"><c:set var="ico_cnt" value="${ico_cnt+1}"/><span class="badge03">품절</span></c:if>
                <c:if test="${ext.lastDcPrice ne ext.lastCpnPrice && ico_cnt < 4}"><c:set var="ico_cnt" value="${ico_cnt+1}"/><span class="badge01">쿠폰</span></c:if>
                <c:if test="${ext.cvslYn && ico_cnt < 4}"><c:set var="ico_cnt" value="${ico_cnt+1}"/><span class="badge02">각인</span></c:if>
                <c:if test="${ext.orderMakeYn && ico_cnt < 4}"><c:set var="ico_cnt" value="${ico_cnt+1}"/><span class="badge02">주문제작</span></c:if>
                <c:if test="${not empty freeGiftList && fn:length(freeGiftList) > 0 && ico_cnt < 4}"><c:set var="ico_cnt" value="${ico_cnt+1}"/><span class="badge02">사은품</span></c:if>
                <c:if test="${ext.limitCount < maxLimitCount && ico_cnt < 4}"><c:set var="ico_cnt" value="${ico_cnt+1}"/><span class="badge02">한정</span></c:if>
                <c:if test="${ext.prdtSellPrice ne ext.lastDcPrice && ico_cnt < 4}"><c:set var="ico_cnt" value="${ico_cnt+1}"/><span class="badge02">할인</span></c:if>
            </div>
            <a href="/m/biz/hot/brandDetail?brandId=${ext.brandId}" class="brand"><span>${ext.brandEngName}</span></a>
            <h2>${ext.prdtName}</h2>
            <c:set var="cnt" value="0"/>
            <c:forEach items="${eventList}" var="l" varStatus="st">
                <c:if test="${l.eventTypeCode eq 'C019H'}"><c:set var="heartEvtId" value="${l.eventId}"/></c:if>
                <c:if test="${l.eventTypeCode eq 'C019I'}"><c:set var="storyEvtId" value="${l.eventId}"/></c:if>
                <c:if test="${l.eventTypeCode ne 'C019H' && l.eventTypeCode ne 'C019I' && cnt eq 0}">
                    <c:set var="cnt" value="1"/>
                    <a href="/m/biz/eventDetail?eventId=${l.eventId}"><span class="event mt5">${l.eventTitle}</span></a>
                </c:if>
            </c:forEach>
        </div>
        <dl class="info">
            <!-- 최종판매가 -->
            <dt class="lastPrice"><span>최종판매가</span></dt>
            <dd class="lastPrice"><strong><fmt:formatNumber type="number">${ext.lastCpnPrice}</fmt:formatNumber></strong>원</dd>
            <!-- #최종판매가 -->
            
            <c:choose>
                <c:when test="${ext.prdtSellPrice ne ext.lastCpnPrice}">
                    <dt>판매가</dt>
                    <dd>
                        <em class="col_red">
                        	[                        		
                        		<fmt:parseNumber var="pricePercent" value="${hfn:rate(ext.prdtSellPrice, ext.lastCpnPrice)}" integerOnly="true" />
								${pricePercent}%
                        	]
                        </em>
                        <fmt:formatNumber type="number">${ext.prdtSellPrice}</fmt:formatNumber>원
                    </dd>
                </c:when>
                <c:otherwise>
                    <dt>판매가</dt>
                    <dd><fmt:formatNumber type="number">${ext.prdtSellPrice}</fmt:formatNumber>원</dd>
                </c:otherwise>
            </c:choose>
            <dt>배송비</dt>
            <dd class="t_r">
                <c:choose>
                    <c:when test="${ext.codDlvyAmtYn}">${ext.dlvyVndrId ne '0625'?'업체':'핫트랙스'} 착불배송</c:when>
                    <c:when test="${ext.lastFreeDlvyYn}">${ext.dlvyVndrId ne '0625'?'업체':'핫트랙스'} 무료배송</c:when>
                    <c:otherwise>
                        <fmt:formatNumber value="${ext.dlvyAmt}" pattern=",###" />원
                        <p class="mb5"><fmt:formatNumber value="${ext.dlvyLevyStdAmt}" pattern=",###" />원 이상 구매 시 무료</p>
                    </c:otherwise>
                </c:choose>
                <!-- 묶음배송 제외 -->
                <c:if test="${!ext.codDlvyAmtYn}">
                    <p class="mt5 mb5">
                    	<a href="/m/biz/hot/brandDetail?brandId=${ext.brandId}" class="bt_sbrg1">묶음배송 상품보기</a>
                    <p>
                </c:if>
            </dd>
            <c:if test="${ext.prdtSavedRate > 0}">
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
                <a href="javascript:dwonProductCoupon();" class="bt_mbgb">쿠폰받기</a>
            </div>
        </c:forEach>
        <div class="sns">
            <c:if test="${not empty heartEvtId}">
                <!--<a href="/m/hot/heart?eventId=${heartEvtId}" class="heart">핫트뿅뿅</a>-->
            </c:if>
            <c:if test="${not empty storyEvtId}">
                <!--<a href="/m/hot/story?eventId=${storyEvtId}" class="story f14 col_black">보이는이야기</a>-->
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
            <a href="#" onclick="toggleShareBox();return false;" class="share">공유하기</a>
            <div class="share_box">
                <a href="#" onclick="goTwitter('${fn:escapeXml(ext.prdtName)}', 'http://m.hottracks.co.kr/p/${ext.sellPrdtBcode}');return false;" class="twitter"><span class="mlm2">트위터</span></a>
                <a href="#" onclick="goFaceBook('${fn:escapeXml(ext.prdtName)}', 'http://m.hottracks.co.kr/p/${ext.sellPrdtBcode}');return false;" class="facebook"><span>페이스북<span></span></a>
                <a href="#" onclick="sendKakao('[핫트랙스] ${fn:escapeXml(ext.prdtName)}', 'http://m.hottracks.co.kr/p/${ext.sellPrdtBcode}');return false;" class="kakao"><span>카카오톡</span></a>
                <a href="#" onclick="goPinterest('${ext.prdtName}', 'http://m.hottracks.co.kr/p/${ext.sellPrdtBcode}');return false;" class="pinterest"><span class="mlm3">핀터레스트</span></a>
                <a href="#" onclick="urlClipCopy('http://m.hottracks.co.kr/p/${ext.sellPrdtBcode}');return false;" class="copy"><span>상품복사</span></a>
                <a class="sms"><span class="mlm3">문자보내기</span></a>
            </div>
        </div>
    </div>
    <!-- //상품 정보 -->
    <div class="giftStockedInfoRequest"></div>
    <!-- 주문 정보 -->
    <div class="detail_input">
        <a href="#" onclick="toggleInput();return false;" class="btn_toggle">토글버튼</a>
        <a href="#" onclick="locBack();return false;" class="btn_back">뒤로</a>
        <a href="/m/gift/detail/desc/${ext.sellPrdtBcode}?sngl=Y" class="btn_detail">확대보기</a>
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
            <div id="listOption" class="pd10" style="display:none;"></div>
            <div id="divOrderMakeCont" class="textarea_wrap pd0_10" style="display:none;"></div>
            <c:if test="${ext.cvslYn}">
                <div class="btn_area box_flex pd0_10 mb20">
                    <a href="javascript:toggleCvsl();" class="bt_mbgb">각인신청하기</a>
                </div>
                <div id="layerCvsl" class="cvsl-layer">
                     <!-- tit_section -->
                     <div id="ly_header">
                         <h1>각인 신청하기</h1>
                     </div>
                     <!-- //tit_section -->
                     <div id="ly_content">
                         <!-- info tab -->
                         <ul class="stab_basic stab_btn"><!-- tab produnt -->
                             <li><a href="#cvsl01" class="on"><span>각인서비스</span></a></li>
                             <li><a href="#cvsl02"><span>자주묻는 질문</span></a></li>
                         </ul>
                         
                         <div id="cvsl01" class="stab_cont">
                             <div class="info-box">
                                 <h5>각인 서비스 안내</h5>
                                 <dl>
                                     <dd>1. 고급필기구 단품가 2만원 이상 구입 시 각인 무료</dd>
                                     <dd>2. 고급필기구 단품가 2만원 미만 구입 시 <em class="col_red">각인비용 5,000원</em><br/>
                                         &nbsp;- 제품 특성 및 브랜드에 따라 각인 불가 상품 있습니다.<br/>
                                         &nbsp;- <em class="col_red">각인된 상품은 반품, 교환 불가</em>합니다.
                                     </dd>
                                     <dd>3. 영문 이니셜 각인시 '성'은 맨 앞 글자만 대문자로 하시는 것이 가장 보기 좋습니다. 예) K.D.HOng</dd>
                                     <dd>4. 아래 서체리스트에서 서체선정 후 각인 내용을 입력하시고 신청 버튼을 눌러주세요.</dd>
                                 </dl>
                             </div>
                             
                             <div class="roundbox line_db">
                                 <!-- font tab -->
                                 <ul class="ctab_basic ctab_btn">
                                     <li><a href="#cvslFont01" class="on"><span>영문서체</span></a></li>
                                     <li><a href="#cvslFont02"><span>한글서체</span></a></li>
                                     <li><a href="#cvslFont03"><span>한문서체</span></a></li>
                                 </ul>
                                 
                                 <div id="cvslFont01" class="ctab_cont">
                                     <ul>
                                         <li><input type="radio" name="engracode" value="필기체|5000|2300000028379|N" id="initials_sample01" /><label for="initials_sample01"><img src="${imageServer}/images/service2/initials_sample01.gif" alt="필기체" /></label></li>
                                         <li><input type="radio" name="engracode" value="잉크버로우체|5000|2300000028379|N" id="initials_sample02" /><label for="initials_sample02"><img src="${imageServer}/images/service2/initials_sample02.gif" alt="잉크버로우체" /></label></li>
                                         <li><input type="radio" name="engracode" value="모노테입체|5000|2300000028379|N" id="initials_sample03" /><label for="initials_sample03"><img src="${imageServer}/images/service2/initials_sample03.gif" alt="모노테입체" /></label></li>
                                         <li><input type="radio" name="engracode" value="양재난초체|5000|2300000028379|N" id="initials_sample04" /><label for="initials_sample04"><img src="${imageServer}/images/service2/initials_sample04.gif" alt="양재난초체" /></label></li>
                                         <li><input type="radio" name="engracode" value="브랜들리 핸드체|5000|2300000028379|N" id="initials_sample05" /><label for="initials_sample05"><img src="${imageServer}/images/service2/initials_sample05.gif" alt="브랜들리 핸드체" /></label></li>
                                         <li><input type="radio" name="engracode" value="고딕체|5000|2300000028379|N" id="initials_sample06" /><label for="initials_sample06"><img src="${imageServer}/images/service2/initials_sample06.gif" alt="고딕체" /></label></li>
                                         <li><input type="radio" name="engracode" value="명조체|5000|2300000028379|N" id="initials_sample07" /><label for="initials_sample07"><img src="${imageServer}/images/service2/initials_sample07.gif" alt="명조체" /></label></li>
                                     </ul>
                                 </div><!-- end initials -->
                                 <div id="cvslFont02" class="ctab_cont">
                                     <ul>
                                         <li><input type="radio" name="engracode" value="양재난초체|5000|2300000028386|N" id="korea_sample01" /><label for="korea_sample01"><img src="${imageServer}/images/service2/korea_sample01.gif" alt="양재난초체" /></label></li>
                                         <li><input type="radio" name="engracode" value="필기체|5000|2300000028386|N" id="korea_sample02" /><label for="korea_sample02"><img src="${imageServer}/images/service2/korea_sample02.gif" alt="필기체" /></label></li>
                                         <li><input type="radio" name="engracode" value="명조체|5000|2300000028386|N" id="korea_sample03" /><label for="korea_sample03"><img src="${imageServer}/images/service2/korea_sample03.gif" alt="명조체" /></label></li>
                                         <li><input type="radio" name="engracode" value="고딕체|5000|2300000028386|N" id="korea_sample04" /><label for="korea_sample04"><img src="${imageServer}/images/service2/korea_sample04.gif" alt="고딕체" /></label></li>
                                     </ul>
                                 </div><!-- end korea -->
                                 <div id="cvslFont03" class="ctab_cont">
                                     <ul>
                                         <li><input type="radio" name="engracode" value="휴먼옛체|5000|2300000028409|N" id="china_sample01" /><label for="china_sample01"><img src="${imageServer}/images/service2/china_sample01.gif" alt="휴먼옛체" /></label></li>
                                         <li><input type="radio" name="engracode" value="한양해서체|5000|2300000028409|N" id="china_sample02" /><label for="china_sample02"><img src="${imageServer}/images/service2/china_sample02.gif" alt="한양해서체" /></label></li>
                                         <li><input type="radio" name="engracode" value="명조체|5000|2300000028409|N" id="china_sample03" /><label for="china_sample03"><img src="${imageServer}/images/service2/china_sample03.gif" alt="명조체" /></label></li>
                                         <li><input type="radio" name="engracode" value="고딕체|5000|2300000028409|N" id="china_sample04" /><label for="china_sample04"><img src="${imageServer}/images/service2/china_sample04.gif" alt="고딕체" /></label></li>
                                     </ul>
                                 </div><!-- end china -->
                                 <!-- // font tab -->
                             </div>
                             <!-- // form area -->
                             <div class="cvsl_form">
                                 <form>
                                     <fieldset>
                                         <legend>각인 신청 서식</legend>
                                         <dl>
                                             <dd><input type="text" id="carving-face" readonly="readonly" class="i_input" placeHolder="※ 각인서체"/></dd>
                                             <dd><input type="text" id="carving-contents" class="i_input" maxlength="20" placeHolder="※ 각인내용"/></dd>
                                             <dd><input type="text" id="price" readonly="readonly" class="i_input" placeHolder="※ 추가금액"/></dd>
                                         </dl>
                                         <!-- input type="hidden" name="lastCpnPrice" value="${ext.lastCpnPrice}"/ -->
                                     </fieldset>
                                 </form>
                                 <!-- // form area -->
                                 <!-- // btn area -->
                                 <div class="btn_area box_flex mt30">
                                     <a href="javascript://" onclick="toggleLayerFull('#layerCvsl')" class="btn_mbrg">취소</a>
                                     <a href="javascript://" onclick="setParentWindowCarvedSealInfo()" class="bt_mbgb ml10">신청</a>
                                 </div>
                                 <!-- end btn area -->
                             </div>
                         </div>
                         <div id="cvsl02" class="stab_cont" style="display:none;">
                             <div class="info-box">
                                 <ul class="ftab_basic ftab_btn">
                                     <li><a href="#cvslFaq01" class="on"><span>A/S</span></a></li>
                                     <li><a href="#cvslFaq02"><span>각인</span></a></li>
                                     <li><a href="#cvslFaq03"><span>포장</span></a></li>
                                     <li><a href="#cvslFaq04"><span>배송</span></a></li>
                                 </ul>
                                 
                                 <!-- A/S 가이드 -->
                                 <ul id="cvslFaq01" class="ftab_cont accordion accordion_q">
                                     <li>
                                         <a href="javascript://"><span class="tit">1년 이내에 구입한 제품을 새 제품으로 교환이 가능한가요?</span></a>
                                         <div class="cont">
                                             <p>
                                                 - 상품의 이상 유무에 따라 다르게 적용 됩니다.<br/>
                                                 - 자체적인 불량이 있는 경우에는 구매 후 1년 이내에 무상으로 교체(제품, 부품) 및 수리가 가능하십니다. 그러나 고객님의 부주의로 인한 제품의 문제일 경우에는 비용이 부과됩니다.
                                             </p>
                                         </div>
                                     </li>
                                     <li>
                                         <a href="javascript://"><span class="tit">제품 A/S 받고자 합니다. 맡기면 A/S 기간이 얼마나 걸리나요?</span></a>
                                         <div class="cont">
                                             <p>
                                                 - 인터넷 교보문고 GIFT에 등기나 택배로 보내시면 15일 이내에 가능합니다.<br/>
                                                 - 별도의 사유로 인한 A/S 지연 시 통보 드립니다.<br/>
                                                 - A/S 사항은 매커니즘 이상 및 작동상의 불량으로 인한 경우에 해당되며 흠집이나 도금은 A/S에 해당하지 않습니다.
                                             </p>
                                         </div>
                                     </li>
                                     <li>
                                         <a href="javascript://"><span class="tit">제품 A/S시 비용이 발생하나요?</span></a>
                                         <div class="cont">
                                             <p>
                                                 - 상품의 보증기간과 이상 내용에 따라 상이하며 A/S에 따른 비용 발생 시 별도의 안내를 드립니다.
                                             </p>
                                         </div>
                                     </li>
                                     <li>
                                         <a href="javascript://"><span class="tit">제품 A/S를 받았는데도 계속 같은 문제가 발생하면 어떻게 하나요?</span></a>
                                         <div class="cont">
                                             <p>
                                                 - 구매 후 1년 이내의 제품에 대해서는 같은 문제가 반복적으로 발생할 경우 이상 부위의 부속 혹은 제품을 무상 혹은 유상으로 교환해 드립니다.
                                             </p>
                                         </div>
                                     </li>
                                     <li>
                                         <a href="javascript://"><span class="tit">컨버터도 A/S가 가능한가요?</span></a>
                                         <div class="cont">
                                             <p>
                                                 - 컨버터는 자체적으로 압축된 상태로서 분리가 되지 않습니다. 따라서,컨버터가 고장이 나거나 훼손된 경우 수리는 불가능 합니다.
                                             </p>
                                         </div>
                                     </li>
                                     <li>
                                         <a href="javascript://"><span class="tit">캡 부위가 금이 갔어요.A/S가 가능한가요?</span></a>
                                         <div class="cont">
                                             <p>
                                                 - 캡의 파손으로 인해 꽉 잠기지 않으면 캡 안쪽의 진공상태 유지가 되지 않으므로 잉크 누수나 사용시 잉크가 나오지 않는 현상이 발생 될 수 있기 때문에 교환해 주어야 합니다.<br/>
                                                 - 교체에 따른 비용은 별도 안내 드립니다.
                                             </p>
                                         </div>
                                     </li>
                                 </ul>
                                 <!-- A/S 가이드 -->
                                 
                                 <!-- 각인 가이드 -->
                                 <ul id="cvslFaq02" class="ftab_cont accordion accordion_q">
                                     <li>
                                         <a href="javascript://"><span class="tit">각인 비용은 별도로 추가 되나요?</span></a>
                                         <div class="cont">
                                             <p>
                                                 - 2 만원 이상 제품 구매 고객에게는 무료 각인 서비스를 실시 하고 있습니다. 단, 각인 사양 및 제품의 재질에 따라 일부 각인 서비스가 지원되지 않는 상품이 있습니다.
                                             </p>
                                         </div>
                                     </li>
                                     <li>
                                         <a href="javascript://"><span class="tit">각인의 종류를 알고 싶어요!</span></a>
                                         <div class="cont">
                                             <p>
                                                 - 영문 / 한글 / 한문 총 3가지 언어로 구분되며 서체도 선택하실 수 있습니다.<br/>
                                                 - 이니셜 / 풀네임 / 원하는 문구/회사 로고 각인도 가능 합니다. (자세한 서체 이미지는 각인 신청 란에서 확인하시면 됩니다.)
                                             </p>
                                         </div>
                                     </li>
                                     <li>
                                         <a href="javascript://"><span class="tit">로고나 이미지 각인의 경우 비용이 발생 하나요?</span></a>
                                         <div class="cont">
                                             <p>
                                                 - 도안이 필요한 특수 로고나 도안이 필요한 경우에는 별도의 도안비를 받습니다. (별도 결제)
                                             </p>
                                         </div>
                                     </li>
                                     <li>
                                         <a href="javascript://"><span class="tit">각인한 상품도 교환이나 환불이 되나요?</span></a>
                                         <div class="cont">
                                             <p>
                                                 - 각인된 상품은 상품의 하자를 제외하고는 교환 및 반품이 불가능 합니다.
                                             </p>
                                         </div>
                                     </li>
                                     <li>
                                         <a href="javascript://"><span class="tit">각인 신청은 어디서 하나요?</span></a>
                                         <div class="cont">
                                             <p>
                                                 - 상품 페이지에서 각인 신청하기를 선택 후 각인 내용 및 각인 서체를 선택, 입력 하시면 됩니다.
                                             </p>
                                         </div>
                                     </li>
                                 </ul>
                                 <!-- 각인 가이드 -->
                                 
                                 <!-- 포장 가이드 -->
                                 <ul id="cvslFaq03" class="ftab_cont accordion accordion_q">
                                     <li>
                                         <a href="javascript://"><span class="tit">포장 신청을 하면 비용이 추가 되나요?</span></a>
                                         <div class="cont">
                                             <p>
                                                 - 고급필기구는 전상품 무료 포장 서비스를 실시하고 있습니다. (포장 이미지는 시즌에 따라 달라질 수 있습니다.)
                                             </p>
                                         </div>
                                     </li>
                                     <li>
                                         <a href="javascript://"><span class="tit">어떻게 포장 신청을 하나요?</span></a>
                                         <div class="cont">
                                             <p>
                                                 - 상품 주문 시 주문 메시지 란 에 포장신청 기입해 주시면 됩니다.
                                             </p>
                                         </div>
                                     </li>
                                 </ul>
                                 <!-- 포장 가이드 -->
                                 
                                 <!-- 배송 가이드 -->
                                 <ul id="cvslFaq04" class="ftab_cont accordion accordion_q">
                                     <li>
                                         <a href="javascript://"><span class="tit">배송 기간이 얼마나 걸리나요?</span></a>
                                         <div class="cont">
                                             <p>
                                                 - 오전 12시 이전 결제완료 주문 건 중 일반 택배의 경우 도서산간 지역을 제외하고 결제완료 후 4~5일 이내에 받을 수 있습니다.
                                             </p>
                                         </div>
                                     </li>
                                     <li>
                                         <a href="javascript://"><span class="tit">배송이 왜 이렇게 오래 걸리나요?</span></a>
                                         <div class="cont">
                                             <p>
                                                 - 인터넷 교보문고 GIFT는 고급필기구 상품의 경우 정식 수입원과 직거래를 통해 제품의 신뢰도를 확보하고 있습니다. 이에 수입원 본사와의 재고 이동 시간으로 인해 배송 기일이 깁니다.
                                             </p>
                                         </div>
                                     </li>
                                 </ul>
                                 <!-- 배송 가이드 -->
                             </div>
                         </div>
                         <!-- // info tab -->
                         
                         <a href="javascript:toggleCvsl();" class="btn_cls">닫기</a>
                     </div>
                     <!-- //content -->
                 </div>
            </c:if>
            <c:if test="${salability && ext.saleStat ne 'N'}">
                <div class="ord_price" id="ord${ext.sellPrdtBcode}">
                    <c:if test="${ext.saleStat eq 'Y'}"><c:set var="maxCnt" value="99"/></c:if>
                    <c:if test="${ext.saleStat ne 'Y'}"><c:set var="maxCnt" value="${ext.saleStat}"/></c:if>
                    <input type="hidden" id="stat${ext.sellPrdtBcode}" value="${ext.saleStat}"/>
                    <div class="count ml10">
                    	<button type="button" title="1개씩 감소" class="down" onclick="decPrdtCnt('${ext.sellPrdtBcode}')">감소</button>
                        <input type="number" name="prdtCnt" id="prdtCnt" number="prdtCnt" class="prdtCnt" min="0" max="${maxCnt}" value="1" title="주문수량 입력" maxlength="5" style="width: 100%;height: 30px;border: 1px solid #ccc; text-align: center;font-size: 16px;color: #000;"/>
                        <button type="button" title="1개씩 증가" class="up" onclick="incPrdtCnt('${ext.sellPrdtBcode}')">증가</button>
                    </div>
                    <span class="amount mr10"><fmt:formatNumber type="number">${ext.lastDcPrice}</fmt:formatNumber><span>원</span></span>
                </div>
                <div id="cartList" class="pd0_10"></div>
            </c:if>
            <div id="cvslOrder" class="cvsl_cont"></div>
            <dl class="amount_price">
                <dt>총금액</dt>
                <dd id="cartSum"><fmt:formatNumber type="number">${ext.lastDcPrice}</fmt:formatNumber><span>원</span></dd>
            </dl>
        </div>
        <div class="detail_order">
           <c:choose>
                <c:when test="${salability && ext.saleStat ne 'N'}">
                    <div class="btn_area box_flex bg_eeeeee">
                        <c:if test="${empty limitProduct}">
                        <a href="#" onclick="goCartProudct();return false;" class="bt_mbrb">장바구니</a>
                        </c:if>
                        <c:if test="${empty limitProduct || limitProduct.limitCount - limitProduct.laveCount > 0}">
                        <a href="#" onclick="goBuyProudct();return false;" class="bt_mbgb ml10">바로구매</a>
                        </c:if>
                    </div>
                </c:when>
                <c:when test="${ext.dlvyVndrId eq '0625' && (ext.prdtStatCode eq 'C0313' || ext.prdtStatCode eq 'C0314')}">
                    <div class="btn_area box_flex bg_eeeeee">
                        <a href="#" onclick="addGiftStockedInfoRequest('${ext.sellPrdtBcode}');return false;" class="bt_mbgb">알림예약 신청하기</a>
                    </div>
                </c:when>
                <c:otherwise>
                    <p class="t_c col_salmon f14 pd10"><strong>현재 판매가 중지된 상품입니다.</strong></p>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
    <!-- //주문 정보 -->
    
    <!-- 레코벨 추천상품으로 변경 start -->
	<!-- a002 -->
	<!-- banner -->
		<c:if test="${not empty listRecobell}">
		 <div class="recobell_list">
			<h2>이 상품과 같이 본 상품</h2>
			<div class="category detail_recobell">
			    <div class="swiper-container">
			        <div class="swiper-wrapper">
			            <c:forEach items="${listRecobell}" varStatus="s1" step="2" end="9">
			                <div class="swiper-slide" id="slide${s1.index}">
			                    <c:forEach items="${listRecobell}" var="l" begin="${s1.index}" end="${s1.index+1}">
			                            <a href="/p/${l.sellPrdtBcode}?foo=bar&rccode=mo_detail1">
			                                <div class="thum">
			                                 	<c:if test="${l.sellPrdtGbn eq 'R' || l.sellPrdtGbn eq 'D'}"><ui:image prdtGbn="${l.sellPrdtGbn}" rcrdCd="${l.rcrdCd}" ratingCode="${l.rtngCode}" style="height:${l.sellPrdtGbn eq 'R'?'138':'138'}px" alt="${fn:escapeXml(l.prdtName)}"/></c:if>
			                                 	<c:if test="${l.sellPrdtGbn ne 'R' && l.sellPrdtGbn ne 'D'}"><ui:image src="${l.productImageUrl}" server="product" alt="${l.prdtName}"/></c:if>
			                                 </div>
			                                <div class="desc">
			                                <p class="txt">${l.prdtName}</p>
			                                <p class="price font_t">
			                                    <c:if test="${l.prdtSellPrice>l.lastCpnPrice}">
			                                    	<span class="percent">			                                    		
														<fmt:parseNumber var="viewPercent" value="${hfn:rate(l.prdtSellPrice,l.lastCpnPrice)}" integerOnly="true" />
	                                        			${viewPercent}%
			                                    	</span>
			                                    </c:if>
			                                    <fmt:formatNumber type="number">${l.lastCpnPrice}</fmt:formatNumber>
			                                </p>
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
		</c:if>
	<!-- 레코벨 추천상품으로 변경 end -->

    <!-- 상세 탭메뉴 -->
    <div class="detail_tab">
        <ul class="tab_btn">
            <li><a href="#detail_cont01" id="detail_tab01" class="on">상품설명</a></li>
            <li><a href="#detail_cont02" id="detail_tab02">상품후기</a></li>
            <li><a href="#detail_cont03" id="detail_tab03">Q&amp;A</a></li>
        </ul>
    </div>
    <!-- //상세 탭메뉴 -->
    
    <div class="tab_pannels">
        <!-- 상품설명 -->
        <div class="tab_cont" id="detail_cont01">
            <h2 class="hid_obj">상품설명</h2>
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
                    <a href="javascript://">배송안내</a>
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
                    <a href="javascript://">반품교환</a>
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
                    <a href="javascript://">기타사항</a>
                    <div class="cont">
                        <p>
                            -상품의 불량에 의한 교환, A/S, 환불, 품질보증 및 피해보상 등에 관한 사항은 소비자분쟁해결 기준 (공정거래위원회 고시)에 준하여 처리됨<br/>
                            -대금 환불 및 환불지연에 따른 배상금 지급 조건, 절차 등은 전자상거래 등에서의 소비자 보호에 관한 법률에 따라 처리함<br/>
                            -구매자가 미성년자인 경우에는 상품 구입 시 법정대리인이 동의 하지 아니하면 미성년자 본인 또는 법정대리인이 구매취소 할 수 있습니다.
                        </p>
                    </div>
                </li>
            </ul>
           
            <div class="prod_scroll_box" style="width:100%;overflow:hidden;">
                <div class="prod_scroll_info">
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
                    <c:if test="${fn:startsWith(ext.vndrCntrtId, 'A420') && (fn:startsWith(category.ctgrId, '000020') || fn:startsWith(category.ctgrId, '000021'))}">
                        <p style="text-align:center;margin:20px 0;"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/1272/1466640532076_scr_19.jpg" style="width:100%;"/></p>
                    </c:if>
                    <!-- //상품설명 --> 
                    <c:if test="${ext.sellPrdtBcode eq '2300186003221'}">
	                    <p style="text-align:center;margin:20px 0;">
	                       <!-- <a href="/e/68553"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/68553_20200617.jpg" style="width:100%;"/></a> -->
	                       <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/68553_20200617.jpg" style="width:100%;"/>
	                    </p>
                	</c:if>
                    <!--  배송 업체 정보 -->
                    <div class="detail_product_img">
						<c:forEach items="${vndrNoti}" var="l" varStatus="st">
							<div>${l.content}</div>
						</c:forEach>
						<c:if test="${not empty ext.dtlBrandImg}">
							<p><ui:image src="${ext.dtlBrandImg}" server="brand"/></p>
						</c:if>
                    </div>
                    <!--  //배송 업체 정보 -->
                    <div id="prodDesc"></div>
                </div>
            </div>
        </div>
        <!-- 상품후기 -->
        <div class="tab_cont" id="detail_cont02"></div>
        <!-- //상품후기 -->

        <!-- QnA -->
        <div class="tab_cont" id="detail_cont03"></div>
        <!-- //QnA -->
    </div>
    
    <!-- banner -->
    <div class="recobell_list_a">
        <!-- 레코벨 추천상품으로 변경 start -->
        <!-- a003 -->
		<c:if test="${not empty listRecobell2}">
	        <div class="recobell_list">
	        <h2>함께 구매하기 좋은 상품</h2>
	        <div class="category detail_recobell2">
	            <div class="swiper-container">
	                <div class="swiper-wrapper">
	                    <c:forEach items="${listRecobell2}" varStatus="s1" step="2" end="9">
	                        <div class="swiper-slide" id="slide${s1.index}">
	                            <c:forEach items="${listRecobell2}" var="l" begin="${s1.index}" end="${s1.index+1}">
                                    <a href="/p/${l.sellPrdtBcode}?foo=bar&rccode=mo_detail2">
                                        <div class="thum">
                                        	<c:if test="${l.sellPrdtGbn eq 'R' || l.sellPrdtGbn eq 'D'}"><ui:image prdtGbn="${l.sellPrdtGbn}" rcrdCd="${l.rcrdCd}" ratingCode="${l.rtngCode}" style="height:${l.sellPrdtGbn eq 'R'?'138':'138'}px" alt="${fn:escapeXml(l.prdtName)}"/></c:if>
                                        	<c:if test="${l.sellPrdtGbn ne 'R' && l.sellPrdtGbn ne 'D'}"><ui:image src="${l.productImageUrl}" server="product" alt="${l.prdtName}"/></c:if>
                                        </div>
                                        <div class="desc">
                                        <p class="txt">${l.prdtName}</p>
                                        <p class="price font_t">
                                        	<c:if test="${l.prdtSellPrice>l.lastCpnPrice}">
                                        		<span class="percent">
                                        			<fmt:parseNumber var="goodPercent" value="${hfn:rate(l.prdtSellPrice,l.lastCpnPrice)}" integerOnly="true" />
                                        			<%-- <fmt:formatNumber type="number">
                                        				${hfn:rate(l.prdtSellPrice,l.lastCpnPrice)}
                                        			</fmt:formatNumber> --%>
                                        			${goodPercent}%
                                        		</span>
                                        	</c:if>
                                            <fmt:formatNumber type="number">${l.lastCpnPrice}</fmt:formatNumber>
                                        </p>
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
        </c:if>
        
        <!-- a004 -->
        <c:if test="${not empty listRecobell3}">
	        <div class="recobell_list">
	        <h2>브랜드 연관상품</h2>
	        <div class="category detail_recobell3">
	            <div class="swiper-container">
	                <div class="swiper-wrapper">
	                    <c:forEach items="${listRecobell3}" varStatus="s1" step="2" end="9">
	                        <div class="swiper-slide" id="slide${s1.index}">
	                            <c:forEach items="${listRecobell3}" var="l" begin="${s1.index}" end="${s1.index+1}">
	                                    <a href="/p/${l.sellPrdtBcode}?foo=bar&rccode=mo_detail3">
	                                        <div class="thum">
		                                        	<c:if test="${l.sellPrdtGbn eq 'R' || l.sellPrdtGbn eq 'D'}"><ui:image prdtGbn="${l.sellPrdtGbn}" rcrdCd="${l.rcrdCd}" ratingCode="${l.rtngCode}" alt="${fn:escapeXml(l.prdtName)}" style="height:${l.sellPrdtGbn eq 'R'?'138':'138'}px"/></c:if>
		                                        	<c:if test="${l.sellPrdtGbn ne 'R' && l.sellPrdtGbn ne 'D'}"><ui:image src="${l.productImageUrl}" server="product" alt="${l.prdtName}"/></c:if>	                                        
		                                    </div>
	                                        <div class="desc">
	                                        <p class="txt">${l.prdtName}</p>
	                                        <p class="price font_t">
	                                            <c:if test="${l.prdtSellPrice>l.lastCpnPrice}">
	                                            	<span class="percent">
	                                            		<fmt:parseNumber var="brandPercent" value="${hfn:rate(l.prdtSellPrice,l.lastCpnPrice)}" integerOnly="true" />	                                            	
	                                        			${brandPercent}%
	                                            	</span>
	                                            </c:if>
	                                            <fmt:formatNumber type="number">${l.lastCpnPrice}</fmt:formatNumber>
	                                        </p>
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
		</c:if>
        <!-- 레코벨 추천상품으로 변경 end -->
    </div>
    <!-- //banner -->
</div>
<!-- //상세 -->
	<div id="formBaseHtml">
	    <input type="hidden" value="${ext.sellPrdtBcode}" name="sellPrdtBcode">
	    <input type="hidden" value="1" name="prdtCount">
	    <div id="cvslInfo"></div>
	</div>

	<FORM name="sForm" id="sFormDiv" method="post"></FORM>  <!-- 장바구니 담기 Form -->
</div>
</body>
</html>