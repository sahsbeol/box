<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<html>
<head>
<script type="text/javascript">
function goList(page){
    location.href="/m/record/best/${c.ctgrId}?bestRangeType=${c.bestRangeType}&page="+page;
}
</script>
</head>
<body>
<input type="hidden" name="eof" value="1"/>
<!-- 정렬 -->
<div class="box_flex t_select">
    <select class="select" title="정렬 순서 선택" name="ctgrId" onchange="location.href='/m/record/best/'+this.value+'?bestRangeType=${c.bestRangeType}';">
        <c:forEach items="${categoryListLeft}" var="l">
            <option value="${l.ctgrId}"<c:if test="${c.ctgrId eq l.ctgrId}"> selected="selected"</c:if>>${l.ctgrName}</option>
        </c:forEach>
    </select>
    <select class="select" title="베스트 기간 선택" name="bestRangeType" onchange="location.href='/m/record/best/${c.ctgrId}?bestRangeType='+this.value;">
        <option value="C1001"<c:if test="${c.bestRangeType eq 'C1001'}"> selected="selected"</c:if>>실시간 베스트</option>
        <option value="C1002"<c:if test="${c.bestRangeType eq 'C1002'}"> selected="selected"</c:if>>일간 베스트</option>
        <option value="C1003"<c:if test="${c.bestRangeType eq 'C1003'}"> selected="selected"</c:if>>주간 베스트</option>
        <option value="C1004"<c:if test="${c.bestRangeType eq 'C1004'}"> selected="selected"</c:if>>월간 베스트</option>
        <option value="C1005"<c:if test="${c.bestRangeType eq 'C1005'}"> selected="selected"</c:if>>년간 베스트</option>
    </select>
</div>
<!-- //정렬 -->

<!-- prod -->
<div class="prod_basic">
    <ul id="productList">
        <c:forEach items="${list}" varStatus="s1" step="2" end="9">
            <li>
                <c:forEach items="${list}" var="l" varStatus="st" begin="${s1.index}" end="${s1.index+1}">
                    <div style="width:46%;margin:0 2%;text-align:center;">
                        <a href="/p/${l.sellPrdtBcode}" title="${l.prdtName}">
                            <span class="best">BEST<strong>${l.rank}</strong></span>
                            <p class="pic<c:if test="${fn:substring(c.ctgrId,0,4) eq '0004'}"> dvd</c:if>"><ui:image prdtGbn="${l.sellPrdtGbn}" rcrdCd="${l.rcrdCd}" ratingCode="${l.rtngCode}" alt="${fn:escapeXml(l.prdtName)}"/></p>
                            <p class="brand t_l">${l.artiName}</p>
                            <p class="tit t_l">${l.commTitle}</p>
                            <p class="price t_l"><strong><fmt:formatNumber type="number">${l.lastCpnPrice}</fmt:formatNumber>원 <c:if test="${l.prdtSellPrice > l.lastCpnPrice}"><span class="sale">[${hfn:rate(l.prdtSellPrice,l.lastCpnPrice)}%]</span></c:if></strong></p>
                        </a>
                    </div>
                </c:forEach>
            </li>
        </c:forEach>
    </ul>
</div>
<!-- //prod -->
<!-- paging -->
<div class="paging">
    <ui:paginationScript name="pageHolder" scriptName="goList"/>
</div>
<!-- //paging -->
</body>
</html>