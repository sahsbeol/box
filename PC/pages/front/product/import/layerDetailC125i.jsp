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
            <th scope="row">용량 또는 중량</th>
            <td>${prdtNotiInfo.size1}</td>
            <th scope="row">수입여부</th>
            <td>${prdtNotiInfo.impYn eq 'Y'?'수입':'국산'}</td>
        </tr>
        <tr>
            <th scope="row">주요성분</th>
            <td colspan="3">${prdtNotiInfo.components}</td>
        </tr>
        <tr>
            <th scope="row">제품 주요 사항</th>
            <td colspan="3">${prdtNotiInfo.mainPoint}</td>
        </tr>
        <tr>
            <th scope="row">사용기한 또는 <br/>개봉 후 사용기간</th>
            <td colspan="3">${prdtNotiInfo.dtInfo}</td>
        </tr>
        <tr>
            <th scope="row">식품의약품안전청 심사필 유무</th>
            <td colspan="3">${prdtNotiInfo.etc1}</td>
        </tr>
        <tr>
            <th scope="row">사용방법</th>
            <td colspan="3">${prdtNotiInfo.useMethd}</td>
        </tr>
        <tr>
            <th scope="row">사용 시 주의사항</th>
            <td colspan="3">${prdtNotiInfo.caution}</td>
        </tr>
        <tr>
            <th scope="row">품질보증기준</th>
            <td colspan="3">${prdtNotiInfo.wrntPolicy}</td>
        </tr>
        <tr>
            <th scope="row">소비자상담</th>
            <td colspan="3">${prdtNotiInfo.asMngrName} / ${prdtNotiInfo.asTelNum}</td>
        </tr>
    </tbody>
</table>