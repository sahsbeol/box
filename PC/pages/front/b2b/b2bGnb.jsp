<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="none"/>
<html>
<head>
<script type="text/javascript">
jQuery(function($){
    var menuId = "${param.menu}";
    
    $("li#b2b_submenu"+menuId).addClass("on");
    
    $("li[id^=b2b_submenu]")
        .mouseover(function(){
            if($(this).attr("id") != "b2b_submenu"+menuId)    $(this).find("img").attr("src", $(this).find("img").attr("src").replace("_off", "_on"));
        })
        .mouseout(function(){
            if($(this).attr("id") != "b2b_submenu"+menuId)    $(this).find("img").attr("src", $(this).find("img").attr("src").replace("_on", "_off"));
        });
});
</script>
</head>
<body>
<div class="b2b_gnb">
    <ul class="b2b_menu">
        <li id="b2b_submenu01" onclick="document.location.href='/ht/b2b/main?menu=01';"><img src="${imageServer}/images/b2b/menu_01_${param.menu eq '01'?'on':'off'}.jpg"/></li>
        <li id="b2b_submenu02" onclick="document.location.href='/ht/b2b/introduce?menu=02';"><img src="${imageServer}/images/b2b/menu_02_${param.menu eq '02'?'on':'off'}.jpg"/></li>
        <li id="b2b_submenu03" onclick="document.location.href='/ht/b2b/merit?menu=03';"><img src="${imageServer}/images/b2b/menu_03_${param.menu eq '03'?'on':'off'}.jpg"/></li>
        <li id="b2b_submenu04" onclick="document.location.href='/ht/b2b/memberJoin?menu=04';"><img src="${imageServer}/images/b2b/menu_04_${param.menu eq '04'?'on':'off'}.jpg"/></li>
        <li id="b2b_submenu05" onclick="document.location.href='/ht/b2b/counsel?menu=05';"><img src="${imageServer}/images/b2b/menu_05_${param.menu eq '05'?'on':'off'}.jpg"/></li>
        <li id="b2b_submenu06" onclick="document.location.href='/ht/b2b/qna?menu=06';"><img src="${imageServer}/images/b2b/menu_06_${param.menu eq '06'?'on':'off'}.jpg"/></li>
    </ul>
</div>
</body>
</html>