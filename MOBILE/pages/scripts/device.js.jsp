<%@page contentType="application/javascript" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<ui:decorator name="none"/>
var device = null;
jQuery(function($){
    if(window.HybridApp != undefined && window.HybridApp.enhanceDeviceInfo != undefined){
        var data = window.HybridApp.enhanceDeviceInfo();
        var json = JSON.parse(data);
        var devId = json["HT_DEVID"];
        var gcmKey = json["HT_GCMKEY"];
        var devVersion = json["HT_DEVVR"];
        
        device = {devId:devId,gcmKey:gcmKey,devVersion:devVersion};
        
        $.ajax({
             type:"POST"
            ,async:true
            ,url:"/m/dev/syncDevice"
            ,dataType:"json"
            ,data:device
        });
    }
});

function locBack(){
    <c:choose>
        <c:when test="${   not empty device
                        && device.devGbnCode eq 'C1332'
                        && not empty device.devVersion
                        && !fn:startsWith(device.devVersion, '1.4')
                        && !fn:startsWith(device.devVersion, '1.5')}">
            document.location = "myScheme://locBack";
        </c:when>
        <c:otherwise>
            history.back();
        </c:otherwise>
    </c:choose>
}

function winOpen(url, target, param){
    if(window.HybridApp != undefined && window.HybridApp.popup != undefined){
        window.HybridApp.popup(url);
    }else{
        window.open(url, target, param);
    }
}

function winOpen2(url, target, param){
    if(window.HybridApp != undefined && window.HybridApp.popup != undefined){
        winOpen(url, target, param);
    }else{
        $("#popupLayer001").find("iframe").attr("src", url);
        $("#popupLayer001").show();
        
        $("#wrap").css({position:"fixed"});
    }
}

function winOpen3(url){
    location.href = url; 
    $("#loading").remove();
}

function closeWin2(){
    $("#popupLayer001").hide();
    $("#popupLayer001").find("iframe").attr("src", "about:Tabs");
    $("#wrap").css({position:"initial"});
}


function goSetting(){
    $("#cate-menu").animate({left:"-100%"}, function(){
        $("#wrap").css({position:"initial"});
        
        var url = location.href;
        if(window.HybridApp != undefined && window.HybridApp.goSetting != undefined){
            window.HybridApp.goSetting(url);
        }else{
            <c:choose>
                <c:when test="${not empty device}">
                    location.href = '${defaultHost}/m/hot/setting';
                </c:when>
                <c:otherwise>
                    location.href = '${defaultHost}/m/mypage/main';
                </c:otherwise>
            </c:choose>
        }
    });
}

function goAppUpdate(){
    var link = encodeURI(location.href);
    var userAgent = navigator.userAgent.toUpperCase();
    var url = 'intent://hottracksand?uri='+link+'#Intent;scheme=hotand;action=android.intent.action.VIEW;category=android.intent.category.BROWSABLE;package=kr.co.hottracks.m.and;end';
    if(!userAgent.match(/ANDROID/)){
        url = 'https://itunes.apple.com/kr/app/hottracks/id1129743143?mt=8';
    }
    location.href = url;
}

function linkToInstagram(target){
    winOpen('https://www.instagram.com/hottracks_online');
}