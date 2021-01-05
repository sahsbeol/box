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
<div class="box_flex t_select" style="margin-top:50px;">
</div>
<div class="prod_basic" style="margin-top:46px">
    <ul>
        <c:forEach items="${list}" varStatus="s1" step="2">
            <li>
                <c:forEach items="${list}" var="l" varStatus="st" begin="${s1.index}" end="${s1.index+1}">
                    <div style="width:46%;margin-left:3%;text-align:center;">
                        <a href="/p/${l.sellPrdtBcode}" title="${l.prdtName}">
                            <span class="best">BEST<strong>${l.dispOrder}</strong></span>
                            <c:if test="${s1.index < 4}"><p class="pic"><ui:image src="${l.productImageUrl}" server="product" alt="${fn:escapeXml(l.prdtName)}"/></p></c:if>
                            <c:if test="${s1.index > 3}"><p class="pic"><ui:image src="${l.productImageUrl}" server="product" alt="${fn:escapeXml(l.prdtName)}" lazy="Y" clazz="lazy"/></p></c:if>
                            <p class="brand t_l">${l.brandName}</p>
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
</body>
</html>