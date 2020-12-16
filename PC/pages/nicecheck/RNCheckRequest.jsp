<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ include file="nice.nuguya.oivs2.jsp" %>

<%
    //#######################################################################################
    //#####
    //##### 개인/외국인 실명확인 서비스 소스 (실명확인요청)             한국신용정보(주)
    //##### ( Java )
    //#####
    //##### ================================================================================
    //#####
    //##### * 본 페이지는 귀사의 서버에 복사해서 관리하십시오.
    //#####   회원사에서 설정할 부분을 제외하고는 수정하거나 변경하지 마십시오.
    //#####   (서비스 장애의 원인이 됩니다)
    //#####
    //#######################################################################################


    //=======================================================================================
    //===== MAIN PROCESS
    //=======================================================================================

    /****************************************************************************************
     *****  ▣ 회원사 ID 설정 : 계약시에 발급된 회원사 ID를 설정하십시오. ▣
     ****************************************************************************************/

    String strNiceId = "Ntracks04";

    /****************************************************************************************
     *****  ▣  NiceCheck.htm 에서 넘겨 받은 SendInfo 값을 복호화 하여 
     *****      주민번호,성명 등 각각의 값을 세팅한다 ▣
     ****************************************************************************************/

    OivsObject oivsObject = new OivsObject();
    oivsObject.clientData = request.getParameter( "SendInfo" );
    oivsObject.desClientData();

    // 복호화 된 값은 아래 주석을 풀어 확인 가능합니다. 
    // (기존 회원 체크는 이 부분에서 하시면 됩니다.)
    /*
    out.println("<BR>성명 : "  + oivsObject.userNm);
    out.println("<BR>주민번호/외국인번호 : "  + oivsObject.resIdNo);
    out.println("<BR>조회사유코드 : "  + oivsObject.inqRsn);
    out.println("<BR>내/외국인 구분코드 : "  + oivsObject.foreigner);
    */

    /****************************************************************************************
     *****  ▣ 실명확인 서비스를 호출한다. ▣
     ****************************************************************************************/
    
    oivsObject.niceId = strNiceId;
    oivsObject.callService();


    /****************************************************************************************
     *****  ▣ 실명확인 서비스를 응답값을 처리한다. ▣

     *****  strRetCd 와 strRetDtlCd를 이용하여 작업 하시면 됩니다.
     *****  단! strRetDtlCd 가 Y,C인 경우는 개인의 설정에 의해 실명확인을 막아 놓은 상태이므로 
     *****  관련스크립트는 수정하지 마시기 바랍니다.
     ****************************************************************************************/

    //==================================================================================================================
    //              응답에 대한 결과 및 변수들에 대한 설명
    //------------------------------------------------------------------------------------------------------------------
    //
    //  < 한국신용정보 온라인 식별 서비스에서 제공하는 정보 >
    //
    //  oivsObject.message          : 오류 또는 정보성 메시지
    //  oivsObject.retCd            : 결과 코드(메뉴얼 참고) // cf. 한국신용정보 성명 등록 및 정정 페이지 : https://www.nuguya.com
    //  oivsObject.retDtlCd         : 결과 상세 코드(메뉴얼 참고)
    //  oivsObject.minor            : 성인인증 결과 코드
    //                                  "1" : 성인
    //                                  "2" : 미성년
    //                                  "9" : 확인 불가
    //
    //=================================================================================================================
%>

<html>
    <head>
        <title>한국신용정보주식회사 개인/외국인 실명확인 서비스 샘플 페이지</Title>
        <!--    ==========================================================  -->
        <!--    한국신용정보주식회사 처리 모듈 (수정 및 변경하지 마십시오)   -->
        <!--    ==========================================================  -->

        <script type="text/javascript" src="http://secure.nuguya.com/nuguya/nice.nuguya.oivs.crypto.js"></script>
        <script type="text/javascript" src="http://secure.nuguya.com/nuguya/nice.nuguya.oivs.msgg.utf8.js"></script>
        <script type="text/javascript" src="http://secure.nuguya.com/nuguya/nice.nuguya.oivs.util.js"></script>
    </head>

    <script type="text/javascript">

        function loadAction()
        {
            var strRetCd = "<%= oivsObject.retCd %>";
            var strRetDtlCd = "<%=oivsObject.retDtlCd %>";
            var strMsg = "<%= oivsObject.message %>";

            //  한국신용정보로 부터 결과코드에 해당하는 메시지를 받아온다.
            //  (다른 메시지를 띄우려면 메뉴얼 파일을 참고하여  strRetCd, strRetDtlCd 별 메시지를 지정해 준다.
            
            strProcessMessage = getMessage( strRetCd, strRetDtlCd ); 

            if ( strRetCd == "1" ) // 실명인증성공
            {
                alert( strProcessMessage ); //결과 메시지 출력
                top.document.location.href="/ht/help/createCounselForm";
                self.close();
            }
            else // 실명인증실패
            {

                //  결과에 따라서 실명안심차단과 명의도용 차단을 처리한다.
                if ( strRetDtlCd == "Y" )
                {
                    //  처리 결과가 실명안심차단 상태인지를 확인한다.
                    var retVal = confirm( strProcessMessage + "\n\n" + getCheckMessage( "S31" ) );
                    if ( retVal == true )
                    {
                        history.go( -1 );
                        goSafeBlockExpt();
                        return;
                    }
                    else
                    {
                        history.go( -1 );
                        return;
                    }
                }
                else if ( strRetDtlCd == "C" )
                {
                    //  처리 결과가 실명명의도용차단 상태인지를 확인한다.
                    alert( getMessage( strRetCd, strRetDtlCd ) + "\n\n" + getCheckMessage( "S32" ) );
//                    document.getElementById( "Message" ).value = getMessage( strRetCd, strRetDtlCd );
                }
                else
                {
                    if ( strMsg != "" )
                    {
                        alert( strMsg );
//                        document.getElementById( "Message" ).value = "<%= oivsObject.message %>";
                        history.go( -1 );
                        return;
                    }
                    else
                    {

                        alert( strProcessMessage );
//                        document.getElementById( "Message" ).value = strProcessMessage;
                    }

                }
                self.close();
            }
        }

    </script>

    <body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="javascript:loadAction();" >
<!--     
<BR><BR>
        <table align="center" width="740" border="0" cellSpacing="1" cellpadding="8" bgcolor="#afafaf">
            <tr bordercolor="#000000">
                <td height="31" colspan="2" bgcolor="#f4f4f4">
                    <b>한국신용정보(주) 개인/외국인 실명확인 서비스 샘플 페이지 (서비스 검증 결과) </b>
                </td>
            </tr>
            <tr>
                <td align="right" bgcolor="#CCCCCC" width="240">결과메시지</td>
                <td bgcolor="#FFFFFF" width="500">
                    <input type="text" id="Message" name="Message" style="width:100%" value="<%= oivsObject.message %>">
                </td>
            </tr>
            <tr>
                <td align="right" bgcolor="#CCCCCC">결과코드</td>
                <td bgcolor="#FFFFFF">
                    <input type="text" id="RetCd" name="RetCd" size="30" value="<%= oivsObject.retCd %>">
                </td>
            </tr>
            <tr>
                <td align="right" bgcolor="#CCCCCC">결과 상세코드</td>
                <td bgcolor="#FFFFFF">
                    <input type="text" id="RetDtlCd" name="RetDtlCd" size="30" value="<%= oivsObject.retDtlCd %>">
                </td>
            </tr>
            <tr>
                <td align="right" bgcolor="#CCCCCC">성인검증결과코드</td>
                <td bgcolor="#FFFFFF">
                    <input type="text" id="Minor" name="Minor" size="30" value="<%= oivsObject.minor %>">
                </td>
            </tr>
            <tr bordercolor="#000000">
                <td height="31" colspan="2" bgcolor="#f4f4f4">
                    <b>사용자 입력 및 회원사 설정 정보</b>
                </td>
            </tr>
            <tr>
                <td align="right" bgcolor="#CCCCCC">실명정보</td>
                <td bgcolor="#FFFFFF">
                    <input type="text" id="UserNm" name="UserNm" size="30" value="<%= oivsObject.userNm %>">
                </td>
            </tr>
            <tr>
                <td align="right" bgcolor="#CCCCCC">주민등록정보/외국인등록번호</td>
                <td bgcolor="#FFFFFF">
                    <input type="text" id="ResIdNo" name="ResIdNo" size="30" value="<%= oivsObject.resIdNo %>">
                </td>
            </tr>
            <tr>
                <td align="right" bgcolor="#CCCCCC">조회사유</td>
                <td bgcolor="#FFFFFF">
                    <input type="text" id="InqRsn" name="InqRsn" size="30" value="<%= oivsObject.inqRsn %>">
                </td>
            </tr>
            <tr>
                <td align="right" bgcolor="#CCCCCC">내/외국인구분</td>
                <td bgcolor="#FFFFFF">
                    <input type="text" id="Foreigner" name="Foreigner" size="30" value="<%= oivsObject.foreigner %>">
                </td>
            </tr>
            <tr>
                <td align="right" bgcolor="#CCCCCC">중복가입확인정보</td>
                <td bgcolor="#FFFFFF">
                    <input type="text" id="DupeInfo" name="DupeInfo" size="30" value="<%= oivsObject.dupeinfo %>">
                </td>
            </tr>
            <tr>
                <td align="right" bgcolor="#CCCCCC">연계정보</td>
                <td bgcolor="#FFFFFF">
                    <input type="text" id="CoInfo" name="CoInfo" size="30" value="<%= oivsObject.coinfo %>">
                </td>
            </tr>
        </table>
 -->
    </body>
</html>