<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="record"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>주요 레이블 안내 | 수입음반 입고안내 | CD - HOTTRACKS</title>
<script type="text/javascript">
//통합 검색
function goSearchLable(searchTerm, searchMenu, subMenu, menuGroup) {
    //if(!serviceCheck()){
        document.location.href="/ht/search/searchMain?searchTerm="+searchTerm+"&searchMenu="+searchMenu+"&subMenu="+subMenu+"&menuGroup="+menuGroup;
    //}
}
</script>
</head>
<body>
<div id="container">
    <!-- music 현재 페이지 위치 소스 입니다 -->
    <div class="page_music">
        <div class="page-location">
            <p class="title"><img src="${imageServer}/images/music/title_music_s14.gif" alt="음반 레이블 가이드" /></p>
            <ul>
                <li><a href="/">홈</a> <span>&gt;</span></li>
                <li><a href="<ui:recordConstants key="url_record_main" />">음반</a> <span>&gt;</span></li>
                <li><a href="/ht/record/lableStockedList">수입음반 입고안내</a> <span>&gt;</span></li> 
                <li><strong>주요 레이블 안내</strong></li>
            </ul> 
        </div>
    </div>
    <!-- //music 현재 페이지 위치 소스 입니다 --> 
  
    <!-- snb -->
    <div class="snb_mnew"> 
        <div class="snb_music">
            <ul>
                <li><a href="/ht/record/lableStockedList">레이블 입고 안내</a></li> 
                <li class="on"><a href="/ht/record/labelInfo">주요 레이블 안내</a></li>  
            </ul>
        </div>    
    </div>
    <!-- //snb --> 
    
    <!-- music -->
    <div id="music">
        <div class="contents">
            <div class="stitle">
                <h3>주요 레이블 안내</h3>
            </div>
            <div class="label_guide">
                <div class="atoz">
                    <ul>
                        <c:forEach var="i" begin="0" end="26">
                            <li class="${c.engLowerSearchs[i]}"><a href="/ht/record/labelAllView?searchIndex=${i}">${c.engSearchs[i]}</a></li>
                        </c:forEach>
                    </ul>
                </div>
                <div class="label">
                    <div class="alphabet">
                        <p><img src="${imageServer}/images/brand/text_big_en<c:if test="${c.searchIndex <9}">0</c:if>${c.searchIndex+1}.gif" alt="${c.engLowerSearchs[c.searchIndex]}" /></p>
                    </div>
                    <c:forEach var="i" begin="1" end="3">
                        <ul class="m_list">
                            <c:forEach var="j" begin="${(i -1)*10}" end="${(i*10)-1}">
                                <c:if test="${j < lastIndexNumber}">
                                    <li><a href="javascript:goSearchLable('${labelList[j].name}', 'LABEL_NAME', '', 'RECORD')">${labelList[j].name}</a></li>
                                </c:if>
                            </c:forEach>
                        </ul>
                    </c:forEach>
                </div>
                <div class="pager bor_none"><ui:pagination name="pageHolder" url="?" parameters="searchIndex"/></div>  
                
            </div>
        </div>
    </div>
    <!-- //music --> 
</div>
</body>
</html>