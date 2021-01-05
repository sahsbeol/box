<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="none"/>
<c:forEach items="${list}" varStatus="s1" step="2" end="9">
    <li>
        <c:forEach items="${list}" var="l" varStatus="st" begin="${s1.index}" end="${s1.index+1}">
            <div style="width:46%;margin-right:4%;text-align:center;">
                <a href="/p/${l.sellPrdtBcode}" title="${l.prdtName}">
                    <span class="best">BEST<strong>${l.rank}</strong></span>
                    <p class="pic<c:if test="${fn:substring(c.ctgrId,0,4) eq '0004'}"> dvd</c:if>"><ui:image prdtGbn="${l.sellPrdtGbn}" rcrdCd="${l.rcrdCd}" ratingCode="${l.rtngCode}" alt="${fn:escapeXml(l.prdtName)}"/></p>
                    <p class="brand t_l">${l.artiName}</p>
                    <p class="tit t_l">${l.commTitle}</p>
                    <p class="price t_l"><strong><fmt:formatNumber type="number">${l.lastCpnPrice}</fmt:formatNumber>원 <c:if test="${l.prdtSellPrice > l.lastCpnPrice}"><span class="sale">[${hfn:rate(l.prdtSellPrice,l.lastCpnPrice)}%]</span></c:if></strong></p>
                </a>
            </div>
        </c:forEach>
    </li>
</c:forEach>
