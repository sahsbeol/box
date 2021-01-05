﻿<%@ page contentType="text/html; charset=UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>

<%@ page import="java.net.InetAddress" %>
<ui:decorator name="none"/>
<%
//InetAddress inet= InetAddress.getLocalHost();	
%>
<!DOCTYPE html>
<html>
<head>
<title>NICEPAY PAY REQUEST(UTF-8)</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=yes, target-densitydpi=medium-dpi" />
<link rel="stylesheet" type="text/css" href="./css/import.css"/>
<script type="text/javascript">
//결제창 최초 요청시 실행됩니다.
function nicepayStart(){
    document.charset = "euc-kr";
    document.payForm.submit();
}
</script>
</head>
<body>
<form name="payForm" method="post" target="_self" action="https://web.nicepay.co.kr/v3/smart/smartPayment.jsp" accept-charset="euc-kr">
    <input type="hidden" name="PayMethod" value="<c:if test="${orderSheet.pymntMeansCode == 'C011J' || orderSheet.pymntMeansCode == 'C011M' || orderSheet.pymntMeansCode == 'C011N'}">CARD</c:if><c:if test="${orderSheet.pymntMeansCode == 'C011K'}">BANK</c:if><c:if test="${orderSheet.pymntMeansCode == 'C011L'}">VBANK</c:if>">
	<input type="hidden" name="GoodsName" value="HOTTRACKS GOODS">
	<input type="hidden" name="GoodsCnt" value="1">
	<input type="hidden" name="Amt" value="${orderSheet.orderAmt}">
    <input type="hidden" name="BuyerName" value="${orderSheet.buyerName}">
    <input type="hidden" name="BuyerTel" value="${orderSheet.handPhone}">
    <input type="hidden" name="Moid" value="${orderSheet.orderNum}">
    <input type="hidden" name="MID" value="${nicePay.MID}">
    <input type="hidden" name="VbankExpDate" value="${VbankExpDate}"/>
	<input type="hidden" name="MallIP" value="175.116.81.48"/>      <!-- 상점서버IP -->
	<input type="hidden" name="GoodsCl" value="1"/>                   <!-- 상품구분 실물(1), 컨텐츠(0) -->
    <input type="hidden" name="CharSet" value="utf-8"/>                   <!-- 인코딩 설정 -->
	<input type="hidden" name="ReturnURL" value="http://devm.hottracks.co.kr/m/order/payResponse">                <!-- Return URL -->
	<input type="hidden" name="EdiDate" value="${nicePay.ediDate}"/>                   <!-- 전문 생성일시 -->
    <input type="hidden" name="EncryptData" value="${nicePay.encryptData}"/>            <!-- 해쉬값    -->
    <input type="hidden" name="TrKey" value=""/>                                 <!-- 필드만 필요 -->
    <input type="hidden" name="AcsNoIframe" value="Y"/>						   <!-- 나이스페이 결제창 프레임 옵션 (변경불가) -->
    
    <c:if test="${orderSheet.pymntMeansCode == 'C011M' || orderSheet.pymntMeansCode == 'C011N'}">
	    <input type="hidden" name="DirectShowOpt" value="CARD"/>
	    <input type="hidden" name="NicepayReserved" value="<c:if test="${orderSheet.pymntMeansCode == 'C011M'}">DirectKakao=Y</c:if><c:if test="${orderSheet.pymntMeansCode == 'C011N'}">DirectPayco=Y</c:if>"/>
    </c:if>
    
	<a href="#" class="btn_blue" onClick="nicepayStart();">요 청</a>
</form>
<script type="text/javascript">
nicepayStart();
</script>
</body>
</html>