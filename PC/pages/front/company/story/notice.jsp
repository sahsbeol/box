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
        <em class="location"><img src="http://image.hottracks.co.kr/info/icon/icon_home.png"  alt="홈"/> &gt; 이야기 &gt; <strong>알려드립니다</strong></em>
        <h2>알려드립니다</h2>
    </div>
    <!-- //location -->  
    <!-- 리스트(공통) -->
    <div class="ListViewWrap">
        <table summary="알려드립니다 리스트 테이블 순번, 제목, 등록일, 조회수로 구성 된 공지사항" cellpadding="0" cellspacing="0">
            <caption>알려드립니다 리스트 테이블</caption>
            <colgroup>
                <col width="53px" />
                <col width="*" />
                <col width="150px" />
                <col width="80px" />
            </colgroup>
            <thead>
                <tr>
                    <th scope="col" class="firstChild">번호</th>
                    <th scope="col">제목</th>
                    <th scope="col">등록일</th>
                    <th scope="col">조회수</th>
                </tr>
            </thead>
            <tbody>
                <c:if test="${empty list}"><tr><td colspan="3">등록된 데이터가 없습니다.</td></tr></c:if>
                <c:forEach items="${list}" var="l" varStatus="st">
                    <tr>
                        <td>${pageHolder.lastIndexNumber - st.count +1}</td>
                        <td class="Tleft"><a href="/company/story/noticeView?boardseq=${l.boardseq}" <c:if test="${l.newYn eq 'Y'}">class=" new"</c:if>>${l.title}</a></td>
                        <td><c:if test="${not empty l.registerdate}"><ui:mask pattern="####/##/##">${l.registerdate}</ui:mask></c:if></td>
                        <td>${l.hits}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div><!-- //ListViewWrap -->
    <!-- paging -->
    <div class="paging">
        <ui:pagination name="pageHolder" url="/company/story/notice" parameters="srchGbn,srchKeyword"/>
    </div>
    <!-- //paging -->
    <!-- search -->
    <form method="post" action="/company/story/notice" onsubmit="return true" name="frmSearch" id="frmSearch">
        <div class="searchWrap">
            <p>
                <select name="srchGbn" title="전체, 제목, 내용 선택">
                    <option value="A" <c:if test="${c.srchGbn eq 'A'}">selected="selected"</c:if>>전체</option>
                    <option value="T" <c:if test="${c.srchGbn eq 'T'}">selected="selected"</c:if>>제목</option>
                    <option value="C" <c:if test="${c.srchGbn eq 'C'}">selected="selected"</c:if>>내용</option>
                </select>
                <input type="text" name="srchKeyword" value="${c.srchKeyword}" title="검색 키워드 입력" maxlength="256"/>
                <input type="image" src="http://image.hottracks.co.kr/info/btn/btn_search.png" alt="검색" value="검색" class="btn_search"/>
            </p>
        </div>
    </form><!-- //search -->
</div><!-- //contents area -->
</div><!-- //container -->
</body>
</html>