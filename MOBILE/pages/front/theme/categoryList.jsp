<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="gift"/>
<html>
<head>
<script type="text/javascript">
jQuery(function($){
    $("img.lazy").lazyload({placeholder:'/images/no_image2.gif',effect : "fadeIn"});
});

function goList(page){
    location.href="?productOrderBy=${c.productOrderBy}&page="+page;
}
</script>
</head>
<body>
<!-- .nav -->
<div class="nav gray">
    <ul class="swiper-wrapper">
        <li class="swiper-slide"><a href="/">HOME</a></li>
        <li class="swiper-slide"><a href="/m/theme/category/${parntCategory.ctgrId}">${parntCategory.ctgrName}</a></li>
        <li class="swiper-slide"><a href="/m/theme/category/${c.themeCtgrId}">${category.ctgrName}</a></li>
    </ul>
</div>
<!-- //.nav -->
<div class="gray_box">
    <hr class="hr_01"/>
    <c:if test="${not empty listBest && not empty listSale && not empty listWish}">
        <div class="gift_best roundbox">
            <ul class="tab_basic tab_btn"><!-- tab produnt -->
                <li><a href="#prod01" class="on"><span>BEST</span></a></li>
                <li><a href="#prod02"><span>SALE</span></a></li>
                <li><a href="#prod03"><span><em class="like">좋아요</em></span></a></li>
            </ul>
            <c:forEach begin="0" end="2" varStatus="s1">
                <c:if test="${s1.index eq 0}"><c:set var="listm" value="${listBest}"/></c:if>
                <c:if test="${s1.index eq 1}"><c:set var="listm" value="${listSale}"/></c:if>
                <c:if test="${s1.index eq 2}"><c:set var="listm" value="${listWish}"/></c:if>
                <div id="prod0${s1.count}" class="prod_basic02 tab_cont"><!--  banner type01 col2-->
                    <ul>
                        <c:forEach items="${listm}" var="l" end="2">
                            <li>
                                <a href="/p/${l.sellPrdtBcode}">
                                    <p class="pic"><ui:image src="${l.prdtImgUrl}" server="product" alt="${fn:escapeXml(l.prdtName)}"/></p>
                                    <p class="tit">${fn:escapeXml(l.prdtName)}</p>
                                    <p class="price">
                                        <fmt:formatNumber type="number">${l.lastCpnPrice}</fmt:formatNumber>원
                                        <c:if test="${l.prdtSellPrice>l.lastCpnPrice}"><span class="sale">[<fmt:formatNumber type="number">${hfn:rate(l.prdtSellPrice,l.lastCpnPrice)}</fmt:formatNumber>%]</span></c:if>
                                    </p>
                                </a>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </c:forEach>
        </div>
        <hr class="hr_01 mt20"/>
    </c:if>
    <!-- 정렬 -->
    <div class="box_flex t_select">
        <select class="select" name="productOrderBy" title="정렬 순서 선택" onchange="location.href='/m/theme/category/${themeCtgrId}?productOrderBy='+this.value;">
            <option value="R"<c:if test="${c.productOrderBy eq 'R'}"> selected="selected"</c:if>>신상품순</option>
            <option value="P"<c:if test="${c.productOrderBy eq 'P'}"> selected="selected"</c:if>>인기상품순</option>
            <option value="L"<c:if test="${c.productOrderBy eq 'L'}"> selected="selected"</c:if>>낮은가격순</option>
            <option value="H"<c:if test="${c.productOrderBy eq 'H'}"> selected="selected"</c:if>>높은가격순</option>
            <option value="T"<c:if test="${c.productOrderBy eq 'T'}"> selected="selected"</c:if>>높은할인율순</option>
        </select>
        <select class="select" name="productCategory" title="분류 선택" onchange="location.href='/m/theme/category/'+this.value+'?productOrderBy=${c.productOrderBy}';">
            <option value="${parntCategory.ctgrId}">전체 상품</option>
            <c:forEach items="${childCategory}" var="l" varStatus="st">
                <option value="${l.ctgrId}"<c:if test="${l.ctgrId eq c.themeCtgrId}"> selected="selected"</c:if>>${l.ctgrName}</option>
            </c:forEach>
        </select>
    </div>
    <!-- //정렬 -->
</div>
<!-- prod -->
<div class="prod_basic">
    <ul id="productList">
        <c:forEach items="${list}" varStatus="s1" step="2">
            <li>
                <c:forEach items="${list}" var="l" varStatus="st" begin="${s1.index}" end="${s1.index+1}">
                    <div style="width:46%;margin-right:4%;text-align:center;">
                        <a href="/m/gift/detail/${l.sellPrdtBcode}">
                            <c:if test="${s1.index < 4}"><p class="pic"><ui:image src="${l.productImageUrl}" server="product" alt="${fn:escapeXml(l.prdtName)}"/></p></c:if>
                            <c:if test="${s1.index > 3}"><p class="pic"><ui:image src="${l.productImageUrl}" server="product" alt="${fn:escapeXml(l.prdtName)}" lazy="Y" clazz="lazy"/></p></c:if>
                            <p class="brand t_l">${l.brandEngName}</p>
                            <p class="tit t_l">${fn:escapeXml(l.prdtName)}</p>
                            <p class="price t_l"><strong><fmt:formatNumber type="number" value="${l.lastCpnPrice}"/>원 <c:if test="${l.prdtSellPrice ne l.lastCpnPrice}"><span class="sale">[<fmt:formatNumber type="number">${hfn:rate(l.prdtSellPrice, l.lastCpnPrice)}</fmt:formatNumber>%]</span></c:if></strong></p>
                        </a>
                    </div>
                </c:forEach>
            </li>
        </c:forEach>
    </ul>
</div>
<!-- //prod -->
<!-- paging -->
<div class="paging mb30">
    <ui:paginationScript name="pageHolder" scriptName="goList"/>
</div>
<!-- //paging -->
</body>
</html>