<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="none"/>
<ul class="br_list mb30">
    <c:if test="${empty list && c.page eq 1}">
        <li class="line bg_eeeeee"><strong>고객님의 ${c.srchGbn eq '0'?'예치금':'환불신청'} 내역은 존재하지 않습니다.</strong></li>
    </c:if>
    <c:forEach items="${list}" var="l" varStatus="st">
        <c:if test="${c.srchGbn eq '0'}">
            <li class="line bg_eeeeee">
                <strong class="fl_l"><fmt:formatDate value="${l.modDtm}" pattern="yyyy.MM.dd"/> (변동일)</strong>
                <strong class="fl_r"><fmt:formatDate value="${l.cmpltDtm}" pattern="yyyy.MM.dd"/> (처리일)</strong>
            </li>
            <li>
                <strong class="fl_l">${l.modRsnCont}</strong>
                <span class="fl_r col_orange"><fmt:formatNumber value="${l.chngAmt}" pattern="#,###"/>P</span>
            </li>
        </c:if>
        <c:if test="${c.srchGbn eq '1'}">
            <li class="line bg_eeeeee">
                <strong class="fl_l"><fmt:formatDate value="${l.reqDtm}" pattern="yyyy.MM.dd"/> (신청일 )</strong>
                <span class="fl_r"></span>
            </li>
            <li>
                <strong class="fl_l">${l.modRsnCont}</strong>
                <span class="fl_r col_orange"><fmt:formatNumber value="${l.chngAmt}" pattern="#,###"/>P</span>
            </li>
        </c:if>
    </c:forEach>
</ul>