<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="welcome"/>
<html>
<head>
<style type="text/css">
span .best{
    background-image : url("htp://image.kyobobook.co.kr/newimages/giftshop_new/common/images/content/bg_best_cate.png");
    }
</style>
<script type="text/javascript">
jQuery(function($){
    $("#wrap").removeClass("mini");
    $("#2017DIARY").addClass("active");
    $("img.lazy").lazyload({placeholder:'/images/no_image2.gif',effect : "fadeIn"});
});
</script>
</head>
<body>
<div class="prod_box" style="margin-top:110px; position:relative;">
    <c:forEach items="${list}" var="l" varStatus="st">
        <a href="/p/${l.sellPrdtBcode}">
            <span class="best">BEST<strong>${st.index +1}</strong></span>
            <c:choose>
                <c:when test="${param.lazy eq 'Y' && st.index > 7}">
                    <c:choose>
                        <c:when test="${l.sellPrdtGbn eq 'R'}"><span class="pic"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="R" ratingCode="${l.rtngCode }" alt="${l.prdtName}" lazy="Y" clazz="lazy"/></span></c:when>
                        <c:when test="${l.sellPrdtGbn eq 'D'}"><span class="pic dvd"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="R" ratingCode="${l.rtngCode }" alt="${l.prdtName}" lazy="Y" clazz="lazy"/></span></c:when>
                        <c:otherwise>
                            <span class="pic"><ui:image src="${l.productImageUrl}" server="product" alt="${fn:escapeXml(l.prdtName)}" lazy="Y" clazz="lazy"/></span>
                        </c:otherwise>
                    </c:choose>
                </c:when>
                <c:otherwise>
                    <c:choose>
                        <c:when test="${l.sellPrdtGbn eq 'R'}"><span class="pic"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="R" ratingCode="${l.rtngCode }" alt="${l.prdtName}"/></span></c:when>
                        <c:when test="${l.sellPrdtGbn eq 'D'}"><span class="pic dvd"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="R" ratingCode="${l.rtngCode }" alt="${l.prdtName}"/></span></c:when>
                        <c:otherwise>
                            <span class="pic"><ui:image src="${l.productImageUrl}" server="product" alt="${fn:escapeXml(l.prdtName)}"/></span>
                        </c:otherwise>
                    </c:choose>
                </c:otherwise>
            </c:choose>
            <span class="txt_box">
                <em class="brand">${l.brandName}</em>
                <em class="tit">${fn:escapeXml(l.prdtName)}</em>
                <em class="price"><fmt:formatNumber type="number" value="${l.lastCpnPrice}"/>원</em>
                <c:if test="${l.prdtSellPrice ne l.lastCpnPrice}"><em class="sale">[<fmt:formatNumber type="number">${hfn:rate(l.prdtSellPrice, l.lastCpnPrice)}</fmt:formatNumber>%]</em></c:if>
            </span>
            <span class="ico_box">
                <c:set var="reviewCount" value="${l.reviewCount}"/>
                <c:set var="wishPrdtCnt" value="${l.wishPrdtCnt}"/>
                <c:if test="${l.reviewCount > 99}"><c:set var="reviewCount" value="99+"/></c:if>
                <c:if test="${l.wishPrdtCnt > 99}"><c:set var="wishPrdtCnt" value="99+"/></c:if>
                <c:if test="${l.reviewCount > 0}"><em class="ico_review">${reviewCount}</em></c:if>
                <c:if test="${l.wishPrdtCnt > 0}"><em class="ico_like">${wishPrdtCnt}</em></c:if>
            </span>
            <span class="bnf_box">
                <c:choose>
                    <c:when test="${l.prdtStatCode ne 'C0312'}"><em class="ico_soldout">품절</em></c:when>
                    <c:otherwise>
                        <c:if test="${fn:substring(l.prdtIcon,8,9) eq '1'}"><em class="ico_free">무료배송</em></c:if>
                        <c:if test="${fn:substring(l.prdtIcon,0,1) eq '1'}"><em class="ico_coupon">쿠폰</em></c:if>
                        <c:if test="${fn:substring(l.prdtIcon,2,3) eq '1'}"><em class="ico_gift">GIFT</em></c:if>
                        <c:if test="${l.dlvyVndrId eq '0625'}"><em class="ico_hottracks">핫트랙스배송</em></c:if>
                    </c:otherwise>
                </c:choose>
            </span>
        </a>
    </c:forEach>
</div>
<!-- //prod -->
</body>
</html>