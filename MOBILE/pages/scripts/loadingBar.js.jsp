<%@page contentType="application/javascript" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<ui:decorator name="none"/>
jQuery(function($) {
    $(document).ready(function(){
        $("#loading").hide();
    });
    
    $(window).on("beforeunload", function(){
        $("#loading").show();
    });
    
    $(window).on("unload", function(){
        $("#loading").hide();
    });
    
    $("#loading").ajaxStart(function(){
        $(this).fadeIn();
        var obj = $(this);
        setTimeout(function(){$(obj).fadeOut();},2000);
    }).ajaxStop(function(){
        $(this).fadeOut();
    });
});

function hideLoad(){
        $("#loading").hide();
}