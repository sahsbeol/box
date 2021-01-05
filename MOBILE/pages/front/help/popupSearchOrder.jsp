<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="layer"/>
<html>
<head>
<title>SOS상담 주문 선택 - NEW ME HOTTRACKS</title>
<style type="text/css">
.table02{
    margin-top : 50px;
}
.table02 td, th{
    border : 1px solid gray;
    padding-left : 10px;
    padding-right : 10px; 
    padding-bottom : 5px;
    padding-top : 5px;
}
.btn.btn_black {
    width : 50px;
    height : 50px;
    float : right;
    background-color: #fff;
}
</style>
<script type="text/javascript" src="/js/jquery.form.js"></script>
<script type="text/javascript">
function sendOrderForm( deliveryId, orderNum ){
    $("input[name='deliveryId']").val(deliveryId);
    closeOrder();
}
function searchOrderProduct(deliveryId, orderNum) {
    //var deliveryId = $("input[name=deliveryId]").val();
    $("input[name='orderNum']").val(orderNum);
    if (deliveryId == "") {
        alert("먼저 주문을 선택해주세요.");
    } else {
        $("#layer").load("/m/help/popupSearchOrderProduct?deliveryId="+ deliveryId+"&orderNum="+orderNum);
        $("#layer").show();
        //location.href = "/m/help/popupSearchOrderProduct?deliveryId=" + deliveryId;
    }
}

function goPage(page){
    $("#layer").load("/m/help/popupSearchOrder?page="+page);
    $("#layer").show();
}
</script>
</head>
<body>
<div class="close">
         <a href="javascript:closeOrder();" class="btn btn_black" style="margin :5px;"><img src="${imageServer }/images/mobile/common/close_1.png" style="width: 30px; height: 30px; margin-top: 5px;"/></a>
    </div>
<div class="sub_contents">
    <div>
        <table class="table02 mgt30">
            <caption>주문내역 조회 <span>주문일, 주문번호, 상품명, 상품금액(배송금액), 배송업체, 처리상태</span></caption>
            <colgroup>  
                <col width="*" /> 
                <col width="*" />
            </colgroup>
            <tbody>
                <c:if test="${empty listOrder}">
                   <div style="text-align: center; margin-top: 10%; font-weight: bold; font-size: 1.1em;">주문하신 내역이 없습니다.</div>
                </c:if>
                <c:if test="${not empty listOrder }">
                    <c:forEach var="order" items="${listOrder}">
                        <tr> 
                            <td> 
                                <a href="javascript://" onclick="searchOrderProduct('${order.deliveryId}', ${order.orderNum})" style="float: left;" >
                                    <font color="gray">주문번호 : ${order.orderNum}</font>
                                    <input type="hidden" name="deliveryId" value="${order.deliveryId}"/>
                                    <input type="hidden" name="orderNum" value="${order.orderNum}"/>
                                   </a><br/> 
                                <!-- </a> --> <br/>
                                     상품명 :  
                                <c:if test="${order.prdtClassCount - 1 >= 1}">${order.prdtName} 외 ${order.prdtClassCount - 1} 종<br/></c:if>
                                <c:if test="${order.prdtClassCount - 1 == 0}">${order.prdtName}<br/></c:if>
                                <c:if test="${not empty order.specName }">└  ${order.specName }</c:if>
                            </td>  
                        </tr>
                    </c:forEach> 
                </c:if>
            </tbody>  
        </table>
        <div class="paging"><ui:paginationScript name="pageHolder" scriptName="goPage"/></div>
    </div>
</div>
</body>
</html>