<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %> 

<ui:decorator name="none"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" media="all" href="/css/m_player_hot.css" /> 
<script src="/js/jquery-1.4.2.min.js" type="text/javascript"  charset="utf-8"></script>
<script src="/js/json2.js" type="text/javascript" charset="utf-8"></script>
<script src="/js/jquery-ui-1.8.14.custom.min.js" type="text/javascript"></script>
<script src="/js/jquery.form.js" type="text/javascript" charset="utf-8"></script>

<script type="text/javascript" src="/js/musicPlayer.js"></script>
<script type="text/javascript" src="/js/musicPlayerHot.js"></script>
</head>
<body oncontextmenu="return false" ondragstart="return false" onselectstart="return false" onclick="tt_barCtl()">

<input type="hidden" name="musicCd" value=<c:out value="${item.musicCd}"/>/>
<input type="hidden" name="cdNo" value=<c:out value="${item.cdNo}"/>/>
<input type="hidden" name="trackNo" value=<c:out value="${item.trackNo}"/>/>

<div id="wait_layer" style="position:absolute; width:100%; height:702px; z-index:100; left: 0; top: 0;"><table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><script type="text/javascript">flash_insert('wait', '/images/musicPlayer/wait.swf',702,388);</script></td>
  </tr>
</table>
</div>
<form name="musicFrmHot" method="post" target="window.opener">
</form>


<script type="text/javascript">
	checkWindows();
	
window.onload = function()
{
	var choice = 'musicCd=<c:out value="${item.musicCd}"/>&cdNo=<c:out value="${item.cdNo}"/>&trackNo=<c:out value="${item.trackNo}"/>';
	
	getPlaylistName(choice);
};
</script>

<script  for="ttplayer" language="javascript" event="statusChange()" >
	tt_playstatus_e();
</script>


<script  for="ttplayer" language="javascript"  event="currentItemChange()" >
	tt_playlist();
</script>


<script  for="ttplayer" language="javascript"  event="playStateChange(NewState)" >
	if (NewState == 3 && playListLoaded == false) 
  {   showPlaylist();  }
</script> 


<script language="javascript" for="ctl_player" event="FSCommand(command, args)" >
	
	if (command =="volume")
	{
		tt_vol(args);
	}
	else if(command == "Mute" )
	{
		if( args == "On")
			tt_mute('on');	
		else if( args == "Off")
			tt_mute('off');
	}	
	else if(command == "Control" )
	{
		if(args == "Play")
			tt_play();
		else if(args == "Stop")
			tt_pause();
		else if(args == "prev")
			tt_prev();
		else if(args == "next")
			tt_next();
	}
	else if(command == "vCon")
	{
		if (args == "-10")
		{
			tt_vol_down(10);
		}
		else if(args == "10")
		{
			tt_vol_up(10);
		}
	}

</script>

<table width="702" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="198" height="388" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td height="153" valign="bottom" style="padding-left:37px;"><table width="124" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td height="124" align="center" valign="middle" bgcolor="#78aade">
            	<ui:image rcrdCd="${result[0].musicCd}" prdtGbn="${result[0].sellPrdtGbn}" width="122" height="122" alt="${result[0].albumNm}" clazz="photo" rcrdImgType="midi" ratingCode="a" /></td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td height="235" valign="top"><script type="text/javascript">flash_insert('ctl_player','/images/musicPlayer/player.swf',198,235)</script></td>
      </tr>
      
    </table></td>
    <td valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td height="32">&nbsp;</td>
      </tr>
      <tr>
        <td height="14"><table width="482" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="395" style="padding-left:4px;"><span id="track_no" class="track_no">&nbsp;</span> <span id="track_name"class="track_title"></span></td>
            <td align="right"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
              	<td width="16"><script type="text/javascript">flash_insert('ctl_st','/images/musicPlayer/cd_stop.swf',14,14)</script></td>
                <td class="track_time"><span id="track_time"></span></td>
              </tr>
            </table></td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td height="30" valign="top" style="padding-left:4px; padding-top:0px;">
        <table width="0" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td height="20"><img src="/images/musicPlayer/status_bar_end.gif" width="1" height="3" /></td>
            <td height="20"><img id="ctl_bar" src="/images/musicPlayer/status_bar_body.gif" width="0" height="3" /></td>
            <td height="20"><script type="text/javascript">flash_insert('status','/images/musicPlayer/btn_status.swf',25,21)</script></td>
          </tr>
        </table>
        </td>
      </tr>
      <tr>
        <td height="8"></td>
      </tr>
      <tr>
        <td height="32" class="album_title"><span id="cd_title"><c:out value="${result[0].albumNm}"/></span></td>
      </tr>
      <tr>
        <td height="25" valign="top" style="padding-left:15px;"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="album_info">
          <tr>
            <th width="59" height="14"><img src="/images/musicPlayer/info_tit_01.gif" width="53" height="10" /></th>
            <td width="255"><span id="cd_artist"><c:out value="${result[0].artistNm}"/></span></td>
            <th width="59"><img src="/images/musicPlayer/info_tit_03.gif" width="53" height="10" /></th>
            <td><span id="cd_date"><c:out value="${result[0].chulsiDay}"/></span></td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td height="18" style="padding-left:1px;"><img src="/images/musicPlayer/track_top_bar.gif" alt="" width="484" height="18" /></td>
      </tr>
      <tr>
        <td height="202" style="padding-left:1px;" valign="top"><iframe name="plistFrm" src="#" width="484" height="202" frameborder="0" scrolling="auto" marginwidth="0" marginheight="0" allowtransparency="true"></iframe></td>
      </tr>
    </table></td>
  </tr>
</table>
</body>
</html>
