<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<ui:decorator name="none"/>
<script type="text/javascript">
jQuery(function(){
    $("input[name=prevQuery]").val("${prevQuery}");
});
</script>
<c:if test="${empty searchCriteria.categoryGroup && empty searchCriteria.brandGroup}">
    <script type="text/javascript">
        $("#totalCnt02").html('<strong>ALL</strong> ('+price_format('${totalCount}')+')<span class="arrow"></span>');
    </script>
</c:if>
<c:if test="${not empty searchCriteria.categoryGroup && empty searchCriteria.brandGroup}">
    <script type="text/javascript">
        $("#totalCnt02").html("<strong>${fn:substringAfter(searchCriteria.categoryGroup, '_')}</strong> ("+price_format('${searchCriteria.categoryBrandCount}')+")<span class=\"arrow\"></span>");
    </script>
</c:if>
<c:if test="${empty searchCriteria.categoryGroup && not empty searchCriteria.brandGroup}">
    <script type="text/javascript">
        $("#totalCnt02").html('<strong>${searchCriteria.brandGroup}</strong> ('+price_format('${searchCriteria.categoryBrandCount}')+')<span class="arrow"></span>');
    </script>
</c:if>
<c:if test="${empty listProduct}">
    <p style="text-align:center;"><img src="${imageServer}/images/renewal/shop/img_no_result.jpg" alt="죄송합니다. 고객님께서 찾으시는 상품이 없네요."/></p>
</c:if>
<c:if test="${searchCriteria.viewType eq 'type02'}">
    <c:if test="${empty listProduct}">
        <p style="text-align:center;"><img src="${imageServer}/images/renewal/shop/img_no_result.jpg" alt="죄송합니다. 고객님께서 찾으시는 상품이 없네요."/></p>
    </c:if>
    <div class="prod_list_normal">
        <c:forEach items="${listProduct}" varStatus="s1" step="4">
            <ul><!-- 1 -->
                <c:forEach items="${listProduct}" var="l" varStatus="st" begin="${s1.index}" end="${s1.index+3}">
                    <!-- 기프트 -->
                    <c:if test="${fn:startsWith(l.categoryId, '0000')}">
                        <li>
                            <!-- AceCounter eCommerce (Product_Detail) v6.5 Start -->
                            <script language='javascript'>
                             _A_amt[_ace_countvar]="${l.productDcPrice}";
                             _A_nl[_ace_countvar]="1";
                             _A_pl[_ace_countvar]="${l.productBarcode}";
                             _A_pn[_ace_countvar]="${l.productName}";
                             _A_ct[_ace_countvar]="";    // ex) 음반/가요/락 -- 매핑불가능한 경우 '' 처리
                             _ace_countvar++;
                            </script>
                            <!-- AceCounter eCommerce (Product_detail) v6.4 Start -->
                            <span class="img">
                                <a href="/ht/product/detail?barcode=${l.productBarcode}"><ui:image src="${l.productImageUrl}" server="product" size="200" alt="${fn:escapeXml(l.productName)}"/></a>
                                <div class="hide_util">
                                    <a href="javascript://" onclick="productPreview('${l.productBarcode}')" class="zoom"><span>확대</span></a>
                                    <a href="/ht/product/detail?barcode=${l.productBarcode}" target="_blank" class="nblank"><span>새창</span></a>
                                    <a href="javascript://" onclick="addWishProduct('${l.productBarcode}')" class="zzim"><span>좋아요</span></a>
                                </div>
                            </span>
                            <a href="/ht/product/detail?barcode=${l.productBarcode}">
                                <span class="make">${l.brandName}</span>
                                <span class="name">${l.productName}</span>
                                <em class="price">
                                    <fmt:parseNumber var="productPrice" value="${l.productPrice}"/>
                                    <fmt:parseNumber var="productDcPrice" value="${l.productDcPrice}"/>
                                    <c:if test="${productPrice > productDcPrice}"><span class="dc"><fmt:formatNumber value="${productPrice}" pattern="#,###"/></span></c:if>
                                    <span class="sale"><fmt:formatNumber value="${l.productDcPrice}" pattern="#,###"/></span>
                                    <c:if test="${fn:substring(l.productIcon,13,14) eq 'X'}"><span class="pc"><img src="${imageServer}/images/renewal/common/ic_status_soldout.gif" alt="품절"/></span></c:if>
                                    <c:if test="${fn:substring(l.productIcon,13,14) ne 'X' && productPrice > productDcPrice}"><span class="pc">${hfn:rate(productPrice, productDcPrice)}%</span></c:if>
                                </em>
                            </a>
                        </li>
                    </c:if>
                    <!-- //기프트 -->
                    <!-- CD -->
                    <c:if test="${fn:startsWith(l.categoryId, '0003')}">
                        <li>
                            <!-- AceCounter eCommerce (Product_Detail) v6.5 Start -->
                            <script language='javascript'>
                            _A_amt[_ace_countvar]="${l.fc_get_dc_price}";
                            _A_nl[_ace_countvar]="1";
                            _A_pl[_ace_countvar]="${l.sell_prdt_bcode}";
                            _A_pn[_ace_countvar]="${l.rcrd_name}";
                            _A_ct[_ace_countvar]="";    // ex) 음반/가요/락 -- 매핑불가능한 경우 '' 처리
                            _ace_countvar++;
                            </script>
                            <!-- AceCounter eCommerce (Product_detail) v6.4 Start -->
                            <span class="img">
                                <a href="/ht/record/detail/${l.sell_prdt_bcode}"><ui:image rcrdCd="${l.rcrd_cd}" prdtGbn="R" ratingCode="${l.rtngCode }" width="200" height="200" alt="${fn:escapeXml(l.ctgr_name)}" /></a>
                                <div class="hide_util">
                                    <a href="/ht/record/detail/${l.sell_prdt_bcode}" target="_blank" class="nblank"><span>새창</span></a>
                                    <a href="javascript://" onclick="addMyListRecord('${l.rcrd_cd}')" class="zzim"><span>담기</span></a>
                                </div>
                            </span>
                            <a href="/ht/record/detail/${l.sell_prdt_bcode}">
                                <span class="make">${l.rcArtiName}</span>
                                <span class="name">${l.rcrd_name}</span>
                                <em class="price">
                                    <fmt:parseNumber var="prdt_sell_price" value="${l.prdt_sell_price}"/>
                                    <fmt:parseNumber var="fc_get_dc_price" value="${l.fc_get_dc_price}"/>
                                    <c:if test="${prdt_sell_price > fc_get_dc_price}"><span class="dc"><fmt:formatNumber value="${prdt_sell_price}" pattern="#,###"/></span></c:if>
                                    <span class="sale"><fmt:formatNumber value="${fc_get_dc_price}" pattern="#,###"/></span>
                                    <c:if test="${l.saleyn ne 'Y'}"><span class="pc"><img src="${imageServer}/images/renewal/common/ic_status_soldout.gif" alt="품절"/></span></c:if>
                                    <c:if test="${l.saleyn eq 'Y' && prdt_sell_price > fc_get_dc_price}"><span class="pc">${hfn:rate(prdt_sell_price, fc_get_dc_price)}%</span></c:if>
                                </em>
                            </a>
                        </li>
                    </c:if>
                    <!-- //CD -->
                    <!-- DVD -->
                    <c:if test="${fn:startsWith(l.categoryId, '0004')}">
                        <li>
                            <!-- AceCounter eCommerce (Product_Detail) v6.5 Start -->
                            <script language='javascript'>
                            _A_amt[_ace_countvar]="${l.fc_get_dc_price}";
                            _A_nl[_ace_countvar]="1";
                            _A_pl[_ace_countvar]="${l.sell_prdt_bcode}";
                            _A_pn[_ace_countvar]="${l.rcrd_name}";
                            _A_ct[_ace_countvar]="";    // ex) 음반/가요/락 -- 매핑불가능한 경우 '' 처리
                            _ace_countvar++;
                            </script>
                            <!-- AceCounter eCommerce (Product_detail) v6.4 Start -->
                            <span class="img">
                                <a href="/ht/record/detail/${l.sell_prdt_bcode}"><ui:image rcrdCd="${l.rcrd_cd}" prdtGbn="D" ratingCode="${l.rtngCode }" width="132" height="200" alt="${fn:escapeXml(l.ctgr_name)}" /></a>
                                <div class="hide_util">
                                    <a href="/ht/record/detail/${l.sell_prdt_bcode}" target="_blank" class="nblank"><span>새창</span></a>
                                    <a href="javascript://" onclick="addMyListDvd('${l.rcrd_cd}')" class="zzim"><span>담기</span></a>
                                </div>
                            </span>
                            <a href="/ht/record/detail/${l.sell_prdt_bcode}">
                                <span class="make">${l.rcArtiName}</span>
                                <span class="name">${l.rcrd_name}</span>
                                <em class="price">
                                    <fmt:parseNumber var="prdt_sell_price" value="${l.prdt_sell_price}"/>
                                    <fmt:parseNumber var="fc_get_dc_price" value="${l.fc_get_dc_price}"/>
                                    <c:if test="${prdt_sell_price > fc_get_dc_price}"><span class="dc"><fmt:formatNumber value="${prdt_sell_price}" pattern="#,###"/></span></c:if>
                                    <span class="sale"><fmt:formatNumber value="${fc_get_dc_price}" pattern="#,###"/></span>
                                    <c:if test="${l.saleyn ne 'Y'}"><span class="pc"><img src="${imageServer}/images/renewal/common/ic_status_soldout.gif" alt="품절"/></span></c:if>
                                    <c:if test="${l.saleyn eq 'Y' && prdt_sell_price > fc_get_dc_price}"><span class="pc">${hfn:rate(prdt_sell_price, fc_get_dc_price)}%</span></c:if>
                                </em>
                            </a>
                        </li>
                    </c:if>
                    <!-- //DVD -->
                </c:forEach>
            </ul>
        </c:forEach>
    </div>
</c:if>
<c:if test="${searchCriteria.viewType eq 'type01'}">
    <div class="prod_list_large">
        <c:forEach items="${listProduct}" varStatus="s1" step="2">
            <ul><!-- 1 -->
                <c:forEach items="${listProduct}" var="l" varStatus="st" begin="${s1.index}" end="${s1.index+1}">
                    <!-- 기프트 -->
                    <c:if test="${fn:startsWith(l.categoryId, '0000')}">
                        <li>
                            <!-- AceCounter eCommerce (Product_Detail) v6.5 Start -->
                            <script language='javascript'>
                             _A_amt[_ace_countvar]="${l.productDcPrice}";
                             _A_nl[_ace_countvar]="1";
                             _A_pl[_ace_countvar]="${l.productBarcode}";
                             _A_pn[_ace_countvar]="${l.productName}";
                             _A_ct[_ace_countvar]="";    // ex) 음반/가요/락 -- 매핑불가능한 경우 '' 처리
                             _ace_countvar++;
                            </script>
                            <!-- AceCounter eCommerce (Product_detail) v6.4 Start -->
                            <span class="img">
                                <a href="/ht/product/detail?barcode=${l.productBarcode}"><ui:image src="${l.productImageUrl}" server="product" size="400" alt="${fn:escapeXml(l.productName)}"/></a>
                                <div class="hide_util">
                                    <a href="javascript://" onclick="productPreview('${l.productBarcode}')" class="zoom"><span>확대</span></a>
                                    <a href="/ht/product/detail?barcode=${l.productBarcode}" target="_blank" class="nblank"><span>새창</span></a>
                                    <a href="javascript://" onclick="addWishProduct('${l.productBarcode}')" class="zzim"><span>좋아요</span></a>
                                </div>
                            </span>
                            <a href="/ht/product/detail?barcode=${l.productBarcode}">
                                <span class="make">${l.brandName}</span>
                                <span class="name">${l.productName}</span>
                                <em class="price">
                                    <fmt:parseNumber var="productPrice" value="${l.productPrice}"/>
                                    <fmt:parseNumber var="productDcPrice" value="${l.productDcPrice}"/>
                                    <c:if test="${productPrice > productDcPrice}"><span class="dc"><fmt:formatNumber value="${productPrice}" pattern="#,###"/></span></c:if>
                                    <span class="sale"><fmt:formatNumber value="${l.productDcPrice}" pattern="#,###"/></span>
                                    <c:if test="${fn:substring(l.productIcon,13,14) eq 'X'}"><span class="pc"><img src="${imageServer}/images/renewal/common/ic_status_soldout.gif" alt="품절"/></span></c:if>
                                    <c:if test="${fn:substring(l.productIcon,13,14) ne 'X' && productPrice > productDcPrice}"><span class="pc">${hfn:rate(productPrice, productDcPrice)}%</span></c:if>
                                </em>
                            </a>
                        </li>
                    </c:if>
                    <!-- //기프트 -->
                    <!-- CD -->
                    <c:if test="${fn:startsWith(l.categoryId, '0003')}">
                        <li>
                            <!-- AceCounter eCommerce (Product_Detail) v6.5 Start -->
                            <script language='javascript'>
                            _A_amt[_ace_countvar]="${l.fc_get_dc_price}";
                            _A_nl[_ace_countvar]="1";
                            _A_pl[_ace_countvar]="${l.sell_prdt_bcode}";
                            _A_pn[_ace_countvar]="${l.rcrd_name}";
                            _A_ct[_ace_countvar]="";    // ex) 음반/가요/락 -- 매핑불가능한 경우 '' 처리
                            _ace_countvar++;
                            </script>
                            <!-- AceCounter eCommerce (Product_detail) v6.4 Start -->
                            <span class="img">
                                <a href="/ht/record/detail/${l.sell_prdt_bcode}"><ui:image rcrdCd="${l.rcrd_cd}" prdtGbn="R" ratingCode="${l.rtngCode }" width="400" height="400" rcrdImgType="large" alt="${fn:escapeXml(l.ctgr_name)}" /></a>
                                <div class="hide_util">
                                    <a href="/ht/record/detail/${l.sell_prdt_bcode}" target="_blank" class="nblank"><span>새창</span></a>
                                    <a href="javascript://" onclick="addMyListRecord('${l.rcrd_cd}')" class="zzim"><span>담기</span></a>
                                </div>
                            </span>
                            <a href="/ht/record/detail/${l.sell_prdt_bcode}">
                                <span class="make">${l.rcArtiName}</span>
                                <span class="name">${l.rcrd_name}</span>
                                <em class="price">
                                    <fmt:parseNumber var="prdt_sell_price" value="${l.prdt_sell_price}"/>
                                    <fmt:parseNumber var="fc_get_dc_price" value="${l.fc_get_dc_price}"/>
                                    <c:if test="${prdt_sell_price > fc_get_dc_price}"><span class="dc"><fmt:formatNumber value="${prdt_sell_price}" pattern="#,###"/></span></c:if>
                                    <span class="sale"><fmt:formatNumber value="${fc_get_dc_price}" pattern="#,###"/></span>
                                    <c:if test="${l.saleyn ne 'Y'}"><span class="pc"><img src="${imageServer}/images/renewal/common/ic_status_soldout.gif" alt="품절"/></span></c:if>
                                    <c:if test="${l.saleyn eq 'Y' && prdt_sell_price > fc_get_dc_price}"><span class="pc">${hfn:rate(prdt_sell_price, fc_get_dc_price)}%</span></c:if>
                                </em>
                            </a>
                        </li>
                    </c:if>
                    <!-- //CD -->
                    <!-- DVD -->
                    <c:if test="${fn:startsWith(l.categoryId, '0004')}">
                        <li>
                            <!-- AceCounter eCommerce (Product_Detail) v6.5 Start -->
                            <script language='javascript'>
                            _A_amt[_ace_countvar]="${l.fc_get_dc_price}";
                            _A_nl[_ace_countvar]="1";
                            _A_pl[_ace_countvar]="${l.sell_prdt_bcode}";
                            _A_pn[_ace_countvar]="${l.rcrd_name}";
                            _A_ct[_ace_countvar]="";    // ex) 음반/가요/락 -- 매핑불가능한 경우 '' 처리
                            _ace_countvar++;
                            </script>
                            <!-- AceCounter eCommerce (Product_detail) v6.4 Start -->
                            <span class="img">
                                <a href="/ht/record/detail/${l.sell_prdt_bcode}"><ui:image rcrdCd="${l.rcrd_cd}" prdtGbn="D" ratingCode="${l.rtngCode }" width="264" height="400" rcrdImgType="large" alt="${fn:escapeXml(l.ctgr_name)}" /></a>
                                <div class="hide_util">
                                    <a href="/ht/record/detail/${l.sell_prdt_bcode}" target="_blank" class="nblank"><span>새창</span></a>
                                    <a href="javascript://" onclick="addMyListDvd('${l.rcrd_cd}')" class="zzim"><span>담기</span></a>
                                </div>
                            </span>
                            <a href="/ht/record/detail/${l.sell_prdt_bcode}">
                                <span class="make">${l.rcArtiName}</span>
                                <span class="name">${l.rcrd_name}</span>
                                <em class="price">
                                    <fmt:parseNumber var="prdt_sell_price" value="${l.prdt_sell_price}"/>
                                    <fmt:parseNumber var="fc_get_dc_price" value="${l.fc_get_dc_price}"/>
                                    <c:if test="${prdt_sell_price > fc_get_dc_price}"><span class="dc"><fmt:formatNumber value="${prdt_sell_price}" pattern="#,###"/></span></c:if>
                                    <span class="sale"><fmt:formatNumber value="${fc_get_dc_price}" pattern="#,###"/></span>
                                    <c:if test="${l.saleyn ne 'Y'}"><span class="pc"><img src="${imageServer}/images/renewal/common/ic_status_soldout.gif" alt="품절"/></span></c:if>
                                    <c:if test="${l.saleyn eq 'Y' && prdt_sell_price > fc_get_dc_price}"><span class="pc">${hfn:rate(prdt_sell_price, fc_get_dc_price)}%</span></c:if>
                                </em>
                            </a>
                        </li>
                    </c:if>
                    <!-- //DVD -->
                </c:forEach>
            </ul>
        </c:forEach>
    </div>
</c:if>
<c:if test="${searchCriteria.viewType eq 'type03'}">
    <div class="prod_list_brd">
        <ul>
            <c:forEach items="${listProduct}" var="l" varStatus="st">
                <!-- 기프트 -->
                <c:if test="${fn:startsWith(l.categoryId, '0000')}">
                    <li>
                        <!-- AceCounter eCommerce (Product_Detail) v6.5 Start -->
                        <script language='javascript'>
                         _A_amt[_ace_countvar]="${l.productDcPrice}";
                         _A_nl[_ace_countvar]="1";
                         _A_pl[_ace_countvar]="${l.productBarcode}";
                         _A_pn[_ace_countvar]="${l.productName}";
                         _A_ct[_ace_countvar]="";    // ex) 음반/가요/락 -- 매핑불가능한 경우 '' 처리
                         _ace_countvar++;
                        </script>
                        <!-- AceCounter eCommerce (Product_detail) v6.4 Start -->
                        <div class="cover"><!-- 2014-10-02 수정 -->
                            <div>
                                <a href="/ht/product/detail?barcode=${l.productBarcode}" title="새창열림">
                                    <ui:image src="${l.productImageUrl}" server="product" size="100" alt="${fn:escapeXml(l.productName)}" style="width:96px;height:96px;"/>
                                </a>
                                <a href="/ht/product/detail?barcode=${l.productBarcode}" target="_blank" title="새창열림" class="blank"><span>새창</span></a>
                            </div>
                        </div>
                        <div class="p_txt">
                            <div class="txt_info">
                                <a href="/ht/product/detail?barcode=${l.productBarcode}" class="tit">${l.brandName} - ${l.productName}</a>
                            </div>
                            <span class="price">
                                <fmt:parseNumber var="productPrice" value="${l.productPrice}"/>
                                <fmt:parseNumber var="productDcPrice" value="${l.productDcPrice}"/>
                                <c:if test="${productPrice > productDcPrice}">
                                    <span class="ori_price"><fmt:formatNumber value="${productPrice}" type="number" /></span>
                                    <span class="dis_price"><strong><fmt:formatNumber value="${productDcPrice}" type="number" /></strong> (${hfn:rate(productPrice, productDcPrice)}%)</span>
                                </c:if>
                                <c:if test="${productPrice <= productDcPrice}">
                                    <span class="dis_price"><strong><fmt:formatNumber value="${productDcPrice}" type="number" /></strong></span>
                                </c:if>
                                <c:if test="${l.savedRate > 0}">
                                    <c:set var="savedPrice" value="${l.productDcPrice * l.savedRate / 100}"/>
                                    <span class="save_price"> | <fmt:formatNumber value="${savedPrice+(10-(savedPrice%10))%10}" type="number" />원 (${l.savedRate}%적립)</span>
                                </c:if>
                                <c:if test="${fn:substring(l.productIcon,13,14) eq 'X'}"><span class="pc"><img src="${imageServer}/images/renewal/common/ic_status_soldout.gif" alt="품절"/></span></c:if>
                            </span>
                        </div>
                        <div class="down">
                            <c:if test="${fn:substring(l.productIcon,13,14) ne 'X'}">
                                <a href="javascript://" onclick="addRecordCart('${l.productBarcode}')" class="btn_type01">장바구니</a>
                            </c:if>
                            <a href="javascript://" onclick="addWishProduct('${l.productBarcode}')" class="btn_type02">좋아요♥</a>
                        </div>
                    </li>
                </c:if>
                <!-- //기프트 -->
                <!-- CD -->
                <c:if test="${fn:startsWith(l.categoryId, '0003')}">
                    <li>
                        <!-- AceCounter eCommerce (Product_Detail) v6.5 Start -->
                        <script language='javascript'>
                        _A_amt[_ace_countvar]="${l.fc_get_dc_price}";
                        _A_nl[_ace_countvar]="1";
                        _A_pl[_ace_countvar]="${l.sell_prdt_bcode}";
                        _A_pn[_ace_countvar]="${l.rcrd_name}";
                        _A_ct[_ace_countvar]="";    // ex) 음반/가요/락 -- 매핑불가능한 경우 '' 처리
                        _ace_countvar++;
                        </script>
                        <!-- AceCounter eCommerce (Product_detail) v6.4 Start -->
                        <div class="cover"><!-- 2014-10-02 수정 -->
                            <div>
                                <a href="/ht/record/detail/${l.sell_prdt_bcode}" title="새창열림">
                                    <ui:image rcrdCd="${l.rcrd_cd}" prdtGbn="R" ratingCode="${l.rtngCode }" width="96" height="96" alt="${fn:escapeXml(l.rcArtiName)} - ${fn:escapeXml(l.rcrd_name)}" />
                                </a>
                                <a href="/ht/record/detail/${l.sell_prdt_bcode}" target="_blank" title="새창열림" class="blank"><span>새창</span></a>
                            </div>
                        </div>
                        <div class="p_txt">
                            <div class="txt_info">
                                <a href="/ht/record/detail/${l.sell_prdt_bcode}" class="tit">${l.rcArtiName} - ${l.rcrd_name}</a>
                            </div>
                            <span class="price">
                                <fmt:parseNumber var="prdt_sell_price" value="${l.prdt_sell_price}"/>
                                <fmt:parseNumber var="fc_get_dc_price" value="${l.fc_get_dc_price}"/>
                                <c:if test="${prdt_sell_price > fc_get_dc_price}">
                                    <span class="ori_price"><fmt:formatNumber value="${prdt_sell_price}" type="number" /></span>
                                    <span class="dis_price"><strong><fmt:formatNumber value="${fc_get_dc_price}" type="number" /></strong> (${hfn:rate(prdt_sell_price, fc_get_dc_price)}%)</span>
                                </c:if>
                                <c:if test="${prdt_sell_price <= fc_get_dc_price}">
                                    <span class="dis_price"><strong><fmt:formatNumber value="${prdt_sell_price}" type="number" /></strong></span>
                                </c:if>
                                <c:if test="${l.prdt_saved_rate_double > 0}">
                                    <c:set var="savedPrice" value="${l.fc_get_dc_price * l.prdt_saved_rate_double / 100}"/>
                                    <span class="save_price"> | <fmt:formatNumber value="${savedPrice+(10-(savedPrice%10))%10}" type="number" />원 (${l.prdt_saved_rate_double}%적립)</span>
                                </c:if>
                                <c:if test="${l.saleyn ne 'Y'}"><span class="pc"><img src="${imageServer}/images/renewal/common/ic_status_soldout.gif" alt="품절"/></span></c:if>
                            </span>
                        </div>
                        <div class="down">
                            <c:if test="${l.saleyn eq 'Y'}">
                                <a href="javascript://" onclick="addRecordCart('${l.sell_prdt_bcode}')" class="btn_type01">장바구니</a>
                                <a href="javascript://" onclick="addRecordBuy('${l.sell_prdt_bcode}')" class="btn_type02">바로구매</a>
                            </c:if>
                            <a href="javascript://" onclick="addWishProduct('${l.sell_prdt_bcode}')" class="btn_type02 zzim"><span>좋아요</span></a>
                        </div>
                    </li>
                </c:if>
                <!-- //CD -->
                <!-- DVD -->
                <c:if test="${fn:startsWith(l.categoryId, '0004')}">
                    <li>
                        <!-- AceCounter eCommerce (Product_Detail) v6.5 Start -->
                        <script language='javascript'>
                        _A_amt[_ace_countvar]="${l.fc_get_dc_price}";
                        _A_nl[_ace_countvar]="1";
                        _A_pl[_ace_countvar]="${l.sell_prdt_bcode}";
                        _A_pn[_ace_countvar]="${l.rcrd_name}";
                        _A_ct[_ace_countvar]="";    // ex) 음반/가요/락 -- 매핑불가능한 경우 '' 처리
                        _ace_countvar++;
                        </script>
                        <!-- AceCounter eCommerce (Product_detail) v6.4 Start -->
                        <div class="cover"><!-- 2014-10-02 수정 -->
                            <div>
                                <a href="/ht/record/detail/${l.sell_prdt_bcode}" title="새창열림">
                                    <ui:image rcrdCd="${l.rcrd_cd}" prdtGbn="D" ratingCode="${l.rtngCode }" width="63" height="96" alt="${fn:escapeXml(l.rcArtiName)} - ${fn:escapeXml(l.rcrd_name)}" />
                                </a>
                                <a href="/ht/record/detail/${l.sell_prdt_bcode}" target="_blank" title="새창열림" class="blank"><span>새창</span></a>
                            </div>
                        </div>
                        <div class="p_txt">
                            <div class="txt_info">
                                <a href="/ht/record/detail/${l.sell_prdt_bcode}" class="tit">${l.rcArtiName} - ${l.rcrd_name}</a>
                            </div>
                            <span class="price">
                                <fmt:parseNumber var="prdt_sell_price" value="${l.prdt_sell_price}"/>
                                <fmt:parseNumber var="fc_get_dc_price" value="${l.fc_get_dc_price}"/>
                                <c:if test="${prdt_sell_price > fc_get_dc_price}">
                                    <span class="ori_price"><fmt:formatNumber value="${prdt_sell_price}" type="number" /></span>
                                    <span class="dis_price"><strong><fmt:formatNumber value="${fc_get_dc_price}" type="number" /></strong> (${hfn:rate(prdt_sell_price, fc_get_dc_price)}%)</span>
                                </c:if>
                                <c:if test="${prdt_sell_price <= fc_get_dc_price}">
                                    <span class="dis_price"><strong><fmt:formatNumber value="${prdt_sell_price}" type="number" /></strong></span>
                                </c:if>
                                <c:if test="${l.prdt_saved_rate_double > 0}">
                                    <c:set var="savedPrice" value="${l.fc_get_dc_price * l.prdt_saved_rate_double / 100}"/>
                                    <span class="save_price"> | <fmt:formatNumber value="${savedPrice+(10-(savedPrice%10))%10}" type="number" />원 (${l.prdt_saved_rate_double}%적립)</span>
                                </c:if>
                                <c:if test="${l.saleyn ne 'Y'}"><span class="pc"><img src="${imageServer}/images/renewal/common/ic_status_soldout.gif" alt="품절"/></span></c:if>
                            </span>
                        </div>
                        <div class="down">
                            <c:if test="${l.saleyn eq 'Y'}">
                                <a href="javascript://" onclick="addRecordCart('${l.sell_prdt_bcode}')" class="btn_type01">장바구니</a>
                                <a href="javascript://" onclick="addRecordBuy('${l.sell_prdt_bcode}')" class="btn_type02">바로구매</a>
                            </c:if>
                            <a href="javascript://" onclick="addWishProduct('${l.sell_prdt_bcode}')" class="btn_type02 zzim"><span>좋아요</span></a>
                        </div>
                    </li>
                </c:if>
                <!-- //DVD -->
            </c:forEach>
        </ul>
    </div>
</c:if>
<div class="paging"><ui:paginationScript name="pageHolder" scriptName="srchPageMove"/></div><!-- end pager -->

<c:if test="${not empty listEvent}">
    <div class="tit_wrap02">
        <h2><img src="${imageServer}/images/renewal/shop/sub_tit16.gif" alt="hot event"/></h2><span>검색어와 매칭되는 이벤트입니다.</span>
    </div>
    
    <div class="event_list">
        <ul class="list">
            <c:forEach items="${listEvent}" var="l" varStatus="st">
                <li>
                    <a href="/ht/biz/eventDetail?eventId=${l.eventId}">
                        <span class="img"><ui:image src="${l.imageUrl}" alt="${l.eventTitle}" width="290px" height="140px"/></span>
                        <span class="tit">
                            <strong>${l.eventTitle}</strong>
                            <em>${l.eventDtlCont} </em>
                        </span>
                    </a>
                </li>
            </c:forEach>
        </ul>
    </div>
</c:if>
