<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="none"/>
<ul class="best_tab tab_btn">
    <li><a href="#bb01" class="on"><span>BEST 1~5</span></a></li>
    <li><a href="#bb02"><span>BEST 6~10</span></a></li>
</ul>

<div class="prod_list tab_pannels">
    <c:forEach items="${realtimesHtts}" varStatus="s1" step="5" begin="0" end="9">
        <ul id="bb0${s1.count}" class="pannel" >
            <c:forEach items="${realtimesHtts}" var="l" varStatus="st" begin="${s1.index}" end="${s1.index+4}">
                <li>
                    <a href="/ht/record/detail/${l.sellPrdtBcode}">
                        <p class="img" style="width : ${l.sellPrdtGbn eq 'R'?'145':'95'}px; height : 145px;"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" width="${l.sellPrdtGbn eq 'R'?'145':'95'}" alt="${l.prdtName}" ratingCode="A" style="width:${l.sellPrdtGbn eq 'R'?'145px':'95px'};height:145px;"/></p>
                        <span class="artist txt_line1">${l.artiName}</span>
                        <span class="tit txt_line1">${l.commTitle}</span>
                        <em class="price">
                            <c:if test="${l.prdtSellPrice eq l.priceReal}">
                                <span class="sale"><fmt:formatNumber value="${l.prdtSellPrice}" pattern=",###"/></span>
                            </c:if>
                            <c:if test="${l.prdtSellPrice ne l.priceReal}">
                                <span class="dc"><fmt:formatNumber value="${l.prdtSellPrice}" pattern=",###"/></span>
                                <span class="sale"><fmt:formatNumber value="${l.priceReal}" pattern=",###"/></span>
                                <span class="pc"><fmt:formatNumber value="${hfn:rate(l.prdtSellPrice,l.priceReal)}" pattern=",###"/>%</span>
                            </c:if>
                        </em>
                    </a>
                </li>
            </c:forEach>
        </ul>
    </c:forEach>
    <a href="/ht/record/bestList/0003?bestRangeType=C1002" class="btn_more">MORE +</a>
</div>
