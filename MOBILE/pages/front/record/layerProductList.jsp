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
                <a href="/m/record/detail/${l.sellPrdtBcode}">
                    <p class="pic"><ui:image prdtGbn="${l.sellPrdtGbn}" rcrdCd="${l.rcrdCd}" ratingCode="${l.rtngCode}" alt="${fn:escapeXml(l.prdtName)}"/></p>
                    <p class="brand t_l">${l.artiName}</p>
                    <p class="tit t_l">${fn:escapeXml(l.prdtName)}</p>
                    <p class="price t_l">${l.lastCpnPrice}원 <c:if test="${l.prdtSellPrice ne l.lastCpnPrice}"><span class="sale">[${l.lastDcRate}%]</span></c:if></p>
                </a>
            </div>
        </c:forEach>
    </li>
</c:forEach>
