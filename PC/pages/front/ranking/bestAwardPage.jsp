<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<html>
<head>
<style type="text/css">
.hide_util a + a {padding-left: 5px; margin-left: 5px; border-left: 1px solid #a3a3a3;}
</style>
</head>
<body>
<div class="welcom_top">
    <h2 class="title"><img src="${imageServer}/images/renewal/common/tit_hot_best.gif" alt="HOT BEST" /></h2>
    <span class="date"><ui:mask pattern="####.##.##">${c.todayStr}</ui:mask></span>
</div>
<div class="welcom_conts">
    <ul class="tab_cate02">
        <li<c:if test="${c.ctgrId eq '0000'}"> class="on"</c:if>><a href="/ht/welcome/hotAwardPage?dispMstrId=${c.dispMstrId}&ctgrId=0000">전체</a></li>
        <li<c:if test="${c.ctgrId eq '000020'}"> class="on"</c:if>><a href="/ht/welcome/hotAwardPage?dispMstrId=${c.dispMstrId}&ctgrId=000020">디자인문구</a></li>
        <li<c:if test="${c.ctgrId eq '000022'}"> class="on"</c:if>><a href="/ht/welcome/hotAwardPage?dispMstrId=${c.dispMstrId}&ctgrId=000022">디지털</a></li>
        <li<c:if test="${c.ctgrId eq '000007'}"> class="on"</c:if>><a href="/ht/welcome/hotAwardPage?dispMstrId=${c.dispMstrId}&ctgrId=000007">고급필기구</a></li>
        <li<c:if test="${c.ctgrId eq '000021'}"> class="on"</c:if>><a href="/ht/welcome/hotAwardPage?dispMstrId=${c.dispMstrId}&ctgrId=000021">오피스</a></li>
        <li<c:if test="${c.ctgrId eq '000025'}"> class="on"</c:if>><a href="/ht/welcome/hotAwardPage?dispMstrId=${c.dispMstrId}&ctgrId=000025">리빙/생활가전</a></li>
        <li<c:if test="${c.ctgrId eq '000026'}"> class="on"</c:if>><a href="/ht/welcome/hotAwardPage?dispMstrId=${c.dispMstrId}&ctgrId=000026">키친/푸드</a></li>
        <li<c:if test="${c.ctgrId eq '000024'}"> class="on"</c:if>><a href="/ht/welcome/hotAwardPage?dispMstrId=${c.dispMstrId}&ctgrId=000024">가구/수납</a></li>
        <li<c:if test="${c.ctgrId eq '000028'}"> class="on"</c:if>><a href="/ht/welcome/hotAwardPage?dispMstrId=${c.dispMstrId}&ctgrId=000028">패션잡화</a></li>
        <li<c:if test="${c.ctgrId eq '000006'}"> class="on"</c:if>><a href="/ht/welcome/hotAwardPage?dispMstrId=${c.dispMstrId}&ctgrId=000006">뷰티/헬스</a></li>
        <li<c:if test="${c.ctgrId eq '000027'}"> class="on"</c:if>><a href="/ht/welcome/hotAwardPage?dispMstrId=${c.dispMstrId}&ctgrId=000027">여행/자동차</a></li>
        <li<c:if test="${c.ctgrId eq '000023'}"> class="on"</c:if>><a href="/ht/welcome/hotAwardPage?dispMstrId=${c.dispMstrId}&ctgrId=000023">취미/펫</a></li>
        <li<c:if test="${c.ctgrId eq '000029'}"> class="on"</c:if>><a href="/ht/welcome/hotAwardPage?dispMstrId=${c.dispMstrId}&ctgrId=000029">유아동</a></li>
    </ul>
    <div class="prod_list_normal best">
        <c:forEach items="${list}" varStatus="s1" step="4" end="19">
            <ul><!-- 1 -->
                <c:forEach items="${list}" var="l" varStatus="st" begin="${s1.index}" end="${s1.index+3}">
                    <li>
                        <div class="rank">
                            <strong>${l.dispOrder}</strong>
                        </div>
                        <span class="img">
                            <a href="/ht/product/detail?barcode=${l.sellPrdtBcode}" title="${l.prdtName}"><ui:image src="${l.prdtImgUrl}" src2="${l.productImageUrl2}" size="200" server="product" alt="${fn:escapeXml(l.prdtName)}" style="width:180px;height:180px;"/></a>
                            <div class="hide_util">
                                <a href="javascript://" onclick="productPreview('${l.sellPrdtBcode}')" class="zoom"><span>확대</span></a>
                                <a href="/ht/product/detail?barcode=${l.sellPrdtBcode}" target="_blank" class="nblank"><span>새창</span></a>
                                <a href="javascript://" onclick="addWishProduct('${l.sellPrdtBcode}')" class="zzim"><span>좋아요</span></a>
                            </div>
                        </span>
                        <a href="/ht/product/detail?barcode=${l.sellPrdtBcode}">
                            <span class="make">${l.brandName}</span>
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
                                <c:if test="${l.basePrdtSellPrice > l.lastCpnPrice}"><span class="dc"><fmt:formatNumber value="${l.basePrdtSellPrice}" pattern="#,###"/></span></c:if>
                                <span class="sale"><fmt:formatNumber value="${l.lastCpnPrice}" pattern="#,###"/></span>
                                <c:if test="${l.prdtStatCode ne 'C0312'}"><span class="pc"><img src="${imageServer}/images/renewal/common/ic_status_soldout.gif" alt="품절"/></span></c:if>
                                <c:if test="${l.prdtStatCode eq 'C0312' && l.basePrdtSellPrice > l.lastCpnPrice}"><span class="pc">${hfn:rate(l.basePrdtSellPrice, l.lastCpnPrice)}%</span></c:if>
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