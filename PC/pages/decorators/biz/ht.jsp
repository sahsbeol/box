<%@ page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
	<!-- 태그 라이브러리 -->
	<%@ include file="/pages/decorators/biz/tagHeader.jsp" %>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="Content-Script-Type" content="text/javascript">
	<meta http-equiv="Content-Style-Type" content="text/css">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=950">
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

<script type="text/javascript">
$(document).ready(function(){
	gnb();//gnb
	nav();//nav	
	if($('.header_wrap').length >0){
		bodyScroll();//body scroll	
	}
})	
</script>
</head>
<body>
<!-- Google Tag Manager (noscript) -->
<noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-5MVN3Z4"
height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
<!-- End Google Tag Manager (noscript) -->

<c:import url="/menu/biz/curtainBnr"/>

<div id="wrap" class="content_new">
    <c:import url="/menu/biz/topGnb"/>
    
    <decorator:usePage id="conPage" />
    <% String container = conPage.getProperty("meta.container"); %>
    
    <!-- Container -->
    <div id="container" <%if(container != null && !"".equals(container)){%>class="<%=container%>"<%}%>>   
        <!-- 컨텐츠 -->        
        <div class="content" id="content">
            <decorator:body/>
            <c:if test="${fn:contains(window.location,'/ht/gift/giftCategoryMain')}">
	        	<c:import url="/menu/biz/quickMenu"/>
            </c:if>
        </div>
        <!-- //컨텐츠 -->
    </div>
    <!-- //Container -->
    <c:import url="/menu/biz/footer" />
</div>
<div id="mask"></div>
</body>
</html>