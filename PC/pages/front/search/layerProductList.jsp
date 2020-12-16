<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<form name="productForm">
<table class="typeC_list dot_line" style="border:none">
    <colgroup>   
        <col width="125px" />
        <col width="*" />  
        <col width="150px" />
        <col width="100px" />
    </colgroup> 
    <tbody> 
        <c:forEach var="product" items="${listProduct}" varStatus="s">
            <!-- 펼쳐보기 상품 GIFT(디자인) S -->
            <c:if test="${(searchCriteria.menuGroup == 'TOTAL' || searchCriteria.menuGroup == 'GIFT') && fn:substring(product.categoryId, 0, 4) eq '0000'}">
                <tr>
                    <td class="product">
                        <a href="/ht/product/detail?barcode=${product.productBarcode}" class="album_pic"><ui:image src="${product.productImageUrl}" server="product" size="85" alt="${product.productName}"/></a></a> 
                        <span class="album_zoom"> 
                            <a href="javascript:productPreview('${product.productBarcode}', '');" class="zoom_s"><img src="${imageServer}/images/music/product_zoom_s.gif" alt="확대보기" /></a>
                            <a href="/ht/product/detail?barcode=${product.productBarcode}" target="_blank"><img src="${imageServer}/images/music/product_zoom.gif" alt="새창열기" /></a>
                        </span> 
                    </td>
                    <td class="infor">   
                        <p class="category_title"><a href="/ht/category/${product.categoryId}">[디자인 | ${product.categoryName}]</a></p> 
                        <p class="album_title"><a href="/ht/product/detail?barcode=${product.productBarcode}">${product.productName}</a></p> 
                        <p class="product-price">
                            <c:if test="${product.productPrice ne product.productDcPrice}">
                                <span class="p_price1"><fmt:formatNumber value="${product.productPrice}" type="number" />원</span>
                            </c:if>
                            <span class="p_price2"><fmt:formatNumber value="${product.productDcPrice}" pattern=",###" />원</span>
                            <c:if test="${product.productPrice ne product.productDcPrice}">
                                <span class="p_price3">[<fmt:formatNumber pattern="#">${hfn:rate(product.productPrice, product.productDcPrice)}</fmt:formatNumber>%]</span>
                            </c:if>
                            <c:if test="${product.savedRate ne 0}">
                                <c:set var="savedPrice" value="${product.productDcPrice * product.savedRate / 100}"/>
                                <span class="p_price4"><fmt:formatNumber value="${savedPrice+(10-(savedPrice%10))%10}" pattern=",###" />원</span>
                                <span class="p_price5">[<fmt:formatNumber pattern="#">${product.savedRate}</fmt:formatNumber>%적립]</span>
                            </c:if>
                        </p>
                        <p class="product-icon">
                            <%--<ui:icon location="T" icons="${product.productIcon}"/> --%>
                            <c:if test="${fn:substring(product.productIcon,0,1) eq '1'}"><img src="${imageServer}/images/search/ico_cupon.gif" alt="쿠폰"/></c:if>
                            <c:if test="${fn:substring(product.productIcon,6,7) eq '1'}"><img src="${imageServer}/images/search/ico_new.gif" alt="NEW"/></c:if>
                            <c:if test="${fn:substring(product.productIcon,8,9) eq '1'}"><img src="${imageServer}/images/search/ico_free.gif" alt="무료배송"/></c:if>
                            <c:if test="${fn:substring(product.productIcon,12,13) eq '1'}"><img src="${imageServer}/images/common/icon_delivery05.gif" alt="핫트랙스배송"/></c:if>
                            <c:if test="${fn:substring(product.productIcon,13,14) eq 'X'}"><img src="${imageServer}/images/search/ico_soldout.gif" alt="품절" /></c:if>
                        </p>
                    </td> 
                    <td class="product-rating"><span class="rating${product.productGrade}"></span>고객평점</td>
                    <td class="down"> 
                        <c:if test="${fn:substring(product.productIcon,13,14) ne 'X'}">
                            <p>
                                <input name="chkListProduct" type="checkbox" value="${product.productBarcode}" title="${product.productName} 선택"/>
                                <input type="hidden" name="${product.productBarcode}_prdt_count" value="1" />
                                <span class="count">
                                    <label for="${product.productBarcode}_prdt_count"><img src="${imageServer}/images/music/text_count.gif" width="19" height="12" alt="수량" /></label>
                                    <input name="${product.productBarcode}_prdt_count" id="${product.productBarcode}_prdt_count" type="text" value="1" class="album_count" />
                                </span>
                            </p>
                            <a href="javascript:addRecordCart('${product.productBarcode}', '');"><img src="${imageServer}/images/search/btn_addcart.gif" alt="장바구니에 담기" class="bt_m" onMouseDown="javascript:AEC_F_D('${product.productBarcode}','i', document.getElementsByName('${product.productBarcode}_prdt_count').value);"/></a>
                        </c:if>
                        <a href="javascript:addWishProduct('${product.productBarcode}');"><img src="${imageServer}/images/search/btn_zzim.gif" alt="좋아요♥"></a> 
                    </td>
                </tr>
            </c:if>
            <!-- 펼쳐보기 상품 음반 S -->
            <c:if test="${(searchCriteria.menuGroup == 'TOTAL' || searchCriteria.menuGroup == 'RECORD') && fn:substring(product.categoryId, 0, 4) eq '0003'}">
                <tr>  
                    <td class="product">
                        <a href="/ht/record/detail/${product.sell_prdt_bcode}" class="album_pic"><ui:image rcrdCd="${product.rcrd_cd}" prdtGbn="R" ratingCode="${product.rtngCode }" width="85" alt="${product.ctgr_name}" /></a></a> 
                        <span class="album_zoom"> 
                            <a href="javascript:productSimpleViewRecord('${product.sell_prdt_bcode}');" class="zoom_s"><img src="${imageServer}/images/music/product_zoom_s.gif" alt="확대보기" /></a>
                            <a href="/ht/record/detail/${product.sell_prdt_bcode}" target="_blank"><img src="${imageServer}/images/music/product_zoom.gif" alt="새창열기" /></a>
                        </span> 
                    </td>
                    <td class="infor">   
                        <p class="category_title"><a href="/ht/category/${product.categoryId}">[음반 | ${product.categoryName}]</a></p> 
                        <p class="album_title"><a href="/ht/record/detail/${product.sell_prdt_bcode}">${product.rcrd_name}</a></p> 
                        <p class="a_description">
                            <a href="javascript:searchMain('<ui:cut isStripHtml="true">${product.rcArtiName}</ui:cut>', 'TOTAL', 'ARTI_NAME', 'RECORD');">${product.rcArtiName}</a> 
                            <span class="seperate">|</span> <a href="javascript:searchMain('<ui:cut isStripHtml="true">${product.maker_name}</ui:cut>', 'TOTAL', 'TOTAL', 'RECORD');">${product.maker_name}</a>
                            <span class="seperate">|</span> <a href="javascript:searchMain('<ui:cut isStripHtml="true">${product.label_name}</ui:cut>', 'TOTAL', 'LABEL_NAME', 'RECORD');">${product.label_name}</a>
                            <span class="seperate">|</span> ${fn:substring(product.rlse_dt, 0, 4)}년 ${fn:substring(product.rlse_dt, 4, 6)}월
                        </p>
                        <p class="product-price">
                            <c:if test="${(product.prdt_sell_price - product.fc_get_dc_price) gt 0}">
                                <span class="p_price1"><fmt:formatNumber value="${product.prdt_sell_price}" type="number" />원</span>
                            </c:if>
                            <span class="p_price2"><fmt:formatNumber value="${product.fc_get_dc_price}" type="number" />원</span>
                            <c:if test="${(product.prdt_sell_price - product.fc_get_dc_price) gt 0}">
                                <span class="p_price3">[<fmt:formatNumber pattern="#">${hfn:rate(product.prdt_sell_price, product.fc_get_dc_price)}</fmt:formatNumber>%]</span>
                            </c:if>
                            <c:if test="${product.prdt_saved_rate_double gt 0}">
                                <c:set var="savedPrice" value="${product.fc_get_dc_price * product.prdt_saved_rate_double / 100}"/>
                                <span class="p_price4"><fmt:formatNumber value="${savedPrice+(10-(savedPrice%10))%10}" pattern=",###" />원</span>
                                <span class="p_price5">[<fmt:formatNumber pattern="#">${product.prdt_saved_rate_double}</fmt:formatNumber>%적립]</span>
                            </c:if>
                        </p>
                        <p class="product-icon">
                            <c:if test="${not empty product.imp_yn and product.imp_yn eq 'Y'}"><img src="${imageServer}/images/search/icon_import.gif" alt="수입"></c:if>
                            <c:if test="${not empty product.rcrdStatCode and product.rcrdStatCode eq '9'}"><img src="${imageServer}/images/search/ico_reserve.gif" alt="예약"></c:if>
                            <c:if test="${not empty product.saleyn && product.saleyn ne 'Y'}"><img src="${imageServer}/images/search/ico_soldout.gif" alt="품절" /></c:if>
                            <c:if test="${not empty product.free_dlvy_yn and product.free_dlvy_yn eq 'Y'}"><img src="${imageServer}/images/search/ico_free.gif" alt="무료배송"/></c:if>
                        </p>
                    </td> 
                    <td class="product-rating"><span class="rating${product.reviewgrade}"></span>고객평점</td>
                    <td class="down"> 
                        <c:if test="${product.saleyn eq 'Y'}">
                            <p>
                                <input name="chkListProduct" type="checkbox" value="${product.sell_prdt_bcode}" />
                                <input type="hidden" name="${product.sell_prdt_bcode}_prdt_count" value="1" />
                                <input type="hidden" name="chkRecord_${product.sell_prdt_bcode}" value="${product.rcrd_cd}" />
                                <span class="count">
                                    <img src="${imageServer}/images/music/text_count.gif" width="19" height="12" alt="수량" />
                                    <input name="${product.sell_prdt_bcode}_prdt_count" type="text" value="1" class="album_count" />
                                </span>
                            </p>
                            <a href="javascript:addRecordCart('${product.sell_prdt_bcode}', '');"><img src="${imageServer}/images/search/btn_addcart.gif" alt="장바구니에 담기" class="bt_m" onMouseDown="javascript:AEC_F_D('${product.sell_prdt_bcode}','i', document.getElementsByName('${product.sell_prdt_bcode}_prdt_count').value);"/></a>
                            <a href="javascript:addRecordBuy('${product.sell_prdt_bcode}');"><img src="${imageServer}/images/search/btn_buy.gif" alt="바로구매하기" class="bt_m" onMouseDown="javascript:AEC_F_D('${product.sell_prdt_bcode}','i', document.getElementsByName('${product.sell_prdt_bcode}_prdt_count').value);"/></a>
                        </c:if>
                    </td>
                </tr>
            </c:if>
            <!-- 펼쳐보기 상품 BLU-RAY S -->
            <c:if test="${(searchCriteria.menuGroup == 'TOTAL' || searchCriteria.menuGroup == 'BLURAY') && fn:substring(product.categoryId, 0, 6) eq '000400'}">
                <tr>  
                    <td class="product">
                        <a href="/ht/record/detail/${product.sell_prdt_bcode}" class="album_pic"><ui:image rcrdCd="${product.rcrd_cd}" prdtGbn="D" ratingCode="${product.rtngCode }" width="66" height="100" alt="${product.ctgr_name}"/></a></a> 
                        <span class="album_zoom"> 
                            <a href="javascript:productSimpleViewRecord('${product.sell_prdt_bcode}');" class="zoom_s"><img src="${imageServer}/images/music/product_zoom_s.gif" alt="확대보기" /></a>
                            <a href="/ht/record/detail/${product.sell_prdt_bcode}" target="_blank"><img src="${imageServer}/images/music/product_zoom.gif" alt="새창열기" /></a>
                        </span> 
                    </td>
                    <td class="infor">
                        <p class="category_title"><a href="/ht/category/${product.categoryId}">[BLU-RAY | ${product.categoryName}]</a></p> 
                        <p class="album_title"><a href="/ht/record/detail/${product.sell_prdt_bcode}">${product.rcrd_name}</a></p> 
                        <p class="a_description">
                            <a href="javascript:searchMain('<ui:cut isStripHtml="true">${product.actor}</ui:cut>', 'TOTAL', 'B_ACTOR', 'BLURAY');">${product.actor}</a>
                            <span class="seperate">|</span> <a href="javascript:searchMain('<ui:cut isStripHtml="true">${product.drctr}</ui:cut>', 'TOTAL', 'B_DRCTR', 'BLURAY');">${product.drctr}</a>
                            <span class="seperate">|</span> <a href="javascript:searchMain('<ui:cut isStripHtml="true">${product.maker_name}</ui:cut>', 'TOTAL', 'TOTAL', 'BLURAY');">${product.maker_name}</a> 
                            <span class="seperate">|</span> ${fn:substring(product.rlse_dt, 0, 4)}년 ${fn:substring(product.rlse_dt, 4, 6)}월
                        </p>
                        <p class="product-price">
                            <c:if test="${(product.prdt_sell_price - product.fc_get_dc_price) gt 0}">
                                <span class="p_price1"><fmt:formatNumber value="${product.prdt_sell_price}" type="number" />원</span>
                            </c:if>
                            <span class="p_price2"><fmt:formatNumber value="${product.fc_get_dc_price}" type="number" />원</span>
                            <c:if test="${(product.prdt_sell_price - product.fc_get_dc_price) gt 0}">
                                <span class="p_price3">[<fmt:formatNumber pattern="#">${hfn:rate(product.prdt_sell_price, product.fc_get_dc_price)}</fmt:formatNumber>%]</span>
                            </c:if>
                            <c:if test="${product.prdt_saved_rate_double gt 0}">
                                <c:set var="savedPrice" value="${product.fc_get_dc_price * product.prdt_saved_rate_double / 100}"/>
                                <span class="p_price4"><fmt:formatNumber value="${savedPrice+(10-(savedPrice%10))%10}" pattern=",###" />원</span>
                                <span class="p_price5">[<fmt:formatNumber pattern="#">${product.prdt_saved_rate_double}</fmt:formatNumber>%적립]</span>
                            </c:if>
                        </p>
                        <p class="product-icon">
                            <c:if test="${not empty product.imp_yn and product.imp_yn eq 'Y'}"><img src="${imageServer}/images/search/icon_import.gif" alt="수입"></c:if>
                            <c:if test="${not empty product.rcrdStatCode and product.rcrdStatCode eq '9'}"><img src="${imageServer}/images/search/ico_reserve.gif" alt="예약"></c:if>
                            <c:if test="${not empty product.saleyn && product.saleyn ne 'Y'}"><img src="${imageServer}/images/search/ico_soldout.gif" alt="품절" /></c:if>
                            <c:if test="${not empty product.free_dlvy_yn and product.free_dlvy_yn eq 'Y'}"><img src="${imageServer}/images/search/ico_free.gif" alt="무료배송"/></c:if>
                        </p>
                    </td> 
                    <td class="product-rating"><span class="rating${product.reviewgrade}"></span>고객평점</td>
                    <td class="down"> 
                        <c:if test="${product.saleyn eq 'Y'}">
                            <p>
                                <input name="chkListProduct" type="checkbox" value="${product.sell_prdt_bcode}" />
                                <input type="hidden" name="${product.sell_prdt_bcode}_prdt_count" value="1" />
                                <input type="hidden" name="chkRecord_${product.sell_prdt_bcode}" value="${product.rcrd_cd}" />
                                <span class="count">
                                    <img src="${imageServer}/images/music/text_count.gif" width="19" height="12" alt="수량" />
                                    <input name="${product.sell_prdt_bcode}_prdt_count" type="text" value="1" class="album_count" />
                                </span>
                            </p>
                            <a href="javascript:addRecordCart('${product.sell_prdt_bcode}', '');"><img src="${imageServer}/images/search/btn_addcart.gif" alt="장바구니에 담기" class="bt_m" onMouseDown="javascript:AEC_F_D('${product.sell_prdt_bcode}','i', document.getElementsByName('${product.sell_prdt_bcode}_prdt_count').value);"/></a>
                            <a href="javascript:addRecordBuy('${product.sell_prdt_bcode}');"><img src="${imageServer}/images/search/btn_buy.gif" alt="바로구매하기" class="bt_m" onMouseDown="javascript:AEC_F_D('${product.sell_prdt_bcode}','i', document.getElementsByName('${product.sell_prdt_bcode}_prdt_count').value);"/></a>
                        </c:if>
                    </td>
                </tr>
            </c:if>
            <!-- 펼쳐보기 상품 BLU-RAY S -->
            <c:if test="${(searchCriteria.menuGroup == 'TOTAL' || searchCriteria.menuGroup == 'DVD') && fn:substring(product.categoryId, 0, 6) eq '000401'}">
                <tr>  
                    <td class="product">
                        <a href="/ht/record/detail/${product.sell_prdt_bcode}" class="album_pic"><ui:image rcrdCd="${product.rcrd_cd}" prdtGbn="D" ratingCode="${product.rtngCode }" width="66" height="100" alt="${product.ctgr_name}"/></a></a> 
                        <span class="album_zoom"> 
                            <a href="javascript:productSimpleViewRecord('${product.sell_prdt_bcode}');" class="zoom_s"><img src="${imageServer}/images/music/product_zoom_s.gif" alt="확대보기" /></a>
                            <a href="/ht/record/detail/${product.sell_prdt_bcode}" target="_blank"><img src="${imageServer}/images/music/product_zoom.gif" alt="새창열기" /></a>
                        </span> 
                    </td>
                    <td class="infor">   
                        <p class="category_title"><a href="/ht/category/${product.categoryId}">[DVD | ${product.categoryName}]</a></p> 
                        <p class="album_title"><a href="/ht/record/detail/${product.sell_prdt_bcode}">${product.rcrd_name}</a></p> 
                        <p class="a_description">
                            <span class="seperate"></span><a href="javascript:searchMain('<ui:cut isStripHtml="true">${product.actor}</ui:cut>', 'TOTAL', 'D_ACTOR', 'DVD');">${product.actor}</a>
                            <span class="seperate">|</span> <a href="javascript:searchMain('<ui:cut isStripHtml="true">${product.drctr}</ui:cut>', 'TOTAL', 'D_DRCTR', 'DVD');">${product.drctr}</a>
                            <span class="seperate">|</span> <a href="javascript:searchMain('<ui:cut isStripHtml="true">${product.maker_name}</ui:cut>', 'TOTAL', 'TOTAL', 'DVD');">${product.maker_name}</a>
                            <span class="seperate">|</span> ${fn:substring(product.rlse_dt, 0, 4)}년 ${fn:substring(product.rlse_dt, 4, 6)}월</p> 
                        </p>
                        <p class="product-price">
                            <c:if test="${(product.prdt_sell_price - product.fc_get_dc_price) gt 0}">
                                <span class="p_price1"><fmt:formatNumber value="${product.prdt_sell_price}" type="number" />원</span>
                            </c:if>
                            <span class="p_price2"><fmt:formatNumber value="${product.fc_get_dc_price}" type="number" />원</span>
                            <c:if test="${(product.prdt_sell_price - product.fc_get_dc_price) gt 0}">
                                <span class="p_price3">[<fmt:formatNumber pattern="#">${hfn:rate(product.prdt_sell_price, product.fc_get_dc_price)}</fmt:formatNumber>%]</span>
                            </c:if>
                            <c:if test="${product.prdt_saved_rate_double gt 0}">
                                <c:set var="savedPrice" value="${product.fc_get_dc_price * product.prdt_saved_rate_double / 100}"/>
                                <span class="p_price4"><fmt:formatNumber value="${savedPrice+(10-(savedPrice%10))%10}" pattern=",###" />원</span>
                                <span class="p_price5">[<fmt:formatNumber pattern="#">${product.prdt_saved_rate_double}</fmt:formatNumber>%적립]</span>
                            </c:if>
                        </p>
                        <p class="product-icon">
                            <c:if test="${not empty product.imp_yn and product.imp_yn eq 'Y'}"><img src="${imageServer}/images/search/icon_import.gif" alt="수입"></c:if>
                            <c:if test="${not empty product.rcrdStatCode and product.rcrdStatCode eq '9'}"><img src="${imageServer}/images/search/ico_reserve.gif" alt="예약"></c:if>
                            <c:if test="${not empty product.saleyn && product.saleyn ne 'Y'}"><img src="${imageServer}/images/search/ico_soldout.gif" alt="품절" /></c:if>
                            <c:if test="${not empty product.free_dlvy_yn and product.free_dlvy_yn eq 'Y'}"><img src="${imageServer}/images/search/ico_free.gif" alt="무료배송"/></c:if>
                        </p>
                    </td> 
                    <td class="product-rating"><span class="rating${product.reviewgrade}"></span>고객평점</td>
                    <td class="down"> 
                        <c:if test="${product.saleyn eq 'Y'}">
                            <p>
                                <input name="chkListProduct" type="checkbox" value="${product.sell_prdt_bcode}" />
                                <input type="hidden" name="${product.sell_prdt_bcode}_prdt_count" value="1" />
                                <input type="hidden" name="chkRecord_${product.sell_prdt_bcode}" value="${product.rcrd_cd}" />
                                <span class="count">
                                    <img src="${imageServer}/images/music/text_count.gif" width="19" height="12" alt="수량" />
                                    <input name="${product.sell_prdt_bcode}_prdt_count" type="text" value="1" class="album_count" />
                                </span>
                            </p>
                            <a href="javascript:addRecordCart('${product.sell_prdt_bcode}', '');"><img src="${imageServer}/images/search/btn_addcart.gif" alt="장바구니에 담기" class="bt_m"  onMouseDown="javascript:AEC_F_D('${product.sell_prdt_bcode}','i', document.productForm.${product.sell_prdt_bcode}_prdt_count.value);"/></a>
                            <a href="javascript:addRecordBuy('${product.sell_prdt_bcode}');"><img src="${imageServer}/images/search/btn_buy.gif" alt="바로구매하기" class="bt_m" onMouseDown="javascript:AEC_F_D('${product.sell_prdt_bcode}','i', document.productForm.${product.sell_prdt_bcode}_prdt_count.value);"/></a>
                        </c:if>
                    </td>
                </tr>
            </c:if>
        </c:forEach>
    </tbody>  
</table>
<div class="list_tool"> 
    <c:if test="${searchCriteria.menuGroup eq 'TOTAL'}">
        <span>
            <a href="javascript:addRecordsCart('chkListProduct');"><img src="${imageServer}/images/music/btn_cart.gif" alt="장바구니에 담기" onMouseDown="javascript:goCartProductListAce(document.productForm);"/></a>
        </span>
    </c:if>
    <c:if test="${searchCriteria.menuGroup eq 'RECORD'}">
        <span>
            <a href="javascript:addRecordsCart('chkListProduct');"><img src="${imageServer}/images/music/btn_cart.gif" alt="장바구니에 담기" onMouseDown="javascript:goCartProductListAce(document.productForm);"/></a>
        </span>
    </c:if>
    <c:if test="${searchCriteria.menuGroup eq 'BLURAY' or searchCriteria.menuGroup eq 'DVD'}">
        <span>
            <a href="javascript:addRecordsCart('chkListProduct');"><img src="${imageServer}/images/music/btn_cart.gif" alt="장바구니에 담기" onMouseDown="javascript:goCartProductListAce(document.productForm);"/></a>
        </span>
    </c:if>
</div> 
</form>