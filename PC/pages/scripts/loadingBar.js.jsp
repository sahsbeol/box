<%@page contentType="application/javascript" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<ui:decorator name="none"/>
jQuery(function($) {
    $("body").append("<div id=\"loadingBar\" style=\"position:absolute; z-index:1500; display:none\"><img src=\"${imageServer}/images/common/ajax-uploader.gif\" alt=\"loadingBar\"/></div>");
    $("div#body").mousemove(function(e){
        var positionX = e.pageX - 25;
        var positionY = e.pageY - 25;
        $("#loadingBar").css({"left" : positionX, "top": positionY});
    });
    $("#loadingBar").ajaxStart(function(){
        $(this).fadeIn();
        var obj = $(this);
        setTimeout(function(){$(obj).fadeOut();},2000);
    }).ajaxStop(function(){
        $(this).fadeOut();
    });
});
