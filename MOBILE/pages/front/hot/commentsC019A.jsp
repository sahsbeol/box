<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="none" />
<hr class="hr_01"/>
<div class="commnt_write">
    <strong class="amount">총 <span class="col_orange"><fmt:formatNumber type="number" value="${cmntCnt}"/>개</span>의 댓글이 있습니다.</strong>
    <form name="eventCommentForm" method="post" onsubmit="return false">
        <div class="textarea_box">
            <input type="hidden" value="${c.eventId}" name="eventId"/>
            <input type="hidden" name="emtcId"/>
            <textarea class="textarea" name="cmnt" title="댓글 입력" style="height:100px;" onclick="preValidation()" placeHolder="내용을 입력하세요."></textarea>
        </div>
        <p class="info mt5">
            ※ 로그인 후 글을 남길 수 있습니다.
            <a href="javascript:save()" class="btn btn_type01 bg_orange fl_r">등록</a>
        </p>
    </form>
</div>

<p class="btn_order">
    <a href="javascript://" onclick="changeOrder('regDtmDesc')" <c:if test="${empty criteria.orderBy || criteria.orderBy eq 'regDtmDesc'}"> class="active"</c:if>>최신순</a>
    <a href="javascript://" onclick="changeOrder('likeCntDesc')" <c:if test="${criteria.orderBy eq 'likeCntDesc'}"> class="active"</c:if>>좋아요순</a>
</p>

<ul class="commnt_list">
    <c:forEach items="${comments}" var="comment" varStatus="status">
        <li>
            <span class="num">${cmntCnt - (pageHolder.startNumber + status.index - 1)}</span>
            <p>${comment.cmnt}</p>
            <div class="info">
                <span class="writer"><ui:idAsterisk value="${comment.userId}"/></span>|  
                <span class="date"><fmt:formatDate value="${comment.regstDtm}" pattern="yyyy.MM.dd"/></span>
            </div>
            <span class="btn_del">
                <c:if test="${comment.userNum == loginUser.userNum}">
                    <a href="javascript://" onclick="deleteComment('${comment.eventCmntSeq}')"><img src="${imageServer}/images/mobile/common/btn_del01.gif"/></a>
                </c:if></td>
            </span>
            <p class="btn_area">
                <span class="btn_box" id="btnChildCmnt${comment.eventCmntSeq}"><a href="javascript://" onclick="toggleChildComment('${comment.eventCmntSeq}')" class="btn_cmnt"><fmt:formatNumber type="number">${comment.childCnt}</fmt:formatNumber></a></span>
                <span class="btn_box"><a href="javascript://" onclick="likeComment('${comment.eventCmntSeq}')" class="btn_like"><fmt:formatNumber type="number">${comment.likeCnt}</fmt:formatNumber></a></span>
            </p>
            <div class="comment_inlist" id="childComment${comment.eventCmntSeq}"></div>
        </li>
    </c:forEach>
</ul>

<!-- paging -->
<div class="paging mb30">
    <ui:paginationScript name="pageHolder" scriptName="goCommentList" parameters="eventId"/>
</div>