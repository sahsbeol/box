<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<ui:decorator name="popup"/>
<html>
<head>
<title>SOS상담 주문 선택 - NEW ME HOTTRACKS</title>
<script type="text/javascript">
    jQuery(function($) {
        window.resizeTo(900, 680);
        
        $("tbody tr td a").click(function() {
            $("input[name='deliveryId']", opener.document).val($(this).find("input[name='deliveryId']").val()); 
            $("input[name='orderNum']", opener.document).val($(this).find("input[name='orderNum']").val());
            self.close();
        });
    });
</script>
</head>
<body>
<div style="width:880px;">
    <h1><img src="${imageServer}/images/renewal/common/h2_popup_customer01.gif" alt="주문내역 조회" /></h1>
    <div class="pop_cont">
        <ul class="list_type02">
            <li>상담을 원하시는 주문번호/상품명을 선택하세요(최근 6개월간의 주문내역을 기본으로 보여드립니다).</li>
        </ul>
        <table class="table02 mgt15">
            <caption>주문내역 조회 <span>주문일, 주문번호, 상품명, 상품금액(배송금액), 배송업체, 처리상태</span></caption>
            <colgroup>  
                <col width="120px" />
                <col width="120px" />
                <col width="*" /> 
                <col width="120px" />
                <col width="120px" />
                <col width="100px" /> 
            </colgroup>
            <thead>
                <tr> 
                    <th scope="col">주문일</th>
                    <th scope="col">주문번호</th>
                    <th scope="col">상품명</th> 
                    <th scope="col">상품금액(배송금액)</th>
                    <th scope="col">배송업체</th>
                    <th scope="col">처리상태</th> 
                </tr>
            </thead>
            <tbody>
                <c:forEach var="order" items="${listOrder}">
                    <tr> 
                        <td class="bold"><fmt:formatDate value="${order.orderDatetime}" pattern="yyyy.MM.dd"/></td>
                        <td>
                            <a href="javascript://">
                                ${order.orderNum}
                                <input type="hidden" name="deliveryId" value="${order.deliveryId}"/>
                                <input type="hidden" name="orderNum" value="${order.orderNum}"/>
                            </a>
                        </td>
                        <td class="t_left">
                            <c:if test="${order.prdtClassCount - 1 >= 1}">${order.prdtName} 외 ${order.prdtClassCount - 1} 종</c:if><br/>
                            <c:if test="${order.prdtClassCount - 1 == 0}">${order.prdtName}</c:if><br/>
                            <c:if test="${not empty order.specName }">└  ${order.specName }</c:if>
                        </td>  
                        <td class="t_right"><fmt:formatNumber value="${order.orderAmt}" pattern="#,###"/>원(<fmt:formatNumber value="${order.deliveryAmt}" pattern="#,###"/>)</td>
                        <td>${order.dlvyVndrName}</td>
                        <td><span class="c_gray"><ui:code codeId="${order.dlvyStatusCode}"/></td>
                    </tr>
                </c:forEach> 
            </tbody>  
        </table>
        <div class="paging"><ui:pagination name="pageHolder" url="/ht/help/popupSearchOrder" parameters=""/></div>
    </div>
    <div class="pop_close">
        <a href="javascript://" onclick="self.close()">닫기</a>
    </div>
</div>
</body>
</html>