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
            <th scope="row">수입여부</th>
            <td>${prdtNotiInfo.impYn eq 'Y'?'수입':'국산'}</td>
        </tr>
        <c:if test="${prdtNotiInfo.certify ne 'N'}">
            <tr>
                <th scope="row">KCC인증 대상</th>
                <td colspan="3">
                    <ul>
                        <c:forEach items="${fn:split(prdtNotiInfo.certify,'@')}" var="l" varStatus="st">
                            <li>
                                <c:if test="${fn:contains(l, '01◆')}">[국가통합인증(KC마크)]${fn:replace(l,'01◆','')}</c:if>
                                <c:if test="${fn:contains(l, '02◆')}">[공산품 안전검사]${fn:replace(l,'02◆','')}</c:if>
                                <c:if test="${fn:contains(l, '03◆')}">[안전인증대상 공산품]${fn:replace(l,'03◆','')}</c:if>
                                <c:if test="${fn:contains(l, '04◆')}">[자율안전 확인 대상 공산품]${fn:replace(l,'04◆','')}</c:if>
                                <c:if test="${fn:contains(l, '05◆')}">[전기용품 안전인증]${fn:replace(l,'05◆','')}</c:if>
                                <c:if test="${fn:contains(l, '06◆')}">[의료기기제조 품목허가]${fn:replace(l,'06◆','')}</c:if>
                                <c:if test="${fn:contains(l, '07◆')}">[기타]${fn:replace(l,'07◆','')}</c:if>
                                <c:if test="${!fn:contains(l, '◆')}">${l}</c:if>
                            </li>
                        </c:forEach>
                    </ul>
                </td>
            </tr>
        </c:if>
        <tr>
            <th scope="row">A/S 및 소비자상담</th>
            <td colspan="3">${prdtNotiInfo.asMngrName} / ${prdtNotiInfo.asTelNum}</td>
        </tr>
    </tbody>
</table>