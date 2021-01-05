<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<ul class="txt_list">
    <li><strong>상품군 : </strong>내비게이션</li>
    <li><strong>제조사 : </strong>${prdtNotiInfo.mnftr}</li>
    <li><strong>제조국 : </strong>${prdtNotiInfo.plorg}</li>
    <li><strong>품명 및 모델명 : </strong>${prdtNotiInfo.itemName}</li>
    <li>
        <strong>동일모델 출시년월 : </strong>
        <c:if test="${fn:length(prdtNotiInfo.dtInfo) eq 8}"><ui:mask pattern="####년##월">${prdtNotiInfo.dtInfo}</ui:mask></c:if>
        <c:if test="${fn:length(prdtNotiInfo.dtInfo) ne 8}">${prdtNotiInfo.dtInfo}</c:if>
    </li>
    <c:if test="${prdtNotiInfo.certify ne 'N'}">
        <li>
            <strong>KCC인증 대상 : </strong>
            <c:forEach items="${fn:split(prdtNotiInfo.certify,'@')}" var="l" varStatus="st">
                <c:if test="${!st.first}"><br/></c:if>
                <c:if test="${fn:contains(l, '01◆')}">[국가통합인증(KC마크)]${fn:replace(l,'01◆','')}</c:if>
                <c:if test="${fn:contains(l, '02◆')}">[공산품 안전검사]${fn:replace(l,'02◆','')}</c:if>
                <c:if test="${fn:contains(l, '03◆')}">[안전인증대상 공산품]${fn:replace(l,'03◆','')}</c:if>
                <c:if test="${fn:contains(l, '04◆')}">[자율안전 확인 대상 공산품]${fn:replace(l,'04◆','')}</c:if>
                <c:if test="${fn:contains(l, '05◆')}">[전기용품 안전인증]${fn:replace(l,'05◆','')}</c:if>
                <c:if test="${fn:contains(l, '06◆')}">[의료기기제조 품목허가]${fn:replace(l,'06◆','')}</c:if>
                <c:if test="${fn:contains(l, '07◆')}">[기타]${fn:replace(l,'07◆','')}</c:if>
                <c:if test="${!fn:contains(l, '◆')}">${l}</c:if>
            </c:forEach>
        </li>
    </c:if>
    <li><strong>크기/무게: </strong>${prdtNotiInfo.size1}</li>
    <li><strong>수입여부 : </strong>${prdtNotiInfo.impYn eq 'Y'?'수입':'국산'}</li>
    <li><strong>정격전압 소비전력: </strong>${prdtNotiInfo.material}</li>
    <li><strong>주요 사항: </strong>${prdtNotiInfo.mainPoint}</li>
    <li><strong>맵 업데이트 비용 및 무상기간: </strong>${prdtNotiInfo.addPrice}</li>
    <li><strong>품질보증기준: </strong>${prdtNotiInfo.wrntPolicy}</li>
    <li><strong>A/S : </strong>${prdtNotiInfo.asMngrName} / ${prdtNotiInfo.asTelNum}</li>
</ul>