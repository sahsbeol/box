<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
<script type="text/javascript" src="/js/fn_htts_slide.js"></script>
<script  type="text/javascript">
jQuery(function($){
    $(document).ready(function(){
        slideDiv(".main_sec1", 6000, ".main_sec1");
    });
});
<c:forEach items="${listPopup}" var="l" varStatus="st">
if(getCookie("hottracks${l.boardseq}") != "yes"){//이미지높이보다 23 크게
    var top = 0 * parseInt("${st.count}");
    var left = 520 * parseInt("${st.count - 1}");
    var popup = window.open('/company/popup?boardseq=${l.boardseq}','_hottracks${l.boardseq}','width=500, height=423, top='+top+',left='+left+' ,toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no');
    popup.focus();
}
</c:forEach>
</script>
</head>
<body>
<div id="main_spot">
    <div class="main_sec1">
        <ul class="main_slide_btn slide_view">
            <c:forEach items="${listBnr01}" var="l" varStatus="st">
                <li class="main_slide_img"><ui:banner bannerImageUrl="${l.bnrImgUrl}" bnrLinkUrl="${l.bnrLnkUrl}" bnrSeq="${l.bnrSeq}" bnrTgtGbn="L" newWdwYn="${l.bnrNewWinYn}" alt="${l.bnrImgAlt}"/></li>
            </c:forEach>
        </ul>
        <ul class="main_slide_navi">
            <c:forEach items="${listBnr01}" var="l" varStatus="st">
                <li class="slide_navi ${st.first?'active':''}"><a href="javascript://"><img src="${imageServer}/images/common/ic_navi0${st.count}.png"/></a></li>
            </c:forEach>
            <!-- 
            <li class="slide_ctrl">
                <a class="stop" href="javascript://">일시정지</a>
            </li>
            -->
        </ul>
    </div>
</div>
<div id="main-bottom-banner">
    <div id="main-event-banner" class="main-bottom-item">
        <h3><a href="/company/story/event">행사안내</a></h3>
        <ul class="list_dot_gray">
            <c:if test="${empty listEvent}"><li>관련 게시물이 없습니다.</li></c:if>
            <c:forEach items="${listEvent}" var="l" varStatus="st" end="4">
                <li><a href="/company/story/eventView?boardseq=${l.boardseq}" title="${l.title}">${l.title}</a></li>
            </c:forEach>
        </ul>
        <em class="more"><a href="/company/story/event"><img src="http://image.hottracks.co.kr/info/btn/btn_more.png" alt="행사안내 더보기"/></a></em>
    </div>
    <div id="main-sign-banner" class="main-bottom-item">
        <h3><a href="/company/story/sign">사인회</a></h3>
        <ul class="list_dot_gray">
            <c:if test="${empty listSign}"><li><a href="javascript://">관련 게시물이 없습니다.</a></li></c:if>
            <c:forEach items="${listSign}" var="l" varStatus="st" end="4">
                <li><a href="/company/story/signView?boardseq=${l.boardseq}" title="${l.title}">${l.title }</a></li>
            </c:forEach>
        </ul>
        <em class="more"><a href="/company/story/sign"><img src="http://image.hottracks.co.kr/info/btn/btn_more.png" alt="사인회 더보기"/></a></em>
    </div>
    <div id="main-notice-banner" class="main-bottom-item">
        <h3><a href="/company/story/notice">${mstBnr02.title}</a></h3>
        <c:if test="${empty listBnr02}"><ul class="list_dot_gray"><li><a href="javascript://">관련 게시물이 없습니다.</a></li></ul></c:if>
        <c:forEach items="${listBnr02}" var="l" varStatus="st">
            <p class="main_banner"><ui:banner bannerImageUrl="${l.bnrImgUrl}" bnrLinkUrl="${l.bnrLnkUrl}" bnrSeq="${l.bnrSeq}" bnrTgtGbn="L" newWdwYn="${l.bnrNewWinYn}" alt="${l.bnrImgAlt}"/></p>
        </c:forEach>
        <em class="more"><a href="/company/story/notice"><img src="http://image.hottracks.co.kr/info/btn/btn_more.png" alt="공지사항 더보기"/></a></em>
    </div>
    <div id="main-music-banner" class="main-bottom-item">
        <h3><a href="/company/story/event">${mstBnr03.title}</a></h3>
        <c:if test="${empty listBnr03}"><ul class="list_dot_gray"><li><a href="javascript://">관련 게시물이 없습니다.</a></li></ul></c:if>
        <c:forEach items="${listBnr03}" var="l" varStatus="st">
            <p class="main_banner"><ui:banner bannerImageUrl="${l.bnrImgUrl}" bnrLinkUrl="${l.bnrLnkUrl}" bnrSeq="${l.bnrSeq}" bnrTgtGbn="L" newWdwYn="${l.bnrNewWinYn}" alt="${l.bnrImgAlt}"/></p>
        </c:forEach>
    </div>
    <div id="main-etc-banner" class="main-bottom-item">
        <ul>
            <li class="mgt20"><a href="https://www.facebook.com/HOTTRACKSFRIEND/" target="_blank"><img src="${imageServer}/images/company/btn_main_facebook.png" alt="페이스북"/></a></li>
            <li class="mgt15"><a href="https://twitter.com/HOTTRACKSFRIEND" target="_blank"><img src="${imageServer}/images/company/btn_main_twitter.png" alt="트위터"/></a></li>
            <li class="mgt15"><a href="https://www.instagram.com/hottracks_official/" target="_blank"><img src="${imageServer}/images/company/btn_main_instagram.jpg" alt="인스타그램"/></a></li>
            <li class="mgt15"><a href="http://blog.naver.com/story1917" target="_blank"><img src="${imageServer}/images/company/btn_main_blog.jpg" alt="네이버블로그"/></a></li>
        </ul>
    </div>
</div>
</body>
</html>