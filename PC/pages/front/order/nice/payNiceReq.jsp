<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>

<%@ page import="java.net.InetAddress" %>
<ui:decorator name="none"/>
<%
/*
******************************************************* 
* <서버 IP값>
*******************************************************
*/
InetAddress inet        = InetAddress.getLocalHost();	
%>
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=yes, target-densitydpi=medium-dpi" />
<link rel="stylesheet" type="text/css" href="./css/import.css"/>
<script type="text/javascript">
//결제창 최초 요청시 실행됩니다. <<'nicepayStart()' 이름 수정 불가능>>
function nicepayStart(){
    goPay(document.payForm);
}

//결제 최종 요청시 실행됩니다. <<'nicepaySubmit()' 이름 수정 불가능>>
function nicepaySubmit(){
	var replaceUrl = "${defaultHost}/ht/order/orderComplete";
    
    // 결제 최종요청
    $("form#payForm").ajaxSubmit({
        url: "/ht/order/payResponse"
        ,dataType: "json"
        ,success: function saveSuccess(data) {
            if (data.save) {
                parent.location.replace(replaceUrl);
                return false;
            } else {
                var errorMessages = data.errorMessages;
                alert(errorMessages.join("\n"));
                parent.location.href = "http://www.hottracks.co.kr/ht/order/cart";
            }
        }
        ,error: function(xhr, status, error) {
            alert("<fmt:message key='error.common.system'/>");
            parent.location.href = "http://www.hottracks.co.kr/ht/order/cart";
        }
    });    
}

//결제창 종료 함수 <<'nicepayClose()' 이름 수정 불가능>>
function nicepayClose(){
    alert("결제가 취소 되었습니다");
    parent.location.reload();
}

</script>
<form name="payForm" id="payForm" method="post" action="/ht/order/payResponse">
    <input type="hidden" name="PayMethod" value="<c:if test="${orderSheet.pymntMeansCode == 'C011J'}">CARD</c:if><c:if test="${orderSheet.pymntMeansCode == 'C011K'}">BANK</c:if><c:if test="${orderSheet.pymntMeansCode == 'C011L'}">VBANK</c:if>">
    <input type="hidden" name="GoodsName" value="HOTTRACKS GOODS">
    <input type="hidden" name="GoodsCnt" value="1">
    <input type="hidden" name="Amt" value="${orderSheet.orderAmt}">
    <input type="hidden" name="BuyerName" value="${orderSheet.buyerName}">
    <input type="hidden" name="BuyerTel" value="${orderSheet.handPhone}">
    <input type="hidden" name="Moid" value="${orderSheet.orderNum}">
    <input type="hidden" name="MID" value="${nicePay.MID}">
    <input type="hidden" name="VbankExpDate" value="${VbankExpDate}"/>
    <input type="hidden" name="MallIP" value="<%=inet.getHostAddress()%>"/>      <!-- 상점서버IP -->
    <input type="hidden" name="CharSet" value="utf-8"/>                   <!-- 인코딩 설정 -->               
    <input type="hidden" name="BuyerEmail" value="${orderSheet.receiverEmail}"/>             <!-- 구매자 이메일 -->				  
    <input type="hidden" name="GoodsCl" value="1"/>                              <!-- 상품구분(실물(1),컨텐츠(0)) -->
    <input type="hidden" name="TransType" value="<c:if test="${orderSheet.escrowUseYn == 'Y'}">1</c:if><c:if test="${orderSheet.escrowUseYn != 'Y'}">0</c:if>"/>                            <!-- 일반(0)/에스크로(1) --> 
    
    <!-- 변경 불가능 -->
    <input type="hidden" name="EdiDate" value="${nicePay.ediDate}"/>                   <!-- 전문 생성일시 -->
    <input type="hidden" name="EncryptData" value="${nicePay.encryptData}"/>            <!-- 해쉬값	-->
    <input type="hidden" name="TrKey" value=""/>                                 <!-- 필드만 필요 -->
    

    
    
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
    <c:forEach items="${orderSheet.applyCouponInfo}" var="coupon">
        <input type="hidden" name="applyCouponInfo" value="${coupon}"/>
    </c:forEach>
    <c:forEach items="${orderSheet.applyDlvyCouponInfo}" var="dlvyCoupon">
        <input type="hidden" name="applyDlvyCouponInfo" value="${dlvyCoupon}"/>
    </c:forEach>
    <input type="hidden" name="applyOrderCouponInfo" value="${orderSheet.applyOrderCouponInfo}"/>
</form>
