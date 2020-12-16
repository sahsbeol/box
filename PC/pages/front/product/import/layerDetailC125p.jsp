<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<table class="table04 mgt80">
    <colgroup>
        <col width="15%" />
        <col width="35%" />
        <col width="15%" />
        <col width="35%" />
    </colgroup>
    <tbody>
        <tr>
            <th scope="row">상품군</th>
            <td colspan="3"><ui:code codeId="${prdtNotiInfo.gbnCode}"/></td>
        </tr>
        <tr>
            <th scope="row">제조사</th>
            <td>${prdtNotiInfo.mnftr}</td>
            <th scope="row">제조국</th>
            <td>${prdtNotiInfo.plorg}</td>
        </tr>
        <tr>
            <th scope="row">품명 및 모델명</th>
            <td>${prdtNotiInfo.itemName}</td>
            <th scope="row">동일모델 출시연월</th>
            <td>
                <c:if test="${fn:length(prdtNotiInfo.dtInfo) eq 8}"><ui:mask pattern="####년##월">${prdtNotiInfo.dtInfo}</ui:mask></c:if>
                <c:if test="${fn:length(prdtNotiInfo.dtInfo) ne 8}">${prdtNotiInfo.dtInfo}</c:if>
            </td>
        </tr>
        <tr>
            <th scope="row">크기/중량</th>
            <td>${prdtNotiInfo.size1}</td>
            <th scope="row">색상</th>
            <td>${prdtNotiInfo.size2}</td>
        </tr>
        <tr>
            <th scope="row">A/S</th>
            <td colspan="3">${prdtNotiInfo.asMngrName} / ${prdtNotiInfo.asTelNum}</td>
        </tr>
        <tr>
            <th scope="row">재질</th>
            <td colspan="3">${prdtNotiInfo.material}</td>
        </tr>
        <tr>
            <th scope="row">상품별 세부 사항</th>
            <td colspan="3">${prdtNotiInfo.mainPoint}</td>
        </tr>
        <tr>
            <th scope="row">품질보증기준</th>
            <td colspan="3">${prdtNotiInfo.wrntPolicy}</td>
        </tr>
        <tr>
            <th scope="row">수입여부</th>
            <td colspan="3">${prdtNotiInfo.impYn eq 'Y'?'수입':'국산'}</td>
        </tr>
    </tbody>
</table>