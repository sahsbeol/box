<%@page import="kr.co.lgcns.module.lite.CnsPayWebConnector"%>
<%@ page contentType="text/html; charset=euc-kr"%>

<%

    System.out.println("Seo================:kakaopayLiteResult.jsp");

    request.setCharacterEncoding("euc-kr"); 
    
    // ����� ��ġ�Ǿ� �ִ� ��� ����
    CnsPayWebConnector connector = new CnsPayWebConnector();
    
    // 1. �α� ���丮 ���� : cnsPayHome/log �� ����
    connector.setLogHome("D:\\cacaolog"); //�������� �α����� ���� ��ġ
    connector.setCnsPayHome("D:\\cacaolog"); // cnspay.properties���� ��ġ
    
    // 2. ��û ������ �Ķ���� ����
    connector.setRequestData(request);
    
    // 3. �߰� �Ķ���� ����
    connector.addRequestData("actionType", "PY0");              // actionType : CL0 ���, PY0 ����
    connector.addRequestData("MallIP", request.getRemoteAddr());// ������ ���� ip
    
    //������Ű ���� (MID ���� Ʋ��) 
    connector.addRequestData("EncodeKey", "33F49GnCMS1mFYlGXisbUDzVf2ATWCl9k3R++d5hDd3Frmuos/XLx8XhXpe+LDYAbpGKZYSwtlyyLOtS/8aD7A==");
    
    // 4. CNSPAY Lite ���� �����Ͽ� ó��
    connector.requestAction();
    
    // 5. ��� ó��
    String resultCode = connector.getResultData("ResultCode");      // ����ڵ� (���� :3001 , �� �� ����)
    String resultMsg = connector.getResultData("ResultMsg");        // ����޽���
    String authDate = connector.getResultData("AuthDate");          // �����Ͻ� YYMMDDHH24mmss
    String authCode = connector.getResultData("AuthCode");          // ���ι�ȣ
    String buyerName = connector.getResultData("BuyerName");        // �����ڸ�
    String goodsName = connector.getResultData("GoodsName");        // ��ǰ��
    String payMethod = connector.getResultData("PayMethod");        // ��������
    String mid = connector.getResultData("MID");                    // ������ID
    String tid = connector.getResultData("TID");                    // �ŷ�ID
    String moid = connector.getResultData("Moid");                  // �ֹ���ȣ
    String amt = connector.getResultData("Amt");                    // �ݾ�
    String cardCode = connector.getResultData("CardCode");          // ī��� �ڵ�
    String cardName = connector.getResultData("CardName");          // ����ī����
    String cardQuota = connector.getResultData("CardQuota");        // �Һΰ����� ex) 00:�Ͻú�,02:2����
    String cardInterest = connector.getResultData("CardInterest");  // ������ ���� (0:�Ϲ�, 1:������)
    String cardCl = connector.getResultData("CardCl");              // üũī�忩�� (0:�Ϲ�, 1:üũī��)
    String cardBin = connector.getResultData("CardBin");            // ī��BIN��ȣ
    String cardPoint = connector.getResultData("CardPoint");        // ī�������Ʈ��뿩�� (0:�̻��, 1:����Ʈ���, 2:���̺�����Ʈ���)
    
    //���ι�����ū��
    String nonRepToken = request.getParameter("NON_REP_TOKEN");
    
    boolean paySuccess = false;                                     // ���� ���� ����
    
    /** ���� ���� ������ �ܿ��� ���� Header�� ������ ������ Get ���� */
    if(payMethod.equals("CARD")){                                   //�ſ�ī��
        if(resultCode.equals("3001")) paySuccess = true;            // ����ڵ� (���� :3001 , �� �� ����)
    }
    
    if(paySuccess){
       // ���� ����
       System.out.println("Seo===========:Success:" + resultCode);
    }else{
       // ���� ����
    	System.out.println("Seo===========:Fail" + resultCode);
    }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="euc-kr" lang="euc-kr">
     <head>
        <title>CNSPay �����Ϸ� ���� ������</title>
    </head>
    <body>
    
        <b>���� �����Դϴ�.</b><br />
        <ul>
            <li>��� ���� : [<%=(resultCode)%>] <%=resultMsg%></li>
            <li>���� ���� : <%=(payMethod) %></li>
            <li>��ǰ�� : <%=goodsName %></li>
            <li>�ݾ� : <%=amt %> ��</li>
            <li>TID : <%=tid %></li>
            <li>MID : <%= mid %></li>
            <li>�������ŷ���ȣ : <%= moid %></li>
            <li>ī���� : <%= cardName %></li>
            <li>�Һΰ��� : <%= cardQuota %></li>
            <li>�����ڿ��� : <%= cardInterest %></li>
            <li>üũī�忩�� : <%= cardCl %></li>
            <li>ī��BIN��ȣ : <%= cardBin %></li>
            <li>ī�������Ʈ��뿩�� : <%= cardPoint %></li>
            <li>�����Ͻ� : <%= authDate %></li>
            <li>���ι�ȣ : <%= authCode %></li>
            <li>���ι�����ū : <textarea rows="5" cols="45" readonly="readonly" style="resize:none;" name="contents"><%=nonRepToken %>&nbsp;</textarea></li>
        </ul>
        
    </body>
</html>
