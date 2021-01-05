<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="hot" />
<html>
<head>
<script type="text/javascript">
jQuery(function($){
    //$("#loading").hidden();
    $("#wrap").addClass("mini");
    $("img.lazy").lazyload({placeholder:'/images/no_image2.gif',effect : "fadeIn"});
});
var rank = 3;
var validPage = true;
function moreBrand(){
    if($(".txt_sel_box dd").hasClass("active")){
        $(".txt_sel_box dd").removeClass();
        $(".txt_sel_box .btn_more").text("+ 더보기");
    }else{
        $(".txt_sel_box dd").addClass("active");
        $(".txt_sel_box .btn_more").text("- 더보기");
    }
}
function goList(page){
    location.replace("?ctgrId=${c.ctgrId}&dlvyVndrId=${c.dlvyVndrId}&brandId=${l.brandId}&productOrderBy=${c.productOrderBy}&page="+page);
}

</script>
</head>
<body>
<div class="nav gray">
    <ul class="swiper-wrapper">
        <li class="swiper-slide"><a href="/">HOME</a></li>
        <li class="swiper-slide"><a href="/m/delivery/main?dlvyVndrId=${c.dlvyVndrId}">묶음 배송 상품</a></li>
    </ul>
</div>
<div class="gray_box" style="margin-top:-3px;">
    <hr class="hr_01"/>
    <c:if test="${c.dlvyVndrId eq '0625' && not empty listBrand}">
        <div class="txt_sel_box bg_white">
            <dl>
                <dt><a href="/m/delivery/main">전체(<fmt:formatNumber type="number"> ${listBrand[0].total2} </fmt:formatNumber>)</a></dt>
                <dd>
                    <c:forEach items="${listBrand}" var="l" varStatus="st" end="20">
                        <a href="/m/delivery/main?dlvyVndrId=${c.dlvyVndrId}&brandId=${l.brandId}&productOrderBy=${c.productOrderBy}">${l.brandName} (<fmt:formatNumber type="number">${l.total}</fmt:formatNumber>)</a>
                    </c:forEach>
                </dd>
            </dl>
            <a class="btn btn_type02 bg_orange btn_more" href="#" onclick="moreBrand();return false;">+ 더보기</a>
        </div>
        <hr class="hr_01"/>
    </c:if>
    <div class="option_box t_select">
        <div class="select_box">
            <c:forEach items="${listCategory}" var="l" varStatus="st">
                <c:if test="${c.ctgrId eq l.ctgrId}"><p>${l.ctgrName} (<fmt:formatNumber type="number">${l.prdtCnt}</fmt:formatNumber>)</c:if>
            </c:forEach>
            <div class="option_box">
                <dl>
                    <c:forEach items="${listCategory}" var="l" varStatus="st">
                        <dd><a href="/m/delivery/main?dlvyVndrId=${c.dlvyVndrId}&brandId=${c.brandId}&productOrderBy=${c.productOrderBy}&ctgrId=${l.ctgrId}"<c:if test="${(empty c.ctgrId && fn:trim(l.ctgrId) eq '') || c.ctgrId eq l.ctgrId}"> class="active"</c:if>>${l.ctgrName} (<fmt:formatNumber type="number">${l.prdtCnt}</fmt:formatNumber>)</a></dd>
                    </c:forEach>
                </dl>
            </div>
        </div>
        <div class="select_box">
            <c:if test="${c.productOrderBy eq 'R'}"><p>신상품순</p></c:if>
            <c:if test="${c.productOrderBy eq 'W'}"><p>좋아요♥순</p></c:if>
            <c:if test="${c.productOrderBy eq 'C'}"><p>후기순</p></c:if>
            <c:if test="${c.productOrderBy eq 'T'}"><p>할인율순</p></c:if>
            <c:if test="${c.productOrderBy eq 'L'}"><p>낮은가격순</p></c:if>
            <c:if test="${c.productOrderBy eq 'H'}"><p>높은가격순</p></c:if>
            <c:if test="${c.productOrderBy eq 'P'}"><p>인기상품순</p></c:if>
            <div class="option_box">
                <dl>
                    <dd><a href="/m/delivery/main?dlvyVndrId=${c.dlvyVndrId}&brandId=${c.brandId}&ctgrId=${c.ctgrId}&productOrderBy=R"<c:if test="${c.productOrderBy eq 'R'}"> class="active"</c:if>>신상품순</a></dd>
                    <dd><a href="/m/delivery/main?dlvyVndrId=${c.dlvyVndrId}&brandId=${c.brandId}&ctgrId=${c.ctgrId}&productOrderBy=W"<c:if test="${c.productOrderBy eq 'W'}"> class="active"</c:if>>좋아요♥순</a></dd>
                    <dd><a href="/m/delivery/main?dlvyVndrId=${c.dlvyVndrId}&brandId=${c.brandId}&ctgrId=${c.ctgrId}&productOrderBy=C"<c:if test="${c.productOrderBy eq 'C'}"> class="active"</c:if>>후기순</a></dd>
                    <dd><a href="/m/delivery/main?dlvyVndrId=${c.dlvyVndrId}&brandId=${c.brandId}&ctgrId=${c.ctgrId}&productOrderBy=T"<c:if test="${c.productOrderBy eq 'T'}"> class="active"</c:if>>할인율순</a></dd>
                    <dd><a href="/m/delivery/main?dlvyVndrId=${c.dlvyVndrId}&brandId=${c.brandId}&ctgrId=${c.ctgrId}&productOrderBy=L"<c:if test="${c.productOrderBy eq 'L'}"> class="active"</c:if>>낮은가격순</a></dd>
                    <dd><a href="/m/delivery/main?dlvyVndrId=${c.dlvyVndrId}&brandId=${c.brandId}&ctgrId=${c.ctgrId}&productOrderBy=H"<c:if test="${c.productOrderBy eq 'H'}"> class="active"</c:if>>높은가격순</a></dd>
                    <dd><a href="/m/delivery/main?dlvyVndrId=${c.dlvyVndrId}&brandId=${c.brandId}&ctgrId=${c.ctgrId}&productOrderBy=P"<c:if test="${c.productOrderBy eq 'P'}"> class="active"</c:if>>인기상품순</a></dd>
                </dl>
            </div>
        </div>
    </div>
    <hr class="hr_01"/>
</div>

<!-- prod -->
<c:import url="../template/layerProduct.jsp" charEncoding="UTF-8">
    <c:param name="best" value="N"/>
    <c:param name="lazy" value="Y"/>
</c:import>
<!-- //prod -->

<div class="paging mb30">
    <ui:paginationScript name="pageHolder" scriptName="goList"/>
</div>
</body>
</html>