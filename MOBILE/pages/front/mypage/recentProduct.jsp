<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<html>
<head>
<title>최근본상품 | MY HOTTRACKS - HOTTRACKS</title>
<script type="text/javascript">
function goList(page){
    location.href="?page="+page;
}
jQuery(function($){
    $("#wrap").addClass("mypage_v0");
});
</script>
<style>
.swiper-slide {width: auto;}
</style>
</head>
<body>
<!-- .nav -->
<div class="nav gray">
    <ul class="swiper-wrapper">
        <li class="swiper-slide"><a href="/">HOME</a></li>
        <li class="swiper-slide"><a href="/m/mypage/main">My Hottracks</a></li>
        <li class="swiper-slide"><a href="/m/mypage/recentProduct">최근본상품</a></li>
    </ul>
</div>
<!-- //.nav -->
<!-- prod -->
<div class="prod_basic03">
    <c:if test="${empty list}">
        <script>$("body").addClass("bg_gray");</script>
        <div class="roundbox mt10">
            <ul class="br_list">
                <li class="br_none"><strong>최근 본 상품 목록이 존재하지 않습니다.</strong></li>
            </ul>
        </div>
    </c:if>
    <c:if test="${not empty list}">
    <ul id="productList">
        <c:forEach items="${list}" var="l" varStatus="st">
            <li>
                <div>
                    <c:if test="${l.sellPrdtGbn ne 'R' && l.sellPrdtGbn ne 'D'}"><p class="pic"><ui:image src="${l.productImageUrl}" server="product" size="150" /></p></c:if>
                    <c:if test="${l.sellPrdtGbn eq 'R'}"><p class="pic"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="R" ratingCode="A" alt="${l.prdtName}"/></p></c:if>
                    <c:if test="${l.sellPrdtGbn eq 'D'}"><p class="pic dvd"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="D" ratingCode="A" alt="${l.prdtName}"/></p></c:if>
                    <p class="brand t_l"><a href="/p/${l.sellPrdtBcode}">${fn:escapeXml(l.brandEngName)}</a></p>
                    <p class="tit t_l"><a href="/p/${l.sellPrdtBcode}">${fn:escapeXml(l.prdtName)}</a></p>
                    <p class="price t_l">
                        <fmt:formatNumber type="number">${l.lastCpnPrice}</fmt:formatNumber>원
                        <c:if test="${l.prdtSellPrice>l.lastCpnPrice}"><em class="sale">[<fmt:formatNumber type="number">${hfn:rate(l.prdtSellPrice,l.lastCpnPrice)}</fmt:formatNumber>%]</em></c:if>
                    </p>
                    <p class="btn_area"><a href="javascript://" onclick="addWishProduct('${l.sellPrdtBcode}', '${fn:escapeXml(l.prdtName)}')" class="btn br_ff6600">찜하기</a></p>
                </div>
            </li>
        </c:forEach>
    </ul>
    </c:if>
</div>
</body>
</html>