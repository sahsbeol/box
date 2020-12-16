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
            <th scope="row">저자/출판사</th>
            <td>${prdtNotiInfo.mnftr}</td>
            <th scope="row">제조국</th>
            <td>${prdtNotiInfo.plorg}</td>
        </tr>
        <tr>
            <th scope="row">도서명</th>
            <td>${prdtNotiInfo.itemName}</td>
            <th scope="row">출간일</th>
            <td><ui:mask pattern="####년##월##일">${prdtNotiInfo.dtInfo}</ui:mask></td>
        </tr>
        <tr>
            <th scope="row">크기</th>
            <td>${prdtNotiInfo.size1}</td>
            <th scope="row">쪽수</th>
            <td>${prdtNotiInfo.size2}</td>
        </tr>
        <tr>
            <th scope="row">수입여부</th>
            <td colspan="3">${prdtNotiInfo.impYn eq 'Y'?'수입':'국산'}</td>
        </tr>
        <tr>
            <th scope="row">제품구성</th>
            <td colspan="3">${prdtNotiInfo.components}</td>
        </tr>
        <tr>
            <th scope="row">목차 또는 책소개</th>
            <td colspan="3">${prdtNotiInfo.useMethd}</td>
        </tr>
    </tbody>
</table>