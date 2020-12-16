<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="track"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<script type="text/javascript" src="/js/form.js"></script>
<script type="text/javascript">
var rollingIdx = 1;

$(document).ready(function(){
	
    $('div#div_rolling_'+rollingIdx).show();
 
});

function prev(){
	var nRollingIdx;
	if(rollingIdx == 1){
	    nRollingIdx = 6;
		$('div#div_rolling_'+rollingIdx).hide();
        $('div#div_rolling_'+nRollingIdx).show();
        rollingIdx = nRollingIdx;
	}else{
		nRollingIdx = rollingIdx - 1;
		$('div#div_rolling_'+(rollingIdx)).hide();
		$('div#div_rolling_'+(nRollingIdx)).show();
		rollingIdx = nRollingIdx;
	}
}

function next(){
	var nRollingIdx;
	if(rollingIdx == 6){
		nRollingIdx = 1;
		$('div#div_rolling_'+rollingIdx).hide();
        $('div#div_rolling_'+nRollingIdx).show();
        rollingIdx = nRollingIdx;
	}else{
		nRollingIdx = rollingIdx + 1;
	    $('div#div_rolling_'+rollingIdx).hide();
	    $('div#div_rolling_'+nRollingIdx).show();
	    rollingIdx = nRollingIdx;
	}
}

function windowOpen(url,target) {
    window.open(url, target, 'width=700,height=640,scrollbars=yes');
    return true;
}
function playAod(){
	
     if ($("input[name=selectedRow]):checkbox:checked").length == 0) {
         alert('선택된 음원이 없습니다.');
     } else {
         var url = 'about:blank';
         var target = 'playerStart';
         if (windowOpen(url, target)) {
        	 var action = $('form[name=genreForm]').attr('action');
             $('form[name=genreForm]').attr('action', '/ht/track/player');
             $('form[name=genreForm]').attr('target', target);
             $('form[name=genreForm]').submit();
         }
     }
}

function playSingle(idx){
   if(idx != null){
		/*
		if($('input[name=selectedRow]').get(idx-1).checked){
			alert("true");
		}else{
			$('input[name=selectedRow]').get(idx-1).checked = true;
		}
		$('input[name=selectedRow]').get(idx-1).attr('checked','checked');
		*/
        $('input[name="listenIdx"]').val(idx);
        var url = 'about:blank';
        var target = 'playerStart';
        if (windowOpen(url, target)) {
      	 var action = $('form[name=genreForm]').attr('action');
       	 $('form[name=genreForm]').attr('action', '/ht/track/playerSingle');
       	 $('form[name=genreForm]').attr('target', target);
       	 $('form[name=genreForm]').submit();
        }
         
     }
     //$('input[name=selectedRow]').get(idx).checked = false;
}

function gnrNavi(fId){
    document.location.href = '/ht/track/genre?genreId=' + fId;
    /*
    $.ajax({
        url : "/ht/track/genre",
        dataType : "html", 
        type : "GET", 
        data : "genreId="+fId
        ,error: function(XMLHttpRequest, textStatus, errorThrown){
            alert(errorThrown);
        }
    });
    */
}

function downSingle(idx){
	//alert(idx);
	$('input[name="listenIdx"]').val(idx);
	$('input[name="trkId"]').val($('input[name="selectedTrkId_"+idx]').val());
	$('input[name="trkName"]').val($('input[name="selectedTrkName_"+idx]').val());

     var url = 'about:blank';
     var target = 'downStart';
     if (windowOpen(url, target)) {
    	    var data = $("#genreForm").formData({ debug : true });
    	    $.ajax({
    	    	url : "/ht/track/downSingle",
    	    	dataType : "json", 
    	        type : "post", 
    	        data : {
  	                    listenIdx : idx,
  	                    downTrkId : $("input[name=selectedTrkId_"+idx+"]").val(),
  	                    downTrkName : $("input[name=selectedTrkName_"+idx+"]").val()
    	        },
    	        target : "downStart",
		        success: function(data) {
		        	alert("2");
		        },
		        error: function(XMLHttpRequest, textStatus, errorThrown){
	                alert("3");
	            }
		    }); 
     }
     
  
    /*
	 $('input[name="listenIdx"]').val(idx);
     var url = 'about:blank';
     var target = 'downStart';
     if (windowOpen(url, target)) {
      $('form[name=genreForm]').attr('action', '/ht/track/downSingle');
      $('form[name=genreForm]').attr('target', 'downIframe');
      $('form[name=genreForm]').submit();
     }
    */
}
</script>
</head>
<body>
<!-- 이곳부터 추가해주시면 됩니다 -->
        <div id="container"> 
           
            <!-- sound 현재 페이지 위치 소스 입니다 -->  
            <div class="page_sound">
                <div class="page-location">
                    <p class="title"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/sound/title_sound_s01.gif" alt="장르별 음악" /></p>
                    <ul>
                        <li><a href="#">홈</a> <span>&gt;</span></li>
                        <li><a href="#">음원</a> <span>&gt;</span></li>
                        <li><strong>장르별 음악</strong></li>
                    </ul>
                </div>
            </div>
            <!-- //sound 현재 페이지 위치 소스 입니다 -->
       
            <!-- snb -->
            <div class="snb_mnew">
            
                <!-- snb_n_sound -->
                <div class="snb_n_sound">
                    <ul> 
                    <c:forEach items="${leftGnrList}" var="lgnr" varStatus="status">
                        <c:choose>
                            <c:when test="${tbc.genreId eq lgnr.fullId}">
                            <li class="on">
                            </c:when>
                            <c:otherwise>
                            <li>
                            </c:otherwise>
                        </c:choose>
                            <span><a href="javascript:gnrNavi('${lgnr.fullId}')">${lgnr.name}</a></span>
                        </li>
                    </c:forEach>
                    </ul>
                </div>
                <!-- // snb_n_sound -->  
                
            </div> 
            <!-- //snb -->
            
            <!-- sound -->
            <div id="sound">
             
                <div class="contents"> 
                     
                    <div class="stitle">
                        <h3>가요</h3> 
                    </div>
                                    
                    <div class="typeF_title">
                        <span class="left"><a href="#" class="on">종합</a> <em>|</em> 
                            <a href="#" class="off">발라드/R&amp;B</a> <em>|</em> 
                            <a href="#" class="off">클럽/댄스</a> <em>|</em> 
                            <a href="#" class="off">힙합</a> <em>|</em> 
                            <a href="#" class="off">포크/블루스</a> <em>|</em> <a href="#" class="off">록</a>
                        </span>  
                    </div>
  
                   <!-- typeF_rollinglist -->
                    <div class="typeF_rollinglist">  
                        <c:forEach begin="1" end="6" var="divSeq" varStatus="s">
                        <c:set var="sIdx" value="${(divSeq - 1) * 5}"/>
                        <c:set var="eIdx" value="${divSeq * 5}"/>
                        <div id="div_rolling_${divSeq}" class="box" style="display:none;">
                            <ul> 
	                            <c:forEach items="${recentList}" var="rList" varStatus="ls">
	                                <c:if test="${ls.index >= sIdx and ls.index < eIdx}">
		                                <li> 
		                                    <p class="album_pic"><a href="#" class="album_pic"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/music/@temp_b4_viewimg.gif" alt="소녀시대 6집 커버이미지" /></a></p>
		                                    <p class="album_artist">${rList.artiName}</p> 
		                                    <p class="album_title"><a href="#">${rList.title}</a></p>
		                                </li>
	                                </c:if>
	                            </c:forEach>
                            </ul>
                        </div>  
                        </c:forEach>
                        <span class="btnleft"><a href="javascript:prev()"><img alt="이전" src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/sound/moth_prev.gif"></a></span>
                        <span class="btnright"><a href="javascript:next()"><img alt="다음" src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/sound/moth_next.gif"></a></span>
                    </div>
                    <!-- //typeF_rollinglist -->
                     
                    <form name="genreForm" method="post" onsubmit="return false;">
                    <input type="hidden" name="genreId" id="genreId" value="${tbc.genreId}"/> 
                    <input type="hidden" name="listenIdx"  value=""/>
                    <input type="hidden" name="trkId"   value=""/>
                    <input type="hidden" name="trkName"  value=""/>
                    <!-- typeF_list 베스트 -->
                  
                    <div class="typeF_list">  
                        <div class="btn_box"> 
                            <a href="javascript:playAod()"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/sound/btn_top_s_listen.gif" alt="듣기" /></a>
                            <a href="#"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/sound/btn_top_s_down.gif" alt="다운" /></a>
                            <a href="#"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/sound/btn_top_s_add.gif" alt="담기" /></a>
                        </div>

                        <table>
                            <colgroup>  
                                <col width="5%" />
                                <col width="5%" /> 
                                <col width="44%" /> 
                                <col width="22%" /> 
                                <col width="6%" />                                                                  
                                <col width="6%" />  
                                <col width="6%" />  
                                <col width="6%" />                      
                            </colgroup>
                            <thead>
                                <tr> 
                                    <th colspan="2"><input type="checkbox" onclick="" name="a" class="checkbox" /> NO</th>  
                                    <th>곡명</th>    
                                    <th>아티스트/음반</th> 
                                    <th>듣기</th> 
                                    <th>가사</th> 
                                    <th>다운</th> 
                                    <th class="bg_none">담기</th> 
                                </tr>
                            </thead>    
                            <tbody> 
                            <c:forEach items="${list}" var="track" varStatus="status">
                                <c:set var="idx" value="${status.count + ((tbc.page * 20)-20)}"/>
                                <tr>   
                                    <td class="check">
                                        <input type="checkbox" name="selectedRow" class="checkbox" value="${idx}"/>
                                        <input type="hidden" name="selectedTrkId_${idx}"  value="${track.trkId}"/>
                                        <input type="hidden" name="selectedTrkName_${idx}" value="${track.trkName}"/>
                                    </td>  
                                    <td class="center">${idx}</td> 
                                    <td class="left">
                                        <c:choose>
                                            <c:when test="${fn:length(track.trkName) > 50}">
                                                <c:out value="${fn:substring(track.trkName,0,50)}"/>..
                                            </c:when>
                                            <c:otherwise>
                                                ${track.trkName}
                                            </c:otherwise>
                                         </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${fn:length(track.artiName) > 8}">
                                                <c:out value="${fn:substring(track.artiName,0,8)}"/>..
                                            </c:when>
                                            <c:otherwise>
                                                ${track.artiName}
                                            </c:otherwise>
                                         </c:choose>
                                            /
                                         <c:choose>
                                            <c:when test="${fn:length(track.title) > 6}">
                                                <c:out value="${fn:substring(track.title,0,6)}"/>..
                                            </c:when>
                                            <c:otherwise>
                                                ${track.title}
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td><a href="javascript:playSingle(${idx})"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/sound/btn_listen.gif" alt="듣기" /></a></td> 
                                    <td><a href="#"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/sound/btn_view_lyrics.gif" alt="가사" /></a></td> 
                                    <td><a href="javascript:downSingle(${idx})"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/sound/btn_down.gif" alt="다운" /></a></td> 
                                    <td><a href="#"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/sound/btn_put_list.gif" alt="담기" /></a></td> 
                                </tr> 
                                </c:forEach>
                            </tbody> 
                        </table> 
                       
                        <div class="btn_box"> 
                            <a href="javascript:playAod()"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/sound/btn_top_s_listen.gif" alt="듣기" /></a>
                            <a href="#"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/sound/btn_top_s_down.gif" alt="다운" /></a>
                            <a href="#"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/sound/btn_top_s_add.gif" alt="담기" /></a>
                        </div>
                   
                        <div class="pager">
                            페이징<ui:pagination name="pageHolder" url="/ht/track/genre" parameters="genreId"/>
                        </div>  
                        
                    </div>
                    <!-- //typeF_list 베스트 --> 
                </form>
                </div>
                
            </div>
            <!-- //sound -->
             
        </div>
        <!-- //이곳까지 추가해주시면 됩니다 --> 
        
      
</body>
</html>



