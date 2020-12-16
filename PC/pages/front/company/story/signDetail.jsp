<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
<script type="text/javascript" src="/js/jquery.form.js"></script>
<script type="text/javascript">
jQuery(function($) {
    $.ajax({
         type: "POST"
       , url: "/company/d/${detail.boardseq}"
       , dataType: "json"
       , success : function(data){
            $(".view_area").html(data.contents);
       }
    });
    
    goCommentList("1", "&boardseq=${detail.boardseq }");
});

function goCommentList(page, param){
    $("#commentArea").load("/company/store/reply?page="+page+param);
}
</script>
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
    
    <!-- story_eventListView -->
    <div class="table_view">
        <table summary="행사안내 상세보기 테이블입니다. 행사명, 진행영업점, 행사기간으로 구성 된 행사안내 상세보기" cellpadding="0" cellspacing="0">
            <caption>행사안내 상세보기</caption>
            <colgroup>
                <col width="113px" />
                <col width="287px" />
                <col width="113px" />
                <col width="*" />
            </colgroup>
                <tbody>
                    <tr>
                        <th scope="row">행사명</th>
                        <td colspan="3">${detail.title }</td>
                    </tr>
                    <tr>
                        <th scope="row">진행 영업점</th>
                        <td>
                            <c:forEach items="${fn:split(detail.deptnames, '/')}" var="l" varStatus="st">
                                <!-- c:if test="{l.checkYn == 'Y' }" -->
                                ${l}
                                <!-- /c:if --> 
                            </c:forEach>
                        </td>
                        <th  scope="row">행사기간</th>
                        <td>
                            <c:if test="${not empty detail.startdate}"><ui:mask pattern="####/##/##">${detail.startdate}</ui:mask></c:if>
                            ~
                            <c:if test="${not empty detail.enddate}"><ui:mask pattern="####/##/##">${detail.enddate}</ui:mask></c:if>
                        </td>
                    </tr>
                    <c:if test="${not empty boardFile && not empty bbsfile.fileName }">
                    <tr>
                        <th  scope="row">첨부파일</th>
                        <td colspan="3"><a href="#none" file="down" fileSeq="${bbsfile.fileseq }" boardseq="${detail.boardseq }">${bbsfile.filename }</a></td>
                    </tr>
                    </c:if>
                    <tr>
                        <td colspan="4" class="view_area">
                            ${detail.contents }
                        </td>
                    </tr>
                </tbody>
            </table>
            <p class="rightBtnView"><a href="#none" title="행사안내 목록보기"><img src="http://image.hottracks.co.kr/info/btn/btn_pre_list.png" alt="목록보기" id="list"/></a></p>
        </div>
        <c:if test="${detail.commentyn == 'Y' }">
            <div id="commentArea"></div>
        </c:if>
        <!-- 리스트(공통) -->
        <div class="ListViewWrap">
            <table summary="리스트 테이블입니다. 번호, 행사명, 행사기간 항목이 있습니다.">
                <caption>리스트 게시판 테이블</caption>
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
                    <c:forEach items="${list}" var="l" varStatus="st">
                    <tr>
                        <td>${pageHolder.lastIndexNumber - st.count +1}</td>
                        <td class="Tleft"><a href="/company/story/signView?boardseq=${l.boardseq}">${l.title }</a><c:if test="${l.newYn eq 'Y'}"><img src="http://image.hottracks.co.kr/info/common/icon_new.png" alt="New" /></c:if></td>
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
            <ui:pagination name="pageHolder" url="/company/story/signView" parameters="srchGbn,srchKeyword,boardseq"/>
        </div>
        <!-- //paging -->
        <!-- search -->
        <form method="post" action="/company/story/sign" onsubmit="return true" name="frmSearch" id="frmSearch">
            <div class="searchWrap">
                <p>
                    <select name="srchGbn" title="전체 제목 내용 선택">
                        <option value="A" <c:if test="${c.srchGbn eq 'A'}">selected="selected"</c:if>>전체</option>
                        <option value="T" <c:if test="${c.srchGbn eq 'T'}">selected="selected"</c:if>>제목</option>
                        <option value="C" <c:if test="${c.srchGbn eq 'C'}">selected="selected"</c:if>>내용</option>
                    </select>
                    <input type="text" name="srchKeyword" value="${c.srchKeyword}" title="검색 키워드 입력" maxlength="256"/>
                    <input type="image" src="http://image.hottracks.co.kr/info/btn/btn_search.png" value="검색" class="btn_search" />
                </p>
            </div>
        </form><!-- //search -->
    </div><!-- //contents area -->
</div><!-- //container -->
</body>
</html>