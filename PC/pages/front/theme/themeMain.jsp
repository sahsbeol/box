<%@ page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>a
<html>
<head>
<script type="text/javascript">
function chkMdsPick(idx){
    $(".mds_pick .tit ul li.on").removeClass("on");
    $(".mds_pick .prod_list.on").removeClass("on");
    $(".mds_pick .tit ul li:eq("+(idx-1)+")").addClass("on");
    $(".mds_pick .prod_list:eq("+(idx-1)+")").addClass("on");
}
</script>
</head>
<body>
        <div id="diay_right">
            <p class="main_banner">
                <c:forEach items="${listMain}" var="l" varStatus="st">
                    <ui:banner bnrLinkUrl="${l.bnrLinkUrl}" bannerImageUrl="${l.bnrImageUrl}" bnrTgtGbn="${l.bnrTgtGbn}" bnrSeq="${l.bnrSeq}" newWdwYn="${l.bnrNewWdwYn}" width="755px" height="470px"/>
                </c:forEach>
            </p>
            <div class="mds_pick">
                <div class="tit">
                    <h3><img src="${imageServer}/images/theme/tit_mdspick.gif" alt="Md's Pick" /></h3>
                    <ul>
                        <c:forEach items="${listMdPick}" var="l" varStatus="st">
                            <c:if test="${not empty listMdPick1 and l.groupId eq '1' and l.dispOrder eq '0'}"><li class="on" onmouseover="chkMdsPick('${l.groupId}')">${l.dispTitle}</li></c:if>
                            <c:if test="${not empty listMdPick2 and l.groupId eq '2' and l.dispOrder eq '0'}"><li onmouseover="chkMdsPick('${l.groupId}')">${l.dispTitle}</li></c:if>
                            <c:if test="${not empty listMdPick3 and l.groupId eq '3' and l.dispOrder eq '0'}"><li onmouseover="chkMdsPick('${l.groupId}')">${l.dispTitle}</li></c:if>
                        </c:forEach>
                    </ul>
                </div>
                <c:forEach begin="0" end="2" varStatus="s1">
                    <c:if test="${s1.index eq 0}"><c:set var="list" value="${listMdPick1}"/></c:if>
                    <c:if test="${s1.index eq 1}"><c:set var="list" value="${listMdPick2}"/></c:if>
                    <c:if test="${s1.index eq 2}"><c:set var="list" value="${listMdPick3}"/></c:if>
                    <c:if test="${not empty list}">
                        <ul class="prod_list ${s1.first?'on':''}">
                            <c:forEach items="${list}" var="l" varStatus="st" begin="1" end="8">
                                <li>
                                    <p class="img">
                                        <c:if test="${l.sellPrdtGbn eq 'P' or l.sellPrdtGbn eq 'G'}"><a href="/p/${l.sellPrdtBcode}"><ui:image src="${l.prdtImageUrl}" server="product" size="120"/></a></c:if>
                                        <c:if test="${l.sellPrdtGbn eq 'R'}"><a href="/p/${l.sellPrdtBcode}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" ratingCode="A" width="120" /></a></c:if>
                                        <c:if test="${l.sellPrdtGbn eq 'D'}"><a href="/p/${l.sellPrdtBcode}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" ratingCode="A" width="79" /></a></c:if>
                                    </p>
                                    <p class="name"><a href="/p/${l.sellPrdtBcode}">${l.prdtName}</a></p>
                                    <p class="price"><fmt:formatNumber type="number">${l.lastCpnPrice}</fmt:formatNumber></strong>
                                </li>
                            </c:forEach>
                        </ul>
                    </c:if>
                </c:forEach>
            </div>
            <div class="hot_event">
                <h3><img src="${imageServer}/images/theme/tit_hotevent.gif" alt="Hot Event" /></h3>
                <c:forEach items="${listEvent}" varStatus="s1" step="3">
                    <ul class="event_list ${s1.last?'last':''}">
                        <c:forEach items="${listEvent}" var="l" varStatus="st" begin="${s1.index}" end="${s1.index+2}">
                            <li><ui:banner bnrLinkUrl="${l.bnrLinkUrl}" bannerImageUrl="${l.bnrImageUrl}" bnrTgtGbn="${l.bnrTgtGbn}" bnrSeq="${l.bnrSeq}" newWdwYn="${l.bnrNewWdwYn}" width="200px" height="210px"/></li>
                        </c:forEach>
                    </ul>
                </c:forEach>
            </div>
        </div>
</body>
</html>