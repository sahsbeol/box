<%@ page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="diary"/>
<html>
<head>
<script type="text/javascript">
<!-- 
//-->
</script>
</head>
<body>
<div class="welcom_top">
    <h2 class="title"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/diary/2018/calendar-icon.jpg" alt="DIARY BEST 20" /></h2>
    <span class="date"><ui:mask pattern="####.##.##">${c.todayStr}</ui:mask></span>
</div>
<div class="welcom_conts">
    <div class="prod_list_normal best">
        <c:forEach items="${list}" varStatus="s1" step="4" end="19">
            <ul><!-- 1 -->
                <c:forEach items="${list}" var="l" varStatus="st" begin="${s1.index}" end="${s1.index+3}">
                    <li>
                        <div class="rank">
                            <strong>${l.dispOrder}</strong>
                        </div>
                        <span class="img">
                            <a href="/ht/product/detail?barcode=${l.sellPrdtBcode}" title="${l.prdtName}"><ui:image src="${l.prdtImgUrl}" size="200" server="product" alt="${l.prdtName}" style="width:180px;height:180px;"/></a>
                            <div class="hide_util">
                                <a href="javascript://" onclick="productPreview('${l.sellPrdtBcode}')" class="zoom"><span>확대</span></a>
                                <a href="/ht/product/detail?barcode=${l.sellPrdtBcode}" target="_blank" class="nblank"><span>새창</span></a>
                                <a href="javascript://" onclick="addWishProduct('${l.sellPrdtBcode}')" class="zzim"><span>좋아요</span></a>
                            </div>
                        </span>
                        <a href="/ht/product/detail?barcode=${l.sellPrdtBcode}">
                            <span class="make">${l.brandEngName}</span>
                            <span class="name">${l.prdtName}</span>
                            <span class="icon">
                                <c:set var="reviewCount" value="${l.reviewCount}"/>
                                <c:set var="wishPrdtCnt" value="${l.wishPrdtCnt}"/>
                                <c:if test="${l.reviewCount > 99}"><c:set var="reviewCount" value="99+"/></c:if>
                                <c:if test="${l.wishPrdtCnt > 99}"><c:set var="wishPrdtCnt" value="99+"/></c:if>
                                <c:if test="${fn:substring(l.prdtIcon,8,9) eq '1'}"><em class="ico_free">무료배송</em></c:if>
                                <c:if test="${fn:substring(l.prdtIcon,0,1) eq '1'}"><em class="ico_coupon">쿠폰</em></c:if>
                                <c:if test="${fn:substring(l.prdtIcon,2,3) eq '1'}"><em class="ico_gift">GIFT</em></c:if>
                                <c:if test="${l.wishPrdtCnt > 0}"><em class="ico_like">${wishPrdtCnt}</em></c:if>
                                <c:if test="${l.reviewCount > 0}"><em class="ico_review">${reviewCount}</em></c:if>
                                </span>
                            <em class="price">
                                <c:if test="${l.basePrdtSellPrice > l.lastCpnPrice}"><span class="dc"><fmt:formatNumber type="number">${l.basePrdtSellPrice}</fmt:formatNumber></span></c:if>
                                <span class="sale"><fmt:formatNumber type="number">${l.lastCpnPrice}</fmt:formatNumber></span>
                                <c:if test="${l.basePrdtSellPrice > l.lastCpnPrice}"><span class="pc">${hfn:rate(l.basePrdtSellPrice,l.lastCpnPrice)}%</span></c:if>
                            </em>
                        </a>
                    </li>
                </c:forEach>
            </ul>
        </c:forEach>
    </div><!-- //.prod_list_normal -->
</div><!-- //.welcom_conts -->
</body>
</html>