<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<div class="prod_box">
    <c:if test="${empty list}">
        <p class="info t_c">해당 분류의 상품이 존재하지 않습니다.</p>
    </c:if>
    <c:forEach items="${list}" var="l" varStatus="st">
        <a href="/m/record/detail/${l.sellPrdtBcode}">
            <c:if test="${not empty param.best && param.best eq 'Y'}"><span class="best">BEST<strong>${l.dispOrder}</strong></span></c:if>
            <c:choose>
                <c:when test="${param.lazy eq 'Y' && st.index > 7}">
                    <c:choose>
                        <c:when test="${l.sellPrdtGbn eq 'R'}"><span class="pic"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="R" ratingCode="${l.rtngCode }" alt="${l.prdtName}" lazy="Y" clazz="lazy"/></span></c:when>
                        <c:when test="${l.sellPrdtGbn eq 'D'}"><span class="pic dvd"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="R" ratingCode="${l.rtngCode }" alt="${l.prdtName}" lazy="Y" clazz="lazy"/></span></c:when>
                        <c:otherwise>
                            <span class="pic"><ui:image src="${l.productImageUrl}" server="product" alt="${fn:escapeXml(l.prdtName)}" lazy="Y" clazz="lazy"/></span>
                        </c:otherwise>
                    </c:choose>
                </c:when>
                <c:otherwise>
                    <c:choose>
                        <c:when test="${l.sellPrdtGbn eq 'R'}"><span class="pic"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="R" ratingCode="${l.rtngCode }" alt="${l.prdtName}"/></span></c:when>
                        <c:when test="${l.sellPrdtGbn eq 'D'}"><span class="pic dvd"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="R" ratingCode="${l.rtngCode }" alt="${l.prdtName}"/></span></c:when>
                        <c:otherwise>
                            <span class="pic"><ui:image src="${l.productImageUrl}" server="product" alt="${fn:escapeXml(l.prdtName)}"/></span>
                        </c:otherwise>
                    </c:choose>
                </c:otherwise>
            </c:choose>
            <span class="txt_box">
                <em class="brand">${l.artiName}</em>
                <em class="tit">${fn:escapeXml(l.prdtName)}</em>
                <em class="price"><fmt:formatNumber type="number" value="${l.lastCpnPrice}"/>원</em>
                <c:if test="${l.prdtSellPrice ne l.lastCpnPrice}"><em class="sale">[<fmt:formatNumber type="number">${hfn:rate(l.prdtSellPrice, l.lastCpnPrice)}</fmt:formatNumber>%]</em></c:if>
            </span>
            <span class="ico_box">
                <c:set var="reviewCount" value="${l.reviewCount}"/>
                <c:set var="wishPrdtCnt" value="${l.wishPrdtCnt}"/>
                <c:if test="${l.reviewCount > 99}"><c:set var="reviewCount" value="99+"/></c:if>
                <c:if test="${l.wishPrdtCnt > 99}"><c:set var="wishPrdtCnt" value="99+"/></c:if>
                <c:if test="${l.reviewCount > 0}"><em class="ico_review">${reviewCount}</em></c:if>
                <c:if test="${l.wishPrdtCnt > 0}"><em class="ico_like">${wishPrdtCnt}</em></c:if>
            </span>
            <span class="bnf_box">
                <c:choose>
                    <c:when test="${l.rcrdStat eq '2' || l.rcrdStat eq '3' || l.rcrdStat eq '4'}"><em class="soldout">품절</em></c:when>
                    <c:otherwise>
                        <c:if test="${l.lastDcPrice >= 20000}"><em class="ico_free">무료배송</em></c:if>
                    </c:otherwise>
                </c:choose>
            </span>
        </a>
    </c:forEach>
</div>