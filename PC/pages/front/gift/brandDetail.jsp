<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<html>
<head>
<!--  SNS 공유 내용 -->
<meta property="og:type" content="website"/>
<meta property="og:title" content="${brand.brandEngName}"/>
<meta property="og:url" content="${defaultHost}/ht/hot/brandDetail?brandId=${brand.brandId}"/>
<meta property="og:image" content="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/renewal/common/logo_over.gif"/>
<!--  SNS 공유 내용 -->
<script type="text/javascript">
jQuery(function($){
    $("img.lazy").lazyload({placeholder:'/images/no_image2.gif',threshold:200});
    $(".paging a").click(function(e){
        e.preventDefault();
        location.href = $(this).attr("href") + "#cateProductList";
    });
});
</script>
</head>
<body>
<!-- brand_all_wrap -->
    <div class="brand_all_wrap">
        <%-- <a href="/ht/hot/brandMain" class="btn_brand"><img src="${imageServer}/images/renewal/common/btn_brand_all.gif" alt="전체보기"></a> --%>
        <div class="brand_info">
            <strong class="brand_name">
                ${brand.brandEngName}
                <c:if test="${not empty brand.brandName}">
                    <span class="lang_ko">(${brand.brandName})</span>
                </c:if>
            </strong>
            <span class="brand_comt">${brand.brandSmry}</span>
        </div>
        <div class="brand_sns">
            <a href="javascript://" onclick="goTwitter('${brand.brandName}', '${defaultHost}/ht/hot/brandDetail?brandId=${brand.brandId}')"><img src="${imageServer}/images/renewal/common/ico_sns_twitter.png" alt="twitter"/></a>
            <a href="javascript://" onclick="goFaceBook('${brand.brandName}', '${defaultHost}/ht/hot/brandDetail?brandId=${brand.brandId}')"><img src="${imageServer}/images/renewal/common/ico_sns_facebook.png" alt="facebook"/></a>
            <a href="javascript://" onclick="goPinterest('${brand.brandName}', '${defaultHost}/ht/hot/brandDetail?brandId=${brand.brandId}')"><img src="${imageServer}/images/renewal/common/ico_sns_pinterest.png" alt="pinterest" style="width:28px;height:28px;" nopin="true"/></a>
            <c:if test="${brand.wishUserBrandCnt eq '0'}">
                <a href="javascript://" onclick="addWishBrand('${brand.brandId}')" class="btn_wish">좋아요<img class="wish_img" src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/renewal/content/ico_like_off.png" /><fmt:formatNumber type="number">${brand.wishBrandCnt}</fmt:formatNumber></a>
            </c:if>
            <c:if test="${brand.wishUserBrandCnt ne '0'}">
                <a href="javascript://" onclick="removeWishBrand('${brand.brandId}', '${brand.brandName }' );" class="btn_wish">좋아요<img class="wish_img" src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/renewal/content/ico_like.png" /><fmt:formatNumber type="number">${brand.wishBrandCnt}</fmt:formatNumber></a>
            </c:if>
        </div>
        <c:if test="${not empty eventList}">
            <div class="brand_event">
                <h4>Brand Event</h4>
                <c:forEach items="${eventList}" var="l" varStatus="st" end="0">
                    <p><a href="/ht/biz/eventDetail?eventId=${l.eventId}">${l.eventTitle}</a></p>
                </c:forEach>
            </div>
        </c:if>
    </div>
<!-- //brand_all_wrap -->
<%--
<c:if test="${not empty noticeList}">
    <!-- brand_notice -->
    <div class="brand_notice">
        <strong>NOTICE</strong>
        <ul>
            <c:forEach items="${noticeList}" var="l">
                <li><a href="/ht/help/listNotice?brandOrCategory=B&brandId=${brand.brandId}&notiSeq=${l.notiSeq}">${l.cuttedTitle}</a></li>
            </c:forEach>
        </ul>
        <a href="/ht/help/listNotice?brandOrCategory=B&brandId=${brand.brandId}" class="more"><img src="${imageServer}/images/renewal/common/btn_brand_notice_more.gif" alt="전체보기"></a>
    </div>
    <!-- //brand_notice -->
</c:if>
--%>
<c:if test="${not empty listBestProduct}">
    <!-- best_pr_wrap -->
    <div class="prod_list_normal brand_best_wrap">
        <ul>
            <c:forEach items="${listBestProduct}" var="l" varStatus="st" end="2">
                <li>
                    <a href="/ht/product/detail?barcode=${l.sellPrdtBcode}" title="${l.prdtName}">
                        <p class="text_best">BEST <ui:lpad length="2" padChar="0">${st.count}</ui:lpad></p>
                        <span class="img"><ui:image src="${l.productImageUrl}" src2="${l.productImageUrl2}" size="400" server="product" alt="${fn:escapeXml(l.prdtName)}" ratingCode="${l.nyoSellBanYn}" style="width:290px;height:290px;"/></span>
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
                            <c:if test="${l.prdtSellPrice > l.lastCpnPrice}"><span class="dc"><fmt:formatNumber value="${l.prdtSellPrice}" pattern="#,###"/></span></c:if>
                            <span class="sale"><fmt:formatNumber value="${l.lastCpnPrice}" pattern="#,###"/></span>
                            <c:if test="${l.prdtStatCode ne 'C0312'}"><span class="pc"><img src="${imageServer}/images/renewal/common/ic_status_soldout.gif" alt="품절"/></span></c:if>
                            <c:if test="${l.prdtStatCode eq 'C0312' && l.prdtSellPrice > l.lastCpnPrice}"><span class="pc">${hfn:rate(l.prdtSellPrice, l.lastCpnPrice)}%</span></c:if>
                        </em>
                    </a>
                </li>
            </c:forEach>
        </ul>
    </div>
    <!-- //best_pr_wrap -->
</c:if>
<!-- brand_pr_list -->
<div class="brand_pr_list mgt40" id="productList">
    <div class="brand_category">
        <ul>
            <c:forEach items="${listPrdtCntByCtgr}" var="l">
                <li<c:if test="${c.ctgrId eq l.ctgrId || (c.ctgrId eq '00'&& empty l.ctgrId)}"> class="active"</c:if>>
                    <a href="?brandId=${brand.brandId}&page=1&productOrderBy=${c.productOrderBy}&productListType=${c.productListType}&listSize=${c.listSize}&ctgrId=${l.ctgrId}#productList">${l.ctgrName}(<span><fmt:formatNumber value="${l.productCnt}" type="number"/></span>)</a>
                </li>
            </c:forEach>
        </ul>
    </div>
    <div class="search_sort_tab04 mgt50" id="cateProductList">
        <div id="ulSort" class="f_left">
            <a href="?brandId=${brand.brandId}&ctgrId=${c.ctgrId}&page=1&productOrderBy=P&productListType=${c.productListType}&listSize=${c.listSize}#productList" class="${c.productOrderBy eq 'P'?'active':''}">인기상품순</a>
            <a href="?brandId=${brand.brandId}&ctgrId=${c.ctgrId}&page=1&productOrderBy=R&productListType=${c.productListType}&listSize=${c.listSize}#productList" class="${c.productOrderBy eq 'R'?'active':''}">신상품순</a>
            <a href="?brandId=${brand.brandId}&ctgrId=${c.ctgrId}&page=1&productOrderBy=L&productListType=${c.productListType}&listSize=${c.listSize}#productList" class="${c.productOrderBy eq 'L'?'active':''}">낮은가격순</a>
            <a href="?brandId=${brand.brandId}&ctgrId=${c.ctgrId}&page=1&productOrderBy=H&productListType=${c.productListType}&listSize=${c.listSize}#productList" class="${c.productOrderBy eq 'H'?'active':''}">높은가격순</a>
            <a href="?brandId=${brand.brandId}&ctgrId=${c.ctgrId}&page=1&productOrderBy=T&productListType=${c.productListType}&listSize=${c.listSize}#productList" class="${c.productOrderBy eq 'T'?'active':''}">높은할인율순</a>
            <a href="?brandId=${brand.brandId}&ctgrId=${c.ctgrId}&page=1&productOrderBy=W&productListType=${c.productListType}&listSize=${c.listSize}#productList" class="${c.productOrderBy eq 'W'?'active':''}">좋아요♥</a>
            <a href="?brandId=${brand.brandId}&ctgrId=${c.ctgrId}&page=1&productOrderBy=Q&productListType=${c.productListType}&listSize=${c.listSize}#productList" class="${c.productOrderBy eq 'Q'?'active':''}">상품평</a>
        </div>
        <div class="btn_l">
           <c:set var="baseLink" value="?brandId=${brand.brandId}&ctgrId=${c.ctgrId}&page=1&productOrderBy=${c.productOrderBy}&listSize=${c.listSize}&saleYn=${c.saleYn}"/>
           <select class="select" id="ulBenefitGbn" style="margin-left:3px;" onchange="location.href='${baseLink}&benefitGbn='+this.value+'#cateProductList';return false;">
                <option value="">전체상품</option>
                <option value="H"<c:if test="${c.benefitGbn eq 'H'}"> selected="selected"</c:if>>핫트랙스배송</option>
                <option value="N"<c:if test="${c.benefitGbn eq 'N'}"> selected="selected"</c:if>>무료배송</option>
                <option value="A"<c:if test="${c.benefitGbn eq 'A'}"> selected="selected"</c:if>>무료+핫트랙스배송</option>
            </select>
            <c:set var="baseLink" value="?brandId=${brand.brandId}&ctgrId=${c.ctgrId}&page=1&productOrderBy=${c.productOrderBy}&listSize=${c.listSize}&benefitGbn=${c.benefitGbn}"/>
            <select class="select" id="ulSaleYn" style="margin-left:3px;" onchange="location.href='${baseLink}&saleYn='+this.value+'#cateProductList';return false;">
                <option value="N"<c:if test="${c.saleYn eq 'N' || empty c.saleYn}"> selected="selected"</c:if>>품절포함</option>
                <option value="Y"<c:if test="${c.saleYn eq 'Y'}"> selected="selected"</c:if>>품절제외</option>
            </select>
            <c:set var="baseLink" value="?brandId=${brand.brandId}&ctgrId=${c.ctgrId}&page=1&productOrderBy=${c.productOrderBy}&benefitGbn=${c.benefitGbn}&saleYn=${c.saleYn}"/>
            <select class="select" id="ulListSize" style="margin-left:3px;" onchange="location.href='${baseLink}&listSize='+this.value+'#cateProductList';return false;">
                <option value="40"<c:if test="${c.listSize eq '40'}"> selected="selected"</c:if>>40개</option>
                <option value="80"<c:if test="${c.listSize eq '80'}"> selected="selected"</c:if>>80개</option>
                <option value="120"<c:if test="${c.listSize eq '120'}"> selected="selected"</c:if>>120개</option>
            </select>
        </div>
    </div>
    <c:if test="${empty listProduct }">
       <div class="t_center mgt25 mgb25"><img src="${imageServer}/images/common/no_result.gif" alt="상품이 존재하지 않습니다" /></div>
    </c:if>
    <div class="prod_list_normal">
        <c:forEach items="${listProduct}" varStatus="s1" step="4">
            <ul>
                <c:forEach items="${listProduct}" var="l" varStatus="st" begin="${s1.index}" end="${s1.index+3}">
                    <li>
                        <span class="img">
                            <c:if test="${s1.index < 4}"><a href="/ht/product/detail?barcode=${l.sellPrdtBcode}&ctgrId=${c.ctgrId}"><ui:image src="${l.productImageUrl}" src2="${l.productImageUrl2}" alt="${fn:escapeXml(l.prdtName)}" server="product" ratingCode="${l.nyoSellBanYn}" size="200"/></a></c:if>
                            <c:if test="${s1.index > 3}"><a href="/ht/product/detail?barcode=${l.sellPrdtBcode}&ctgrId=${c.ctgrId}"><ui:image src="${l.productImageUrl}" src2="${l.productImageUrl2}" alt="${fn:escapeXml(l.prdtName)}" server="product" ratingCode="${l.nyoSellBanYn}" size="200" lazy="Y" clazz="lazy"/></a></c:if>
                            <div class="hide_util">
                                <a href="javascript://" onclick="productPreview('${l.sellPrdtBcode}')" class="zoom"><span>확대</span></a>
                                <a href="/ht/product/detail?barcode=${l.sellPrdtBcode}" target="_blank" class="nblank"><span>새창</span></a>
                                <a href="javascript://" onclick="addWishProduct('${l.sellPrdtBcode}')"class="zzim"><span>좋아요</span></a>
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
                                <c:if test="${l.prdtSellPrice > l.lastCpnPrice}"><span class="dc"><fmt:formatNumber value="${l.prdtSellPrice}" pattern="#,###"/></span></c:if>
                                <span class="sale"><fmt:formatNumber value="${l.lastCpnPrice}" pattern="#,###"/></span>
                                <c:if test="${l.prdtStatCode ne 'C0312'}"><span class="pc"><img src="${imageServer}/images/renewal/common/ic_status_soldout.gif" alt="품절"/></span></c:if>
                                <c:if test="${l.prdtStatCode eq 'C0312' && l.prdtSellPrice > l.lastCpnPrice}"><span class="pc">${hfn:rate(l.prdtSellPrice, l.lastCpnPrice)}%</span></c:if>
                            </em>
                        </a>
                    </li>
                </c:forEach>
            </ul>
        </c:forEach>
    </div>
    <div class="paging"><ui:pagination name="pageHolder" url="?" parameters="brandId,ctgrId,productOrderBy,productListType,listSize,listLine,saleYn"/></div>
</div>
<!-- brand_pr_list -->
</body>
</html>