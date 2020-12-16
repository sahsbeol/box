<%@page import="kr.co.lgcns.module.lite.CnsPayWebConnector"%>
<%@ page contentType="text/html; charset=euc-kr"%>

<%

    System.out.println("Seo================:kakaopayLiteResult.jsp");

    request.setCharacterEncoding("euc-kr"); 
    
    // 모듈이 설치되어 있는 경로 설정
    CnsPayWebConnector connector = new CnsPayWebConnector();
    
    // 1. 로그 디렉토리 생성 : cnsPayHome/log 로 생성
    connector.setLogHome("D:\\cacaolog"); //가맹점의 로그파일 생성 위치
    connector.setCnsPayHome("D:\\cacaolog"); // cnspay.properties파일 위치
    
    // 2. 요청 페이지 파라메터 셋팅
    connector.setRequestData(request);
    
    // 3. 추가 파라메터 셋팅
    connector.addRequestData("actionType", "PY0");              // actionType : CL0 취소, PY0 승인
    connector.addRequestData("MallIP", request.getRemoteAddr());// 가맹점 고유 ip
    
    //가맹점키 셋팅 (MID 별로 틀림) 
    connector.addRequestData("EncodeKey", "33F49GnCMS1mFYlGXisbUDzVf2ATWCl9k3R++d5hDd3Frmuos/XLx8XhXpe+LDYAbpGKZYSwtlyyLOtS/8aD7A==");
    
    // 4. CNSPAY Lite 서버 접속하여 처리
    connector.requestAction();
    
    // 5. 결과 처리
    String resultCode = connector.getResultData("ResultCode");      // 결과코드 (정상 :3001 , 그 외 에러)
    String resultMsg = connector.getResultData("ResultMsg");        // 결과메시지
    String authDate = connector.getResultData("AuthDate");          // 승인일시 YYMMDDHH24mmss
    String authCode = connector.getResultData("AuthCode");          // 승인번호
    String buyerName = connector.getResultData("BuyerName");        // 구매자명
    String goodsName = connector.getResultData("GoodsName");        // 상품명
    String payMethod = connector.getResultData("PayMethod");        // 결제수단
    String mid = connector.getResultData("MID");                    // 가맹점ID
    String tid = connector.getResultData("TID");                    // 거래ID
    String moid = connector.getResultData("Moid");                  // 주문번호
    String amt = connector.getResultData("Amt");                    // 금액
    String cardCode = connector.getResultData("CardCode");          // 카드사 코드
    String cardName = connector.getResultData("CardName");          // 결제카드사명
    String cardQuota = connector.getResultData("CardQuota");        // 할부개월수 ex) 00:일시불,02:2개월
    String cardInterest = connector.getResultData("CardInterest");  // 무이자 여부 (0:일반, 1:무이자)
    String cardCl = connector.getResultData("CardCl");              // 체크카드여부 (0:일반, 1:체크카드)
    String cardBin = connector.getResultData("CardBin");            // 카드BIN번호
    String cardPoint = connector.getResultData("CardPoint");        // 카드사포인트사용여부 (0:미사용, 1:포인트사용, 2:세이브포인트사용)
    
    //부인방지토큰값
    String nonRepToken = request.getParameter("NON_REP_TOKEN");
    
    boolean paySuccess = false;                                     // 결제 성공 여부
    
    /** 위의 응답 데이터 외에도 전문 Header와 개별부 데이터 Get 가능 */
    if(payMethod.equals("CARD")){                                   //신용카드
        if(resultCode.equals("3001")) paySuccess = true;            // 결과코드 (정상 :3001 , 그 외 에러)
    }
    
    if(paySuccess){
       // 결제 성공
       System.out.println("Seo===========:Success:" + resultCode);
    }else{
       // 결제 실패
    	System.out.println("Seo===========:Fail" + resultCode);
    }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="euc-kr" lang="euc-kr">
     <head>
        <title>CNSPay 결제완료 샘플 페이지</title>
    </head>
    <body>
    
        <b>결제 내역입니다.</b><br />
        <ul>
            <li>결과 내용 : [<%=(resultCode)%>] <%=resultMsg%></li>
            <li>결제 수단 : <%=(payMethod) %></li>
            <li>상품명 : <%=goodsName %></li>
            <li>금액 : <%=amt %> 원</li>
            <li>TID : <%=tid %></li>
            <li>MID : <%= mid %></li>
            <li>가맹점거래번호 : <%= moid %></li>
            <li>카드사명 : <%= cardName %></li>
            <li>할부개월 : <%= cardQuota %></li>
            <li>무이자여부 : <%= cardInterest %></li>
            <li>체크카드여부 : <%= cardCl %></li>
            <li>카드BIN번호 : <%= cardBin %></li>
            <li>카드사포인트사용여부 : <%= cardPoint %></li>
            <li>승인일시 : <%= authDate %></li>
            <li>승인번호 : <%= authCode %></li>
            <li>부인방지토큰 : <textarea rows="5" cols="45" readonly="readonly" style="resize:none;" name="contents"><%=nonRepToken %>&nbsp;</textarea></li>
        </ul>
        
    </body>
</html>
