<%@ page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<html>
<head>
<script type="text/javascript" src="/js/jquery_product.js"></script>
<script type="text/javascript" src="/scripts/mypage"></script>
<link rel="stylesheet" type="text/css" href="/css/layout_product.css" />
<link rel="stylesheet" type="text/css" href="/css/product_list.css" />
<link rel="stylesheet" type="text/css" href="/css/category.css" />
<script type="text/javascript">
jQuery(function($) {
    $("div.best-seller p.close a img").click(function() {
        $("div.best-seller").slideUp();
    });
});
</script>
</head>
<body>
<h3 class="title">${master[0].themeName}</h3>  
<div class="category-menu">
    <ul>
        <c:set var="fourDepthCtgrList" value=""/>
        <c:forEach items="${subListFull}" var="l" varStatus="st">
            <li<c:if test="${fn:startsWith(themeId, l.themeId)}"> class="selected"</c:if>>
                <span><a href="/ht/theme/${l.themeId}">${l.themeName}</a>[<fmt:formatNumber type="number">${l.productCnt}</fmt:formatNumber>]</span>
            </li>
        </c:forEach>
    </ul>
</div><!-- end category-menu -->
<div class="list-sort">
    <ul class="sort">
        <li class="first-child"><a href="?page=1&orderBy=&productListType=${c.productListType}&listSize=${c.listSize}"><img src="${imageServer}/images/common/text_sort01_${empty c.orderBy?'on':'off'}.gif" alt="전체보기" /></a></li>
        <li><a href="?page=1&orderBy=R&productListType=${c.productListType}&listSize=${c.listSize}"><img src="${imageServer}/images/common/text_sort02_${c.orderBy eq 'R'?'on':'off'}.gif" alt="최신순" /></a></li>
        <li><a href="?page=1&orderBy=P&productListType=${c.productListType}&listSize=${c.listSize}"><img src="${imageServer}/images/common/text_sort03_${c.orderBy eq 'P'?'on':'off'}.gif" alt="인기순" /></a></li>
        <li><a href="?page=1&orderBy=L&productListType=${c.productListType}&listSize=${c.listSize}"><img src="${imageServer}/images/common/text_sort04_${c.orderBy eq 'L'?'on':'off'}.gif" alt="낮은가격순" /></a></li>
        <li><a href="?page=1&orderBy=H&productListType=${c.productListType}&listSize=${c.listSize}"><img src="${imageServer}/images/common/text_sort05_${c.orderBy eq 'H'?'on':'off'}.gif" alt="높은가격순" /></a></li>
    </ul>
    <ul class="list-type">
        <li><a href="?page=1&productListType=A&orderBy=${c.orderBy}&listSize=${c.listSize}"><img src="${imageServer}/images/common/list_type01_${c.productListType eq 'A'?'on':'off'}.gif" alt="큰이미지로 보기" /></a></li>
        <li><a href="?page=1&productListType=B&orderBy=${c.orderBy}&listSize=${c.listSize}"><img src="${imageServer}/images/common/list_type02_${c.productListType eq 'B'?'on':'off'}.gif" alt="작은이미지로 보기" /></a></li>
        <li><a href="?page=1&productListType=C&orderBy=${c.orderBy}&listSize=${c.listSize}"><img src="${imageServer}/images/common/list_type03_${c.productListType eq 'C'?'on':'off'}.gif" alt="목록으로 보기" /></a></li>
    </ul>
    <div class="list-size">
        <p><a href="#list-size">상품수 ${c.listSize}개보기</a></p>
        <ul>
            <li><a href="?page=1&listSize=30&productListType=${c.productListType}&orderBy=${c.orderBy}">상품수 30개보기</a></li>
            <li><a href="?page=1&listSize=60&productListType=${c.productListType}&orderBy=${c.orderBy}">상품수 60개보기</a></li>
            <li><a href="?page=1&listSize=90&productListType=${c.productListType}&orderBy=${c.orderBy}">상품수 90개보기</a></li>
        </ul>
    </div><!-- end list-size -->
</div><!-- end list-sort -->
<div class="pager"><ui:pagination name="pageHolder" url="?" parameters="ctgrId,orderBy,productListType,listSize,listLine"/></div><!-- end pager -->
<div id="productList" style="margin-top:53px;">
<!-- 큰이미지로 보기 -->
<c:if test="${c.productListType eq 'A'}">
<div class="product-list01">
    <ul>
        <c:forEach items="${productList}" var="l" varStatus="st">
            <li>
                <p class="top">
                    <c:if test="${l.reviewCnt > 0}"><span><img src="${imageServer}/images/common/ico_review.gif"/>${l.reviewCnt}개</span></c:if>
                </p>
                <p class="photo"><a href="/ht/product/detail?barcode=${l.sellPrdtBcode}">
                    <ui:image src="${l.productImageUrl}" alt="${l.prdtName}" server="product" size="200"/>
                </a></p>
                <p class="category-name">[${l.brandName}]</p>
                <p class="product-name"><a href="/ht/product/detail?barcode=${l.sellPrdtBcode}" title="${l.prdtName}">${l.prdtName}</a></p>
                <c:set var="isDscntYn" value="N"/>
                <c:set var="isCpnYn" value="N"/>
                <c:if test="${l.prdtSellPrice ne l.lastDcPrice}"><c:set var="isDscntYn" value="Y"/></c:if>
                <c:if test="${l.prdtSellPrice ne l.lastCpnPrice && l.lastDcPrice ne l.lastCpnPrice}"><c:set var="isCpnYn" value="Y"/></c:if>
                <c:if test="${isDscntYn eq 'N' && isCpnYn eq 'N'}">
                    <p class="price"><strong><span><fmt:formatNumber value="${l.prdtSellPrice}" pattern=",###" /></span>원</strong></p>
                </c:if>
                <c:if test="${isDscntYn eq 'Y' && isCpnYn eq 'N'}">
                    <p class="origin-price"><span><fmt:formatNumber value="${l.prdtSellPrice}" pattern=",###"/>원</span><strong>[${l.lastDcRate}%]</strong></p>
                    <p class="price"><strong><span><fmt:formatNumber value="${l.lastDcPrice}" pattern=",###" /></span>원</strong></p>
                </c:if>
                <c:if test="${isDscntYn eq 'N' && isCpnYn eq 'Y'}">
                    <p class="origin-price"><span><fmt:formatNumber value="${l.prdtSellPrice}" pattern=",###"/>원</span></p>
                    <p class="price"><strong><span><fmt:formatNumber value="${l.lastCpnPrice}" pattern=",###" /></span>원</strong></p>
                </c:if>
                <c:if test="${isDscntYn eq 'Y' && isCpnYn eq 'Y'}">
                    <p class="origin-price"><span><fmt:formatNumber value="${l.prdtSellPrice}" pattern=",###"/>원</span><strong>[${l.lastDcRate}%]</strong></p>
                    <p class="price"><strong><span><fmt:formatNumber value="${l.lastCpnPrice}" pattern=",###" /></span>원</strong></p>
                </c:if>
                <p class="product-icon"><ui:icon location="T" icons="${l.icon}"/></p>
                <p class="delivery"><ui:icon location="B" icons="${l.icon}"/></p>
                <p class="zoom-cart-zzim">
                    <a href="javascript:productPreview('${l.sellPrdtBcode}', '0000');"><img src="${imageServer}/images/common/btn_product_zoom01.gif" alt="확대보기" /></a>
                    <a href="/ht/product/detail?barcode=${l.sellPrdtBcode}" target="_blank"><img src="${imageServer}/images/common/btn_product_cart01.gif" alt="새창열기" /></a>
                    <a href="javascript:addWishProduct('${l.sellPrdtBcode}');"><img src="${imageServer}/images/common/btn_product_zzim01.gif" alt="좋아요♥" /></a>
                </p>
            </li>
        </c:forEach>
    </ul>
</div><!-- end product-list01 -->
</c:if>
<c:if test="${c.productListType eq 'B'}">
<!-- 작은이미지로 보기 -->
<div class="product-list02">
    <ul>
        <c:forEach items="${productList}" var="l" varStatus="st">
            <li>
                <p class="top">
                    <c:if test="${l.reviewCnt > 0}"><span><img src="${imageServer}/images/common/ico_review.gif"/>${l.reviewCnt}개</span></c:if>
                </p>
                <p class="photo"><a href="/ht/product/detail?barcode=${l.sellPrdtBcode}">
                    <ui:image src="${l.productImageUrl}" alt="${l.prdtName}" server="product" size="120"/>
                </a></p>
                <p class="category-name">[${l.brandName}]</p>
                <p class="product-name"><a href="/ht/product/detail?barcode=${l.sellPrdtBcode}" title="${l.prdtName}">${l.prdtName}</a></p>
                <c:set var="isDscntYn" value="N"/>
                <c:set var="isCpnYn" value="N"/>
                <c:if test="${l.prdtSellPrice ne l.lastDcPrice}"><c:set var="isDscntYn" value="Y"/></c:if>
                <c:if test="${l.prdtSellPrice ne l.lastCpnPrice && l.lastDcPrice ne l.lastCpnPrice}"><c:set var="isCpnYn" value="Y"/></c:if>
                <c:if test="${isDscntYn eq 'N' && isCpnYn eq 'N'}">
                    <p class="price"><strong><span><fmt:formatNumber value="${l.prdtSellPrice}" pattern=",###" /></span>원</strong></p>
                </c:if>
                <c:if test="${isDscntYn eq 'Y' && isCpnYn eq 'N'}">
                    <p class="origin-price"><span><fmt:formatNumber value="${l.prdtSellPrice}" pattern=",###"/>원</span><strong>[${l.lastDcRate}%]</strong></p>
                    <p class="price"><strong><span><fmt:formatNumber value="${l.lastDcPrice}" pattern=",###" /></span>원</strong></p>
                </c:if>
                <c:if test="${isDscntYn eq 'N' && isCpnYn eq 'Y'}">
                    <p class="origin-price"><span><fmt:formatNumber value="${l.prdtSellPrice}" pattern=",###"/>원</span></p>
                    <p class="price"><strong><span><fmt:formatNumber value="${l.lastCpnPrice}" pattern=",###" /></span>원</strong></p>
                </c:if>
                <c:if test="${isDscntYn eq 'Y' && isCpnYn eq 'Y'}">
                    <p class="origin-price"><span><fmt:formatNumber value="${l.prdtSellPrice}" pattern=",###"/>원</span><strong>[${l.lastDcRate}%]</strong></p>
                    <p class="price"><strong><span><fmt:formatNumber value="${l.lastCpnPrice}" pattern=",###" /></span>원</strong></p>
                </c:if>
                <p class="product-icon"><ui:icon location="T" icons="${l.icon}"/></p>
                <p class="delivery"><ui:icon location="B" icons="${l.icon}"/></p>
                <p class="zoom-cart-zzim">
                    <a href="javascript:productPreview('${l.sellPrdtBcode}', '00');"><img src="${imageServer}/images/common/btn_product_zoom02.gif" alt="확대보기" /></a>
                    <a href="/ht/product/detail?barcode=${l.sellPrdtBcode}" target="_blank"><img src="${imageServer}/images/common/btn_product_cart02.gif" alt="새창열기" /></a>
                    <a href="javascript:addWishProduct('${l.sellPrdtBcode}');"><img src="${imageServer}/images/common/btn_product_zzim02.gif" alt="좋아요♥" /></a>
                </p>
            </li>
        </c:forEach>
    </ul>
</div><!-- end product-list02 -->
</c:if>
<c:if test="${c.productListType eq 'C'}">
<!-- 목록으로 보기 -->
<div class="product-list03">
    <table summary="상품목록">
        <caption>상품목록</caption>
        <thead>
            <tr>
                <th scope="col" class="product-name">상품명</th>
                <th scope="col" class="price">가격</th>
                <th scope="col" class="delivery">배송</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${productList}" var="l" varStatus="st">
                <tr<c:if test="${st.first}"> class="first-child"</c:if>>
                    <td class="product">
                        <p class="photo"><a href="/ht/product/detail?barcode=${l.sellPrdtBcode}">
                            <ui:image src="${l.productImageUrl}" alt="${l.prdtName}" server="product" size="85"/>
                        </a></p>
                        <p class="product-name">
                            <a href="/ht/product/detail?barcode=${l.sellPrdtBcode}">[${l.brandName}] ${l.prdtName}</a>
                        </p>
                        <p class="discount">(<fmt:formatNumber value="${l.lastDcRate}"/>% 할인)/ + ${l.prdtSavedPrice+(10-(l.prdtSavedPrice%10))%10}원 (${l.prdtSavedRate}% 적립)</p>
                        <p class="product-icon">
                            <ui:icon location="T" icons="${l.icon}"/>
                            <c:if test="${l.reviewCnt > 0}"><span><img src="${imageServer}/images/common/ico_review.gif"/>${l.reviewCnt}개</span></c:if>
                        </p>
                        <p class="zoom-cart-zzim">
                            <a href="javascript:productPreview('${l.sellPrdtBcode}', '0000');"><img src="${imageServer}/images/common/btn_product_zoom03.gif" alt="확대보기" /></a>
                            <a href="/ht/product/detail?barcode=${l.sellPrdtBcode}" target="_blank"><img src="${imageServer}/images/common/btn_product_cart03.gif" alt="새창열기" /></a>
                            <a href="javascript:addWishProduct('${l.sellPrdtBcode}');"><img src="${imageServer}/images/common/btn_product_zzim03.gif" alt="좋아요♥" /></a>
                        </p>
                    </td>
                    <td class="price">
                        <c:set var="isDscntYn" value="N"/>
                        <c:set var="isCpnYn" value="N"/>
                        <c:if test="${l.prdtSellPrice ne l.lastDcPrice}"><c:set var="isDscntYn" value="Y"/></c:if>
                        <c:if test="${l.prdtSellPrice ne l.lastCpnPrice && l.lastDcPrice ne l.lastCpnPrice}"><c:set var="isCpnYn" value="Y"/></c:if>
                        <c:if test="${isDscntYn eq 'N' && isCpnYn eq 'N'}">
                            <p><strong><span><fmt:formatNumber value="${l.prdtSellPrice}" pattern=",###" /></span>원</strong></p>
                        </c:if>
                        <c:if test="${isDscntYn eq 'Y' && isCpnYn eq 'N'}">
                            <p class="origin-price"><span><fmt:formatNumber value="${l.prdtSellPrice}" pattern=",###"/>원</span><strong>[${l.lastDcRate}%]</strong></p>
                            <p><strong><span><fmt:formatNumber value="${l.lastDcPrice}" pattern=",###" /></span>원</strong></p>
                        </c:if>
                        <c:if test="${isDscntYn eq 'N' && isCpnYn eq 'Y'}">
                            <p class="origin-price"><span><fmt:formatNumber value="${l.prdtSellPrice}" pattern=",###"/>원</span></p>
                            <p><strong><span><fmt:formatNumber value="${l.lastCpnPrice}" pattern=",###" /></span>원</strong></p>
                        </c:if>
                        <c:if test="${isDscntYn eq 'Y' && isCpnYn eq 'Y'}">
                            <p class="origin-price"><span><fmt:formatNumber value="${l.prdtSellPrice}" pattern=",###"/>원</span><strong>[${l.lastDcRate}%]</strong></p>
                            <p><strong><span><fmt:formatNumber value="${l.lastCpnPrice}" pattern=",###" /></span>원</strong></p>
                        </c:if>
                    </td>
                    <td class="delivery"><ui:icon location="B" icons="${l.icon}" blankOrNewline="N"/></td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div><!-- end product-list03 -->
</c:if>
<div class="pager"><ui:pagination name="pageHolder" url="?" parameters="ctgrId,orderBy,productListType,listSize,listLine"/></div><!-- end pager -->
<c:if test="${empty productList}">
   <div class="no-result"><img src="${imageServer}/images/common/no_result.gif" alt="상품이 존재하지 않습니다" /></div>
</c:if>
</div>
</body>
</html>