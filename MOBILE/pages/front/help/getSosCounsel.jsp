<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="none"/>
<c:set var="listProduct" value="${counsel.listProduct}"/>
<div class="one">
    <c:forEach items="${listProduct}" var="prod" end="0">
        <p style="padding:5px 0;color:#FF0000;"><strong>${prod.productName}</strong></p>
    </c:forEach>
    <p style='padding:5px 0;'>${counsel.counselContent}</p>
</div>
<c:if test="${counsel.sosProcessGubun eq 'E'}">
    <div class="two">
        <p style='padding:5px 0;'><strong class='col_orange'>A.핫트랙스</strong></p>
        <p style='padding:5px 0;text-align:right;'>답변일시 : <fmt:formatDate value="${counsel.lastModifyDtm}" pattern="yyyy.MM.dd"/></p>
        <p style='padding:5px 0;'>${counsel.replyContent}</p>
    </div>
</c:if>