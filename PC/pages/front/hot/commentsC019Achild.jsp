<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="none" />
<ul>
    <c:forEach items="${list}" var="child">
        <li>
            <div class="comment_item">
                <p class="date">
                    <strong><ui:idAsterisk value="${child.userId}"/></strong>
                    <fmt:formatDate value="${child.registDatetime}" pattern="yyyy-MM-dd"/>
                    <c:if test="${child.userNum == loginUser.num}">
                        <a href="javascript://" onclick="deleteChildComment('${child.sequence}', '${criteria.parntCmntSeq}')" class="btn_del">삭제</a>
                    </c:if>
                </p>
                <p class="txt">${child.eventComment}</p>
            </div>
        </li>
    </c:forEach>
</ul>
<div class="comment_inbox">
    <span class="arrow"></span>
    <form name="eventCommentForm${criteria.parntCmntSeq}" method="post" onsubmit="return false">
        <div class="inner">
            <p class="wrtor"><ui:idAsterisk value="${loginUser.id}"/></p>
                <input type="hidden" value="${criteria.parntCmntSeq}" name="parntCmntSeq"/>
                <input type="hidden" value="${criteria.eventId}" name="eventId"/>
                <textarea name="eventComment" cols="10" rows="10" title="코멘트입력" id="eventComment${criteria.parntCmntSeq}" onkeydown="checkLength('#eventComment${criteria.parntCmntSeq}', '#chkByte${criteria.parntCmntSeq}', 250)"></textarea>
            <p class="txt_cnt"><strong id="chkByte${criteria.parntCmntSeq}">0</strong>/250</p>
        </div>
        <button onclick="saveChild('${criteria.parntCmntSeq}')">등록</button>
    </form>
</div><!-- //comment-box -->
<div class="paging">
    <ui:paginationScript name="pageHolder" scriptName="loadChildComment" parameters="eventId,parntCmntSeq"/>
</div><!-- end pager -->
