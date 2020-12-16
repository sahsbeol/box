<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<form name="productForm">
<ul class="view_type_list">
    <c:if test="${fn:length(listProduct) == 0 }">
        <li>검색 결과가 없습니다.</li>
    </c:if>
    <c:if test="${fn:length(listProduct) > 0 }">
        <c:forEach var="product" items="${listProduct}" varStatus="s">
            <!-- 간략보기 상품 GIFT(디자인) S -->
            <c:if test="${(searchCriteria.searchMenu == 'TOTAL' || searchCriteria.menuGroup == 'GIFT') && fn:substring(product.categoryId, 0, 4) eq '0000'}">
                <li>
                    <p class="prod_top">
                        <c:if test="${fn:substring(product.productIcon,13,14) eq 'X'}">
                            <span class="prod_cart">
                                <a href="javascript:productPreview('${product.productBarcode}', '');" class="zoom_s"><img src="${imageServer}/images/search/product_zoom_s.gif" alt="확대보기" /></a>
                                <a href="/ht/product/detail?barcode=${product.productBarcode}" target="_new"><img src="${imageServer}/images/search/product_zoom.gif" alt="새창열기" /></a> 
                            </span>
                        </c:if>
                        <c:if test="${fn:substring(product.productIcon,13,14) ne 'X'}">
                            <span class="prod_chk">
                                <input name="chkViewProduct" type="checkbox" value="${product.productBarcode}" title="${product.productName} 선택"/>
                                <input type="hidden" name="${product.productBarcode}_prdt_count" value="1" />
                            </span>
                            <span class="prod_cart">
                                <a href="javascript:productPreview('${product.productBarcode}', '');" class="zoom_s"><img src="${imageServer}/images/search/product_zoom_s.gif" alt="확대보기" /></a>
                                <a href="/ht/product/detail?barcode=${product.productBarcode}" target="_new"><img src="${imageServer}/images/search/product_zoom.gif" alt="새창열기" /></a> 
                                <a href="javascript:addRecordCart('${product.productBarcode}');"><img src="${imageServer}/images/search/ico_cart.gif" alt="장바구니 담기" onMouseDown="javascript:AEC_F_D('${product.productBarcode}','i', document.getElementsByName('${product.productBarcode}_prdt_count').value);"/></a>
                            </span>
                        </c:if>
                    </p>
                    <p class="prod_photo">
                        <a href="/ht/product/detail?barcode=${product.productBarcode}">
                            <ui:image src="${product.productImageUrl}" server="product" size="150" alt="${product.productName}"/>
                        </a>
                    </p>
                    <p class="prod_title" title="[디자인 | ${product.ctgr_name}]"><a href="/ht/category/${product.categoryId}">[디자인 | <ui:cut isStripHtml="true" limit="8" tail="..">${product.categoryName}</ui:cut>]</a></p> 
                    <p class="prod_name"><a href="/ht/product/detail?barcode=${product.productBarcode}" title="${product.productName}"><ui:cut isStripHtml="true" limit="30" tail="..">${product.productName}</ui:cut></a></p>
                    <p>
                        <c:if test="${product.productPrice ne product.productDcPrice}">
                            <span class="prod_price1"><fmt:formatNumber value='${product.productPrice}' type="number" />원</span>
                        </c:if>
                        <span class="prod_price2"><fmt:formatNumber value='${product.productDcPrice}' type="number" />원</span>
                    </p>
                    <c:if test="${product.productPrice ne product.productDcPrice || product.savedRate ne 0}">
                        <p>
                            <c:if test="${product.productPrice ne product.productDcPrice}">
                                <span class="prod_sale">[<fmt:formatNumber pattern="#">${hfn:rate(product.productPrice, product.productDcPrice)}</fmt:formatNumber>%]</span>
                            </c:if>
                            <c:if test="${product.savedRate ne 0}">
                                <c:set var="savedPrice" value="${product.productDcPrice * product.savedRate / 100}"/>
                                <span class="prod_price3"><fmt:formatNumber value="${savedPrice+(10-(savedPrice%10))%10}" pattern=",###" />원</span>
                            </c:if>
                        </p>
                    </c:if>
                    <p class="prod_icon">
                        <c:if test="${fn:substring(product.productIcon,0,1) eq '1'}"><img src="${imageServer}/images/search/ico_cupon.gif" alt="쿠폰"/></c:if>
                        <c:if test="${fn:substring(product.productIcon,6,7) eq '1'}"><img src="${imageServer}/images/search/ico_new.gif" alt="NEW"/></c:if>
                        <c:if test="${fn:substring(product.productIcon,8,9) eq '1'}"><img src="${imageServer}/images/search/ico_free.gif" alt="무료배송"/></c:if>
                        <c:if test="${fn:substring(product.productIcon,12,13) eq '1'}"><img src="${imageServer}/images/common/icon_delivery05.gif" alt="핫트랙스배송"/></c:if>
                        <c:if test="${fn:substring(product.productIcon,13,14) eq 'X'}"><img src="${imageServer}/images/search/ico_soldout.gif" alt="품절" /></c:if>
                    </p>
                </li>
            </c:if>
            <c:if test="${(searchCriteria.menuGroup == 'TOTAL' || searchCriteria.menuGroup == 'RECORD') && fn:substring(product.categoryId, 0, 4) eq '0003'}">
                <li>
                    <p class="prod_top">
                        <c:if test="${product.saleyn ne 'Y'}">
                            <span class="prod_cart">
                                <a href="javascript:productSimpleViewRecord('${product.sell_prdt_bcode}');" class="zoom_s"><img src="${imageServer}/images/search/product_zoom_s.gif" alt="확대보기" /></a>
                                <a href="javascript:viewRecordWin('${product.sell_prdt_bcode}', '${fn:substring(product.categoryId, 0, 4)}');" class="new"><img src="${imageServer}/images/search/product_zoom.gif" alt="새창열기" /></a> 
                            </span>
                        </c:if>
                        <c:if test="${product.saleyn eq 'Y'}">
                            <span class="prod_chk">
                                <input name="chkViewProduct" type="checkbox" value="${product.sell_prdt_bcode}" />
                                <input type="hidden" name="chkRecord_${product.sell_prdt_bcode}" value="${product.rcrd_cd}" />
                            </span>
                            <span class="prod_cart">
                                <a href="javascript:productSimpleViewRecord('${product.sell_prdt_bcode}');" class="zoom_s"><img src="${imageServer}/images/search/product_zoom_s.gif" alt="확대보기" /></a>
                                <a href="javascript:viewRecordWin('${product.sell_prdt_bcode}', '${fn:substring(product.categoryId, 0, 4)}');" class="new"><img src="${imageServer}/images/search/product_zoom.gif" alt="새창열기" /></a> 
                                <a href="javascript:addRecordCart('${product.sell_prdt_bcode}');"><img src="${imageServer}/images/search/ico_cart.gif" alt="장바구니 담기" onMouseDown="javascript:AEC_F_D('${product.sell_prdt_bcode}','i', document.getElementsByName('${product.sell_prdt_bcode}_prdt_count').value);"/></a>
                            </span>
                        </c:if>
                    </p>
                    <p class="prod_photo">
                        <a href="/ht/record/detail/${product.sell_prdt_bcode}" class="album_pic">
                            <ui:image rcrdCd="${product.rcrd_cd}" prdtGbn="R" ratingCode="${product.rtngCode }" width="150" alt="${product.ctgr_name}" />
                        </a>
                    </p>
                    <p class="prod_title" title="[음반 | ${product.ctgr_name}]"><a href="/ht/category/${product.categoryId}">[음반 | <ui:cut isStripHtml="true" limit="8" tail="..">${product.categoryName}</ui:cut>]</a></p> 
                    <p class="prod_name"><a href="/ht/record/detail/${product.sell_prdt_bcode}" title="${product.rcrd_name}"><ui:cut isStripHtml="true" limit="30" tail="..">${product.rcrd_name}</ui:cut></a></p>
                    <p>
                        <c:if test="${product.prdt_sell_price ne product.fc_get_dc_price}">
                            <span class="prod_price1"><fmt:formatNumber value='${product.prdt_sell_price}' type="number" />원</span>
                        </c:if>
                        <span class="prod_price2"><fmt:formatNumber value='${product.fc_get_dc_price}' type="number" />원</span>
                    </p>
                    <c:if test="${product.prdt_sell_price ne product.fc_get_dc_price || product.prdt_saved_rate_double ne 0}">
                        <p>
                            <c:if test="${product.prdt_sell_price ne product.fc_get_dc_price}">
                                <span class="prod_sale">[<fmt:formatNumber pattern="#">${hfn:rate(product.prdt_sell_price, product.fc_get_dc_price)}</fmt:formatNumber>%]</span>
                            </c:if>
                            <c:if test="${product.prdt_saved_rate_double ne 0}">
                                <c:set var="savedPrice" value="${product.fc_get_dc_price * product.prdt_saved_rate_double / 100}"/>
                                <span class="prod_price3"><fmt:formatNumber value="${savedPrice+(10-(savedPrice%10))%10}" pattern=",###" />원</span>
                            </c:if>
                        </p>
                    </c:if>
                    <c:if test="${(not empty product.imp_yn and product.imp_yn eq 'Y') || (not empty product.rcrdStatCode and product.rcrdStatCode eq '9') || (not empty product.saleyn && product.saleyn ne 'Y') || (not empty product.free_dlvy_yn and product.free_dlvy_yn eq 'Y')}">
                        <p class="prod_icon">
                            <c:if test="${not empty product.imp_yn and product.imp_yn eq 'Y'}"><img src="${imageServer}/images/search/icon_import.gif" alt="수입"></c:if>
                            <c:if test="${not empty product.rcrdStatCode and product.rcrdStatCode eq '9'}"><img src="${imageServer}/images/search/ico_reserve.gif" alt="예약"></c:if>
                            <c:if test="${not empty product.free_dlvy_yn and product.free_dlvy_yn eq 'Y'}"><img src="${imageServer}/images/search/ico_free.gif" alt="무료배송"/></c:if>
                        </p>
                    </c:if>
                    <p class="prod_icon">
                        <c:if test="${not empty product.saleyn && product.saleyn ne 'Y'}"><img src="${imageServer}/images/search/ico_soldout.gif" alt="품절" /></c:if>
                        <c:if test="${product.saleyn eq 'Y'}">
                            <span><a href="javascript:addRecordBuy('${product.sell_prdt_bcode}');"><img src="${imageServer}/images/search/ico_buy.gif" alt="구매" onMouseDown="javascript:AEC_F_D('${product.sell_prdt_bcode}','i', document.getElementsByName('${product.sell_prdt_bcode}_prdt_count').value);"/></a></span>
                        </c:if>
                        <span><a href="javascript:addMyListRecord('${product.rcrd_cd}');"><img src="${imageServer}/images/search/ico_add.gif" alt="담기" /></a></span>
                    </p>
                </li>
            </c:if>
            <c:if test="${(searchCriteria.menuGroup == 'TOTAL' || searchCriteria.menuGroup == 'BLURAY') && fn:substring(product.categoryId, 0, 6) eq '000400'}">
                <li>
                    <p class="prod_top">
                        <c:if test="${product.saleyn ne 'Y'}">
                            <span class="prod_cart">
                                <a href="javascript:productSimpleViewRecord('${product.sell_prdt_bcode}');" class="zoom_s"><img src="${imageServer}/images/search/product_zoom_s.gif" alt="확대보기" /></a>
                                <a href="javascript:viewRecordWin('${product.sell_prdt_bcode}', '${fn:substring(product.categoryId, 0, 4)}');" class="new"><img src="${imageServer}/images/search/product_zoom.gif" alt="새창열기" /></a> 
                            </span>
                        </c:if>
                        <c:if test="${product.saleyn eq 'Y'}">
                            <span class="prod_chk">
                                <input name="chkViewProduct" type="checkbox" value="${product.sell_prdt_bcode}" />
                                <input type="hidden" name="chkRecord_${product.sell_prdt_bcode}" value="${product.rcrd_cd}" />
                            </span>
                            <span class="prod_cart">
                                <a href="javascript:productSimpleViewRecord('${product.sell_prdt_bcode}');" class="zoom_s"><img src="${imageServer}/images/search/product_zoom_s.gif" alt="확대보기" /></a>
                                <a href="javascript:viewRecordWin('${product.sell_prdt_bcode}', '${fn:substring(product.categoryId, 0, 4)}');" class="new"><img src="${imageServer}/images/search/product_zoom.gif" alt="새창열기" /></a> 
                                <a href="javascript:addRecordCart('${product.sell_prdt_bcode}');"><img src="${imageServer}/images/search/ico_cart.gif" alt="장바구니 담기" onMouseDown="javascript:AEC_F_D('${product.sell_prdt_bcode}','i', document.getElementsByName('${product.sell_prdt_bcode}_prdt_count').value);"/></a>
                            </span>
                        </c:if>
                    </p>
                    <p class="prod_photo">
                        <a href="/ht/record/detail/${product.sell_prdt_bcode}" class="album_pic">
                            <ui:image rcrdCd="${product.rcrd_cd}" prdtGbn="D" ratingCode="${product.rtngCode }" width="100" height="150" alt="${product.ctgr_name}" />
                        </a>
                    </p>
                    <p class="prod_title" title="[BLU-RAY | ${product.ctgr_name}]"><a href="/ht/category/${product.categoryId}">[BLU-RAY | <ui:cut isStripHtml="true" limit="8" tail="..">${product.categoryName}</ui:cut>]</a></p> 
                    <p class="prod_name"><a href="/ht/record/detail/${product.sell_prdt_bcode}" title="${product.rcrd_name}"><ui:cut isStripHtml="true" limit="30" tail="..">${product.rcrd_name}</ui:cut></a></p>
                    <p>
                        <c:if test="${product.prdt_sell_price ne product.fc_get_dc_price}">
                            <span class="prod_price1"><fmt:formatNumber value='${product.prdt_sell_price}' type="number" />원</span>
                        </c:if>
                        <span class="prod_price2"><fmt:formatNumber value='${product.fc_get_dc_price}' type="number" />원</span>
                    </p>
                    <c:if test="${product.prdt_sell_price ne product.fc_get_dc_price || product.prdt_saved_rate_double ne 0}">
                        <p>
                            <c:if test="${product.prdt_sell_price ne product.fc_get_dc_price}">
                                <span class="prod_sale">[<fmt:formatNumber pattern="#">${hfn:rate(product.prdt_sell_price, product.fc_get_dc_price)}</fmt:formatNumber>%]</span>
                            </c:if>
                            <c:if test="${product.prdt_saved_rate_double ne 0}">
                                <c:set var="savedPrice" value="${product.fc_get_dc_price * product.prdt_saved_rate_double / 100}"/>
                                <span class="prod_price3"><fmt:formatNumber value="${savedPrice+(10-(savedPrice%10))%10}" pattern=",###" />원</span>
                            </c:if>
                        </p>
                    </c:if>
                    <c:if test="${(not empty product.imp_yn and product.imp_yn eq 'Y') || (not empty product.rcrdStatCode and product.rcrdStatCode eq '9') || (not empty product.saleyn && product.saleyn ne 'Y') || (not empty product.free_dlvy_yn and product.free_dlvy_yn eq 'Y')}">
                        <p class="prod_icon">
                            <c:if test="${not empty product.imp_yn and product.imp_yn eq 'Y'}"><img src="${imageServer}/images/search/icon_import.gif" alt="수입"></c:if>
                            <c:if test="${not empty product.rcrdStatCode and product.rcrdStatCode eq '9'}"><img src="${imageServer}/images/search/ico_reserve.gif" alt="예약"></c:if>
                            <c:if test="${not empty product.free_dlvy_yn and product.free_dlvy_yn eq 'Y'}"><img src="${imageServer}/images/search/ico_free.gif" alt="무료배송"/></c:if>
                        </p>
                    </c:if>
                    <p class="prod_icon">
                        <c:if test="${not empty product.saleyn && product.saleyn ne 'Y'}"><img src="${imageServer}/images/search/ico_soldout.gif" alt="품절" /></c:if>
                        <c:if test="${product.saleyn eq 'Y'}">
                            <span><a href="javascript:addRecordBuy('${product.sell_prdt_bcode}');"><img src="${imageServer}/images/search/ico_buy.gif" alt="구매" onMouseDown="javascript:AEC_F_D('${product.sell_prdt_bcode}','i', document.getElementsByName('${product.sell_prdt_bcode}_prdt_count').value);"/></a></span>
                        </c:if>
                        <span><a href="javascript:addMyListRecord('${product.rcrd_cd}');"><img src="${imageServer}/images/search/ico_add.gif" alt="담기" /></a></span>
                    </p>
                </li>
            </c:if>
            <c:if test="${(searchCriteria.menuGroup == 'TOTAL' || searchCriteria.menuGroup == 'DVD') && fn:substring(product.categoryId, 0, 6) eq '000401'}">
                <li>
                    <p class="prod_top">
                        <c:if test="${product.saleyn ne 'Y'}">
                            <span class="prod_cart">
                                <a href="javascript:productSimpleViewRecord('${product.sell_prdt_bcode}');" class="zoom_s"><img src="${imageServer}/images/search/product_zoom_s.gif" alt="확대보기" /></a>
                                <a href="javascript:viewRecordWin('${product.sell_prdt_bcode}', '${fn:substring(product.categoryId, 0, 4)}');" class="new"><img src="${imageServer}/images/search/product_zoom.gif" alt="새창열기" /></a> 
                            </span>
                        </c:if>
                        <c:if test="${product.saleyn eq 'Y'}">
                            <span class="prod_chk">
                                <input name="chkViewProduct" type="checkbox" value="${product.sell_prdt_bcode}" />
                                <input type="hidden" name="chkRecord_${product.sell_prdt_bcode}" value="${product.rcrd_cd}" />
                            </span>
                            <span class="prod_cart">
                                <a href="javascript:productSimpleViewRecord('${product.sell_prdt_bcode}');" class="zoom_s"><img src="${imageServer}/images/search/product_zoom_s.gif" alt="확대보기" /></a>
                                <a href="javascript:viewRecordWin('${product.sell_prdt_bcode}', '${fn:substring(product.categoryId, 0, 4)}');" class="new"><img src="${imageServer}/images/search/product_zoom.gif" alt="새창열기" /></a> 
                                <a href="javascript:addRecordCart('${product.sell_prdt_bcode}');"><img src="${imageServer}/images/search/ico_cart.gif" alt="장바구니 담기" onMouseDown="javascript:AEC_F_D('${product.sell_prdt_bcode}','i', document.getElementsByName('${product.sell_prdt_bcode}_prdt_count').value);"/></a>
                            </span>
                        </c:if>
                    </p>
                    <p class="prod_photo">
                        <a href="/ht/record/detail/${product.sell_prdt_bcode}" class="album_pic">
                            <ui:image rcrdCd="${product.rcrd_cd}" prdtGbn="D" ratingCode="${product.rtngCode }" width="100" height="150" alt="${product.ctgr_name}" />
                        </a>
                    </p>
                    <p class="prod_title" title="[DVD | ${product.ctgr_name}]"><a href="/ht/category/${product.categoryId}">[DVD | <ui:cut isStripHtml="true" limit="8" tail="..">${product.categoryName}</ui:cut>]</a></p> 
                    <p class="prod_name"><a href="/ht/record/detail/${product.sell_prdt_bcode}" title="${product.rcrd_name}"><ui:cut isStripHtml="true" limit="30" tail="..">${product.rcrd_name}</ui:cut></a></p>
                    <p>
                        <c:if test="${product.prdt_sell_price ne product.fc_get_dc_price}">
                            <span class="prod_price1"><fmt:formatNumber value='${product.prdt_sell_price}' type="number" />원</span>
                        </c:if>
                        <span class="prod_price2"><fmt:formatNumber value='${product.fc_get_dc_price}' type="number" />원</span>
                    </p>
                    <c:if test="${product.prdt_sell_price ne product.fc_get_dc_price || product.prdt_saved_rate_double ne 0}">
                        <p>
                            <c:if test="${product.prdt_sell_price ne product.fc_get_dc_price}">
                                <span class="prod_sale">[<fmt:formatNumber pattern="#">${hfn:rate(product.prdt_sell_price, product.fc_get_dc_price)}</fmt:formatNumber>%]</span>
                            </c:if>
                            <c:if test="${product.prdt_saved_rate_double ne 0}">
                                <c:set var="savedPrice" value="${product.fc_get_dc_price * product.prdt_saved_rate_double / 100}"/>
                                <span class="prod_price3"><fmt:formatNumber value="${savedPrice+(10-(savedPrice%10))%10}" pattern=",###" />원</span>
                            </c:if>
                        </p>
                    </c:if>
                    <c:if test="${(not empty product.imp_yn and product.imp_yn eq 'Y') || (not empty product.rcrdStatCode and product.rcrdStatCode eq '9') || (not empty product.saleyn && product.saleyn ne 'Y') || (not empty product.free_dlvy_yn and product.free_dlvy_yn eq 'Y')}">
                        <p class="prod_icon">
                            <c:if test="${not empty product.imp_yn and product.imp_yn eq 'Y'}"><img src="${imageServer}/images/search/icon_import.gif" alt="수입"></c:if>
                            <c:if test="${not empty product.rcrdStatCode and product.rcrdStatCode eq '9'}"><img src="${imageServer}/images/search/ico_reserve.gif" alt="예약"></c:if>
                            <c:if test="${not empty product.free_dlvy_yn and product.free_dlvy_yn eq 'Y'}"><img src="${imageServer}/images/search/ico_free.gif" alt="무료배송"/></c:if>
                        </p>
                    </c:if>
                    <p class="prod_icon">
                        <c:if test="${not empty product.saleyn && product.saleyn ne 'Y'}"><img src="${imageServer}/images/search/ico_soldout.gif" alt="품절" /></c:if>
                        <c:if test="${product.saleyn eq 'Y'}">
                            <span><a href="javascript:addRecordBuy('${product.sell_prdt_bcode}');"><img src="${imageServer}/images/search/ico_buy.gif" alt="구매" onMouseDown="javascript:AEC_F_D('${product.sell_prdt_bcode}','i', document.getElementsByName('${product.sell_prdt_bcode}_prdt_count').value);"/></a></span>
                        </c:if>
                        <span><a href="javascript:addMyListRecord('${product.rcrd_cd}');"><img src="${imageServer}/images/search/ico_add.gif" alt="담기" /></a></span>
                    </p>
                </li>
            </c:if>
        </c:forEach>
    </c:if>
</ul>
<div class="list_tool"> 
    <c:if test="${searchCriteria.menuGroup eq 'TOTAL'}">
        <span>
            <a href="javascript:addRecordsCart('chkViewProduct');"><img src="${imageServer}/images/music/btn_cart.gif" alt="장바구니에 담기"  onMouseDown="javascript:goCartProductListAce(document.productForm);"/></a>
        </span>
    </c:if>
    <c:if test="${searchCriteria.menuGroup eq 'RECORD'}">
        <span>
            <a href="javascript:addRecordsCart('chkViewProduct');"><img src="${imageServer}/images/music/btn_cart.gif" alt="장바구니에 담기"  onMouseDown="javascript:goCartProductListAce(document.productForm);"/></a>
        </span>
    </c:if>
    <c:if test="${searchCriteria.menuGroup eq 'BLURAY' or searchCriteria.menuGroup eq 'DVD'}">
        <span>
            <a href="javascript:addRecordsCart('chkViewProduct');"><img src="${imageServer}/images/music/btn_cart.gif" alt="장바구니에 담기"  onMouseDown="javascript:goCartProductListAce(document.productForm);"/></a>
        </span>
    </c:if>
</div> 
</form>