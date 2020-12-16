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
<title>휴대폰 결제 인증 응답페이지</title>
<script type="text/javascript" src="/js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="/js/jquery.form.js" charset="utf-8"></script>
<script language="JavaScript">
function onPayCall() {
    document.forms['orderInfoForm'].orderNum.value = opener.document.forms['orderInfoForm'].orderNum.value;
    document.forms['orderInfoForm'].buyerName.value = opener.document.forms['orderInfoForm'].buyerName.value;
    document.forms['orderInfoForm'].buyerEmail.value = opener.document.forms['orderInfoForm'].buyerEmail.value;
    document.forms['orderInfoForm'].telePhone.value = opener.document.forms['orderInfoForm'].telePhone.value;
    document.forms['orderInfoForm'].handPhone.value = opener.document.forms['orderInfoForm'].handPhone.value;
    document.forms['orderInfoForm'].smsReceiveYn.value = opener.document.forms['orderInfoForm'].smsReceiveYn.value;
    document.forms['orderInfoForm'].receiverName.value = opener.document.forms['orderInfoForm'].receiverName.value;
    document.forms['orderInfoForm'].receiverEmail.value = opener.document.forms['orderInfoForm'].receiverEmail.value;
    document.forms['orderInfoForm'].receiverTelePhone.value = opener.document.forms['orderInfoForm'].receiverTelePhone.value;
    document.forms['orderInfoForm'].receiverHandPhone.value = opener.document.forms['orderInfoForm'].receiverHandPhone.value;
    document.forms['orderInfoForm'].receiverPostNum.value = opener.document.forms['orderInfoForm'].receiverPostNum.value;
    document.forms['orderInfoForm'].receiverAddress.value = opener.document.forms['orderInfoForm'].receiverAddress.value;
    document.forms['orderInfoForm'].receiverDetailAddress.value = opener.document.forms['orderInfoForm'].receiverDetailAddress.value;
    document.forms['orderInfoForm'].receiverDetailAddress3.value = opener.document.forms['orderInfoForm'].receiverDetailAddress3.value;
    document.forms['orderInfoForm'].receiverDetailAddress4.value = opener.document.forms['orderInfoForm'].receiverDetailAddress4.value;
    document.forms['orderInfoForm'].orderMessage.value = opener.document.forms['orderInfoForm'].orderMessage.value;
    document.forms['orderInfoForm'].giftMessage.value = opener.document.forms['orderInfoForm'].giftMessage.value;
    document.forms['orderInfoForm'].deliveryMessage.value = opener.document.forms['orderInfoForm'].deliveryMessage.value;
    document.forms['orderInfoForm'].password.value = opener.document.forms['orderInfoForm'].password.value;
    document.forms['orderInfoForm'].orderAmt.value = opener.document.forms['orderInfoForm'].orderAmt.value;
    document.forms['orderInfoForm'].pymntMeansCode.value = opener.document.forms['orderInfoForm'].pymntMeansCode.value;
    document.forms['orderInfoForm'].escrowUseYn.value = opener.document.forms['orderInfoForm'].escrowUseYn.value;
    document.forms['orderInfoForm'].mileage.value = opener.document.forms['orderInfoForm'].mileage.value;
    document.forms['orderInfoForm'].totmileage.value = opener.document.forms['orderInfoForm'].totmileage.value;
    document.forms['orderInfoForm'].deposit.value = opener.document.forms['orderInfoForm'].deposit.value;
    document.forms['orderInfoForm'].gsPointUse.value = opener.document.forms['orderInfoForm'].gsPointUse.value;
    document.forms['orderInfoForm'].gsId.value = opener.document.forms['orderInfoForm'].gsId.value;
    document.forms['orderInfoForm'].gsPw.value = opener.document.forms['orderInfoForm'].gsPw.value;
    document.forms['orderInfoForm'].userGsCardNo.value = opener.document.forms['orderInfoForm'].userGsCardNo.value;
    document.forms['orderInfoForm'].gsPointSave.value = opener.document.forms['orderInfoForm'].gsPointSave.value;
    document.forms['orderInfoForm'].linkTmsYn.value = opener.document.forms['orderInfoForm'].linkTmsYn.value;
    document.forms['orderInfoForm'].userokCardNo.value = opener.document.forms['orderInfoForm'].userokCardNo.value;
    document.forms['orderInfoForm'].userokCardPw.value = opener.document.forms['orderInfoForm'].userokCardPw.value;
    document.forms['orderInfoForm'].okPointUse.value = opener.document.forms['orderInfoForm'].okPointUse.value;
    document.forms['orderInfoForm'].okPointSave.value = opener.document.forms['orderInfoForm'].okPointSave.value;
    document.forms['orderInfoForm'].lPointUse.value = opener.document.forms['orderInfoForm'].lPointUse.value;
    document.forms['orderInfoForm'].userlCardNo.value = opener.document.forms['orderInfoForm'].userlCardNo.value;
    document.forms['orderInfoForm'].userlPw.value = opener.document.forms['orderInfoForm'].userlPw.value;
    document.forms['orderInfoForm'].lPointSave.value = opener.document.forms['orderInfoForm'].lPointSave.value;
    document.forms['orderInfoForm'].applyCouponInfo.value = opener.document.forms['orderInfoForm'].applyCouponInfo.value;
    document.forms['orderInfoForm'].applyDlvyCouponInfo.value = opener.document.forms['orderInfoForm'].applyDlvyCouponInfo.value;
    document.forms['orderInfoForm'].applyOrderCouponInfo.value = opener.document.forms['orderInfoForm'].applyOrderCouponInfo.value;
    
    var replaceUrl = "http://www.hottracks.co.kr/ht/order/orderComplete";
    
    // 결제 최종요청
    $("form#orderInfoForm").ajaxSubmit({
        url: "/ht/order/payResponse"
        ,dataType: "json"
        ,success: function saveSuccess(data) {
            if (data.save) {
                opener.parent.location.replace(replaceUrl);
                window.close();
                return false;
            } else {
                var errorMessages = data.errorMessages;
                alert(errorMessages.join("\n"));
                opener.parent.location.href = "${defaultHost}/ht/order/cart";
                window.close();
            }
        }
        ,error: function(xhr, status, error) {
            alert("<fmt:message key='error.common.system'/>");
            opener.parent.location.href = "${defaultHost}/ht/order/cart";
            window.close();
        }
    });
}
</script>
</head>

<body onload="javascript:onPayCall();">
<form id="orderInfoForm" action="/ht/order/payResponse" method="post">

    <input type="hidden" name="Mob_Phoneid" value="${param.USERKEY}"/>
    <input type="hidden" name="Mob_Tradeid" value="${param.Tradeid}"/>
    <input type="hidden" name="Mob_Prdtnm" value="${param.Prdtnm}"/>
    <input type="hidden" name="Mob_Prdtprice" value="${param.Prdtprice}"/>
    <input type="hidden" name="Mob_Mobilid" value="${param.Mobilid}"/>
    <input type="hidden" name="Mob_Userid" value="${param.Userid}"/>
    <input type="hidden" name="Mob_Userip" value="${param.Userip}"/>
    <input type="hidden" name="Mob_MSTR" value="${param.MSTR}"/>
    <input type="hidden" name="Mob_Email" value="${param.Email}"/>
    
    <input type="hidden" name="orderNum" id="orderNum" value=""/>
    <input type="hidden" name="buyerName" id="buyerName" value=""/>
    <input type="hidden" name="buyerEmail" id="buyerEmail" value=""/>
    <input type="hidden" name="telePhone" id="telePhone" value=""/>
    <input type="hidden" name="handPhone" id="handPhone" value=""/>
    <input type="hidden" name="smsReceiveYn" id="smsReceiveYn" value=""/>
    <input type="hidden" name="receiverName" id="receiverName" value=""/>
    <input type="hidden" name="receiverEmail" id="receiverEmail" value=""/>
    <input type="hidden" name="receiverTelePhone" id="receiverTelePhone" value=""/>
    <input type="hidden" name="receiverHandPhone" id="receiverHandPhone" value=""/>
    <input type="hidden" name="receiverPostNum" id="receiverPostNum" value=""/>
    <input type="hidden" name="receiverAddress" id="receiverAddress" value=""/>
    <input type="hidden" name="receiverDetailAddress" id="receiverDetailAddress" value=""/>
    <input type="hidden" name="receiverDetailAddress3" id="receiverDetailAddress3" value=""/>
    <input type="hidden" name="receiverDetailAddress4" id="receiverDetailAddress4" value=""/>
    <input type="hidden" name="orderMessage" id="orderMessage" value=""/>
    <input type="hidden" name="giftMessage" id="giftMessage" value=""/>
    <input type="hidden" name="deliveryMessage" id="deliveryMessage" value=""/>
    <input type="hidden" name="password" id="password" value=""/>
    <input type="hidden" name="orderAmt" id="orderAmt" value=""/>
    <input type="hidden" name="pymntMeansCode" id="pymntMeansCode" value=""/>
    <input type="hidden" name="escrowUseYn" id="escrowUseYn" value=""/>
    <input type="hidden" name="mileage" id="mileage" value=""/>
    <input type="hidden" name="totmileage" id="totmileage" value=""/>
    <input type="hidden" name="deposit" id="deposit" value=""/>
    <input type="hidden" name="gsPointUse" id="gsPointUse" value=""/>
    <input type="hidden" name="gsId" id="gsId" value=""/>
    <input type="hidden" name="gsPw" id="gsPw" value=""/>
    <input type="hidden" name="userGsCardNo" id="userGsCardNo" value=""/>
    <input type="hidden" name="gsPointSave" id="gsPointSave" value=""/>
    <input type="hidden" name="linkTmsYn" id="linkTmsYn" value=""/>
    <input type="hidden" name="userokCardNo" id="userokCardNo" value=""/>
    <input type="hidden" name="userokCardPw" id="userokCardPw" value=""/>
    <input type="hidden" name="okPointUse" id="okPointUse" value=""/>
    <input type="hidden" name="okPointSave" id="okPointSave" value=""/>
    <input type="hidden" name="lPointUse" id="lPointUse" value=""/>
    <input type="hidden" name="userlCardNo" id="userlCardNo" value=""/>
    <input type="hidden" name="userlPw" id="userlPw" value=""/>
    <input type="hidden" name="lPointSave" id="lPointSave" value=""/>
    <input type="hidden" name="applyCouponInfo" id="applyCouponInfo" value=""/>
    <input type="hidden" name="applyDlvyCouponInfo" id="applyDlvyCouponInfo" value=""/>
    <input type="hidden" name="applyOrderCouponInfo" id="applyOrderCouponInfo" value=""/>
</form>
</body>
</html>
