<%@ page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,viewport-fit=cover">
<meta name="format-detection" content="telephone=no, address=no, email=no" /> 
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
<title><decorator:title default="HOTTRACKS - 생활 속 감성충전소"/></title>
<c:import url="/pages/decorators/importHeader.jsp"/>

<script type="text/javascript">
jQuery(function($){
    $('.tab_basic').fnTab({contentClass:'tab_cont'}); //best/new 탭
    
    $.ajax({
        type: "POST"
        ,url: "/m/quickmenu"
        ,dataType: "html"
        ,success : function(html){
            $("body").append(html);
        } 
        ,error: function(data) {
        }
    });
});
</script>

<decorator:head/>

</head>
<body>
<div id="loading" class="loadingbar"><img src="/images/common/ajax-loader.gif"/></div>
<c:import url="/m/hot/menu"/>
<c:import url="/m/hot/search"/>
<div id="wrap" class="mini">
    <c:import url="/m/gnb"/>
    <!-- #content -->
    <div id="content">
        <decorator:body/>
    </div>
    <c:import url="/m/footer"/>
</div>
</body>
</html>