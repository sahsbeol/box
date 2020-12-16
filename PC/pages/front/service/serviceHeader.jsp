<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<ui:decorator name="none"/>

    <script type="text/javascript">
        jQuery(function($) {
        	var type = parseInt("${type}")-1;
        	var src = $("#service-head > ul li").eq(type).find("img").attr("src").replace("_off.gif", "_on.gif");
        	
        	$("#service-head > ul li").eq(type).find("img").attr("src", src);
        });
    </script>
    
    <div id="service-head">
        <h1><img src="${imageServer}/images/service/h1_title.gif" alt="hottracks 만년필 집중탐구" /></h1>
        <ul>
            <li><a href="/ht/brandStory?type=1"><img src="${imageServer}/images/service/main_navi01_off.gif" alt="브랜드 스토리" /></a></li>
            <li><a href="/ht/fountainPen?type=1"><img src="${imageServer}/images/service/main_navi02_off.gif" alt="만년필 사용법" /></a></li>
            <li><a href="/ht/carvingService""><img src="${imageServer}/images/service/main_navi03_off.gif" alt="각인서비스" /></a></li>
            <li><a href="/ht/packingService"><img src="${imageServer}/images/service/main_navi04_off.gif" alt="포장서비스" /></a></li>
            <li><a href="/ht/fountainPenFaq?type=1"><img src="${imageServer}/images/service/main_navi05_off.gif" alt="자주묻는 질문" /></a></li>
        </ul>
    </div><!-- end service-head -->
