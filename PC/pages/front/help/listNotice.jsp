<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
<title>공지사항 | 공지/문의 | 고객센터 - HOTTRACKS</title>
<script type="text/javascript">
jQuery(function($) {
    $("tbody tr td a.click").click(function(event) {
        event.preventDefault(); // # 링크 이동 중지
        
        var selectHref = $(this).attr("href");
        if($(selectHref).hasClass("on")){
            $(selectHref).removeClass("on");
        }else{
            $(selectHref).addClass("on");
            
            var seq = $(this).siblings("input").val();
            //setHit
            $.ajax({
                type: "GET"
                ,url: "/ht/help/listNotice/updateHit"
                ,dataType: "html"
                ,data:{notiSeq:seq}
            });  
        }
    });
    
    $("#${userNoticeCriteria.notiSeq}").click();
    
    $(".bbs_list01 img").each(function(){
        $(this).css("max-width", "100%");
    });
});
</script>
</head>
<body>
<!-- sub top -->
<div class="page_location">
    <h2 class="title"><img src="${imageServer}/images/renewal/common/tit_cs_center.gif" alt="CS Center"/></h2>
    <div class="loc"><a href="/" class="home">Home</a><em>공지사항</em></div>
</div>
<!-- //sub top -->

<c:import url="/menu/help/lnb"/>

<!-- sub contents -->
<div class="sub_contents">
    <!-- h3 class="page_title mgt0"><img src="${imageServer}/images/renewal/common/tit_notice.gif" alt="공지사항" /></h3 -->
    <div class="page_stitle">
        <a href="/ht/help/listNotice"><img src="${imageServer}/images/renewal/content/txt_notice_on.gif" alt="공지사항" /></a>
        <a href="/ht/help/eventPrizeList"><img src="${imageServer}/images/renewal/content/txt_event_off.gif" alt="이벤트 당첨자" /></a>
    </div>
    <ul class="list_type02">
        <li>핫트랙스에서 고객 여러분께 유익한 쇼핑 정보를 알려드립니다.</li>
    </ul>

    <!-- 
    <div class="tab1">
        <ul>
            <li><a href="/ht/help/listNotice" class="${userNoticeCriteria.brandOrCategory ne 'B'?'on':'off'}"><span>핫트랙스공지사항</span></a></li>
            <li><a href="/ht/help/listNotice?brandOrCategory=B" class="${userNoticeCriteria.brandOrCategory eq 'B'?'on':'off'}"><span>브랜드공지사항</span></a></li>
        </ul>
    </div>
    -->

    <table class="bbs_list01 mgt30 tbl_slide" summary="핫트랙스 공지사항의 번호, 제목, 등록일, 조회 항목이 있습니다">
        <caption>핫트랙스 공지사항</caption>
        <colgroup>
            <col width="80" />
            <col width="*" />
            <col width="100" />
        </colgroup>
        <thead>
            <tr>
                <th scope="col" class="fir">번호</th>
                <th scope="col">제목</th>
                <th scope="col" class="last">등록일</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${list}" var="userNoticeDto" varStatus="st">
                <tr> 
                    <td>${pageHolder.lastIndexNumber - st.index}</td>
                    <td class="t_left">
                        <input type="hidden" value="${userNoticeDto.notiSeq}"/>
                        <a href="#list-content${userNoticeDto.notiSeq}" id="${userNoticeDto.notiSeq}" class="click">
                            <c:if test="${!empty userNoticeDto.brandId && userNoticeDto.brandOrCategory eq 'B'}">[${userNoticeDto.brandName}]</c:if>
                            <c:if test="${empty userNoticeDto.brandId && userNoticeDto.brandOrCategory eq 'B'}">[전체]</c:if>
                            ${userNoticeDto.title}
                            <c:if test="${userNoticeDto.newYn eq 'Y'}"><img src="${imageServer}/images/renewal/content/ic_new.gif" alt="NEW" style="vertical-align:baseline;margin-left:5px;"/></c:if>
                        </a>
                    </td>
                    <td><fmt:formatDate value="${userNoticeDto.registrationDate}" pattern="yyyy.MM.dd"></fmt:formatDate></td>  
                </tr> 
                <tr class="conts" id="list-content${userNoticeDto.notiSeq}">  
                    <td colspan="3">
                        <div class="txt">
                            ${userNoticeDto.content}
                            <c:if test="${not empty userNoticeDto.linkUrl}"><a href="${userNoticeDto.linkUrl}" target="_blank">${userNoticeDto.linkUrl}</a></c:if> 
                        </div>
                    </td>  
                </tr>
            </c:forEach>
            <c:if test="${empty list && empty title}"><tr><td colspan="3" class="no_data">등록된 공지사항이 없습니다.</td></tr></c:if>
        </tbody>
    </table>
    <!-- paging -->
    <div class="paging mgt40">
        <ui:pagination name="pageHolder" url="/ht/help/listNotice" parameters="title,categoryId,page,brandOrCategory,brandId"/>
    </div>
    <!-- //paging -->
</div>
<!-- //sub contents -->
</body>
</html>