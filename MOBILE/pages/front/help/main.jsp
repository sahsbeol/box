<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<html>
<head>
<script type="text/javascript">
$(document).ready(function(){
    $("#wrap").addClass("mypage_v2");
    $("#locHelp").addClass("active");
    
    $(".cont").find("*").css("max-width", "100%");
});

$('.tog_area a').click(function(){
    $('.tog_area a').removeClass('active');
    $(this).addClass('active');
});
</script>
</head>
<body>
<!-- content -->
<div class="customer mt17">
    <div class="cstm_box">
        <a href="#" onclick="window.open('tel:1661-1112');return false;" class="tel">
            <span>1661-1112</span>
            <em>오전9시 ~ 오후6시 까지<br/>(주말/공휴일 제외)</em>
        </a>
        <a href="/m/help/listSosCounsel" class="sos">
            <span>1:1문의</span>
        </a>
    </div>
    
    <div class="bbs_box">
        <h4>공지사항</h4>
        <ul class="accordion">
            <c:forEach items="${listNotice}" var="l" varStatus="st">
                <li>
                    <a href="javascript://">
                        <span>${l.notiTitle}</span>
                        <em><fmt:formatDate value="${l.regstDtm}" pattern="yyyy.MM.dd"/></em>
                    </a>
                    <div class="cont">
                        <div class="inner">${l.notiCont}</div>
                    </div>
                </li>
            </c:forEach>
        </ul>
        <a href="/m/help/listNotice" class="btn_more">더보기</a>
    </div>
    
    <div class="bbs_box mt20">
        <h4>FAQ</h4>
        <ul class="accordion">
            <c:forEach items="${listFaq}" var="l" varStatus="st">
                <li>
                    <a href="javascript://">
                        <span>${l.faqTitle}</span>
                        <em><fmt:formatDate value="${l.regstDtm}" pattern="yyyy.MM.dd"/></em>
                    </a>
                    <div class="cont">
                        <div class="inner">${l.faqCont}</div>
                    </div>
                </li>
            </c:forEach>
        </ul>
        <a href="/m/help/listFaq" class="btn_more">더보기</a>
    </div>
</div>
</body>
</html>
