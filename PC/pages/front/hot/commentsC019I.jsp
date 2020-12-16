<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="none" />
<div class="comment_area">
    <p class="txt_total"> 총 ${cmntCnt}건의 COMMENT가 있습니다.</p>
    <div class="comment_box">
        <div class="inner">
            <form name="eventCommentForm" method="post" onsubmit="return false">
                <c:choose>
                    <c:when test="${not empty param.eventId }"><input type="hidden" value="${param.eventId}" name="eventId"/></c:when>
                    <c:otherwise><input type="hidden" value="${criteria.eventId}" name="eventId"/></c:otherwise>
                </c:choose>
                <input type="hidden" name="emtcId"/>
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
                <col width="120px">
            </colgroup>
            <tbody>
                <c:forEach items="${comments}" var="comment" varStatus="status">
                    <tr>
                        <td class="num">${cmntCnt - (pageHolder.startNumber + status.index - 1)}</td>
                        <td class="txt">
                            <c:choose>
                                <c:when test="${comment.dispStarYn eq 'Y' && comment.userNum != loginUser.num}">
                                    ***********************************************
                                </c:when>
                                <c:otherwise>${comment.eventComment}</c:otherwise>
                            </c:choose>
                        </td>
                        <td class="date">
                            <c:if test="${comment.eventId != '38071'}">
                            <strong><ui:idAsterisk value="${comment.userId}"/></strong>
                            </c:if>
                            <fmt:formatDate value="${comment.registDatetime}" pattern="yyyy-MM-dd"/>
                            <c:if test="${comment.userNum == loginUser.num}">
                                <br/> 
                                <a href="javascript://" onclick="deleteComment(${comment.sequence})" class="btn_type01">삭제</a>
                            </c:if></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div><!-- end comment-list -->
    <div class="paging mgt40">
        <ui:paginationScript name="pageHolder" scriptName="goCommentList" parameters="eventId"/>
    </div><!-- end pager -->
</div>