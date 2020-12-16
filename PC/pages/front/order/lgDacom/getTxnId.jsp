<%@page import="com.lgcns.kmpay.dto.DealApproveDto"%>
<%@page import="com.lgcns.kmpay.service.CallWebService"%>
<%@page import="net.sf.json.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
request.setCharacterEncoding("UTF-8");
    System.setProperty("https.protocols", "TLSv1");

    JSONObject  resultJSONObject =  new JSONObject();

    String PR_TYPE = request.getParameter("prType");
    String MERCHANT_ID = request.getParameter("MID");
    String MERCHANT_TXN_NUM = request.getParameter("merchantTxnNum");
    String channelType = request.getParameter("channelType");
    byte[] PRODUCT_NAME = (""+request.getParameter("GoodsName")).getBytes("UTF-8");
    String AMOUNT = request.getParameter("Amt");
    String serviceAmt = request.getParameter("ServiceAmt");
    String supplyAmt = request.getParameter("SupplyAmt");
    String goodsVat = request.getParameter("GoodsVat");
    
    String CURRENCY = request.getParameter("currency");
    String RETURN_URL = request.getParameter("returnUrl");
    String merchantEncKey = request.getParameter("merchantEncKey");
    String merchantHashKey = request.getParameter("merchantHashKey");
    String requestDealApproveUrl = request.getParameter("requestDealApproveUrl");
    String certifiedFlag = request.getParameter("certifiedFlag");
    
    String requestorName = request.getParameter("requestorName");
    String requestorTel = request.getParameter("requestorTel");
    
    String offerPeriod = request.getParameter("offerPeriod");
    String offerPeriodFlag = request.getParameter("offerPeriodFlag");
    String possiCard = request.getParameter("possiCard");
    String fixedInt = request.getParameter("fixedInt");
    String maxInt = request.getParameter("maxInt");
    String noIntYN = request.getParameter("noIntYN");
    String noIntOpt = request.getParameter("noIntOpt");
    String pointUseYN = request.getParameter("pointUseYn");
    String blockCard = request.getParameter("blockCard");
    
    String blockBin = request.getParameter("blockBin");
    
    String resultString = "";
    String resultCode = "";
    String resultMsg = "";
    String txnId = "";
    String merchantTxnNum = "";
    String prDt = "";
    
    int timeOut = 20;
    CallWebService webService = new CallWebService(timeOut);
    
    DealApproveDto approveDto = new DealApproveDto();
    
    approveDto.setRequestDealApproveUrl(requestDealApproveUrl);
    approveDto.setMerchantEncKey(merchantEncKey); 
    approveDto.setMerchantHashKey(merchantHashKey);

    approveDto.setCertifiedFlag(certifiedFlag);
    approveDto.setPrType(PR_TYPE);
    approveDto.setChannelType(channelType);
    
    approveDto.setRequestorName(requestorName);
    approveDto.setRequestorTel(requestorTel);
    
    approveDto.setMerchantID(MERCHANT_ID);
    approveDto.setMerchantTxnNum(MERCHANT_TXN_NUM);
    
    approveDto.setProductName(new String(PRODUCT_NAME,"UTF-8"));
    
    approveDto.setAmount(AMOUNT);
    approveDto.setServiceAmt(serviceAmt);
    approveDto.setSupplyAmt(supplyAmt);
    approveDto.setGoodsVat(goodsVat);
    
    approveDto.setCurrency(CURRENCY);
    approveDto.setReturnUrl(RETURN_URL);
    
    approveDto.setOfferPeriod(offerPeriod);
    approveDto.setOfferPeriodFlag(offerPeriodFlag);
    
    approveDto.setPossiCard(possiCard);
    approveDto.setFixedInt(fixedInt);
    approveDto.setMaxInt(maxInt);
    approveDto.setNoIntYN(noIntYN);
    approveDto.setNoIntOpt(noIntOpt);
    approveDto.setPointUseYN(pointUseYN);
    approveDto.setBlockCard(blockCard);
    
    approveDto.setBlockBin(blockBin);
    
    resultJSONObject = webService.requestDealApprove(approveDto);
    resultString = resultJSONObject.toString();

    if( !resultString.equals("{}") ) {
        resultCode = resultJSONObject.getString("RESULT_CODE");
        resultMsg = resultJSONObject.getString("RESULT_MSG");
        
        if( resultCode.equals("00") ) {
            txnId = resultJSONObject.getString("TXN_ID");
            merchantTxnNum = resultJSONObject.getString("MERCHANT_TXN_NUM");
            prDt = resultJSONObject.getString("PR_DT");
        }
    }
    
%>

<script>
    function setTxnId() {
        var resultCode   = "<%=resultCode%>";
        var resultMsg    = "<%=resultMsg%>";

        var txnId           = "<%=txnId%>";
        var merchantTxnNum  = "<%=merchantTxnNum%>";
        var prDt            = "<%=prDt%>";
        
        parent.document.getElementById('resultCode').value = resultCode;
        parent.document.getElementById('resultMsg').value = resultMsg;
        parent.document.getElementById('txnId').value = txnId;
        //parent.document.getElementById('merchantTxnNum').value = merchantTxnNum;
        parent.document.getElementById('prDt').value = prDt;
        
        parent.cnspay();
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="euc-kr" lang="euc-kr">
<head></head>
<body onload="setTxnId()"></body>
</html>