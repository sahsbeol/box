<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="none"/>
<div id="recent_box">
    <h5 class="tit">최근 본 상품</h5>
    <div class="rcnt_btn_area type01">
        <a href="#" onclick="Fn_rcntChangMode('Y');return false;">선택</a>
        <a href="#" onclick="Fn_rcntChangMode('A');return false;">전체선택</a>
        <a href="${defaultHost}/m/mypage/wishProduct" class="btn_go"><img src="${imageServer}/images/mobile/content/ico_list.png"/> 좋아요</a>
    </div>
    <div class="rcnt_btn_area type02">
        <a href="#" onclick="Fn_rcntChangMode('N');return false;">취소</a>
        <a href="#" onclick="Fn_rcntItemLike();return false;"><img src="${imageServer}/images/mobile/content/ico_like02.png"/> 좋아요</a>
        <a href="#" onclick="Fn_rcntItemDel();return false;" class="btn_del">삭제</a>
    </div>
    <div class="prod_basic05">
        <c:forEach items="${listRecentProduct}" var="l" varStatus="st">
            <a href="#" onclick="Fn_rcntItemClick('${l.sellPrdtBcode}');return false;" id="rcntProd${l.sellPrdtBcode}">
                <input type="hidden" name="sellPrdtBcode" value="${l.sellPrdtBcode}"/>
                <c:if test="${l.sellPrdtGbn ne 'R' && l.sellPrdtGbn ne 'D'}"><p class="pic"><ui:image src="${l.productImageUrl}" server="product" size="150" ssl="${pageContext.request.scheme eq 'http'?'N':'Y'}"/></p></c:if>
                <c:if test="${l.sellPrdtGbn eq 'R'}"><p class="pic"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="R" ratingCode="A" alt="${l.prdtName}" ssl="${pageContext.request.scheme eq 'http'?'N':'Y'}"/></p></c:if>
                <c:if test="${l.sellPrdtGbn eq 'D'}"><p class="pic dvd"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="D" ratingCode="A" alt="${l.prdtName}" ssl="${pageContext.request.scheme eq 'http'?'N':'Y'}"/></p></c:if>
                <em class="chk">상품체크</em>
            </a>
        </c:forEach>
        <hr class="hr"/>
    </div>
</div>