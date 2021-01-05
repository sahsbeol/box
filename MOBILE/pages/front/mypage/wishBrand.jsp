<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<html>
<head>
<title>찜상품 | 마이핫트랙스 - 뉴미핫트랙스</title>
<script type="text/javascript">
jQuery(function($){
    $("#wrap").addClass("mypage_v2");
    $("#locWish").addClass("active");
});

function goList(page){
    location.href="?page="+page;
}
</script>
</head>
<body>
<!-- prod -->
<div class="prod_basic04">
    <c:if test="${empty list}">
        <script>$("body").addClass("bg_gray");</script>
        <div class="roundbox mt10">
            <ul class="br_list">
                <li class="br_none"><strong>찜하신 상품 목록이 존재하지 않습니다.</strong></li>
            </ul>
        </div>
    </c:if>
    <c:if test="${not empty list}">
    <ul id="productList">
        <c:forEach items="${list}" varStatus="s1" step="2">
            <li>
                <c:forEach items="${list}" var="l" varStatus="st" begin="${s1.index}" end="${s1.index+1}">
                    <div style="width:48%;margin-right:2%;text-align:center;position:relative;">
                        <a href="/m/hot/brandDetail?brandId=${l.brandId}">
                            <p class="brand">${l.brandEngName}</p>
                            <p class="pic"><ui:image src="${l.productImageUrl}" server="product" alt="${fn:escapeXml(l.brandEngName)}" /></p>
                        </a>
                        <a href="javascript:removeWishBrand2('${l.brandId}', '${l.brandEngName}');" class="delete">X</a>
                    </div>
                </c:forEach>
            </li>
        </c:forEach>
    </ul>
    </c:if>
</div>
<!-- paging -->
<div class="paging mb30">
    <ui:paginationScript name="pageHolder" scriptName="goList"/>
</div>
<!-- //paging -->
</body>
</html>