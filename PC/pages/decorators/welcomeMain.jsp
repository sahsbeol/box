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
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=950">
<meta name="naver-site-verification" content="53af49e4832e3ad93ffe7a4cfd2b1151821828e5"/>
<title><decorator:title default="HOTTRACKS - 생활 속 감성충전소"/></title>
<c:import url="/pages/decorators/importHeader.jsp"/>

<decorator:head/>

<!-- Google Tag Manager -->
<script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
})(window,document,'script','dataLayer','GTM-5MVN3Z4');</script>
<!-- End Google Tag Manager -->

</head>
<body>
<!-- Google Tag Manager (noscript) -->
<noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-5MVN3Z4"
height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
<!-- End Google Tag Manager (noscript) -->

<ul id="skip-navigation"><!-- skip-navigation -->
    <li><a href="#content">본문 바로가기</a></li>
    <li><a href="#gnb">메뉴 바로가기</a></li>
</ul>

<div id="wrap">
    <c:import url="/menu/topGnb?gnbType=main"/>
    <c:import url="/menu/quickMenu"/>
    <!-- Container -->
    <div id="container">
        <!-- 컨텐츠 -->
            <decorator:body/>
        <!-- //컨텐츠 -->
    </div>
    <!-- //Container -->
    <c:import url="/menu/footer" />
</div>
<div id="mask"></div>
</body>
</html>