<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="none"/>
<c:forEach items="${list}" var="l" varStatus="st">
    <div class="roundbox mt20 order_inquiry">
        <strong class="order_num">${l.orderNum}</strong>
        <ul class="br_list">
            <li class="br_none">
                <strong class="fl_l">주문일자</strong>
                <span class="fl_r"><fmt:formatDate value="${l.orderDtm}" pattern="yyyy.MM.dd"/></span>
            </li>
            <li>
                <strong class="fl_l">상품명</strong>
                <span class="fl_r">
                    <span class="name">${l.prdtName}<c:if test="${l.orderCnt > 0}"> 외 ${l.orderCnt}개</c:if></span>
                </span>
            </li>
            <li>
                <strong class="fl_l">주문금액</strong>
                <span class="fl_r"><span class="col_orange"><fmt:formatNumber value="${l.orderAmt}"/></span>원</span>
            </li>
            <li>
                <strong class="fl_l">처리상태</strong>
                <span class="fl_r">${l.orderStatusName}</span>
            </li>
        </ul>
        <a href="/m/mypage/orderDeliveryDetail?orderNum=${l.orderNum}" class="detail_view"><span>상세보기</span></a>
    </div>
</c:forEach>
