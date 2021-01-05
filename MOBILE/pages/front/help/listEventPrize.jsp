<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<html>
<head>
<script type="text/javascript">
jQuery(function($){
    $("#wrap").addClass("mypage_main");
    $("#locNotice").addClass("active");
    
    $(".cont").find("*").css("max-width", "100%");
});

$('.tog_area a').click(function(){
    $('.tog_area a').removeClass('active');
    $(this).addClass('active');
});

function goList(page){
    location.replace("?page="+page);
}
</script>
</head>
<body>
<!-- content -->
<div class="customer mt17">
    <div class="tab_box">
        <a href="/m/help/listNotice">공지사항</a>
        <a href="/m/help/listEventPrize" class="active">이벤트당첨자</a>
    </div>
    <div class="bbs_box">
        <ul class="accordion mgt20">
            <c:forEach items="${list}" var="l" varStatus="st">
                <li>
                    <a href="javascript://"<c:if test="${param.eventId eq l.eventId}"> class="on"</c:if>>
                        <span>${l.eventTitle}</span>
                        <em><fmt:formatDate value="${l.regstDtm}" pattern="yyyy.MM.dd"/></em>
                    </a>
                    <div class="cont">
                        <div class="inner">
                            <h3>${l.eventTitle}</h3>
                            <br/>
                            ${l.prizeCont}
                        </div>
                    </div>
                </li>
            </c:forEach>
        </ul>
    </div>
    
    <!-- paging -->
    <div class="paging mb30">
        <ui:paginationScript name="pageHolder" scriptName="goList"/>
    </div>
    <!-- //paging -->
</div>
</body>
</html>
