<%@ page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="none"/>
    <c:set var="imageUrl" value="https://simage.kyobobook.co.kr/newimages/giftshop/images"/>
    <div class="top">
        <span><img src="${imageUrl}/2013Diary/Diary_txt_ranking.jpg"/></span>
        <span class="right"><a href="/ht/diary/listBestDiary"><img src="${imageUrl}/2013Diary/btn_more.jpg"/></a></span>
    </div>
    <div class="rankTab">
        <ul>
            <li><a href="javascript://" onclick="loadBestRank('00000000')"><img src="${imageUrl}/2013Diary/ranking_tab01<c:if test="${c.ctgrId eq '00000000'}">_on</c:if>.jpg"/></a></li>
            <li><a href="javascript://" onclick="loadBestRank('00000001')"><img src="${imageUrl}/2013Diary/ranking_tab02<c:if test="${c.ctgrId eq '00000001'}">_on</c:if>.jpg"/></a></li>
            <li><a href="javascript://" onclick="loadBestRank('00000005')"><img src="${imageUrl}/2013Diary/ranking_tab03<c:if test="${c.ctgrId eq '00000005'}">_on</c:if>.jpg"/></a></li>
        </ul>
    </div><!-- end rankTop -->
    <div class="rankProductList">
        <ul>
            <c:forEach items="${list}" var="l" varStatus="s">
                <c:if test="${s.first}">
                    <li>
                        <div><a href="/ht/product/detail?barcode=${l.productBarcode}" title="${l.productName}"><ui:image src="${l.productImageUrl}" server="product" size="120"/></a></div>
                        <div style="padding:0 0 0 8px;">
                            <p class="brand" title="${l.brandName}" style="overflow:hidden;text-overflow:ellipsis;white-space:nowrap;width:70px;">${l.brandName}</p>
                            <p class="name" title="${l.productName}" style="overflow:hidden;text-overflow:ellipsis;white-space:nowrap;width:70px;"><a href="/ht/product/detail?barcode=${l.productBarcode}">${l.productName}</a></p>
                            <p class="rankIcon"><img src="${imageUrl}/2013Diary/Diary_best_01.jpg"/></p>
                        </div>
                    </li>
                </c:if>
                <c:if test="${!s.first}">
                    <li class="small">
                        <div style="padding:0 10px 0 0;"><img src="${imageUrl}/2013Diary/Diary_best_0${s.index+1}.jpg"/></div>
                        <div><a href="/ht/product/detail?barcode=${l.productBarcode}" title="${l.productName}"><ui:image src="${l.productImageUrl}" server="product" size="50"/></a></div>
                    </li>
                </c:if>
            </c:forEach>
        </ul>
    </div><!-- end fourth -->