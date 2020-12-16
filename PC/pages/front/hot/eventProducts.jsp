<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="none" />
<c:if test="${c.eventPrdtTypeCode eq 'C0241'}">
    <c:forEach items="${listMain}" var="l">
        <!-- pord -->
        <div class="event_detail">
            <div class="cover">
                <c:if test="${l.sellPrdtGbn eq 'R' || l.sellPrdtGbn eq 'D'}">
                    <a href="/ht/record/detail/${l.sellPrdtBcode}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" ratingCode="${l.rtngCode}" rcrdImgType="large" width="${l.sellPrdtGbn eq 'R'?'400':'264'}" clazz="photo" alt="${fn:escapeXml(l.prdtName)}"/></a>
                </c:if>
                <c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G' || l.sellPrdtGbn eq 'S'}">
                    <a href="/ht/product/detail?barcode=${l.sellPrdtBcode}"><ui:image src="${l.prdtImageUrl}" src2="${l.productImageUrl2}" size="400" server="product" clazz="photo" alt="${fn:escapeXml(l.prdtName)}"/></a>
                </c:if>
                <div class="hide_util">
                    <c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G' || l.sellPrdtGbn eq 'S'}">
                        <a href="javascript://" onclick="productPreview('${l.sellPrdtBcode}')" class="zoom"><span>확대</span></a>
                        <a href="/ht/product/detail?barcode=${l.sellPrdtBcode}" target="_blank" class="nblank"><span>새창</span></a>
                        <a href="javascript://" onclick="addWishProduct('${l.sellPrdtBcode}')" class="zzim"><span>좋아요</span></a>
                    </c:if>
                    <c:if test="${l.sellPrdtGbn eq 'R' || l.sellPrdtGbn eq 'D'}">
                        <a href="/ht/record/detail/${l.sellPrdtBcode}" target="_blank" class="nblank"><span>새창</span></a>
                        <a href="javascript://" onclick="addWishProduct('${l.sellPrdtBcode}')" class="zzim"><span>좋아요</span></a>
                    </c:if>
                </div>
            </div>
            <div class="detail_info">
                <a href="/p/${l.sellPrdtBcode}"><span class="brand">${l.brandName}</span></a>
                <h2 class="prod_tit">${fn:escapeXml(l.prdtName)}</h2>
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
                <ul>
                    <li>
                        <span class="tit">판매가</span>
                        <div class="price">
                            <c:if test="${l.prdtSellPrice ne l.lastCpnPrice}"><span class="ori_price"><fmt:formatNumber type="number">${l.prdtSellPrice}</fmt:formatNumber></span></c:if>
                            <strong><fmt:formatNumber type="number">${l.lastCpnPrice}</fmt:formatNumber></strong> (<fmt:formatNumber type="number">${hfn:rate(l.prdtSellPrice,l.lastCpnPrice)}</fmt:formatNumber>%)
                            <c:if test="${l.prdtStatCode ne 'C0312'}"><img src="${imageServer}/images/renewal/common/ic_status_soldout.gif" alt="품절"/></c:if>
                        </div>
                    </li>
                    <c:if test="${l.savedRate ne 0}">
                        <c:set var="savedPrice" value="${l.lastCpnPrice * l.savedRate / 100}"/>
                        <li>
                            <span class="tit">통합포인트</span>
                            <div>
                                <span class=""><fmt:formatNumber value="${savedPrice+(10-(savedPrice%10))%10}" pattern=",###" />원 (${l.savedRate}%적립)</span>
                                <div class="tooltip_wrap">
                                    <a href="#tooltip2" class="tooltip">?</a>
                                    <div id="tooltip2" class="layer_pop_wrap">
                                        <div class="layer_pop_container" style="width:289px;height:433px;">
                                            <h1>통합포인트 안내</h1>
                                            <div class="layer_pop_cont">
                                                <ul>
                                                    <li>•<strong>핫트랙스 온라인/오프라인, 교보문고 온라인/오프라인, 모바일 교보문고에서 모두 적립·사용 가능!</strong></li>
                                                    <li>•<strong>10원 이상의 포인트도 바로바로 사용! (영업점은 1,000원 단위 사용)</strong><br>주문 시, 10원 단위부터 사용하실 수 있습니다.</li>
                                                    <li>•<strong>자동적립되는 편리한 포인트!</strong><br>구매 후 어떤 절차나 과정없이 바로 자동으로 적립됩니다.</li>
                                                    <li>•<strong>포인트 확인도 폭넓~게!</strong><br>온라인 마이룸, 모바일, 무인가입기, 영업점 영수증 등에서 적립하거나 사용하신 포인트 내역을 확인하실 수 있습니다.<br>
                                                    상품 구매 시 해당 상품의 적립률에 따라 지급되며 고객님께서 주문하신 상품이 발송완료 된 후 자동 지급됩니다.<br>단, 쿠폰 또는 마일리지, 통합포인트 사용 시 예상적립금이 변동될 수 있습니다.<br>(주문취소나 반품시에는 적립된 통합포인트가 다시 차감됩니다.)</li>
                                                </ul>
                                            </div>
                                            <a href="#none" class="cls_btn" title="레이어팝업 닫기"><img src="${imageServer}/images/renewal/common/btn_cls.gif" alt="닫기"></a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </li>
                    </c:if>
                </ul>
                <div class="btn_wrap mgt20">
                    <c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G' || l.sellPrdtGbn eq 'S'}">
                        <a href="/ht/product/detail?barcode=${l.sellPrdtBcode}" class="btn_type03">구매하기</a>
                        <a href="javascript://" onclick="addWishProduct('${l.sellPrdtBcode}')" class="btn_type04">좋아요♥</a>
                    </c:if>
                    <c:if test="${l.sellPrdtGbn eq 'R' || l.sellPrdtGbn eq 'D'}">
                        <a href="/ht/record/detail/${l.sellPrdtBcode}" class="btn_type03">구매하기</a>
                        <a href="javascript://" onclick="addWishProduct('${l.sellPrdtBcode}')" class="btn_type04">담기</a>
                    </c:if>
                </div>
            </div>
        </div>
        <!-- //pord -->
    </c:forEach>
</c:if>
<c:if test="${c.eventPrdtTypeCode eq 'C0242' || c.eventPrdtTypeCode eq 'C0244'}">
    <div class="prod_list_large">
        <c:forEach items="${listMain}" step="2" varStatus="s1">
            <c:if test="${s1.first || fn:length(listMain)-s1.index > 1}">
            <ul>
                <c:forEach items="${listMain}" var="l" varStatus="st" begin="${s1.index}" end="${s1.index+1}">
                    <li>
                        <span class="img">
                            <c:if test="${l.sellPrdtGbn eq 'R' || l.sellPrdtGbn eq 'D'}">
                                <a href="/ht/record/detail/${l.sellPrdtBcode}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" ratingCode="${l.rtngCode}" rcrdImgType="large" width="${l.sellPrdtGbn eq 'R'?'400':'264'}" clazz="photo" alt="${fn:escapeXml(l.prdtName)}"/></a>
                            </c:if>
                            <c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G' || l.sellPrdtGbn eq 'S'}">
                                <a href="/ht/product/detail?barcode=${l.sellPrdtBcode}"><ui:image src="${l.prdtImageUrl}" src2="${l.productImageUrl2}" size="400" server="product" clazz="photo" alt="${fn:escapeXml(l.prdtName)}"/></a>
                            </c:if>
                            <div class="hide_util">
                                <c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G' || l.sellPrdtGbn eq 'S'}">
                                    <a href="javascript://" onclick="productPreview('${l.sellPrdtBcode}')" class="zoom"><span>확대</span></a>
                                    <a href="/ht/product/detail?barcode=${l.sellPrdtBcode}" target="_blank" class="nblank"><span>새창</span></a>
                                    <a href="javascript://" onclick="addWishProduct('${l.sellPrdtBcode}')" class="zzim"><span>좋아요</span></a>
                                </c:if>
                                <c:if test="${l.sellPrdtGbn eq 'R' || l.sellPrdtGbn eq 'D' }">
                                    <a href="/ht/record/detail/${l.sellPrdtBcode}" target="_blank" class="nblank"><span>새창</span></a>
                                    <a href="javascript://" onclick="addWishProduct('${l.sellPrdtBcode}')" class="zzim"><span>좋아요</span></a>
                                </c:if>
                            </div>
                        </span>
                        <c:if test="${c.prdtInfoExpsYn eq 'Y'}">
                        <a href="/p/${l.sellPrdtBcode}">
                            <span class="make txt_line1">${l.brandName}</span>
                            <span class="name">${fn:escapeXml(l.prdtName)}</span>
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
                                <c:if test="${l.prdtSellPrice eq l.lastCpnPrice}">
                                    <span class="sale"><fmt:formatNumber type="number">${l.prdtSellPrice}</fmt:formatNumber></span>
                                    <c:if test="${l.prdtStatCode ne 'C0312'}"><span class="pc"><img src="${imageServer}/images/renewal/common/ic_status_soldout.gif" alt="품절"/></span></c:if>
                                </c:if>
                                <c:if test="${l.prdtSellPrice ne l.lastCpnPrice}">
                                    <span class="dc"><fmt:formatNumber type="number">${l.prdtSellPrice}</fmt:formatNumber></span>
                                    <span class="sale"><fmt:formatNumber type="number">${l.lastCpnPrice}</fmt:formatNumber></span>
                                    <c:if test="${l.prdtStatCode ne 'C0312'}"><span class="pc"><img src="${imageServer}/images/renewal/common/ic_status_soldout.gif" alt="품절"/></span></c:if>
                                    <c:if test="${l.prdtStatCode eq 'C0312'}"><span class="pc"><fmt:formatNumber type="number">${hfn:rate(l.prdtSellPrice,l.lastCpnPrice)}</fmt:formatNumber>%</span></c:if>
                                </c:if>
                            </em>
                        </a>
                        </c:if>
                    </li>
                </c:forEach>
            </ul>
            </c:if>
        </c:forEach>
    </div>
</c:if>
<c:if test="${c.eventPrdtTypeCode eq 'C0243'}">
    <div class="prod_list_large02 mgb25">
        <c:forEach items="${listMain}" step="3" varStatus="s1">
            <c:if test="${s1.first || fn:length(listMain)-s1.index > 2}">
            <ul>
                <c:forEach items="${listMain}" var="l" varStatus="st" begin="${s1.index}" end="${s1.index+2}">
                    <li>
                        <span class="img">
                            <c:if test="${l.sellPrdtGbn eq 'R' || l.sellPrdtGbn eq 'D'}">
                                <a href="/ht/record/detail/${l.sellPrdtBcode}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" ratingCode="${l.rtngCode}" rcrdImgType="large" width="${l.sellPrdtGbn eq 'R'?'400':'264'}" clazz="photo" alt="${fn:escapeXml(l.prdtName)}"/></a>
                            </c:if>
                            <c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G' || l.sellPrdtGbn eq 'S'}">
                                <a href="/ht/product/detail?barcode=${l.sellPrdtBcode}"><ui:image src="${l.prdtImageUrl}" src2="${l.productImageUrl2}" size="400" server="product" clazz="photo" alt="${fn:escapeXml(l.prdtName)}"/></a>
                            </c:if>
                            <div class="hide_util">
                                <c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G' || l.sellPrdtGbn eq 'S'}">
                                    <a href="javascript://" onclick="productPreview('${l.sellPrdtBcode}')" class="zoom"><span>확대</span></a>
                                    <a href="/ht/product/detail?barcode=${l.sellPrdtBcode}" target="_blank" class="nblank"><span>새창</span></a>
                                    <<a href="javascript://" onclick="addWishProduct('${l.sellPrdtBcode}')" class="zzim"><span>좋아요</span></a>
                                </c:if>
                                <c:if test="${l.sellPrdtGbn eq 'R' || l.sellPrdtGbn eq 'D'}">
                                    <a href="/ht/record/detail/${l.sellPrdtBcode}" target="_blank" class="nblank"><span>새창</span></a>
                                    <a href="javascript://" onclick="addWishProduct('${l.sellPrdtBcode}')" class="zzim"><span>좋아요</span></a>
                                </c:if>`
                            </div>
                        </span>
                        <c:if test="${c.prdtInfoExpsYn eq 'Y'}">
                        <a href="/p/${l.sellPrdtBcode}">
                            <span class="make txt_line1">${l.brandName}</span>
                            <span class="name">${fn:escapeXml(l.prdtName)}</span>
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
                                <c:if test="${l.prdtSellPrice eq l.lastCpnPrice}">
                                    <span class="sale"><fmt:formatNumber type="number">${l.prdtSellPrice}</fmt:formatNumber></span>
                                    <c:if test="${l.prdtStatCode ne 'C0312'}"><span class="pc"><img src="${imageServer}/images/renewal/common/ic_status_soldout.gif" alt="품절"/></span></c:if>
                                </c:if>
                                <c:if test="${l.prdtSellPrice ne l.lastCpnPrice}">
                                    <span class="dc"><fmt:formatNumber type="number">${l.prdtSellPrice}</fmt:formatNumber></span>
                                    <span class="sale"><fmt:formatNumber type="number">${l.lastCpnPrice}</fmt:formatNumber></span>
                                    <c:if test="${l.prdtStatCode ne 'C0312'}"><span class="pc"><img src="${imageServer}/images/renewal/common/ic_status_soldout.gif" alt="품절"/></span></c:if>
                                    <c:if test="${l.prdtStatCode eq 'C0312'}"><span class="pc"><fmt:formatNumber type="number">${hfn:rate(l.prdtSellPrice,l.lastCpnPrice)}</fmt:formatNumber>%</span></c:if>
                                </c:if>
                            </em>
                        </a>
                        </c:if>
                    </li>
                </c:forEach>
            </ul>
            </c:if>
        </c:forEach>
    </div>
</c:if>
<c:if test="${c.eventPrdtTypeCode eq 'C0245'}">
    <div class="prod_list_normal mgb25">
        <c:forEach items="${listMain}" step="4" varStatus="s1">
            <c:if test="${s1.first || fn:length(listMain)-s1.index > 3}">
            <ul>
                <c:forEach items="${listMain}" var="l" varStatus="st" begin="${s1.index}" end="${s1.index+3}">
                    <li>
                        <span class="img">
                            <c:if test="${l.sellPrdtGbn eq 'R' || l.sellPrdtGbn eq 'D'}">
                                <a href="/ht/record/detail/${l.sellPrdtBcode}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" ratingCode="${l.rtngCode}" rcrdImgType="large" width="${l.sellPrdtGbn eq 'R'?'200':'132'}" clazz="photo" alt="${fn:escapeXml(l.prdtName)}"/></a>
                            </c:if>
                            <c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G' || l.sellPrdtGbn eq 'S'}">
                                <a href="/ht/product/detail?barcode=${l.sellPrdtBcode}"><ui:image src="${l.prdtImageUrl}" src2="${l.productImageUrl2}" size="200" server="product" clazz="photo" alt="${fn:escapeXml(l.prdtName)}"/></a>
                            </c:if>
                            <div class="hide_util">
                                <c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G' || l.sellPrdtGbn eq 'S'}">
                                    <a href="javascript://" onclick="productPreview('${l.sellPrdtBcode}')" class="zoom"><span>확대</span></a>
                                    <a href="/ht/product/detail?barcode=${l.sellPrdtBcode}" target="_blank" class="nblank"><span>새창</span></a>
                                    <a href="javascript://" onclick="addWishProduct('${l.sellPrdtBcode}')" class="zzim"><span>좋아요</span></a>
                                </c:if>
                                <c:if test="${l.sellPrdtGbn eq 'R' || l.sellPrdtGbn eq 'D'}">
                                    <a href="/ht/record/detail/${l.sellPrdtBcode}" target="_blank" class="nblank"><span>새창</span></a>
                                    <a href="javascript://" onclick="addWishProduct('${l.sellPrdtBcode}')" class="zzim"><span>좋아요</span></a>
                                </c:if>
                            </div>
                        </span>
                        <c:if test="${c.prdtInfoExpsYn eq 'Y'}">
                        <a href="/p/${l.sellPrdtBcode}">
                            <span class="make txt_line1">${l.brandName}</span>
                            <span class="name">${fn:escapeXml(l.prdtName)}</span>
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
                                <c:if test="${l.prdtSellPrice eq l.lastCpnPrice}">
                                    <span class="sale"><fmt:formatNumber type="number">${l.prdtSellPrice}</fmt:formatNumber></span>
                                    <c:if test="${l.prdtStatCode ne 'C0312'}"><span class="pc"><img src="${imageServer}/images/renewal/common/ic_status_soldout.gif" alt="품절"/></span></c:if>
                                </c:if>
                                <c:if test="${l.prdtSellPrice ne l.lastCpnPrice}">
                                    <span class="dc"><fmt:formatNumber type="number">${l.prdtSellPrice}</fmt:formatNumber></span>
                                    <span class="sale"><fmt:formatNumber type="number">${l.lastCpnPrice}</fmt:formatNumber></span>
                                    <c:if test="${l.prdtStatCode ne 'C0312'}"><span class="pc"><img src="${imageServer}/images/renewal/common/ic_status_soldout.gif" alt="품절"/></span></c:if>
                                    <c:if test="${l.prdtStatCode eq 'C0312'}"><span class="pc"><fmt:formatNumber type="number">${hfn:rate(l.prdtSellPrice,l.lastCpnPrice)}</fmt:formatNumber>%</span></c:if>
                                </c:if>
                            </em>
                        </a>
                        </c:if>
                    </li>
                </c:forEach>
            </ul>
            </c:if>
        </c:forEach>
    </div>
</c:if>
<c:if test="${c.eventPrdtTypeCode eq 'C0244'}">
    <div class="prod_list_large">
        <c:forEach items="${listProduct}" step="2" varStatus="s1">
            <c:if test="${s1.first || fn:length(listProduct)-s1.index > 1}">
            <ul>
                <c:forEach items="${listProduct}" var="l" varStatus="st" begin="${s1.index}" end="${s1.index+1}">
                    <li>
                        <span class="img">
                            <c:if test="${l.sellPrdtGbn eq 'R' || l.sellPrdtGbn eq 'D'}">
                                <a href="/ht/record/detail/${l.sellPrdtBcode}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" ratingCode="${l.rtngCode}" rcrdImgType="large" width="${l.sellPrdtGbn eq 'R'?'400':'264'}" clazz="photo" alt="${fn:escapeXml(l.prdtName)}"/></a>
                            </c:if>
                            <c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G' || l.sellPrdtGbn eq 'S'}">
                                <a href="/ht/product/detail?barcode=${l.sellPrdtBcode}"><ui:image src="${l.prdtImageUrl}" src2="${l.productImageUrl2}" size="400" server="product" clazz="photo" alt="${fn:escapeXml(l.prdtName)}"/></a>
                            </c:if>
                            <div class="hide_util">
                                <c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G' || l.sellPrdtGbn eq 'S'}">
                                    <a href="javascript://" onclick="productPreview('${l.sellPrdtBcode}')" class="zoom"><span>확대</span></a>
                                    <a href="/ht/product/detail?barcode=${l.sellPrdtBcode}" target="_blank" class="nblank"><span>새창</span></a>
                                    <a href="javascript://" onclick="addWishProduct('${l.sellPrdtBcode}')" class="zzim"><span>좋아요</span></a>
                                </c:if>
                                <c:if test="${l.sellPrdtGbn eq 'R' || l.sellPrdtGbn eq 'D'}">
                                    <a href="/ht/record/detail/${l.sellPrdtBcode}" target="_blank" class="nblank"><span>새창</span></a>
                                    <a href="javascript://" onclick="addWishProduct('${l.sellPrdtBcode}')" class="zzim"><span>좋아요</span></a>
                                </c:if>
                            </div>
                        </span>
                        <c:if test="${c.prdtInfoExpsYn eq 'Y'}">
                        <a href="/p/${l.sellPrdtBcode}">
                            <span class="make txt_line1">${l.brandName}</span>
                            <span class="name">${fn:escapeXml(l.prdtName)}</span>
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
                                <c:if test="${l.prdtSellPrice eq l.lastCpnPrice}">
                                    <span class="sale"><fmt:formatNumber type="number">${l.prdtSellPrice}</fmt:formatNumber></span>
                                    <c:if test="${l.prdtStatCode ne 'C0312'}"><span class="pc"><img src="${imageServer}/images/renewal/common/ic_status_soldout.gif" alt="품절"/></span></c:if>
                                </c:if>
                                <c:if test="${l.prdtSellPrice ne l.lastCpnPrice}">
                                    <span class="dc"><fmt:formatNumber type="number">${l.prdtSellPrice}</fmt:formatNumber></span>
                                    <span class="sale"><fmt:formatNumber type="number">${l.lastCpnPrice}</fmt:formatNumber></span>
                                    <c:if test="${l.prdtStatCode ne 'C0312'}"><span class="pc"><img src="${imageServer}/images/renewal/common/ic_status_soldout.gif" alt="품절"/></span></c:if>
                                    <c:if test="${l.prdtStatCode eq 'C0312'}"><span class="pc"><fmt:formatNumber type="number">${hfn:rate(l.prdtSellPrice,l.lastCpnPrice)}</fmt:formatNumber>%</span></c:if>
                                </c:if>
                            </em>
                        </a>
                        </c:if>
                    </li>
                </c:forEach>
            </ul>
            </c:if>
        </c:forEach>
    </div>
</c:if>
<c:if test="${not empty listProduct && (c.eventPrdtTypeCode eq 'C0241' || c.eventPrdtTypeCode eq 'C0242' || c.eventPrdtTypeCode eq 'C0243' || c.eventPrdtTypeCode eq 'C0245')}">
    <div class="prod_list_normal">
        <c:forEach items="${listProduct}" step="4" varStatus="s1">
            <c:if test="${s1.first || c.eventPrdtTypeCode eq 'C0245' || fn:length(listProduct)-s1.index > 3}">
            <ul>
                <c:forEach items="${listProduct}" var="l" varStatus="st" begin="${s1.index}" end="${s1.index+3}">
                    <li>
                        <span class="img">
                            <c:if test="${l.sellPrdtGbn eq 'R' || l.sellPrdtGbn eq 'D'}">
                                <a href="/ht/record/detail/${l.sellPrdtBcode}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" ratingCode="${l.rtngCode}" rcrdImgType="large" width="${l.sellPrdtGbn eq 'R'?'200':'132'}" clazz="photo" alt="${fn:escapeXml(l.prdtName)}"/></a>
                            </c:if>
                            <c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G' || l.sellPrdtGbn eq 'S'}">
                                <a href="/ht/product/detail?barcode=${l.sellPrdtBcode}"><ui:image src="${l.prdtImageUrl}" src2="${l.productImageUrl2}" size="200" server="product" clazz="photo" alt="${fn:escapeXml(l.prdtName)}"/></a>
                            </c:if>
                            <div class="hide_util">
                                <c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G' || l.sellPrdtGbn eq 'S'}">
                                    <a href="javascript://" onclick="productPreview('${l.sellPrdtBcode}')" class="zoom"><span>확대</span></a>
                                    <a href="/ht/product/detail?barcode=${l.sellPrdtBcode}" target="_blank" class="nblank"><span>새창</span></a>
                                    <a href="javascript://" onclick="addWishProduct('${l.sellPrdtBcode}')" class="zzim"><span>좋아요</span></a>
                                </c:if>
                                <c:if test="${l.sellPrdtGbn eq 'R' || l.sellPrdtGbn eq 'D'}">
                                    <a href="/ht/record/detail/${l.sellPrdtBcode}" target="_blank" class="nblank"><span>새창</span></a>
                                    <a href="javascript://" onclick="addWishProduct('${l.sellPrdtBcode}')" class="zzim"><span>좋아요</span></a>
                                </c:if>
                            </div>
                        </span>
                        <c:if test="${c.prdtInfoExpsYn eq 'Y'}">
                        <a href="/p/${l.sellPrdtBcode}">
                            <span class="make txt_line1">${l.brandName}</span>
                            <span class="name">${fn:escapeXml(l.prdtName)}</span>
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
                                <c:if test="${l.prdtSellPrice eq l.lastCpnPrice}">
                                    <span class="sale"><fmt:formatNumber type="number">${l.prdtSellPrice}</fmt:formatNumber></span>
                                    <c:if test="${l.prdtStatCode ne 'C0312'}"><span class="pc"><img src="${imageServer}/images/renewal/common/ic_status_soldout.gif" alt="품절"/></span></c:if>
                                </c:if>
                                <c:if test="${l.prdtSellPrice ne l.lastCpnPrice}">
                                    <span class="dc"><fmt:formatNumber type="number">${l.prdtSellPrice}</fmt:formatNumber></span>
                                    <span class="sale"><fmt:formatNumber type="number">${l.lastCpnPrice}</fmt:formatNumber></span>
                                    <c:if test="${l.prdtStatCode ne 'C0312'}"><span class="pc"><img src="${imageServer}/images/renewal/common/ic_status_soldout.gif" alt="품절"/></span></c:if>
                                    <c:if test="${l.prdtStatCode eq 'C0312'}"><span class="pc"><fmt:formatNumber type="number">${hfn:rate(l.prdtSellPrice,l.lastCpnPrice)}</fmt:formatNumber>%</span></c:if>
                                </c:if>
                            </em>
                        </a>
                        </c:if>
                    </li>
                </c:forEach>
            </ul>
            </c:if>
        </c:forEach>
    </div>
</c:if>