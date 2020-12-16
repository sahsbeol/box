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
        <em class="location">HOME &gt; 영업점 &gt; ${store.deptname} &gt; <strong>${store.deptname}이야기</strong></em>
    </div>
    <!-- //location -->
    <!-- 리스트(공통) -->
    <div class="ListViewWrap">
        <table summary="순번, 제목, 등록일로 구성 된 지점별 스토리리스트" cellpadding="0" cellspacing="0">
            <caption>지점별 스토리 리스트</caption>
            <colgroup>
                <col width="53px" />
                <col width="*" />
                <col width="180px" />
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
                        <td class="Tleft">
                            <a href="/company/store/storyView?deptcode=${c.deptcode}&boardseq=${l.boardseq}" title="${l.title}">${l.title}</a>
                            <c:if test="${l.newYn eq 'Y'}"><img src="http://image.hottracks.co.kr/info/common/icon_new.png" alt="New" /></c:if>
                        </td>
                        <td><c:if test="${not empty l.registerdate}"><ui:mask pattern="####/##/##">${l.registerdate}</ui:mask></c:if></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div><!-- //ListViewWrap -->
    <!-- paging -->
    <div class="paging">
        <ui:pagination name="pageHolder" url="/company/store/story" parameters="srchGbn,srchKeyword,deptcode"/>
    </div>
    <!-- //paging -->
    <!-- search -->
    <form method="post" action="/company/store/story" onsubmit="return true" name="frmSearch" id="frmSearch">
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
    </form>
    <!-- //search -->
</div>
</div><!--  container -->
<!-- //contents area -->
</body>
</html>