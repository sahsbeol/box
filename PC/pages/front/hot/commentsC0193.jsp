<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="none" />
<p class="txt_total"> 총 ${cmntCnt}건의 COMMENT가 있습니다.</p>
<div class="comment_box">
    <div class="inner">
        <form name="eventCommentForm" method="post" onsubmit="return false">
            <input type="hidden" value="${criteria.eventId}" name="eventId"/>
            <textarea name="eventComment" cols="10" rows="10" title="코멘트입력" onkeydown="preValidation()"></textarea>
            <button onclick="save()">등록</button>
        </form>
    </div>
</div><!-- //comment-box -->
<div class="comment_list">
    <table summary="코멘트 목록">
        <caption>코멘트 목록</caption>
        <colgroup>
            <col width="80px">
            <col width="*">
            <col width="150px">
            <col width="120px">
        </colgroup>
        <tbody>
            <c:forEach items="${comments}" var="comment" varStatus="status">
                <tr>
                    <td class="num">${cmntCnt - (pageHolder.startNumber + status.index - 1)}</td>
                    <td class="txt">${comment.eventComment}</td>
                    <td class="t_center"><c:if test="${comment.entryYn}"><ui:image width="50" src="${comment.eventIconUrl}" alt="아이콘"/></c:if></td>
                    <td class="date">
                        <strong><ui:idAsterisk value="${comment.userId}"/></strong>
                        <fmt:formatDate value="${comment.registDatetime}" pattern="yyyy-MM-dd"/>
                        <c:if test="${comment.userNum == loginUser.num}"> 
                            <a href="javascript://" onclick="deleteComment(${comment.sequence})"><img src="${imageServer}/images/event/btn_x.gif" alt="삭제" /></a>
                        </c:if></td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div><!-- end comment-list -->
<div class="paging mgt40">
    <ui:paginationScript name="pageHolder" scriptName="goCommentList" parameters="eventId"/>
</div><!-- end pager -->
