<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="none"/>
<ul class="br_list mb30">
    <c:if test="${empty list && c.page eq 1}">
        <li class="line bg_eeeeee"><strong>${c.srchMaxDate}개월 이내에 고객님께서 사용/적립하신 내역이 존재하지 않습니다.</strong></li>
    </c:if>
    <c:forEach items="${list}" var="l" varStatus="st">
        <li class="line bg_eeeeee">
            <strong class="fl_l"><fmt:formatDate value="${l.modDtm}" pattern="yyyy.MM.dd"/></strong>
        </li>
        <li>
            <strong class="fl_l">${l.modRsnCont}</strong>
            <strong class="fl_r"><span class="col_orange"><fmt:formatNumber value="${l.chngAmt}" pattern="#,###"/> P</span></strong>
        </li>
    </c:forEach>
</ul>