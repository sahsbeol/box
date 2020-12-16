<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/pages/front/order/lgDacom/incMerchant.jsp" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %> 
<ui:decorator name="none"/>
    <form name="payForm" id="payForm" action=""  method="post" accept-charset = "">
        <!-- 결제 파라미터 목록 -->
        <input type="hidden" name="PayMethod" value="SMILEPAY" id="smilepay" checked="checked"/>
        <input name="GoodsName" type="hidden" value="Hottracks Goods"/>
            <input name="Amt" type="hidden" value="${cacaoPayInfo.cacaoAmt}"/>
            <input name="SupplyAmt" type="hidden" value="0"/>
            <input name="GoodsVat" type="hidden" value="0"/>
            <input name="ServiceAmt" type="hidden" value="0"/>
            <input name="GoodsCnt" type="hidden"  value="1" readonly="readonly" style="background-color: #e2e2e2;" />
            <input name="MID" type="hidden" value="${cacaoPayInfo.MID}" />
            <input name="AuthFlg" type="hidden" value="10" readonly="readonly" style="background-color: #e2e2e2;" />
            <input name="EdiDate" type="hidden" value="${cacaoPayInfo.ediDate}" readonly="readonly" style="background-color: #e2e2e2;"/>
            <input name="EncryptData" type="hidden" value="${cacaoPayInfo.hash_String}" readonly="readonly" style="background-color: #e2e2e2;"/>
            <input name="BuyerEmail" type="hidden" value="${orderSheet.buyerEmail}"/>
            <input name="BuyerName" type="hidden" value="${orderSheet.buyerName}"/>
            <input name="offerPeriodFlag" type="hidden" value="N"/>
            <input name="offerPeriod" type="hidden" value=""/>
            <input type="hidden" name="certifiedFlag" value="CN" readonly="readonly" style="background-color: #e2e2e2;" />
            <input type="hidden" name="currency" value="KRW" readonly="readonly" style="background-color: #e2e2e2;" />
            <input type="hidden" name="merchantEncKey" value="${cacaoPayInfo.merchantEncKey}" />
            <input type="hidden" name="merchantHashKey" value="${cacaoPayInfo.merchantHashKey}" />
            <input type="hidden" name="requestDealApproveUrl" value="${cacaoPayInfo.webPath}${cacaoPayInfo.msgName}" />
            <input type="hidden" name="prType" value="WPM" /> <!-- MPM : 모바일결제, WPM : PC결제 -->
            <input type="hidden" name="channelType" value="4" /> <!-- 2: 모바일결제, 4: PC결제 -->
            <input type="hidden" name="merchantTxnNum" value="${orderSheet.orderNum}" />
        <br />
        <input id="resultCode" type="hidden" value="${resTxnId.resultCode}"/>
        <input id="resultMsg" type="hidden" value="${resTxnId.resultMsg}"/>
        <input id="txnId" type="hidden" value="${resTxnId.txnId}"/>
        <input id="prDt" type="hidden" value="${resTxnId.prDt}"/>
        <input type="hidden" name="SPU" value=""/>
        <input type="hidden" name="SPU_SIGN_TOKEN" value=""/>
    </form>
    
        <!-- TODO :  LayerPopup의 Target DIV 생성 -->
        <div id="smilePay_layer"  style="display: none"></div>
    
    <iframe name="txnIdGetterFrame" id="txnIdGetterFrame" src=""  width="0" height="0"></iframe>

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

    
    
    <c:forEach items="${orderSheet.applyCouponInfo}" var="coupon">
        <input type="hidden" name="applyCouponInfo" value="${coupon}"/>
    </c:forEach>
    <c:forEach items="${orderSheet.applyDlvyCouponInfo}" var="dlvyCoupon">
        <input type="hidden" name="applyDlvyCouponInfo" value="${dlvyCoupon}"/>
    </c:forEach>
    <input type="hidden" name="applyOrderCouponInfo" value="${orderSheet.applyOrderCouponInfo}"/>
</form>


