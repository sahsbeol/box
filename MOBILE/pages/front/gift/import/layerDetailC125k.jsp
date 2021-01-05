<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<ul class="txt_list">
    <li><strong>상품군 : </strong>식품(농수산물)</li>
    <li><strong>생산자 : </strong>${prdtNotiInfo.mnftr}</li>
    <li><strong>원산지 : </strong>${prdtNotiInfo.plorg}</li>
    <li><strong>용량(중량), 수량, 크기 : </strong>${prdtNotiInfo.size1}</li>
    <li><strong>수입여부 : </strong>${prdtNotiInfo.impYn eq 'Y'?'수입':'국산'}</li>
    <li><strong>생산연월과 유통기한 : </strong>${prdtNotiInfo.dtInfo}</li>
    <li>
        <strong>주원료명 : </strong>
        <ul>
            <c:forEach items="${fn:split(prdtNotiInfo.mainPoint, '@')}" var="l">
                <li>${fn:replace(l, '◆', ' : ')}</li>
            </c:forEach>
        </ul>
    </li>
    <li><strong>관련법상 표시사항: </strong>${prdtNotiInfo.etc1}</li>
    <li><strong>상품구성: </strong>${prdtNotiInfo.components}</li>
    <li><strong>보관방법 또는 취급방법 : </strong>${prdtNotiInfo.caution}</li>
    <li><strong>소비자상담 : </strong>${prdtNotiInfo.asMngrName} / ${prdtNotiInfo.asTelNum}</li>
</ul>