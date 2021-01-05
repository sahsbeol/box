<%@ page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
	<!-- 태그 라이브러리 -->
	<%@ include file="/pages/decorators/biz/tagHeader.jsp" %>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,viewport-fit=cover">
	<meta name="format-detection" content="telephone=no, address=no, email=no" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
	<title><decorator:title default="HOTTRACKS - 생활 속 감성충전소"/></title>
	<c:import url="/pages/decorators/biz/importHeader.jsp"/>
	
	<decorator:head/>

	<!-- Google Tag Manager -->
	<script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
	new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
	j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
	'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
	})(window,document,'script','dataLayer','GTM-5MVN3Z4');</script>
	<!-- End Google Tag Manager -->
	
<script>
$(document).ready(function(){	
	topMenu();//gnb	
	sideMenu();//side menu	
	footerFn();//footer
	topDownFn();//탑다운 버튼
	
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
</head>

<body>
	<!-- Google Tag Manager (noscript) -->
	<noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-5MVN3Z4"
	height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
	<!-- End Google Tag Manager (noscript) -->
	
	<div id="loading" class="loadingbar"><img src="/images/common/ajax-loader.gif"/></div>
	<div id="popupArea"></div>
<%-- 	<c:import url="/m/hot/menu"/> --%>
	<c:import url="/m/biz/hot/search"/>
	<div id="wrap" class="content_new">
	    <c:import url="/m/biz/gnb"/>
	    <decorator:body/>	    
	    <c:import url="/m/biz/footer"/>	     
	</div>
</body>
</html>