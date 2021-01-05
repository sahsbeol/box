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
<title>통합LG유플러스 전자결서비스 결제테스트</title>
<script language="javascript" src="http://xpay.uplus.co.kr/xpay/js/xpay_crossplatform.js" type="text/javascript"></script>
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
<table>
    <tr>
        <td>구매자 이름 </td>
        <td>${lgUplus.lgdBuyer}서국영</td>
    </tr>
    <tr>
        <td>상품정보 </td>
        <td>${lgUplus.lgdProductInfo}</td>
    </tr>
    <tr>
        <td>결제금액 </td>
        <td>${lgUplus.lgdAmount}</td>
    </tr>
    <tr>
        <td>구매자 이메일 </td>
        <td>${lgUplus.lgdBuyerEMail}</td>
    </tr>
    <tr>
        <td>주문번호 </td>
        <td>${lgUplus.lgdOid}</td>
    </tr>
    <tr>
        <td colspan="2">* 추가 상세 결제요청 파라미터는 메뉴얼을 참조하시기 바랍니다.</td>
    </tr>
    <tr>
        <td colspan="2"></td>
    </tr>
    <tr>
        <td colspan="2">
        <input type="button" value="인증요청" onclick="launchCrossPlatform();"/>
        </td>
    </tr>
</table>
<input type="hidden" name="CST_PLATFORM"                value="${lgUplus.cstPlatform}">             <!-- 테스트, 서비스 구분 -->
<input type="hidden" name="CST_MID"                     value="${lgUplus.cstMid}">                  <!-- 상점아이디 -->
<input type="hidden" name="CST_WINDOW_TYPE"             value="submit">                  <!-- 상점아이디 -->
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
<input type="hidden" name="LGD_RETURNURL"               value="http://192.168.201.222/m/order/testpayRespons">                  <!-- 응답수신페이지 -->
<input type="hidden" name="LGD_VERSION"                 value="JSP_SmartXPay_1.0">                  <!-- 응답수신페이지 -->
<input type="hidden" name="LGD_CUSTOM_FIRSTPAY"         value="${lgUplus.lgdCustomFirstPay}">       <!-- 상점정의 초기 결제수단  -->
<input type="hidden" name="LGD_CUSTOM_SWITCHINGTYPE"    value="SUBMIT">       <!-- 신용카드 카드사 인증 페이지 연동 방식  -->

<input type="hidden" name="LGD_RESPCODE"    value="">       
<input type="hidden" name="LGD_RESPMSG"     value="">       
<input type="hidden" name="LGD_PAYKEY"      value="">       

</form>

</body>
<script type="text/javascript">
launchCrossPlatform();
</script>
</html>
