<%@ page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Script-Type" content="text/javascript">
<meta http-equiv="Content-Style-Type" content="text/css">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=950">
<title><decorator:title default="HOTTRACKS - 생활 속 감성충전소"/></title>

<c:import url="/pages/decorators/biz/importHeader.jsp"/>

<%-- <c:set var="temp" value="201807031321"/>

<link rel="stylesheet" type="text/css" href="/css/s_common.css?${temp}" />
<link rel="stylesheet" type="text/css" href="/css/s_layout.css?${temp}" />
<link rel="stylesheet" type="text/css" href="/css/s_contents.css?${temp}" />
<link rel="stylesheet" type="text/css" href="/css/s_shop.css?${temp}" />

<script type="text/javascript" src="/js/jquery-1.9.1.min.js?${temp}"></script>
<script type="text/javascript" src="/js/m_contents.js?${temp}"></script>
<script type="text/javascript" src="/js/music.js?${temp}"></script>
<script type="text/javascript" src="/scripts/common?${temp}"></script>
<script type="text/javascript" src="/js/ht.common.utils.1.0.0.js"></script>
<script type="text/javascript" src="/js/ht.menu.topGnb.1.0.0.js"></script> --%>

<decorator:head/>

</head>
<body>
<c:import url="/menu/biz/curtainBnr"/>

<div id="wrap" class="content_new">
    <c:import url="/menu/biz/topGnb?ssl=Y"/>
    
    <!-- Container -->
    <div id="container">   
        <!-- 컨텐츠 -->
        <div class="content" id="content">
            <decorator:body/>
        </div>
        <!-- //컨텐츠 -->
    </div>
    <!-- //Container -->
    <c:import url="/menu/biz/footer?ssl=Y" />
</div>
<div id="mask"></div>
</body>
</html>