<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %> 
<ui:decorator name="popup"/>
<html>
<head>
<script src="/scripts/json2.js" type="text/javascript" charset="utf-8"></script>
<script src="/scripts/jquery/jquery-ui-1.8.6.custom.min.js" type="text/javascript"></script>
<script src="/scripts/jquery/jquery.form.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript" src="/js/music.js"></script>
<script type="text/javascript" src="/js/musicPlayer.js"></script>
<script type="text/javascript" charset="utf-8">
var mediaLen;
var mediaIdx;
var currentIdx;
var suffleYn;
var loopYn;
var oneLoopYn;
var suffleAry;
var histFlag;
// alert 순서를 위한.
//var testIdx = 0;
var isLogin = ${isLogin};
var listenYn = ${playAuth.listenYn};
$(document).ready(function(){
	if(isLogin && listenYn){
        $("select#full_yn option[value='Y']").attr("selected","true");
    }else{
        $("select#full_yn option[value='N']").attr("selected","true");
        $('span#auth').html("현재 1분듣기만 가능합니다.");
    }
	//alert("isLogin = " + isLogin);
    //alert("listenYn = "+ listenYn);
    init();	
   
});	
function init(){
	musicPlayer.player.setPlayList(${listJSON});
    musicPlayer.player.createPlayList();
   
	// default 값 정의
	suffleYn = 'N';
	loopYn = 'Y';
	oneLoopYn = 'N';
	// suffle 순서생성.
	mediaLen = ($("input[name=trkId]").length)-1;
    suffleAryMake();
	
	currentIdx = 0;
	play(currentIdx);
}
// 10초 앞뒤 1분 앞뒤
function changePosition(direction,sec)
{
    if(direction==0){
        if( Player.controls.currentPosition - sec > 0 ){
            Player.controls.currentPosition=Player.controls.currentPosition - sec;
        }else{
            Player.controls.currentPosition=0;
        }
    }else{
        if( Player.controls.currentPosition + sec > Player.currentMedia.duration){
            Player.controls.stop();
        }else{
            Player.controls.currentPosition= Player.controls.currentPosition + sec ;
        }   
    }
}
// 음원 플레이
function play(p)
{
	
	var intP;
	var id;
	// suffle 재생체크
	if(suffleYn == 'N'){
		intP = parseInt(p);
	}else if(suffleYn == 'Y'){
		// 미리생성해둔 suffle순서 적용.
		intP = parseInt(suffleAry[p]);
		//alert("intP = "+intP);
	}
    if(Player.playstate != 2) {
    	//alert("play의p = "+ p);   	
        id = parseInt($("input[name=trkId]").get(intP).value); 
        switch(id%4) {
            case 1 :
                Player.ServerAdd='fds1bgm.rsrs.co.kr';
                break;
            case 2 :
                Player.ServerAdd='fds2bgm.rsrs.co.kr';
                break;
            case 3 :
                Player.ServerAdd='fds3bgm.rsrs.co.kr';
                break;
            case 0 :
                Player.ServerAdd='fds4bgm.rsrs.co.kr';
                break;
        }
    
        Player.MediaID=id;
    }
    
    Player.controls.play();
    currentIdx = p;
    // 곡명 보여주기
    $('span#mediaText').html('');
    $('span#mediaText').html($("input[name=trkName]").get(intP).value);
    runTimeCheck();
    playTimeDuration();
    histFlag = 'N';
    trackUseHistoty();
}

// 전체/1분 미리듣기 여부 -- 전체 듣기 권리가 없는 사용자이고 1분 이상 들었으면 재생 중지 or 다음곡 재생
function runTimeCheck() {
    if(Player.playstate == 3) {
        if( $("select#full_yn > option:selected").val() == 'N' && Player.controls.currentPosition >= 60){ 
        	Player.controls.stop();
      }
    }
    // 전체곡수 체크
    var newMediaLen = ($("input[name=trkId]").length)-1;
    if(mediaLen != newMediaLen){
    	//전체곡수 틀려지면 suffle 순서 재생성.
    	suffleAryMake();
    }
    mediaLen = newMediaLen;
    setTimeout("runTimeCheck()",500);
}

//음원 플레이시간표시
function playTimeDuration() {
	var durTime = Player.currentMedia.durationString;
	var curTime = Player.controls.currentPositionString;
    $('span#durTm').html(curTime + "/" + durTime);
	setTimeout("playTimeDuration()",500);
}

// 베스트랭킹 history 쌓기 
function trackUseHistoty(){
	var dur = parseInt(Player.currentMedia.duration);
	var cur = parseInt(Player.controls.currentPosition);
    if( dur >= 90){
        if( cur== 90){
        	if(histFlag == 'N'){
        	    trackUseHist(Player.MediaID);
        	}
        }
    }else{
        if((dur - 1) == cur){
        	if(histFlag == 'N'){
        	    trackUseHist(Player.MediaID);
        	}
        }
    }
    setTimeout("trackUseHistoty()",1000);
}

// 음원ready 상태처리.
function playproc(){
    // 음원의 마지막index 미도착.
	if(Player.playstate == 10 && mediaLen > currentIdx){
        //alert("setStateInfoStr 의 currentIdx=" + currentIdx);
        if(oneLoopYn == 'Y'){
        	//현재곡반복재생.
            currentIdx = currentIdx;
        }else{
        	// 다음곡 재생.
            currentIdx = parseInt(currentIdx)+1;
        }
        play(currentIdx);
   // 음원의 마지막 index 도착.
    }else if(Player.playstate == 10 && mediaLen == currentIdx){
        if(loopYn == 'Y' && oneLoopYn == 'N'){
        	//전체반복
            currentIdx = 0;
            play(currentIdx);
        } else if(loopYn = 'N' && oneLoopYn == 'Y'){
        	//현재곡반복
            play(currentIdx);
        } else if(loopYn = 'N' && oneLoopYn == 'N' && suffleYn == 'N'){
        	//반복없고 순차재생.
            Player.controls.stop();
        } else if(loopYn = 'N' && oneLoopYn == 'N' && suffleYn == 'Y'){
        	//suffle 재생은 default 가 전체반복재생.
        	currentIdx = 0;
            play(currentIdx);
        } 
    }
}

//음원 상태 이벤트처리	
function setStateInfoStr(str, bool){
	//alert("str="+str+"/currentIdx="+currentIdx+"/순서=/status="+Player.playstate);
    if(str=='Ready' && bool==false){
    	// 바로재생시 곡뛰어넘는현상으로 딜레이줌.
    	setTimeout("playproc()",1000); 
    }else if(str=='Change'&& bool==true){
    	// 곡바뀔때 전체음원갯수체크
    	mediaLen = ($("input[name=trkId]").length)-1;
    }else if(str =='Playing' && bool==true){
    	
    }else if(str=='Stop' && bool==false){
    	// stop() 함수 사용시 발생 status. 1분듣기시 stop() 함수 사용으로 다음곡1  분듣기 처리.
        if($("select#full_yn > option:selected").val() == 'N'){
        	if(mediaLen > currentIdx){
                currentIdx = parseInt(currentIdx)+1;
                play(currentIdx);
            }
        }
    }
}
// 볼륨..
function setVolumePosition(){
	Player.Settings.Volume = 40;
    $('input[name=volume]').val(Player.settings.volume);
}
//음원 반목모드 - 벅스처럼 하나의 이미지로 처리한다면 동시상태없음.
function loopMode(m) {
	if(m == 0){
		loopYn='N';
		oneLoopYn='N';
	    $('span#allrepeat').html("all="+loopYn);
        $('span#onerepeat').html("one="+oneLoopYn);
	}else if(m == 1){
		loopYn='Y';
		oneLoopYn = 'N';
        $('span#allrepeat').html("all="+loopYn);
        $('span#onerepeat').html("one="+oneLoopYn);
	}else if(m == 2){
		loopYn ='N';
		oneLoopYn = 'Y';
        $('span#allrepeat').html("all="+loopYn);
        $('span#onerepeat').html("one="+oneLoopYn);
	}
}
// 음원 랜덤듣기mode 설정.
function suffleMode(){
	if(suffleYn == 'Y'){
		suffleYn = 'N';
		$('span#suffle').html('');
        $('span#suffle').html("suffle="+suffleYn);
	}else if(suffleYn == 'N'){
		suffleYn ='Y';
		$('span#suffle').html('');
        $('span#suffle').html("suffle="+suffleYn);
 
	}
}
// 음원suffle만들기
function suffleAryMake(){
	var z=0;
	mediaLen = ($("input[name=trkId]").length)-1;
	if(mediaLen >= 0){
		suffleAry = new Array(mediaLen);
		while(z <= mediaLen){
			var f=0;
			var randNo= Math.floor(Math.random() * (parseInt(mediaLen)+1));
			for(i=0; i<=suffleAry.length;i++){
				  if(suffleAry[i] == randNo){
					  f++;
				  }	
			}
			if(f == 0){
				suffleAry[z] = randNo;
				z++;
			}
			if(z > mediaLen){
				break;
			}
		}
	}
	/* 서플순서 보기 - alert
	var bstr="";
	for(j=0; j<suffleAry.length;j++){
		var astr = suffleAry[j];
	    bstr = bstr+","+astr;
	}
	alert("["+bstr+"]");
	*/
}

//음원 이전곡다음곡처리
function runPlay(r){
	mediaLen = ($("input[name=trkId]").length)-1;
	if(mediaLen >= 0){
		if(r == "prev"){
			var prevIdx = parseInt(currentIdx) -1;
			//alert("curIdx="+currentIdx+"/prevIdx="+prevIdx);
			if(prevIdx >= 0){
				currentIdx = prevIdx;
				play(currentIdx);
			}	
	    }else if(r == "next"){
	    	var nextIdx = parseInt(currentIdx) +1;
	    	//alert("mediaLen="+mediaLen+"/nextIdx="+nextIdx);
	    	if(nextIdx > mediaLen){
	          play(currentIdx);
	    	}else{
	    	  currentIdx = nextIdx;
	    	  play(currentIdx);
	    	  
	    	}
	    }
	}
}
// 음원 1분듣기,전곡듣기 테스트
function chgFullYn(){
	var sval = $("select#full_yn > option:selected").val();
	$('input[name=fullYn]').val(sval);
}

//선택항목 담기 처리
function playerAddMyListTrack(){
    var trkIds = musicPlayer.player.getCheckTrackIds();

    if(trkIds.length == 0){ alert("항목을 선택해 주십시오"); return; }
    addMyListTrack(trkIds.join(","));
}

</script>
</head>
<BODY>

<SCRIPT FOR = "Player" EVENT = "PlaylistChange(Playlist, change)" language="JScript">
    //alert("playlistChange 의 change="+change);
	switch (change){
	case 2: //InfoChange
		setStateInfoStr('Change',true);
		break
	case 3: //Move
		setStateInfoStr('Change',true);
		break
	case 4: //Delete
		setStateInfoStr('Change',true);
		break
	case 5: //Insert
		setStateInfoStr('Change',true);
		break
		   default:
	}
</SCRIPT>

<script for="Player" event="openStateChange(NewStat)" language="JScript">
    //alert("openStateChange 의 NewStat="+NewStat+"["+(testIdx++)+"]");
	switch(NewStat) {
	case 0 : // undefined
		break;
	case 1 : // playlist changing
		break;
	case 7 : //A new playlist has been assigned to currentPlaylist, playlist changed.
		setStateInfoStr('Change',true); 
		break;
	case 8 : //New media is about to be loaded. media changing
		setStateInfoStr('Change',true);
		break;
	case 13 : // media open
		break
    }
</script>

<script for="Player" event="playStateChange(NewState)" language="JScript">
    //alert("PlayStateChage 의 newstate="+NewState+"["+(testIdx++)+"]");
	switch(NewState) {
	case 0 : // Undefined
		   setStateInfoStr('Unknown',false);
	break;
	case 1 : // Stopped
		setStateInfoStr('Stop',false);
		break;
	case 2 : // Paused
		setStateInfoStr('Pause',true);
		break;
	case 3 : // Playing
		setStateInfoStr('Playing',true);
		setVolumePosition(); //현재 볼륨의 위치 보여줌
		break;
	case 4 : // ScanForward
		setStateInfoStr('Forward',true);
		break;
	case 5 : // ScanReverse
		setStateInfoStr('Reverse',true);
		break;
	case 6 : // Buffering
		setStateInfoStr('Buffering',true);
		break;
	case 7 : // Waiting
		setStateInfoStr('Waiting',false);
		break;
	case 8 : // MediaEnded
		setStateInfoStr('Ended',false);
		break;
	case 9 : // Transitioning
		setStateInfoStr('Transitioning',true);
		break;
	case 10 : // Ready
		setStateInfoStr('Ready',false);
		break;
	default:
		setStateInfoStr('Ready',false);
		break;
    }
</script>

<OBJECT classid="CLSID:04670ED5-3464-4a83-BE1F-24E6FFA41928" CODEBASE="http://www.peeringportal.net/caburl/p3controls.cab#version=1,0,0,0" height=100 id=Player style="position:absolute; LEFT: 0px; TOP: 0px; WIDTH: 0px; height:0;" type="application/x-oleobject" VIEWASTEXT>
<PARAM NAME="SetLBS"        VALUE="lbsaod.rsrs.co.kr;lbsaod.rsrs.co.kr">    
<PARAM NAME="LogSvr"        VALUE="statsvr.rsrs.co.kr;statsvr.rsrs.co.kr">  
<PARAM NAME="userID"        VALUE="admin">    
<PARAM NAME="ServiceID"     VALUE="HOTTRACKSAF">   
<PARAM NAME="ChargedUser"   VALUE="">
<PARAM NAME="UserMsg1"      VALUE="">
<PARAM NAME="UserMsg2"      VALUE="">
<PARAM NAME="UserMsg3"      VALUE="">
<PARAM NAME="ServerAdd"     VALUE=""> 
<PARAM NAME="Gender"        VALUE="">
<PARAM NAME="Age"           VALUE="">
<PARAM NAME="Area"          VALUE="">
<PARAM NAME="MediaSort"     VALUE="1">  
<PARAM NAME="MediaID"       VALUE=""> 
<PARAM NAME="Volume"        VALUE="70">
</OBJECT>

<form name="aodPlay" method="GET">
<input type="hidden" name=SVC_ID value="">
<input type="hidden" name=fullYn value="">
    <span id="auth"></span><br/><br/>
    <span id="durTm"></span>&nbsp;<span id="mediaText"></span><br/>
    <span id="allrepeat"></span><br/>
    <span id="onerepeat"></span><br/>
    <span id="suffle"></span><br/>
    <input type="checkbox" onclick="musicPlayer.player.checkAll(this);" />
    <a href="javascript:musicPlayer.player.removePlayList();">[삭제]</a>
    [다운]
    <a href="javascript:playerAddMyListTrack();">[담기]</a>
    <br/>
    
    <div class="playListArea"></div>
  
    <br/>
    <input type="button" value="이전곡" onClick="runPlay('prev')">
    <input type="button"  value="play" onClick="Player.controls.play();"> 
    <input type="button" value="Pause" onClick="Player.controls.pause();">
    <input type="button" value="다음곡" onClick="runPlay('next')">  
    <input type="button" value="전곡반복" onClick="loopMode(1)">
    <input type="button" value="한곡반복" onClick="loopMode(2)">
    <input type="button" value="반복안함" onClick="loopMode(0)">
    <input type="button" value="suffle" onClick="suffleMode()">
    
    &nbsp; <select id="full_yn" name="full_yn" onChange="chgFullYn()">
                <option value="Y">전체듣기</option> 
                <option value="N">1분 미리듣기</option>
           </select>
    &nbsp;
    <input type="text" name="volume" id="volume" value=""/>
    </form>
    <input type="button" value="-1분" onClick="changePosition(0,60)">
    <input type="button" value="-10초" onClick="changePosition(0,10)">
    <input type="button" value="+10초" onClick="changePosition(1,10)">
    <input type="button" value="+1분" onClick="changePosition(1,60)">
   
</BODY>
</HTML>
