<%@ page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<ui:decorator name="none"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <title>${popup.popuptitle}</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="stylesheet" type="text/css" href="/css/common.css" />
    <link rel="stylesheet" type="text/css" href="/css/popup.css" />
    <script type="text/javascript" src="/js/jquery-1.4.2.min.js" charset="utf-8"></script>
    <script type="text/javascript">
    jQuery(function($){
        $("a,area").click(function(){
            $.ajax({
                url: 'http://admin.hottracks.co.kr/admin/system/hotSiteClickCheck2'
                ,dataType: 'jsonp'
                ,jsonpCallback: "callback"
                ,success: function(data) {
                }
            });
        });
    });
    function todayclose() {
        $.ajax({
            type: "GET"
            ,url: "/ht/savePopupCookie"
            ,data: {popupSeq : '${popup.popupseq}' }
            ,dataType: "json"
            ,success: function(data) {
                window.close();
            }
            ,error: function(xhr, status, error) {
                alert("<fmt:message key='error.common.system'/>");
            }
        });
    }
    </script>
</head>
<body>
    <div class="photo-notice">
        <ui:image src="${popup.imageurl}" id="popupImageUrl" usemap="#popupImageMap"/>
        <map name="popupImageMap">${popup.popuphtml}</map>
    </div><!-- end quick -->
    <div class="close-in-day">
        <c:if test="${popup.todaycloseyn}"><label for="not-view">오늘 하루 보지 않기</label><input type="checkbox" id="not-view" onclick="todayclose();"/></c:if>
        <c:if test="${!popup.todaycloseyn}"><a href="#" onclick="window.close();" title="닫기" class="close">닫기</a></c:if>
    </div>
</body>
</html>