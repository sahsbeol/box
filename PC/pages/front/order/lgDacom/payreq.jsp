<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="none"/>
<form method="post" id="LGD_PAYINFO" action="#">
<input type="hidden" name="CST_PLATFORM"                value="${lgUplus.cstPlatform}">             <!-- 테스트, 서비스 구분 -->
<input type="hidden" name="CST_MID"                     value="${lgUplus.cstMid}">                  <!-- 상점아이디 -->
<input type="hidden" name="LGD_WINDOW_TYPE"             value="iframe">                             <!-- 상점아이디 -->
<input type="hidden" name="LGD_MID"                     value="${lgUplus.lgdMid}">                  <!-- 상점아이디 -->
<input type="hidden" name="LGD_OID"                     value="${lgUplus.lgdOid}">                  <!-- 주문번호 -->
<input type="hidden" name="LGD_BUYER"                   value="${lgUplus.lgdBuyer}">                <!-- 구매자 -->
<input type="hidden" name="LGD_PRODUCTINFO"             value="${lgUplus.lgdProductInfo}">          <!-- 상품정보 -->
<input type="hidden" name="LGD_AMOUNT"                  value="${lgUplus.lgdAmount}">               <!-- 결제금액 -->
<input type="hidden" name="LGD_BUYEREMAIL"              value="${lgUplus.lgdBuyerEMail}">           <!-- 구매자 이메일 -->
<input type="hidden" name="LGD_CUSTOM_SKIN"             value="${lgUplus.lgdCustomSkin}">           <!-- 결제창 SKIN -->
<input type="hidden" name="LGD_CUSTOM_PROCESSTYPE"      value="${lgUplus.lgdCustomProcessType}">    <!-- 트랜잭션 처리방식 -->
<input type="hidden" name="LGD_TIMESTAMP"               value="${lgUplus.lgdTimestamp}">            <!-- 타임스탬프 -->
<input type="hidden" name="LGD_HASHDATA"                value="${lgUplus.lgdHashData}">             <!-- MD5 해쉬암호값 -->
<input type="hidden" name="LGD_CUSTOM_FIRSTPAY"         value="${lgUplus.lgdCustomFirstPay}">       <!-- 상점정의 초기 결제수단  -->
<input type="hidden" name="LGD_CUSTOM_USABLEPAY"        value="${lgUplus.lgdCustomUsablePay}">      <!-- 상점정의  결제 가능 수단 -->
<input type="hidden" name="LGD_ESCROW_USEYN"            value="${lgUplus.lgdEscrowUseYn}">          <!-- 에스크로 적용여부 -->
<input type="hidden" name="LGD_PAYKEY"                  id="LGD_PAYKEY">                            <!-- LG데이콤 PAYKEY(인증후 자동셋팅)-->

<input type="hidden" name="LGD_BUYERID"                 value="${lgUplus.lgdBuyerId}">
<input type="hidden" name="LGD_BUYERIP"                 value="${lgUplus.lgdBuyerIp}">
<input type="hidden" name="LGD_CUSTOM_LOGO"             value="${imageServer}/images/order/hottracks_my.jpg">
<input type="hidden" name="LGD_VERSION"                 value="JSP_SmartXPay_1.0">
<input type="hidden" name="LGD_CASHRECEIPTSELFYN"       value="Y">
<input type="hidden" name="LGD_CASHRECEIPTYN"           value="${lgUplus.lgdCashReceiptYn}">        <!-- 현금영수증 사용여부 -->
<input type="hidden" name="LGD_WINDOW_VER"              id="LGD_WINDOW_VER" value="2.5">
<input type="hidden" name="LGD_RETURNURL"              id="LGD_RETURNURL" value="https://www.hottracks.co.kr/pages/front/order/lgDacom/returnurl.jsp">
<input type="hidden" name="LGD_ENCODING"              id="LGD_ENCODING" value="UTF-8">
<input type="hidden" name="LGD_ENCODING_NOTEURL"              id="LGD_ENCODING_NOTEURL" value="UTF-8">
<input type="hidden" name="LGD_ENCODING_RETURNURL"              id="LGD_ENCODING_RETURNURL" value="UTF-8">
<input type="hidden" name="sellPrdtGbn" value="${sellPrdtGbn }" />

<c:if test="${lgUplus.lgdEscrowUseYn eq 'Y'}">
    <c:forEach items="${lgUplus.lgdEscrowGoodList}" var="good" varStatus="status">
        <input type="hidden" name="LGD_ESCROW_GOODID" value="${orderSheet.orderNum}<c:if test='${status.count < 10}'>0</c:if>${status.count}">
        <input type="hidden" name="LGD_ESCROW_GOODNAME" value="${good.prdtName}">
        <input type="hidden" name="LGD_ESCROW_GOODCODE" value="${good.sellPrdtBcode}">
        <input type="hidden" name="LGD_ESCROW_UNITPRICE" value="${good.sellPrice}">
        <input type="hidden" name="LGD_ESCROW_QUANTITY" value="${good.prdtCount}">
    </c:forEach>
    <input type="hidden" name="LGD_ESCROW_USEYN" value="${lgUplus.lgdEscrowUseYn}">
    <input type="hidden" name="LGD_ESCROW_ZIPCODE" value="${orderSheet.receiverPostNum}">
    <input type="hidden" name="LGD_ESCROW_ADDRESS1" value="${orderSheet.receiverAddress}">
    <input type="hidden" name="LGD_ESCROW_ADDRESS2" value="${orderSheet.receiverDetailAddress}">
    <input type="hidden" name="LGD_ESCROW_BUYERPHONE" value="${orderSheet.handPhone}">
</c:if>
<c:if test="${lgUplus.lgdAmount < 50000}">
    <input type="hidden" name="LGD_NOINTINF" value="">
</c:if>
<c:if test="${lgUplus.lgdAmount >= 50000}">
    <input type="hidden" name="LGD_NOINTINF" value="41-2:3">
</c:if>
<input type="hidden" name="LGD_CASNOTEURL" value="http://admin.hottracks.co.kr/pages/backoffice/calculate/noCashCheck.jsp">        <!-- 무통장 입금내역 DB연동Page -->
<input type="hidden" name="LGD_CLOSEDATE" value="${lgUplus.lgdCloseDate}">            <!-- 타임스탬프 -->
</form>

<form id="LGD_PAYINFO_COMPLETE_FORM" action="/ht/order/payResponse" method="post"></form>


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
    <input type="button" value="인증요청" onclick="launchCrossPlatform();"/>
</form>
