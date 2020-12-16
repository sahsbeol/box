<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>   
<ui:decorator name="popup"/> 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html lang="ko">
<head>
<title>다운로드</title>
<meta http-equiv='Cache-Control' content='no-cache'>
<meta http-equiv='Progma' content='no-cache'>
<meta http-equiv='Content-Type' content='text/html; charset=EUC-KR'>
<link rel='stylesheet' type='text/css' href='common.css'>
<script src="/scripts/json2.js" type="text/javascript" charset="utf-8"></script>
<script src="/scripts/jquery/jquery-ui-1.8.6.custom.min.js" type="text/javascript"></script>
<script src="/scripts/jquery/jquery.form.js" type="text/javascript" charset="utf-8"></script>

<script language="javaScript">
        var g_nFileIndex    = 1;
        var g_nDRMType;
        
        function initialize()
        {
        	 alert("1");
            //다운로드 받을 폴더 위치
            Downloader.SetDownloadPath(2, '');
            alert("2");
            path.value = Downloader.GetDownloadPath();      
            //다운로드 받는 서버측 스크립트 URL
            alert("3");
            Downloader.SetServerURL("http://drmdown.rsrs.co.kr/madownload.asp", "http://drmlicense.rsrs.co.kr/msdrm/mslicenseIssuer.asp");
            //Downloader.SetFileMove(true);
        }
        
        function SetPath()
        {
            Downloader.SeTDownloadPath(1, "");
            path.value = Downloader.GeTDownloadPath();
        }
        
        function showfolder()
        {
            Downloader.ShowFolder();
        }
        
        function allDown()
        {

            //var sUserKey = document.getElementById('UserKey').value;
            var sUserKey = $('input#UserKey').val();
            var sFileName;
            var sCID;
            var sBitrate;
            //alert("sUserKey="+ sUserKey);
            g_nDRMType =  $('input#drmType').val(); 
            //alert("g_nDRMType="+g_nDRMType);
            sFileName   = $('input#sFileName'+g_nFileIndex).val(); 
            //alert("sFileName="+sFileName);
            sCID        = $('input#sCID'+g_nFileIndex).val(); 
            //alert("sCID="+sCID);
            sBitrate    = $('select[name="bitrate"]').val();  
            //alert("sBitrate="+sBitrate);
            Download(sUserKey, sCID, sFileName, sBitrate);
        }
        
        //다운로드 요청
        function Download(sUserKey, sCID, sFileName, sBitrate)
        {
            var sDomain = "universal";
            //alert("sUserKey : "+sUserKey+"\nsCID : "+sCID+"\nsFileName : "+sFileName+"\nsBitrate : "+sBitrate+"\ng_nDRMType : "+g_nDRMType);
            downtest = Downloader.Download(sDomain, sUserKey, sCID, sFileName, sBitrate, g_nDRMType);
        }
        
        //다운로드 중지
        function DownStop()
        {
            Downloader.DownloadStop();
        }
        
        function progress(ing, end){
            if(ing > 0 && ing <=100) {
                $('img#totalPercentage').css("display","block"); 
                $('span#state'+g_nFileIndex).html(ing + "%"); 
                $('img#totalPercentage').css("width",ing + "%"); 
            }
        }       
</script>
</head>
<body class="bg_title">
<div style="width:380px;margin-left:10;margin-right:10;">
    
<Script language="javaScript" event="OnDownStatus(Result, CID, Message, Param)" for="Downloader">
        if (0 == Result){
        	$('span#state'+g_nFileIndex).html('0%');
        }else if (105 == Result){
        	$('span#state'+g_nFileIndex).html('중지');
        }else{
        	$('span#state'+g_nFileIndex).html(Message);
        }
</Script>
<Script language="javaScript" event="OnEndDownload(Result, CID, DRMType)" for="Downloader">
        var sState;
        //alert("onEndDownload (sState)= " + sState + "/ g_nFileIndex=" + g_nFileIndex +" / Result = "+ Result +"/drmtype = "+ DRMType);
        
        if (105 == Result)
        {
            sState =  "중지";
        }
        else
        {
            switch (Result)
            {
                case 0: //다운로드 성공
                	if ($('span#state'+g_nFileIndex).html() == "100%")//if (document.getElementById('state'+g_nFileIndex).innerHTML == "100%")
                	{
                        sState = "완료";
                    }
                	
                    // 앨범 아트 추가
                    var saveFilePath = Downloader.GeTDownloadPath() + "\\" + $('input#sFileName'+g_nFileIndex).val(); 
                    //alert("saveFilePath = " + saveFilePath);
                    var sTrack_id = $('input#sCID'+g_nFileIndex).val(); 
                    //alert("sTrack_id = " + sTrack_id);
                    
                    Downloader.SetAlbumArtInfo("http://www.bugs.co.kr", saveFilePath, sTrack_id);
                    
                    break ;
                case 1:
                    sState = "파라메터 오류";
                    break ;
                case 2: 
                    sState = "도메인 정보 오류";
                    break ;
                case 3:
                    sState = "CID 오류";
                    break ;
                case 4:
                    sState = "DB 오류";
                    break ;
                case 5:
                    sState = "파일 오류";
                    break ;
                case 6:
                    sState = "패키징 실패";
                    break ;
                case 7:
                    sState = "파일 오류";
                    break ;
                case 100:
                    sState = "통신 끊김";
                    break ;
                case 101:
                    sState = "파일 I/O 오류";
                    break ;
                case 102:
                    sState = "공간 부족";
                    break ;
                case 103:
                    sState = "파라메터 오류";
                    break ;
                case 104:
                    sState = "알 수 없는 오류";
                    break ;
                case 106:
                    sState = "라이센스 발급 오류";
                    break ;
            }
            
            $('span#state'+g_nFileIndex).html(sState); 
            
            if(g_nFileIndex < 1)
            {
                g_nFileIndex++;
                allDown();
            } else {
                g_nFileIndex = 1;
            }
        }
</Script>   

<!--다운로드 파일 용량 -->
<Script language="javaScript" event="OnBeginDownload(CID, FileSize, DRMType)" for="Downloader">
    progress(FileSize, 1);
</Script>

<!--다운로드 퍼센트 -->
<Script language="javaScript" event="OnDownloading(CID, CurrentSize, Percent, Param)" for="Downloader">
    progress(Percent, 100);
</Script>
<script>
var MadownObj = "";
MadownObj = MadownObj + "<OBJECT ";
MadownObj = MadownObj + "ID=\"Downloader\" ";
MadownObj = MadownObj + "CLASSID=\"CLSID:6FD1645E-19A2-4F4D-A721-535D2CD3F64A\" ";
MadownObj = MadownObj + "codebase=\"http://dev.front.hottracks.co.kr:80/cab/MAMEinsDownload.cab#version=1,2,2009,119\" ";
MadownObj = MadownObj + "width=\"0\" height=\"0\"></Object>";
document.writeln(MadownObj);
</script> 
    <!-- Title str -->
    <div style="height:45px;">
        <div class="fr" style="padding-top:18px;"><a href="#" onclick="window.close();"><img src="http://file.rsrs.co.kr/gmarket/images/popup/btn_close.gif" alt="Close"></a></div>
    </div>
    <!-- Title end -->
    
    <!-- Contents str -->
    <input type="hidden" id="drmType" name="drmType" value="0">
    <!-- 
        ASP 업체에서 사용하는 회원번호를 입력해주시면 됩니다. 
                    해당 회원번호를 가지고 서버통신으로 구매여부를 체크합니다. 
    -->
    <input type="hidden" id="UserKey" name='UserKey' value='609713198'>
    <div style="padding:20px 0;">
        <OBJECT ID="Downloader" CLASSID="CLSID:6FD1645E-19A2-4F4D-A721-535D2CD3F64A" codebase="http://dev.front.hottracks.co.kr:80/cab/MAMEinsDownload.cab#version=1,2,2009,119" width="0" height="0"></Object>

        <table cellpadding="0" cellspacing="0" border="0" width="100%">
	        <!-- 다운로드목록 str -->
	        <tr>
	            <td class="bu_popup">다운로드목록</td>
	        </tr>
	        <tr>
	            <td class="pat6">
	                <table cellpadding="0" cellspacing="0" border="0" class="bbsList">
		                <colgroup>
		                    <col width="28px" />
		                    <col width="150" />
		                    <col width="110px" />
		                    <col width="70px" />
		                    <col width="80px" />
		                </colgroup>
		                <tr class="pat3">
		                    <th class="none">순서</th>
		                    <th>트랙명</th>
		                    <th>아티스트</th>
		                    <th>유효기간</th>
		                    <th>진행상황</th>
		                </tr>
		                <tr>
		                    <td class="none num">
		                        1
			                    <!-- 곡아이디를 입력해주시면 됩니다.  -->
			                    <input type='hidden' id="sCID1" name='sCID1' value='1621583'>
			                    <!-- 
			                                                                곡 제목으로 다운로드 받을 파일명을 만들어 주시면됩니다. 확장자 필수 입니다.
			                                                                단, 특수문자는 모두 제외하시고 만들어주세요.
			                    -->
			                    <input type='hidden' id="sFileName1" name='sFileName1' value="붉은 노을.mp3">
		                    </td>
		                    <td class="left">붉은 노을</td>
		                    <td>빅뱅(Bigbang)</td>
		                    <td class="num">2010.10.10</td>
		                    <td><span id='state1'>준비</span></td>
		                </tr>
	                </table>
	            </td>
	        </tr>
	        <!-- 다운로드목록 end -->
	        <tr>
	            <td style="height:17px;"></td>
	        </tr>
	        <!-- 옵션 str -->
	        <tr>
	            <td class="bu_popup">옵션</td>
	        </tr>
	        <tr>
	            <td class="pat6">
	                <table cellpadding="0" cellspacing="0" border="0" class="bbsList">
	                <colgroup><col width="60px" /><col width="*" /></colgroup>
	                <tr>
	                    <th class="none">다운로드위치</th>
	                    <td class="left">
	                        <input type="text" id="path" name="path" style="width:198px;" class="input_popup" />
	                        <a href="javascript:SetPath();"><img src="http://file.rsrs.co.kr/gmarket/images/popup/btn_folderSelect.gif" alt="폴더선택" align="absmiddle"></a>
	                        <a href="javascript:showfolder();"><img src="http://file.rsrs.co.kr/gmarket/images/popup/btn_folderOpen.gif" alt="폴더열기" align="absmiddle"></a>
	                    </td>
	                </tr>
	                <tr>
	                    <th class="none ls0">Bit Rate</th>
	                    <td class="left">
	                        <!-- 
	                                                                            곡의 다운로드 권리에 따라 노출이 틀려진다. 
	                            - 128 kbps      : svc_128_yn
	                            - 192 kbps      : svc_192_yn
	                            - 320 kbps      : svc_320_yn
	                         -->
	                        <select id="bitrate" name="bitrate" style="width:74px;" class="select_popup">
	                            <option value='128k'>128 kbps</option> 
	                            <option value='192k' selected>192 kbps</option>
	                            <option value='320k'>320 kbps</option>
	                        </select>
	                    </td>
	                </tr>
	                </table>
	            </td>
	        </tr>
	        <!-- 옵션 end -->
	        <tr>
	            <td style="height:17px;"></td>
	        </tr>
	        <!-- 전체진행상황 str -->
	        <tr>
	            <td class="bu_popup">전체진행상황</td>
	        </tr>       
	        <tr>
	            <td class="pat6">
	                <table cellpadding="0" cellspacing="0" border="0" width="100%" style="background:#f3f3f3; padding:10px;">
	                <tr>
	                    <td height="30px"><img id="totalPercentage" src="http://file.rsrs.co.kr/gmarket/images/popup/percent.gif" width="0%" height="10px" style="display:none"> </td>
	                </tr>
	                </table>
	            </td>
	        </tr>
	        <!-- 전체진행상황 end -->
	        <!-- Btn str -->
	        <tr>
	            <td style="padding-top:20px;" align="center">
	                <a href="#" onClick='allDown()'><img src="http://file.rsrs.co.kr/gmarket/images/popup/btn_down.gif" alt="다운받기" align="absmiddle"></a>
	                <a href="#" onClick='DownStop()'><img src="http://file.rsrs.co.kr/gmarket/images/popup/btn_stop.gif" alt="중지" align="absmiddle"></a>
	                <a href="#" onclick="window.close();"><img src="http://file.rsrs.co.kr/gmarket/images/popup/btn_winClose.gif" alt="창닫기" align="absmiddle"></a>
	            </td>
	        </tr>
	        <!-- Btn end -->
        </table>
    <!-- Contents end -->
    </div>
</div>
<script> 
    initialize();
</script>
</body></html>

