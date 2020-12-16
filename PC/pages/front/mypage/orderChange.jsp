<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
<title>주문취소/변경 | 주문정보 | MY HOTTRACKS - HOTTRACKS</title>
<script type="text/javascript" src="/scripts/loadingBar"></script>
<script type="text/javascript">
function cancelOrder(orderNum){
    if(!confirm("<fmt:message key='confirm.cancel.message'/>")) {
        return;
    }
    
    $.ajax({
        type: "POST"
        ,url: "/ht/mypage/cancelOrderForAll"
        ,data: {orderNo : orderNum}
        ,dataType: "json"
        ,success : function(data){
            if (data) {
                if(data.save) {
                    alert("주문이 취소되었습니다.");
                    window.location.reload();
                } else {
                    var errorMessages = data.errorMessages;
                    alert(errorMessages.join("\n"));
                }
            }
        }
        ,error: function(data) {
            alert('<fmt:message key="error.common.system"/>');
        }
    });
}

function goSosCounsel(orderNum) {
    window.location.href = "/ht/help/createCounselForm?orderNum=" + orderNum + "&sosCounselCode=C0663";
}
</script>
</head>
<body>
<!-- sub top -->
<div class="page_location">
    <h2 class="title"><img src="${imageServer}/images/renewal/common/tit_my_hottracks.gif" alt="My Hottracks"/></h2>
    <div class="loc"><a href="/" class="home">Home</a><em>MY HOTTRACKS</em></div>
</div>
<!-- //sub top -->

<c:import url="/menu/mypage/lnb"/>

<!-- sub contents -->
<div class="sub_contents">
    <h3 class="page_title mgt0"><img src="${imageServer}/images/renewal/common/tit_order_change.gif" alt="주문취소/변경" /></h3>
    <ul class="list_type02">
        <li>주문취소 및 주소변경이 가능한 주문내역만 보여집니다.</li>
        <li>상품준비 이전 단계에서는 바로 주문 전체취소 및 주소변경이 가능하며, [주문/배송조회]에서 확인하실 수 있습니다.</li>
        <li>상품준비 이전 단계에서의 부분취소는 [SOS 상담]을 이용하시거나 고객센터로 연락주시기 바랍니다.</li>
        <li class="mgt20">주문취소 시에는 고객님께서 결제한 계좌로 환불처리 됩니다. (신용카드 : 즉시, 계좌이체 : 최대3일 소요)<br />
        일부 환불이 불가능한 경우에는 교보핫트랙스 온라인 예치금으로 자동 예치됩니다. (마이핫트랙스 &gt; 교보핫트랙스 온라인 예치금<br />
        메뉴에서 환불 요청 가능) 
        <div class="tooltip_wrap">
            <a href="#tooltip" class="tooltip">?</a>
            <div class="layer_pop_wrap" id="tooltip">
                <div class="layer_pop_container" style="width:320px;height:96px;">
                    <h1>아래의 경우 환불이 불가능 합니다.</h1>
                    <div class="layer_pop_cont">
                        <ul>
                            <li>핫트랙스에서 지정한 환불기간이 지났을 경우(10일)</li>
                            <li>은행에서 장애가 발생하였을 경우</li>
                        </ul>
                    </div>
                    <a href="#none" class="cls_btn" title="레이어팝업 닫기"><img src="${imageServer}/images/renewal/common/btn_cls.gif" alt="닫기" /></a>
                </div>
            </div>
        </div>
        </li>
        <li class="mgt20">상품준비 이후 단계에서는 [SOS 상담] 또는 고객센터를 통해 신청이 가능하나, 상품이 이미 출고된 경우에는<br />취소 및 변경이 불가능합니다. 출고 이후 주문취소는 반품접수를 이용해주시기 바랍니다.</li>
    </ul>
    <table class="bbs_list01 mgt40">
        <caption>주문취소/변경 내역 <span>주문일, 주문번호, 상품명, 결제금액, 처리상태, 취소/변경</span></caption>
        <colgroup>
            <col style="width:80px" />
            <col style="width:110px" />
            <col style="width:*" />
            <col style="width:80px" />
            <col style="width:70px" />
            <col style="width:100px" />
        </colgroup>
        <thead>
            <tr>
                <th scope="col" class="fir">주문일</th>
                <th scope="col">주문번호</th>
                <th scope="col">상품명</th>
                <th scope="col">결제금액</th>
                <th scope="col">처리상태</th>
                <th scope="col" class="last">취소/변경</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${orderList}" var="l">
                <tr> 
                    <td><fmt:formatDate value="${l.orderDatetime}" pattern="yyyy.MM.dd"/></td>
                    <td>
                        <a href="/ht/mypage/orderDeliveryDetail?orderNo=${l.orderNum }&menuId=2">${l.orderNum}</a>
                        <input type="hidden" name="orderNum" value="${l.orderNum}"/>
                    </td>
                    <td class="t_left">${l.prdtName}<c:if test="${l.prdtClassCount > 1}">외 ${l.prdtClassCount-1}건</c:if></td>
                    <td class="t_right"><fmt:formatNumber value="${l.orderAmt}" pattern="#,###"/>원</td>
                    <td><ui:code codeId="${l.dlvyStatusCode}"/></td>
                    <td class="img">
                        <c:if test="${l.dlvyStatusCode eq 'C0281' || l.dlvyStatusCode eq 'C0121'}">
                            <a href="javascript://" class="btn_type02" title="새창으로 열림" onclick="cancelOrder('${l.orderNum}')">주문취소</a>
                            <a href="javascript://" class="btn_type02" title="새창으로 열림" onclick="window.open('/ht/mypage/popupChangeDeliveryDestination?orderNum=${l.orderNum}', 'popupChageDeliveryDestination', 'width=600,height=372');return false;">주소변경</a>
                        </c:if>
                        <c:if test="${l.dlvyStatusCode eq 'C0122'}">
                            <a href="javascript://" class="btn_type02" title="새창으로 열림" onclick="goSosCounsel('${l.orderNum}');">주문취소 신청</a>
                            <a href="javascript://" class="btn_type02" title="새창으로 열림" onclick="goSosCounsel('${l.orderNum}');">주소변경 신청</a>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty orderList}"><tr><td colspan="6" class="no_data">주문취소/변경 내역이 없습니다.</td></tr></c:if>
        </tbody>
    </table>
    <!-- paging -->
    <div class="paging">
        <ui:pagination url="/ht/mypage/orderChange" name="pageHolder"/>
    </div>
    <!-- //paging -->
</div>
<!-- //sub contents -->
</body>
</html>