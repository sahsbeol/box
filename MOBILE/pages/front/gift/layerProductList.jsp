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
            <div style="width:48%;margin-right:2%;">
                <a href="/m/gift/detail/${l.sellPrdtBcode}">
                    <span class="pic"><ui:image src="${l.productImageUrl}" server="product" alt="${fn:escapeXml(l.prdtName)}" /></span>
                    <span class="brand">${l.brandEngName}</span>
                    <strong class="tit">${fn:escapeXml(l.prdtName)}</strong>
                    <em class="price">${l.lastCpnPrice}원 <c:if test="${l.prdtSellPrice ne l.lastCpnPrice}"><span class="sale">[<fmt:formatNumber type="number">${hfn:rate(l.prdtSellPrice, l.lastCpnPrice)}</fmt:formatNumber>%]</span></c:if></em>
                </a>
            </div>
        </c:forEach>
    </li>
</c:forEach>
