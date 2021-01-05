<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="none"/>
<c:forEach items="${listRecobell}" var="l" begin="0" end="2">
	<li>
		<span>
			<c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G'}">
				<ui:image src="${l.productImageUrl}" server="product" alt="${fn:escapeXml(l.prdtName)}"/>
			</c:if>
			<c:if test="${l.sellPrdtGbn eq 'R'}">
				<ui:image rcrdCd="${l.rcrdCd}" prdtGbn="R" ratingCode="A" alt="${fn:escapeXml(l.prdtName)}"/>
			</c:if>
			<c:if test="${l.sellPrdtGbn eq 'D'}">
				<ui:image rcrdCd="${l.rcrdCd}" prdtGbn="D" ratingCode="A" alt="${fn:escapeXml(l.prdtName)}"/>
			</c:if>
		</span>
		<div class='desc_recomm lst_desc'>
			<h4>${l.prdtName}</h4>
			<em class='rec_prc font_t'><fmt:formatNumber type="number">${l.lastCpnPrice}</fmt:formatNumber></em>
			<c:if test="${not empty rate}">
			<em class='rec_per font_t'>${rate}%</em>
			</c:if>
		</div>
		<a href="javascript:;" onclick="location.href='/p/${l.sellPrdtBcode}?foo=bar&rccode=mo_main3';return false;"></a>
	</li>
</c:forEach>
