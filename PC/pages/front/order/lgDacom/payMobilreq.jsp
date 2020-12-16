<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="none"/>
<%
/****************************************************************************************
* 파일명 : mc_web.jsp
* 작성자 : PG기술팀
* 작성일 : 2013.10
* 용  도 : 휴대폰 hybrid 방식 결제 인증 연동 페이지
* 버  전 : 0006
* ---------------------------------------------------------------------------------------
* 가맹점의 소스 임의변경에 따른 책임은 모빌리언스에서 책임을 지지 않습니다.
* 요청 파라미터 및 결제 후 가맹점측 Okurl / Notiurl 으로 Return 되는 파라미터와
* 가맹점 서비스처리 방법은 연동 매뉴얼을 반드시 참조하세요.
* 결제실서버 전환시 꼭 모빌리언스 기술지원팀으로 연락바랍니다.
* 
* 암호화 사용시 필수 클래스
* mup.mcash.module.common.McashCipher.class
* mup.mcash.module.common.McashSeed.class
****************************************************************************************/
%>

<%@page import="mup.mcash.module.common.McashCipher.*"%>
<%@page import="java.security.MessageDigest"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>

<%
//unique한 거래번호를 위한 거래일시 (밀리세컨드까지 조회)
SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmssSSSS");
String appr_dtm = dateFormat.format(new Date());
%>

<%
/*****************************************************************************************
- 필수 입력 항목
*****************************************************************************************/
String CASH_GB      = "MC";     //[   2byte 고정] 결제수단구분. "MC" 고정값. 수정불가!
String MC_SVCID     = "140306180001";       //[  12byte 고정] 모빌리언스에서 부여한 서비스ID (12byte 숫자 형식)
String Prdtprice    = "";       //[  10byte 이하] 결제요청금액 (암호화 사용 시 암호화 대상)
String PAY_MODE     = "10";     //[   2byte 고정] 연동시 테스트/실결제 구분 (00: 테스트결제-비과금, 10: 실거래결제-과금)
String Okurl        = "https://www.hottracks.co.kr/pages/front/order/lgDacom/payMobilres.jsp";       //[ 128byte 이하] 결제 완료 후 사용자에게 보여질 가맹점측 완료 페이지. (예: http://www.mcash.co.kr/okurl.jsp)
String Prdtnm       = "";       //[  50byte 이하] 상품명
String Siteurl      = "www.hottracks.co.kr";       //[  20byte 이하] 가맹점도메인 (예: www.mcash.co.kr)

String Tradeid      = MC_SVCID + "_" + appr_dtm;    //[4byte 이상, 40byte 이하] 가맹점거래번호. 결제 요청 시 마다 unique한 값을 세팅해야 함.
                                                    //해당 샘플에는 테스트를 위해 {가맹점 서비스ID + 요청일시} 형식으로 세팅하였음.



/*****************************************************************************************
- 디자인 관련 필수항목
*****************************************************************************************/
String LOGO_YN      = "N";      //[   1byte 고정] 가맹점 로고 사용 여부 (N: 모빌리언스 로고-default, Y: 가맹점 로고 (사전에 모빌리언스에 가맹점 로고 이미지를 등록해야함))
String CALL_TYPE    = "P";      //[   4byte 이하] 결제창 호출 방식 (P: 팝업-default, SELF: 페이지전환, I: 아이프레임)



/*****************************************************************************************
- 선택 입력 항목
*****************************************************************************************/
String MC_AUTHPAY       = "Y";  //[   1byte 고정] 하이브리드 방식 사용시  "Y" 로 설정 (휴대폰 SMS인증 후 일반 소켓모듈 결제 연동시 사용) (N: 미사용-default, Y: 사용)
String MC_AUTOPAY       = "";   //[   1byte 고정] 자동결제를 위한 최초 일반결제 시 "Y" 세팅. 결제 완료 후 휴대폰정보 대체용 USERKEY 발급 및 자동결제용 AutoBillKey 발급 (N: 미사용-default, Y: 사용)
String MC_PARTPAY       = "";   //[   1byte 고정] 부분취소를 위한 일반결제 시 "Y" 세팅. 결제 완료 후 자동결제 USERKEY 발급 (N: 미사용-default, Y: 사용)
String MC_No            = "";   //[  11byte 이하] 사용자 폰번호 (결제창 호출시 세팅할 폰번호)
String MC_FIXNO         = "";   //[   1byte 고정] 사용자 폰번호 수정불가 여부(N: 수정가능-default, Y: 수정불가)
String MC_DEFAULTCOMMID = "";   //[   3byte 고정] 통신사 기본 선택 값. SKT, KTF, LGT 3개의 값 중 원하는 통신사 세팅 시 해당 통신사가 미리 선택되어짐.
String MC_FIXCOMMID     = "";   //[   1byte 고정] 통신사 고정 선택 값. SKT, KTF, LGT 3개의 값 중 원하는 통신사 세팅 시 해당 통신사만 결제창에 보여짐.
String Payeremail       = "";   //[  30byte 이하] 결제자 e-mail
String Userid           = "";   //[  20byte 이하] 가맹점 결제자ID
String Item             = "";   //[   8byte 이하] 아이템코드. 미사용 시 반드시 공백으로 세팅.
String Prdtcd           = "";   //[  40byte 이하] 상품코드. 자동결제인 경우 상품코드별 SMS문구를 별도 세팅할 때 사용하며 사전에 모빌리언스에 등록이 필요함.
String MC_Cpcode        = "";   //[  20byte 이하] 리셀러하위상점key. 리셀러 업체인 경우에만 세팅.
String Notiemail        = "";   //[  30byte 이하] 알림 e-mail: 결제 완료 후 당사와 가맹점간의 Noti 연동이 실패한 경우 알람 메일을 받을 가맹점 담당자 이메일주소
String Notiurl          = "";   //[ 128byte 이하] 결제 완료 후 가맹점 측 결제 처리를 담당하는 페이지. System back단으로 호출이 되며 사용자에게는 보여지지 않는다.
String Closeurl         = "https://www.hottracks.co.kr/pages/front/order/lgDacom/payMobilresFail.jsp";   //[ 128byte 이하] 결제창 취소버튼, 닫기버튼 클릭 시 호출되는 가맹점 측 페이지. iframe 호출 시 필수! (예: http://www.mcash.co.kr/closeurl.jsp)
String Failurl          = "https://www.hottracks.co.kr/pages/front/order/lgDacom/payMobilresFail.jsp";   //[ 128byte 이하] 결제 실패 시 사용자에게 보여질 가맹점 측 실패 페이지. 결제처리에 대한 실패처리 안내를 가맹점에서 제어해야 할 경우만 사용.
                                //                iframe 호출 시 필수! (예: http://www.mcash.co.kr/failurl.jsp)
String MSTR             = "";   //[2000byte 이하] 가맹점 콜백 변수. 가맹점에서 추가적으로 파라미터가 필요한 경우 사용하며 &, % 는 사용불가 (예: MSTR="a=1|b=2|c=3")

/*****************************************************************************************
- 오픈마켓의 경우 아래의 정보를 입력해야 합니다.
장바구니 결제의 경우 대표 판매자 외 n명, 대표 판매자 연락처를 입력하세요.
예)  Sellernm  = "홍길동외 2명";
    Sellertel = "0212345678";
*****************************************************************************************/
String Sellernm         = "";   //[  50byte 이하] 실판매자 이름 (오픈마켓의 경우 실 판매자 정보 필수)
String Sellertel        = "";   //[  15byte 이하] 실판매자 전화번호 (오픈마켓의 경우 실 판매자 정보 필수)



/*****************************************************************************************
- 디자인 관련 선택항목 (향후 변경될 수 있습니다.)
*****************************************************************************************/
String IFRAME_NAME      = "";   //[   1byte 고정] 결제창을 iframe으로 호출 할 경우 iframe 명칭 세팅
String INFOAREA_YN      = "";   //[   1byte 고정] 결제창 안내문 표시여부 (Y: 표시-default,  N: 미표시)
String FOOTER_YN        = "";   //[   1byte 고정] 결제창 하단 안내 표시여부 (Y: 표시-default,  N: 미표시)
String HEIGHT           = "";   //[   4byte 이하] 결제창 높이 (px단위: iframe 등 사용시 결제창 높이 조절, 팝업창 등 호출시 "" 로 세팅)
String PRDT_HIDDEN      = "";   //[   1byte 고정] iframe 사용시 상품명 숨김 여부 (가맹점 디자인 결제창으로 결제 입력 사항만 iframe에서 사용시)
String EMAIL_HIDDEN     = "";   //[   1byte 고정] 결제자 e-mail 입력창 숨김 여부 (N: 표시-default, Y: 미표시)
String CONTRACT_HIDDEN  = "";   //[   1byte 고정] 이용약관 숨김 여부 (Y: 표시-default,  N: 미표시)



/*****************************************************************************************
- 암호화 처리 (암호화 사용 시)
Cryptstring 항목은 금액변조에 대한 확인용으로 반드시 아래와 같이 문자열을 생성하여야 합니다.

주) 암호화 스트링은 가맹점에서 전달하는 거래번호로 부터 추출되어 사용되므로
암호화에 이용한 거래번호가  변조되어 전달될 경우 복호화 실패로 결제 진행 불가
*****************************************************************************************/
String Cryptyn      = "N";  //Y: 암호화 사용, N: 암호화 미사용
String Cryptstring  = "";   //암호화 사용 시 암호화된 스트링

if( Cryptyn.equals("Y") ){
    Cryptstring = Prdtprice + Okurl;    //금액변조확인 (결제요청금액 + Okurl)
    Okurl       = McashCipher.encodeString(Okurl, Tradeid);
    Failurl     = McashCipher.encodeString(Failurl, Tradeid);
    Notiurl     = McashCipher.encodeString(Notiurl, Tradeid);
    Prdtprice   = McashCipher.encodeString(Prdtprice, Tradeid);
    Cryptstring = McashCipher.encodeString(Cryptstring, Tradeid);
}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr"/>
<title>휴대폰 결제 SAMPLE PAGE</title>
<%
/*****************************************************************************************
가맹점에서는 아래 js 파일을 반드시 include 해야 함.
실 결제환경 구성시 모빌리언스 담당자와 상의 요망
*****************************************************************************************/
%>
<script src="https://mcash.mobilians.co.kr/js/ext/ext_inc_comm.js"></script>

<script language="javascript">
function payRequest(){
    //아래와 같이 ext_inc_comm.js에 선언되어 있는 함수를 호출
    MCASH_PAYMENT(document.payForm);
}
</script>
</head>

<body onload="javascript:payRequest();">
<form name="payForm" accept-charset="euc-kr">
<table border="1" width="100%">
<tr>
    <td align="center" colspan="6"><font size="15pt"><b>휴대폰 결제 SAMPLE PAGE</b></font></td>
</tr>
<tr>
    <td colspan="3"><font color="red">&nbsp;빨간색 항목은 필수 값!!!</font></td>
    <td colspan="3"><font color="blue">&nbsp;파란색 항목은 결제창 UI 관련 파라미터</font></td>
</tr>
<tr>
    <td align="center"><font color="red">결제수단 구분</font></td>
    <td align="center"><font color="red">*CASH_GB</font></td>
    <td><input type="hidden" name="CASH_GB" id="CASH_GB" size="30" value="<%=CASH_GB%>"></td>
    <td align="center"><font color="red">성공URL</font></td>
    <td align="center"><font color="red">*Okurl</font></td>
    <td><input type="hidden" name="Okurl" id="Okurl" size="50" value="<%=Okurl%>"></td>
</tr>
<tr>
    <td align="center"><font color="red">서비스아이디</font></td>
    <td align="center"><font color="red">*MC_SVCID</font></td>
    <td><input type="hidden" name="MC_SVCID" id="MC_SVCID" size="30" value="<%=MC_SVCID%>"></td>
    <td align="center"><font color="red">상품명</font></td>
    <td align="center"><font color="red">*Prdtnm</font></td>
    <td><input type="hidden" name="Prdtnm" id="Prdtnm" size="30" value="${mobilians.lgdProductInfo}"></td>
</tr>
<tr>
    <td align="center"><font color="red">결제요청금액</font></td>
    <td align="center"><font color="red">*Prdtprice</font></td>
    <td><input type="hidden" name="Prdtprice" id="Prdtprice" size="30" value="${mobilians.lgdAmount}"></td>
    <td align="center"><font color="red">가맹점도메인</font></td>
    <td align="center"><font color="red">*Siteurl</font></td>
    <td><input type="hidden" name="Siteurl" id="Siteurl" size="30" value="<%=Siteurl%>"></td>
</tr>
<tr>
    <td align="center"><font color="red">거래종류</font></td>
    <td align="center"><font color="red">*PAY_MODE</font></td>
    <td><input type="hidden" name="PAY_MODE" id="PAY_MODE" size="30" value="<%=PAY_MODE%>"></td>
    <td align="center"><font color="red">가맹점거래번호</font></td>
    <td align="center"><font color="red">*Tradeid</font></td>
    <td><input type="hidden" name="Tradeid" id="Tradeid" size="50" value="${mobilians.lgdOid}"></td>
</tr>
<tr>
    <td align="center"><font color="red">가맹점 로고 사용여부</font></td>
    <td align="center"><font color="red">*LOGO_YN</font></td>
    <td><input type="hidden" name="LOGO_YN" id="LOGO_YN" size="30" value="<%=LOGO_YN%>"></td>
    <td align="center"><font color="red">결제창 호출방식</font></td>
    <td align="center"><font color="red">*CALL_TYPE</font></td>
    <td><input type="hidden" name="CALL_TYPE" id="CALL_TYPE" size="30" value="<%=CALL_TYPE%>"></td>
</tr>
<tr>
    <td align="center">결제 인증만 사용(hybrid 사용)</td>
    <td align="center">MC_AUTHPAY</td>
    <td><input type="hidden" name="MC_AUTHPAY" id="MC_AUTHPAY" size="30" value="<%=MC_AUTHPAY%>"></td>
    <td align="center">결과통보 처리 url</td>
    <td align="center">Notiurl</td>
    <td><input type="hidden" name="Notiurl" id="Notiurl" size="50" value="<%=Notiurl%>"></td>
</tr>
<tr>
    <td align="center">자동결제를 위한 일반결제 여부</td>
    <td align="center">MC_AUTOPAY</td>
    <td><input type="hidden" name="MC_AUTOPAY" id="MC_AUTOPAY" size="30" value="<%=MC_AUTOPAY%>"></td>
    <td align="center">취소/닫기 시 이동 url</td>
    <td align="center">Closeurl</td>
    <td><input type="hidden" name="Closeurl" id="Closeurl" size="50" value="<%=Closeurl%>"></td>
</tr>
<tr>
    <td align="center">부분취소 가능 여부</td>
    <td align="center">MC_PARTPAY</td>
    <td><input type="hidden" name="MC_PARTPAY" id="MC_PARTPAY" size="30" value="<%=MC_PARTPAY%>"></td>
    <td align="center">실패 시 이동 url</td>
    <td align="center">Failurl</td>
    <td><input type="hidden" name="Failurl" id="Failurl" size="50" value="<%=Failurl%>"></td>
</tr>
<tr>
    <td align="center">결제 휴대폰번호</td>
    <td align="center">MC_No</td>
    <td><input type="hidden" name="MC_No" id="MC_No" size="30" value="<%=MC_No%>"></td>
    <td align="center">휴대폰번호 수정불가 여부</td>
    <td align="center">MC_FIXNO</td>
    <td><input type="hidden" name="MC_FIXNO" id="MC_FIXNO" size="30" value="<%=MC_FIXNO%>"></td>
</tr>
<tr>
    <td align="center">리셀러 하위 상점 key</td>
    <td align="center">MC_Cpcode</td>
    <td><input type="hidden" name="MC_Cpcode" id="MC_Cpcode" size="30" value="<%=MC_Cpcode%>"></td>
    <td align="center">사용자 ID</td>
    <td align="center">Userid</td>
    <td><input type="hidden" name="Userid" id="Userid" size="30" value="<%=Userid%>"></td>
</tr>
<tr>
    <td align="center">아이템</td>
    <td align="center">Item</td>
    <td><input type="hidden" name="Item" id="Item" size="30" value="<%=Item%>"></td>
    <td align="center">상품코드</td>
    <td align="center">Prdtcd</td>
    <td><input type="hidden" name="Prdtcd" id="Prdtcd" size="30" value="<%=Prdtcd%>"></td>
</tr>
<tr>
    <td align="center">결제자 이메일</td>
    <td align="center">Payeremail</td>
    <td><input type="hidden" name="Payeremail" id="Payeremail" size="30" value="<%=Payeremail%>"></td>
    <td align="center">기본 이통사</td>
    <td align="center">MC_DEFAULTCOMMID</td>
    <td><input type="hidden" name="MC_DEFAULTCOMMID" id="MC_DEFAULTCOMMID" size="30" value="<%=MC_DEFAULTCOMMID%>"></td>
</tr>
<tr>
    <td align="center">이통사 수정불가 여부</td>
    <td align="center">MC_FIXCOMMID</td>
    <td><input type="hidden" name="MC_FIXCOMMID" id="MC_FIXCOMMID" size="30" value="<%=MC_FIXCOMMID%>"></td>
    <td align="center">가맹점 콜백 변수</td>
    <td align="center">MSTR</td>
    <td><input type="hidden" name="MSTR" id="MSTR" size="50" value="<%=MSTR%>"></td>
</tr>
<tr>
    <td align="center">실판매자명</td>
    <td align="center">Sellernm</td>
    <td><input type="hidden" name="Sellernm" id="Sellernm" size="30" value="<%=Sellernm%>"></td>
    <td align="center">실판매자 연락처</td>
    <td align="center">Sellertel</td>
    <td><input type="hidden" name="Sellertel" id="Sellertel" size="30" value="<%=Sellertel%>"></td>
</tr>
<tr>
    <td align="center">Noti 알림E-mail</td>
    <td align="center">Notiemail</td>
    <td><input type="hidden" name="Notiemail" id="Notiemail" size="30" value="<%=Notiemail%>"></td>
    <td align="center"><font color="blue">iframe 명칭</font></td>
    <td align="center"><font color="blue">IFRAME_NAME</font></td>
    <td><input type="hidden" name="IFRAME_NAME" id="IFRAME_NAME" size="30" value="<%=IFRAME_NAME%>"></td>
</tr>
<tr>
    <td align="center"><font color="blue">결제창 안내문 표시 여부</font></td>
    <td align="center"><font color="blue">INFOAREA_YN</font></td>
    <td><input type="hidden" name="INFOAREA_YN" id="INFOAREA_YN" size="30" value="<%=INFOAREA_YN%>"></td>
    <td align="center"><font color="blue">결제창 하단 안내 표시 여부</font></td>
    <td align="center"><font color="blue">FOOTER_YN</font></td>
    <td><input type="hidden" name="FOOTER_YN" id="FOOTER_YN" size="30" value="<%=FOOTER_YN%>"></td>
</tr>
<tr>
    <td align="center"><font color="blue">결제창 높이</font></td>
    <td align="center"><font color="blue">HEIGHT</font></td>
    <td><input type="hidden" name="HEIGHT" id="HEIGHT" size="30" value="<%=HEIGHT%>"></td>
    <td align="center"><font color="blue">상품명 숨김 여부</font></td>
    <td align="center"><font color="blue">PRDT_HIDDEN</font></td>
    <td><input type="hidden" name="PRDT_HIDDEN" id="PRDT_HIDDEN" size="30" value="<%=PRDT_HIDDEN%>"></td>
</tr>
<tr>
    <td align="center"><font color="blue">결제자 이메일 숨김 여부</font></td>
    <td align="center"><font color="blue">EMAIL_HIDDEN</font></td>
    <td><input type="hidden" name="EMAIL_HIDDEN" id="EMAIL_HIDDEN" size="30" value="<%=EMAIL_HIDDEN%>"></td>
    <td align="center"><font color="blue">이용약관 숨김 여부</font></td>
    <td align="center"><font color="blue">CONTRACT_HIDDEN</font></td>
    <td><input type="hidden" name="CONTRACT_HIDDEN" id="CONTRACT_HIDDEN" size="30" value="<%=CONTRACT_HIDDEN%>"></td>
</tr>
<tr>
    <td align="center">암호화 사용 여부</td>
    <td align="center">Cryptyn</td>
    <td><input type="hidden" name="Cryptyn" id="Cryptyn" size="30" value="<%=Cryptyn%>"></td>
    <td align="center">암호화 검증 값</td>
    <td align="center">Cryptstring</td>
    <td><input type="hidden" name="Cryptstring" id="Cryptstring" size="50" value="<%=Cryptstring%>"></td>
</tr>
<tr>
    <td align="center" colspan="6">&nbsp;</td>
</tr>
<tr>
    <td align="center" colspan="6"><input type="button" value="결제하기" onclick="payRequest();"></td>
</tr>
</table>
</form>
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
    <c:if test="${empty orderSheet.applyCouponInfo}">
        <input type="hidden" name="applyCouponInfo" value=""/>
    </c:if>
    <c:forEach items="${orderSheet.applyDlvyCouponInfo}" var="dlvyCoupon">
        <input type="hidden" name="applyDlvyCouponInfo" value="${dlvyCoupon}"/>
    </c:forEach>
    <c:if test="${empty orderSheet.applyDlvyCouponInfo}">
        <input type="hidden" name="applyDlvyCouponInfo" value=""/>
    </c:if>
    <input type="hidden" name="applyOrderCouponInfo" value="${orderSheet.applyOrderCouponInfo}"/>
</form>
</body>
</html>
