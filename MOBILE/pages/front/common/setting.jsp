<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="layer"/>
<html>
<head>
<style type="text/css">
.list01 a { line-height:20px; }
.rulebox { line-height:20px; }
.rulebox p { margin-top:20px;font-weight:bold; }
</style>
<script type="text/javascript">
var page = 1;
jQuery(function($){
    $(document).ready(function(){
        $('body').addClass('bg_gray');//상단 mini 모드
    });
    
    $(".radio_box a")
    .click(function(e){
        e.preventDefault();
        if($(this).hasClass("active")){
            $(this).removeClass("active");
        }else{
            $(this).addClass("active");
        }
        
        syncData();
    });
    
    $(".quick_box a")
    .click(function(e){
        e.preventDefault();
        var quickId = $(this).attr("href").replace("#", "");
        if($(this).hasClass("active")){
            rmQuickItem(quickId);
        }else if($(".my_quick_box").find("a").length > 3){
            alert("최대 4개 까지만 등록 가능합니다.");
        }else{
            addQuickItem(quickId);
        }
    });
});

function initQuickItem(){
    $(".my_quick_box").find("a").each(function(){
        var quickId = $(this).attr("href").replace("#", "");
        
        var quickItem = $("#quick"+quickId);
        quickItem.removeClass("active");
        quickItem.css("background-image", "url('"+quickItem.attr("offimg")+"')");
        $(this).remove();
    });
    
    syncData();
}

function rmQuickItem(quickId){
    $(".my_quick_box").find("a").each(function(){
        if($(this).attr("href").replace("#", "") == quickId){
            $(this).remove();
        }
    });
    
    var quickItem = $("#quick"+quickId);
    quickItem.removeClass("active");
    quickItem.css("background-image", "url('"+quickItem.attr("offimg")+"')");
    
    syncData();
}

function addQuickItem(quickId){
    var quickItem = $("#quick"+quickId);
    var item = '<a href="#'+quickId+'" onclick="rmQuickItem(\''+quickId+'\');return false;" style="background-image:url(\''+quickItem.attr("offimg")+'\');">'+quickItem.text();+'</a>';
    $(".my_quick_box").append(item);
    
    quickItem.addClass("active");
    quickItem.css("background-image", "url('"+quickItem.attr("onimg")+"')");
    
    syncData();
    
    if(window.HybridApp != undefined && window.HybridApp.syncData != undefined){
        window.HybridApp.syncData();
    }
}

function closeSetting(){
    if(window.HybridApp != undefined && window.HybridApp.goSetting != undefined){
        window.HybridApp.closeSetting();
    }else{
        history.back();
    }
}

function syncData(){
    var altShopYn = $("#btnAltShopYn").hasClass("active")?"Y":"N";
    var altSignYn = $("#btnAltSignYn").hasClass("active")?"Y":"N";
    var autoLoginYn = $("#btnAutoLoginYn").hasClass("active")?"Y":"N";
    var linkIds = "";
    $(".my_quick_box").find("a").each(function(){
        var quickId = $(this).attr("href").replace("#", "");
        if(linkIds != "")    linkIds += ",";
        linkIds += quickId;
    });
    
    $.ajax({
        type: "POST"
        ,url: "/m/dev/syncData"
        ,dataType: "json"
        ,data : {
            devId : "${device.devId}"
          , gcmKey : "${device.gcmKey}"
          , devVersion : "${device.devVersion}"
          , altShopYn : altShopYn
          , altSignYn : altSignYn
          , autoLoginYn : autoLoginYn
          , linkIds : linkIds
        }
        ,success : function(data){
            console.log("save");
        } 
        ,error: function(data) {
            console.log("fail");
        }
    });
}
</script>
</head>
<body>
<style type="text/css">
#ly_setting {  }
#ly_setting .login_box { display:block;margin:10px; }
#ly_setting .login_box .info_box { display:block;padding:10px;border:1px solid #dadada;border-radius:4px;height:24px;line-heihgt:24px; }
#ly_setting .login_box .info_box .btn { float:right;height:24px;line-height:24px;padding:0 10px; }
#ly_setting .radio_box { height:24px;line-height:24px;padding:10px; }
#ly_setting .radio_box + .radio_box { padding-top:0; }
#ly_setting .radio_box span { }
#ly_setting .radio_box a { float:right;display:block;width:44px;height:24px;text-indent:-999em;background:url('http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/mobile/common/ic_switch_off.png') no-repeat center center;background-size:44px 24px; }
#ly_setting .radio_box a.active { background-image:url('http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/mobile/common/ic_switch_on.png'); }
#ly_setting h4 { padding:15px 10px;background-color:#eee;position:relative; }
#ly_setting h4 a { position:absolute;right:10px;top:10px;background-color:#595959;padding:5px 12px;border-radius:2px;color:#fff; }
#ly_setting .my_quick_box { padding:20px;height:45px;display:-webkit-box; }
#ly_setting .my_quick_box a { -webkit-box-flex:1;display:block;padding-top:35px;background-size:30px;background-repeat:no-repeat;background-position:center 0;text-align:center; }
#ly_setting .quick_box { border-top:1px solid #dadada;border-bottom:1px solid #dadada; }
#ly_setting .quick_box a { display:block;padding:5px 0 5px 40px;margin:0 10px;background-size:30px;line-height:30px;background-repeat:no-repeat;background-position:0 center;text-align:left; }
#ly_setting .quick_box a + a { border-top:1px solid #dadada; }
#ly_setting .version_box { margin:20px 10px; }
#ly_setting .version_box .txt { margin-top:15px;text-align:center;display:block; }
#ly_setting .version_box .txt em + strong { margin-left:10px; }
#ly_setting .btn_cls {position:absolute;top:0;right:0;width:40px;height:40px;overflow:hidden;background:url(/images/common/btn_layer_cls.gif) no-repeat;background-size:100% auto;line-height:999px;}
</style>
<div id="ly_header"><h1>설정</h1></div>
<!-- content -->
<div id="ly_setting">
    <div class="login_box">
        <c:choose>
            <c:when test="${not empty user}">
                <div class="info_box">
                    <strong>로그인정보</strong>
                    ${user.userId}
                    <a href="#" onclick="logout();return false;" class="btn btn_orange">로그아웃</a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="box_flex">
                    <a href="#" onclick="login();return false;" class="btn btn_orange">로그인</a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
    
    <div class="radio_box">
        <span>자동로그인</span>
        <a href="#" id="btnAutoLoginYn"<c:if test="${device.autoLoginYn ne 'N'}"> class="active"</c:if>>자동로그인</a>
    </div>
    
    <h4><strong>알림설정</strong></h4>
    <div class="radio_box">
        <span>쇼핑혜택 알림 받기</span>
        <a href="#" id="btnAltShopYn"<c:if test="${device.altShopYn ne 'N'}"> class="active"</c:if>>쇼핑혜택 알림 받기</a>
    </div>
    <div class="radio_box">
        <span>사인회 알림 받기</span>
        <a href="#" id="btnAltSignYn"<c:if test="${device.altSignYn ne 'N'}"> class="active"</c:if>>사인회 알림 받기</a>
    </div>
    <h4>
        <strong>퀵메뉴 편집하기</strong>
        <a href="#" onclick="initQuickItem();return false;">초기화</a>
    </h4>
    <div class="my_quick_box">
        <c:forEach items="${listMyQuick}" var="l" varStatus="st">
            <a href="#${l.id}" onclick="rmQuickItem('${l.id}');return false;" style="background-image:url('${imageServer}/images/mobile/quick/${l.offImgUrl}.png');">${l.title}</a>
        </c:forEach>
    </div>
    <div class="quick_box">
        <c:forEach items="${listQuick}" var="l" varStatus="st">
            <c:choose>
                <c:when test="${l.checkYn eq 'Y'}">
                    <a href="#${l.id}" id="quick${l.id}" style="background-image:url('${imageServer}/images/mobile/quick/${l.onImgUrl}.png');"
                       onImg="${imageServer}/images/mobile/quick/${l.onImgUrl}.png"
                       offImg="${imageServer}/images/mobile/quick/${l.offImgUrl}.png"
                       class="active"
                    >${l.title}</a>
                </c:when>
                <c:otherwise>
                    <a href="#${l.id}" id="quick${l.id}" style="background-image:url('${imageServer}/images/mobile/quick/${l.offImgUrl}.png');"
                       onImg="${imageServer}/images/mobile/quick/${l.onImgUrl}.png"
                       offImg="${imageServer}/images/mobile/quick/${l.offImgUrl}.png"
                    >${l.title}</a>
                </c:otherwise>
            </c:choose>
        </c:forEach>
    </div>
    <div class="version_box">
        <c:if test="${device.devVersion ne rcntVersion}">
            <div class="box_flex">
                <a href="market://details?id=kr.co.hottracks.m.app" class="btn btn_orange">최신버전 업데이트</a>
            </div>
        </c:if>
        <p class="txt">
            <strong>현재버전</strong>
            <em>${device.devVersion}</em>
            <strong>최신버전</strong>
            <em class="col_orange">${rcntVersion}</em>
        </p>
    </div>
    <a href="#" onclick="closeSetting();return false;" class="btn_cls">닫기</a>
</div>
</body>
</html>