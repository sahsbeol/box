<%@ page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<!-- 태그 라이브러리 -->
<%@ include file="/pages/decorators/biz/tagHeader.jsp" %>

<c:set var="tmpKey" value="201906210101"/>

<link href="/images/biz/common/favicon.ico" rel="shortcut icon">

<link rel="apple-touch-icon-precomposed" href="/images/ico_app.png" />
<link rel="apple-touch-startup-image" href="/images/ico_app.png">

<link rel="stylesheet" type="text/css" href="/css/common.css?${tmpKey}">
<link rel="stylesheet" type="text/css" href="/css/layout.css?${tmpKey}">
<link rel="stylesheet" type="text/css" href="/css/contents.css?${tmpKey}">
<link rel="stylesheet" type="text/css" href="/css/shop.css?${tmpKey}">
<link rel="stylesheet" type="text/css" href="/css/biz/common_v2.css?${tmpKey}">
<link rel="stylesheet" type="text/css" href="/css/biz/hottweb_yj.css?${tmpKey}">
<link rel="stylesheet" type="text/css" href="/css/biz/slick.css?${tmpKey}">

<script type="text/javascript" src="/js/jquery-1.9.1.min.js?${tmpKey}"></script>
<script type="text/javascript" src="/js/jquery.lazyload.min.js?${tmpKey}"></script>
<script type="text/javascript" src="/js/m_contents.js?${tmpKey}"></script>
<script type="text/javascript" src="/js/music.js?${tmpKey}"></script>
<script type="text/javascript" src="/js/musicPlayer.js?${tmpKey}"></script>
<script type="text/javascript" src="/scripts/common?${tmpKey}"></script>
<script type="text/javascript" src="/js/ht.common.utils.1.0.0.js?${tmpKey}"></script>
<script type="text/javascript" src="/js/ht.menu.topGnb.1.0.0.js?${tmpKey}"></script>
<script type="text/javascript" src="/js/biz/jquery/swiper.min.js"></script>
<script type="text/javascript" src="/js/biz/common_v2.js"></script>
<script type="text/javascript" src="/js/biz/hott.js"></script>
<script type="text/javascript" src="/js/biz/jquery/jquery.easing.1.3.min.js"></script>
<script type="text/javascript" src="/js/biz/jquery/TweenMax.min.js"></script>
<script type="text/javascript" src="/js/biz/ht.menu.bizTopGnb.1.0.0.js?${tmpKey}"></script>
<script type="text/javascript" src="/js/biz/jquery/jquery.bxslider.min.js?${tmpKey}"></script>
<script type="text/javascript" src="/js/biz/jquery/slick.min.js?${tmpKey}"></script>

<!-- 데이타 스토리  script--> 
<script type="text/javascript">
(function() {
	var nl = document.createElement('script'); nl.type = 'text/javascript';
	nl.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + 'www.hottracks.co.kr/js/wl6.js';
	var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(nl, s);
	var done = false;
	nl.onload = nl.onreadystatechange = function() {
	    if ( !done && (!this.readyState || this.readyState === 'loaded' || this.readyState === 'complete') ) {
	        done = true;
			_n_sid = 'pc.hottracks.co.kr';        // _n_sid 값 별로 로그파일이 생성이 됩니다
	        _n_uid_cookie = 'WNO';
	        n_logging();
	        nl.onload = nl.onreadystatechange = null;
	    }
	}
})();
</script>