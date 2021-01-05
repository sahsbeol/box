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

<title>����LG���÷��� ���ڰἭ�� ����</title>
<!-- <script language="javascript" src="https://xpay.uplus.co.kr/xpay/js/xpay_crossplatform.js" type="text/javascript"></script> -->
<script language="javascript" src="https://xpayvvip.uplus.co.kr/xpay/js/xpay_crossplatform.js" type="text/javascript"></script>
<script type="text/javascript">

/*
* iframe���� ����â�� ȣ���Ͻñ⸦ ���Ͻø� iframe���� ���� (������ ���� �Ұ�)
*/
    var LGD_window_type = 'submit';
/*
* �����Ұ�
*/
function launchCrossPlatform(){
      lgdwin = open_paymentwindow(document.getElementById('LGD_PAYINFO'), '${lgUplus.cstPlatform}', LGD_window_type);
}
/*
* FORM ��  ���� ����
*/
function getFormObject() {
        return document.getElementById("LGD_PAYINFO");
}

</script>
</head>
<body>
<form method="post" name="LGD_PAYINFO" id="LGD_PAYINFO" action="">
<input type="hidden" name="CST_PLATFORM"             id="CST_PLATFORM"    value="${lgUplus.cstPlatform}">             <!-- �׽�Ʈ, ���� ���� -->
<input type="hidden" name="CST_MID"                     id="CST_MID"  value="${lgUplus.cstMid}">                  <!-- �������̵� -->
<input type="hidden" name="CST_WINDOW_TYPE"       id="CST_WINDOW_TYPE"       value="submit">                  <!-- �������̵� -->
<input type="hidden" name="LGD_MID"                 id="LGD_MID"       value="${lgUplus.lgdMid}">                  <!-- �������̵� -->
<input type="hidden" name="LGD_OID"                 id="LGD_OID"      value="${lgUplus.lgdOid}">                  <!-- �ֹ���ȣ -->
<input type="hidden" name="LGD_BUYER"              id="LGD_BUYER"           value="${lgUplus.lgdBuyer}">                <!-- ������ -->
<input type="hidden" name="LGD_PRODUCTINFO"     id="LGD_PRODUCTINFO"         value="${lgUplus.lgdProductInfo}">          <!-- ��ǰ���� -->
<input type="hidden" name="LGD_AMOUNT"            id="LGD_AMOUNT"        value="${lgUplus.lgdAmount}">               <!-- �����ݾ� -->
<input type="hidden" name="LGD_BUYEREMAIL"        id="LGD_BUYEREMAIL"       value="${lgUplus.lgdBuyerEMail}">           <!-- ������ �̸��� -->
<input type="hidden" name="LGD_CUSTOM_SKIN"      id="LGD_CUSTOM_SKIN"        value="${lgUplus.lgdCustomSkin}">           <!-- ����â SKIN -->
<input type="hidden" name="LGD_CUSTOM_PROCESSTYPE"  id="LGD_CUSTOM_PROCESSTYPE"      value="${lgUplus.lgdCustomProcessType}">    <!-- Ʈ����� ó����� -->
<input type="hidden" name="LGD_TIMESTAMP"         id="LGD_TIMESTAMP"         value="${lgUplus.lgdTimestamp}">            <!-- Ÿ�ӽ����� -->
<input type="hidden" name="LGD_HASHDATA"         id="LGD_HASHDATA"          value="${lgUplus.lgdHashData}">             <!-- MD5 �ؽ���ȣ�� -->
<input type="hidden" name="LGD_RETURNURL"         id="LGD_RETURNURL"         value="${lgUplus.lgdReturnUrl}">            <!-- ������������� -->
<input type="hidden" name="LGD_VERSION"            id="LGD_VERSION"       value="JSP_Non-ActiveX_SmartXPay">                  <!-- ������������� -->
<input type="hidden" name="LGD_CUSTOM_FIRSTPAY"    id="LGD_CUSTOM_FIRSTPAY"       value="${lgUplus.lgdCustomFirstPay}">       <!-- �������� �ʱ� ��������  -->
<c:if test="${lgUplus.lgdAmount < 50000}">
    <input type="hidden" name="LGD_NOINTINF" value="">
</c:if>
<c:if test="${lgUplus.lgdAmount >= 50000}">
    <input type="hidden" name="LGD_NOINTINF" value="41-2:3">
</c:if>
<input type="hidden" name="LGD_CASNOTEURL"  id="LGD_CASNOTEURL" value="http://admin.hottracks.co.kr/pages/backoffice/calculate/noCashCheck.jsp">
<input type="hidden" name="LGD_CLOSEDATE"  id="LGD_CLOSEDATE" value="${lgUplus.lgdCloseDate}">                          <!-- Ÿ�ӽ����� -->
<input type="hidden" name="LGD_CUSTOM_SWITCHINGTYPE"  id="LGD_CUSTOM_SWITCHINGTYPE"   value="SUBMIT">       <!-- �ſ�ī�� ī��� ���� ������ ���� ���  -->

<input type="hidden" name="LGD_ESCROW_USEYN"       id="LGD_ESCROW_USEYN"          value="N">          <!-- ����ũ�� ���뿩�� -->
<input type="hidden" name="LGD_BUYERID"              id="LGD_BUYERID"         value="${lgUplus.lgdBuyerId}">
<input type="hidden" name="LGD_BUYERIP"           id="LGD_BUYERIP"        value="${lgUplus.lgdBuyerIp}">

<input type="hidden" name="LGD_CASHRECEIPTSELFYN"    id="LGD_CASHRECEIPTSELFYN"     value="Y">
<input type="hidden" name="LGD_CASHRECEIPTYN"         id="LGD_CASHRECEIPTYN"      value="Y">        <!-- ���ݿ����� ��뿩�� -->
<input type="hidden" name="LGD_WINDOW_VER"              id="LGD_WINDOW_VER" value="2.5">
<input type="hidden" name="LGD_OSTYPE_CHECK"              id="LGD_OSTYPE_CHECK" value="M">
<input type="hidden" name="LGD_ACTIVEXYN"              id="LGD_ACTIVEXYN" value="N">

<!-- ������ü �ʼ� -->
<input type="hidden" name="LGD_MTRANSFERWAPURL"              id="LGD_MTRANSFERWAPURL" value="">
<input type="hidden" name="LGD_MTRANSFERCANCELURL"              id="LGD_MTRANSFERCANCELURL" value="">
<!-- ������ü �ʼ� ��-->

<!-- 
    ****************************************************
    * ����� OS�� ISP(����/��), ������ü ���� ���� ��
    ****************************************************
    1) Web to Web
    - �ȵ���̵�: A (����Ʈ)
    - iOS: N
      ** iOS�� ���, �ݵ�� N���� ���� ����
    2) App to Web(�ݵ�� SmartXPay_AppToWeb_�������̵带 �����մϴ�.)
    - �ȵ���̵�, iOS: A
 -->
<input type="hidden" name="LGD_KVPMISPAUTOAPPYN"              id="LGD_KVPMISPAUTOAPPYN" value="A">
<input type="hidden" name="LGD_MTRANSFERAUTOAPPYN"              id="LGD_MTRANSFERAUTOAPPYN" value="A">
<!-- ����� OS�� ISP(����/��), ������ü ���� ���� �� �� -->


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
