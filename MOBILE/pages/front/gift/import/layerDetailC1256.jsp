<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<ul class="txt_list">
    <li><strong>상품군 : </strong>가구(침대/소파/싱크대/DIY제품)</li>
    <li><strong>제조사 : </strong>${prdtNotiInfo.mnftr}</li>
    <li><strong>제조국 : </strong>${prdtNotiInfo.plorg}</li>
    <li><strong>품명 : </strong>${prdtNotiInfo.itemName}</li>
    <li><strong>색상 : </strong>${prdtNotiInfo.size2}</li>
    <li><strong>크기 : </strong>${prdtNotiInfo.size1}</li>
    <li><strong>수입여부 : </strong>${prdtNotiInfo.impYn eq 'Y'?'수입':'국산'}</li>
    <li><strong>A/S : </strong>${prdtNotiInfo.asMngrName} / ${prdtNotiInfo.asTelNum}</li>
    <c:if test="${prdtNotiInfo.certify ne 'N'}">
        <li>
            <strong>KC 인증 대상 : </strong>
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
    <li><strong>구성품 : </strong>${prdtNotiInfo.components}</li>
    <li>
        <strong>제품 소재 : </strong>
        <c:if test="${empty prdtNotiInfo.material}">해당 정보 준비중입니다.</c:if>
        <c:if test="${not empty prdtNotiInfo.material}">${prdtNotiInfo.material}</c:if>
    </li>
    <li><strong>배송·설치비용 : </strong>${prdtNotiInfo.addPrice}</li>
    <li><strong>품질보증기준 : </strong>${prdtNotiInfo.wrntPolicy}</li>
</ul>