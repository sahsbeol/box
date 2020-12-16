<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
<title>${criteria.wishGbn eq 'P'?'좋아요♥상품 ':'좋아요♥브랜드'}| 쇼핑리스트 | MY HOTTRACKS - HOTTRACKS</title>
<script type="text/javascript">
function delWishProduct(barcode) {
    if(!confirm("정말 삭제하시겠습니까?")) {
        return;
    }
    
    $.ajax({
        type: "GET"
        ,url: "/ht/mypage/removeWishProduct"
        ,data: {barcode : barcode}
        ,dataType: "json"
        ,success : function(data){
            if (data) {
                if (data.save) {
                    alert('<fmt:message key="message.delete.success"/>');
                    window.location.reload();
                } else {
                    alert(data.errorMessages);
                }
            }
        }
    });
}
function deleteWishBrand(brandId) {
    if(!confirm("정말 삭제하시겠습니까?")) {
        return;
    }
    
    $.ajax({
        type: "GET"
        ,url: "/ht/mypage/deleteWishBrand"
        ,data: {brandId : brandId}
        ,dataType: "json"
        ,success : function(data){
            if (data) {
                if (data.save) {
                    alert('<fmt:message key="message.delete.success"/>');
                    window.location.reload();
                } else {
                    alert(data.errorMessages);
                }
            }
        }
    });
}

</script>
</head>
<body>
<!-- sub top -->
<div class="page_location">
    <h2 class="title"><img src="${imageServer}/images/renewal/common/tit_my_hottracks.gif" alt="My Hottracks"/></h2>
    <div class="loc"><a href="/" class="home">Home</a><em>MY HOTTRACKS</em></div>
</div>
<!-- //sub top -->

<c:import url="/menu/mypage/lnb"/>
<script type="text/javascript">
jQuery(function($){
	$(document).ready(function(){
		if('${criteria.wishGbn}' == 'P')
			$("div.lnb ul li.listWishProduct").addClass("active");
		else
			$("div.lnb ul li.listWishBrand").addClass("active");
	});
});
</script>

<!-- sub contents -->
<div class="sub_contents">
    
    <h3 class="page_title mgt0"><img src="${imageServer}/images/renewal/common/tit_list_wish_product.gif" alt="좋아요♥하기 내역보기" /></h3>
    <ul class="list_type02">
        <c:if test="${criteria.wishGbn eq 'P'}">
            <li>고객님께서 선택하신 '좋아요'은 보관기간에 제한이 없이 영구보존 됩니다.</li>
            <li>더 이상 '좋아요'를 원치않는 상품은 개별 삭제를 해주시기 바랍니다.</li>
        </c:if>
        <c:if test="${criteria.wishGbn eq 'B'}">
            <li>고객님께서 선택하신 '좋아요'브랜드는 보관기간에 제한이 없이 영구보존 됩니다.</li>
            <li>더 이상 '좋아요'를 원치않는 브랜드는 개별 삭제를 해주시기 바랍니다.</li>
        </c:if>
    </ul>

    <div class="box_gray mgt40">
        <c:if test="${criteria.wishGbn eq 'P'}"><div class="wish_product">좋아요♥ 상품 <span><fmt:formatNumber type="number">${wishProductCount}</fmt:formatNumber></span>건</div></c:if>
        <c:if test="${criteria.wishGbn eq 'B'}"><div class="wish_product">좋아요♥ 브랜드 <span><fmt:formatNumber type="number">${wishBrandCount}</fmt:formatNumber></span>건</div></c:if>
        
    </div>

    <c:if test="${criteria.wishGbn eq 'P'}">
        <c:forEach items="${wishProducts}" varStatus="s1" step="4">
            <ul class="wish_list">
                <c:forEach items="${wishProducts}" var="l" varStatus="st" begin="${s1.index}" end="${s1.index+3}">
                    <li>
                        <c:if test="${fn:contains('DR', l.sellPrdtGbn) }"><a href="/ht/record/detail/${l.barcode}" class="photo" title="${l.productName}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn }" width="200" ratingCode="${l.rtngCode}" alt="${l.productName}"/></a></c:if>
                        <c:if test="${!fn:contains('DR', l.sellPrdtGbn) }"><a href="/p/${l.barcode}" class="photo<c:if test="${l.sellPrdtGbn eq 'D'}"> dvd</c:if>" title="${l.productName}"><ui:image src="${l.productImageUrl}" src2="${l.productImageUrl2}" server="product" size="200" alt="${l.productName}"/></a></c:if>
                        <a href="/p/${l.barcode}" class="make">${l.brandEngName}</a>
                        <a href="/p/${l.barcode}" class="name">${l.productName}</a>
                        <em class="price">
                            <c:if test="${l.prdtSellPrice > l.lastCpnPrice}"><span class="dc"><fmt:formatNumber value="${l.prdtSellPrice}" pattern="#,###"/></span></c:if>
                            <span class="sale"><fmt:formatNumber value="${l.lastCpnPrice}" pattern="#,###"/></span>
                            <c:if test="${l.prdtStatCode ne 'C0312'}"><span class="pc"><img src="${imageServer}/images/renewal/common/ic_status_soldout.gif" alt="품절"/></span></c:if>
                            <c:if test="${l.prdtStatCode eq 'C0312' && l.prdtSellPrice > l.lastCpnPrice}">
                            <fmt:parseNumber var="rate" integerOnly="true" value="${(l.prdtSellPrice - l.lastCpnPrice) / l.prdtSellPrice * 100}"/>
                            <span class="pc">${rate}%</span>
                            </c:if>
                        </em>
                        <div class="del_btn"><a href="javascript://" class="btn_type02" onclick="delWishProduct('${l.barcode}')">삭제</a></div>
                    </li>
                </c:forEach>
            </ul>
        </c:forEach>
    </c:if>
    <c:if test="${criteria.wishGbn eq 'B'}">
        <c:forEach items="${wishProducts}" varStatus="s1" step="4">
            <ul class="wish_blist">
                <c:forEach items="${wishProducts}" var="l" varStatus="st" begin="${s1.index}" end="${s1.index+3}">
                    <li>
                        <a href="/ht/hot/brandDetail?brandId=${l.brandId}" class="make">${l.brandEngName}</a>
                        <a href="/ht/hot/brandDetail?brandId=${l.brandId}" class="photo"><ui:image src="${l.productImageUrl}" src2="${l.productImageUrl2}" server="product" size="200" alt="${l.brandEngName}"/></a>
                        <div class="del_btn"><a href="javascript://" class="btn_type02" onclick="deleteWishBrand('${l.brandId}')">삭제</a></div>
                    </li>
                </c:forEach>
            </ul>
        </c:forEach>
    </c:if>
    <!-- paging -->
    <div class="paging"><ui:pagination name="pageHolder" url="?"/></div>
    <!-- //paging -->
</div>
<!-- //sub contents -->
</body>
</html>