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
            <th scope="row">발행자</th>
            <td>${prdtNotiInfo.mnftr}</td>
            <th scope="row">제조국</th>
            <td>${prdtNotiInfo.plorg}</td>
        </tr>
        <tr>
            <th scope="row">수입여부</th>
            <td colspan="3">${prdtNotiInfo.impYn eq 'Y'?'수입':'국산'}</td>
        </tr>
        <tr>
            <th scope="row">유효기간/이용조건</th>
            <td colspan="3">${prdtNotiInfo.dtInfo}</td>
        </tr>
        <tr>
            <th scope="row">이용가능매장</th>
            <td colspan="3">${prdtNotiInfo.mainPoint}</td>
        </tr>
        <tr>
            <th scope="row">잔액환급조건</th>
            <td colspan="3">${prdtNotiInfo.addPrice}</td>
        </tr>
        <tr>
            <th scope="row">소비자상담</th>
            <td colspan="3">${prdtNotiInfo.asMngrName} / ${prdtNotiInfo.asTelNum}</td>
        </tr>
    </tbody>
</table>