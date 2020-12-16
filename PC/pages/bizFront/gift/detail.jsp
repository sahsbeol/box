<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
<title>${ext.prdtName} - NEW ME HOTTRACKS</title> 
<META http-equiv="Expires" content="-1"> 
<META http-equiv="Pragma" content="no-cache"> 
<META http-equiv="Cache-Control" content="No-Cache">

<c:if test="${ext.sellPrdtBcode eq '2310029966439' || ext.sellPrdtBcode eq '2310040221104' || ext.sellPrdtBcode eq '2310032863619' || ext.sellPrdtBcode eq '2310029965968'}">
    <!-- 네이버수집제외 -->
    <meta name="robots" content="noindex,nofollow">
</c:if>

<!--  SNS 공유 내용 -->
<meta property="og:type" content="website" />
<meta property="og:title" content="${fn:escapeXml(ext.prdtName)}" />
<meta property="og:url" content="${defaultHost}/ht/product/detail?barcode=${ext.sellPrdtBcode}" />
<meta property="og:description" content="${fn:escapeXml(ext.brandEngName)}" />
<meta property="og:image" content="${productImageUrl}" />
<!--  SNS 공유 내용 -->

<!--  레코벨 스크립트 -->
<meta property="eg:type" content="product" />
<meta property="eg:cuid" content="e15e978e-3623-4892-bf0a-485b9f8196ee" />
<meta property="eg:itemId" content="${ext.sellPrdtBcode}" />
<meta property="eg:itemName" content="${ext.prdtName}" />
<meta property="eg:itemImage" content="${productImageUrl}" />
<meta property="eg:itemUrl" content="${defaultHost}/ht/product/detail?barcode=${ext.sellPrdtBcode}" />
<meta property="eg:originalPrice" content="${ext.prdtSellPrice}" />
<meta property="eg:salePrice" content="${ext.lastDcPrice}" />

<c:set var="stind" value="0"/>
<c:forEach varStatus="st" begin="6" end="${fn:length(category.cateId)}" step="2">
    <c:set var="stind" value="${stind+1}"/>
    <meta property="eg:category${stind}" content="${fn:substring(category.cateId, 0, st.index)}" />
</c:forEach>

<meta property="eg:brandId" content="${ext.brandId}" />
<meta property="eg:brandName" content="${ext.brandEngName}" />
<meta property="eg:regDate" content="" />
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
<!--  레코벨 스크립트 끝-->

<link rel="stylesheet" type="text/css" href="/css/swiper-5.1.0.min.css?${tmpKey}">
<script type="text/javascript" src="/js/jquery.form.js"></script>

<%-- 상품 중요정보 세팅 --%>
<script type="text/javascript" src="/js/ht.product.detail.1.0.0.js?20190304"></script>

<!-- Facebook Pixel Code -->
<script>
	!function(f,b,e,v,n,t,s){if(f.fbq)return;n=f.fbq=function(){n.callMethod?
	n.callMethod.apply(n,arguments):n.queue.push(arguments);};if(!f._fbq)f._fbq=n;
	n.push=n;n.loaded=!0;n.version='2.0';n.queue=[];t=b.createElement(e);t.async=!0;
	t.src=v;s=b.getElementsByTagName(e)[0];s.parentNode.insertBefore(t,s);}(window,
	document,'script','//connect.facebook.net/en_US/fbevents.js');
	
	fbq('init', '2595348470556537');
	fbq('track', "PageView");
</script>

<noscript>
	<img height="1" width="1" style="display:none" src="https://www.facebook.com/tr?id=1053245131399072&ev=PageView&noscript=1"/>
</noscript>
<!-- End Facebook Pixel Code -->

<!--  레코벨 스크립트 -->
<script type="text/javascript">
  var _recoUserId = getCookie('UserCookieKey');
  window._eglqueue = window._eglqueue || [];
  _eglqueue.push(['setVar','cuid','e15e978e-3623-4892-bf0a-485b9f8196ee']);
  _eglqueue.push(['setVar','itemId','${ext.sellPrdtBcode}']);
  _eglqueue.push(['setVar','userId',SHA256(_recoUserId)]);
  _eglqueue.push(['setVar','searchTerm','']);  
  _eglqueue.push(['track','view']);
  _eglqueue.push(['track','product']);  /* -- IMPORTANT -- */
  (function(s,x){s=document.createElement('script');s.type='text/javascript';
  s.async=true;s.defer=true;s.src=(('https:'==document.location.protocol)?'https':'http')+'://logger.eigene.io/js/logger.min.js';
  x=document.getElementsByTagName('script')[0];x.parentNode.insertBefore(s, x);})();
</script>
<!--  레코벨 스크립트 끝 -->

<script type="text/javascript">
	var sslHost = "${sslHost}";
	var loginYn = ("${isLogin}" == "true");
	var empYn = ("${isEmpYn }" == "true");
	var empBarYn = ("${isEmpBar }" == "true");

	function sendOrder() {
	    $.ajax({
	         url: $('form[name="sForm"]').attr("action")
	       , data: JSON.stringify($cart.getCartParam())
	       , type:"POST"
	       , headers: {
	            "Accept": "application/json"
	          , "Content-Type": "application/json"
	         }
	        ,dataType: "json"
	        ,success : function(data){
	            if (data) {
	                if(!isEmpty(data.cartType)) {
	                    if(data.save) {
	                        // 바로구매
	                        if(data.cartType == "quickOrder")    window.location.href = sslHost + "/ht/order/orderGiftChoose";
	                    } else {
	                        var errorMessages = data.result;
	                        alert(errorMessages);
	                    }
	                } else {
	                	_rbSendSyncLogs();
	                	
	                    // 장바구니 담기
	                    if(confirm(data.result + '\n--------------------------\n[장바구니로 이동하시겠습니까?]')){
	                        location.href = "/ht/order/cart";
	                    }
	                    
	                    // 각인정보 삭제
	                    $cart.cvsl = null;
	                    
	                    // 상단 장바구니 카운트 변경
	                    initTopNavigation();
	                    
	                    $('form[name="sForm"]').empty();
	                }
	            }
	        }
	        ,error: function(request, status, error) {
	            alert('<fmt:message key="error.common.system"/>');
	        }
	    });
	}

	function sendConnectOrder() {
	    if ($product.orderMakeYn) {
	        if (isEmpty($cart.orderMakeCont)) {
	            alert("주문제작 문구는 생략 할 수 없습니다.");
	            return;
	        }
	    }
	    
	    if (!$product.isOption && !$product.isSpec) {
	        sendOrder();
	    } else if ($product.isOption || $product.isSpec) {
	        if ($cart.option.list < 1) {
	            alert('옵션을 선택하세요.');
	            $('select.options:first').focus();
	        }else{
	            sendOrder();
	        }
	    } else {
	        alert("주문할 수 없는상품입니다");
	    }
	}

	<%-- 상품평 --%>
	function loadCommentSubList(param){
	    if(param != null && param != ""){
	        var param = "?barcode=${ext.sellPrdtBcode}&page="+param;
	    }else{
	        var param = "?barcode=${ext.sellPrdtBcode}";
	    }
	    jQuery(function($) {
	        $.ajax({
	            type: "POST"
	              ,url: "/ht/product/subCommentListPage" + param
	              ,dataType: "html"
	            ,success : function(html){
	                $("#divSubCommentList").html(html);
	            }
	        });
	    });
	}

	<%-- Q&A --%>
	function loadQuestionSubList(param){
	    if(param != null && param != ""){
	        var param = "?barcode=${ext.sellPrdtBcode}&page="+param;
	    }else{
	        var param = "?barcode=${ext.sellPrdtBcode}";
	    }
	    jQuery(function($) {
	        $.ajax({
	            type: "POST"
	              ,url: "/ht/product/subQuestionListPage" + param
	              ,dataType: "html"
	            ,success : function(html){
	                $("#divSubQuestionList").html(html);
	            }
	        });
	    });
	}

	function openCarvedSeal(barcode) {
	    window.open("/ht/product/carvingService?barcode=" + barcode, "", "width=900, height=1000, scrollbars=yes");
	}
	
	function setCarvedSealInfo(info, cvslCont) {
	    if(info.length >= 3) {
	        var payYn = true;
	        if($product && $product.lastDcPrice >= 20000 && info.length == 4) {
	            payYn = false;
	        }
	        
	        var cvslBcode = payYn?info[2]:"2300000032307";
	        
	        $cart.cvsl = { cvslBcode:cvslBcode, cvslCont:cvslCont, cvslFont:info[0] };
	    }else{
	        $cart.cvsl = null;
	    }
	}

	jQuery(function($) {
	    $('input#productCountText').blur(function() {
	        var value = $(this).val();
	        
	        if (isEmpty(value))    $(this).val("1");
	        else if ($product && $product.isSpec) {
	        } else {
	            var rtnMsg = $cart.prdtCnt.update(value);
	            if(rtnMsg)    alert(rtnMsg);
	            
	            $(this).val($cart.prdtCnt.value);
	        }
	    });
	    
	    $(document).ready(function(){
	        loadCommentSubList();
	        loadQuestionSubList();
	        
	        _init("${ext.sellPrdtBcode}");
	        
	        // 상품고시정보 공란시 체크
	        $(".content1 table tbody tr td").each(function(){
	            if($(this).text() == ""){
	               $(this).html("해당 정보 준비중입니다.");
	            }
	        });
	        
	        // 좋아요 펌핑
	        if($(".btn_like").length > 0){
	            setPumpBackground(".btn_like", 2, 110);
	        }
	        
	        // 최근본상품 등록
	        saveRecentProduct("${ext.sellPrdtBcode}");
	    });
	    
	    $('#onClickBuyNow').click(function() {
	        $('form[name="sForm"]').attr("action", "/ht/order/directOrderForOption");
	        sendConnectOrder();
	    });
	    
	    $('#onClickAddCart').click(function() {
	        
	        /* Facebook Pixel Code */
	        fbq('track', 'AddToCart');
	        /* End Facebook Pixel Code */
	        
	        $('form[name="sForm"]').attr("action", "/ht/order/addCartForOption");
	        sendConnectOrder();
	    });
	    
	    $('#sendCoupon').click(function(){
	        var barcode = "${ext.sellPrdtBcode}";
	        if ($product.isSpec) {
	            if ($('select[name="specPrdtBcode"]').val() == '') {
	                alert('옵션값은 생략 할 수 없습니다');
	                return;
	            }else{
	                barcode = $('select[name="specPrdtBcode"]').val();
	            }
	        }
	        
	        if (isEmpty(barcode))    alert("오류가 발생하였습니다.");
	        else {
	            if (loginYn){
	                window.open('/ht/coupon/popupProductCoupon?barcode='+barcode,'popupPrizewinner','width=610,height=480');
	                return false;
	            } else {
	                needLogin();
	            }
	        }
	    });
	    
	    
	    /* 상품평쑈기 */ 
	    $("#aWriteCommentBtn").click(function(event) {
	        event.preventDefault();
	        var now = returnToday();
	        var empStart = (now - '20171208'  >= 0) && ('20171218' - now >= 0);
	        
	        if (loginYn){
	            if(!empYn||(empYn && !empBarYn || !empStart) ){
	                // 체험단이 아니거나, 체험단이면서, 체험단 상품이 아니거나 체험 기간이 아닌경우 
	                $.ajax({
	                    type: 'GET'
	                    ,url: '/ht/product/getHistoryOfBarcode'
	                    ,data: 'barcode=${ext.sellPrdtBcode}'
	                    ,dataType: 'json'
	                    ,async: false
	                    ,success: function(data) {
	                        if(data.result == null || data.result.stInt1 == 0){
	                            alert("구매하지 않은 상품이거나 구매 후 3개월이 지난 상품입니다. 상품을 구매하신 뒤 다시 상품평을 작성해주세요.");
	                            return false;
	                        }else if(data.result.stVar1 == 'C0123' && data.result.stVar3 == 'Y'){
	                            if(confirm("수취확인후에 상품평을 작성 하실 수 있습니다.\n수취확인 하러 가시겠습니까?")) {
	                            	location.href='/ht/mypage/orderDelivery?sellPrdtBcode=${ext.sellPrdtBcode}';
	                            } else {
	                                return false;
	                            }
	                        }else if(data.result.stVar1 != 'C0124'){
	                            alert(data.result.stVar2+" 상품은 배송완료 상태인 경우에 상품평을 작성 하실 수 있습니다.");
	                            return false;
	                        }else{
	                              location.href='/ht/mypage/orderDelivery?sellPrdtBcode=${ext.sellPrdtBcode}';
	                        }
	                    }
	                    ,error: function(data) {
	                        alert('<fmt:message key="error.common.system"/>');
	                    }
	                });    
	            }else{
	                  // 체험단이면서 체험단 상품인 경우
	                $.ajax({
	                    type: 'GET'
	                    ,url: '/ht/product/getHistoryOfBarcode'
	                    ,data: 'barcode=${ext.sellPrdtBcode}'
	                    ,dataType: 'json'
	                    ,async: false
	                    ,success: function(data) {
	                        if(data.result == null || data.result.stInt1 == 0 || data.result.stVar1 != 'C0124'){
	                            window.open(paramFactory("/ht/product/commentPopup4write"), "", "width=500, height=600, scrollbars=no");
	                            return false;
	                        }else{
	                            location.href='/ht/mypage/orderDelivery?sellPrdtBcode=${ext.sellPrdtBcode}';
	                        }
	                    }
	                    ,error: function(data) {
	                        alert('<fmt:message key="error.common.system"/>');
	                    }
	                }); 
	            }
	            return false; 
	        } else {
	            if(!empBarYn)
	                needLogin2('${ext.sellPrdtBcode}');
	            else
	                needLoginForEmp('${ext.sellPrdtBcode}');
	        }
	    });
	    
	    $("#aWriteQuestionBtn").click(function(event) {
	        event.preventDefault();
	        if (loginYn){
	            window.open(paramFactory("/ht/product/questionPopup4write"), "", "width=500, height=700, scrollbars=no");
	            return false;
	        } else {
	            needLogin();
	        }
	    });
	    
	    function paramFactory(urlStr){
	        var url = urlStr;
	        url += "?barcode=${ext.sellPrdtBcode}";
	        return url;
	    }
	});

	function incPrdtCnt(){
	    var rtnMsg = $cart.prdtCnt.increase();
	    if(rtnMsg)    alert(rtnMsg);
	    $("#productCountText").val($cart.prdtCnt.value);
	}
	
	function decPrdtCnt(sellPrdtBcode){
	    var rtnMsg = $cart.prdtCnt.decrease();
	    if(rtnMsg)    alert(rtnMsg);
	    $("#productCountText").val($cart.prdtCnt.value);
	}
	
	function goCopyUrl(barcode) {
	    var IE=(document.all)?true:false;
	    if (IE) {
	        if(confirm("이 글의 트랙백 주소를 클립보드에 복사하시겠습니까?"))
	        window.clipboardData.setData("Text", location.href);
	    } else {
	        temp = prompt("이 글의 트랙백 주소입니다. Ctrl+C를 눌러 클립보드로 복사하세요", $(location).attr("href"));
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
	
	function addGiftStockedInfoRequest(goodId){
	    if (loginYn){
	        window.open("/ht/mypage/giftStockedInfoRequestForm?goodId=" + goodId, "", "width=600, height=450, scrollbars=yes");
	        return false;
	    } else {
	        needLogin();
	    }
	}

	// 좋아요 토글
	function toggleWichProduct(){
	    if($(".btn_like").hasClass("active")){
	        removeWishProduct("${ext.sellPrdtBcode}");
	    }else{
	        fbq('track', 'AddToWishlist');
	        addWishProduct("${ext.sellPrdtBcode}");
	    }
	}

	/* Facebook Pixel Code */
	fbq('track', 'ViewContent');
	/* End Facebook Pixel Code */
</script>

<script type='text/javascript' src='//logger.eigene.io/js/logger.min.js'></script>
<script type='text/javascript'>
var _recoUserId = getCookie('UserCookieKey');
var _rbSendSyncLogs = function() {
	eglc.op('setVar','cuid','e15e978e-3623-4892-bf0a-485b9f8196ee');
	eglc.op('setVar','itemId','${ext.sellPrdtBcode}');
	eglc.op('track','add_to_cart');
	// if you want to send user log with userId inserted
	eglc.op('setVar','userId',SHA256(_recoUserId));
	eglc.op('track', 'user');
};
</script>
</head>
<body>
<!-- detail_top -->
<div class="detail_top">
    <div class="inner">
        <!-- Location -->
        <div class="location_wrap_v2 mgt20 mgb10">
                <a href="/" class="btn_home">Home</a>
                <c:forEach varStatus="st" begin="6" end="${fn:length(category.cateId)}" step="2">
                    <c:if test="${st.first}">
                    	<div class="location_nav_wrap">
                    		<a class="location_1" href="/ht/gift/giftCategoryMain?ctgrId=${fn:substring(category.cateId, 0, st.index)}"><ui:category id="${fn:substring(category.cateId, 0, st.index)}" full="false"/></a>
                    	</div>
                    </c:if>
                    <c:if test="${!st.first}">
                    	<div class="location_nav_wrap">
                    		<a class="location_1" href="/ht/gift/giftCategorySub?ctgrId=${fn:substring(category.cateId, 0, st.index)}"><ui:category id="${fn:substring(category.cateId, 0, st.index)}" full="false"/></a>
                    	</div>
                    </c:if>
                </c:forEach>
        </div>
        <!-- //Location -->
        
		<!-- 다이어리 배너 추가 -->
    	<a href="/ht/diary/main" style="margin:0 0 10px 0;">
			<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/resources/img/bnr/h_950_100.png">
		</a>
                
        <div class="detail_cont">			
            <!-- 상품배너 -->
            <div class="view_banner tab_wrap">
                <ul class="slide_btn tab_btn">
                    <c:forEach items="${imageList}" var="l" varStatus="st">
                        <li>
                        	<a href="#vb<ui:lpad length="2" padChar="0">${st.count}</ui:lpad>"<c:if test="${st.first}"> class="on"</c:if>>
                        		<span>
                        			<ui:image src="${l.imageUrl}" size="400" server="product" alt="${ext.prdtName}" clazz="sns_img"/>
                        		</span>
                        		<span class="over"></span>
                        	</a>
                        </li>
                    </c:forEach>
                </ul>
                <div class="slide_pannels tab_pannels">
                    <c:forEach items="${imageList}" var="l" varStatus="st">
                        <div id="vb<ui:lpad length="2" padChar="0">${st.count}</ui:lpad>" class="pannel">
                            <ui:image src="${l.imageUrl}" size="400" server="product" alt="${ext.prdtName}"/>
                        </div>
                    </c:forEach>
                </div>
            </div>
            <!-- //상품배너 -->
            <div class="ico_label badge">
                <c:set var="ic_cnt" value="0"/>
                <c:if test="${ext.prdtStatCode eq 'C0313' && ic_cnt < 2}">
                    <c:set var="ic_cnt" value="${ic_cnt + 1}"/>
                    <span class="badge03">일시품절</span>
                </c:if>
                <c:if test="${ext.prdtStatCode ne 'C0312' && ext.prdtStatCode ne 'C0313' && ic_cnt < 2}">
                    <c:set var="ic_cnt" value="${ic_cnt + 1}"/>
                    <span class="badge03">품절</span>
                </c:if>
                <c:if test="${ext.lastDcPrice ne ext.lastCpnPrice && ic_cnt < 2}">
                    <c:set var="ic_cnt" value="${ic_cnt + 1}"/>
                    <span class="badge01">쿠폰</span>
                </c:if>
                <c:if test="${ext.cvslYn && ic_cnt < 2}">
                    <c:set var="ic_cnt" value="${ic_cnt + 1}"/>
                    <span class="badge02">각인</span>
                </c:if>
                <c:if test="${ext.orderMakeYn && ic_cnt < 2}">
                    <c:set var="ic_cnt" value="${ic_cnt + 1}"/>
                    <span class="badge02">주문제작</span>
                </c:if>
                <c:if test="${not empty freeGiftList && fn:length(freeGiftList) > 0 && ic_cnt < 2}">
                    <c:set var="ic_cnt" value="${ic_cnt + 1}"/>
                    <span class="badge02">사은품</span>
                </c:if>
                <c:if test="${ext.limitCount < maxLimitCount && ic_cnt < 2}">
                    <c:set var="ic_cnt" value="${ic_cnt + 1}"/>
                    <span class="badge02">한정</span>
                </c:if>
                <c:if test="${ext.prdtSellPrice ne ext.lastDcPrice && ic_cnt < 2}">
                    <c:set var="ic_cnt" value="${ic_cnt + 1}"/>
                    <span class="badge02">할인</span>
                </c:if>
            </div>
            <form name="productForm">
                <div class="detail_info">
                    <p class="brand_name"><a href="/ht/biz/hot/brandDetail?brandId=${ext.brandId}">${ext.brandEngName}</a></p>
                    <h2 class="tit">${ext.prdtName}</h2>
                    <ul>
                        <c:if test="${not empty ext.prvdTitle}">
                            <li class="mgb10">
                            	<span class="sub_tit">${ext.prvdTitle}</span>
                            </li>
                        </c:if>
                        <li style="display:none;"><span class="tit">검색키워드</span><div>${ext.prdtSrchWord}</div></li>
                        <c:if test="${ext.nyoSellBanYn eq 'Y'}">
                            <li class="mgb10">
                            	<span class="sub_tit">19세 이상 상품입니다.</span>
                            </li>
                        </c:if>
                        <li>
                            <span class="tit">판매가</span>
                            <div class="price">
                                <c:choose>
                                    <c:when test="${ext.prdtSellPrice ne ext.lastDcPrice}">
                                        <span class="ori_price"><fmt:formatNumber value="${ext.prdtSellPrice}" type="number" /></span>
                                        <strong><fmt:formatNumber value="${ext.lastDcPrice}" type="number" /></strong> (<fmt:formatNumber value="${ext.lastDcRate}" type="number"/>%)
                                    </c:when>
                                    <c:otherwise>
                                        <strong><fmt:formatNumber value="${ext.prdtSellPrice}" type="number" /></strong>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </li>
                        <c:if test="${ext.lastDcPrice ne ext.lastCpnPrice}">
                            <li>
                                <span class="tit">쿠폰적용가</span>
                                <div class="price">
                                    <span class="ori_price"><fmt:formatNumber value="${ext.lastDcPrice}" type="number" /></span>
                                    <strong class="c_point"><fmt:formatNumber value="${ext.lastCpnPrice}" type="number" /></strong>
                                    <c:forEach items="${couponList}" var="l" varStatus="st" end="0">
                                        <span class="c_amt">
                                            <c:if test="${l.rateYn}"><fmt:formatNumber type="number">${l.couponDiscountRate}</fmt:formatNumber>%</c:if>
                                            <c:if test="${!l.rateYn}"><fmt:formatNumber type="number">${l.couponDiscountAmount}</fmt:formatNumber></c:if>
                                        </span>
                                        <span class="c_down"><a href="javascript://" id="sendCoupon" class="btn_type05_v2">쿠폰받기</a></span>
                                    </c:forEach>
                                </div>
                            </li>
                        </c:if>
                        <c:if test="${ext.prdtSavedRate > 0}">
                            <li>
                                <span class="tit">통합포인트</span>
                                <div>
                                    <span class="w100">${ext.prdtSavedRate}%적립 (+<fmt:formatNumber value="${ext.prdtSavedPrice+(10-(ext.prdtSavedPrice%10))%10}" type="number"/>원)</span>
                                    <div class="tooltip_wrap">
                                        <a href="#tooltip3" class="tooltip">?</a>
                                        <div id="tooltip3" class="layer_pop_wrap">
                                            <div class="layer_pop_container" style="width:340px;height:385px;">
                                                <h1>통합포인트 안내</h1>
                                                <div class="layer_pop_cont">
                                                    <ul class="bu_list">
                                                        <li><span class="bu">•</span><strong>핫트랙스 온라인/오프라인, 교보문고 온라인/오프라인, 모바일 교보문고에서 모두 적립&middot;사용 가능!</strong></li>
                                                        <li><span class="bu">•</span><strong>10원 이상의 포인트도 바로바로 사용! (영업점은 1,000원 단위 사용)</strong><br />주문 시, 10원 단위부터 사용하실 수 있습니다.</li>
                                                        <li><span class="bu">•</span><strong>자동적립되는 편리한 포인트!</strong><br />구매 후 어떤 절차나 과정없이 바로 자동으로 적립됩니다.</li>
                                                        <li>
                                                        	<span class="bu">•</span><strong>포인트 확인도 폭넓~게!</strong><br />온라인 마이룸, 모바일, 무인가입기, 영업점 영수증 등에서 적립하거나 사용하신 포인트 내역을 확인하실 수 있습니다.<br />
                                                        	상품 구매 시 해당 상품의 적립률에 따라 지급되며 고객님께서 주문하신 상품이 발송완료 된 후 자동 지급됩니다.<br />단, 쿠폰 또는 마일리지, 통합포인트 사용 시 예상적립금이 변동될 수 있습니다.<br />(주문취소나 반품시에는 적립된 통합포인트가 다시 차감됩니다.)
                                                        </li>
                                                    </ul>
                                                </div>
                                                <a href="javascript:;" class="cls_btn" title="레이어팝업 닫기">
                                                	<img src="${imageServer}/images/renewal/common/btn_cls.gif" alt="닫기" />
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </li>
                        </c:if>
                        <li>
                            <span class="tit">카드혜택</span>
                            <div>
                                <span class="w100">신용카드 할인안내</span>
                                <div class="tooltip_wrap">
                                    <a href="#tooltip" class="tooltip">?</a>
                                    <div id="tooltip" class="layer_pop_wrap">
                                        <div class="layer_pop_container" style="width:309px;line-height:20px;">
                                            <h1>신용카드 할인안내</h1>
                                            <div class="layer_pop_cont pd0">
                                                <ul class="card_list">
                                                    <li>
                                                        <span class="img"><img src="${imageServer}/images/common/ic_card_80_50.png" alt="신용카드" /></span>
                                                        <div class="txt">
                                                            <strong>신한카드</strong>
                                                            -2~6개월, 12개월(부분) 무이자
                 										    <strong>하나카드</strong>
                                                            -2~3개월 무이자
	                                                        <strong>국민카드</strong>
                                                            -2~5개월 무이자
                                                            <strong>비씨, NH농협, 현대, 삼성카드</strong>															
															-2~6개월 무이자
															<strong>유의사항</strong>
															-법인,체크,선불,기프트,하이브리드 제외<br/>
															-무이자 적용 최소결제 금액 등 상세 내용은 결제 팝업창에서 확인 요망
                                                        </div>
                                                    </li>
	                                                <li>
	                                                    <span class="img"><img src="${imageServer}/images/common/smilepay_80_50.jpg" alt="스마일페이" /></span>
                                                        <div class="txt">
                                                            <strong>※Smile Pay  결제시 2천원 적립</strong>
                                                            -이벤트 기간 : 2019.08.01 ~ 2019.12.31<br/>
                                                            -스마일페이로 3만원 이상 첫 결제 시 2천원 스마일캐시 적립
                                                        </div>
                                                    </li>
                                                </ul>
                                            </div>
                                            <a href="#none" class="cls_btn" title="레이어팝업 닫기"><img src="${imageServer}/images/renewal/common/btn_cls.gif" alt="닫기" /></a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <li>
                            <span class="tit">배송구분</span>
                            <div>
                                <span class="w100">
                                    ${ext.dlvyVndrId ne '0625'?'업체':'핫트랙스'}
                                    <c:choose>
                                        <c:when test="${ext.codDlvyAmtYn && ext.lastFreeDlvyYn}"> 착불배송</c:when>
                                        <c:when test="${!ext.codDlvyAmtYn && !ext.lastFreeDlvyYn}"> 조건배송</c:when>
                                        <c:when test="${!ext.codDlvyAmtYn && ext.lastFreeDlvyYn}"> 무료배송</c:when>
                                        <c:otherwise> 조건배송</c:otherwise>
                                    </c:choose>
                                </span>
                                <div class="tooltip_wrap">
                                    <a href="#tooltip2" class="tooltip">?</a>
                                    <div id="tooltip2" class="layer_pop_wrap">
                                        <div class="layer_pop_container" style="width:289px;height:100px;line-height:20px;">
                                            <h1>배송구분 안내</h1>
                                            <div class="layer_pop_cont">
                                                <p>
                                                    <c:choose>
                                                        <c:when test="${ext.codDlvyAmtYn && ext.lastFreeDlvyYn}">${ext.dlvyVndrId ne '0625'?'업체':'핫트랙스'} 착불배송</c:when>
                                                        <c:when test="${!ext.codDlvyAmtYn && ext.lastFreeDlvyYn}">${ext.dlvyVndrId ne '0625'?'업체':'핫트랙스'} 무료배송</c:when>
                                                        <c:otherwise>
                                                            <fmt:formatNumber value="${dlvyVendor.deliveryAmount}" pattern=",###" /> 원
                                                            (<fmt:formatNumber value="${dlvyVendor.deliveryLevyStandardAmount}" pattern=",###" /> 이상 구매시 무료)
                                                        </c:otherwise>
                                                    </c:choose>
                                                </p>
                                                <p>도서·산간지역 추가요금 있음</p>
                                                <a href="#none" class="cls_btn" title="레이어팝업 닫기"><img src="${imageServer}/images/renewal/common/btn_cls.gif" alt="닫기" /></a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <li id="listOption" style="display:none;"></li>
                        <li id="trGPrice">
                            <span class="tit">수량</span>
                            <div class="count">
                                <c:if test="${!salability}">없음</c:if>
                                <c:if test="${salability}">
                                    <input type="text" id="productCountText" name="productCount" value="1" maxlength="4" class="prdtCnt inputNumberText" style="ime-mode:disabled" title="수량입력"/>
                                    <input type="hidden" id="stat${ext.sellPrdtBcode}" value="${ext.saleStat}"/>
                                    <span class="button_wrap mgl4m">
                                        <a href="#" class="up" onclick="incPrdtCnt();return false;">증가</a>
                                        <a href="#" class="down" onclick="decPrdtCnt();return false;">감소</a>
                                    </span>
                                    <span class="s_txt">개</span>
                                    <c:if test="${ext.limitCount < maxLimitCount}">
                                        (한정수량 ${ext.limitCount} 개중 ${ext.laveCount} 개 남음)
                                    </c:if>
                                </c:if>
                            </div>
                        </li>
                        <li id="divOrderMakeCont" style="display:none;"></li>
                        <c:if test="${ext.cvslYn}">
                            <li>
                                <span class="tit">각인서비스</span>
                                <div>
                                    <a href="javascript:;" onclick="openCarvedSeal('${ext.sellPrdtBcode}');return false;" class="btn_type01_v2">각인신청하기</a>
                                </div>
                            </li>
                        </c:if>
                        <c:if test="${not empty freeGiftList}">
                            <li>
                                <span class="tit">특별사은품</span>
                                <div>
                                    <c:forEach items="${freeGiftList}" var="l" varStatus="st">
                                        <c:if test="${not empty l.linkUrl}">
                                            <a href="${l.linkUrl}" target="_blank">
                                                <dl style="position:relative;height:50px;line-height:15px;<c:if test="${!st.first}">margin-top:15px;</c:if>width:300px;">
                                                    <dt style="position:absolute;left:0;top:0;"><ui:image src="${l.listImageUrl}" style="width:50px;height:50px;"/></dt>
                                                    <dd style="margin:0 0 0 60px; padding:5px 0 0 0; color:#000;">${l.name}</dd>
                                                    <dd style="margin:10px 0 0 60px; color:#777;">기간: <ui:mask pattern="####.##.##">${l.presentStartDate}</ui:mask> ~ <ui:mask pattern="####.##.##">${l.presentEndDate}</ui:mask></dd>
                                                </dl>
                                            </a>
                                        </c:if>
                                        <c:if test="${empty l.linkUrl}">
                                            <dl style="position:relative;height:50px;line-height:15px;<c:if test="${!st.first}">margin-top:15px;</c:if>width:300px;">
                                                <dt style="position:absolute;left:0;top:0;"><ui:image src="${l.listImageUrl}" style="width:50px;height:50px;"/></dt>
                                                <dd style="margin:0 0 0 60px; padding:5px 0 0 0; color:#000;">${l.name}</dd>
                                                <dd style="margin:10px 0 0 60px; color:#777;">기간: <ui:mask pattern="####.##.##">${l.presentStartDate}</ui:mask> ~ <ui:mask pattern="####.##.##">${l.presentEndDate}</ui:mask></dd>
                                            </dl>
                                        </c:if>
                                    </c:forEach>
                                </div>
                            </li>
                        </c:if>
                    </ul>
                    <div id="cartArea" style="display:none;">
                        <table class="detail_tbl">
                            <colgroup>
                                <col style="width:*">
                                <col style="width:70px">
                                <col style="width:150px">
                            </colgroup>
                            <tfoot>
                                <tr>
                                    <th colspan="2">상품 금액 합계</th>
                                    <td id="cartSum">0</td>
                                </tr>
                            </tfoot>
                            <tbody id="cartList"></tbody>
                        </table>
                    </div>
                    <div class="sns">
                        <p>온라인/오프라인 판매상품은 동일하지 않을 수 있습니다.</p>
                        <div class="btn_wrap">
                            <a href="#" onclick="goTwitter('${ext.prdtName}', '${defaultHost}/ht/product/detail?barcode=${ext.sellPrdtBcode}');return false;"><img src="${imageServer}/images/renewal/common/ico_sns_twitter.png" alt="twitter"/></a>
                            <a href="#" onclick="goFaceBook('${ext.prdtName}', '${defaultHost}/ht/product/detail?barcode=${ext.sellPrdtBcode}');return false;"><img src="${imageServer}/images/renewal/common/ico_sns_facebook.png" alt="facebook"/></a>
                            <a href="#" onclick="goPinterest('${ext.prdtName}', '${defaultHost}/ht/product/detail?barcode=${ext.sellPrdtBcode}');return false;"><img src="${imageServer}/images/renewal/common/ico_sns_pinterest.png" alt="pinterest" style="width:28px;height:28px;" nopin="true"/></a>
                        </div>
                    </div>
                    <div class="btn_wrap mgt35">
                        <c:choose>
                            <c:when test="${ext.wishUserPrdtCnt eq '0'}"><c:set var="linkCls" value="pump"/></c:when>
                            <c:otherwise><c:set var="linkCls" value="active"/></c:otherwise>
                        </c:choose>
                        <c:if test="${!salability}"><p class="fs14 bold c_red pd5 mgb10">${sellStopReason}</p></c:if>
                        <c:if test="${salability && ext.saleStat ne 'N'}">
                            <a href="javascript://" id="onClickBuyNow" class="btn_type04_v1 fs18" style="width:133px;">바로구매</a>
                            <a href="javascript://" id="onClickAddCart" class="btn_type04_v2 fs18 mgl8" style="width:133px;">장바구니</a>
                            <a href="#" onclick="toggleWichProduct();return false;" class="btn_type04_v2 fs18 mgl7" style="width:133px;"><em class="btn_like ${linkCls}"><fmt:formatNumber type="number">${ext.wishPrdtCnt}</fmt:formatNumber></em></a>
                        </c:if>
                        <c:if test="${!salability or ext.saleStat eq 'N'}">
                            <c:if test="${dlvyVendor.vendorId eq '0625'}"><!-- 2310001747513 -->
                                <a href="javascript://" onclick="addGiftStockedInfoRequest('${ext.sellPrdtBcode}')" class="btn_type04_v2">알림예약 신청하기</a>
                            </c:if>
                            <c:if test="${dlvyVendor.vendorId ne '0625'}">
                                <a href="#" onclick="return false;" class="btn_dim btn_type04_v1 fs18" style="width:133px;">바로구매</a>
                                <a href="#" onclick="return false;" class="btn_dim btn_type04_v2 fs18 mgl8" style="width:133px;">장바구니</a>
                                <a href="#" onclick="toggleWichProduct();return false;" class="btn_type04_v2 fs18 mgl7" style="width:133px;"><em class="btn_like ${linkCls}"><fmt:formatNumber type="number">${ext.wishPrdtCnt}</fmt:formatNumber></em></a>
                            </c:if>
                        </c:if>
                    </div>
                    <c:if test="${not empty eventList}">
                        <dl class="detail_event">
                            <c:set var="cnt1" value="0"/>
                            <c:set var="cnt2" value="0"/>
                            <c:forEach items="${eventList}" var="l" varStatus="st">
                           			<dt><strong>관련이벤트</strong></dt>
                                    <c:if test="${l.typeCode ne 'C019H' && cnt1 eq 0}">
                                        <c:set var="cnt1" value="1"/>
                                        <dd><a href="/ht/biz/eventDetail?eventId=${l.id}"><span>${l.title}</span></a></dd>
                                    </c:if>
                            </c:forEach>
                        </dl>
                    </c:if>
                </div>
            </form>
        </div>
    </div>
</div>
<!-- //detail_top -->

<!-- 레코벨 추천상품 start-->
<c:if test="${not empty listRecobell || not empty listRecobell2 || not empty listRecobell3}">
<div class="best_gift_a">
<ul class="best_gift">
    <c:forEach begin="0" end="2" varStatus="s1">
        <c:if test="${s1.index eq 0}"><c:set var="title" value="이 상품과 같이 본 상품"/><c:set var="list" value="${listRecobell}"/><c:set var="link" value="/ht/gift/giftCategorySub?ctgrId=${category.cateId}&productOrderBy=P"/></c:if>
        <c:if test="${s1.index eq 1}"><c:set var="title" value="함께 구매하기 좋은 상품"/><c:set var="list" value="${listRecobell2}"/><c:set var="link" value="/ht/gift/giftCategorySub?ctgrId=${category.cateId}&productOrderBy=R"/></c:if>
        <c:if test="${s1.index eq 2}"><c:set var="title" value="브랜드 연관 상품"/><c:set var="list" value="${listRecobell3}"/><c:set var="link" value="/ht/biz/hot/brandDetail?brandId=${ext.brandId}&productOrderBy=P"/></c:if>
        <c:if test="${not empty list}">
            	<li class="t_tab<c:if test="${s1.first}"> active</c:if>">
                <a href="javascript://" class="tab"><span>${title}</span></a>
                <div class="depth2 swiper-container">
                	<div class="swiper-wrapper">
                    <c:forEach items="${list}" varStatus="s"  step="4" end="11">
                    <ul class="swiper-slide">
                        	<c:forEach items="${list}" var="l" varStatus="st" begin="${s.index}" end="${s.index+3}">
                            <li class="txt_line1">
                            	<c:if test="${l.sellPrdtGbn eq 'R' || l.sellPrdtGbn eq 'D'}"><a href="/ht/record/detail/${l.sellPrdtBcode}?foo=bar&rccode=<c:if test="${s1.index eq 0}">pc_detail1</c:if><c:if test="${s1.index eq 1}">pc_detail2</c:if><c:if test="${s1.index eq 2}">pc_detail3</c:if>" title="${l.prdtName}"></c:if>
	                            <c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G' || l.sellPrdtGbn eq 'S'}"><a href="/ht/product/detail?barcode=${l.sellPrdtBcode}&foo=bar&rccode=<c:if test="${s1.index eq 0}">pc_detail1</c:if><c:if test="${s1.index eq 1}">pc_detail2</c:if><c:if test="${s1.index eq 2}">pc_detail3</c:if>" title="${l.prdtName}"></c:if>
                                    <span class="cover t_center">
	                                    <c:if test="${l.sellPrdtGbn eq 'R' || l.sellPrdtGbn eq 'D'}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" ratingCode="A" rcrdImgType="large" width="${l.sellPrdtGbn eq 'R'?'150':'99'}" clazz="photo" alt="${fn:escapeXml(l.prdtName)}"/></c:if>
	                            		<c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G' || l.sellPrdtGbn eq 'S'}"><ui:image src="${l.prdtImgUrl}" src2="${l.productImageUrl2}" size="400" server="product" clazz="photo" alt="${fn:escapeXml(l.prdtName)}"/></c:if>
                                    </span>
                                    <span class="artist">${l.brandName}</span>
                                    <strong class="tit">${l.prdtName}</strong>
                                </a>
                            </li>
                        	</c:forEach>
                    </ul>
                    </c:forEach>
                    </div>
                    
                     <div class="p_pagination">
	                 	<!-- Add Pagination -->
					    <div class="swiper-pagination"></div>
					    <!-- Add Arrows -->
					    <div class="swiper-button-area">
					    	<div class="swiper-button-next"></div>
					    	<div class="swiper-button-prev"></div>
					    </div>
				     </div> 
                       
                </div>  	
            </li>
        </c:if>

    </c:forEach>
</ul>
</div>
</c:if>

<script type="text/javascript" src="/js/swiper-5.1.0.min.js?${tmpKey}"></script>
<script>
 var swiper = new Swiper('.swiper-container', {
   speed: 1000,
   pagination: {
     el: '.swiper-pagination',
     type: 'fraction',
   },
   navigation: {
     nextEl: '.swiper-button-next',
     prevEl: '.swiper-button-prev',
   },
 });

 $('.swiper-pagination-fraction').each(function() {
	 var text = $(this).html();
	 $(this).html(text.replace(' / ', ' '));

 });
</script>

<style>    
	.best_gift .p_pagination {position: absolute; bottom: 0px; width: 232px; height: 44px; left: 50%; margin-left: -116px;}
	.best_gift .swiper-pagination {font-size: 18px; line-height: 21px; height:44px;}
	_:-ms-fullscreen, :root .best_gift .swiper-pagination {line-height: 44px !important; bottom:0px !important;}
	_:-ms-fullscreen, :root .best_gift .p_pagination {bottom:20px !important;}
	.best_gift .swiper-pagination span.swiper-pagination-current {font-family: font_gs, sans-serif; font-weight:bold; color: #000; margin-right: 8px; line-height: 21px;}
	.best_gift .swiper-pagination span.swiper-pagination-total {font-family: font_gs, sans-serif; font-weight:normal; color: #777; line-height: 21px;}
	.best_gift .swiper-button-area {position:absolute;width:232px;left:50%;margin-left:-116px;bottom:0;height:44px; top:auto;}
	.best_gift .swiper-button-next {position:absolute; width:44px; height:44px; background:url('https://simage.kyobobook.co.kr/newimages/giftshop_new/resources/img/common/icon_swiper_arr03.png') no-repeat; background-position:-88px 0; overflow:hidden; font-size:0; line-height:0px; text-indent:-9999px; opacity: 1; top:auto;}
	.best_gift .swiper-button-prev {position:absolute; width:44px; height:44px; background:url('https://simage.kyobobook.co.kr/newimages/giftshop_new/resources/img/common/icon_swiper_arr03.png') no-repeat; background-position:-44px 0; overflow:hidden; font-size:0; line-height:0px; text-indent:-9999px; opacity: 1; top:auto;}
	.best_gift .swiper-button-next.swiper-button-disabled {position:absolute; width:44px; height:44px; background-position:100% 0; overflow:hidden; font-size:0; line-height:0px; text-indent:-9999px; opacity: 1;}
	.best_gift .swiper-button-prev.swiper-button-disabled {position:absolute; width:44px; height:44px; background-position:0 0; overflow:hidden; font-size:0; line-height:0px; text-indent:-9999px; opacity: 1;}
	.best_gift .swiper-button-next, .swiper-button-prev {display: inline-flex;}
</style>
<!-- 레코벨 추천상품 end-->

<!-- 상품정보 -->
<div class="detail_p_info">
    <!-- 음반정보 -->
    <div class="" id="detail_cont01">
        <ul class="detail_tab">
            <li class="active"><a href="#detail_cont01">상품설명<span class="hidden_obj">- 현재진행단계</span></a></li>
            <li><a href="#detail_cont02">상품후기<span class="product-estimation c_salmon mgl10">(0)</span></a></li>
            <li><a href="#detail_cont03">상품Q&amp;A<span class="product-qna c_salmon mgl10">(0)</span></a></li>
            <li><a href="#detail_cont04">배송/교환/반품</a></li>
        </ul>
        
        <c:if test="${not empty prdtNotiInfo}">
            <c:import url="/pages/front/product/import/layerDetail${prdtNotiInfo.gbnCode}.jsp" charEncoding="utf-8"/>
        </c:if>
        <c:if test="${empty prdtNotiInfo}">
            <table class="table04 mgt80">
                <tr><td>상품정보 준비중입니다.</td></tr>
            </table>
        </c:if>
        
        <c:if test="${not empty bnrPrdtDetail}">
            <c:forEach var="l" varStatus="st" items="${bnrPrdtDetail}">
                <p style="text-align:center;margin:20px 0;">
                    <c:if test="${l.linkUrl ne '#'}"> 
                        <a href="${l.linkUrl }"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${l.imgUrl }" style="max-width:100%;"/></a>
                    </c:if>
                    <c:if test="${l.linkUrl eq '#'}"> 
                        <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${l.imgUrl }" style="max-width:100%;"/>
                    </c:if>
                </p>
            </c:forEach>
        </c:if>
        <c:if test="${fn:startsWith(ext.vndrCntrtId, 'A420') && (fn:startsWith(category.cateId, '000020') || fn:startsWith(category.cateId, '000021'))}">
            <p style="text-align:center;margin:20px 0;"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/1272/1466640532076_scr_19.jpg"/></p>
        </c:if>
        
        <div class="detail_product_img" style="line-height: normal;font-size: medium;font-family: initial;">
            <c:forEach items="${vndrNoti}" var="l" varStatus="st">
                <div>${l.content}</div>
            </c:forEach>
            <c:if test="${not empty ext.dtlBrandImg}">
                <p><ui:image src="${ext.dtlBrandImg}" server="brand"/></p>
            </c:if>
            ${ext.prdtDtlInfo}
    </div>
    <!-- //음반정보 -->

    <!-- 상품후기 -->
    <div style="padding-top:140px;" id="detail_cont02">
        <ul class="detail_tab">
            <li><a href="#detail_cont01">상품설명</a></li>
            <li class="active"><a href="#detail_cont02">상품후기<span class="product-estimation c_salmon mgl10"></span><span class="hidden_obj">- 현재진행단계</span></a></li>
            <li><a href="#detail_cont03">상품Q&amp;A<span class="product-qna c_salmon mgl10">(0)</span></a></li>
            <li><a href="#detail_cont04">배송/교환/반품</a></li>
        </ul>
        
        <h2 class="hidden_obj">상품후기</h2>
        <div class="tbl_top mgt0">
            <p class="txt_l">이상품, 어떠셨나요? 상품구입 후 상품평을 등록해 주시면, 포인트를 적립해 드립니다. 생애 첫 후기 200P 적립 / 기본 100P 적립</p>
            <div class="f_right">
                <a href="javascript:;" id="aWriteCommentBtn" class="btn_type02_v1">상품평쓰기</a>
            </div>
        </div>
        <div id="divSubCommentList"></div>
    </div>
    <!-- //상품후기 -->

    <!-- 상품Q&amp;A -->
    <div style="padding-top:140px;" id="detail_cont03">
        <ul class="detail_tab">
            <li><a href="#detail_cont01">상품설명</a></li>
            <li><a href="#detail_cont02">상품후기<span class="product-estimation c_salmon mgl10"></span></a></li>
            <li class="active"><a href="#detail_cont03">상품Q&amp;A<span class="product-qna c_salmon mgl10">(0)</span><span class="hidden_obj">- 현재진행단계</span></a></li>
            <li><a href="#detail_cont04">배송/교환/반품</a></li>
        </ul>
        
        <h2 class="hidden_obj">상품Q&amp;A</h2>
        <div class="tbl_top mgt0">
            <p class="txt_l">상품 Q&A는 상품문의하기를, 주문/배송/교환/반품 문의는 고객센터 문의하기를 이용해 주시기 바랍니다.</p>
            <div class="f_right">
                <a href="#n" id="aWriteQuestionBtn" class="btn_type02_v1">상품문의하기</a>
                <a href="/ht/help/createCounselForm" class="btn_type02_v1 mgl7">고객센터 문의하기</a>
            </div>
        </div>
        <div id="divSubQuestionList"></div>
    </div>
    <!-- //상품Q&amp;A -->

    <!-- 배송/교환/반품 -->
    <div style="padding-top:140px;" id="detail_cont04">
        <ul class="detail_tab">
            <li><a href="#detail_cont01">상품설명</a></li>
            <li><a href="#detail_cont02">상품후기<span class="product-estimation c_salmon mgl10"></span></a></li>
            <li><a href="#detail_cont03">상품Q&amp;A<span class="product-qna c_salmon mgl10">(0)</span></a></li>
            <li class="active"><a href="#detail_cont04">배송/교환/반품<span class="hidden_obj">- 현재진행단계</span></a></li>
        </ul>

        <h2 class="hidden_obj">배송/교환/반품</h2>
        <div class="detail_info_box">
            <div class="inner mgt0">
                <h3>배송안내</h3>
                <div class="txt_wrap">
                    <ul>
                        <li><span class="bu">-</span>핫트랙스 배송 : 2만원 이상 구매 시 무료배송/ 2만원 미만 구매 시 배송비 2,000원</li>
                        <li><span class="bu">-</span>브랜드별 배송 : 브랜드 정책에 따라 무료배송 혹은 배송비 부과 (상품상세정보에서 배송비 기준 확인가능)</li>
                    </ul>
                    <h4>* 배송비</h4>
                    <ul>
                        <li><span class="bu">-</span>도서, 산간, 오지, 일부지역, 설치배송 상품 등은 배송비가 추가될 수 있습니다.</li>
                        <li><span class="bu">-</span>무료배송 상품과 함께 구입 시, 기준금액 미만으로 구입하시더라도 해당 브랜드 상품은 무료배송 됩니다.</li>
                        <li><span class="bu">-</span>핫트랙스 배송과 브랜드 개별 배송비는 별도로 부과 됩니다.</li>
                    </ul>
                    <h4>* 배송기간 및 방법</h4>
                    <ul>
                        <li><span class="bu">-</span>결제 완료 후, 1~5일 이내에 배송 됩니다. (단, 상품의 재고 상황이나 배송 상황, 지역특성에 따라 배송이 지연될 수 있습니다.)</li>
                        <li><span class="bu">-</span>주문제작 상품 및 가구와 같은 업체 직배송 상품은 제작기간과 배송시기를 별도 확인하시기 바랍니다.</li>
                    </ul>
                </div>
            </div>
            <div class="inner">
                <h3>반품/교환 안내</h3>
                <div class="txt_wrap">
                    <ul>
                        <li><span class="bu">-</span>상품 설명에 반품/교환 관련 안내가 있는 경우 그 내용을 우선으로 합니다. (업체 사정에 따라 변경 될 수 있습니다.)</li>
                        <li><span class="bu">-</span>브랜드별 배송 : 브랜드 정책에 따라 무료배송 혹은 배송비 부과 (상품상세정보에서 배송비 기준 확인가능)</li>
                    </ul>
                    <h4>* 반품/교환 방법</h4>
                    <ul>
                        <li><span class="bu">-</span>MY HOTTRACKS &gt; 주문정보 &gt; 반품/교환신청</li>
                        <li><span class="bu">-</span>고객센터 &gt; SOS상담</li>
                        <li><span class="bu">-</span>고객센터 (1661-1112)</li>
                    </ul>
                    <h4>* 반품/교환가능 기간</h4>
                    <ul>
                        <li><span class="bu">-</span>변심반품의 경우 수령 후 7일 이내, 상품의 결함 및 계약내용과 다를 경우 문제점 발견 후 30일 이내</li>
                        <li><span class="bu">-</span>상품불량 및 오배송 등의 이유로 반품/교환을 하실 경우 반품/교환비는 무료 입니다.<br />(단, 판매자가 반품된 상품 확인 후 상품불량이 아닌 것으로 확인 될 시 반송비를 고객님께 부과할 수 있습니다.)</li>
                        <li><span class="bu">-</span>고객변심으로 인한 교환/반품의 배송비는 고객님 부담 입니다.</li>
                        <li><span class="bu">-</span>고객변심으로 인한 교환/반품 시 주문에 사용된 할인쿠폰은 반환되지 않습니다.</li>
                    </ul>
                    <h4>* 반품/교환 불가사유</h4>
                    <ul>
                        <li><span class="bu">-</span>반품/교환 가능 기간을 초과한 경우</li>
                        <li><span class="bu">-</span>소비자의 책임 있는 사유로 상품 등이 손실 또는 훼손된 경우 (단지 확인을 위한 포장 훼손은 제외)</li>
                        <li><span class="bu">-</span>소비자의 사용, 포장 개봉에 의해 상품 등의 가치가 현저히 감소한 경우 (예: 밀봉상품, 제품 수선, 세탁, 기타 사용/분리/훼손)</li>
                        <li><span class="bu">-</span>설치상품의 경우 설치가 완료되어 상품의 가치가 훼손된 경우 (예: 설치가전, 가구, 식품 등)</li>
                        <li><span class="bu">-</span>소비자의 요청에 따라 개별적으로 주문 제작되는 상품의 경우</li>
                        <li><span class="bu">-</span>시간의 경과에 의해 재판매가 곤란한 정도로 가치가 현저히 감소한 경우</li>
                        <li><span class="bu">-</span>전자상거래 등에서의 소비자보호에 관한 법률이 정하는 소비자 청약철회 제한 내용에 해당되는 경우</li>
                        <li><span class="bu">-</span>복제가 가능한 상품 등의 포장을 훼손한 경우 (예: 음반/DVD/비디오, 소프트웨어, 영상화보집)</li>
                    </ul>
                </div>
            </div>
            <div class="inner">
                <h3>기타 사항</h3>
                <div class="txt_wrap">
                    <ul>
                        <li><span class="bu">-</span>상품의 불량에 의한 교환, A/S, 환불, 품질보증 및 피해보상 등에 관한 사항은 소비자분쟁해결 기준 (공정거래위원회 고시)에 준하여 처리됨</li>
                        <li><span class="bu">-</span>대금 환불 및 환불지연에 따른 배상금 지급 조건, 절차 등은 전자상거래 등에서의 소비자 보호에 관한 법률에 따라 처리함</li>
                        <li><span class="bu">-</span>구매자가 미성년자인 경우에는 상품 구입 시 법정대리인이 동의 하지 아니하면 미성년자 본인 또는 법정대리인이 구매취소 할 수 있습니다.</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <!-- //배송/교환/반품 -->
</div>
</div>
	<!-- //상품정보 -->
	<div id="formBaseHtml">
	    <input type="hidden" value="${ext.sellPrdtBcode}" name="sellPrdtBcode">
	    <input type="hidden" value="1" name="prdtCount">
	</div>
	<form name="sForm" id="sFormDiv" method="post"></form>
	<form name="vForm" id="vFormDiv" method="post"></form>
	<div class="alert_wrap">
	    <div class="inbox"></div>
	</div>
</body>
</html>