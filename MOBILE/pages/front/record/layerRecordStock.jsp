<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="none"/>
<div class="ly_stock_box">
<div class="col_red t_l mt5 ml5">
	<p>영업점 재고는 고객님의 편의를 위해 제공된 것이며,</p>
	<p><strong>구매 가능한 수량과 차이가 날 수 있습니다.</strong></p>
	<p><strong>할인가는 영업점과 상이할 수 있습니다.</strong></p>
	<p><strong>방문 전 해당 영업점에 "꼭" 문의 바랍니다.</strong></p>
	<p class="col_grey">"문의"는 소량재고를, "100+"는 100장 이상 재고를 나타냅니다.</p>
</div>
<table class="table mt10">
    <c:forEach items="${list}" var="l" varStatus="st">
        <tr>
            <th scope="col" colspan="5">
                ${l.locGbnName}
                <c:choose>
                    <c:when test="${l.stockQty <= 0}"><span>0</span></c:when>
                    <c:when test="${l.stockQty <= 5}"><span>(문의)</span></c:when>
                    <c:when test="${l.stockQty > 100}"><span>(100+)</span></c:when>
                    <c:otherwise>(${l.stockQty})</c:otherwise>
                </c:choose>
            </th>
        </tr>
        <c:forEach items="${l.childList}" varStatus="s1" step="5">
            <tr>
                <c:set var="sp" value="5"/>
                <c:forEach items="${l.childList}" var="child" begin="${s1.index}" end="${s1.index+4}">
                    <c:set var="sp" value="${sp-1}"/>
                    <td>
                        <strong><a href="tel:${child.rdpTlnm }">${child.rdpName}</a></strong>
                        <c:choose>
                            <c:when test="${child.stockQty <= 0}"><span>0</span></c:when>
                            <c:when test="${child.stockQty <= 5}"><span>(문의)</span></c:when>
                            <c:when test="${child.stockQty > 100}"><span>100+</span></c:when>
                            <c:otherwise><span>${child.stockQty}</span></c:otherwise>
                        </c:choose>
                    </td>
                </c:forEach>
                <c:forEach begin="1" end="${sp}">
                    <td>
                        <strong>&nbsp;</strong>
                        <span>&nbsp;</span>
                    </td>
                </c:forEach>
            </tr>
        </c:forEach>
    </c:forEach>
</table>