<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<h4><img src="${imageServer}/images/search/prod_tit_01.gif" alt="추천상품" /></h4>
<div class="recommend_box">
    <ul class="search_prod_typeA">
        <c:forEach var="product" items="${listBest}" begin="0" end="4" varStatus="st">
            <li>
                <c:if test="${fn:substring(product.categoryId, 0 , 4) eq '0000' or fn:substring(product.categoryId, 0 , 4) eq '0001'}" >
                    <p class="prdt-photo">
                        <a href="/ht/product/${product.barcode}"><ui:image src="${product.productImageUrl}" alt="${product.productName}" server="product" size="150"/></a>
                    </p>
                    <p class="brand_name"><a href="/ht/product/${product.barcode}">[${product.brandName}]</a></p>
                    <p class="prod_name"><a href="/ht/product/${product.barcode}" title="${product.productName}"><ui:cut isStripHtml="true" limit="28" tail="..">${product.productName}</ui:cut></a></p>
                    <p class="prod_price">
                        <c:if test="${product.productSellPrice ne product.productPrice}">
                            <span class="prod_price1"><fmt:formatNumber value="${product.productSellPrice}" pattern="#,###"/>원</span>
                        </c:if>
                        <span class="prod_price2"><fmt:formatNumber value="${product.productPrice}" pattern="#,###"/>원</span>
                    </p>
                    <c:if test="${(hfn:rate(product.productSellPrice, product.productPrice) ne 0) || (product.prdtSavedRate ne 0)}">
                        <p class="prod_price">
                            <c:if test="${hfn:rate(product.productSellPrice, product.productPrice) ne 0}">
                                <span class="prod_sale">[<fmt:formatNumber pattern="#">${hfn:rate(product.productSellPrice, product.productPrice)}</fmt:formatNumber>%]</span>
                            </c:if>
                            <c:if test="${product.prdtSavedRate ne 0}">
                                <c:set var="savedPrice" value="${product.productPrice * product.prdtSavedRate / 100}"/>
                                <span class="prod_price3"><fmt:formatNumber value="${savedPrice+(10-(savedPrice%10))%10}" pattern=",###" />
                            </c:if>
                        </p>
                    </c:if>
                    <c:if test="${(fn:substring(product.icons,6,7) eq '1') || (fn:substring(product.icons,0,1) eq '1') || (fn:substring(product.icons,8,9) eq '1')}">
                        <p class="prod_icon">
                            <c:if test="${fn:substring(product.icons,6,7) eq '1'}"><span class="prod_icon"><img src="${imageServer}/images/search/ico_new.gif" alt="NEW"/></span></c:if>
                            <c:if test="${fn:substring(product.icons,0,1) eq '1'}"><span class="prod_icon"><img src="${imageServer}/images/search/ico_cupon.gif" alt="쿠폰"/></span></c:if>
                            <c:if test="${fn:substring(product.icons,8,9) eq '1'}"><span class="prod_icon"><img src="${imageServer}/images/search/ico_free.gif" alt="무료배송"/></span></c:if>
                        </p>
                    </c:if>
                </c:if>
                <c:if test="${fn:substring(product.categoryId, 0 , 4) eq '0003'}" >
                    <p class="prdt-photo">
                        <a href="/ht/product/${product.barcode}"><ui:image rcrdCd="${product.rcrdCd}" prdtGbn="R" ratingCode="${product.rtngCode}" width="150" alt="${product.brandName}" /></a>
                    </p>
                    <p class="brand_name"><a href="/ht/product/${product.barcode}">[${product.brandName}]</a></p>
                    <p class="prod_name"><a href="/ht/product/${product.barcode}" title="${product.productName}"><ui:cut isStripHtml="true" limit="28" tail="..">${product.productName}</ui:cut></a></p>
                    <p class="prod_price">
                        <c:if test="${product.productSellPrice ne product.productPrice}">
                            <span class="prod_price1"><fmt:formatNumber value="${product.productSellPrice}" pattern="#,###"/>원</span>
                        </c:if>
                        <span class="prod_price2"><fmt:formatNumber value="${product.productPrice}" pattern="#,###"/>원</span>
                    </p>
                    <c:if test="${(hfn:rate(product.productSellPrice, product.productPrice) ne 0)||(product.prdtSavedRate ne 0)}">
                        <p class="prod_price">
                            <c:if test="${hfn:rate(product.productSellPrice, product.productPrice) ne 0}">
                                <span class="prod_sale">[<fmt:formatNumber pattern="#">${hfn:rate(product.productSellPrice, product.productPrice)}</fmt:formatNumber>%]</span>
                            </c:if>
                            <c:if test="${product.prdtSavedRate ne 0}">
                                <c:set var="savedPrice" value="${product.productPrice * product.prdtSavedRate / 100}"/>
                                <span class="prod_price3"><fmt:formatNumber value="${savedPrice+(10-(savedPrice%10))%10}" pattern=",###" />
                            </c:if>
                        </p>
                    </c:if>
                    <c:if test="${(not empty product.impYn and product.impYn eq 'Y')||(not empty product.rcrdStat and product.rcrdStat eq '9')||(not empty product.freeDlvyYn and product.freeDlvyYn eq 'Y')}">
                        <p class="prod_icon">
                            <c:if test="${not empty product.impYn and product.impYn eq 'Y'}"><span class="prod_icon"><img src="${imageServer}/images/search/icon_import.gif" alt="수입"></span></c:if>
                            <c:if test="${not empty product.rcrdStat and product.rcrdStat eq '9'}"><span class="prod_icon"><img src="${imageServer}/images/search/ico_reserve.gif" alt="예약"></span></c:if>
                            <c:if test="${not empty product.freeDlvyYn and product.freeDlvyYn eq 'Y'}"><span class="prod_icon"><img src="${imageServer}/images/search/ico_free.gif" alt="무료배송"/></span></c:if>
                        </p>
                    </c:if>
                </c:if>
                <c:if test="${fn:substring(product.categoryId, 0 , 4) eq '0004'}" >
                    <p class="prdt-photo">
                        <a href="/ht/product/${product.barcode}"><ui:image rcrdCd="${product.rcrdCd}" prdtGbn="R" ratingCode="${product.rtngCode}" width="100" height="150" alt="${product.brandName}" /></a>
                    </p>
                    <p class="brand_name"><a href="/ht/product/${product.barcode}">[${product.brandName}]</a></p>
                    <p class="prod_name"><a href="/ht/product/${product.barcode}" title="${product.productName}"><ui:cut isStripHtml="true" limit="28" tail="..">${product.productName}</ui:cut></a></p>
                    <p class="prod_price">
                        <c:if test="${product.productSellPrice ne product.productPrice}">
                            <span class="prod_price1"><fmt:formatNumber value="${product.productSellPrice}" pattern="#,###"/>원</span>
                        </c:if>
                        <span class="prod_price2"><fmt:formatNumber value="${product.productPrice}" pattern="#,###"/>원</span>
                    </p>
                    <c:if test="${(hfn:rate(product.productSellPrice, product.productPrice) ne 0)||(product.prdtSavedRate ne 0)}">
                        <p class="prod_price">
                            <c:if test="${hfn:rate(product.productSellPrice, product.productPrice) ne 0}">
                                <span class="prod_sale">[<fmt:formatNumber pattern="#">${hfn:rate(product.productSellPrice, product.productPrice)}</fmt:formatNumber>%]</span>
                            </c:if>
                            <c:if test="${product.prdtSavedRate ne 0}">
                                <c:set var="savedPrice" value="${product.productPrice * product.prdtSavedRate / 100}"/>
                                <span class="prod_price3"><fmt:formatNumber value="${savedPrice+(10-(savedPrice%10))%10}" pattern=",###" />
                            </c:if>
                        </p>
                    </c:if>
                    <c:if test="${(not empty product.impYn and product.impYn eq 'Y')||(not empty product.rcrdStat and product.rcrdStat eq '9')||(not empty product.freeDlvyYn and product.freeDlvyYn eq 'Y')}">
                        <p class="prod_icon">
                            <c:if test="${not empty product.impYn and product.impYn eq 'Y'}"><span class="prod_icon"><img src="${imageServer}/images/search/icon_import.gif" alt="수입"></span></c:if>
                            <c:if test="${not empty product.rcrdStat and product.rcrdStat eq '9'}"><span class="prod_icon"><img src="${imageServer}/images/search/ico_reserve.gif" alt="예약"></span></c:if>
                            <c:if test="${not empty product.freeDlvyYn and product.freeDlvyYn eq 'Y'}"><span class="prod_icon"><img src="${imageServer}/images/search/ico_free.gif" alt="무료배송"/></span></c:if>
                        </p>
                    </c:if>
                </c:if>
            </li>
        </c:forEach>
    </ul>
</div>
<!-- //리스트 뷰 -->