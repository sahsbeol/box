<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="none"/>
<c:if test="${empty list && c.page eq 1}">
    <div class="couponbox">
        <div class="box">
            <p class="nocoupon">고객님의 보유 쿠폰이 존재하지 않습니다.</p>
        </div>
    </div>
</c:if>
<c:forEach items="${list}" var="l" varStatus="st">
    <div class="couponbox">
        <div class="box">
            <div class="inner_box">
                <p class="cpn_tit">${l.cpnName}</p>
                <p class="cpn_txt">
                    <c:choose>
                        <c:when test="${l.scopeGbn eq 'D'}"><span>배송비무료</span></c:when>
                        <c:otherwise>
                            <c:choose>
                                <c:when test="${l.rateYn}"><span><fmt:formatNumber value="${l.cpnDscntRate}" pattern="#,###"/></span>% 할인</c:when>
                                <c:when test="${!l.rateYn}"><span><fmt:formatNumber value="${l.cpnDscntAmt}" pattern="#,###"/></span>원 할인</c:when>
                                <c:otherwise><span>0</span></c:otherwise>
                            </c:choose>
                        </c:otherwise>
                    </c:choose>
                </p>
                <p class="cpn_date">
                    <ui:mask pattern="####-##-##">${l.cpnValidDt}</ui:mask> 일까지
                    <em class="col_orange">${l.limitDt}일 남음</em>
                </p>
                
                <p class="cpn_cont">
                    <c:if test="${l.scopeGbn eq 'D'}">-</c:if>
                    <c:if test="${l.scopeGbn eq 'O'}">주문금액 <fmt:formatNumber pattern="#,###" value="${l.cpnStdAmt}"/>원 이상</c:if>
                    <c:if test="${l.scopeGbn eq 'C' || l.scopeGbn eq 'P'}">상품단가 <fmt:formatNumber pattern="#,###" value="${l.snglPrdtLimitPrice}"/>원 이상</c:if>
                </p>
            </div>
        </div>
    </div>
</c:forEach>
