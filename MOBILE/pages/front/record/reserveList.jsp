<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<html>
<head>
<script type="text/javascript">
function goList(page){
    location.href="?ctgrId=${c.ctgrId}&productOrderBy=${c.productOrderBy}&page="+page;
}
</script>
</head>
<body>
<!-- .nav -->
<div class="nav gray">
    <c:set var="ctgrNavi" value="${fn:split(fn:replace(category.ctgrNamePath, ' ', ''), '>')}"/>
    <ul class="swiper-wrapper">
        <li class="swiper-slide"><a href="/">HOME</a></li>
        <c:if test="${fn:startsWith(ctgrId, '0003')}">
            <li class="swiper-slide"><a href="/m/recordMain">CD</a></li>
        </c:if>
        <c:if test="${fn:startsWith(ctgrId, '0004')}">
            <li class="swiper-slide"><a href="/m/dvdMain">DVD</a></li>
        </c:if>
        <li class="swiper-slide"><a href="/m/record/reserve/${ctgrId}">예약 ${category.ctgrName}</a></li>
    </ul>
</div>
<!-- //.nav -->
<div class="gray_box">
    <hr class="hr_01"/>
    <!-- 정렬 -->
    <div class="box_flex t_select">
        <select class="select" name="productOrderBy" title="정렬 순서 선택" onchange="location.href='/m/record/reserve/${ctgrId}?ctgrId=${c.ctgrId}&productOrderBy='+this.value;">
            <option value="R"<c:if test="${c.productOrderBy eq 'R'}"> selected="selected"</c:if>>신상품순</option>
            <option value="P"<c:if test="${c.productOrderBy eq 'P'}"> selected="selected"</c:if>>인기상품순</option>
            <option value="L"<c:if test="${c.productOrderBy eq 'L'}"> selected="selected"</c:if>>낮은가격순</option>
            <option value="H"<c:if test="${c.productOrderBy eq 'H'}"> selected="selected"</c:if>>높은가격순</option>
            <option value="T"<c:if test="${c.productOrderBy eq 'T'}"> selected="selected"</c:if>>높은할인율순</option>
        </select>
        <select class="select" name="productCategory" title="분류 선택" onchange="location.href='/m/record/reserve/${ctgrId}?ctgrId='+this.value+'&productOrderBy=${c.productOrderBy}';">
            <option value="${ctgrId}">전체 상품</option>
            <c:forEach items="${childCategory}" var="l" varStatus="st">
                <option value="${l.ctgrId}"<c:if test="${l.ctgrId eq c.ctgrId}"> selected="selected"</c:if>>${l.ctgrName}</option>
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
                        <a href="/m/record/detail/${l.sellPrdtBcode}">
                            <p class="pic<c:if test="${l.sellPrdtGbn eq 'D'}"> dvd</c:if>"><ui:image prdtGbn="${l.sellPrdtGbn}" rcrdCd="${l.rcrdCd}" ratingCode="${l.rtngCode}" alt="${fn:escapeXml(l.prdtName)}"/></p>
                            <p class="brand t_l">${l.artiName}</p>
                            <p class="tit t_l">${fn:escapeXml(l.prdtName)}</p>
                            <p class="price t_l"><strong>${l.lastCpnPrice}원 <c:if test="${l.prdtSellPrice ne l.lastCpnPrice}"><span class="sale">[<fmt:formatNumber type="number">${hfn:rate(l.prdtSellPrice, l.lastCpnPrice)}</fmt:formatNumber>%]</span></c:if></strong></p>
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