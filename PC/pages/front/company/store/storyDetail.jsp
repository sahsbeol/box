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
<p class="cont_topBg_recruit"><img src="http://image.hottracks.co.kr/info/layout/bg_snb_shop.png" alt="핫트랙스 영업점의 여러가지 소식을 알려드립니다"/></p>
<c:import url="/company/store/lnb?deptcode=${c.deptcode}"/>
<!-- contents area -->
<div id="contents_area">
    <!-- location -->
    <div id="location">
        <h2>${store.deptname}</h2>
        <em class="location"><img src="http://image.hottracks.co.kr/info/icon/icon_home.png"  alt="홈"/> &gt; 영업점 &gt; ${store.deptname} &gt; <strong>${store.deptname}이야기</strong></em>
    </div>
    <!-- //location -->  
    
    <div class="table_view">
        <table summary="행사명, 진행영업점, 행사기간으로 구성 된 행사안내 상세보기" cellpadding="0" cellspacing="0">
            <caption>행사안내 상세보기</caption>
            <colgroup>
                <col width="113px" />
                <col width="287px" />
                <col width="113px" />
                <col width="*" />
            </colgroup>
            <tbody>
                <tr>
                    <th>제목</th>
                    <td colspan="3">${detail.title }</td>
                </tr>
                <tr>
                    <th>진행 영업점</th>
                    <td>${detail.deptnames}</td>
                    <th>등록일</th>
                    <td><c:if test="${not empty detail.registerdate}"><ui:mask pattern="####/##/##">${detail.registerdate}</ui:mask></c:if></td>
                </tr>
                <c:if test="${not empty bbsfile}">
                <tr>
                    <th>첨부파일</th>
                    <td colspan="3"><a href="#none" file="down" fileSeq="${bbsfile.fileseq }" boardseq="${detail.boardseq}">${detail.filename}</a></td>
                </tr>
                </c:if>
                <tr><td colspan="4" class="view_area"></td></tr>
            </tbody>
        </table>
        <p class="rightBtnView"><a href="/company/store/story?deptcode=${c.deptcode}&page=${c.page}&srchGbn=${c.srchGbn}&srchKeyword=${c.srchKeyword}" title="목록보기"><img src="http://image.hottracks.co.kr/info/btn/btn_pre_list.png" alt="목록보기"/></a></p>
    </div>
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
                    <td class="Tleft"><a href="/company/store/storyView?deptcode=${c.deptcode}&boardseq=${l.boardseq}" storylist="storylist" boardseq="${l.boardseq}">${l.title }</a><c:if test="${l.newYn eq 'Y'}"><img src="http://image.hottracks.co.kr/info/common/icon_new.png" alt="New" /></c:if></td>
                    <td><ui:mask pattern="####/##/##">${l.registerdate}</ui:mask></td>
                </tr>
                </c:forEach>
            </tbody>
        </table>
    </div><!-- //ListViewWrap -->
    <!-- paging -->
    <div class="paging">
        <ui:pagination name="pageHolder" url="/company/store/story" parameters="srchGbn,srchKeyword,deptcode,boardseq"/>
    </div>
    <!-- //paging -->
    <!-- search -->
    <form method="post" action="/company/store/story" onsubmit="return true" name="frmSearch" id="frmSearch">
        <input type="hidden" name="boardseq" value="${c.boardseq }" />
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