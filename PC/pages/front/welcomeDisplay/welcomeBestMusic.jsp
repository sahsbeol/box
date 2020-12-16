<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<ui:decorator name="none"/>
<span class="ir">BEST MUSIC</span>
<ul class="menu">
    <c:forEach begin="0" end="3" varStatus="s1">
        <li>
            <a href="javascript://"
               onclick="fnRolling('.bmPg', ${s1.index}, true)"
               targetView="#bestMusicDiv${s1.count}"
               class="bmPg ${s1.first?'on':''}"
            >
                ${s1.index eq 0?'종합':''}
                ${s1.index eq 1?'가요':''}
                ${s1.index eq 2?'POP':''}
                ${s1.index eq 3?'클래식':''}
            </a>
        </li>
    </c:forEach>
</ul>
<div class="box_r">
    <c:forEach begin="0" end="3" varStatus="s1">
        <c:if test="${s1.index eq 0}"><c:set var="list" value="${bestTrackAll}"/></c:if>
        <c:if test="${s1.index eq 1}"><c:set var="list" value="${bestTrackMusic}"/></c:if>
        <c:if test="${s1.index eq 2}"><c:set var="list" value="${bestTrackPop}"/></c:if>
        <c:if test="${s1.index eq 3}"><c:set var="list" value="${bestTrackClassic}"/></c:if>
        <div id="bestMusicDiv${s1.count}" style="display:${s1.first?'done':'none'};">
            <c:forEach items="${list}" var="l" varStatus="s">
                <p class="album" <c:if test="${!s.first}">style="display:none;"</c:if>>
                    <a href="javascript:musicPlayer.base.openPlayer(${l.trkId});"><ui:albumImage abmId="${l.abmId}" width="90" height="90" size="140" /></a>
                </p>
            </c:forEach>
            <p style="cursor:pointer;" class="btn_prev" onclick="prevBestMusic()"><a><img src="${imageServer}/images/main/btn_prev_main.gif" alt="이전" /></a></p>
            <p style="cursor:pointer;" class="btn_next" onclick="nextBestMusic()"><a><img src="${imageServer}/images/main/btn_next_main.gif" alt="다음" /></a></p>
            <ul>
                <c:forEach items="${list}" var="l" varStatus="s">
                    <li <c:if test="${s.index eq '4'}">class="last"</c:if>>
                        <a href="javascript:musicPlayer.base.openPlayer(${l.trkId});" onclick="moveBestMusic(${s.index})" <c:if test="${s.first}">class="on"</c:if>>
                            <span class="box">${l.rank}</span><span class="title">${l.trkName} / ${l.artiName}</span>
                        </a>
                    </li> 
                </c:forEach>
            </ul> 
        </div>
    </c:forEach>
</div>