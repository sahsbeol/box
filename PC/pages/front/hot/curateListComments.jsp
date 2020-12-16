<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="none" />
<ul>
    <c:forEach items="${commentList}" var="child">
        <li>
            <div class="comment_item">
                <p class="date">
                    <strong><ui:idAsterisk value="${child.userId}"/></strong>
                    <fmt:formatDate value="${child.regstDtm}" pattern="yyyy-MM-dd"/>
                    <c:if test="${child.userNum eq loginUser.num}">
                        <a href="javascript://" onclick="deleteCurateComment('${child.crtCmntSeq}', '${child.crtSeq}')" class="btn_del">삭제</a>
                    </c:if>
                </p>
                <p class="txt">${child.cmnt}</p>
            </div>
        </li>
    </c:forEach>
</ul>
<div class="comment_inbox">
    <span class="arrow"></span>
    <form name="curateCommentFrm${commentCriteria.crtSeq}" method="post" onsubmit="return false">
        <div class="inner">
            <p class="wrtor"><ui:idAsterisk value="${loginUser.id}"/></p>
                <input type="hidden" name="crtSeq" value="${commentCriteria.crtSeq}"/>
                <textarea name="cmnt" cols="10" rows="10" title="코멘트입력" id="curateComment${commentCriteria.crtSeq}" onkeydown="checkLength('#curateComment${commentCriteria.crtSeq}', '#chkByte${commentCriteria.crtSeq}', 250)"></textarea>
            <p class="txt_cnt"><strong id="chkByte${commentCriteria.crtSeq}">0</strong>/250</p>
        </div>
        <button onclick="saveCurateComment('${commentCriteria.crtSeq}')">등록</button>
    </form>
</div><!-- //comment-box -->
<div class="paging">
    <ui:paginationScript name="pageHolder" scriptName="loadChildComment4Page" parameters="crtSeq"/>
</div><!-- end pager -->
