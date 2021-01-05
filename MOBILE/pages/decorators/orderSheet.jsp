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

<link rel="stylesheet" type="text/css" href="/css/s_order.css?${temp}">

<script type="text/javascript" src="/js/jquery-1.9.1.min.js?${temp}"></script>
<script type="text/javascript" src="/js/jquery.mobile-events.min.js?${temp}"></script>
<script type="text/javascript" src="/js/idangerous.swiper.min.js?${temp}"></script>
<script type="text/javascript" src="/js/common.js?${temp}"></script>
<script type="text/javascript" src="/js/kakao.min.js?${temp}"></script>
<script type="text/javascript" src="/scripts/common?${temp}"></script>
<script type="text/javascript" src="/scripts/loadingBar?${temp}"></script>
<script type="text/javascript" src="/scripts/device?${tmpKey}"></script>

<decorator:head/>

</head>
<body>
<div id="loading" class="loadingbar"><img src="/images/common/ajax-loader.gif"/></div>
<c:import url="/m/hot/menu"/>
<c:import url="/m/hot/search"/>
<div id="wrap" class="mini">
    <c:import url="/m/gnb"/>
    <div id="content">
        <decorator:body/>
    </div>
    <c:import url="/m/footer"/>
</div>
</body>
</html>