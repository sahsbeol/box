<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/pages/front/order/lgDacom/incMerchant.jsp" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="UTF-8" lang="UTF-8">
<head>
<title>CNSPay 결제 샘플 페이지</title>
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width, shrink-to-fit=no" />

<!-- OpenSource Library -->
<script src="https://pg.cnspay.co.kr/dlp/scripts/postmessage.js" type="text/javascript"></script>
<script src="https://pg.cnspay.co.kr/dlp/scripts/cnspay.js" type="text/javascript"></script>

<!-- DLP창에 대한 KaKaoPay Library -->
<script type="text/javascript" src="/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="/js/jquery.form.js" charset="utf-8"></script>

<script type="text/javascript">

    /**
    cnspay  를 통해 결제를 시작합니다.
    */
    function cnspay() {
        
        // TO-DO : 가맹점에서 해줘야할 부분(TXN_ID)과 KaKaoPay DLP 호출 API
        // 결과코드가 00(정상처리되었습니다.)
        if(document.payForm.resultCode.value == '00') {
            XD.receiveMessage( smilepay_callback, "https://pg.cnspay.co.kr" );
            cnspay_L.callPage("smilePay_layer", eval(false), smilepay_callback);
        } else {
        	alert('[RESULT_CODE] : ' + document.payForm.resultCode.value + '\n[RESULT_MSG] : ' + document.payForm.resultMsg.value);
            location.href = "${defaultHost}/m/order/cart";
        }
        
    }
    
    //smilepay 결제버튼 완료 후 호출되는 콜백
    var smilepay_callback = function (message){
        cnspay_L.destroy();
        
        if(message !=null && message.data != null && message.data != "null"){
            var obj = JSON.parse(message.data);  
            document.getElementsByName('SPU')[0].value = obj.SPU;
            document.getElementsByName('SPU_SIGN_TOKEN')[0].value = obj.SPU_SIGN_TOKEN;

            
            var replaceUrl = "http://m.hottracks.co.kr/m/order/orderComplete";
            // 매뉴얼 참조하여 부인방지코드값 관리
            $("form#payForm").ajaxSubmit({
                url: "/m/order/payMobResponse"
                ,dataType: "json"
                ,success: function saveSuccess(data) {
                    if (data.save) {
                        location.replace(replaceUrl);
                        return false;
                    } else {
                        var errorMessages = data.errorMessages;
                        alert(errorMessages.join("\n"));
                        location.href = "${defaultHost}/m/order/cart";
                    }
                }
                ,error: function(xhr, status, error) {
                    alert("<fmt:message key='error.common.system'/>");
                    location.href = "${defaultHost}/m/order/cart";
                }
            });            
            
        }else{
            alert("결제가 취소되었습니다.");
            location.href = "${defaultHost}/m/order/cart";
        }       
    }
</script>
 

</head>
<ui:decorator name="none"/>
<body onload="cnspay()">
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
            <input name="BuyerEmail" type="hidden" value=""/>
            <input name="BuyerName" type="hidden" value="${orderSheet.buyerName}"/>
            <input name="offerPeriodFlag" type="hidden" value="N"/>
            <input name="offerPeriod" type="hidden" value=""/>
            <input type="hidden" name="certifiedFlag" value="CN" readonly="readonly" style="background-color: #e2e2e2;" />
            <input type="hidden" name="currency" value="KRW" readonly="readonly" style="background-color: #e2e2e2;" />
            <input type="hidden" name="merchantEncKey" value="${cacaoPayInfo.merchantEncKey}" />
            <input type="hidden" name="merchantHashKey" value="${cacaoPayInfo.merchantHashKey}" />
            <input type="hidden" name="requestDealApproveUrl" value="${cacaoPayInfo.webPath}${cacaoPayInfo.msgName}" />
            <input type="hidden" name="prType" value="MPM" /> <!-- MPM : 모바일결제, WPM : PC결제 -->
            <input type="hidden" name="channelType" value="2" /> <!-- 2: 모바일결제, 4: PC결제 -->
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
</body>
</html>
    