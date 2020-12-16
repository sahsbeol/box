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
<p class="cont_topBg_recruit"><img src="http://image.hottracks.co.kr/info/company/bg_snb_company.png" alt="반갑습니다. 일상을 즐거움으로 채워가는 핫트랙스입니다."/></p>
<c:import url="./layerLnb.jsp"/>
<!-- contents area -->
<div id="contents_area">
    <!-- location -->
    <div id="location">
        <em class="location"><img src="http://image.hottracks.co.kr/info/icon/icon_home.png"  alt="홈"/> &gt; 회사소개 &gt; <strong>P.R</strong></em>
        <h2>P.R</h2>
    </div>
    <!-- //location -->  
    <!-- 리스트(공통) -->
    <div class="ListViewWrap">
        <table summary="P.R 게시판 리스트 테이블 입니다.번호, 제목, 등록일 항목이 있습니다." cellpadding="0" cellspacing="0">
            <caption>P.R 게시판</caption>
            <colgroup>
                <col width="53px" />
                <col width="*" />
                <col width="135px" />
            </colgroup>
            <thead>
                <tr>
                    <th scope="col" class="firstChild">번호</th>
                    <th scope="col">제목</th>
                    <th scope="col">등록일</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${list}" var="l" varStatus="st">
                <tr>
                    <td>${pageHolder.lastIndexNumber - st.count +1}</td>
                    <td class="Tleft"><a href="/company/about/prView?boardseq=${l.boardseq}" title="${board.title}">${l.title }</a><c:if test="${l.newYn eq 'Y'}"><img src="http://image.hottracks.co.kr/info/common/icon_new.png" alt="New" /></c:if></td>
                        <td><c:if test="${not empty l.registerdate}"><ui:mask pattern="####/##/##">${l.registerdate}</ui:mask></c:if></td>
                </tr>
                </c:forEach>
            </tbody>
        </table>
    </div><!-- //ListViewWrap -->
        <!-- paging -->
        <div class="paging">
            <ui:pagination name="pageHolder" url="/company/about/pr" parameters="sKind,sWord"/>
        </div>
        <!-- //paging -->
        <!-- search -->
        <form method="post" action="/company/about/pr" onsubmit="return true" name="frmSearch" id="frmSearch">
        <div class="searchWrap">
            <p>
                <select name="srchGbn" title="전체, 제목, 내용 항목선택">
                    <option value="A" <c:if test="${c.srchGbn eq 'A'}">selected="selected"</c:if>>전체</option>
                    <option value="T" <c:if test="${c.srchGbn eq 'T'}">selected="selected"</c:if>>제목</option>
                    <option value="C" <c:if test="${c.srchGbn eq 'C'}">selected="selected"</c:if>>내용</option>
                </select>
                <input type="text" name="srchKeyword" value="${c.srchKeyword}" title="검색키워드입력" maxlength="256"/>
                <input type="image" src="http://image.hottracks.co.kr/info/btn/btn_search.png" alt="검색" value="검색" class="btn_search" />
            </p>
        </div>
        </form><!-- //search -->
</div><!-- //contents area -->
</div><!-- //container -->
</body>
</html>