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
            <th scope="row">생산자</th>
            <td>${prdtNotiInfo.mnftr}</td>
            <th scope="row">원산지</th>
            <td>${prdtNotiInfo.plorg}</td>
        </tr>
        <tr>
            <th scope="row">식품 유형</th>
            <td>${prdtNotiInfo.itemName}</td>
            <th scope="row">용량(중량), 수량</th>
            <td>${prdtNotiInfo.size1}</td>
        </tr>
        <tr>
            <th scope="row">수입여부</th>
            <td colspan="3">${prdtNotiInfo.impYn eq 'Y'?'수입':'국산'}${prdtNotiInfo.impYn eq 'Y'?' : 식품위생법에 따른 수입신고를 필함':''}</td>
        </tr>
        <tr>
            <th scope="row">제조일자<br/>(유통기한)</th>
            <td colspan="3">${prdtNotiInfo.dtInfo}</td>
        </tr>
        <tr>
            <th scope="row">주원료</th>
            <td colspan="3">
                <ul>
                    <c:forEach items="${fn:split(prdtNotiInfo.mainPoint, '@')}" var="l">
                        <li>${fn:replace(l, '◆', ' : ')}</li>
                    </c:forEach>
                </ul>
            </td>
        </tr>
        <c:if test="${prdtNotiInfo.material ne '해당없음'}">
            <tr>
                <th scope="row">영양성분</th>
                <td colspan="3">${prdtNotiInfo.material}</td>
            </tr>
        </c:if>
        <c:if test="${prdtNotiInfo.etc1 ne '해당없음'}">
            <tr>
                <th scope="row">유전자 재조합 식품 여부</th>
                <td colspan="3">${prdtNotiInfo.etc1}</td>
            </tr>
        </c:if>
        <c:if test="${prdtNotiInfo.etc2 ne '해당없음'}">
            <tr>
                <th scope="row">표시광고<br/>사전심의번호</th>
                <td colspan="3">${prdtNotiInfo.etc2}</td>
            </tr>
        </c:if>
        <tr>
            <th scope="row">소비자상담</th>
            <td colspan="3">${prdtNotiInfo.asMngrName} / ${prdtNotiInfo.asTelNum}</td>
        </tr>
    </tbody>
</table>