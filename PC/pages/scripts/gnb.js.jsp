<%@page contentType="application/javascript" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<ui:decorator name="none"/>
function initTopNavigation() {
    $.ajax({
        type: 'GET'
        ,url: '/ht/order/ajaxGetCartCount'
        ,dataType: 'json'
        ,success: function(data) {
            $('.cartCount').html('(' + data.cartCount + ')');
        }
        ,error: function(data) {
            // ignore
        }
    });
}

jQuery(function($) {
    $(document).ready(function() {
        var vid = $.cookie('UserCookieKey');
        if (isEmpty(vid)) {//로그인이 안되있으면
            $('#loginLnb').show();
            $('#logoutLnb').hide();
        } else {
            $('#loginLnb').hide();
            $('#logoutLnb').show();
        }
        
        initTopNavigation();
    });

   /*$('#ulMenu a').mouseover(function() { 
        menu_mouseover($(this));
    });

    $("#divMenu div").mouseover(function() {
        menu_recovery();
    });

    $("#divMenu").mouseout(function() {
        menu_clear();
    });*/
    
    $('#searchKey').toggle(function() {
        $("#searchUl").show();
    }, function() {
        $("#searchUl").hide();
    });

    $('#myHottracksMenu').toggle(function() {
        $("#myhottracks").show();
        if($("#myHottracksMenu").hasClass("lnb_menu4_off")){
            $("#myHottracksMenu").removeClass("lnb_menu4_off");
            $("#myHottracksMenu").addClass("lnb_menu4_on");
        }else{
            $("#myHottracksMenu").addClass("lnb_menu4_off");
            $("#myHottracksMenu").removeClass("lnb_menu4_on");
        }
    }, function() {
        $("#myhottracks").hide();
        if($("#myHottracksMenu").hasClass("lnb_menu4_off")){
            $("#myHottracksMenu").removeClass("lnb_menu4_off");
            $("#myHottracksMenu").addClass("lnb_menu4_on");
        }else{
            $("#myHottracksMenu").addClass("lnb_menu4_off");
            $("#myHottracksMenu").removeClass("lnb_menu4_on");
        }
    });
    
    $('#serviceAllShow').click(function() {
        $("#view_all").show();
    });
    
    $('#serviceAllHide').click(function() {
        $("#view_all").hide();
    });
});
