<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<ul class="txt_list">
    <li><strong>상품군 : </strong>가공식품</li>
    <li><strong>생산자 : </strong>${prdtNotiInfo.mnftr}</li>
    <li><strong>원산지 : </strong>${prdtNotiInfo.plorg}</li>
    <li><strong>식품 유형 : </strong>${prdtNotiInfo.itemName}</li>
    <li><strong>용량(중량), 수량, 크기 : </strong>${prdtNotiInfo.size1}</li>
    <li><strong>수입여부 : </strong>${prdtNotiInfo.impYn eq 'Y'?'수입':'국산'}${prdtNotiInfo.impYn eq 'Y'?' : 식품위생법에 따른 수입신고를 필함':''}</li>
    <li><strong>제조일자(유통기한) : </strong>${prdtNotiInfo.dtInfo}</li>
    <li>
        <strong>주원료 : </strong>
        <ul>
            <c:forEach items="${fn:split(prdtNotiInfo.mainPoint, '@')}" var="l">
                <li>${fn:replace(l, '◆', ' : ')}</li>
            </c:forEach>
        </ul>
    </li>
    <c:if test="${prdtNotiInfo.material ne '해당없음'}">
        <li><strong>영양성분: </strong>${prdtNotiInfo.material}</li>
    </c:if>
    <c:if test="${prdtNotiInfo.etc1 ne '해당없음'}">
        <li><strong>유전자 재조합 식품 여부: </strong>${prdtNotiInfo.etc1}</li>
    </c:if>
    <c:if test="${prdtNotiInfo.etc2 ne '해당없음'}">
        <li><strong>표시광고 사전심의번호 : </strong>${prdtNotiInfo.etc2}</li>
    </c:if>
    <li><strong>소비자상담 : </strong>${prdtNotiInfo.asMngrName} / ${prdtNotiInfo.asTelNum}</li>
</ul>