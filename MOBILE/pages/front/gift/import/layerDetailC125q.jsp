<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<ul class="txt_list">
    <li><strong>상품군 : </strong>서적</li>
    <li><strong>저자/출판사 : </strong>${prdtNotiInfo.mnftr}</li>
    <li><strong>제조국 : </strong>${prdtNotiInfo.plorg}</li>
    <li><strong>도서명 : </strong>${prdtNotiInfo.itemName}</li>
    <li>
        <strong>출간일 : </strong>
        <c:if test="${fn:length(prdtNotiInfo.dtInfo) eq 8}"><ui:mask pattern="####년##월">${prdtNotiInfo.dtInfo}</ui:mask></c:if>
        <c:if test="${fn:length(prdtNotiInfo.dtInfo) ne 8}">${prdtNotiInfo.dtInfo}</c:if>
    </li>
    <li><strong>크기 : </strong>${prdtNotiInfo.size1}</li>
    <li><strong>쪽수 : </strong>${prdtNotiInfo.size2}</li>
    <li><strong>수입여부 : </strong>${prdtNotiInfo.impYn eq 'Y'?'수입':'국산'}</li>
    <li><strong>제품구성 : </strong>${prdtNotiInfo.components}</li>
    <li><strong>목차 또는 책소개 : </strong>${prdtNotiInfo.useMethd}</li>
    <li><strong>A/S : </strong>${prdtNotiInfo.asMngrName} / ${prdtNotiInfo.asTelNum}</li>
</ul>