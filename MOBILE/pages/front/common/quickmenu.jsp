<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="none"/>
<c:if test="${not empty listMyQuick}">
<script type="text/javascript">
var scroll = $(window).scrollTop();
var actYn = "N";
$(window).scroll(function() {
    /*
    if(!$("#ly_quick").hasClass("none")){
        if ($(window).scrollTop() - 10 > scroll && actYn == "N") {
            actYn = "Y";
            $("#ly_quick").animate({bottom:"-70px"}, 500, function(){ actYn = "N";});
        } else if($(window).scrollTop() <= scroll && actYn == "N") {
            actYn = "Y";
            $("#ly_quick").animate({bottom:0}, 1000, function(){ actYn = "N";});
        }
        scroll = $(window).scrollTop();
    }
    */
    $("#ly_quick").css("bottom", 0);
});

$("#ly_recent").click(function(e){
    if(!$("#recent_box").has(e.target).length){
        closeRecent();
    }
});
</script>
<div id="ly_quick">
    <div class="my_quick_box">
        <c:forEach items="${listMyQuick}" var="l" varStatus="st">
            <a href="#" class="${l.quickId} ic_quick" onclick="location.href='${l.linkUrl}';return false;">
                <span class="txt">${l.quickTitle}</span>
                <c:choose>
                    <c:when test="${l.altCnt > 99}"><span class="alt_cnt">99+</span></c:when>
                    <c:when test="${l.altCnt > 0}"><span class="alt_cnt">${l.altCnt}</span></c:when>
                </c:choose>
            </a>
        </c:forEach>
    </div>
    <a href="#" onclick="openRecent();return false;" class="ic_recent MB_RECENT">
        <c:choose>
            <c:when test="${not empty listRecent}">
                <c:forEach items="${listRecent}" var="l" varStatus="st" end="0">
                    <c:if test="${l.sellPrdtGbn ne 'R' && l.sellPrdtGbn ne 'D'}"><ui:image src="${l.productImageUrl}" server="product" size="150" ssl="${pageContext.request.scheme eq 'http'?'N':'Y'}"/></c:if>
                    <c:if test="${l.sellPrdtGbn eq 'R'}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="R" ratingCode="A" alt="${l.prdtName}" ssl="${pageContext.request.scheme eq 'http'?'N':'Y'}"/></c:if>
                    <c:if test="${l.sellPrdtGbn eq 'D'}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="D" ratingCode="A" alt="${l.prdtName}" ssl="${pageContext.request.scheme eq 'http'?'N':'Y'}"/></c:if>
                </c:forEach>
            </c:when>
            <c:otherwise><img src="${imageServer}/images/mobile/content/no_img03.jpg" alt="상품 없음"/></c:otherwise>
        </c:choose>
        <span class="txt">히스토리</span>
    </a>
</div>
<div id="ly_recent" class="ly_base"></div>
</c:if>