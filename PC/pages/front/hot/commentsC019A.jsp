<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="none" />
<div class="type-d">
    <input type="hidden" name="cmntPage" value="${criteria.page}"/>
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
        <p class="txt_total">총 <span class="c_orange"><fmt:formatNumber type="number">${cmntCnt}</fmt:formatNumber></span>건의 COMMENT가 있습니다.</p>
        <p class="btn_order">
            <a href="javascript://" onclick="changeOrder('regDtmDesc')" <c:if test="${empty criteria.orderBy || criteria.orderBy eq 'regDtmDesc'}"> class="active"</c:if>>최신순</a>
            <a href="javascript://" onclick="changeOrder('likeCntDesc')" <c:if test="${criteria.orderBy eq 'likeCntDesc'}"> class="active"</c:if>>좋아요순</a>
        </p>
        <ul>
            <c:forEach items="${comments}" var="comment" varStatus="status">
                <li>
                    <div class="comment_item">
                        <td class="num">${cmntCnt - (pageHolder.startNumber + status.index - 1)}</td>
                        <p class="date">
                            <strong><ui:idAsterisk value="${comment.userId}"/></strong>
                            <fmt:formatDate value="${comment.registDatetime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                            <c:if test="${comment.userNum == loginUser.num}">
                                <a href="javascript://" onclick="deleteComment(${comment.sequence})" class="btn_del">삭제</a>
                            </c:if>
                        </p>
                        <p class="txt">${comment.eventComment}</p>
                        <p class="btn_area">
                            <span class="btn_box" id="btnChildCmnt${comment.sequence}"><a href="javascript://" onclick="toggleChildComment('${comment.sequence}')" class="btn_cmnt"><fmt:formatNumber type="number">${comment.childCnt}</fmt:formatNumber></a></span>
                            <span class="btn_box"><a href="javascript://" onclick="likeComment('${comment.sequence}')" class="btn_like"><fmt:formatNumber type="number">${comment.likeCnt}</fmt:formatNumber></a></span>
                        </p>
                    </div>
                    <div class="comment_inlist" id="childComment${comment.sequence}"></div>
                </li>
            </c:forEach>
        </ul>
    </div><!-- end comment-list -->
    <div class="paging mgt40">
        <ui:paginationScript name="pageHolder" scriptName="goCommentList" parameters="eventId"/>
    </div><!-- end pager -->
</div>