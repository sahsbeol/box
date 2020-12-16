<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<ui:decorator name="none"/>
    <table class="bbs_list_v2 mgt20">
        <caption>주문번호 조회 <span>선택, 주문번호, 결제완료일, 상품내역, 결제금액</span>
        </caption>
        <colgroup>
            <col style="width:50px" />
            <col style="width:80px" />
            <col style="width:120px" />
            <col style="width:*" />
            <col style="width:80px" />
        </colgroup>
        <thead>
            <tr>
                <th scope="col" class="fir">선택</th>
                <th scope="col">주문번호</th>
                <th scope="col">결제완료일</th>
                <th scope="col">상품내역</th>
                <th scope="col" class="last">결제금액</th>
            </tr>
        </thead>
        <tbody>
            <c:if test="${empty orderHistoryList}"><tr><td colspan="5" class="no_data">검색된 주문내용이 없습니다.</td></tr></c:if>
            <c:forEach items="${orderHistoryList}" var="order" varStatus="status">
                <tr>
                    <td><input name="orderNums" value="${order.orderNum}" type="checkbox" title="[${order.orderNum}] 주문번호 선택" /></td>
                    <td><a href="/ht/mypage/orderDeliveryDetail?orderNo=${order.orderNum}">${order.orderNum}</a></td>
                    <td><fmt:formatDate value="${order.pymntDtm}" pattern="yyyy.MM.dd"/></td>
                    <td><a href="/ht/mypage/orderDeliveryDetail?orderNo=${order.orderNum}">${order.prdtName}<c:if test=" ${order.prdtCount > 0}" > 외  ${order.prdtCount}건</c:if></a></td>
                    <td class="t_right"><fmt:formatNumber value="${order.pymntAmt}" pattern="#,###"/>원</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
