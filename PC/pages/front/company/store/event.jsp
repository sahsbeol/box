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
<p class="cont_topBg_recruit"><img src="http://image.hottracks.co.kr/info/layout/bg_snb_shop.png" alt="핫트랙스 영업점의 여러가지 소식을 알려드립니다"/></p>
<c:import url="/company/store/lnb?deptcode=${c.deptcode}"/>
<!-- contents area -->
<div id="contents_area">
    <!-- location -->
    <div id="location">
        <h2>${store.deptname}</h2>
        <em class="location"><!-- <img src="http://image.hottracks.co.kr/info/icon/icon_home.png"  alt="홈" />  -->HOME &gt; 영업점 &gt; ${store.deptname} &gt; <strong>행사안내</strong></em>
    </div>
    <!-- //location -->
    <!-- 지점행사안내(공통) -->
    <h3 class="hidden">행사안내</h3>
    <div class="eventWrap">
        <ol class="bannerList">
            <c:forEach items="${list}" var="l" varStatus="st" end="2">
            <li <c:if test="${st.first}">class="firstChild"</c:if>>
                <div class="bannerImg">
                    <a href="/company/store/eventView?deptcode=${c.deptcode}&boardseq=${l.boardseq}" title="${l.title}"><img width="209" height="77" src="http://info.hottracks.co.kr${l.imgurl}"  alt="${l.title}" /></a>
                    <c:choose>
                        <c:when test="${l.prosGbn eq 'N'}"><div class="bannerIcon"><img src="http://image.hottracks.co.kr/info/story/ico_now.png" alt="NOW" class="png24" /></div></c:when>
                        <c:when test="${l.prosGbn eq 'S'}"><div class="bannerIcon"><img src="http://image.hottracks.co.kr/info/story/ico_soon.png" alt="SOON" class="png24" /></div></c:when>
                        <c:otherwise><div class="bannerIcon"><img src="http://image.hottracks.co.kr/info/story/ico_end.png" alt="END" class="png24" /></div></c:otherwise>
                    </c:choose>
                </div>
                <ul class="bannerTxt">
                    <li><a href="/company/store/eventView?deptcode=${c.deptcode}&boardseq=${l.boardseq}" title="${l.title}" >${l.title }</a></li>
                    <li>
                        <c:if test="${not empty l.startdate}"><ui:mask pattern="####/##/##">${l.startdate}</ui:mask></c:if>
                        ~
                        <c:if test="${not empty l.enddate}"><ui:mask pattern="####/##/##">${l.enddate}</ui:mask></c:if>
                    </li>
                    <li>
                        <c:set var="arrDpCdName" value="${fn:split(l.deptnames, ',') }"/> 
                        <c:choose>
                            <c:when test="${fn:length(arrDpCdName) > 3 }">${arrDpCdName[0] }, ${arrDpCdName[1] }, ${arrDpCdName[2] } 외</c:when>
                            <c:otherwise>${l.deptnames}</c:otherwise>
                        </c:choose>
                    </li>
                </ul>
            </li>
            </c:forEach>
        </ol>
    </div><!-- //eventInfoWrap:지점행사안내(공통) -->
    <hr />
    <!-- 리스트(공통) -->
    <div class="ListViewWrap">
        <table summary="순번, 행사명, 행사기간으로 구성 된 지점별 이벤트 게시판" cellpadding="0" cellspacing="0">
            <caption>지점별 이벤트 게시판</caption>
            <colgroup>
                <col width="53px" />
                <col width="*" />
                <col width="180px" />
            </colgroup>
            <thead>
                <tr>
                    <th scope="col" class="firstChild">번호</th>
                    <th scope="col">행사명</th>
                    <th scope="col" class="last">행사기간</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${list}" var="l" varStatus="status">
                    <tr>
                        <td>${pageHolder.lastIndexNumber - status.count +1}</td>
                        <td class="Tleft">
                            <a href="/company/store/eventView?deptcode=${c.deptcode}&boardseq=${l.boardseq}" title="${l.title}" >${l.title }</a>
                            <c:if test="${l.newYn eq 'Y'}"><img src="http://image.hottracks.co.kr/info/common/icon_new.png" alt="New" /></c:if>
                        </td>
                        <td>
                            <c:if test="${not empty l.startdate}"><ui:mask pattern="####/##/##">${l.startdate}</ui:mask></c:if>
                            ~
                            <c:if test="${not empty l.enddate}"><ui:mask pattern="####/##/##">${l.enddate}</ui:mask></c:if>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div><!-- //ListViewWrap -->
    <!-- paging -->
    <div class="paging">
        <ui:pagination name="pageHolder" url="/company/store/event" parameters="srchGbn,srchKeyword,deptcode"/>
    </div>
    <!-- //paging -->
    <!-- search -->
    <form method="post" action="/company/store/event" onsubmit="return true" name="frmSearch" id="frmSearch">
        <input type="hidden" name="deptcode" value="${c.deptcode}" />
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