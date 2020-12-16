<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="record"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<script type="text/javascript">
function listenAllMusic(){
    $('input[name="chkTrk"]').attr("checked", true);
    musicPlayer.base.openPlayer('chkTrk');
}

function goToTheOtherWeek(type){
    var stdDt = '';
    stdDt += $('select[name="selYear"]').val();
    if(type == 'year'){
        stdDt += '0101';
    }else if(type = 'month'){
        stdDt += $('select[name="selMonth"]').val();
        stdDt += '01';
    }else {
        stdDt += $('select[name="selMonth"]').val();
        stdDt += $('select[name="selWeek"]').val();
    }
    
    $('input[name="stdDt"]').val(stdDt);
    
    $('form').submit();
}
</script>
</head>
<body>
<div id="container"> 
    <div class="page_music">
        <div class="page-location">
            <p class="title"><img src="${imageServer}/images/music/title_music_s05.gif" alt="실시간 차트" /></p>
            <ul>
                <li><a href="/">홈</a> <span>&gt;</span></li>
                <li><a href="<ui:recordConstants key="url_record_main" />">음반</a> <span>&gt;</span></li>
                <li><strong>실시간 차트</strong></li>
            </ul> 
        </div>
    </div><!-- end page_music -->
    <div class="snb_mnew"> 
        <div class="snb_music">
            <ul class="sub_1df">
                <li><a href="/ht/record/realTimeList/C0991?bestRangeType=C1001&ctgrId=000300">한터</a>
                    <ul class="sub_2df">
                        <%-- li><a href="/ht/record/realTimeList/C0991?bestRangeType=C1001&ctgrId=0003">종합</a></li --%>
                        <li><a href="/ht/record/realTimeList/C0991?bestRangeType=C1001&ctgrId=000300">가요</a></li>
                        <li><a href="/ht/record/realTimeList/C0991?bestRangeType=C1001&ctgrId=000301">팝</a></li>
                        <li><a href="/ht/record/realTimeList/C0991?bestRangeType=C1001&ctgrId=000308">클래식</a></li>
                    </ul>
                </li>
                <li <c:if test="${c.trkBestType eq 'C1142'}">class="on"</c:if>><a href="/ht/record/realTimeListM/C1142">뮤직뱅크</a></li>
                <li <c:if test="${c.trkBestType eq 'C1143'}">class="on"</c:if>><a href="/ht/record/realTimeListM/C1143">엠카운트다운</a></li> 
            </ul>
        </div>          
    </div><!-- end snb_mnew -->
    <div id="music">
        <div class="contents"> 
            <p class="category_imgtype02">
                <c:if test="${c.trkBestType eq 'C1142'}"><img src="${imageServer}/images/music/img_rlChart02.gif" alt="뮤직뱅크" /></c:if>
                <c:if test="${c.trkBestType eq 'C1143'}"><img src="${imageServer}/images/music/img_rlChart03.gif" alt="엠카운트다운" /></c:if>
            </p>
            <div class="typeF2_title">  
                <div class="btn_box_02">
                    <form action="?" method="post">
                    <input type="hidden" name="stdDt" value="${c.stdDt}"/>
                    <ul class="select_month">
                        <li>
                            <select name="selYear" onchange="goToTheOtherWeek('year')">
                                <c:forEach begin="2011" end="${maxStdDtYear}" var="i">
                                    <option value="${i}" <c:if test="${fn:substring(c.stdDt,0,4) eq i}">selected</c:if>>${i}년</option>
                                </c:forEach>
                            </select>
                        </li>
                        <li>
                            <select name="selMonth" onchange="goToTheOtherWeek('month')">
                                <c:forEach begin="1" end="${maxStdDtMonth}" var="i">
                                    <option value="<ui:lpad length="2" padChar="0">${i}</ui:lpad>" <c:if test="${fn:substring(c.stdDt,4,6) eq i || (fn:substring(c.stdDt,4,5) eq '0' && fn:substring(c.stdDt,5,6) eq i)}">selected</c:if>>${i}월</option>        
                                </c:forEach>
                            </select>
                        </li>
                        <li>
                            <select name="selWeek" onchange="goToTheOtherWeek('week')">
                                <c:forEach begin="1" end="${maxStdDtWeek}" var="i">
                                    <option value="<ui:lpad length="2" padChar="0">${i}</ui:lpad>" <c:if test="${fn:substring(c.stdDt,6,8) eq i || (fn:substring(c.stdDt,6,7) eq '0' && fn:substring(c.stdDt,7,8) eq i)}">selected</c:if>>${i}주차</option>
                                </c:forEach>
                            </select>
                        </li>
                    </ul>
                    </form>
                    <a onclick="listenAllMusic()"><img src="${imageServer}/images/sound/btn_top_alllisten.gif" alt="전체듣기" /></a>
                    <a href="javascript:musicPlayer.base.openPlayer('chkTrk');"><img src="${imageServer}/images/sound/btn_top_listen.gif" alt="듣기" /></a>
                    <a href="javascript:musicDownloader.base.openDownloader('chkTrk');"><img src="${imageServer}/images/sound/btn_top_down.gif" alt="다운" /></a>
                    <a href="javascript:addMyListTrackC('chkTrk');"><img src="${imageServer}/images/music/btn_top_add.gif" alt="담기" /></a>
                </div>
            </div><!-- end typeF2_title -->
            <div class="typeF2_list">  
                <ul>
                    <c:forEach items="${list}" var="l" varStatus="s">
                        <c:if test="${s.index < 5}">
                            <li id="li-${l.abmId}" onmouseover="" onmousedown="">
                                <p class="rank"><span><a href="/ht/track/album/${l.abmId}"><img src="${imageServer}/images/sound/g_best_no${s.count}.png" class="iepngfix" alt="best ${s.count}" /></a></span></p>  
                                <p class="check"><input name="chkTrk" type="checkbox" value="${l.trkId}" /></p> 
                                <p class="album_pic"><a href="/ht/track/album/${l.abmId}" class="album_pic"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" ratingCode="A" width="120"/></a></p>
                                <p class="album_title"><a href="javascript:musicPlayer.base.openPlayer(${l.trkId});"><ui:cut isStripHtml="true" limit="10" tail="...">${l.trkName}</ui:cut></a></p>
                                <p class="singer"><ui:cut isStripHtml="true" limit="10" tail="...">${l.artiName}</ui:cut></p> 
                                <p class="album_artist"><a href="/ht/track/album/${l.abmId}"><ui:cut isStripHtml="true" limit="10" tail="...">${l.albumTitle}</ui:cut></a></p> 
                                <p class="zoom-cart-zzim">
                                    <a href="javascript:musicPlayer.base.openPlayer(${l.trkId});"><img src="${imageServer}/images/sound/btn_listen.png" class="iepngfix" alt="듣기" /></a>
                                    <a href="javascript:viewLyrics(${l.trkId});"><img src="${imageServer}/images/sound/btn_viewlyrics.png" class="iepngfix" alt="가사" /></a>
                                    <a href="javascript:musicDownloader.base.openDownloader(${l.trkId});"><img src="${imageServer}/images/sound/btn_down.png" class="iepngfix" alt="다운" /></a>
                                    <a href="javascript:addMyListTrackC(${l.trkId});" class="bor_none"><img src="${imageServer}/images/sound/btn_putlist.png" class="iepngfix" alt="담기" /></a>
                                </p> 
                            </li>
                        </c:if>
                    </c:forEach>
                </ul>  
                <table>
                    <colgroup>  
                        <col width="6%" />
                        <col width="6%" /> 
                        <col width="28%" /> 
                        <col width="40%" /> 
                        <col width="5%" />
                        <col width="5%" />
                        <col width="5%" />
                        <col width="5%" />
                    </colgroup> 
                    <tbody>
                        <c:forEach items="${list}" var="l" varStatus="s">
                            <c:if test="${s.index > 4}">
                                <tr>   
                                    <td class="check"><input type="checkbox" name="chkTrk" class="checkbox" value="${l.trkId}"/></td>  
                                    <td class="rank"><span class="best${l.rank}"><a href="javascript:musicPlayer.base.openPlayer(${l.trkId});">best ${l.rank}</a></span></td>   
                                    <td class="left"><a href="javascript:musicPlayer.base.openPlayer(${l.trkId});">${l.trkName}</a></td>
                                    <td class="left">${l.artiName} / <a href="/ht/track/album/${l.abmId}">${l.albumTitle}</a></td>
                                    <td><a href="javascript:musicPlayer.base.openPlayer(${l.trkId});"><img src="${imageServer}/images/sound/btn_listen.png" class="iepngfix" alt="듣기" /></a></td>
                                    <td><a href="javascript:viewLyrics(${l.trkId});"><img src="${imageServer}/images/sound/btn_viewlyrics.png" class="iepngfix" alt="가사" /></a></td>
                                    <td><a href="javascript:musicDownloader.base.openDownloader(${l.trkId});"><img src="${imageServer}/images/sound/btn_down.png" class="iepngfix" alt="다운" /></a></td>
                                    <td><a href="javascript:addMyListTrackC(${l.trkId});"><img src="${imageServer}/images/sound/btn_putlist.png" class="iepngfix" alt="담기" /></a></td>
                                </tr>
                            </c:if>
                        </c:forEach>
                    </tbody> 
                </table> 
                <div class="btn_box_02">  
                    <a onclick="listenAllMusic()"><img src="${imageServer}/images/sound/btn_top_alllisten.gif" alt="전체듣기" /></a>
                    <a href="javascript:musicPlayer.base.openPlayer('chkTrk');"><img src="${imageServer}/images/sound/btn_top_listen.gif" alt="듣기" /></a>
                    <a href="javascript:musicDownloader.base.openDownloader('chkTrk');"><img src="${imageServer}/images/sound/btn_top_down.gif" alt="다운" /></a>
                    <a href="javascript:addMyListTrackC('chkTrk');"><img src="${imageServer}/images/music/btn_top_add.gif" alt="담기" /></a>
                </div>                   
            </div><!-- end typeF2_list -->
        </div><!-- end contents -->
    </div><!-- end music -->
</div><!-- end container -->
</body>
</html>