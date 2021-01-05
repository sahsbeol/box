<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ include file="nice.nuguya.oivs.jsp" %>
<html>
<%

    //#######################################################################################
    //#####
    //##### 나이스아이핀(대체인증키) 서비스 샘플 페이지 소스             한국신용정보(주)
    //#####
    //##### ================================================================================
    //#####
    //##### * 본 페이지는 귀사의 화면에 맞게 수정하십시오.
    //#####   단, Head 영역에 설정된 Javascript를 수정하거나 변경하시면 사용할 수 없습니다.
    //#####
    //#######################################################################################


    //========================================================================================
    //===== ▣ 회원사 ID 설정 : 계약시에 발급된 회원사 ID를 설정하십시오. ▣
    //========================================================================================

    String NiceId = "Ntracks03"; //회원사 ID
    String SIKey = "K00010740051"; // 사이트식별 번호 12자리

    //========================================================================================
    //===== ▣ 반환 결과를 수신할 URL을 설정하십시오. (단, 페이지는 그대로 사용하십시오)
    //=====    한신정 서비스에 전달되어 사용되므로 반드시 절대 URL 경로를 설정하셔야 합니다.
    //========================================================================================

    //EX) http://귀사의도메인/NiceCheckPopup.jsp
    String ReturnURL = "http://m.hottracks.co.kr/m/nicecheck/niceCheckPopup" ;
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

    <!--    ==========================================================  -->
    <!--    한국신용정보주식회사 처리 모듈 (수정 및 변경하지 마십시오)   -->
    <!--    ==========================================================  -->
    <script type="text/javascript" src="http://secure.nuguya.com/nuguya/nice.nuguya.oivs.crypto.js"></script>
    <script type="text/javascript" src="http://secure.nuguya.com/nuguya/nice.nuguya.oivs.msgg.utf8.js"></script>
    <script type="text/javascript" src="http://secure.nuguya.com/nuguya/nice.nuguya.oivs.util.js"></script>
    
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
<!-- sub top -->
<div class="page_location">
    <h2 class="title"><img src="${imageServer}/images/renewal/common/tit_cs_center.gif" alt="CS Center"/></h2>
    <div class="loc"><a href="/" class="home">Home</a><em>SOS상담</em></div>
</div>
<!-- //sub top -->

<c:import url="/menu/help/lnb"/>

<!-- sub contents -->
<div class="sub_contents">
    <h3 class="page_title mgt0"><img src="${imageServer}/images/renewal/common/tit_list_sos_counsel.gif" alt="SOS상담" /></h3>
    <ul class="list_type02">
        <li>핫트랙스는, 원활한 상담과 타인의 주민번호도용 및 허위정보로 인한 피해를 방지하기 위해 실명인증을 시행하고 있습니다.</li>
        <li>교보핫트랙스 회원이신 고객께서는 [회원 상담]을 선택해 주시기 바라며 (로그인 후 바로 이용가능하십니다),<br />비회원으로 상담을 원하시는 고객께서는 <span class="point02">[비회원 상담]</span>을 선택해 주시기 바랍니다.</li>
        <li><span class="point02">[비회원 상담]</span>의 경우 실명확인을 하셔야만 접수가 가능합니다.</li>
        <li>입력하신 정보는 고객님의 동의 없이 공개되지 않으며, 개인정보보호정책에 의해 보호 받고 있습니다.</li>
    </ul>
    
    <FORM id="reqForm" name="reqForm" method="POST" action="">
        <input class="small" type="hidden" id="SendInfo" name="SendInfo" >
        <input class="small" type="hidden" id="ProcessType" name="ProcessType" >
    </FORM>
    <FORM id="pageForm" name="pageForm" method="POST" action="">
        <INPUT type="hidden" id="NiceId" name="NiceId" value="<%= NiceId %>">
        <INPUT type="hidden" id="SIKey" name="SIKey" value="<%= SIKey %>">
        <INPUT type="hidden" id="PingInfo" name="PingInfo" value="<%= oivsObject.pingInfo %>">
        <INPUT type="hidden" id="ReturnURL" name="ReturnURL" value="<%= ReturnURL %>" >
        <!--    조회사유를 설정하십시오 ( '10'-회원가입, '20'-기존회원 확인, '30'-성인인증, '40'-비회원 확인, '50'-기타 사유 )    -->
        <input type="hidden" id="InqRsn" name="InqRsn" value="10">
        <!--    주문번호를 설정하십시오. (최소 14자리, 20자리미만) -->
        <input type="hidden" id="OrderNo" name="OrderNo" value="<%=strOrderNo%>">
        <div class="sos_counsel">
            <div class="f_left">
                <h4 class="tit01">회원 상담</h4>
                <div class="btn">
                    <a href="/m/mypage/loginForm" class="btn_type07">회원 상담</a>
                </div>
            </div>
            <div class="f_right">
                <h4 class="tit01">비회원 상담</h4>
                <div class="btn">
                    <a href="javascript://" onclick="goIDCheck()" class="btn_type07">실명 인증</a>
                </div>
                <p class="txt">교보문고/핫트랙스 통합 회원으로 가입하시면<br /> 편리함과 혜택이 늘어납니다!</p>
                <a href="javascript://" onclick="goMemJoin()" class="btn_type01">회원가입 하기</a>
            </div>
        </div>
    </FORM>
</div>
<!-- //sub contents -->
</body>
</html>