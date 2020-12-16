<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="htNoQuick"/>
<html>
<head>
<title>이벤트 당첨자 | 공지/문의 | 고객센터 - HOTTRACKS</title>
<script type="text/javascript">
jQuery(function($) {
    $("tbody tr td a.click").click(function(event) {
        event.preventDefault(); // # 링크 이동 중지
        
        var selectHref = $(this).attr("href");
        if($(selectHref).hasClass("on")){
            $(selectHref).removeClass("on");
        }else{
            $(selectHref).addClass("on");
        }
    });
});
</script>
</head>
<body>
<!-- sub top -->
<div class="page_location">
    <h2 class="title"><img src="${imageServer}/images/renewal/common/tit_cs_center.gif" alt="CS Center"/></h2>
    <div class="loc"><a href="#" class="home">Home</a><em>이벤트 당첨자</em></div>
</div>
<!-- //sub top -->

<c:import url="/menu/help/lnb"/>

<!-- sub contents -->
<div class="sub_contents">
    <!-- h3 class="page_title mgt0"><img src="${imageServer}/images/renewal/common/tit_event_prize.gif" alt="이벤트 당첨자" /></h3 -->
    <div class="page_stitle">
        <a href="/ht/help/listNotice"><img src="${imageServer}/images/renewal/content/txt_notice_off.gif" alt="공지사항" /></a>
        <a href="/ht/help/eventPrizeList"><img src="${imageServer}/images/renewal/content/txt_event_on.gif" alt="이벤트 당첨자" /></a>
    </div>
    <ul class="list_type02">
        <li>기프트, 음반, BLU-RAY/DVD 이벤트 당첨자를 알려드립니다</li>
    </ul>

    <table class="bbs_list01 mgt30" summary="이벤트 당첨자의 번호, 구분, 제목, 등록일 항목이 있습니다">
        <caption>이벤트 당첨자</caption>
        <colgroup>
            <col width="70" />
            <col width="120" />
            <col width="*" />
            <col width="100" />
        </colgroup>
        <thead>
            <tr>
                <th scope="col" class="fir">번호</th>
                <th scope="col">구분</th>
                <th scope="col">제목</th>
                <th scope="col" class="last">등록일</th>
            </tr>
        </thead>
        <tbody>
            <c:if test="${empty list}"><tr><td colspan="4" class="no_data">이벤트 당첨자가 없습니다.</td></tr></c:if>
            <c:forEach items="${list}" var="l" varStatus="st">
                <tr>
                    <td>${totalCnt - (pageHolder.startNumber + st.index - 1)}</td>
                    <td class="t_left"><ui:category id="${fn:substring(l.ctgrId,0,4)}" full="false"/></td>
                    <td class="t_left">
                        <a href="#list-content${l.eventId}" class="click">
                            ${l.eventTitle}
                            <c:if test="${l.newYn eq 'Y'}"><img src="${imageServer}/images/renewal/content/ic_new.gif" alt="NEW" style="vertical-align:baseline;margin-left:5px;"/></c:if>
                        </a>
                    </td>
                    <td><fmt:formatDate pattern="yyyy.MM.dd" value="${l.regstDtm}"></fmt:formatDate></td>
                </tr>
                <tr class="conts" id="list-content${l.eventId}">
                    <td colspan="4">
                        <div class="txt">
                            ${l.prizeCont}
                        </div>
                    </td>  
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <!-- paging -->
    <div class="paging mgt40">
        <ui:pagination name="pageHolder" url="?" parameters=""/>
    </div>
    <!-- //paging -->
</div>
<!-- //sub contents -->
</body>
</html>