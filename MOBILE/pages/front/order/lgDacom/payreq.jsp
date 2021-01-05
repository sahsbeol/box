<%@ page contentType="text/html;charset=EUC-KR" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="none"/>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">

<title>통합LG유플러스 전자결서비스 결제</title>
<!-- <script language="javascript" src="https://xpay.uplus.co.kr/xpay/js/xpay_crossplatform.js" type="text/javascript"></script> -->
<script language="javascript" src="https://xpayvvip.uplus.co.kr/xpay/js/xpay_crossplatform.js" type="text/javascript"></script>
<script type="text/javascript">

/*
* iframe으로 결제창을 호출하시기를 원하시면 iframe으로 설정 (변수명 수정 불가)
*/
    var LGD_window_type = 'submit';
/*
* 수정불가
*/
function launchCrossPlatform(){
      lgdwin = open_paymentwindow(document.getElementById('LGD_PAYINFO'), '${lgUplus.cstPlatform}', LGD_window_type);
}
/*
* FORM 명만  수정 가능
*/
function getFormObject() {
        return document.getElementById("LGD_PAYINFO");
}

</script>
</head>
<body>
<form method="post" name="LGD_PAYINFO" id="LGD_PAYINFO" action="">
<input type="hidden" name="CST_PLATFORM"             id="CST_PLATFORM"    value="${lgUplus.cstPlatform}">             <!-- 테스트, 서비스 구분 -->
<input type="hidden" name="CST_MID"                     id="CST_MID"  value="${lgUplus.cstMid}">                  <!-- 상점아이디 -->
<input type="hidden" name="CST_WINDOW_TYPE"       id="CST_WINDOW_TYPE"       value="submit">                  <!-- 상점아이디 -->
<input type="hidden" name="LGD_MID"                 id="LGD_MID"       value="${lgUplus.lgdMid}">                  <!-- 상점아이디 -->
<input type="hidden" name="LGD_OID"                 id="LGD_OID"      value="${lgUplus.lgdOid}">                  <!-- 주문번호 -->
<input type="hidden" name="LGD_BUYER"              id="LGD_BUYER"           value="${lgUplus.lgdBuyer}">                <!-- 구매자 -->
<input type="hidden" name="LGD_PRODUCTINFO"     id="LGD_PRODUCTINFO"         value="${lgUplus.lgdProductInfo}">          <!-- 상품정보 -->
<input type="hidden" name="LGD_AMOUNT"            id="LGD_AMOUNT"        value="${lgUplus.lgdAmount}">               <!-- 결제금액 -->
<input type="hidden" name="LGD_BUYEREMAIL"        id="LGD_BUYEREMAIL"       value="${lgUplus.lgdBuyerEMail}">           <!-- 구매자 이메일 -->
<input type="hidden" name="LGD_CUSTOM_SKIN"      id="LGD_CUSTOM_SKIN"        value="${lgUplus.lgdCustomSkin}">           <!-- 결제창 SKIN -->
<input type="hidden" name="LGD_CUSTOM_PROCESSTYPE"  id="LGD_CUSTOM_PROCESSTYPE"      value="${lgUplus.lgdCustomProcessType}">    <!-- 트랜잭션 처리방식 -->
<input type="hidden" name="LGD_TIMESTAMP"         id="LGD_TIMESTAMP"         value="${lgUplus.lgdTimestamp}">            <!-- 타임스탬프 -->
<input type="hidden" name="LGD_HASHDATA"         id="LGD_HASHDATA"          value="${lgUplus.lgdHashData}">             <!-- MD5 해쉬암호값 -->
<input type="hidden" name="LGD_RETURNURL"         id="LGD_RETURNURL"         value="${lgUplus.lgdReturnUrl}">            <!-- 응답수신페이지 -->
<input type="hidden" name="LGD_VERSION"            id="LGD_VERSION"       value="JSP_Non-ActiveX_SmartXPay">                  <!-- 응답수신페이지 -->
<input type="hidden" name="LGD_CUSTOM_FIRSTPAY"    id="LGD_CUSTOM_FIRSTPAY"       value="${lgUplus.lgdCustomFirstPay}">       <!-- 상점정의 초기 결제수단  -->
<c:if test="${lgUplus.lgdAmount < 50000}">
    <input type="hidden" name="LGD_NOINTINF" value="">
</c:if>
<c:if test="${lgUplus.lgdAmount >= 50000}">
    <input type="hidden" name="LGD_NOINTINF" value="41-2:3">
</c:if>
<input type="hidden" name="LGD_CASNOTEURL"  id="LGD_CASNOTEURL" value="http://admin.hottracks.co.kr/pages/backoffice/calculate/noCashCheck.jsp">
<input type="hidden" name="LGD_CLOSEDATE"  id="LGD_CLOSEDATE" value="${lgUplus.lgdCloseDate}">                          <!-- 타임스탬프 -->
<input type="hidden" name="LGD_CUSTOM_SWITCHINGTYPE"  id="LGD_CUSTOM_SWITCHINGTYPE"   value="SUBMIT">       <!-- 신용카드 카드사 인증 페이지 연동 방식  -->

<input type="hidden" name="LGD_ESCROW_USEYN"       id="LGD_ESCROW_USEYN"          value="N">          <!-- 에스크로 적용여부 -->
<input type="hidden" name="LGD_BUYERID"              id="LGD_BUYERID"         value="${lgUplus.lgdBuyerId}">
<input type="hidden" name="LGD_BUYERIP"           id="LGD_BUYERIP"        value="${lgUplus.lgdBuyerIp}">

<input type="hidden" name="LGD_CASHRECEIPTSELFYN"    id="LGD_CASHRECEIPTSELFYN"     value="Y">
<input type="hidden" name="LGD_CASHRECEIPTYN"         id="LGD_CASHRECEIPTYN"      value="Y">        <!-- 현금영수증 사용여부 -->
<input type="hidden" name="LGD_WINDOW_VER"              id="LGD_WINDOW_VER" value="2.5">
<input type="hidden" name="LGD_OSTYPE_CHECK"              id="LGD_OSTYPE_CHECK" value="M">
<input type="hidden" name="LGD_ACTIVEXYN"              id="LGD_ACTIVEXYN" value="N">

<!-- 계좌이체 필수 -->
<input type="hidden" name="LGD_MTRANSFERWAPURL"              id="LGD_MTRANSFERWAPURL" value="">
<input type="hidden" name="LGD_MTRANSFERCANCELURL"              id="LGD_MTRANSFERCANCELURL" value="">
<!-- 계좌이체 필수 끝-->

<!-- 
    ****************************************************
    * 모바일 OS별 ISP(국민/비씨), 계좌이체 결제 구분 값
    ****************************************************
    1) Web to Web
    - 안드로이드: A (디폴트)
    - iOS: N
      ** iOS일 경우, 반드시 N으로 값을 수정
    2) App to Web(반드시 SmartXPay_AppToWeb_연동가이드를 참조합니다.)
    - 안드로이드, iOS: A
 -->
<input type="hidden" name="LGD_KVPMISPAUTOAPPYN"              id="LGD_KVPMISPAUTOAPPYN" value="A">
<input type="hidden" name="LGD_MTRANSFERAUTOAPPYN"              id="LGD_MTRANSFERAUTOAPPYN" value="A">
<!-- 모바일 OS별 ISP(국민/비씨), 계좌이체 결제 구분 값 끝 -->


<input type="hidden" name="LGD_RESPCODE"    value="">
<input type="hidden" name="LGD_RESPMSG"     value="">
<input type="hidden" name="LGD_PAYKEY"      value="">

</form>

</body>
<script type="text/javascript">

var browerAgent  = navigator.userAgent;
if (browerAgent.indexOf("iPhone") != -1) {
	    document.LGD_PAYINFO.LGD_KVPMISPAUTOAPPYN.value = "N";  
	    document.LGD_PAYINFO.LGD_MTRANSFERAUTOAPPYN.value = "N";		
}

launchCrossPlatform();
</script>
</html>
