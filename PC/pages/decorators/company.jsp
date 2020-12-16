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

<c:set var="tmpKey" value="201704031351"/>

<link rel="stylesheet" type="text/css" href="/css/common.css?${tmpKey }" />
<link rel="stylesheet" type="text/css" href="/css/company.css?${tmpKey}" />

<script type="text/javascript" src="/js/jquery-1.9.1.min.js?${tmpKey }"></script>
<script type="text/javascript" src="/scripts/common?${tmpKey }"></script>
<decorator:head/>

<script type="text/javascript">
jQuery(function($) {
    $(".gnb-item").hover(
        function(){
            $(".gnb-item.on").removeClass("on");
            $(this).addClass("on");
        }
      , function(){
          $(this).removeClass("on");
        }
    )
});
</script>
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
<form method="post" action="/company/story/eventView" onsubmit="return true" name="frmSearch" id="frmSearch">
    <input type="hidden" name="boardSeq" value="0" />
    <input type="hidden" name="page" value="1" />
</form>
<!-- Skip - Navigation -->
<div class="hidden_obj"><h2><a href="#contents">본문바로가기</a></h2></div>
<!-- //Skip - Navigation -->
<hr/><!-- 문단나누기 -->
<div id="wrapper">
    <c:import url="/company/gnb"/>
    <hr/><!-- 문단나누기 -->
    <div id="contents">
        <decorator:body/>
    </div><!-- end contents -->
    <hr/><!-- 문단나누기 -->
    <!-- Footer -->
    <c:import url="/company/footer"/>
    <hr/><!-- 문단나누기 -->
</div>
</body>
</html>