<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" import="Kisinfo.Check.IPIN2Client" %>
<html>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	/********************************************************************************************************************************************
		NICE평가정보 Copyright(c) KOREA INFOMATION SERVICE INC. ALL RIGHTS RESERVED
		
		서비스명 : IPIN 가상주민번호 서비스 
		페이지명 : IPIN 가상주민번호 서비스 호출 페이지
	*********************************************************************************************************************************************/
	
	String sSiteCode	= "FJ28";			//  NICE평가정보에서 발급한 IPIN 서비스 사이트코드
	String sSitePw		= "75320195";		//  NICE평가정보에서 발급한 IPIN 서비스 사이트패스워드
	
	
	/*
	┌ sReturnURL 변수에 대한 설명  ─────────────────────────────────────────────────────
		암호화된 인증결과 데이터를 리턴받을 URL을 프로토콜부터 풀주소로 정의해주세요.
		
		* URL은 반드시 프로토콜부터 입력해야 하며 외부에서 접속이 가능한 주소여야 합니다.
		* 당사 샘플페이지 중 ipin_process 페이지가 인증결과 데이터를 리턴받는 페이지입니다.
		
		예 - http://www.test.co.kr/ipin_process.jsp
			 https://www.test.kr:4343/ipin_process.jsp
	└────────────────────────────────────────────────────────────────────
	*/
	String sReturnURL   = "http://dev.hottracks.co.kr/pages/nicecheck/ipin_process.jsp";
	
	
	/*
	┌ sCPRequest 변수에 대한 설명  ─────────────────────────────────────────────────────
		CP요청번호는 추가적인 보안처리를 위한 변수입니다. 인증 후 인증결과 데이터와 함께 전달됩니다.
		세션에 저장된 값과 비교해 데이터 위변조를 검사하거나, 사용자 특정용으로 이용할 수 있습니다.	
		위변조 검사는 인증에 필수적인 처리는 아니며 보안을 위한 권고 사항입니다.		
		
		+ CP요청번호 설정 방법
			1. 당사에서 배포된 모듈로 생성
			2. 귀사에서 임의로 정의(최대 30byte) 
	└────────────────────────────────────────────────────────────────────
	*/
	String sCPRequest = "";	
	
	
	// 모듈객체 생성
	IPIN2Client pClient = new IPIN2Client();	
	
	// CP요청번호 생성
	sCPRequest = pClient.getRequestNO(sSiteCode);
	
	// CP요청번호 세션에 저장 
	// : 저장된 값은 ipin_result 페이지에서 데이터 위변조 검사에 이용됩니다.
	session.setAttribute("CPREQUEST" , sCPRequest);
	
	
	// 인증요청 암호화 데이터 생성
	int iRtn = pClient.fnRequest(sSiteCode, sSitePw, sCPRequest, sReturnURL);
	
	String sEncData		= "";	// 인증요청 암호화 데이터
	String sRtnMsg		= "";	// 처리결과 메세지
	
	// 암호화 처리결과코드에 따른 처리
	if (iRtn == 0)
	{
        // 인증요청 암호화 데이터 추출
		sEncData = pClient.getCipherData();		
		sRtnMsg = "정상 처리되었습니다.";
	}
	else if (iRtn == -1)
	{
		sRtnMsg = "암호화 시스템 오류 : 귀사 서버 환경에 맞는 모듈을 이용해주십시오.<br>오류가 지속되는 경우 iRtn 값, 서버 환경정보, 사이트코드를 기재해 문의주시기 바랍니다.";
	}
	else if (iRtn == -2)
	{
		sRtnMsg = "암호화 처리 오류 : 최신 모듈을 이용해주십시오. 오류가 지속되는 경우 iRtn 값, 서버 환경정보, 사이트코드를 기재해 문의주시기 바랍니다.";
	}
	else if (iRtn == -9)
	{
		sRtnMsg = "입력 정보 오류 : 암호화 함수에 입력된 파라미터 값을 확인해주십시오.<br>오류가 지속되는 경우, 함수 실행 직전 각 파라미터 값을 로그로 출력해 발송해주시기 바랍니다.";
	}
	else
	{
		sRtnMsg = "기타 오류: iRtn 값과 적용한 샘플소스를 발송해주시기 바랍니다.";
	}

%>
<head>
    <title>고객센터</title>

    <script>
		window.name ="Parent_window";

		function fnPopup(iRtn, sRtnMsg){
			if(iRtn == '0'){
				window.open('', 'popupIPIN2', 'width=450, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
				document.pageForm.target = "popupIPIN2";
				document.pageForm.action = "https://cert.vno.co.kr/ipin.cb";
				document.pageForm.submit();
			}else{
				alert(sRtnMsg);
				return false;
			}
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
    
    <!-- <FORM id="reqForm" name="reqForm" method="POST" action="">
        <input class="small" type="hidden" id="SendInfo" name="SendInfo" >
        <input class="small" type="hidden" id="ProcessType" name="ProcessType" >
    </FORM> -->
    <FORM id="pageForm" name="pageForm" method="POST" action="">
    	<input type="hidden" name="m" value="pubmain">	
		<!-- 인증요청 암호화 데이터 -->
		<input type="hidden" name="enc_data" value="<%= sEncData %>">
        <div class="sos_counsel">
            <div class="f_left">
                <h4 class="tit01">회원 상담</h4>
                <div class="btn">
                    <a href="https://www.hottracks.co.kr/ht/mypage/loginForm" class="btn_type07">회원 상담</a>
                </div>
            </div>
            <div class="f_right">
                <h4 class="tit01">비회원 상담</h4>
                <div class="btn">
                    <a href="javascript://" onclick="javascript:fnPopup('<%= iRtn %>', '<%= sRtnMsg %>');" class="btn_type07">실명 인증</a>
                </div>
                <p class="txt">교보문고/핫트랙스 통합 회원으로 가입하시면<br /> 편리함과 혜택이 늘어납니다!</p>
                <a href="javascript://" onclick="goMemJoin()" class="btn_type01">회원가입 하기</a>
            </div>
        </div>
    </FORM>
    <form name="vnoform" method="post">
		<!-- 인증결과 암호화 데이터 -->
		<input type="hidden" name="enc_data">								
	</form>
</div>
<!-- //sub contents -->
</body>
</html>