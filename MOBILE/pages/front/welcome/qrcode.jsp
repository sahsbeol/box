<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="none"/>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0">
<meta name="format-detection" content="telephone=no, address=no, email=no" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
<c:forEach items="${list}" var="l" end="0">
    <c:set var="mobIntro" value="${l}"/>
</c:forEach>
<style type="text/css">
html,body { margin:0;padding:0;background-color:#000; }
.scr { position:fixed;left:0;top:0;width:100%;height:100%;background:url('${mobIntro.imgUrl}') no-repeat center center;background-size:cover; }
</style>
<script type="text/javascript" src="/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript">
jQuery(function($) {
    $(document).ready(function(){
        var userAgent = navigator.userAgent.toUpperCase();
        var link = encodeURI(location.href);
        if(userAgent.match(/IPHONE/) || userAgent.match(/IPAD/)){
            location.href = 'https://itunes.apple.com/kr/app/hottracks/id1129743143?mt=8';
        } else if (userAgent.match(/ANDROID/)){
            location.href = 'intent://hottracksand?uri=http://m.hottracks.co.kr${tUrl}#Intent;scheme=hotand;action=android.intent.action.VIEW;category=android.intent.category.BROWSABLE;package=kr.co.hottracks.m.and;end';
        } else {
            location.href = 'http://m.hottracks.co.kr${tUrl}';
        }
    });
});
function move(){
    $(".scr").animate({ "opacity": "0" },2000, function () { location.replace("${tUrl}"); });
    return false;
}
</script>
</head>
<body>
<div class="scr"></div>
</body>
</html>