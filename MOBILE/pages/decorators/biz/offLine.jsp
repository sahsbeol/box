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
<c:import url="/pages/decorators/biz/importHeader.jsp"/>

<c:set value="201709121070" var="temp"/>
<link rel="stylesheet" type="text/css" href="/css/offLine.css?${temp }"/>

<script type="text/javascript">
$(document).ready(function(){	
	topMenu();//gnb	
	sideMenu();//side menu	
	footerFn();//footer
	topDownFn();//탑다운 버튼
	
	$('#subTitle').html('오프라인');
	
	// app bar 호출
	$.ajax({
        type: "POST"
        ,url: "/m/biz/quickmenu"
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
<div id="loading" class="loadingbar"><img src="/images/common/ajax-loader.gif"/></div>
<c:import url="/m/biz/hot/search"/>
<div id="wrap" class="mini">
    <c:import url="/m/biz/gnb"/>
    <!-- #content -->
    <div id="content">
        <decorator:body/>
    </div>
    <c:import url="/m/biz/footer"/>
</div>
</body>
</html>