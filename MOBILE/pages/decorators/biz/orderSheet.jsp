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

<c:set var="temp" value="201709070873"/>
<link href="/images/biz/common/favicon.ico" rel="shortcut icon">
<link rel="stylesheet" type="text/css" href="/css/layout.css?${tmpKey}">
<link rel="stylesheet" type="text/css" href="/css/content.css?${tmpKey}">
<link rel="stylesheet" type="text/css" href="/css/common.css?${tmpKey}">
<link rel="stylesheet" type="text/css" href="/css/biz/common_v2.css?${tmpKey}">
<link rel="stylesheet" type="text/css" href="/css/biz/hottm_yj.css?${tmpKey}">

<script type="text/javascript" src="/js/jquery-1.9.1.min.js?${temp}"></script>
<script type="text/javascript" src="/js/jquery.mobile-events.min.js?${temp}"></script>
<script type="text/javascript" src="/js/idangerous.swiper.min.js?${temp}"></script>
<script type="text/javascript" src="/js/common.js?${temp}"></script>
<script type="text/javascript" src="/js/kakao.min.js?${temp}"></script>
<script type="text/javascript" src="/scripts/common?${temp}"></script>
<script type="text/javascript" src="/scripts/loadingBar?${temp}"></script>
<script type="text/javascript" src="/scripts/device?${tmpKey}"></script>
<script type="text/javascript" src="/js/biz/common_v2.js?${tmpKey}"></script>
<script type="text/javascript" src="/js/biz/m_hott.js?${tmpKey}"></script>
<script type="text/javascript" src="/js/biz/jquery/jquery.easing.1.3.min.js?${tmpKey}"></script>
<script type="text/javascript" src="/js/biz/jquery/TweenMax.min.js?${tmpKey}"></script>
<decorator:head/>

</head>
<script type="text/javascript">
$(document).ready(function(){	
	topMenu();//gnb	
	sideMenu();//side menu	
	topDownFn();//탑다운 버튼
	initTopNavigation();
	
	$('#subTitle').html('주문서 작성');
    $('.btn_search').hide();
    $('.btn_category').hide();
    $('.btn_bhome').show();
	
	// app bar 호출
	/* $.ajax({
        type: "POST"
        ,url: "/m/biz/quickmenu"
        ,dataType: "html"
        ,success : function(html){
            $("body").append(html);            
        } 
        ,error: function(data) {
        }
    }); */
});
</script>
<body>
<div id="loading" class="loadingbar"><img src="/images/common/ajax-loader.gif"/></div>
<div id="wrap" class="mini">
    <c:import url="/m/biz/gnb"/>
    <div id="content">
        <decorator:body/>
    </div>
</div>
</body>
</html>