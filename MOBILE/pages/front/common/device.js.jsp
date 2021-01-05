<%@page contentType="application/javascript" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<ui:decorator name="none"/>
function goSetting(){
    $("#cate-menu").animate({left:"-100%"}, function(){
        $("#wrap").css({position:"initial"});
        
        var url = location.href;
        if(window.HybridApp != undefined && window.HybridApp.goSetting != undefined){
            window.HybridApp.goSetting(url);
        }else{
            location.href = '${defaultHost}/m/mypage/main';
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
    var userAgent = navigator.userAgent.toUpperCase();
    if(!userAgent.match(/ANDROID/)){
        window.open('https://www.instagram.com/hottracks_online');
    }else{
        if(target == null || target == "home"){
            window.open('intent://instagram.com/_u/hottracks_online/#Intent;package=com.instagram.android;scheme=https;end', '_instagram', '');
        }else{
            window.open('intent://instagram.com/_n/mainfeed/#Intent;package=com.instagram.android;scheme=https;end', '_instagram', '');
        }
    }
}