<%@ page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="welcome"/>
<html>
<head>
<script type="text/javascript">
jQuery(function($){
    $("#wrap").removeClass("mini");
    $("#2017DIARY").addClass("active");
});

/* function goPage(){
    $("#loading").show();
    if(isNaN(page))    page = 1;
    page++;
    $.ajax({
        type: "GET"
       ,url: "/m/diary/layerEventDiary?page="+page
       ,dataType: "html"
       ,success : function(htmlStr){
           $("#eventList").append(htmlStr);
           $("#loading").hide();
       }
       ,error: function(data) {
           alert('<fmt:message key="error.common.system"/>');
           $("#loading").hide();
       }
   }); 
}  */
function goPage(page){
    location.replace("?page="+page);
}
</script>
</head>
<body>
<div id="content">
<img alt="Diary Event" style="margin-top:10px; " src="${imageServer}/images/2015Diary/diaryevent.gif">
    <div class="banner_basic02">
    <ul class="eventList" style="background:url('http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/renewal/shop/bg_orders_carousel.gif') no-repeat 0px top;padding-top:23px;">
        <c:forEach items="${listEvent}" var="l" varStatus="st">
            <li style="min-height:250px;">
                <a href="/m/biz/eventDetail?eventId=${l.eventId}">
                    <p class="pic_full"><ui:image src="${l.imageUrl}" alt="${l.eventTitle}" /></p>
                    <p class="tit t_l"><strong>${fn:escapeXml(l.eventTitle)}</strong></p>
                    <p class="txt t_l">${fn:escapeXml(l.eventDtlCont)}</p>
                </a>
            </li>
        </c:forEach>
    </ul>
    <!-- paging -->
    <div class="paging"><ui:paginationScript name="pageHolder" scriptName="goPage"/></div>
    <!-- //paging -->
    </div>
</div>
</body>
</html>