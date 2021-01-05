<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="layer"/>
<html>
<head>
<script type="text/javascript">
$(document).ready(function(){
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
<!-- tit_section -->
<div id="ly_header">
    <h1>FAQ</h1>
</div>
<!-- //tit_section -->

<!-- content -->
<div id="ly_content" class="customer">
    
    <h2 class="tit_type1">※ FAQ</h2>
    <p>핫트랙스에서 고객 여러분께 자주묻는 질문의 답변을 드립니다.</p>
    <ul class="accordion mgt20">
        <c:forEach items="${list}" var="l" varStatus="st">
            <li>
                <a href="javascript://">
                    <span class="question">Question</span>
                    <strong>${l.faqTitle}</strong>
                </a>
                <div class="cont">
                    <strong class="answer">answer</strong>
                    <div class="inner">${l.faqCont}</div>
                </div>
            </li>
        </c:forEach>
    </ul>
    
    <!-- paging -->
    <div class="paging mb30">
        <ui:paginationScript name="pageHolder" scriptName="goList"/>
    </div>
    <!-- //paging -->
    
    <a href="javascript:history.back();" class="btn_cls">닫기</a>
    </div>
</body>
</html>
