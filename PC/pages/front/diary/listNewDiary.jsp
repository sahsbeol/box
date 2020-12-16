<%@ page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="diary"/>
<html>
<head>
<script type="text/javascript">
<!-- 
//-->
</script>
</head>
<body>
<div class="welcom_top">
    <h2 class="title"><img src="${imageServer}/images/2015Diary/new_diary.gif" alt="NEW DIARY" /></h2>
</div>
<div class="welcom_conts">
    <div class="tab_cate02">
    </div>
    <div class="prod_list_normal">
        <c:forEach items="${list}" varStatus="s1" step="4">
            <ul><!-- 1 -->
                <c:forEach items="${list}" var="l" varStatus="st" begin="${s1.index}" end="${s1.index+3}">
                    <li>
                        <span class="img">
                            <a href="/ht/product/detail?barcode=${l.sellPrdtBcode}" title="${l.prdtName}"><ui:image src="${l.prdtImgUrl}" size="200" server="product" alt="${l.prdtName}"/></a>
                            <div class="hide_util">
                                <a href="javascript://" onclick="productPreview('${l.sellPrdtBcode}')" class="zoom"><span>확대</span></a>
                                <a href="/ht/product/detail?barcode=${l.sellPrdtBcode}" target="_blank" class="nblank"><span>새창</span></a>
                                <a href="javascript://" onclick="addWishProduct('${l.sellPrdtBcode}')" class="zzim"><span>좋아요</span></a>
                            </div>
                        </span>
                        <a href="/ht/product/detail?barcode=${l.sellPrdtBcode}">
                            <span class="make">${l.brandEngName}</span>
                            <span class="name">${l.prdtName}</span>
                            <em class="price">
                                <c:if test="${l.basePrdtSellPrice > l.lastCpnPrice}"><span class="dc"><fmt:formatNumber type="number">${l.basePrdtSellPrice}</fmt:formatNumber></span></c:if>
                                <span class="sale"><fmt:formatNumber type="number">${l.lastCpnPrice}</fmt:formatNumber></span>
                                <c:if test="${l.basePrdtSellPrice > l.lastCpnPrice}"><span class="pc">${hfn:rate(l.basePrdtSellPrice,l.lastCpnPrice)}%</span></c:if>
                            </em>
                        </a>
                    </li>
                </c:forEach>
            </ul>
        </c:forEach>
    </div><!-- //.prod_list_normal -->
</div><!-- //.welcom_conts -->
<div class="paging mgt70"><ui:pagination name="pageHolder" url="?" parameters=""/></div>
</body>
</html>