<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<html>
<head>
<title>${detail.eventTitle} - NEW ME HOTTRACKS</title>
<meta property="fb:app_id" content="981386905311018" />
<!--  SNS 공유 내용 -->
<meta property="og:type" content="website"/>
<meta property="og:title" content="${fn:escapeXml(detail.eventTitle)}"/>
<meta property="og:url" content="${defaultHost}/ht/biz/eventDetail?eventId=${detail.eventId}"/>
<c:choose>
    <c:when test="${not empty detail.eventRangeInfo}"><meta property="og:description" content="${detail.eventRangeInfo}"/></c:when>
    <c:otherwise><meta property="og:description" content="<ui:mask pattern="####.##.##">${detail.eventStartDt}</ui:mask> ~ <ui:mask pattern="####.##.##">${detail.eventEndDt}</ui:mask>"/></c:otherwise>
</c:choose>
<meta property="og:image" content="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${detail.thumUrl}" />
<link rel="image_src" href="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${detail.thumUrl}" />
<!--  SNS 공유 내용 -->
<style type="text/css">
.tit_bucket { margin:60px 0 50px;text-align:center; }
.tit_bucket p { margin-top:20px; }
.bucket_cont { max-width:950px;margin-bottom:50px; }
#imageMid {height : 530px;position: relative; margin-top : -530px; z-index : -1;}
.bg_mt {background-position-y: 205px !important;}
</style>
<script type="text/javascript" src="/js/jquery.form.js"></script>
<script type="text/javascript" src="/js/jquery.bpopup.min.js"></script>

<!--  레코벨 스크립트 -->
<script type="text/javascript">
  var _recoUserId = getCookie('UserCookieKey');
  window._eglqueue = window._eglqueue || [];
  _eglqueue.push(['setVar','cuid','e15e978e-3623-4892-bf0a-485b9f8196ee']);
  _eglqueue.push(['setVar','planId','${detail.eventId}']);
  _eglqueue.push(['setVar','userId',SHA256(_recoUserId)]);  // optional
  _eglqueue.push(['track','view']); 
  setTimeout(function() {
    (function(s,x){s=document.createElement('script');s.type='text/x-x-javascript';
    s.async=true;s.defer=true;s.src=(('https:'==document.location.protocol)?'https':'http')+
    '://logger.eigene.io/js/logger.min.js';
    x=document.getElementsByTagName('script')[0];x.parentNode.insertBefore(s, x);})();
  }, 0);
</script>
<!--  레코벨 스크립트 끝-->

<script type="text/javascript">
//레이어 팝업 
function go_popup(img) { 
    popimg.src = img; 
    $("#popup").bPopup({
    	follow: [true, false],
        position: ['auto', 'auto'] //x, y
    });
}

//핫트 프라이데이 이벤트 포인트지급 참여 때문에 일회용으로 만듦(단계별이벤트형식으로 지급) - 스텝순서무시
var date = new Date(); 
var day = date.getDate(); 
var st = 1; 
//20일(1step), 21일(2step), 22일(3step)
switch(day) {
	case 21:
		st = 2;	
		break;
	case 22:
		st = 3;
		break;
}

function ht_dailyCheck(){ 
	if (!isLogin) {
        needLogin();
    }else{
        $.ajax({
            type: 'POST'
            ,url: '/ht/event/saveEventAttendStep'
            ,data: {eventId:"${detail.eventId}", step : st}
            ,dataType: 'json'
            ,async: false
            ,success: function(data) {
                alert(data.alert);
                if (data.save) {
                    location.reload(true);
                }
            }
            ,error: function(data) {
                alert('이벤트 진행 중 오류가 발생하였습니다. 잠시 후 다시 이용해주세요');
            }
        });
    }
}
/* 핫트 프라이데이 응모하기 이벤트 (1회용)*/
function ht_entryEvent(){
    if (preValidation()) {
        $.ajax({
            type: "GET"
            ,url: "/ht/hot/entryEvent"
            ,data: "eventId=65101"
            ,dataType: 'json'
            ,success: function(data) {
                if (data.result.save) {
                    alert(data.result.resultMsg);
                } else {
                    alert(data.result.errMsg);
                }
            }
            ,error: function(data) {
                alert('<fmt:message key="error.common.system"/>');
            }
        });
    }
}

/* 핫트 프라이데이 응모하기 이벤트 (1회용)*/
function ht_entryEvent(){
	alert('공유하기 이벤트는 모바일에서만 응모 가능합니다.');
}
function ht_shareEvent(){
	alert('공유하기 이벤트는 모바일에서만 응모 가능합니다.');
}

</script>
<style type="text/css"> 
    .Pstyle{ 
        opacity:0; 
        display:none; 
        position:relative; 
        width:820px;
        border:5px solid#fff; 
        padding:20px; 
        background-color:#fff; 

    } 
    .b-close{ 
        position:absolute; 
        right:0px; 
        top:0px; 
        padding:5px; 
        display:inline-block; 
        cursor:pointer;
        font-weight: bold; 
        font-size: 10;
    } 
</style>

<script type="text/javascript">
isLogin = ${isLogin};
isEntryTerm = ${entryTermYn};
<c:if test="${detail.eventTypeCode eq 'C0192' || detail.eventTypeCode eq 'C0193' || detail.eventTypeCode eq 'C0197'}">
orderBy = 'regDtmDesc';
</c:if>
<c:if test="${detail.eventTypeCode eq 'C019A'}">
orderBy = 'likeCntDesc';
</c:if>

jQuery(function($){
    $(document).ready(function(){
        $(".c_select ul li").each(function(){
            var clsName = $(this).find("a").attr("href");
            if($(".e_select li"+clsName).length < 1){
                $(this).hide();
            }
        });
        
        var cateId = "${detail.ctgrId}";
        var cultZoneYn = "${detail.cultZoneYn}";
        
        if(cateId.substring(0, 4) == "0003"){
            $(".c_select li.item0003").find("a").click();
        }else if(cateId.substring(0, 4) == "0004"){
            $(".c_select li.item0004").find("a").click();
        }else if(cateId.length >= 6){
            $(".c_select li.item"+cateId.substring(0, 6)).find("a").click();
        }
        
        if('${skip}' == 'skipEvent'){
            $(".ly_box_skip").addClass("active");
            $("div.comment_box textarea[name=eventComment]").attr("disabled","disabled");
        }
        
        if(cateId == "000020" && cultZoneYn == "D"){
        	$("#container").addClass("bg_mt");
        }
    });
    $(".c_select ul li a").click(function(e){
        e.preventDefault();
        clsName = $(this).attr("href");
        $(".c_select .c_txt").html($(this).text());
        if(clsName == ""){
            $(".e_select li").show();
        }else{
            $(".e_select li").hide();
            $(".e_select li:first").show();
            $(".e_select li"+clsName).show();
        }
        $(".e_select_btn").hide();
        $(".e_select .e_txt").html($(".e_select li:first").html());
    });
    
    $(".e_select ul li").click(function(e){
        e.preventDefault();
        clsName = $(this).attr("href");
        $(".e_select .e_txt").html($(this).html());
        $(".e_select_btn").fadeIn();
    });
    
    $("area").attr("onfocus","this.blur();");
    
    
    // 포춘쿠키 이벤트 레이어 팝업 처리 램덤 -- 2020.01.08 Start
    $("#popOpenBtn").click(function(event){  //팝업 Open 버튼 클릭 시
    	
        if(isLogin){
            $.ajax({
                type: "GET"
                ,url: "/ht/getEventRequest"
                ,data: 'eventNum=2020012401'
                ,dataType: "json"
                ,success: function(data) {
                	alert(data.save);
                	alert(data.msg);
                    if (data.save) {
                    	
                        $("#popupDiv").removeClass();
                        
                        if (data.msg == "2020")        {$("#popupDiv").addClass("p2020 popCloseBtn");}
                        else if (data.msg == "100")  {$("#popupDiv").addClass("p100 popCloseBtn");}
                        else {alert("선착순 마감되었습니다. ㅠ.ㅠ");return;}
                        
                        $("#popupDiv").css({
                            "top": (($(window).height()-$("#popupDiv").outerHeight())/2+$(window).scrollTop())+"px",
                            //"left": (($(window).width()-$("#popupDiv").outerWidth())/2+$(window).scrollLeft())+"px"
                            //팝업창을 가운데로 띄우기 위해 현재 화면의 가운데 값과 스크롤 값을 계산하여 팝업창 CSS 설정

                        });

                        $("#popup_mask").css("display","block"); //팝업 뒷배경 display block
                        $("#popupDiv").css("display","block"); //팝업창 display block

                        $("body").css("overflow","hidden");//body 스크롤바 없애기
                    } else {
                        alert(data.msg);
                    }
                }
                ,error: function() {
                    alert('<fmt:message key="error.common.system"/>');
                }
            });
        	
        }else{
            needLogin();
        }
    });

    $(".popCloseBtn").click(function(event){
        $("#popup_mask").css("display","none"); //팝업창 뒷배경 display none
        $("#popupDiv").css("display","none"); //팝업창 display none
        $("body").css("overflow","auto");//body 스크롤바 생성
    });
    // // 포춘쿠키 이벤트 레이어 팝업 처리 램덤 -- 2020.01.08 End
});

function preValidation() {
    if (!isLogin) {
        needLogin();
        return false;
    } else if (!isEntryTerm) {
        alert("해당기간이 아닙니다.");
        $("div.comment_box textarea[name=eventComment]").attr("disabled","disabled");
        $("div.comment_box textarea[name=eventComment]").val();
        return false;
    }

    return true;
}

function save(){
    if (preValidation()) {
        $('form[name="eventCommentForm"]').ajaxSubmit({
            url: '/ht/hot/saveEventComment'
            ,dataType: 'json'
            ,success: function(data) {
                if (data.save) {
                    alert('<fmt:message key="message.save.success"/>'); 
                    $('div#commentArea').load('/ht/hot/comment/${detail.eventTypeCode}?eventId=${detail.eventId}&orderBy='+orderBy);
                } else {
                    alert(data.errorMessages);
                }
            }
            ,error: function(data) {
                alert('<fmt:message key="error.common.system"/>');
            }
        });
    }
    return false;
}

/* 참여이벤트 */
function entryEvent(){
    if (preValidation()) {
        $.ajax({
            type: "GET"
            ,url: "/ht/hot/entryEvent"
            ,data: "eventId=${detail.eventId}"
            ,dataType: 'json'
            ,success: function(data) {
                if (data.result.save) {
                    alert(data.result.resultMsg);
                } else {
                    alert(data.result.errMsg);
                }
            }
            ,error: function(data) {
                alert('<fmt:message key="error.common.system"/>');
            }
        });
    }
}

/* 참여이벤트 -주문금액 */
function entryEventAmt(){
    if (preValidation()) {
        $.ajax({
            type: "GET"
            ,url: "/ht/hot/entryEventAmt"
            ,data: "eventId=${detail.eventId}"
            ,dataType: 'json'
            ,success: function(data) {
                if (data.result.save) {
                    alert(data.result.resultMsg);
                } else {
                    alert(data.result.errMsg);
                }
            }
            ,error: function(data) {
                alert('<fmt:message key="error.common.system"/>');
            }
        });
    }
}



function deleteComment(sequence) {
    if (preValidation()) {
        if (confirm('삭제하시겠습니까?')) {
            $.ajax({
                type: 'GET'
                ,url: '/ht/hot/deleteEventComment'
                ,data: 'eventId=${detail.eventId}&sequence=' + sequence
                ,dataType: 'json'
                ,success: function(data) {
                    if (data.save) {
                        alert('<fmt:message key="message.delete.success"/>');
                        $('div#commentArea').load('/ht/hot/comment/${detail.eventTypeCode}?eventId=${detail.eventId}&orderBy='+orderBy+'&temp='+ Math.random());
                    } else {
                        alert(data.errorMessages);
                    }
                }
                ,error: function(data) {
                    alert('<fmt:message key="error.common.system"/>');
                }
            });
        }
    }
}

function couponDown(couponId) {
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

function eventRequest(eventNum) {
    if (!isLogin) {
        needLogin();
    } else {
        $.ajax({
            type: "GET"
            ,url: "/ht/getEventRequest"
            ,data: 'eventNum=' + eventNum
            ,dataType: "json"
            ,success: function(data) {
                if (data.save) {
                    alert(data.msg);
                } else {
                    alert(data.msg);
                }
            }
            ,error: function() {
                alert('<fmt:message key="error.common.system"/>');
            }
        });
    }
}




function goCommentList(page) {
    $('div#commentArea').load('/ht/hot/comment/${detail.eventTypeCode}?eventId=${detail.eventId}&orderBy='+orderBy+'&page=' + page);
}

function goEventList(page) {
    if(page == null || page == undefined)    page = 1;
    location.href="/ht/biz/eventDetail?eventId=${detail.eventId}&page=" +page + "#bucketEventList";
}

function checkEmtcId(obj, imgSrc){
    $(".comment_emtc a.on").removeClass("on");
    obj.setAttribute("class", "on");
    $("input[name=emtcId]").val(imgSrc);
}

function toggleChildComment(seq){
    if($("#btnChildCmnt"+seq).hasClass("active")){
        $('#childComment'+seq).empty();
        $("#btnChildCmnt"+seq).removeClass("active");
    }else{
        loadChildComment('1', '&eventId=${detail.eventId}&parntCmntSeq='+seq);
        $("#btnChildCmnt"+seq).addClass("active");
    }
}

function loadChildComment(page, param){
    params = param.split("&");
    var seq = '';
    for(var i = 0; i<params.length; i++){
        if(params[i].indexOf("parntCmntSeq=") == 0){
            seq = params[i].replace("parntCmntSeq=", "");
        }
    }
    $('#childComment'+seq).load('/ht/hot/comment/child/${detail.eventTypeCode}?page=' + page + param, function (){
        $("html,body").scrollTop($('#childComment'+seq).offset().top-100);
    });
}

function saveChild(parntSeq){
    if (preValidation()) {
        $('form[name=eventCommentForm'+parntSeq+']').ajaxSubmit({
            url: '/ht/hot/saveEventComment'
            ,dataType: 'json'
            ,success: function(data) {
                if (data.save) {
                    alert('<fmt:message key="message.save.success"/>');
                    $('div#commentArea').load('/ht/hot/comment/${detail.eventTypeCode}?eventId=${detail.eventId}&orderBy='+orderBy+'&page=' + $("input[name=cmntPage]").val()
                    , function(){
                        loadChildComment('1', '&eventId=${detail.eventId}&parntCmntSeq='+parntSeq);
                    })
                } else {
                    alert(data.errorMessages);
                }
            }
            ,error: function(data) {
                alert('<fmt:message key="error.common.system"/>');
            }
        });
    }
    return false;
}

function deleteChildComment(seq, parntSeq) {
    if (preValidation()) {
        if (confirm('삭제하시겠습니까?')) {
            $.ajax({
                type: 'GET'
                ,url: '/ht/hot/deleteEventComment'
                ,data: 'eventId=${detail.eventId}&sequence=' + seq
                ,dataType: 'json'
                ,success: function(data) {
                    if (data.save) {
                        alert('<fmt:message key="message.delete.success"/>');
                        $('div#commentArea').load('/ht/hot/comment/${detail.eventTypeCode}?eventId=${detail.eventId}&orderBy='+orderBy+'&page=' + $("input[name=cmntPage]").val()
                        , function(){
                            loadChildComment('1', '&eventId=${detail.eventId}&parntCmntSeq='+parntSeq);
                        })
                    } else {
                        alert(data.errorMessages);
                    }
                }
                ,error: function(data) {
                    alert('<fmt:message key="error.common.system"/>');
                }
            });
        }
    }
}

function likeComment(seq) {
    if (preValidation()) {
        $.ajax({
            type: 'GET'
            ,url: '/ht/hot/likeEventComment'
            ,data: 'eventId=${detail.eventId}&sequence=' + seq
            ,dataType: 'json'
            ,success: function(data) {
                if (data.save) {
                    alert('쪼아쪼아~♥');
                    goCommentList('1');
                } else {
                    alert(data.errorMessages);
                }
            }
            ,error: function(data) {
                alert('<fmt:message key="error.common.system"/>');
            }
        });
    }
}

function init() {
    $.ajax({
        type: "GET"
        ,url: "/ht/getSaleUserCount"
        ,dataType: "json"
        ,success: function(data) {
            $("#num1").attr("src","http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/music/" + data.cnt.cpnName + ".png");
            $("#num2").attr("src","http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/music/" + data.cnt.usest + ".png");
            $("#num3").attr("src","http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/music/" + data.cnt.useet + ".png");
        }
        ,error: function() {
        }
    });
}

function goEvent(){
    location.href = $(".e_select .e_txt a").attr("href");
}

function changeOrder(type){
    orderBy = type;
    goCommentList("1");
}

function pageC019C(target, navi){
    $("#"+target).find(".prod_page.active").removeClass("active");
    $("#"+target+"_"+navi).addClass("active");
    $("#"+target).find(".prod_page_navi a.active").removeClass("active");
    $("#"+target+"_"+navi+"_page").addClass("active");
}
function addBannerClickInfo() {
    if (!isLogin) {
        needLogin();
    }else{
        $.ajax({
            type: "GET"
            ,url: "/ht/getBannerClick"
            ,data: {'bannerGubun' : 'E${detail.eventId}', 'userNum' : '${loginUser.num}', 'clickDt':'TODAY'}
            ,dataType: "json"
            ,success: function (data) {
                if(data.list.length > 0){
                    alert("이미 출석체크하셨습니다.");
                }else{
                    $.ajax({
                        type: "GET"
                        ,url: "/ht/bannerClick"
                        ,data: {'bannerGubun' : 'E${detail.eventId}', 'userNum' : '${loginUser.num}'}
                        ,dataType: "json"
                        ,success: function (data) {
                            alert("짝!짝!짝! 출석체크되었습니다.");
                            loadBannerClickInfo();
                        }
                        ,error: function() {
                            alert('<fmt:message key="error.common.system"/>');
                        }
                    });
                }
            }
            ,error: function() {
                alert('<fmt:message key="error.common.system"/>');
            }
        });
    }
}

function loadBannerClickInfo() {
    if (isLogin) {
        $.ajax({
            type: "GET"
            ,url: "/ht/getBannerClick"
            ,data: {'bannerGubun' : 'E${detail.eventId}', 'userNum' : '${loginUser.num}'}
            ,dataType: "json"
            ,success: function (data) {
                for(var i = 0; i<data.list.length; i++){
                    var id = data.list[i].clickDt;
                    $("#dt"+id).show();
                }
            }
            ,error: function() {
                alert('<fmt:message key="error.common.system"/>');
            }
        });
    }
}

function _applyEvent(){
    if (!isLogin) {
        needLogin();
    } else {
        $.ajax({
            type: 'POST'
            ,url: '/ht/hot/saveCheckEvent'
            ,data: { eventId:"${detail.eventId}" }
            ,dataType: 'json'
            ,success: function(data) {
                alert(data.alert);
                if (data.save) {
                    location.reload(true);
                }
            }
            ,error: function(data) {
                alert('응모 중 오류가 발생하였습니다. 잠시 후 다시 이용해주세요');
            }
        });
    }
}

/* 참여이벤트 */
function entryEventEmtc(emtcId){
    if (preValidation()) {
        $.ajax({
            type: "GET"
            ,url: "/ht/hot/entryEventEmtc"
            ,data: "eventId=${detail.eventId}"
            ,dataType: 'json'
            ,success: function(data) {
                if (data.result.save) {
                    alert(data.result.resultMsg);
                } else {
                    alert(data.result.errMsg);
                }
            }
            ,error: function(data) {
                alert('<fmt:message key="error.common.system"/>');
            }
        });
    }
}

function saveOff(){
    if($("input[name=userName]").val() == null ||  $("input[name=userName]").val() == ""){
        alert("이름을 입력해주세요.");
    }else if($("input[name=handPhoneNum1]").val() == null ||  $("input[name=handPhoneNum1]").val() == ""
       ||$("input[name=handPhoneNum2]").val() == null ||  $("input[name=handPhoneNum2]").val() == ""
       ||$("input[name=handPhoneNum3]").val() == null ||  $("input[name=handPhoneNum3]").val() == ""
       ){
            alert("핸드폰번호를 입력해주세요.");
    }else if($("textarea[name=userAddr]").val() == null ||  $("textarea[name=userAddr]").val() == ""){
            alert("주소지를 입력해주세요.");
    }else if($("input[name=userDtl]").val() == null ||  $("input[name=userDtl]").val() == ""){
            alert("영수증번호를 입력해주세요.");
    }else{
        var userTelNum = $("input[name=handPhoneNum1]").val() + $("input[name=handPhoneNum2]").val() + $("input[name=handPhoneNum3]").val();
        $('form[name="eventCommentForm"]').ajaxSubmit({
            url: '/ht/hot/entryEventOff'
            ,dataType: 'json'
            ,data :{
                eventId : '${detail.eventId}',
                userTelNum : userTelNum
            }
            ,success: function(data) {
                if (data.result.save) {
                    alert(data.result.resultMsg);
                    location.href="/ht/welcomeMain";
                } else {
                    alert(data.result.errMsg);
                }
            }
            ,error: function(data) {
                alert('<fmt:message key="error.common.system"/>');
            }
        });
    }
}

</script>
</head>
<body>
<c:if test="${detail.eventDispScrnCode eq 'C0201' || detail.cultZoneYn eq 'Y'}"><c:set var="isFull" value="N"/></c:if>
<c:if test="${detail.eventDispScrnCode ne 'C0201' && detail.cultZoneYn ne 'Y'}"><c:set var="isFull" value="Y"/></c:if>
<!-- 레이어팝업 : start --> 
<div id="popup" class="Pstyle"> 
    <span class="b-close">X</span> 
    <div class="content" style="height:auto; width:auto;"> 
        <img src="" id="popimg" style="width: 100%;"/> 
    </div> 
</div> 
<!-- 레이어팝업 : end -->
<div class="event_wrap ${isFull ne 'Y'?'w755':'w950'}">
    <c:if test="${isFull ne 'Y'}">
        <c:if test="${detail.cultZoneYn eq 'Y'}"><div style="border: 5px solid #f5f5f1;float:left;padding: 45px 0 50px;text-align: center;width: 170px;margin-right:15px;"><a href="/ht/culture/main"><img src="${imageServer}/images/renewal/common/tit_culture_zone02.gif" alt="CULTURE ZONE"/></a></div></c:if>
        <c:if test="${detail.cultZoneYn ne 'Y' && not empty detail.brandId}"><div class="brand_name"><a href="/ht/hot/brandDetail?brandId=${detail.brandId}"><ui:image src="${detail.brandImageUrl}" server="brand" width="170" height="170" alt="${detail.brandName}"/></a></div></c:if>
        <c:if test="${detail.cultZoneYn ne 'Y' && empty detail.brandId}"><div class="brand_name"><a style="cursor: default;" href="javascript://"><ui:image src="${detail.brandImageUrl}" server="brand" width="170" height="170"/></a></div></c:if>
    </c:if>
    <div class="event_info">
        <c:if test="${detail.eventDispTypeCode ne 'C0219'}">
            <div class="h_section">
                <%-- <c:if test="${not empty listDiary}">
                    <select class="e_select" title="다이어리 이벤트 선택" onchange="location.href=this.value;">
                        <option value="/ht/diary/main">다이어리 이벤트 전체보기</option>
                        <c:forEach items="${listDiary}" var="l">
                            <option value="/ht/biz/eventDetail?eventId=${l.eventId}">${l.eventTitle}</option>
                        </c:forEach>
                    </select>
                </c:if> --%>
                <c:if test="${empty listDiary}">
                    <div class="c_select">
                        <strong class="c_txt">전체</strong>
                        <ul>
                            <li><a href="">전체</a></li>
                            <c:forEach items="${listCtgr}" var="l">
                                <li class="item${l.cateId}"><a href=".list${l.cateId}">${l.cateName}</a></li>
                            </c:forEach>
                        </ul>
                    </div>
                    <div class="e_select">
                        <strong class="e_txt"><a href="/ht/biz/eventDetail?eventId=${detail.eventId}">${detail.eventTitle}</a></strong>
                        <ul>
                            <li><a href="/ht/welcome/hotEventMain?eventDispTypeCode=${detail.eventDispTypeCode}"><ui:code codeId="${detail.eventDispTypeCode}"/> 전체보기</a></li>
                            <c:forEach items="${listEvent}" var="l">
                                <li class="list${l.ctgrId}" title="${l.eventTitle}"><a href="/ht/biz/eventDetail?eventId=${l.eventId}">${l.eventTitle}</a></li>
                            </c:forEach>
                        </ul>
                    </div>
                    <span class="e_select_btn"><a href="javascript://" onclick="goEvent()">GO</a></span>
                </c:if>
                <div class="sns">
                    <a href="javascript://" onclick="goTwitter('${detail.eventTitle}', '${defaultHost}/ht/biz/eventDetail?eventId=${detail.eventId}')"><img src="${imageServer}/images/renewal/common/ico_sns_twitter.png" alt="twitter"/></a>
                    <a href="javascript://" onclick="goFaceBook('${detail.eventTitle}', '${defaultHost}/ht/biz/eventDetail?eventId=${detail.eventId}')"><img src="${imageServer}/images/renewal/common/ico_sns_facebook.png" alt="facebook"/></a>
                    <a href="javascript://" onclick="goPinterest('${detail.eventTitle}', '${defaultHost}/ht/biz/eventDetail?eventId=${detail.eventId}')"><img src="${imageServer}/images/renewal/common/ico_sns_pinterest.png" alt="pinterest" style="width:28px;height:28px;" nopin="true"/></a>
                </div>
                <span class="date">
                    <c:choose>
                        <c:when test="${not empty detail.eventRangeInfo}">${detail.eventRangeInfo}</c:when>
                        <c:otherwise><ui:mask pattern="####.##.##">${detail.eventStartDt}</ui:mask> ~ <ui:mask pattern="####.##.##">${detail.eventEndDt}</ui:mask></c:otherwise>
                    </c:choose>
                </span>
            </div>
        </c:if>
        <c:if test="${not empty eventRandom && detail.eventId ne '65980' && detail.eventId ne '66267'}">
            <c:if test="${detail.eventId eq '49299'}">
                <c:set var="num"><ui:lpad length="7" padChar="0">${eventRandom.totGiftAmt}</ui:lpad></c:set>
                <div style="display: block;position: absolute;height: 54px;top: 875px;font-size: 0;text-align: center;margin: 0 auto;width: 950px;">
                     <c:set var="isnon" value="true"/>
                    <c:forEach begin="0" end="6" varStatus="st">
                        <c:set var="num_idx">${fn:substring(num, st.index, st.index+1)}</c:set>
                        <c:if test="${isnon && num_idx ne '0'}"><c:set var="isnon" value="false"/></c:if>
                        <c:if test="${st.index eq 1 || st.index eq 4}"><img src="${imageServer}/images/event/49299/pc/ic_num_dot.jpg" style="margin-right:6px;"/></c:if>
                        <c:choose>
                            <c:when test="${!isnon}">
                                <img src="${imageServer}/images/event/49299/pc/ic_num_${num_idx}.jpg" alt="${num_idx}" style="margin-right:6px;"/>
                            </c:when>
                            <c:otherwise><img src="${imageServer}/images/event/49299/pc/ic_num_no.jpg" style="margin-right:6px;"/></c:otherwise>
                        </c:choose>
                    </c:forEach>
                </div>
            </c:if>
<script type="text/javascript" src="/js/jQueryRotate.2.3.js"></script>
<script type="text/javascript" src="/js/jQueryRotateCompressed.2.3.js"></script>
<script type="text/javascript">
    var is_rotating = false;	//룰렛 실행중 중복실행 방지
    var is_rotated = false;		//페이지에서 1회만 실행되도록 설정
    
    function call_rotate(img_id, angle, msg) {
        if(is_rotating) return;
        is_rotating = true;

        duration = 3000;  //돌리는 시간 : 1/1000초
        rotateCnt = Math.floor(Math.random()*20) * 360;

        $('#'+img_id).rotate({
            duration: duration,
            animateTo: (rotateCnt + angle),
            callback: function () {
                is_rotating = false;
                //is_rotated = true;  
                alert(msg);
                // location.href = "/ht/mypage/coupon";
            }
        });
    }
    
    function getRotateNum(eventId) {
        if(isLogin){
            /* if(is_rotated) {
                alert('이미 응모하신 이벤트입니다.');   
                return;
            } */
            if(is_rotating) {
                return;			
            }
            
            // 서버에서 룰렛 값을 가져옴 ( 조작 방지 위함 )
            $.ajax({
                url: "/ht/hot/saveRandomPoint",
                dataType: "json",
                data: { eventId:'${detail.eventId}' },
                success: function(data) {
                    if(data.save){
                        call_rotate('roulette', data.rotateAngle, data.returnMsg);
                    }else{
                        alert(data.returnMsg);
                    }
                },
                error:function(request,status,error){
                    console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
                   }
            });
        }else{
            needLogin();
            
        }
    }
</script>
            <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${eventRandom.imageUrlTop}" usemap="#eventImageTop"/>
            <c:if test="${not empty eventRandom.imageMapTop}">
                <map name="eventImageTop">
                    ${eventRandom.imageMapTop}
                </map>
            </c:if>
            <!-- 
            <div style="position:relative;display:block;width:950px;height:3575px;background:url('http://image.kyobobook.co.kr/newimages/giftshop_new/work/${eventRandom.imageUrlBg}') no-repeat;">
                <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${eventRandom.imageUrlPin}" style="position:absolute;bottom:3415px;left:calc(50% - 50px);z-index:2;"/>
                <a href="#" onClick="getRotateNum('${eventRandom.eventId}');return false;" id="roulette" style="position:absolute;left:calc(50% - 428px);display:block;z-index:1;" >
                    <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${eventRandom.imageUrlRlt}" width="875" height="875"/>
                </a>
            </div>
             -->
            <div style="position:relative;display:block;">
                <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${eventRandom.imageUrlBg}" style="position:relative;z-index:1;width:100%;" usemap="#eventSns"/>
	            <c:if test="${detail.eventId == '66470'}">
	                <map name="eventSns">
	                    <area shape="rect" coords="71,889,818,1211" href="javascript:ht_shareEvent()">
	                </map>
	            </c:if>
                <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${eventRandom.imageUrlPin}" style="position:absolute;bottom:97%;left:47%;z-index:3;width:6%;background:none;"/>
                <a href="#" onClick="getRotateNum('${eventRandom.eventId}');return false;" id="roulette" style="position:absolute;bottom:76.5%;width:92%;left:4%;display:block;z-index:2;background:none;" >
                    <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${eventRandom.imageUrlRlt}" width="875" height="875" style="background:none;"/>
                </a>
            </div>
            
            
        </c:if>
        <!-- img -->
        <c:if test="${not empty detail.imageUrl950 }">
                <%-- <c:when test="${fn:startsWith(detail.ctgrId, '00002000')}">
                    <div> <!-- 이벤트 튼 배경화면 -->
                        <script type="text/javascript">
                        $("#container").css("background", "url('http://image.kyobobook.co.kr/newimages/giftshop_new/work/${detail.imageUrl950}') no-repeat 50% 534px");
                        $(".event_wrap").css("padding-top" ,"25px");
                        </script>
                    </div>
                </c:when> --%>
                <div> <!-- 이벤트 튼 배경화면 -->
                    <script type="text/javascript">
                    $("#container").css("background", "url('http://image.kyobobook.co.kr/newimages/giftshop_new/work/${detail.imageUrl950}') no-repeat 50% 80px");
                    </script>
                </div>
        </c:if>
        <div class="event_img">
            <div class="ly_box_skip" style="${isFull ne 'Y'?'width: 755px; left: 195px;':'left:0;'}">">
                <p>종료된 이벤트 입니다.</p>
            </div>
        <c:if test="${not empty detail.imageUrl}"><div><ui:image src="${detail.imageUrl}" id="eventImageUrl" usemap="#eventImageMap" clazz="sns_img"/></div></c:if>
        <c:if test="${detail.stampYn}">
            <!-- 스탬프이벤트 -->
            <div id="divStamp"></div>
            <script src="/js/ht.hot.eventDetail.stamp.js?201901071633" type="text/javascript"></script>
            <script type="text/javascript">
                _eventStamp("${detail.eventId}");
            </script>
            <!-- #스탬프이벤트 -->
        </c:if>
        <c:if test="${not empty detail.userTmplHtml}">
            <div id="userTemplate"></div>
            <textarea name="userTmplHtml" style="display:none;">${detail.userTmplHtml}</textarea>
            <script src="/js/fn_htts_event_template.js?201810041520" type="text/javascript"></script>
        </c:if>
        <c:if test="${detail.userTmplUseYn eq 'Y'}"><div>${detail.userTmpl}</div></c:if>
        </div>
        <!-- 기차형바: 상품B형(C019C)이 아닌경우에만 노출 -->
        <c:if test="${detail.eventTypeCode ne 'C019C'}">
            <!-- link -->
            <div class="event_link<c:if test="${not empty detail.offLineYn}"> event_link${detail.offLineYn}</c:if>">
                <c:if test="${not empty listDisplayType}">
                    <c:set var="isExpYn" value="false"/>
                    <c:forEach items="${listDisplayType}" var="l">
                        <c:if test="${l.titleUseYn eq 'Y' && l.titleExpsYn eq 'Y'}">
                            <c:set var="isExpYn" value="true"/>
                        </c:if>
                    </c:forEach>
                    <c:if test="${isExpYn}">
                        <ul>
                            <c:forEach items="${listDisplayType}" var="l">
                                <c:if test="${l.titleUseYn eq 'Y' && l.titleExpsYn eq 'Y'}">
                                    <li><a href="#event-link${l.eventTypeInseq}" title="${l.eventTitle}"><span>${l.eventTitle}</span></a></li>
                                </c:if>
                            </c:forEach>
                        </ul>
                    </c:if>
                </c:if>
            </div>
            <!-- /link -->
            <c:forEach items="${listDisplayType}" var="l">
                <c:if test="${l.titleUseYn eq 'Y'}">
                    <div class="image-tema-title">
                        <c:if test="${not empty l.titleImageUrl}">
                            <c:if test="${not empty l.eventLinkUrl}">
                                <div class="e_bar2"><a href="${l.eventLinkUrl}"><ui:image src="${l.titleImageUrl}" id="event-link${l.eventTypeInseq}"/></a></div>
                            </c:if>
                            <c:if test="${empty l.eventLinkUrl}">
                                <div class="e_bar2"><ui:image src="${l.titleImageUrl}" id="event-link${l.eventTypeInseq}"/></div>
                            </c:if>
                        </c:if>
                        <c:if test="${empty l.titleImageUrl}">
                            <div id="event-link${l.eventTypeInseq}" class="e_bar">
                                ${l.eventTitle}
                                <c:if test="${not empty l.eventLinkUrl}"><p class="more"><a href="${l.eventLinkUrl}">더보기</a></p></c:if>
                            </div>
                        </c:if>
                    </div>
                </c:if>
                <c:import url="/ht/hot/listEventProduct?eventTypeInseq=${l.eventTypeInseq}&eventPrdtTypeCode=${l.eventPrdtTypeCode}&prdtInfoExpsYn=${l.prdtInfoExpsYn}&eventDispTypeCode=${detail.eventTypeCode}"/>
            </c:forEach>
        </c:if>
        <!-- //기차형바: 상품B형이 아닌경우에만 노출 -->
        <c:if test="${detail.eventTypeCode eq 'C019C'}">
            <c:forEach items="${listDisplayType}" var="l" varStatus="st">
                <div class="evt-list-type">
                    <div class="list-type0${st.index%2+1}">
                        <c:if test="${not empty l.eventLinkUrl}">
                            <div class="evt-bnr"><a href="${l.eventLinkUrl}"><ui:image src="${l.titleImageUrl}" id="event-link${l.eventTypeInseq}"/></a></div>
                        </c:if>
                        <c:if test="${empty l.eventLinkUrl}">
                            <div class="evt-bnr"><ui:image src="${l.titleImageUrl}" id="event-link${l.eventTypeInseq}"/></div>
                        </c:if>
                        <c:import url="/ht/hot/listEventProductC019C?eventTypeInseq=${l.eventTypeInseq}&eventPrdtTypeCode=${l.eventPrdtTypeCode}&prdtInfoExpsYn=${l.prdtInfoExpsYn}&eventDispTypeCode=${detail.eventTypeCode}&listSize=6"/>
                    </div>
                </div>
            </c:forEach>
        </c:if>
        <!-- Comment -->
        <c:if test="${detail.eventTypeCode eq 'C0192' || detail.eventTypeCode eq 'C0193' || detail.eventTypeCode eq 'C0197'}">
            <div id="commentArea">
                <c:import url="/ht/hot/comment/${detail.eventTypeCode}"/>
            </div>
        </c:if>
        <c:if test="${detail.eventId eq '61406'}">
            <div id="commentArea">
                <c:import url="/ht/hot/comment/${detail.eventTypeCode}"/>
            </div>
        </c:if>
        <c:if test="${detail.eventTypeCode eq 'C019B'}">
            <c:import url="/ht/hot/curateList/${detail.eventId}"/>
        </c:if>
        <c:if test="${detail.eventTypeCode eq 'C019A'}">
            <div id="commentArea">
                <c:import url="/ht/hot/comment/${detail.eventTypeCode}?orderBy=likeCntDesc"/>
            </div>
        </c:if>
        <c:if test="${detail.eventDispTypeCode eq 'C0219' && not empty listEvent}">
            <div id="bucketEventList">
                <p style="padding:50px;">&nbsp;</p>
                <div class="page_location" style="margin-bottom:30px;">
                    <h2 class="title"><img id="aaaaa" src="${imageServer}/images/renewal/common/tit_contentslist.gif" alt="CONTENTS LIST"></h2>
                </div>
                <div class="prod_list_normal">
                    <ul>
                        <c:forEach items="${listEvent}" var="l">
                            <li>
                                <a href="/ht/biz/eventDetail?eventId=${l.eventId}">
                                    <span class="img"><ui:image src="${l.imageUrl}" alt="${l.eventTitle}" style="width:200px;height:200px;"/></span>
                                    <span class="name mgt10">${l.eventTitle}</span>
                                </a>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
                <div class="paging">
                    <ui:paginationScript scriptName="goEventList" name="pageHolder"/>
                </div>
            </div>
        </c:if>
    </div>
</div>
</body>
</html>