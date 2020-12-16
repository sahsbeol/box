<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ include file="nice.nuguya.oivs.jsp" %>
<ui:decorator name="help"/>
<%

	//#######################################################################################
	//#####
	//#####	나이스아이핀(대체인증키) 서비스 샘플 페이지 소스				한국신용정보(주)
	//#####
	//#####	================================================================================
	//#####
	//#####	* 본 페이지는 귀사의 화면에 맞게 수정하십시오.
	//#####	  단, Head 영역에 설정된 Javascript를 수정하거나 변경하시면 사용할 수 없습니다.
	//#####
	//#######################################################################################


	//========================================================================================
	//=====	▣ 회원사 ID 설정 : 계약시에 발급된 회원사 ID를 설정하십시오. ▣
	//========================================================================================

	String NiceId = "Ntracks03"; //회원사 ID
	String SIKey = "K00010740051"; // 사이트식별 번호 12자리

	//========================================================================================
	//=====	▣ 반환 결과를 수신할 URL을 설정하십시오. (단, 페이지는 그대로 사용하십시오)
	//=====	   한신정 서비스에 전달되어 사용되므로 반드시 절대 URL 경로를 설정하셔야 합니다.
	//========================================================================================

	//EX) http://귀사의도메인/NiceCheckPopup.jsp
	String ReturnURL = "http://www.hottracks.co.kr:8081/ht/nicecheck/niceCheckPopup" ;
	String strOrderNo = "" ; //주문번호.. 매 요청마다 중복되지 않도록 유의
	
	//주문번호 생성예시
	Date d = new Date();
	strOrderNo =  (d.getYear()+1900) + ""
		+ ((d.getMonth() + 1) <10 ? "0" : "") + (d.getMonth() + 1) + ""
		+ (d.getDate() <10 ? "0" : "") + d.getDate() + ""
		+ Math.round(Math.random()*1000000000) + "";

	// 해킹방지를 위해 요청정보 세션에 저장
	session.setAttribute("niceOrderNo" , strOrderNo);

	OivsObject oivsObject = new OivsObject();

%>

<head>
	<title>고객센터</title>

	<!--	==========================================================	-->
	<!--	한국신용정보주식회사 처리 모듈 (수정 및 변경하지 마십시오)	-->
	<!--	==========================================================	-->
	<script type="text/javascript" src="http://secure.nuguya.com/nuguya/nice.nuguya.oivs.crypto.js"></script>
	<script type="text/javascript" src="http://secure.nuguya.com/nuguya/nice.nuguya.oivs.msgg.utf8.js"></script>
	<script type="text/javascript" src="http://secure.nuguya.com/nuguya/nice.nuguya.oivs.util.js"></script>

	<LINK href="./nice.nuguya.oivs.css" type=text/css rel=stylesheet>
    <script language="javascript">
        jQuery(function($) {
            loadAction();
        });
        document.onkeydown = onKeyDown;

        function onKeyDown( event )
        {
            var e = event;
            if ( event == null ) e = window.event;

            if ( e.keyCode == 13 ) goIDCheck();
        }

        function loadAction()
        {
            if ( document.all.PingInfo.value == "" )
            {
                alert( "한국신용정보(주)의 개인인증키 서비스가 점검중입니다.\n잠시후 다시 시도하시기 바랍니다.\n\n상태가 계속되면 사이트관리자에게 문의하십시오" );
                return;
            }
        }

        function validate()
        {
            var NiceId      = document.getElementById( "NiceId" );
            var PingInfo    = document.getElementById( "PingInfo" );
            var ReturnURL   = document.getElementById( "ReturnURL" );

            if ( NiceId.value == "" )
            {
                alert( getCheckMessage( "S60" ) );
                NiceId.focus();
                return false;
            }

            if ( PingInfo.value == "" )
            {
                alert( getCheckMessage( "S61" ) );
                return false;
            }

            if ( ReturnURL.value == "" )
            {
                alert( getCheckMessage( "S64" ) );
                ReturnURL.focus();
                return false;
            }

            return true;
        }

        function goIDCheck()
        {
            if ( validate() == true )
            {
                var strNiceId   = document.getElementById( "NiceId" ).value;
                var strPingInfo = document.getElementById( "PingInfo" ).value;
                var strOrderNo  = document.getElementById( "OrderNo" ).value;
                var strInqRsn   = document.getElementById( "InqRsn" ).value;
                var strReturnUrl    = document.getElementById( "ReturnURL" ).value;
                var strSIKey    = document.getElementById( "SIKey" ).value;

                document.reqForm.SendInfo.value = makeCertKeyInfoPA( strNiceId, strPingInfo, strOrderNo, strInqRsn, strReturnUrl, strSIKey );
//              document.reqForm.SendInfo.value = makeCertKeyInfo( strNiceId, strPingInfo, strOrderNo, strInqRsn, strReturnUrl );
                document.reqForm.ProcessType.value = strPersonalCertKey;

                var popupWindow = window.open( "", "popupCertKey", "top=100, left=200, status=0, width=417, height=490" );
                document.reqForm.target = "popupCertKey";
                document.reqForm.action = strCertKeyServiceUrl;
                document.reqForm.submit();
                popupWindow.focus();
            }

            return;
        }

    </script>
</head>

<body>

    <!-- customer -->
    <div id="customer">
     
        <div class="contents"> 
        
            <p class="mypagetit13 ir">SOS상담</p>
            <div class="sub_stitle">
                <p>교보핫트랙스는,<br />
                원활한 상담과 타인의 주민번호도용 및 허위정보로 인한 피해를 방지하기 위해 실명인증을 시행하고 있습니다.<br />
                입력하신 정보는 고객님의 동의 없이 공개되지 않으며, 개인정보보호정책에 의해 보고 받고 있습니다.</p>
            </div>
            
            <div class="order_infor h40_bottom"> 
                <div class="order_infor_title2">
                    <div><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/customer/sos_title01.gif" alt="개인정보 취급방침" /></div>  
                </div>  
                <div class="txt_infor"> 
                    <div>
<!-- 여기부터 추가 -->                
<div class="infor_box">             
<p class="one" id="infor01">제1조(목적)</p> 
이 약관은 교보핫트랙스㈜(이하 "회사"라 한다)가 운영하는 오프라인 영업점 및 사이버몰 등의 서비스(이하 "서비스"라 한다)를 이용함에 있어 "회사"와 이용자의 권리, 의무 및 책임사항을 규정함을 목적으로 합니다.<br />
※「PC통신, 무선 등을 이용하는 전자상거래에 대해서도 그 성질에 반하지 않는 한 이 약관을 준용합니다」<br />
    

<p class="top" id="infor02">제2조(정의)</p>
1.  "회사"가 재화 또는 용역을 이용자에게 제공하기 위하여 운영하는 오프라인 영업장 및 컴퓨터 등 정보통신설비(인터넷, 전화 등)를 이용하여 재화 또는 용역을 거래할 수 있도록 설정한 가상의 영업장을 말하며 아울러 오프라인 영업장과 사이버몰을 운영하는 사업자의 의미로도 사용합니다.<br />
2.  "이용자"란 영업장에 방문하거나 "사이트"에 접속하여 이 약관에 따라 "회사"가 제공하는 정보 및 기타 서비스를 제공받는 회원 및 비회원을 말합니다.<br />
3.  "회원"이라 함은 "회사"에 개인정보를 제공하여 회원등록을 하고 회원 ID를 부여 받은 자 또는 그 회원전체를 의미하며, "회사"의 정보 및 서비스를 지속적으로 제공 받고, "회사"가 제공하는 서비스를 계속적으로 이용할 수 있는 자를 말합니다.<br />
4.  4. "비회원"이라 함은 회원에 가입하지 않고 "회사"가 제공하는 서비스를 이용하는 자를 말합니다.<br />
5.  아이디(ID)라 함은 "회원"의 식별과 "서비스"이용을 위하여 "회원"이 정하고 "회사"가 승인하는 문자와 숫자의 조합을 의미합니다.<br />
6.  "비밀번호"라 함은 "회원"이 부여 받은 "아이디"와 일치되는 "회원"임을 확인하고 비밀보호를 위해 "회원" 자신이 정한 문자 또는 숫자의 조합을 의미합니다.<br />
7.  "유료서비스"라 함은 "회사"가 유료로 제공하는 각종 온라인 디지털콘텐츠(각종 정보콘텐츠, VOD, 기타 유료콘텐츠 포함) 및 제반 서비스를 의미합니다.<br /> 
8.  "게시물"이라 함은 "회원"이 "서비스"를 이용함에 있어 "서비스상"에 게시한 부호.문자.음성.음향.화상.동영상 등 정보 형태의 글, 사진, 동영상 및 각종 파일과 링크 등을 의미합니다.<br />


<p class="top" id="infor03">제3조 (약관등의 명시와 설명 및 개정)</p>
1.  "회사"는 이 약관의 내용과 상호 및 대표자 성명, 영업소 소재지 주소(소비자의 불만을 처리할 수 있는 곳의 주소를 포함), 전화번호․모사전송번호․전자우편주소, 사업자등록번호, 통신판매업신고번호, 개인정보보호책임자등을 이용자가 쉽게 알 수 있도록 "회사"의 초기 서비스화면(전면)에 게시합니다. 다만, 약관의 내용은 이용자가 연결화면을 통하여 볼 수 있도록 할 수 있습니다.<br />
2.  "회사"는 이용자가 약관에 동의하기에 앞서 약관에 정하여져 있는 내용 중 청약철회․배송책임․환불조건 등과 같은 중요한 내용을 이용자가 이해할 수 있도록 별도의 연결화면 또는 팝업화면 등을 제공하여 이용자의 확인을 구하여야 합니다.<br />
※ 청약철회, 배송, 환불에 대한 안내 바로가기<br />
3.   "회사"는 전자상거래등에서의소비자보호에관한법률, 약관의규제에관한법률, 전자거래기본법, 전자서명법, 정보통신망이용촉진등에관한법률, 방문판매등에관한법률, 소비자보호법 등 관련법을 위배하지 않는 범위에서 이 약관을 개정할 수 있습니다.<br />
4.  "회사"는 약관을 개정할 경우에는 적용일자 및 개정사유를 명시하여 현행약관과 함께 몰의 초기화면에 그 적용일자 7일이전부터 적용일자 전일까지 공지합니다. 다만, 이용자에게 불리하게 약관내용을 변경하는 경우에는 최소한 30일 이상의 사전 유예기간을 두고 공지합니다. 이 경우 "회사"는 개정전 내용과 개정후 내용을 명확하게 비교하여 이용자가 알기 쉽도록 표시합니다.<br />
5.  "회사"가 약관을 개정할 경우에는 그 개정약관은 그 적용일자 이후에 체결되는 계약에만 적용되고 그 이전에 이미 체결된 계약에 대해서는 개정전의 약관조항이 그대로 적용됩니다. 다만 이미 계약을 체결한 이용자가 개정약관 조항의 적용을 받기를 원하는 뜻을 제3항에 의한 개정약관의 공지기간내에 "회사"에 송신하여 "회사"의 동의를 받은 경우에는 개정약관 조항이 적용됩니다.<br />
6.  "회사"가 개정약관을 공지 또는 통지하면서 회원에게 30일 기간 내에 의사표시를 하지 않으면 의사표시가 표명된 것으로 본다는 뜻을 명확하게 공지 또는 고지하였음에도 회원이 명시적으로 거부의 의사표시를 하지 아니한 경우 회원이 개정약관에 동의한 것으로 봅니다. <br />
7.  회원이 개정약관의 적용에 동의하지 않는 경우 "회사"는 개정 약관의 내용을 적용할 수 없으며, 이 경우 회원은 이용계약을 해지할 수 있습니다. 다만, 기존 약관을 적용할 수 없는 특별한 사정이 있는 경우에는 "회사"는 이용계약을 해지할 수 있습니다.<br /> 
8.  이 약관에서 정하지 아니한 사항과 이 약관의 해석에 관하여는 전자상거래등에서의소비자보호에관한법률, 약관의규제등에관한법률, 공정거래위원회가 정하는 전자상거래등에서의소비자보호지침 및 관계법령 또는 상관례에 따릅니다.<br />
 
</div>
<!-- //여기까지 추가 -->  
                    </div> 
                </div>
                <label for="memAgre1" class="f11">개인정보수집 항목 및 내용에 동의합니다.</label> <input type="checkbox" class="radios" value="" id="memAgre1" name="memAgre1">
            </div>
        </div>
    </div>
    <!-- //customer -->

	<FORM id="reqForm" name="reqForm" method="POST" action="">
		<input class="small" type="hidden" id="SendInfo" name="SendInfo" >
		<input class="small" type="hidden" id="ProcessType" name="ProcessType" >
	</FORM>
	<FORM id="pageForm" name="pageForm" method="POST" action="">
  		<INPUT type="hidden" id="NiceId" name="NiceId" value="<%= NiceId %>">
  		<INPUT type="hidden" id="SIKey" name="SIKey" value="<%= SIKey %>">
		<INPUT type="hidden" id="PingInfo" name="PingInfo" value="<%= oivsObject.pingInfo %>">
  		<INPUT type="hidden" id="ReturnURL" name="ReturnURL" value="<%= ReturnURL %>" >
		<!--	조회사유를 설정하십시오 ( '10'-회원가입, '20'-기존회원 확인, '30'-성인인증, '40'-비회원 확인, '50'-기타 사유 )	-->
		<input type="hidden" id="InqRsn" name="InqRsn" value="10">
		<!--	주문번호를 설정하십시오. (최소 14자리, 20자리미만)	-->
		<input type="hidden" id="OrderNo" name="OrderNo" value="<%=strOrderNo%>">

		<INPUT name="Confirm" type="button" id="Confirm" value="나이스 아이핀 인증" style="width:150px;" onclick="javascript:goIDCheck();">
	</form>
</body>


