<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<ui:decorator name="none"/>
<ul class="br_list mt20">
    <c:if test="${empty list && c.page eq 1}">
        <li class="br_none"><strong>해당 지역의 우편번호가 존재하지 않습니다.</strong></li>
    </c:if>
    <c:forEach items="${list}" var="l" varStatus="st">
        <li><a href="javascript:select_address('${l.postNum}', '${l.si} ${l.gu} ${l.roadNm} ${l.bdngNmbr}', '${l.bdngNm}', '${l.dong}', '${l.si} ${l.gu} ${l.dong} ${l.landNmbr}');">[${l.postNum}] ${l.si} ${l.gu} ${l.roadNm} ${l.bdngNmbr}(${l.dong} ${l.bdngNm})<br/>${l.si} ${l.gu} ${l.dong} ${l.landNmbr}</a></li>
    </c:forEach>
</ul>
<div class="paging mb30">
    <ui:paginationScript name="pageHolder" scriptName="zipPage"/>
</div>