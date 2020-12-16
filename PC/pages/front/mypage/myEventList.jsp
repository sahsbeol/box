<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<html>
<head>
<title>참여이벤트 | 쇼핑도우미 | MY HOTTRACKS - HOTTRACKS</title>
</head>
<body>
<!-- sub top -->
<div class="page_location">
    <h2 class="title"><img src="${imageServer}/images/renewal/common/tit_my_hottracks.gif" alt="My Hottracks"/></h2>
    <div class="loc"><a href="/" class="home">Home</a><em>MY HOTTRACKS</em></div>
</div>
<!-- //sub top -->

<c:import url="/menu/mypage/lnb"/>

<!-- sub contents -->
<div class="sub_contents">
    
    <h3 class="page_title mgt0"><img src="${imageServer}/images/renewal/common/tit_event_list.gif" alt="이벤트 참여 내역" /></h3>
    <ul class="list_type02">
        <li>참여하신 이벤트에 대하여 편리하게 보실 수 있습니다.</li>
        <li>당첨되신분은 반드시 당첨자 확인대기를 클릭하여 정보를 입력해야만 혜택을 받으실 수 있습니다.</li>
    </ul>
    
    <div class="tbl_desc mgt50">현재 <em>${progressEventCount}</em> 건의 이벤트에 참여중입니다.</div>
    <table class="bbs_list01">
        <caption>이벤트 참여 내역 <span>참여일자, 이벤트명, 당첨자발표, 진행여부</span></caption>
        <colgroup>
            <col style="width:100px" />
            <col style="width:*" />
            <col style="width:90px" />
            <col style="width:100px" />
        </colgroup>
        <thead>
            <tr>
                <th scope="col" class="fir">참여일자</th>
                <th scope="col">이벤트명</th>
                <th scope="col">당첨자발표</th>
                <th scope="col" class="last">진행여부</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${eventEnterDataList}" var="l" varStatus="st">
                <tr>
                    <td><fmt:formatDate value="${l.regstDtm}" pattern="yyyy.MM.dd"/></td>
                    <td class="t_left"><a href="/ht/biz/eventDetail?eventId=${l.eventId}" target="_blank" title="새창에서 열림">${l.eventTitle}</a></td>
                    <td>
                        <c:choose>
                            <c:when test="${l.eventStatus eq 'progress'}">
                                <c:if test="${empty l.userNum}"><!-- 발표준비중 -->
                                    <p><ui:mask pattern="####.##.##">${l.announcingWinnerDate}</ui:mask></p>
                                </c:if>
                                <c:if test="${!empty l.userNum && !empty loginUser && !empty loginUser.address}"><!-- 당첨 -->
                                    <p class="btn_type01">당첨</p>
                                </c:if>
                                <c:if test="${!empty l.userNum && (empty loginUser || empty loginUser.address)}"><!-- 당첨/배송준비 -->
                                    <p class="btn_type01">당첨</p>
                                    <p class="btn_type02 mgt5"><a href="javascript:goModifyMemInfo();">회원정보수정</a></p>
                                </c:if>
                             </c:when>
                            <c:when test="${l.eventStatus eq 'win'}">
                                <c:if test="${!empty loginUser && !empty loginUser.address}"><!-- win -->
                                    <p class="btn_type01">당첨</p>
                                </c:if>
                                <c:if test="${empty loginUser || empty loginUser.address}"><!-- expert-destination -->
                                    <p class="btn_type01">당첨</p>
                                    <p class="btn_type02 mgt5"><a href="javascript:goModifyMemInfo();">회원정보수정</a></p>
                                </c:if>
                            </c:when>
                            <c:when test="${l.eventStatus eq 'progress'}"><!-- standby -->
                                <p><ui:mask pattern="####.##.##">${l.announcingWinnerDate}</ui:mask></p>
                            </c:when>
                            <c:otherwise><!-- next-chance -->
                                <p>${l.announcementYn?'다음 기회에':'발표준비중'}</p>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td class="center">${l.eventStatus eq 'progress'?'진행중':'마감'}</td>
                </tr>
            </c:forEach>
            <c:if test="${empty eventEnterDataList}"><tr><td colspan="4" class="no_data">이벤트 참여 내역이 없습니다.</td></tr></c:if>
        </tbody>
    </table>
    <!-- paging -->
    <div class="paging">
        <ui:pagination url="/ht/mypage/myEventList" name="pageHolder" />
    </div>
    <!-- //paging -->

</div>
<!-- //sub contents -->
</body>
</html>