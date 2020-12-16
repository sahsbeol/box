<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %> 
<ui:decorator name="none"/>
<HTML>
<HEAD>
<title>PCube AoD Demo - Installer</title>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
<meta http-equiv='Cache-Control' content='no-cache'>
<meta http-equiv='Pragma' content='no-cache'>
<script type="text/javascript" src="/js/jquery-1.4.2.min.js" charset="utf-8"></script>
<script type="text/javascript" src="/js/json2.js"></script>
<script type="text/javascript" src="/js/music.js"></script>
<script type="text/javascript" src="/js/musicPlayer.js"></script>
<script type="text/javascript" charset="utf-8">

var isLogin = ${isLogin};


// 선택항목 담기 처리
function playerAddMyListTrack(){
	var trkIds = musicPlayer.player.getCheckTrackIds();

	if(trkIds.length == 0){ alert("항목을 선택해 주십시오"); return; }
	addMyListTrack(trkIds.join(","));
}


$(document).ready(function(){
	// 플레이어 초기화
	musicPlayer.player.setPlayList(${listJSON});
	musicPlayer.player.createPlayList();
});


</SCRIPT>
</HEAD>
<BODY>


<input type="checkbox" onclick="musicPlayer.player.checkAll(this);" />
<a href="javascript:musicPlayer.player.removePlayList();">[삭제]</a>
[다운]
<a href="javascript:playerAddMyListTrack();">[담기]</a>
<div class="playListArea"></div>


</BODY>
</HTML>


