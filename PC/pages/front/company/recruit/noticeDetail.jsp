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
            $(".view_area_left").html(data.contents);
       }
    });
});
</script>
</head>
<body>
<div id="container">
<p class="cont_topBg_recruit"><img src="http://image.hottracks.co.kr/info/layout/bg_snb_recruit.png" alt="아름다운핫트랙스 이야기를 함께 만들어갈 인재를 환영합니다."/></p>
<c:import url="./layerLnb.jsp"/>
<!-- contents area -->
<div id="contents_area">
    <!-- location -->
    <div id="location">
        <em class="location"><img src="http://image.hottracks.co.kr/info/icon/icon_home.png"  alt="홈"/> &gt; 이야기 &gt; <strong>알려드립니다</strong></em>
        <h2>알려드립니다</h2>
    </div>
    <!-- //location -->  
    <div class="table_view">
        <table summary="행사안내 상세보기 테이블 행사명, 진행영업점, 행사기간으로 구성 된 행사안내 상세보기" cellpadding="0" cellspacing="0">
            <caption>행사안내 상세보기</caption>
            <colgroup>
                <col width="113px" />
                <col width="287px" />
                <col width="113px" />
                <col width="*" />
            </colgroup>
                <tbody>
                    <tr>
                        <th scope="row">제목</th>
                        <td colspan="3">${detail.title}</td>
                    </tr>
                    <tr>
                        <th scope="row">조회수</th>
                        <td>${detail.hits}</td>
                        <th scope="row">등록일</th>
                        <td><c:if test="${not empty detail.registerdate}"><ui:mask pattern="####/##/##">${detail.registerdate}</ui:mask></c:if></td>
                    </tr>
                    <c:if test="${not empty bbsfile}">
                    <tr>
                        <th scope="row">첨부파일</th>
                        <td colspan="3"><a href="#none" file="down" fileSeq="${bbsfile.fileseq }" boardseq="${detail.boardseq}">${bbsfile.filename }</a></td>
                    </tr>
                    </c:if>
                    <tr>
                        <td colspan="4" class="view_area_left"></td>
                    </tr>
                </tbody>
        </table>
        <p class="rightBtnView"><a href="/company/recruit/notice?page=${c.page}&srchGbn=${c.srchGbn}&srchKeyword=${c.srchKeyword}" title="행사안내 목록보기"><img src="http://image.hottracks.co.kr/info/btn/btn_pre_list.png" alt="목록보기" id="list"/></a></p>
    </div>
    <!-- 리스트(공통) -->
    <div class="ListViewWrap">
        <table summary="공지사항 리스트 테이블입니다. 번호, 제목, 등록일, 조회수로 구성 된 공지사항" cellpadding="0" cellspacing="0">
            <caption>공지사항 리스트</caption>
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
                <c:forEach items="${list}" var="l" varStatus="st">
                <tr>
                    <td>${pageHolder.lastIndexNumber - st.count +1}</td>
                    <td class="Tleft"><a href="/company/recruit/noticeView?boardseq=${l.boardseq}" title="${l.title }" list="list" boardseq="${l.boardseq}">${l.title}</a></td>
                    <td><c:if test="${not empty l.registerdate}"><ui:mask pattern="####/##/##">${l.registerdate}</ui:mask></c:if></td>
                    <td>${l.hits}</td>
                </tr>
                </c:forEach>
            </tbody>
        </table>
    </div><!-- //ListViewWrap -->
    <!-- paging -->
    <div class="paging">
        <ui:pagination name="pageHolder" url="/company/recruit/notice" parameters="srchGbn,srchKeyword,boardseq"/>
    </div>
    <!-- //paging -->
    <!-- search -->
    <form method="post" action="/company/recruit/notice" onsubmit="return true" name="frmSearch" id="frmSearch">
        <div class="searchWrap">
            <p>
                <select name="srchGbn" title="전체 제목 내요 선택">
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