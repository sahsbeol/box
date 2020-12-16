<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
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
});
</script>
</head>
<body>
<div id="container">
<p class="cont_topBg_recruit"><img src="/images/company/company/bg_snb_company.png" alt="반갑습니다. 일상을 즐거움으로 채워가는 핫트랙스입니다."/></p>
<c:import url="./layerLnb.jsp"/>
<!-- contents area -->
<div id="contents_area">
    <!-- location -->
    <div id="location">
        <h2>P.R</h2>
        <em class="location"><img src="/images/company/icon/icon_home.png"  alt="홈"/> &gt; 회사소개 &gt; <strong>P.R</strong></em>
    </div>
    <!-- //location -->  
    <div class="table_view">
        <table summary="순번, 제목, 등록일로 구성 된 P.R 게시판 상세보기" cellpadding="0" cellspacing="0">
            <caption>P.R 게시판 상세보기</caption>
                <colgroup>
                    <col width="113px" />
                    <col width="396px" />
                    <col width="113px" />
                    <col width="120px" />
                </colgroup>
                <tbody>
                    <tr>
                        <th scope="row">제목</th>
                        <td>${detail.title }</td>
                        <th scope="row">등록일</th>
                        <td><ui:mask pattern="####/##/##">${detail.registerdate}</ui:mask></td>
                    </tr>
                    <c:if test="${not empty bbsfile }">
                        <tr>
                            <th>첨부파일</th>
                            <td colspan="3"><a href="#none" file="down" fileSeq="${bbsfile.fileseq }" boardseq="${detail.boardseq }">${bbsfile.filename }</a></td>
                        </tr>
                    </c:if>
                    <tr><td colspan="4" class="view_area"></td></tr>
                </tbody>
            </table>
            <p class="rightBtnView"><a href="/company/story/pr?page=${c.page}&srchGbn=${c.srchGbn}&srchKeyword=${c.srchKeyword}" title="PR 목록보기"><img src="/images/company/btn/btn_pre_list.png" alt="목록보기" id="list"/></a></p>
        </div>
        <!-- 리스트(공통) -->
        <div class="ListViewWrap">
            <table summary="순번, 제목, 등록일로 구성 된 P.R 게시판" cellpadding="0" cellspacing="0">
                <caption>P.R 게시판</caption>
                <colgroup>
                    <col width="53px" />
                    <col width="*" />
                    <col width="135px" />
                </colgroup>
                <thead>
                    <tr>
                        <th class="firstChild">번호</th>
                        <th>제목</th>
                        <th>등록일</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${list}" var="l" varStatus="st">
                        <tr>
                            <td>${pageHolder.lastIndexNumber - st.count +1}</td>
                            <td class="Tleft"><a href="/company/about/prView?boardseq=${l.boardseq}" title="${l.title}">${l.title }</a><c:if test="${l.newYn eq 'Y'}"><img src="/images/company/common/icon_new.png" alt="New" /></c:if></td>
                            <td><c:if test="${not empty l.registerdate}"><ui:mask pattern="####/##/##">${l.registerdate}</ui:mask></c:if></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div><!-- //ListViewWrap -->
        <!-- paging -->
        <div class="paging"><ui:pagination name="pageHolder" url="/company/about/prView" parameters="srchGbn,srchKeyword,boardseq"/></div>
        <!-- //paging -->    
        <!-- search -->
        <form method="post" action="/company/about/prView" onsubmit="return true" name="frmSearch" id="frmSearch">
            <div class="searchWrap">
                <p>
                    <select name="srchGbn">
                        <option value="A" <c:if test="${boardSearch.srchGbn eq 'A'}">selected="selected"</c:if>>전체</option>
                        <option value="T" <c:if test="${boardSearch.srchGbn eq 'T'}">selected="selected"</c:if>>제목</option>
                        <option value="C" <c:if test="${boardSearch.srchGbn eq 'C'}">selected="selected"</c:if>>내용</option>
                    </select>
                    <input type="text" name="srchKeyword" value="${boardSearch.srchKeyword}" maxlength="256"/>
                    <input type="image" src="/images/company/btn/btn_search.png" value="검색" class="btn_search" />
                </p>
            </div>
        </form><!-- //search -->
    </div><!-- //contents area -->
</div><!-- //container -->
</body>
</html>