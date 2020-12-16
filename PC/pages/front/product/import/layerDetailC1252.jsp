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
            <th scope="row">색상</th>
            <td>${prdtNotiInfo.size2}</td>
            <th scope="row">수입여부</th>
            <td>${prdtNotiInfo.impYn eq 'Y'?'수입':'국산'}</td>
        </tr>
        <tr>
            <th scope="row">치수</th>
            <td colspan="3">${prdtNotiInfo.size1}</td>
        </tr>
        <tr>
            <th scope="row">제품 소재</th>
            <td colspan="3">${prdtNotiInfo.material}</td>
        </tr>
        <tr>
            <th scope="row">취급시 주의사항</th>
            <td colspan="3">${prdtNotiInfo.caution}</td>
        </tr>
        <tr>
            <th scope="row">품질보증기준</th>
            <td colspan="3">${prdtNotiInfo.wrntPolicy}</td>
        </tr>
        <tr>
            <th scope="row">A/S</th>
            <td colspan="3">${prdtNotiInfo.asMngrName} / ${prdtNotiInfo.asTelNum}</td>
        </tr>
    </tbody>
</table>