<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="none"/>
<c:forEach items="${list}" varStatus="s1" step="2">
    <li>
        <c:forEach items="${list}" var="l" varStatus="st" begin="${s1.index}" end="${s1.index+1}">
            <div style="width:46%;margin-right:4%;text-align:center;">
                <a href="/m/gift/detail/${l.sellPrdtBcode}">
                    <p class="pic"><ui:image src="${l.productImageUrl}" server="product" alt="${fn:escapeXml(l.prdtName)}"/></p>
                    <span class="txt_box">
                        <em class="brand t_l">${l.brandEngName}</em>
                        <c:if test="${l.wishPrdtCnt ne 0}"><em class="wish"><fmt:formatNumber type="number">${l.wishPrdtCnt}</fmt:formatNumber></em></c:if>
                        <em class="tit t_l">${fn:escapeXml(l.prdtName)}</em>
                        <em class="price t_l"><strong><fmt:formatNumber type="number" value="${l.lastCpnPrice}"/>원 <c:if test="${l.prdtSellPrice ne l.lastCpnPrice}"><span class="sale">[<fmt:formatNumber type="number">${hfn:rate(l.prdtSellPrice, l.lastCpnPrice)}</fmt:formatNumber>%]</span></c:if></strong></em>
                        <c:if test="${l.dlvyVndrId eq '0625'}"><em class="delivery">[핫트랙스배송]</em></c:if>
                    </span>
                </a>
            </div>
        </c:forEach>
    </li>
</c:forEach>