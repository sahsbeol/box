<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<ul class="txt_list">
    <li><strong>상품군 : </strong>주방용품</li>
    <li><strong>제조사 : </strong>${prdtNotiInfo.mnftr}</li>
    <li><strong>제조국 : </strong>${prdtNotiInfo.plorg}</li>
    <li><strong>품명 및 모델명 : </strong>${prdtNotiInfo.itemName}</li>
    <li>
        <strong>동일모델 출시년월 : </strong>
        <c:if test="${fn:length(prdtNotiInfo.dtInfo) eq 8}"><ui:mask pattern="####년##월">${prdtNotiInfo.dtInfo}</ui:mask></c:if>
        <c:if test="${fn:length(prdtNotiInfo.dtInfo) ne 8}">${prdtNotiInfo.dtInfo}</c:if>
    </li>
    <li><strong>크기: </strong>${prdtNotiInfo.size1}</li>
    <li><strong>수입여부 : </strong>${prdtNotiInfo.impYn eq 'Y'?'수입':'국산'}</li>
    <li><strong>재질: </strong>${prdtNotiInfo.material}</li>
    <li><strong>구성품: </strong>${prdtNotiInfo.components}</li>
    <li>
        <strong>품질보증기준: </strong>
        ${prdtNotiInfo.wrntPolicy} <c:if test="${prdtNotiInfo.etc1 eq 'Y'}">(식품위생법에 따른 수입신고를 필함)</td></c:if>
    </li>
    <li><strong>A/S : </strong>${prdtNotiInfo.asMngrName} / ${prdtNotiInfo.asTelNum}</li>
</ul>