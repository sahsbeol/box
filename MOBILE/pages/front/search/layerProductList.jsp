<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="none"/>
    <!-- prod -->
    <div class="prod_basic">
        <ul id="productList">
            <c:forEach items="${listProduct}" varStatus="s1" step="2">
                <li>
                    <c:forEach items="${listProduct}" var="l" varStatus="st" begin="${s1.index}" end="${s1.index+1}">
                        <div style="width:46%;margin-right:4%;">
                        <c:if test="${fn:startsWith(l.categoryId, '0000')}">
                            <a href="/m/gift/detail/${l.productBarcode}">
                                <p class="pic"><ui:image src="${l.productImageUrl}" server="product" alt="${fn:escapeXml(l.productName)}"/></p>
                                <p class="brand">${l.brandName}</p>
                                <p class="tit">${l.productName}</p>
                                <p class="price">
                                    <strong>
                                    <fmt:formatNumber value="${l.productDcPrice}" pattern=",###" />원
                                    <c:if test="${l.productPrice > l.productDcPrice}"> <span class="sale">[${hfn:rate(l.productPrice, l.productDcPrice)}%]</span></c:if>
                                    </strong>
                                </p>
                            </a>
                        </c:if>
                        <c:if test="${fn:startsWith(l.categoryId, '0003')}">
                            <a href="/m/record/detail/${l.sell_prdt_bcode}">
                                <p class="pic"><ui:image rcrdCd="${l.rcrd_cd}" prdtGbn="R" ratingCode="${l.rtngCode }" alt="${fn:escapeXml(l.rcrd_name)}"/></p>
                                <p class="brand">${l.label_name}</p>
                                <p class="tit">${l.rcrd_name}</p>
                                <p class="price">
                                    <strong>
                                    <fmt:formatNumber value="${l.fc_get_dc_price}" pattern=",###" />원
                                    <c:if test="${l.prdt_sell_price > l.fc_get_dc_price}"> <span class="sale">[${hfn:rate(l.prdt_sell_price, l.fc_get_dc_price)}%]</span></c:if>
                                    </strong>
                                </P>
                            </a>
                        </c:if>
                        <c:if test="${fn:startsWith(l.categoryId, '0004')}">
                            <a href="/m/record/detail/${l.sell_prdt_bcode}">
                                <p class="pic dvd"><ui:image rcrdCd="${l.rcrd_cd}" prdtGbn="D" ratingCode="${l.rtngCode }" alt="${fn:escapeXml(l.rcrd_name)}"/></p>
                                <p class="brand">D${l.label_name}</p>
                                <p class="tit">${l.rcrd_name}</p>
                                <p class="price">
                                    <strong>
                                    <fmt:formatNumber value="${l.fc_get_dc_price}" pattern=",###" />원
                                    <c:if test="${l.prdt_sell_price > l.fc_get_dc_price}"> <span class="sale">[${hfn:rate(l.prdt_sell_price, l.fc_get_dc_price)}%]</span></c:if>
                                    </strong>
                                </p>
                            </a>
                        </c:if>
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
    <!-- //paging -->
