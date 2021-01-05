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
            <div style="width:48%;margin-right:2%;text-align:center;">
                <c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G' || l.sellPrdtGbn eq 'S'}">
                    <a href="/m/gift/detail/${l.sellPrdtBcode}">
                        <p class="pic"><ui:image src="${l.productImageUrl}" server="product" alt="${fn:escapeXml(l.prdtName)}" /></p>
                        <p class="brand t_l">${l.brandEngName}</p>
                        <p class="tit t_l">${fn:escapeXml(l.prdtName)}</p>
                    </a>
                </c:if>
                <c:if test="${l.sellPrdtGbn eq 'R' || l.sellPrdtGbn eq 'D'}">
                    <a href="/m/record/detail/${l.sellPrdtBcode}">
                        <p class="pic<c:if test="${l.sellPrdtGbn eq 'D'}"> dvd</c:if>"><ui:image prdtGbn="${l.sellPrdtGbn}" rcrdCd="${l.rcrdCd}" ratingCode="A" alt="${fn:escapeXml(l.prdtName)}"/></span>
                        <p class="brand t_l">${l.artiName}</p>
                        <p class="tit t_l"><strong>${fn:escapeXml(l.prdtName)}</strong></p>
                    </a>
                </c:if>
            </div>
        </c:forEach>
    </li>
</c:forEach>
