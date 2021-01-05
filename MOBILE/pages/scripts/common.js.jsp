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

function join() {
    var returnUrl = (document.location.href).split('#')[0];
    var kyoboJoinUrl = '<ui:variable key="kyobo.server"/>/member/join?partnerCode=HOT?turl=' + escape(returnUrl);
    
    // document.location.href = kyoboJoinUrl;
    winOpen(kyoboJoinUrl, '_join', '');
}

function goModifyMemInfo() {
    document.location.href="https://mobile.kyobobook.co.kr/member/modifyProfile";-
    
    // document.location.href = kyoboLoginUrl;
    winOpen(kyoboLoginUrl, '_join', '');
}

function logout(){
    document.location.href = '${defaultHost}/m/logout';
}

function needLogin() {
    if (confirm('로그인 사용자만 이용가능한 서비스입니다. 로그인 후 진행해주세요.')) {
        var returnUrl = (document.location.href).split('#')[0];
        var kyoboLoginUrl = '<ui:variable key="kyobo.server"/><ui:variable key="kyobo.login.uri"/>' + escape(returnUrl);
        document.location.href = kyoboLoginUrl;
            
        return true;
    } else {
        return false;
    }
}

function needLogin2(sellPrdtBcode) {
    if (confirm('로그인 사용자만 이용가능한 서비스입니다. 로그인 후 진행해주세요.')) {
        var returnUrl = 'http://m.hottracks.co.kr/m/mypage/orderDelivery?sellPrdtBcode='+sellPrdtBcode
        var kyoboLoginUrl = '<ui:variable key="kyobo.server"/><ui:variable key="kyobo.login.uri"/>' + escape(returnUrl);
        document.location.href = kyoboLoginUrl;
            
        return true;
    } else {
        return false;
    }
}

function needLoginForEmp(sellPrdtBcode) {
    if (confirm('로그인하셔야합니다. 로그인하시겠습니까?')) {
        var returnUrl = 'http://m.hottracks.co.kr/m/goToReview/'+sellPrdtBcode;
        var kyoboLoginUrl = '<ui:variable key="kyobo.server"/><ui:variable key="kyobo.login.uri"/>' + escape(returnUrl);
        document.location.href = kyoboLoginUrl;
            
        return true;
    } else {
        return false;
    }
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

function goTwitter(msg,url) {
    sendToSns('twitter', msg, url);
}

function goFaceBook(msg, url) {
    sendToSns('facebook', msg, url);
}

function goPinterest(msg,url) {
    sendToSns('pinterest', msg, url);
}

// send to SNS
function sendToSns(type, msg, url) {
    var snsArray = new Array();
    var strMsg = msg + " " + url;
    var image = $(".sns_img:first").attr("src");
    if(image == null)
        image="";
    snsArray['twitter']   = "https://twitter.com/intent/tweet?text=" + encodeURIComponent(msg) + ' ' + encodeURIComponent(url);
    snsArray['facebook']  = "http://www.facebook.com/share.php?u=" + encodeURIComponent(url) + '&t=' + encodeURIComponent(msg);
    snsArray['pinterest'] = "https://www.pinterest.com/pin/create/button/?url=" + encodeURIComponent(url) + "&media=" + image.replace("http://image", "https://simage") + "&description=" + encodeURIComponent(msg);
    snsArray['band']      = "http://band.us/plugin/share?body=" + encodeURIComponent(msg) + "  " + encodeURIComponent(url) + "&route=" + encodeURIComponent(url);
    snsArray['blog']      = "http://blog.naver.com/openapi/share?url=" + encodeURIComponent(url) + "&title=" + encodeURIComponent(msg);
    snsArray['line']      = "http://line.me/R/msg/text/?" + encodeURIComponent(msg) + " " + encodeURIComponent(url);
    snsArray['pholar']    = "http://www.pholar.co/spi/rephol?url=" + encodeURIComponent(url) + "&title=" + encodeURIComponent(msg);
    snsArray['google']    = "https://plus.google.com/share?url=" + encodeURIComponent(url) + "&t=" + encodeURIComponent(msg);
    winOpen(snsArray[type], '_'+type, '');
}

try{ Kakao.init("fcb0fcf1b62584364d5853ff4c6b56c7"); }catch (err){ }
function sendKakao(msg, url){
    var imgSrc = $(".kakao-img").attr("src");
    
    Kakao.Link.sendDefault({
      objectType: 'feed',
      content: {
        title: '핫트랙스',
        description: msg,
        imageUrl: imgSrc,
        link: {
           mobileWebUrl: url
         , webUrl: url
        }
      },
      buttons: [
        {
          title: '웹으로 보기',
          link: {
             mobileWebUrl: url
           , webUrl: url
          }
        }
      ]
    });
    
    setTimeout(function(){ $("#loading").hide(); }, 1000);
}

function urlClipCopy(url) {
    var textarea = $("#myClipboard");
    textarea.parent().show();
    
    var textToClipboard = url;
    var success = false;
    if ( window.clipboardData ){
        window.clipboardData.setData ( "Text", textToClipboard );
        success = true;
    } else {
        textarea.val(textToClipboard);
        var rangeToSelect = document.createRange();
        rangeToSelect.selectNodeContents( textarea.context );
        var selection = window.getSelection();
        selection.removeAllRanges();
        selection.addRange( rangeToSelect );
        
        success = true;
        
        try {
            if ( window.netscape && (netscape.security && netscape.security.PrivilegeManager) ){
                netscape.security.PrivilegeManager.enablePrivilege( "UniversalXPConnect" );
            }
            textarea.select();
            success = document.execCommand( "copy", false, null );
        } catch ( error ){
            success = false;
            alert( error );
        }
    }
    textarea.parent().hide();
    textarea.val("");
    
    if ( success ){ alert( '클립보드에 복사되었습니다.' ); }
    else {    alert( " 복사하지 못했습니다. " );    }
}

function sendSms(msg,url) {
    var userAgent = navigator.userAgent.toUpperCase();
    if(userAgent.match(/IPHONE/) || userAgent.match(/IPAD/)){
        window.open("sms:&body="+msg+" "+url, 'sms', '');
    }else{
        window.open("sms:?body="+msg+" "+url, 'sms', '');
    }
}

function goValidEscrow(mertid){
    var strMertid = mertid; 
    window.open("https://pgweb.dacom.net/pg/wmp/mertadmin/jsp/mertservice/s_escrowYn.jsp?mertid="+strMertid,"check","width=339, height=263, scrollbars=no, left = 200, top = 50");  
}

var sslHost = "${sslHost}";
function buyMusicGiftForDownload(prdtBcode, prdtCount){
    if(typeof prdtCount == "undefined" || prdtCount == 0) {
        prdtCount = 1;
    }
    
    // 바로 주문
    $.ajax({
        type: "POST"
        ,url: "/m/order/quickOrder"
        ,dataType: "json"
        ,data : {
            sellPrdtBcode : prdtBcode
            , prdtCount : prdtCount
        }
        ,success : function(data){
            if(data.save) {
                location.href= sslHost + "/m/order/musicOrderSheet";
            } else {
                var errorMessages = data.errorMessages;
                alert(errorMessages.join("\n"));
            }
        } 
        ,error: function(data) {
            alert('<fmt:message key="error.common.system"/>');
        }
    });
}

/* 쿠키 설정 */
function setCookie(name, value, expiredays){ 
    // setCookie("CookieName"+GOOD.NOTICEBBS_SEQ, "no" , 1);   // 부모창에서 지정한 쿠키네임과 일치 해야 합니다.
    var todayDate = new Date(); 
    todayDate.setDate( todayDate.getDate() + expiredays ); 
    document.cookie = name + "=" + escape(value) + "; path=/; expires=" + todayDate.toGMTString() + ";";
}

function setSessCookie(name, value){ 
    // setCookie("CookieName"+GOOD.NOTICEBBS_SEQ, "no");   // 부모창에서 지정한 쿠키네임과 일치 해야 합니다.
    document.cookie = name + "=" + escape(value) + "; path=/;";
}

function setSessCookieNew(name, value, date){ 
    // setCookie("CookieName"+GOOD.NOTICEBBS_SEQ, "no");   // 부모창에서 지정한 쿠키네임과 일치 해야 합니다.
    document.cookie = name + "=" + escape(value) +date+ "; path=/;";
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

/* 개별 상품 좋아요 추가 */
function addWishProduct(sellPrdtBcode, prdtName) {
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
                    //alert('['+ prdtName +'] 상품을 찜하셨습니다.');
                    showLikeComplete('A');
                    
                    $(".sns a:first-child").bind('click', function(){
                        removeWishProduct(sellPrdtBcode, prdtName)
                    });
                    var l = parseInt($(".like_cnt").val());
                    l = l+1;
                    $(".like_cnt").val(l);
                    
                    $(".sns a.like").attr('onclick','').unbind('click');
                    $(".sns a.like").attr('class','like_full');
                    $(".sns a.like_full").attr("onclick",'removeWishProduct(\''+sellPrdtBcode+'\',\''+prdtName+'\'); return false;');
                    
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

/* 상품 좋아요삭제*/
function removeWishProduct(sellPrdtBcode, prdtName) {
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
                    //alert('['+ prdtName +'] 상품을 찜목록에서 삭제하였습니다.');
                    showLikeComplete('D');
                    
                    $(".sns a.like_full").attr('onclick','').unbind('click');
                    $(".sns a.like_full").attr('class','like');
                    
                    var l = parseInt($(".like_cnt").val());
                    l = l-1;
                    $(".like_cnt").val(l);
                    
                    $(".sns a.like").attr("onclick",'addWishProduct(\''+sellPrdtBcode+'\',\''+prdtName+'\'); return false;');
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

/* 오늘 날짜 구하기 */
function returnToday(){
    var now = new Date();
    var year= now.getFullYear();
    var mon = (now.getMonth()+1) > 9 ? ''+(now.getMonth()+1) : '0'+(now.getMonth()+1);
    var day = now.getDate() > 9 ? ''+now.getDate() : '0'+now.getDate();
             
    var today = year + '' + mon + '' + day;
    return today;
}

/* 현재 시간 구하기 */
function returnNow(){
    var Now = new Date().getHours();
    var today = Now;
    return today;
}

/* 개별 브랜드 좋아요하기 */
function addWishBrand(brandId, brandName) {
    <c:if test='${!isLogin}'>
        needLogin();
    </c:if>
    <c:if test='${isLogin}'>
        $.ajax({
            type: 'GET'
            ,url: '/m/gift/addWishBrand'
            ,data: 'brandId=' + brandId
            ,dataType: 'json'
            ,success: function(data) {
                var size = data.errorMessages.length;
                if (size == 0) {
                    //alert('['+ brandName +'] 브랜드를 찜하셨습니다.');
                    showLikeComplete('B');
                    
                    $(".sns a.like").attr('onclick','').unbind('click');
                    $(".sns a.like").attr("onclick",'removeWishBrand(\''+brandId+'\',\''+brandName+'\'); return false;');
                    $(".sns a.like img").attr('src','/images/content/ico_like.png');
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

/* 좋아요 브랜드 지우기 */
function removeWishBrand(brandId, brandName) {
    <c:if test='${!isLogin}'>
        needLogin();
    </c:if>
    <c:if test='${isLogin}'>
        $.ajax({
            type: 'GET'
            ,url: '/m/gift/removeWishBrand'
            ,data: 'brandId=' + brandId
            ,dataType: 'json'
            ,success: function(data) {
                var size = data.errorMessages.length;
                
                if (size == 0) {
                    //alert('['+ brandName +'] 브랜드좋아요를 삭제하셨습니다.');
                    showLikeComplete('E');
                    
                    $(".sns a.like").attr('onclick','').unbind('click');
                    $(".sns a.like").attr("onclick",'addWishBrand(\''+brandId+'\',\''+brandName+'\'); return false;');
                    $(".sns a.like img").attr('src','/images/content/btn_like_off.png');

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

/* 좋아요 브랜드 지우기 */
function removeWishBrand2(brandId, brandName) {
    <c:if test='${!isLogin}'>
        needLogin();
    </c:if>
    <c:if test='${isLogin}'>
        $.ajax({
            type: 'GET'
            ,url: '/m/gift/removeWishBrand'
            ,data: 'brandId=' + brandId
            ,dataType: 'json'
            ,success: function(data) {
                var size = data.errorMessages.length;
                
                if (size == 0) {
                    //alert('['+ brandName +'] 브랜드좋아요를 삭제하셨습니다.');
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

//체험단이면서 체험 상품인 경우
function addReviewTest(barcode, rcrdCd){
    <c:if test='${!isLogin}'>
        needLoginForEmp(barcode);
    </c:if>
    <c:if test='${isLogin}'>
        if(rcrdCd == null ||rcrdCd == ""){
            var now = returnToday();
            var empStart = (now - '20171208'  >= 0) && ('20171218' - now >= 0);
            if(empStart){
                   $.ajax({
                    type: 'GET'
                    ,url: '/m/gift/getHistoryOfBarcode'
                    ,data: {barcode : barcode, rcrdCd : rcrdCd }
                    ,dataType: 'json'
                    ,async: false
                    ,success: function(data) {
                        if(data.result== null || data.result.stInt1 == 0){
                            location.href='/m/gift/detail/reviewForm?sellPrdtBcode='+barcode+'&rtnGbn=P';
                            return false;
                        }else if(data.result.stVar1 != 'C0124'){
                            location.href='/m/gift/detail/reviewForm?sellPrdtBcode='+barcode+'&rtnGbn=P';
                            return false;
                        }else{
                            <c:if test='${isLogin}'>
                                location.href='/m/mypage/orderDelivery?sellPrdtBcode='+barcode;
                            </c:if>
                        }
                    }
                ,error: function(data) {
                    alert('<fmt:message key="error.common.system"/>');
                }
                });
            }else{
                    $.ajax({
                        type: 'GET'
                        ,url: '/m/gift/getHistoryOfBarcode'
                        ,data: {barcode : barcode, rcrdCd : rcrdCd }
                        ,dataType: 'json'
                        ,async: false
                        ,success: function(data) {
                            if(data.result== null || data.result.stInt1 == 0){
                                alert("구매하지 않은 상품이거나 구매 후 3개월이 지난 상품입니다. 상품을 구매하신 뒤 다시 상품평을 작성해주세요.");
                                return false;
                            }else if(data.result.stVar1 != 'C0124'){
                                alert(data.result.stVar2+" 상품은 배송완료 상태인 경우에 상품평을 작성 하실 수 있습니다.");
                                return false;
                            }else{
                                <c:if test='${isLogin}'>
                                    location.href='/m/mypage/orderDelivery?sellPrdtBcode='+barcode;
                                </c:if>
                            }
                        }
                    ,error: function(data) {
                        alert('<fmt:message key="error.common.system"/>');
                    }
                });
            }
        }else{
        //읍반 후기
        <c:if test='${isLogin}'>
            location.href='/m/gift/detail/reviewForm?sellPrdtBcode='+barcode+'&rtnGbn=P';
        </c:if>
        }
    </c:if>
}

function addReview(barcode, rcrdCd){
    <c:if test='${!isLogin}'>
        needLoginForEmp(barcode);
    </c:if>
    <c:if test='${isLogin}'>
        if(rcrdCd == null ||rcrdCd == ""){
                $.ajax({
                    type: 'GET'
                    ,url: '/m/gift/getHistoryOfBarcode'
                    ,data: {barcode : barcode, rcrdCd : rcrdCd }
                    ,dataType: 'json'
                    ,async: false
                    ,success: function(data) {
                        if(data.result== null || data.result.stInt1 == 0){
                            alert("구매하지 않은 상품이거나 구매 후 3개월이 지난 상품입니다. 상품을 구매하신 뒤 다시 상품평을 작성해주세요.");
                            return false;
                        }else if(data.result.stVar1 == 'C0123' && data.result.stVar3 == 'Y'){
                            if(confirm("수취확인후에 상품평을 작성 하실 수 있습니다.\n수취확인 하러 가시겠습니까?")) {
                            	location.href='/m/mypage/orderDelivery?sellPrdtBcode='+barcode;
                            } else {
                                return false;
                            }
                        }else if(data.result.stVar1 != 'C0124'){
                            alert(data.result.stVar2+" 상품은 배송완료 상태인 경우에 상품평을 작성 하실 수 있습니다.");
                            return false;
                        }else{
                            <c:if test='${isLogin}'>
                                location.href='/m/mypage/orderDelivery?sellPrdtBcode='+barcode;
                            </c:if>
                        }
                    }
                ,error: function(data) {
                    alert('<fmt:message key="error.common.system"/>');
                }
            });
        }else{
        //읍반 후기
        <c:if test='${isLogin}'>
            location.href='/m/gift/detail/reviewForm?sellPrdtBcode='+barcode+'&rtnGbn=P';
        </c:if>
        }
    </c:if>
}

function addQna(sellPrdtBcode, rcrdCd){
    <c:if test='${!isLogin}'>
        needLogin();
    </c:if>
    <c:if test='${isLogin}'>
        location.href='/m/gift/detail/qnaForm?sellPrdtBcode='+sellPrdtBcode+'&rcrdCd='+rcrdCd;
    </c:if>
}

function addQnaGroup(sellPrdtBcode, rcrdCd, groupNum){
    <c:if test='${!isLogin}'>
        needLogin();
    </c:if>
    <c:if test='${isLogin}'>
        location.href='/m/gift/detail/qnaForm?qnaGubun=G&brandName='+groupNum+'&sellPrdtBcode='+sellPrdtBcode+'&rcrdCd='+rcrdCd;
    </c:if>
}

function toggleLayer(id){
    if($(id).is(":hidden")){
        $(id).fadeIn('fast');
    }else{
        $(id).fadeOut('fast');
    }
}

function toggleSlide(id){
    if($(id).is(":hidden")){
        $(id).slideDown('fast');
    }else{
        $(id).slideUp('fast');
    }
}

function toggleLayerFull(id){
    if($(id).is(":hidden")){
        $(id).fadeIn('fast', function(){
            $("#header").slideUp();
            $("#wrap").css("position", "fixed");
            $(this).css("overflow", "auto");
        });
    }else{
        $(id).fadeOut('fast', function(){
            $("#header").slideDown();
            $("#wrap").css("position", "initial");
            $(this).css("overflow", "hidden");
        });
    }
}

function initTopNavigation() {
    $.ajax({
        type: 'GET'
        ,url: '/m/order/ajaxGetCartCount'
        ,dataType: 'json'
        ,success: function(data) {
            $('#cartCnt').html(data.cartCount);
        }
        ,error: function(data) {
            // ignore
        }
    });
}

// 음반의 큰 이미지가 없는 경우 작은 이미지로 대체 처리하는 함수. ImageTag에서 적용함.
function checkRecordImage(img, path){
    $(img).data("errorCnt", $(img).data("errorCnt") + 1 || 1); 

    if($(img).data("errorCnt") <= 1){
        img.src = path;
        
        if($(img).hasClass("recordDetailPhoto") && $(img).css("width") == "400px"){
            $(img).css("width", "200px");
            $(img).css("height", "200px");
            $(img).css("padding-top", "100px");
            $(img).css("padding-left", "100px");
        }
        
        if($(img).hasClass("recordDetailPhoto") && $(img).css("width") == "264px"){
            $(img).css("width", "148px");
            $(img).css("height", "224px");
            $(img).css("padding-top", "66px");
            $(img).css("padding-left", "55px");
        }
    }else{
        img.src = "http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/no_image2.gif";
    }
}

function coupondown(couponId) {
    $.ajax({
        type: "POST"
        ,url:"/m/coupon/productCouponDown"
        ,dataType: 'json'
        ,data : {couponId : couponId}
        ,success: function(data) {
            if (data.save) {
                alert("쿠폰이 다운로드 되었습니다.");
            } else {
                alert(data.errorMessage);
            }
        }
        ,error: function() {
            alert('시스템오류가 발생하였습니다. 고객센터에 문의해주시기 바랍니다.');
        }
    });
}

/* 회원로그인체크 */
function memloginYn () {
    <c:if test='${!isLogin}'>
        return false;
    </c:if>
    <c:if test='${isLogin}'>
        return true;
    </c:if>
}

function showPcVer(){ 
    location.href = "http://www.hottracks.co.kr/ht/welcomeMain?httsPcVer=Y";
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

function scanCallBack(barcode){
    $("[name=searchTerm]").val(barcode);
    gnbSrchFrm();
}

function voiceCallBack(term){
    $("[name=searchTerm]").val(term);
    gnbSrchFrm();
}

function linkToDevice(agree){
    if(agree == 'Y'){
        var userAgent = navigator.userAgent.toUpperCase();
        var link = encodeURI(location.href);
        if(userAgent.match(/IPHONE/) || userAgent.match(/IPAD/)){
            location.href = 'https://itunes.apple.com/kr/app/hottracks/id1129743143?mt=8';
        }else{
            location.href = 'intent://hottracksand?uri='+link+'#Intent;scheme=hotand;action=android.intent.action.VIEW;category=android.intent.category.BROWSABLE;package=kr.co.hottracks.m.and;end';
        }
    }
    $(".lyDeviceAlert").remove();
    setTimeout(function(){ $("#loading").hide(); }, 1000);
    
    setSessCookie("LayerAltApp", "Y" , 1);
}

function addGiftStockedInfoRequest(goodId){
    if (${isLogin}){
        $(".giftStockedInfoRequest").load("/m/mypage/giftStockedInfoRequestForm?goodId=" + goodId);
        $(".giftStockedInfoRequest").show();
        
        $("#wrap").css("position", "fixed");
    } else {
        needLogin();
    }
}

function closeGiftStockedInfoRequest(){
    $(".giftStockedInfoRequest").empty;
    $(".giftStockedInfoRequest").hide();
    
    $("#wrap").css("position", "initial");
}

function openrecordStockedInfoRequestEnd(){
    $(".giftStockedInfoRequest").load("/m/mypage/recordStockedInfoRequestEnd");
    $(".giftStockedInfoRequest").show();
    
    $("#wrap").css("position", "initial");
}

function fn_CheckLength(object){
    if (object.value.length > object.maxLength){
        object.value = object.value.slice(0, object.maxLength);
    }
}

function fn_Alert(msg){
    var htmlStr = '<div id="lyAlert" style="position: fixed;left:0;top:0;width:100%;height:100%;z-index:999;background:url(/images/mplus/bg_layer01.png);">';
    htmlStr += '    <div style="position: absolute;left: 50%;top: 150px;width: 300px;margin-left: -160px;text-align: left;background-color: #fff;border-radius: 5px;overflow:hidden;text-align:center;padding:10px;">';
    htmlStr += '        <div style="margin:10px auto;max-height:250px;overflow:auto;">'+msg+'</div>';
    htmlStr += '        <a href="#" onclick="fn_AlertClose();return false;" style="display:block;padding:10px;font-size:15px;background-color:#ff6600;color:#fff;font-weight:bold;border-radius:5px;margin-bottom:10px;">창 닫기</a>';
    htmlStr += '    </div>';
    htmlStr += '</div>';

    $(body).append(htmlStr);
    $("#contents").css("position", "fixed");
}

function fn_AlertClose(){
    $(document).find("#lyAlert").remove();
    $("#contents").css("position", "relative");
}

// MOVE TO TOP
function moveTop(){
    moveScroll(0);
}

// MOVE TO BOTTOM
function moveBottom(){
    moveScroll($(document).height());
}
function openSide(){
 $('body').addClass('fixed').on('touchmove', function(e){e.preventDefault();return false;});
    $('#header').append('<div class="dim"></div>');
    TweenLite.to($('#header .dim'),0.7,{ease:Power4.easeOut,opacity:0.8})
    TweenLite.to($('#sidemenu_wrapper'),0.7,{ease:Power4.easeOut,left:0,onComplete:function(){
      
	}});
	$("#btnBack,#btnTop,#btnDown,#btnSidem").fadeOut("slow");
}
function moveScroll(scroll){
    $("html, body").stop(true,true).animate({
        "scrollTop":scroll
    },500);
}

function moreGnbCheck(){
    $("#topMenu").find(".btn_more.left").css("left", $("#topMenu").scrollLeft());
    var gap = $("#topMenu .gnb-box").width() - $("#topMenu").width();
    if(gap > 0){
        if($("#topMenu").scrollLeft() > 0){
            $("#topMenu .btn_more.left").show();
        }else{
            $("#topMenu .btn_more.right").show();
        }
    }
}

function moreGnbMenu(direct){
    var gap = $("#topMenu .gnb-box").width() - $("#topMenu").width();
    $("#topMenu").find(".btn_more").hide();
    if(direct == "L")    $("#topMenu").animate({scrollLeft:0}, 500);
    else                 $("#topMenu").animate({scrollLeft:gap}, 500);
}


function showLoading(){
    $("#loading").show();
}

function hideLoading(){
    $("#loading").hide();
}

function lpad(n, padLength, padString){
  n = n + '';
  return n.length >= padLength ? n : new Array(padLength - n.length + 1).join(padString) + n;
}

// 텍스트 애니메이션 이벤트
function aniText(targetName, baseSize, activeSize){
    var length = $(targetName).length;
    var cnt = 0;
    
    $(targetName).eq(cnt).css("font-size", activeSize).css("color","#444");
    var txt01 = setInterval(function (){
        $(targetName).eq(cnt).css("font-size", baseSize).css("color","#9e9e9e");
        if(cnt + 2 > length) cnt = 0;
        else                 cnt++;
        $(targetName).eq(cnt).css("font-size", activeSize).css("color","#444");
    }, 3000);
}

// 슬라이드의 랜덤 페이지 호출
function randomSlide(divElmt){
    var length = $(divElmt).find(".swiper-slide:not(.swiper-slide-duplicate)").length;
    var now = new Date();
    var idx = Math.floor(now.getSeconds()%length);
    return parseInt(idx);
}

// 최근본 상품 등록
function saveRecentProduct(sellPrdtBcode){
    $.ajax({
        type: "POST"
        ,url: "/m/checkRecentProduct"
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

function Fn_rcntItemLike(){
    if($("#ly_recent").find(".prod_basic05 a.active").length > 0){
        if(!${isLogin}){
            needLogin();
        }else{
            var arr = new Array();
            $("#ly_recent").find(".prod_basic05 a.active").each(function(){
                arr.push($(this).find("[name=sellPrdtBcode]").val());
            });
            $.ajax({
                type: 'POST'
                ,url: '/m/gift/addWishProductBatch'
                ,data: {sellPrdtBcode:arr.join(",")}
                ,dataType: 'json'
                ,success: function(data) {
                    if($.trim(data.errorMessages) != ""){
                        alert(data.errorMessages);
                    }else{
                        // alert("좋아요 등록되었습니다.");
                        showLikeComplete('A');
                        setTimeout(function(){ Fn_rcntChangMode("N"); }, 1000);
                    }
                }
                ,error: function(data) {
                    alert('<fmt:message key="error.common.system"/>');
                }
            });
        }
    }else{
        alert("선택하신 상품이 없습니다. '♥좋아요'하실 상품을 클릭해주세요.");
    }
}

function Fn_rcntItemDel(sellPrdtBcode){
    if($("#ly_recent").find(".prod_basic05 a.active").length > 0){
        if(confirm("해당 최근 본 상품을 삭제하시겠습니까?")){
            var arr = new Array();
            $("#ly_recent").find(".prod_basic05 a.active").each(function(){
                arr.push($(this).find("[name=sellPrdtBcode]").val());
            });
            $.ajax({
                type: 'POST'
                ,url: '/m/removeRecentProduct'
                ,data: {sellPrdtBcode:arr.join(",")}
                ,async: false
                ,dataType: 'json'
                ,success: function(data) {
                    $("#ly_recent").load("/m/hot/recent");
                }
                ,error: function(data) {
                    alert('<fmt:message key="error.common.system"/>');
                }
            });
        }
    }else{
        alert("선택하신 상품이 없습니다. 최근 본 상품에서 삭제하실 상품을 클릭해주세요.");
    }
}

function Fn_closeLayer(_id, _doNotShowYn, date){
    $(_id).hide();
    if(_id == "#eventPopSlide"){
	    $("body").removeClass("noscroll");
    }
    if(_doNotShowYn == "Y"){
        setSessCookieNew(_id.substring(1), "Y" , date);
        $.ajax({
               type: 'POST'
               ,url: '/m/removeTodayBnr'
               ,data: {bnrSeq:_id.substring(1)}
               ,async: false
               ,dataType: 'json'
               ,error: function(data) {
                   alert('<fmt:message key="error.common.system"/>');
               }
           });
    }
}

function Fn_closeLayerTopBnr(_id, _doNotShowYn, date){
    $(_id).hide();
    if(_doNotShowYn == "Y"){
        setSessCookieNew(_id.substring(1), "Y" , date);
        $("#header").removeClass("bnr_top");
        $("#content").removeAttr("style");
    }
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
            ,url: '/m/biz/gift/removeWishProduct'
            ,data: 'sellPrdtBcode=' + sellPrdtBcode
            ,dataType: 'json'
            ,async: false
            ,success: function(data) {
                var size = data.errorMessages.length;
                if (size == 0) {                    
                    // showLikeComplete('D');                                                            
                    $("a[prdtId="+sellPrdtBcode+"]").removeClass('active');  
                    
                    if($(".like[code="+ sellPrdtBcode +"]").length > 0){
                    	$(".like[code="+ sellPrdtBcode +"]").text(data.wishCnt > 999 ? "999+" : data.wishCnt);
                    }
                } else {
                    alert(data.errorMessages);
                }
            }
            ,error: function(data) {
                alert('<fmt:message key="error.common.system"/>');
            }
        });    
    }else{	// 좋아요 추가
 		$.ajax({
		    type: 'GET'
		    ,url: '/m/biz/gift/addWishProduct'
		    ,data: 'sellPrdtBcode=' + sellPrdtBcode
		    ,dataType: 'json'
		    ,async: false
		    ,success: function(data) {
		        var size = data.errorMessages.length;
		        if (size == 0) {                    		            
		            // showLikeComplete('A');		        
		            $("a[prdtId="+sellPrdtBcode+"]").addClass('active');
		            
		            if($(".like[code="+ sellPrdtBcode +"]").length > 0){
		            	$(".like[code="+ sellPrdtBcode +"]").text(data.wishCnt > 999 ? "999+" : data.wishCnt);	
		            }            		            		                               
		        } else {                	
		            alert('<fmt:message key="error.common.system"/>');
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

/* 개별 브랜드 좋아요 추가 및 삭제 */
function addBizWishBrand(brandId) {
    <c:if test='${!isLogin}'>
        needLogin();
    </c:if>
    <c:if test='${isLogin}'>
	    var $prdObj = $("."+brandId);
	    if($prdObj.hasClass('on')){	// 좋아요 삭제    
	        $.ajax({
	            type: 'GET'
	            ,url: '/m/biz/gift/removeWishBrand'
	            ,data: 'brandId=' + brandId
	            ,dataType: 'json'
	            ,success: function(data) {
	                var size = data.errorMessages.length;
	                
	                if (size == 0) {
	                    // showLikeComplete('E');
	                    $prdObj.removeClass('on');
	                    
						if($(".brandTxt[code="+ brandId +"]").length > 0){
	                    	$(".brandTxt[code="+ brandId +"]").text(data.wishCnt > 999 ? "999+" : data.wishCnt);
	                    }
	
	                } else {
	                    alert(data.errorMessages);
	                }
	            }
	            ,error: function(data) {
	                alert('<fmt:message key="error.common.system"/>');
	            }
	        });
	     }else{
	     	$.ajax({
	            type: 'GET'
	            ,url: '/m/biz/gift/addWishBrand'
	            ,data: 'brandId=' + brandId
	            ,dataType: 'json'
	            ,success: function(data) {
	                var size = data.errorMessages.length;
	                if (size == 0) {
	                    // showLikeComplete('B');
	                    $prdObj.addClass('on');
	                   
						if($(".brandTxt[code="+ brandId +"]").length > 0){
	                    	$(".brandTxt[code="+ brandId +"]").text(data.wishCnt > 999 ? "999+" : data.wishCnt);
	                    }
	                } else {
	                    alert(data.errorMessages);
	                }
	            }
	            ,error: function(data) {
	                alert('<fmt:message key="error.common.system"/>');
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
            ,url: '/m/biz/gift/deleteWishLife'
            ,data: 'sellPrdtBcode=' + svcSeq
            ,dataType: 'json'
            ,async: false
            ,success: function(data) {            
            	var size = data.errorMessages.length;            	
                if (size == 0) {                                                                                                       
                    $("a[svcSeq="+svcSeq+"]").prev('span').removeClass('on');                    
                    var d = new Date();
                    var url = "/images/biz/sub/heart_off.gif?a="+d.getTime();
                    $("a[svcSeq="+svcSeq+"]").prev('span').css({"background":""});
                    $("a[svcSeq="+svcSeq+"]").prev('span').css({background:"url("+url+") 50% 0% no-repeat",backgroundSize: 32});
                    if($(".heart[code="+ svcSeq +"]").length > 0){  
                    	$(".heart[code="+ svcSeq +"]").text(data.wishCnt > 999 ? "999+" : data.wishCnt);
                    }
                } else {
                    alert(data.errorMessages);
                }
            }
            ,error: function(data) {
                alert('<fmt:message key="error.common.system"/>');
            }
        });    
    }else{	// 좋아요 추가
 		$.ajax({
		    type: 'GET'
		    ,url: '/m/biz/gift/addWishLife'
		    ,data: 'sellPrdtBcode=' + svcSeq
		    ,dataType: 'json'
		    ,async: false
		    ,success: function(data) {
		        var size = data.errorMessages.length;
		        if (size == 0) {
		        	$(".heart[code="+ svcSeq +"]").addClass('on');   
		            var d = new Date();
		            var url = "/images/biz/sub/heart_on.gif?a="+d.getTime();
		            $("a[svcSeq="+svcSeq+"]").prev('span').css({"background":""});
		            $("a[svcSeq="+svcSeq+"]").prev('span').css({background:"url("+url+") 50% 0% no-repeat",backgroundSize: 32});
		            
		            if($(".heart[code="+ svcSeq +"]").length > 0){ 		   
		            	$(".heart[code="+ svcSeq +"]").text(data.wishCnt > 999 ? "999+" : data.wishCnt);  
		            }       		            		                               
		        } else {                	
		            alert('<fmt:message key="error.common.system"/>');
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