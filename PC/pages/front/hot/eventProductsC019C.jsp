<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="none" />
<div id="PROD_${c.eventTypeInseq}" class="prod_list_normal">
    <c:forEach items="${listProduct}" step="6" varStatus="s0">
        <div id="PROD_${c.eventTypeInseq}_${s0.count}" class="prod_page<c:if test="${s0.first}"> active</c:if>">
            <c:forEach items="${listProduct}" step="3" varStatus="s1" begin="${s0.index}" end="${s0.index+5}">
                <ul>
                    <c:forEach items="${listProduct}" var="l" varStatus="st" begin="${s1.index}" end="${s1.index+2}">
                        <li>
                            <span class="img">
                                <c:if test="${l.sellPrdtGbn eq 'R' || l.sellPrdtGbn eq 'D'}">
                                    <a href="/ht/record/detail/${l.sellPrdtBcode}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" ratingCode="${l.rtngCode}" rcrdImgType="large" width="${l.sellPrdtGbn eq 'R'?'150':'99'}" clazz="photo" alt="${fn:escapeXml(l.prdtName)}"/></a>
                                </c:if>
                                <c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G' || l.sellPrdtGbn eq 'S'}">
                                    <a href="/ht/product/detail?barcode=${l.sellPrdtBcode}"><ui:image src="${l.prdtImageUrl}" src2="${l.productImageUrl2}" size="150" server="product" clazz="photo" alt="${fn:escapeXml(l.prdtName)}"/></a>
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
                            <a href="/p/${l.sellPrdtBcode}">
                                <span class="make txt_line1">${l.brandName}</span>
                                <span class="name">${fn:escapeXml(l.prdtName)}</span>
                                <em class="price">
                                    <c:if test="${l.prdtSellPrice eq l.lastCpnPrice}">
                                        <span class="sale"><fmt:formatNumber type="number">${l.prdtSellPrice}</fmt:formatNumber></span>
                                    </c:if>
                                    <c:if test="${l.prdtSellPrice ne l.lastCpnPrice}">
                                        <span class="dc"><fmt:formatNumber type="number">${l.prdtSellPrice}</fmt:formatNumber></span>
                                        <span class="sale"><fmt:formatNumber type="number">${l.lastCpnPrice}</fmt:formatNumber></span>
                                        <c:if test="${l.prdtStatCode ne 'C0312'}"><span class="pc"><img src="${imageServer}/images/renewal/common/ic_status_soldout.gif" alt="품절"/></span></c:if>
                                        <c:if test="${l.prdtStatCode eq 'C0312'}"><span class="pc"><fmt:formatNumber type="number">${hfn:rate(l.prdtSellPrice,l.lastCpnPrice)}</fmt:formatNumber>%</span></c:if>
                                    </c:if>
                                </em>
                            </a>
                        </li>
                    </c:forEach>
                </ul>
            </c:forEach>
        </div>
    </c:forEach>
    <div class="prod_page_navi">
        <c:forEach items="${listProduct}" step="6" varStatus="s0">
            <a href="javascript://" id="PROD_${c.eventTypeInseq}_${s0.count}_page" <c:if test="${s0.first}"> class="active"</c:if> onmouseover="pageC019C('PROD_${c.eventTypeInseq}', '${s0.count}')">${s0.count}번째 페이지</a>
        </c:forEach>
    </div>
</div>