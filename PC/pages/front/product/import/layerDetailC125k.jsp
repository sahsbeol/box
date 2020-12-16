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
            <th scope="row">용량(중량), 수량, 크기</th>
            <td>${prdtNotiInfo.size1}</td>
            <th scope="row">수입여부</th>
            <td>${prdtNotiInfo.impYn eq 'Y'?'수입':'국산'}</td>
        </tr>
        <tr>
            <th scope="row">생산연월과 유통기한</th>
            <td colspan="3">${prdtNotiInfo.dtInfo}</td>
        </tr>
        <tr>
            <th scope="row">주원료명</th>
            <td colspan="3">
                <ul>
                    <c:forEach items="${fn:split(prdtNotiInfo.mainPoint, '@')}" var="l">
                        <li>${fn:replace(l, '◆', ' : ')}</li>
                    </c:forEach>
                </ul>
            </td>
        </tr>
        <tr>
            <th scope="row">관련법상 표시사항</th>
            <td colspan="3">${prdtNotiInfo.etc1}</td>
        </tr>
        <tr>
            <th scope="row">상품구성</th>
            <td colspan="3">${prdtNotiInfo.components}</td>
        </tr>
        <tr>
            <th scope="row">보관방법 또는 취급방법</th>
            <td colspan="3">${prdtNotiInfo.caution}</td>
        </tr>
        <tr>
            <th scope="row">소비자상담</th>
            <td>${prdtNotiInfo.asMngrName} / ${prdtNotiInfo.asTelNum}</td>
        </tr>
    </tbody>
</table>