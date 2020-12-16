<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="none"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr"/>
<title>네이버페이결제 처리</title>
<script type="text/javascript" src="/js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="/js/jquery.form.js" charset="utf-8"></script>
<script language="javascript">

var cacaoPayReq = 0;
var tid = '${res.tid}';


function payRequest(){
    newwin = window.open('${res.nextRedirectPcUrl}', '_blank', 'width=500,height=500,scrollbars=yes');
    
    if (newwin == null){ 
        var message = "팝업 차단기능 혹은 팝업차단 프로그램이 동작중입니다. 팝업 차단 기능을 해제한 후 다시 시도하세요."; 
        alert(message);
        parent.location.href = "${defaultHost}/ht/order/cart";
        return;
    }

    loop = setInterval(function() {   
        if(newwin.closed && cacaoPayReq == 0) {  
            clearInterval(loop);  
            alert("사용자가 결제를 취소하였습니다.");
            parent.location.href = "${defaultHost}/ht/order/cart";
        }  
    }, 1000); 
}

function payCancleReturn () {
	alert("결제를 취소하였습니다.");
	parent.location.href = "${defaultHost}/ht/order/cart";
	return;	
}

function payFailReturn() {
    alert("결제 실패 하였습니다.");
    parent.location.href = "${defaultHost}/ht/order/cart";
    return; 
}


function payReturn(pg_token) {
    document.forms['orderInfoForm'].cacaoPgToken.value = pg_token;
    document.forms['orderInfoForm'].cacaoTid.value = tid;

    var replaceUrl = "${defaultHost}/ht/order/orderComplete";
    // 결제 최종요청
    $("form#orderInfoForm").ajaxSubmit({
        url: "/ht/order/payResponse"
        ,dataType: "json"
        ,success: function saveSuccess(data) {
            if (data.save) {
                parent.location.replace(replaceUrl);
            } else {
                var errorMessages = data.errorMessages;
                alert(errorMessages.join("\n"));
                parent.location.href = "${defaultHost}/ht/order/cart";
            }
        }
        ,error: function(xhr, status, error) {
            alert("<fmt:message key='error.common.system'/>");
            parent.location.href = "${defaultHost}/ht/order/cart";
        }
    });
    
    
    return; 
}
</script>
</head>

<body onload="javascript:payRequest();">
<form id="orderInfoForm" action="#" method="post">
    <input type="hidden" name="orderNum" value="${orderSheet.orderNum}"/>
    <input type="hidden" name="buyerName" value="${orderSheet.buyerName}"/>
    <input type="hidden" name="buyerEmail" value="${orderSheet.buyerEmail}"/>
    <input type="hidden" name="telePhone" value="${orderSheet.telePhone}"/>
    <input type="hidden" name="handPhone" value="${orderSheet.handPhone}"/>
    <input type="hidden" name="smsReceiveYn" value="${orderSheet.smsReceiveYn}"/>
    <input type="hidden" name="receiverName" value="${orderSheet.receiverName}"/>
    <input type="hidden" name="receiverEmail" value="${orderSheet.receiverEmail}"/>
    <input type="hidden" name="receiverTelePhone" value="${orderSheet.receiverTelePhone}"/>
    <input type="hidden" name="receiverHandPhone" value="${orderSheet.receiverHandPhone}"/>
    <input type="hidden" name="receiverPostNum" value="${orderSheet.receiverPostNum}"/>
    <input type="hidden" name="receiverAddress" value="${orderSheet.receiverAddress}"/>
    <input type="hidden" name="receiverDetailAddress" value="${orderSheet.receiverDetailAddress}"/>
    <input type="hidden" name="receiverDetailAddress3" value="${orderSheet.receiverDetailAddress3}"/>
    <input type="hidden" name="receiverDetailAddress4" value="${orderSheet.receiverDetailAddress4}"/>
    <input type="hidden" name="orderMessage" value="${orderSheet.orderMessage}"/>
    <input type="hidden" name="giftMessage" value="${orderSheet.giftMessage}"/>
    <input type="hidden" name="deliveryMessage" value="${orderSheet.deliveryMessage}"/>
    <input type="hidden" name="password" value="${orderSheet.password}"/>
    <input type="hidden" name="orderAmt" value="${orderSheet.orderAmt}"/>
    <input type="hidden" name="pymntMeansCode" value="${orderSheet.pymntMeansCode}"/>
    <input type="hidden" name="escrowUseYn" value="${orderSheet.escrowUseYn}"/>
    <input type="hidden" name="mileage" value="${orderSheet.mileage}"/>
    <input type="hidden" name="totmileage" value="${orderSheet.totmileage}"/>
    <input type="hidden" name="deposit" value="${orderSheet.deposit}"/>
    <input type="hidden" name="gsPointUse" value="${orderSheet.gsPointUse}"/>
    <input type="hidden" name="gsId" value="${orderSheet.gsId}"/>
    <input type="hidden" name="gsPw" value="${orderSheet.gsPw}"/>
    <input type="hidden" name="userGsCardNo" value="${orderSheet.userGsCardNo}"/>
    <input type="hidden" name="gsPointSave" value="${orderSheet.gsPointSave}"/>
    <input type="hidden" name="linkTmsYn" value="${orderSheet.linkTmsYn}"/>
    <input type="hidden" name="userokCardNo" value="${orderSheet.userokCardNo}"/>
    <input type="hidden" name="userokCardPw" value="${orderSheet.userokCardPw}"/>
    <input type="hidden" name="okPointUse" value="${orderSheet.okPointUse}"/>
    <input type="hidden" name="okPointSave" value="${orderSheet.okPointSave}"/>
    
    <input type="hidden" name="lPointUse" value="${orderSheet.lPointUse}"/>
    <input type="hidden" name="userlCardNo" value="${orderSheet.userlCardNo}"/>
    <input type="hidden" name="userlPw" value="${orderSheet.userlPw}"/>
    <input type="hidden" name="lPointSave" value="${orderSheet.lPointSave}"/>
    
    <input type="hidden" name="cacaoPgToken" value=""/>
    <input type="hidden" name="cacaoTid" value=""/>
    
    <input type="hidden" name="cashRepCode" value="${orderSheet.cashRepCode}"/>
    <input type="hidden" name="cashRepCodeKi" value="${orderSheet.cashRepCodeKi}"/>
    <input type="hidden" name="cashRepHp1" value="${orderSheet.cashRepHp1}"/>
    <input type="hidden" name="cashRepHp2" value="${orderSheet.cashRepHp2}"/>
    <input type="hidden" name="cashRepHp3" value="${orderSheet.cashRepHp3}"/>
    <input type="hidden" name="cashRepCd1" value="${orderSheet.cashRepCd1}"/>
    <input type="hidden" name="cashRepCd2" value="${orderSheet.cashRepCd2}"/>
    <input type="hidden" name="cashRepCd3" value="${orderSheet.cashRepCd3}"/>
    <input type="hidden" name="cashRepCd4" value="${orderSheet.cashRepCd4}"/>
    <input type="hidden" name="cashRepbizNum1" value="${orderSheet.cashRepbizNum1}"/>
    <input type="hidden" name="cashRepbizNum2" value="${orderSheet.cashRepbizNum2}"/>
    <input type="hidden" name="cashRepbizNum3" value="${orderSheet.cashRepbizNum3}"/>
    
    <c:forEach items="${orderSheet.applyCouponInfo}" var="coupon">
        <input type="hidden" name="applyCouponInfo" value="${coupon}"/>
    </c:forEach>
    <c:if test="${empty orderSheet.applyCouponInfo}">
        <input type="hidden" name="applyCouponInfo" value=""/>
    </c:if>
    <c:forEach items="${orderSheet.applyDlvyCouponInfo}" var="dlvyCoupon">
        <input type="hidden" name="applyDlvyCouponInfo" value="${dlvyCoupon}"/>
    </c:forEach>
    <c:if test="${empty orderSheet.applyDlvyCouponInfo}">
        <input type="hidden" name="applyDlvyCouponInfo" value=""/>
    </c:if>
    <input type="hidden" name="applyOrderCouponInfo" value="${orderSheet.applyOrderCouponInfo}"/>
</form>
</body>
</html>
