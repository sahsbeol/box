<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<head>
<title>음반 메인 - NEW ME HOTTRACKS</title>
<c:set value="333" var="temp"/>
<link rel="stylesheet" type="text/css" href="/css/chart.css?${temp }">
<script type="text/javascript">
jQuery(function($){
    
});
function goList(page) {
    if(page == null || page == undefined)    page = 1;
    location.href="?page=" +page;
}

</script>
</head>
<body>
<div class="music_wrap">
    <h1 id="music_magazine_title"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/idol/music_title.png"/></h1>
    <div class="idole_news">
    <section class="musicmain">
        <div id="magazine_title">
            <p id="news"><a href="/ht/idol/news">신곡뉴스</a></p>
            <p id="special" class="on"><a href="/ht/idol/special">아이돌매거진</a></p>
        </div>
        <div class="news_list">
            <c:forEach items="${ special}" var="l" varStatus="st">
                <a class="music_news_div" href="/ht/idol/specialDetail?cntid=${l.cntid }">
                    <p class="img" style="background:url(${l.image }) center center no-repeat;"></p>
                    <span class="title">
                        <c:choose>
                                <c:when test="${not empty l.title && fn:length(l.title) >= 73 }">
                                    ${l.title}<span class="content_after">...</span>
                                </c:when>
                                <c:otherwise>${l.title}</c:otherwise>
                        </c:choose>
                    </span>
                    <span class="date">${l.pubdt }</span>
                </a>
            </c:forEach>
        </div>
    </section>
    </div>
    <!-- paging -->
    <div class="paging mb30">
        <ui:paginationScript name="pageHolder" scriptName="goList"/>
    </div>
</div>
</body>
</html>