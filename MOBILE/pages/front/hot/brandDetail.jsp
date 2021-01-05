<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<html>
<head>
<!--  SNS 공유 내용 -->
<meta property="og:type" content="website"/>
<meta property="og:title" content="${brand.brandEngName}"/>
<meta property="og:url" content="${defaultHost}/ht/hot/brandDetail?brandId=${brand.brandId}"/>
<meta property="og:image" content="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/renewal/common/logo_over.gif"/>
<!--  SNS 공유 내용 -->
<style type="text/css">
.like_img{ position: fixed; top: 35%; z-index: 999; overflow: initial; width: 100%; text-align: center; left :0px;}
</style>
<script type="text/javascript">
jQuery(function($){
    $("img.lazy").lazyload({placeholder:'/images/no_image2.gif',effect : "fadeIn"});
    
    $(".like_img").show();
});
function goList(page){
    location.href="?brandId=${c.brandId}&ctgrId=${c.ctgrId}&productOrderBy=${c.productOrderBy}&page="+page;
}
</script>
</head>
<body>
<c:choose>
    <c:when test="${empty list}">
        <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/renewal/common/logo_over.gif" alt="NEW ME HOTTRACKS" class="sns_img kakao-img" style="display:none;"/>
    </c:when>
    <c:otherwise>
        <c:forEach items="${list}" var="l" end="0">
            <ui:image src="${l.productImageUrl}" server="product" alt="${fn:escapeXml(l.prdtName)}" clazz="sns_img kakao-img" style="display:none;"/></span>
        </c:forEach>
    </c:otherwise>
</c:choose>
<!-- .nav -->
<div class="nav gray" style="margin-top: -11px;">
    <ul class="swiper-wrapper">
        <li class="swiper-slide"><a href="/">HOME</a></li>
        <li class="swiper-slide"><a href="/m/hot/brandDetail?brandId=${c.brandId}">${brand.brandEngName}</a></li>
    </ul>
</div>
<!-- //.nav -->
<div class="brand_box">
    <p class="title"><strong class="col_orange">${brand.brandEngName}</strong> (${brand.brandName})</p>
    <p class="cont">${brand.brandDesc}</p>
    <div class="sns">
        <a href="javascript:goTwitter('${fn:escapeXml(brand.brandEngName)}', 'http://m.hottracks.co.kr/m/hot/brandDetail?brandId=${brand.brandId}')" class="twitter">트위터</a>
        <a href="javascript:goFaceBook('${fn:escapeXml(brand.brandEngName)}', 'http://m.hottracks.co.kr/m/hot/brandDetail?brandId=${brand.brandId}')" class="facebook">페이스북</a>
        <a href="javascript:sendKakao('[핫트랙스] ${fn:escapeXml(brand.brandEngName)}', 'http://m.hottracks.co.kr/m/hot/brandDetail?brandId=${brand.brandId}');" class="kakao">카카오톡</a>
        <div class="like_img"></div>
        <c:if test="${brand.wishUserBrandCnt eq '0'}"><!-- 내가 클릭한 경우가 없으면 -->
            <a href="#" onclick="addWishBrand('${brand.brandId}', '${fn:escapeXml(brand.brandEngName)}');return false;" class="like" title="브랜드 좋아요하기">좋아요<img src="/images/content/btn_like_off.png" title="좋아요" /></a>
        </c:if>
        <c:if test="${brand.wishUserBrandCnt ne '0'}"><!-- 내가 클릭한 경우가 있으면 -->
            <a href="#" onclick="removeWishBrand('${brand.brandId}', '${fn:escapeXml(brand.brandEngName)}');return false;" class="like" title="브랜드 좋아요하기">좋아요<img src="/images/content/ico_like.png" title="좋아요"  /></a>
        </c:if>
    </div>
</div>
<c:if test="${not empty eventList}">
<div class="brand_evt_box">
    <hr class="hr_01"/>
    <p class="title"><strong>Brand</strong> Event</p>
    <c:forEach items="${eventList}" var="l" end="1">
        <a href="/m/biz/eventDetail?eventId=${l.eventId}" class="cont">${l.eventTitle}</a>
    </c:forEach>
    
</div>
</c:if>
<div class="gray_box">
    <hr class="hr_01"/>
    <!-- 정렬 -->
    <div class="box_flex t_select">
        <select class="select" name="productOrderBy" title="정렬 순서 선택" onchange="location.href='/m/hot/brandDetail?brandId=${c.brandId}&ctgrId=${c.ctgrId}&productOrderBy='+this.value;">
            <option value="R"<c:if test="${c.productOrderBy eq 'R'}"> selected="selected"</c:if>>신상품순</option>
            <option value="W"<c:if test="${c.productOrderBy eq 'W'}"> selected="selected"</c:if>>좋아요♥순</option>
            <option value="C"<c:if test="${c.productOrderBy eq 'C'}"> selected="selected"</c:if>>후기순</option>
            <option value="P"<c:if test="${c.productOrderBy eq 'P'}"> selected="selected"</c:if>>인기상품순</option>
            <option value="L"<c:if test="${c.productOrderBy eq 'L'}"> selected="selected"</c:if>>낮은가격순</option>
            <option value="H"<c:if test="${c.productOrderBy eq 'H'}"> selected="selected"</c:if>>높은가격순</option>
            <option value="T"<c:if test="${c.productOrderBy eq 'T'}"> selected="selected"</c:if>>높은할인율순</option>
        </select>
        <select class="select" name="ctgrId" title="상품 분류 선택" onchange="location.href='/m/hot/brandDetail?brandId=${c.brandId}&productOrderBy=${c.productOrderBy}&ctgrId='+this.value;">
            <option value="">전체상품</option>
            <c:forEach items="${listCateogry}" var="l" varStatus="st">
                <option value="${l.ctgrId}"<c:if test="${c.ctgrId eq l.ctgrId}"> selected="selected"</c:if>>${l.ctgrName}</option>
            </c:forEach>
        </select>
    </div>
    <!-- //정렬 -->
</div>

<!-- prod -->
<c:import url="../template/layerProduct.jsp" charEncoding="UTF-8">
    <c:param name="best" value="N"/>
    <c:param name="lazy" value="Y"/>
</c:import>
<!-- //prod -->

<!-- paging -->
<div class="paging mb50">
    <ui:paginationScript name="pageHolder" scriptName="goList"/>
</div>
<!-- //paging -->
</body>
</html>