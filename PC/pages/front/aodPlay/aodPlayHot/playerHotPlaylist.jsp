<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %> 

<ui:decorator name="none"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<link rel="stylesheet" type="text/css" media="all" href="/css/m_player_plist_hot.css" /> 
<script src="/js/jquery-1.4.2.min.js" type="text/javascript"  charset="utf-8"></script>
<script src="/js/json2.js" type="text/javascript" charset="utf-8"></script>
<script src="/js/jquery-ui-1.8.14.custom.min.js" type="text/javascript"></script>
<script src="/js/jquery.form.js" type="text/javascript" charset="utf-8"></script>
<script src="/js/musicPlayerHotFlexcroll.js" type="text/javascript"></script>
</head>


<body style="background-color:transparent; overflow-x:hidden;" oncontextmenu="return false" ondragstart="return false" onselectstart="return false">
<script type="text/javascript">

var sel_pp = 1;

var strImgPath = "/images/musicPlayer/";

function changeItem(no, sel)
{
	if(no != sel_pp)
	{
		var old_tr = document.getElementById('pp_'+sel_pp);	
		var old_img = document.getElementById('pp_'+sel_pp+'_img');	
	
		if( sel_pp % 2 == 0)
		{
			// bg = e6e6e6
			old_tr.style.backgroundColor = '#e6e6e6';
		}
		else
		{
			// bg = FFFFFF
			old_tr.style.backgroundColor = '';
			
		}
		old_tr.style.fontWeight  = '';
		old_img.src=strImgPath+'blank.gif';
	}
	sel_pp = no;

	var new_tr = document.getElementById('pp_'+no);	
	var new_img = document.getElementById('pp_'+no+'_img');	

	new_tr.style.backgroundColor = '#c9d3dc';
	new_tr.style.fontWeight = 'bold';
	new_img.src = strImgPath+'ico_current.png';
	
	if(sel == null)
		parent.tt_select(no);
}

function showPlayItems()
{
	var cdindex = 0;
	var plist = ''; 
    
    var playlistItems = parent.ttplayer.currentPlaylist.count; 
    
	plist = '<table  width="469" border="0" cellpadding="0" cellspacing="0" class="track_list">\n';

    for (i=0; i<playlistItems; i++)
    { 
    	var titles = parent.ttplayer.currentPlaylist.item(i).name; 
		var times =  parent.ttplayer.currentPlaylist.item(i).durationString; 

		if(times == '00:00')
			times = '';
				
    	var items = titles.split("||");
    	
    	var tmp = items[0].split("/");
    	
    	var CDnum = parseInt(tmp[0].replace(/0/g, ""));
    	var TrackNo = tmp[1];
    	
    	if( items[1].length > 45)
    		titles = items[1].substring(0, 45) + '....';
    	else
    		titles = items[1];

    	if( cdindex != CDnum)
    	{
			plist= plist + '  <tr bgcolor="e6e6e6">\n';
			plist= plist + '    <td width="58"  class="cd_no">CD '+CDnum+'</td>\n';
			plist= plist + '    <td width="11"  class="title">&nbsp;</td>\n';
			plist= plist + '    <td width="328"  class="title">&nbsp;</td>\n';
			plist= plist + '    <td >&nbsp;</td>\n';
			plist= plist + '  </tr>\n';
			
			cdindex = CDnum;
    	}
    	
    	if( (i+1) % 2 == 0)
    	{
			plist= plist + '  <tr id="pp_'+(i+1)+'" bgcolor="e6e6e6" onClick="changeItem('+(i+1)+')" style="cursor:hand">\n';
			plist= plist + '    <td>'+TrackNo+'</td>\n';
			plist= plist + '    <td class="title"><img id="pp_'+(i+1)+'_img" src="'+strImgPath+'blank.gif" width="5" height="7" /></td>\n';
			plist= plist + '    <td class="title">'+titles+'</td>\n';
			plist= plist + '    <td><span id="times_'+(i+1)+'">'+times+'</span></td>\n';
			plist= plist + '  </tr>\n';
    	}
   		else
    	{
			plist= plist + '  <tr id="pp_'+(i+1)+'"  onClick="changeItem('+(i+1)+')" style="cursor:hand">\n';
			plist= plist + '    <td>'+TrackNo+'</td>\n';
			plist= plist + '    <td class="title"><img id="pp_'+(i+1)+'_img" src="'+strImgPath+'blank.gif" width="5" height="7" /></td>\n';
			plist= plist + '    <td class="title">'+titles+'</td>\n';
			plist= plist + '    <td ><span id="times_'+(i+1)+'">'+times+'</span></td>\n';
			plist= plist + '  </tr>\n';
    	}
    	
    } 
	plist = plist + '</table>\n';
	parent.wait_close();
	document.write(plist);
	changeItem(1, 0);	
} 


</script>
<div id='mycustomscroll' class='flexcroll'>
<script type="text/javascript">
	showPlayItems();
</script>
</div>
</body>
</html>
