<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
</head>
<body>
<div id="container">
<p class="cont_topBg_recruit"><img src="http://image.hottracks.co.kr/info/layout/bg_snb_story.png" alt="핫트랙스가 전해드리는새롭고 즐거운 이야기입니다"/></p>
<c:import url="./layerLnb.jsp"/>
<!-- contents area -->
<div id="contents_area">
    <!-- location -->
    <div id="location">
        <em class="location"><img src="http://image.hottracks.co.kr/info/icon/icon_home.png"  alt="홈"/> &gt; 이야기 &gt; <strong>행사안내</strong></em>
        <h2>행사안내</h2>
    </div>
    <!-- //location -->
    <!-- story_eventList -->
    <div class="eventListWrap">
        <ul class="eventList">
            <c:forEach items="${list}" varStatus="s1" step="3">
                <li>
                    <ul class="bannerList">
                        <c:forEach items="${list}" var="l" varStatus="st" begin="${s1.index}" end="${s1.index+2}">
                            <li <c:if test="${st.first}">class="firstChild"</c:if>>
                                <div class="bannerImg">
                                    <a href="/company/story/eventView?boardseq=${l.boardseq}" title="${l.title}"><img width="209" height="77" src="http://info.hottracks.co.kr/${l.imgurl}" alt="${l.title }" /></a>
                                    <c:choose>
                                        <c:when test="${l.prosGbn eq 'N'}"><div class="bannerIcon"><img src="http://image.hottracks.co.kr/info/story/ico_now.png" alt="NOW" class="png24" /></div></c:when>
                                        <c:when test="${l.prosGbn eq 'S'}"><div class="bannerIcon"><img src="http://image.hottracks.co.kr/info/story/ico_soon.png" alt="SOON" class="png24" /></div></c:when>
                                        <c:otherwise><div class="bannerIcon"><img src="http://image.hottracks.co.kr/info/story/ico_end.png" alt="END" class="png24" /></div></c:otherwise>
                                    </c:choose>
                                </div>
                                <ul class="bannerTxt">
                                    <li><a href="/company/story/eventView?boardseq=${l.boardseq}" title="${l.title}">${l.title}</a></li>
                                    <li>
                                        <c:if test="${not empty l.startdate}"><ui:mask pattern="####/##/##">${l.startdate}</ui:mask></c:if>
                                        ~
                                        <c:if test="${not empty l.enddate}"><ui:mask pattern="####/##/##">${l.enddate}</ui:mask></c:if>
                                    </li>
                                    <li>
                                        <c:set var="dpCdNames" value="${fn:replace(l.deptnames,'/',',') }"/>
                                        <c:set var="arrDpCdName" value="${fn:split(dpCdNames, ',') }"/> 
                                        <c:choose>
                                            <c:when test="${fn:length(arrDpCdName) > 3 }">${arrDpCdName[0] }, ${arrDpCdName[1] }, ${arrDpCdName[2] } 외</c:when>
                                            <c:otherwise>${fn:replace(l.deptnames,'/',', ') }</c:otherwise>
                                        </c:choose>
                                    </li>
                                </ul>
                            </li>
                        </c:forEach>
                    </ul>
                </li>
            </c:forEach>
        </ul>
    </div>
    <!-- //story_eventList -->
    <!-- paging -->
    <div class="paging">
        <ui:pagination name="pageHolder" url="/company/story/event" parameters="srchGbn,srchKeyword"/>
    </div>
    <!-- //paging -->
    <!-- search -->
    <form method="post" action="/company/story/event" onsubmit="return true" name="frmSearch" id="frmSearch">
        <div class="searchWrap">
            <p>
                <select name="srchGbn" title="전체, 제목, 내용 선택">
                    <option value="A" <c:if test="${c.srchGbn eq 'A'}">selected="selected"</c:if>>전체</option>
                    <option value="T" <c:if test="${c.srchGbn eq 'T'}">selected="selected"</c:if>>제목</option>
                    <option value="C" <c:if test="${c.srchGbn eq 'C'}">selected="selected"</c:if>>내용</option>
                </select>
                <input type="text" name="srchKeyword" value="${c.srchKeyword}" title="검색 키워드 입력" maxlength="256"/>
                <input type="image" src="http://image.hottracks.co.kr/info/btn/btn_search.png" alt="검색" value="검색" class="btn_search" />
            </p>
        </div>
    </form><!-- //search -->
</div><!-- //contents area -->
</div><!-- //container -->
</body>
</html>