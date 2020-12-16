<%@page contentType="application/javascript" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<ui:decorator name="none"/>

function isEmpty(val) {
    if(val == null || val == '' || val == undefined || val == 'undefined')
        return true;

    return false;
}

function login() {
    var returnUrl = (document.location.href).split('#')[0];
    var kyoboLoginUrl = '<ui:variable key="kyobo.server"/><ui:variable key="kyobo.login.uri"/>' + escape(returnUrl);
    
    document.location.href = kyoboLoginUrl;
}

function needLogin() {
    if (confirm('로그인하셔야합니다. 로그인하시겠습니까?')) {
        var returnUrl = (document.location.href).split('#')[0];
        var kyoboLoginUrl = '<ui:variable key="kyobo.server"/><ui:variable key="kyobo.login.uri"/>' + escape(returnUrl);
        document.location.href = kyoboLoginUrl;
            
        return true;
    } else {
        return false;
    }
}


function needLogin2(sellPrdtBcode) {
    if (confirm('로그인하셔야합니다. 로그인하시겠습니까?')) {
        var returnUrl = 'http://www.hottracks.co.kr/ht/mypage/orderDelivery?sellPrdtBcode='+sellPrdtBcode
        var kyoboLoginUrl = '<ui:variable key="kyobo.server"/><ui:variable key="kyobo.login.uri"/>' + escape(returnUrl);
        document.location.href = kyoboLoginUrl;
            
        return true;
    } else {
        return false;
    }
}

function needLoginForEmp(sellPrdtBcode) {
    if (confirm('로그인하셔야합니다. 로그인하시겠습니까?')) {
        var returnUrl = 'http://www.hottracks.co.kr/ht/goToReview/'+sellPrdtBcode;
        var kyoboLoginUrl = '<ui:variable key="kyobo.server"/><ui:variable key="kyobo.login.uri"/>' + escape(returnUrl);
        document.location.href = kyoboLoginUrl;
            
        return true;
    } else {
        return false;
    }
}


function goTopBooklog() {
    <c:if test="${isLogin}">
    goBookLog('${loginUser.id}');
    </c:if>
    <c:if test="${!isLogin}">
    alert('먼저 로그인 하셔야 합니다.');
    </c:if>
}

function productPreview(barcode, ctgrId) {
    var url = "/ht/product/popupDetail?barcode=" + barcode;
    if (isEmpty(ctgrId) == false) {
        url += "&ctgrId="+ctgrId;
    }
    
    window.open(url, "", "width=785, height=635, scrollbars=yes");
}

function productSimpleViewRecord(sellPrdtBcode) {
    var url = "/ht/product/productSimpleViewRecord/"+sellPrdtBcode;

    window.open(url, "", "width=800, height=437, scrollbars=yes");
}

function productSimpleViewDvd(sellPrdtBcode) {
    var url = "/ht/product/productSimpleViewDvd/"+sellPrdtBcode;
   
    window.open(url, "", "width=800, height=520, scrollbars=yes");
}

function price_format(val){
    val = $.trim(val+"");
    if(val == ''){ return val; }
    if(isNaN(val)){ return val; }

    var rv = "", idx = 0;
    for(var i = val.length-1 ; i >= 0 ; i--){
        rv = ((idx != 0 && idx%3 == 0) ? val.substring(i, i+1) + "," : val.substring(i, i+1)) + rv;
        idx++;
    }
    
    return rv;
}

jQuery(function($) {
    $(document).ready(function() {
        
        var wideYn = getCookie("CookieName_WIDEBNR");
        //console.log(wideYn);
        if (!isEmpty(wideYn) && wideYn == "no") {
            $(".gnb-wide-bnr").hide();
        }
        
        initTopNavigation();
        
        
        if(location.pathname == "/ht/gift/giftCategoryMain" || location.pathname == "/ht/gift/giftCategorySub"){
            // params = location.search.substring("&");
            var idx = location.search.indexOf("ctgrId=");
            if(idx > 0){
                var ids = idx + 7;
                var ide = ids + 13;
                ctgrId = location.search.substring(ids, ide);
                if(ctgrId.indexOf("000020")  == 0)   $("#gnb .depth01 li a").eq(0).addClass("active");   // 디자인문구
                if(ctgrId.indexOf("000022")  == 0)   $("#gnb .depth01 li a").eq(1).addClass("active");   // 디지털
                if(ctgrId.indexOf("000007")  == 0)   $("#gnb .depth01 li a").eq(2).addClass("active");   // 고급필기루
                if(ctgrId.indexOf("000021")  == 0)   $("#gnb .depth01 li a").eq(3).addClass("active");   // 오피스
                if(ctgrId.indexOf("000025")  == 0)   $("#gnb .depth01 li a").eq(4).addClass("active");   // 생활가전
                if(ctgrId.indexOf("000026")  == 0)   $("#gnb .depth01 li a").eq(5).addClass("active");   // 생활가전
                if(ctgrId.indexOf("000024")  == 0)   $("#gnb .depth01 li a").eq(6).addClass("active");   // 가구수납
                if(ctgrId.indexOf("000028")  == 0)   $("#gnb .depth01 li a").eq(7).addClass("active");   // 패션잡화
                if(ctgrId.indexOf("000006")  == 0)   $("#gnb .depth01 li a").eq(8).addClass("active");   // 뷰티헬스
                if(ctgrId.indexOf("000027")  == 0)   $("#gnb .depth01 li a").eq(9).addClass("active");   // 여행자동차
                if(ctgrId.indexOf("000023")  == 0)   $("#gnb .depth01 li a").eq(10).addClass("active");   // 취미/펫
                if(ctgrId.indexOf("000029")  == 0)   $("#gnb .depth01 li a").eq(11).addClass("active");   // 유아동
                
            }
        }else if(location.pathname == "/ht/recordMain" || location.pathname == "/ht/recordMainHtml"){
            $("#gnb .depth01 li a").eq(12).addClass("active");
        }else if(location.pathname == "/ht/dvdMain" || location.pathname == "/ht/dvdMainHtml"){
            $("#gnb .depth01 li a").eq(13).addClass("active");
        }
    });
    
    $(".gnb-wide-bnr .close").click(function(){
        document.cookie = "CookieName_WIDEBNR" + "=" + escape("no") + "; path=/;"
        $(".gnb-wide-bnr").slideUp("fast", function(){ 
            if($(window).scrollTop() > $("#container").offset().top){
                $("#quickmenu").css("padding-top", 0);
                $("#quickmenu .sall_box").css("top", 0);
            }else{
                $("#quickmenu").css("padding-top", $("#container").offset().top-$(window).scrollTop()+25);
                $("#quickmenu .sall_box").css("top", $("#container").offset().top-$(window).scrollTop()+25);
            }
        });
    });
    
    $('input.inputNumberText').keypress(function(event) {
        if (event.which != 13 && event.which != 18 && event.which != 19 && event.which != 46 && event.which != 37 && event.which != 39) {
            if (event.which < 48 || event.which > 57) {
                event.preventDefault();
            }
        }
    });
    
    $("a.goIEClipboard").each(function(){
        if(navigator.userAgent.toLowerCase().indexOf('msie')!=-1){
            $("a.goIEClipboard").show();
        }else{
            $("a.goIEClipboard").hide();
        }
    });
    
});

function goTwitter(msg,url) {
    var href = "http://twitter.com/home?status=" + encodeURIComponent(msg) + " " + encodeURIComponent(url);
    window.open(href, 'twitter', '');
}

function goFaceBook(msg,url) {
    var href = "http://www.facebook.com/sharer.php?u=" + encodeURIComponent(url) + "&t=" + encodeURIComponent(msg);
    window.open(href, 'facebook', '');
}

function goPinterest(msg,url) {
    var href = "https://www.pinterest.com/pin/create/button/?url=" + encodeURIComponent(url) + "&media=" + $(".sns_img:first").attr("src") + "&description=" + encodeURIComponent(msg);
    window.open(href, 'pinterest', '');
}

function goIEClipboard(msg) {
    if (window.clipboardData){
        var result = window.clipboardData.setData('text', msg);
        if(result){ 
            alert("복사되었습니다.\n붙여넣기(Ctrl+V)하여 사용하세요.");
        }
    }
}

function coupondown(couponId) {
    $.ajax({
        type: "POST"
        ,url:"/ht/coupon/productCouponDown"
        ,dataType: 'json'
        ,data : {couponId : couponId}
        ,success: function(data) {
            if (data.result) {
                if(data.result["V_RES_CODE"] == '200'){
                    alert("쿠폰이 다운로드 되었습니다.");
                }else{
                    alert(data.result["V_RES_CONT"]);
                }
            } else {
                alert('쿠폰 다운로드 중 오류가 발생하였습니다. 잠시후 다시 이용해주세요.');
            }
        }
        ,error: function() {
            console.log('<fmt:message key="error.common.system"/>');
        }
    });
}

isLogin = ${isLogin};
function coupondown2(couponId){
    if (!isLogin) {
        needLogin();
    } else {
        $.ajax({
            type: "GET"
            ,url: "/ht/getCouponDown"
            ,data: 'couponId=' + couponId
            ,dataType: "json"
            ,success: function(data) {
                if (data.save) {
                    alert("쿠폰이 다운로드 되었습니다.");
                } else {
                    alert(data.errorMessage);
                }
            }
            ,error: function() {
                alert('<fmt:message key="error.common.system"/>');
            }
        });
    }
}

function goValidEscrow(mertid){
    window.open("https://pgweb.dacom.net/pg/wmp/mertadmin/jsp/mertservice/s_escrowYn.jsp?mertid="+mertid,"check","width=339, height=263, scrollbars=no, left = 200, top = 50");  
}

var sslHost = "${sslHost}";
function buyMusicGiftForDownload(prdtBcode, prdtCount){
    if(typeof prdtCount == "undefined" || prdtCount == 0) {
        prdtCount = 1;
    }
    
    // 바로 주문
    $.ajax({
        type: "POST"
        ,url: "/ht/order/quickOrder"
        ,dataType: "json"
        ,data : {
            sellPrdtBcode : prdtBcode
            , prdtCount : prdtCount
        }
        ,success : function(data){
            if(data.save) {
                location.href= sslHost + "/ht/order/musicOrderSheet";
            } else {
                var errorMessages = data.errorMessages;
                alert(errorMessages.join("\n"));
            }
        } 
        ,error: function(data) {
            console.log('<fmt:message key="error.common.system"/>');
        }
    });
}

/* 시작페이지 설정 */
function setStartPage(Obj){
    var strUrl = "http://www.hottracks.co.kr/ht/welcomeMain";
    
    if(document.all){  // ie
        document.body.style.behavior='url(#default#homepage)';
        document.body.setHomePage(strUrl);
    }else{
        alert("이용하시는 웹 브라우저는 이 기능이 지원되지 않습니다.\n- 이용 가능 웹브라우저 : Internet Explorer");
    }
}

/* 즐겨찾기 추가 */
function setFavoritePage(){
    var title = '핫트랙스';
    var url = 'http://www.hottracks.co.kr/ht/welcomeMain'
    if(window.sidebar && window.sidebar.addPanel){  // Firefox
        window.sidebar.addPanel(title, url,"");
    }else if(window.opera && window.print){         // Opera
        var elem = document.createElement('a');
        elem.setAttribute('href',url);
        elem.setAttribute('title',title);
        elem.setAttribute('rel','sidebar');
        elem.click();
    }else if(document.all){                         // ie
        window.external.AddFavorite(url, title);
    }else{
        alert("이용하시는 웹 브라우저는 기능이 지원되지 않습니다.\n- 이용 가능 웹브라우저 : Internet Explorer, Firefox, Opera");
    }
}

/* 클립보드에 복사 */
function copyToClipboard(text){
    if (window.clipboardData){      // the IE-manier
        window.clipboardData.setData("Text", text);
        alert("복사되었습니다.\n--------------------------------------\n" + text);
    }else{
        // alert("이용하시는 웹 브라우저는 기능이 지원되지 않습니다.\n- 이용 가능 웹브라우저 : Internet Explorer");
        var wnd = window.open("about:blank", "_copy", "width=700, height=437, scrollbars=yes");
        var str = "";
        str += '<p style="color:blue;border-bottom:1px solid #dadada;padding-bottom:5px">※ 해당 브라우저는 복사기능이 지원되지 않습니다. 아래내용을 복사해주세요.</p>';
        str += text.split("\r\n").join("<br/>");
        wnd.document.write(str);
        wnd.focus();
    }
}
/* 쿠키 설정 */
function setCookie(name, value, expiredays){ 
    // setCookie("CookieName"+GOOD.NOTICEBBS_SEQ, "no" , 1);   // 부모창에서 지정한 쿠키네임과 일치 해야 합니다.
    var todayDate = new Date(); 
    todayDate.setDate( todayDate.getDate() + expiredays ); 
    document.cookie = name + "=" + escape(value) + "; path=/; expires=" + todayDate.toGMTString() + ";"
}

/* 쿠키 로드 */
function getCookie(name){
    var Found = false;
    var start, end;
    var i = 0;

    while(i <= document.cookie.length) {
        start = i;
        end = start + name.length;
        if(document.cookie.substring(start, end) == name) {
            Found = true;
            break;
        }
        i++;
    }

    if(Found == true) {
        start = end + 1;
        end = document.cookie.indexOf(";", start);
        if(end < start)    end = document.cookie.length
        return document.cookie.substring(start, end)
    }
    return ""
} 

// 회원정보 수정
function goModifyMemInfo(){
    if(!serviceCheck() && confirm("회원정보수정은 회원통합관리 정책에 따라 인터넷교보문고(http://www.kyobobook.co.kr)에서 가능합니다. 이동하시겠습니까?\n회원정보를 수정하시는 경우, 재로그인 하셔야 변경된 정보가 반영됩니다.")){
        /*document.location.href="https://www.kyobobook.co.kr/myroom/joinModForm.laf";*/ 
        document.location.href = "https://order.kyobobook.co.kr/myroom/commIframe?targetUrl=//www.kyobobook.co.kr/myroom/joinModFormIframe.laf?iframe_yn=Y";
    }
}

// 회원정보 탈퇴
function goDeleteMemInfo(){
    if(!serviceCheck() && confirm("회원탈퇴는 회원통합관리 정책에 따라 인터넷교보문고(http://www.kyobobook.co.kr)에서 가능합니다. 이동하시겠습니까?")){
         // document.location.href="https://www.kyobobook.co.kr/myroom/joinDelForm.laf";
         document.location.href = "https://order.kyobobook.co.kr/myroom/commIframe?targetUrl=//www.kyobobook.co.kr/myroom/joinDelFormIframe.laf?iframe_yn=Y";
    }
}

// 회원가입
function goMemJoin(){
    if(!serviceCheck()){
        // document.location.href = "https://www.kyobobook.co.kr/member/JoinMainHot.jsp";
        document.location.href = "https://www.kyobobook.co.kr/member/joinMain.laf?mallGb=HOT";
    }
}

// 통합회원동의
function goAgreeMemInfo(){
    if(!serviceCheck()){
        document.location.href="http://www.kyobobook.co.kr/member/joinAgreement.laf";
    }
}

// 서비스점검여부
function serviceCheck(skip){
    // alert("서비스 점검중입니다. (23:00 ~ 07:00)");
    /*
    if(skip == undefined || !skip){
        // var pop = window.open('about:blank' ,'popupPrepared' ,'width=300 , height=430');
        if(!$("#serviceReady").hasClass("serviceReady")){
            window.open('/serviceCheck.html' ,'popupPrepared' ,'left=100,top=100,width=800, height=350');
        }
    }
    */
    return false;
}

// GNB 장바구니 카운드 갱신
function initTopNavigation() {
    $.ajax({
        type: 'GET'
        ,url: '/ht/order/ajaxGetCartCount'
        ,dataType: 'json'
        ,success: function(data) {
            $('.cartCount').html('(' + price_format(data.cartCount) + ')');
            $('#quickmenu #cartCnt').html('(' + price_format(data.cartCount) + ')');
            $('#quickmenu #wishCnt').html('(' + price_format(data.wishCount) + ')');
        }
        ,error: function(data) {
            // ignore
        }
    });
}

/* 개별 상품 찜하기 */
function addWishProduct(barcode) {
    <c:if test='${!isLogin}'>
        needLogin();
        // location.href = '<ui:variable key="kyobo.server"/><ui:variable key="kyobo.login.uri"/>' + escape((document.location.href).substr(0,(document.location.href).indexOf('#')));
    </c:if>
    <c:if test='${isLogin}'>
        $.ajax({
            type: 'GET'
            ,url: '/ht/mypage/addWishPrdt'
            ,data: 'barcode=' + barcode
            ,dataType: 'json'
            ,success: function(data) {
                var size = data.errorMessages.length;
                if (size == 0) {
//                    window.open('/ht/mypage/wishPrdtPop?sellPrdtBcode=' + barcode, '','width=446, height=330' );
//                    
//                    cnt = $("#likeCnt"+barcode);
//                    if(cnt.length == 1){
//                        cntNum = parseInt(cnt.text());
//                        cnt.text(price_format(cntNum+1));
//                    }
                    location.reload(true);
                } else {
                    alert(data.errorMessages);
                }
            }
            ,error: function(data) {
                console.log('<fmt:message key="error.common.system"/>');
            }
        });
    </c:if>
}

/* 상품 좋아요삭제*/
function removeWishProduct(barcode) {
    <c:if test='${!isLogin}'>
        needLogin();
    </c:if>
    <c:if test='${isLogin}'>
        $.ajax({
            type: 'GET'
            ,url: '/ht/mypage/removeWishProduct'
            ,data: 'barcode=' + barcode
            ,dataType: 'json'
            ,success: function(data) {
                if(data.save != false) {
//                    window.open('/ht/mypage/removeWishPrdtPop?barcode=' + barcode, '','width=446, height=330' );
//                    
//                    cnt = $("#likeCnt"+barcode);
                    location.reload(true);
                } else {
                    alert(data.errorMessages);
                }
            }
            ,error: function(data) {
                console.log('<fmt:message key="error.common.system"/>');
            }
        });
    </c:if>
}


/* 개별 브랜드 찜하기 */
function addWishBrand(brandId) {
    <c:if test='${!isLogin}'>
        needLogin();
        // location.href = '<ui:variable key="kyobo.server"/><ui:variable key="kyobo.login.uri"/>' + escape((document.location.href).substr(0,(document.location.href).indexOf('#')));
    </c:if>
    <c:if test='${isLogin}'>
        $.ajax({
            type: 'GET'
            ,url: '/ht/mypage/addWishBrand'
            ,data: 'brandId=' + brandId
            ,dataType: 'json'
            ,success: function(data) {
                var size = data.errorMessages.length;
                if (size == 0) {
                    window.open('/ht/mypage/wishBrandPop?brandId=' + brandId, '','width=446, height=330' );
                    location.reload(true);
                } else {
                    alert(data.errorMessages);
                }
            }
            ,error: function(data) {
                console.log('<fmt:message key="error.common.system"/>');
            }
        });
    </c:if>
}

/* 좋아요 브랜드 지우기 */
function removeWishBrand(brandId, brandName) {
    <c:if test='${!isLogin}'>
        needLogin();
    </c:if>
    <c:if test='${isLogin}'>
        $.ajax({
            type: 'GET'
            ,url: '/ht/mypage/deleteWishBrand'
            ,data: 'brandId=' + brandId
            ,dataType: 'json'
            ,success: function(data) {
                
                if(data.save != false) {
                    window.open('/ht/mypage/removeWishBrandPop?brandId=' + brandId, '','width=446, height=330' );
                    location.reload(true);
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

function addWishProductList(barcodeList) {
    <c:if test='${!isLogin}'>
        if (needLogin()) {
            $('img#eventFloatingIcon').hide();
        }
    </c:if>
    <c:if test='${isLogin}'>
        $.ajax({
            type: 'GET'
            ,url: '/ht/mypage/addWishProductList'
            ,data: 'barcodes=' + barcodeList.join('&barcodes=')
            ,dataType: 'json'
            ,success: function(data) {
                var size = data.errorMessages.length;
                if (size == 0) {
                   alert("찜상품으로 저장되었습니다.");
                } else {
                    alert(data.errorMessages);
                }
            }
            ,error: function(data) {
                console.log('<fmt:message key="error.common.system"/>');
            }
        });
    </c:if>
}

function checkLength(chkObj, printObj, maxLength){
    if(preValidation()){
        var str = new String($(chkObj).val());
        var _byte = 0;
        if(str.length != 0){
            for(var i = 0; i < str.length; i++){
                if(escape(str.charAt(i)).length > 4)    _byte += 2;
                else                                    _byte++;
    
                if(_byte > maxLength){
                    alert('제한 글자 수를 초과하였습니다');
                    $(chkObj).val(str.substr(0, i-1));
    
                    if(escape(str.charAt(i)).length > 4)    _byte -= 2;
                    else                                    _byte--;
    
                    break;
                }
            }
        }
        
        $(printObj).html(Byte_Length($(chkObj).val()));
    }
}
/* 오늘 날짜 구하기 */
function returnToday(){
    var now = new Date();
    var year= now.getFullYear();
    var mon = (now.getMonth()+1) > 9 ? ''+(now.getMonth()+1) : '0'+(now.getMonth()+1);
    var day = now.getDate() > 9 ? ''+now.getDate() : '0'+now.getDate();
             
    var today = year + '' + mon + '' + day;
    return today;
}
function Byte_Length(lvStr){
    var resultSize = 0;
    if (lvStr == null) return 0;
    for(var i=0; i<lvStr.length; i++){
        var c = escape(lvStr.charAt(i));
        if(c.length == 1) resultSize ++;
        else if(c.indexOf("%u") != -1) resultSize += 2;
        else if(c.indexOf("%") != -1) resultSize += c.length/3;
    }
    return resultSize;
}

// MOVE TO TOP
function moveTop(){
    moveScroll(0);
}

// MOVE TO BOTTOM
function moveBottom(){
    moveScroll($(document).height());
}

function moveScroll(scroll){
    $("html, body").stop(true,true).animate({
        "scrollTop":scroll
    },500);
}

// 배경이미지 펌핑 (클래스명, 단계, 적용ms)
function setPumpBackground(clsName, step, pumpTime){
	if($(clsName).length > 0){
	    var pump;
	    
	    var btn = $(clsName);
	    var baseSize = parseInt(btn.css("background-size"));
	    var baseGap = parseInt($(".btn_like").css("background-position").split(" ")[0]);
	    var size = baseSize;
	    var up = true;
	    var idx = 0;
	    $(clsName+".pump").hover(
	            function(){
	                pump = setInterval(function(){
	                    if(up){
	                        if(idx > step)    up = false;
	                        else              idx++;
	                    }else {
	                        if(idx > 0)       idx--;
	                        else              up = true;
	                    }
	                    btn.css({backgroundSize:baseSize+(idx*2),backgroundPositionX:baseGap-idx});
	                }, pumpTime);
	            }
	          , function(){
	                clearInterval(pump);
	                size = baseSize;
	                up = true;
	                idx = 0;
	                $(this).css({backgroundSize:baseSize,backgroundPositionX:baseGap});
	            }
	    );
	}
}


// 최근본 상품 등록
function saveRecentProduct(sellPrdtBcode){
    $.ajax({
        type: "POST"
        ,url: "/ht/checkRecentProduct"
        ,dataType: "json"
        ,async: true
        ,data : { sellPrdtBcode : sellPrdtBcode }
        ,success : function(data){ } 
        ,error: function(data) { }
    });
}

// 최근본 상품 관리
function Fn_rcntChangMode(mode){
    if(mode == "A"){
        $("#ly_recent").addClass("checkmod");
        $("#ly_recent").find(".prod_basic05 a").addClass("active");
    }else if(mode == "Y"){
            $("#ly_recent").addClass("checkmod");
    }else if(mode == "N"){
        $("#ly_recent").removeClass("checkmod");
        $("#ly_recent").find(".prod_basic05 a").removeClass("active");
    }
}

function Fn_rcntItemClick(sellPrdtBcode){
    if($("#ly_recent").hasClass("checkmod")){
        var item = $("#ly_recent").find("#rcntProd"+sellPrdtBcode)
        if(item.hasClass("active"))    item.removeClass("active");
        else                           item.addClass("active");
    }else{
        location.href="${defaultHost}/p/"+sellPrdtBcode;
    }
}


function SHA256(s){
    
    var chrsz   = 8;
    var hexcase = 0;
  
    function safe_add (x, y) {
        var lsw = (x & 0xFFFF) + (y & 0xFFFF);
        var msw = (x >> 16) + (y >> 16) + (lsw >> 16);
        return (msw << 16) | (lsw & 0xFFFF);
    }
  
    function S (X, n) { return ( X >>> n ) | (X << (32 - n)); }
    function R (X, n) { return ( X >>> n ); }
    function Ch(x, y, z) { return ((x & y) ^ ((~x) & z)); }
    function Maj(x, y, z) { return ((x & y) ^ (x & z) ^ (y & z)); }
    function Sigma0256(x) { return (S(x, 2) ^ S(x, 13) ^ S(x, 22)); }
    function Sigma1256(x) { return (S(x, 6) ^ S(x, 11) ^ S(x, 25)); }
    function Gamma0256(x) { return (S(x, 7) ^ S(x, 18) ^ R(x, 3)); }
    function Gamma1256(x) { return (S(x, 17) ^ S(x, 19) ^ R(x, 10)); }
  
    function core_sha256 (m, l) {
         
        var K = new Array(0x428A2F98, 0x71374491, 0xB5C0FBCF, 0xE9B5DBA5, 0x3956C25B, 0x59F111F1,
            0x923F82A4, 0xAB1C5ED5, 0xD807AA98, 0x12835B01, 0x243185BE, 0x550C7DC3,
            0x72BE5D74, 0x80DEB1FE, 0x9BDC06A7, 0xC19BF174, 0xE49B69C1, 0xEFBE4786,
            0xFC19DC6, 0x240CA1CC, 0x2DE92C6F, 0x4A7484AA, 0x5CB0A9DC, 0x76F988DA,
            0x983E5152, 0xA831C66D, 0xB00327C8, 0xBF597FC7, 0xC6E00BF3, 0xD5A79147,
            0x6CA6351, 0x14292967, 0x27B70A85, 0x2E1B2138, 0x4D2C6DFC, 0x53380D13,
            0x650A7354, 0x766A0ABB, 0x81C2C92E, 0x92722C85, 0xA2BFE8A1, 0xA81A664B,
            0xC24B8B70, 0xC76C51A3, 0xD192E819, 0xD6990624, 0xF40E3585, 0x106AA070,
            0x19A4C116, 0x1E376C08, 0x2748774C, 0x34B0BCB5, 0x391C0CB3, 0x4ED8AA4A,
            0x5B9CCA4F, 0x682E6FF3, 0x748F82EE, 0x78A5636F, 0x84C87814, 0x8CC70208,
            0x90BEFFFA, 0xA4506CEB, 0xBEF9A3F7, 0xC67178F2);

        var HASH = new Array(0x6A09E667, 0xBB67AE85, 0x3C6EF372, 0xA54FF53A, 0x510E527F, 0x9B05688C, 0x1F83D9AB, 0x5BE0CD19);

        var W = new Array(64);
        var a, b, c, d, e, f, g, h, i, j;
        var T1, T2;
  
        m[l >> 5] |= 0x80 << (24 - l % 32);
        m[((l + 64 >> 9) << 4) + 15] = l;
  
        for ( var i = 0; i<m.length; i+=16 ) {
            a = HASH[0];
            b = HASH[1];
            c = HASH[2];
            d = HASH[3];
            e = HASH[4];
            f = HASH[5];
            g = HASH[6];
            h = HASH[7];
  
            for ( var j = 0; j<64; j++) {
                if (j < 16) W[j] = m[j + i];
                else W[j] = safe_add(safe_add(safe_add(Gamma1256(W[j - 2]), W[j - 7]), Gamma0256(W[j - 15])), W[j - 16]);
  
                T1 = safe_add(safe_add(safe_add(safe_add(h, Sigma1256(e)), Ch(e, f, g)), K[j]), W[j]);
                T2 = safe_add(Sigma0256(a), Maj(a, b, c));
  
                h = g;
                g = f;
                f = e;
                e = safe_add(d, T1);
                d = c;
                c = b;
                b = a;
                a = safe_add(T1, T2);
            }
  
            HASH[0] = safe_add(a, HASH[0]);
            HASH[1] = safe_add(b, HASH[1]);
            HASH[2] = safe_add(c, HASH[2]);
            HASH[3] = safe_add(d, HASH[3]);
            HASH[4] = safe_add(e, HASH[4]);
            HASH[5] = safe_add(f, HASH[5]);
            HASH[6] = safe_add(g, HASH[6]);
            HASH[7] = safe_add(h, HASH[7]);
        }
        return HASH;
    }
  
    function str2binb (str) {
        var bin = Array();
        var mask = (1 << chrsz) - 1;
        for(var i = 0; i < str.length * chrsz; i += chrsz) {
            bin[i>>5] |= (str.charCodeAt(i / chrsz) & mask) << (24 - i%32);
        }
        return bin;
    }
  
    function Utf8Encode(string) {
        string = string.replace(/\r\n/g,"\n");
        var utftext = "";
  
        for (var n = 0; n < string.length; n++) {
  
            var c = string.charCodeAt(n);
  
            if (c < 128) {
                utftext += String.fromCharCode(c);
            }
            else if((c > 127) && (c < 2048)) {
                utftext += String.fromCharCode((c >> 6) | 192);
                utftext += String.fromCharCode((c & 63) | 128);
            }
            else {
                utftext += String.fromCharCode((c >> 12) | 224);
                utftext += String.fromCharCode(((c >> 6) & 63) | 128);
                utftext += String.fromCharCode((c & 63) | 128);
            }
  
        }
  
        return utftext;
    }
  
    function binb2hex (binarray) {
        var hex_tab = hexcase ? "0123456789ABCDEF" : "0123456789abcdef";
        var str = "";
        for(var i = 0; i < binarray.length * 4; i++) {
            str += hex_tab.charAt((binarray[i>>2] >> ((3 - i%4)*8+4)) & 0xF) +
            hex_tab.charAt((binarray[i>>2] >> ((3 - i%4)*8  )) & 0xF);
        }
        return str;
    }
  
    s = Utf8Encode(s);
    return binb2hex(core_sha256(str2binb(s), s.length * chrsz));
  
}

/* 개별 상품 좋아요 추가 및 삭제 */
function addBizWishProduct(obj) {
    <c:if test='${!isLogin}'>
        needLogin();
    </c:if>
    <c:if test='${isLogin}'>

    var $prdObj = $(obj);
    var sellPrdtBcode = $prdObj.attr("prdtId");
    if($prdObj.hasClass('active')){	// 좋아요 삭제    
    	$.ajax({
            type: 'GET'
            ,url: '/ht/biz/mypage/removeWishProduct'
            ,data: 'barcode=' + sellPrdtBcode
            ,dataType: 'json'
            ,async: false
            ,success: function(data) {
                var size = data.errorMessages.length;
                if (size == 0) {                                                                            
                    $("a[prdtId="+sellPrdtBcode+"]").removeClass('active');    
                    
                    if($(".like[code="+ sellPrdtBcode +"]").length > 0){  
                    	$(".like[code="+ sellPrdtBcode +"]").text(data.wishCnt > 999 ? "999+" : data.wishCnt);
                    }
                } else {
                    //alert(data.errorMessages);
                    location.reload();
                }
            }
            ,error: function(data) {
                alert('<fmt:message key="error.common.system"/>');
            }
        });    
    }else{	// 좋아요 추가
 		$.ajax({
		    type: 'GET'
		    ,url: '/ht/biz/mypage/addWishPrdt'
		    ,data: 'barcode=' + sellPrdtBcode
		    ,dataType: 'json'
		    ,async: false
		    ,success: function(data) {
		        var size = data.errorMessages.length;
		        if (size == 0) {		        	    		           	        
		            $("a[prdtId="+sellPrdtBcode+"]").addClass('active');  
		            
		            if($(".like[code="+ sellPrdtBcode +"]").length > 0){ 		   
		            	$(".like[code="+ sellPrdtBcode +"]").text(data.wishCnt > 999 ? "999+" : data.wishCnt);  
		            }       		            		                               
		        } else {                	
		            //alert('<fmt:message key="error.common.system"/>');
		            location.reload();
		        }
		    }
		    ,error: function(data) {
		        alert('<fmt:message key="error.common.system"/>');
		    }
		});
    }
    </c:if>
}

/* 개별 브랜드 찜하기 */
function addBizWishBrand(brandId) {
    <c:if test='${!isLogin}'>
        needLogin();
    </c:if>
    <c:if test='${isLogin}'>
    	var $prdObj = $("#"+brandId);
	    if($prdObj.hasClass('on')){	// 좋아요 삭제
	        $.ajax({
            type: 'GET'
            ,url: '/ht/biz/mypage/deleteWishBrand'
            ,data: 'brandId=' + brandId
            ,dataType: 'json'
            ,success: function(data) {               
                if(data.save != false) {
                	$prdObj.removeClass('on');
                	
                    if($(".brandTxt[code="+ brandId +"]").length > 0){
                    	$(".brandTxt[code="+ brandId +"]").text(data.wishCnt > 999 ? "999+" : data.wishCnt);
                    }
                } else {
                    //alert(data.errorMessages);
                    location.reload();
                }
            }
            ,error: function(data) {
                alert('<fmt:message key="error.common.system"/>');
            }
        });
		}else{
			$.ajax({
	            type: 'GET'
	            ,url: '/ht/biz/mypage/addWishBrand'
	            ,data: 'brandId=' + brandId
	            ,dataType: 'json'
	            ,success: function(data) {
	                var size = data.errorMessages.length;
	                if (size == 0) {
	                    $prdObj.addClass('on');
	                    
	                    if($(".brandTxt[code="+ brandId +"]").length > 0){
	                    	$(".brandTxt[code="+ brandId +"]").text(data.wishCnt > 999 ? "999+" : data.wishCnt);
	                    }
	                } else {
	                    //alert(data.errorMessages);
	                    location.reload();
	                }
	            }
	            ,error: function(data) {
	                console.log('<fmt:message key="error.common.system"/>');
	            }
	        });
		}
    </c:if>
}

/* 이럴 때, 좋아요 추가 및 삭제 */
function addBizWishLife(obj) {
    <c:if test='${!isLogin}'>
        needLogin();
    </c:if>
    <c:if test='${isLogin}'>

    var $prdObj = $(obj);
    var svcSeq = $prdObj.attr("svcSeq");
    if($prdObj.prev('span').hasClass('on')){	// 좋아요 삭제    
    	$.ajax({
            type: 'GET'
            ,url: '/ht/biz/mypage/deleteWishLife'
            ,data: 'barcode=' + svcSeq
            ,dataType: 'json'
            ,async: false
            ,success: function(data) {
                if(data.save != false) {                                                                            
                    $("a[svcSeq="+svcSeq+"]").prev('span').removeClass('on');
                    
                    var d = new Date();
                    var url = "/images/biz/sub/heart_off.gif?a="+d.getTime();
                    $("a[svcSeq="+svcSeq+"]").prev('span').css({"background":""});
                    $("a[svcSeq="+svcSeq+"]").prev('span').css({background:"url("+url+") 50% 0% no-repeat",backgroundSize: 39});
                    
                    if($(".heart[code="+ svcSeq +"]").length > 0){  
                    	$(".heart[code="+ svcSeq +"]").text(data.wishCnt > 999 ? "999+" : data.wishCnt);
                    }
                } else {
                    //alert(data.errorMessages);
                    location.reload();
                }
            }
            ,error: function(data) {
                alert('<fmt:message key="error.common.system"/>');
            }
        });    
    }else{	// 좋아요 추가
 		$.ajax({
		    type: 'GET'
		    ,url: '/ht/biz/mypage/addWishLife'
		    ,data: 'barcode=' + svcSeq
		    ,dataType: 'json'
		    ,async: false
		    ,success: function(data) {
		        var size = data.errorMessages.length;
		        if (size == 0) {		        	    		           	        
		            $("a[svcSeq="+svcSeq+"]").prev('span').addClass('on');
		            
		            var d = new Date();
		            var url = "/images/biz/sub/heart_on.gif?a="+d.getTime();
		            $("a[svcSeq="+svcSeq+"]").prev('span').css({"background":""});
		            $("a[svcSeq="+svcSeq+"]").prev('span').css({background:"url("+url+") 50% 0% no-repeat",backgroundSize: 39});
		         
		            if($(".heart[code="+ svcSeq +"]").length > 0){ 		   
		            	$(".heart[code="+ svcSeq +"]").text(data.wishCnt > 999 ? "999+" : data.wishCnt);  
		            }       		            		                               
		        } else {                	
		            //alert('<fmt:message key="error.common.system"/>');
		            location.reload();
		        }
		    }
		    ,error: function(data) {
		        alert('<fmt:message key="error.common.system"/>');
		    }
		});
    }
    </c:if>
}