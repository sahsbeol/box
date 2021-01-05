<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="welcome"/>
<head>
<title>음반 메인 - NEW ME HOTTRACKS</title>
<c:import url="/pages/decorators/importHeader.jsp"/>
<c:set value="124" var="temp"/>
<link rel="stylesheet" type="text/css" href="/css/chart.css?${temp }">
<script type="text/javascript">
jQuery(function($){
    $("#wrap").removeClass("mini");
    $("#locMusic").addClass("active");
    
});
function goList(page){
    location.href="?page="+page;
}
</script>
</head>
<body>
<div class="music_wrap" style="background-color: white">
    <div class="idole_news">
    <section class="musicmain">
        <div style="display: flex;height: 49.5px;">
            <p id="news" class="on"><a href="/m/idol/news">신곡뉴스</a></p>
            <p id="speical"><a href="/m/idol/special">아이돌매거진</a></p>
        </div>
        <div class="news_list">
            <c:forEach items="${news }" var="l" varStatus="st">
                <a class="music_news_div" href="/m/idol/newsDetail?cntid=${l.cntid }">
                    <p class="img" style="background:url('${l.image }') center center no-repeat; background-size:cover;"></p>
                    <span class="title">${l.title }</span>
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