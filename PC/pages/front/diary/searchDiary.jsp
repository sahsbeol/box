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
var colorKey = new Array();
jQuery(function($){
    $(document).ready(function(){
        $('div#searchSubArea ul.color li').each(function(){
            if('${c.searchColor}'.indexOf($(this).attr('id'))>-1){
                mngColorKey($(this).attr('id'));
            } 
        });
    });
    
    $('div#searchSubArea span.submit').click(function(){
        $('div#searchSubArea form').submit();
    });

    $('div#searchSubArea span.reset').click(function(){
        $('div#searchSubArea form').find('input').each(function(){
            $(this).val('');
        });
        
        resetColor();
    });
    
    $('select#selectOrderBy').change(function(){
        $('div#searchSubArea input[name="orderByGbn"]').val($(this).val());
        $('div#searchSubArea form').submit();
    });
});

function resetColor(){
    colorKey = new Array();
    $('div#searchSubArea input[name="searchColor"]').val(colorKey);
    $('div#searchSubArea form ul.color li').each(function(){
        $(this).find('img').attr('src', $(this).find('img').attr('src').replace('_on.jpg', '.jpg'));
    });
}

function mngColorKey(key){
    var arrays = new Array();
    var isContained = false;
    
    for (var i = 0; i < colorKey.length; i++){
        if(colorKey[i] == key){
            isContained = true;
        }else{
            arrays.push(colorKey[i]);
        }
    }
    
    if(isContained){
        $('div#searchSubArea ul.color li#'+key+' img').attr('src', $('ul.color li#'+key+' img').attr('src').replace('_on.jpg', '.jpg'));
    }else{
        arrays.push(key);
        $('div#searchSubArea ul.color li#'+key+' img').attr('src', $('ul.color li#'+key+' img').attr('src').replace('_on.jpg', '.jpg'));
        $('div#searchSubArea ul.color li#'+key+' img').attr('src', $('ul.color li#'+key+' img').attr('src').replace('.jpg', '_on.jpg'));
    }
    
    colorKey = arrays;
    $('div#searchSubArea input[name="searchColor"]').val(colorKey);
}

//-->
</script>    
</head>
<body>
<div id="container">
    <c:set var="imageUrl" value="https://simage.kyobobook.co.kr/newimages/giftshop/images"/>
    <div id="searchSubArea">
        <form action="/ht/diary/searchDiary" method="post">
            <input type="hidden" name="orderByGbn" value="${c.orderByGbn}"/>
            <div class="srch_title"><p><img src="${imageUrl}/2013Diary/search_title_star.gif"/> 원하시는 항목만 선택하세요</p></div>
            <div class="innerArea">
                <table>
                    <tbody>
                        <tr>
                            <th><img src="${imageUrl}/2013Diary/search_title01.jpg" title="디자인"/></th>
                            <td>
                                <input type="radio" name="ctgrId" value="" <c:if test="${empty c.ctgrId}">checked="checked"</c:if>/>전체
                                <input type="radio" name="ctgrId" value="0000000002" <c:if test="${c.ctgrId eq '0000000002'}">checked="checked"</c:if>/>심플/기능성
                                <input type="radio" name="ctgrId" value="0000000000" <c:if test="${c.ctgrId eq '0000000000'}">checked="checked"</c:if>/>캐릭터/일러스트
                                <input type="radio" name="ctgrId" value="0000000001" <c:if test="${c.ctgrId eq '0000000001'}">checked="checked"</c:if>/>포토/여행
                                <input type="radio" name="ctgrId" value="0000000006" <c:if test="${c.ctgrId eq '0000000006'}">checked="checked"</c:if>/>핸드메이드
                            </td>
                        </tr>
                        <tr>
                            <th><img src="${imageUrl}/2013Diary/search_title02.jpg" title="가격"/></th>
                            <td>
                                <input type="text" class="input_txt inputNumberText" name="sellPriceMin" title="최소가격을 입력하세요" value="${c.sellPriceMin}"/>
                                ~
                                <input type="text" class="input_txt inputNumberText" name="sellPriceMax" title="최대가격을 입력하세요" value="${c.sellPriceMax}"/>
                            </td>
                        </tr>
                        <tr>
                            <th><img src="${imageUrl}/2013Diary/search_title03.jpg" title="연도구분"/></th>
                            <td>
                                <input type="radio" name="yearGbn" value="" <c:if test="${empty c.yearGbn}">checked="checked"</c:if>/>전체
                                <input type="radio" name="yearGbn" value="N" <c:if test="${c.yearGbn eq 'N'}">checked="checked"</c:if>/>만년
                                <input type="radio" name="yearGbn" value="Y" <c:if test="${c.yearGbn eq 'Y'}">checked="checked"</c:if>/>날짜인쇄
                            </td>
                        </tr>
                        <tr>
                            <th><img src="${imageUrl}/2013Diary/search_title04.jpg" title="배송구분"/></th>
                            <td>
                                <input type="radio" name="deliveryGbn" value="" <c:if test="${empty c.deliveryGbn}">checked="checked"</c:if>/>전체
                                <input type="radio" name="deliveryGbn" value="F" <c:if test="${c.deliveryGbn eq 'F'}">checked="checked"</c:if>/>무료배송
                                <input type="radio" name="deliveryGbn" value="H" <c:if test="${c.deliveryGbn eq 'H'}">checked="checked"</c:if>/>핫트랙스배송
                                <input type="radio" name="deliveryGbn" value="D" <c:if test="${c.deliveryGbn eq 'D'}">checked="checked"</c:if>/>무료배송+핫트랙스배송
                            </td>
                        </tr>
                        <tr class="control">
                            <td colspan="2" style="text-align:center;">
                                <span class="submit"><a><img src="${imageUrl}/2013Diary/btn_searchb.jpg" alt="검색"/></a></span>
                                <span class="reset"><a><img src="${imageUrl}/2013Diary/btn_first.jpg" alt="검색조건초기화"/></a></span>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </form>
    </div><!-- end searchArea -->
    <div class="listMenu third">
        <span class="left"><img src="${imageUrl}/2013Diary/diary_icon.jpg"/> <strong>총 <fmt:formatNumber value="${size}" pattern=",###"/>건</strong>의 다이어리가 검색되었습니다.</span>
        <select id="selectOrderBy" class="select f_right">
            <option value="N" <c:if test="${c.orderByGbn eq 'N'}">selected="selected"</c:if>>신상품순</option>
            <option value="T" <c:if test="${c.orderByGbn eq 'T'}">selected="selected"</c:if>>판매순</option>
            <option value="S" <c:if test="${c.orderByGbn eq 'S'}">selected="selected"</c:if>>낮은가격순</option>
            <option value="H" <c:if test="${c.orderByGbn eq 'H'}">selected="selected"</c:if>>높은가격순</option>
        </select>
    </div><!-- end third -->
    <div class="prod_list_normal mgt30">
        <c:choose>
            <c:when test="${not empty list}">
                <c:forEach items="${list}" varStatus="s1" step="4">
                <ul>
                    <c:forEach items="${list}" var="l" varStatus="status" begin="${s1.index}" end="${s1.index+3}">
                        <li>
                            <span class="img"><a href="/ht/product/detail?barcode=${l.productBarcode}"><ui:image src="${l.productImageUrl}" server="product" size="200"/></a></span>
                            <a href="/ht/product/detail?barcode=${l.productBarcode}">
                                <span class="make">${l.brandName}</span>
                                <span class="name">${l.productName}</span>
                                <em class="price">
                                    <c:if test="${l.orgSellPrice > l.sellPrice}">
                                        <span class="dc"><fmt:formatNumber value="${l.orgSellPrice}" type="number" /></span>
                                        <span class="sale"><fmt:formatNumber value="${l.sellPrice}" pattern=",###" /></span>
                                        <span class="pc">${hfn:rate(l.orgSellPrice, l.sellPrice)}%</span>
                                    </c:if>
                                    <c:if test="${l.orgSellPrice <= l.sellPrice}">
                                        <span class="sale"><fmt:formatNumber value="${l.orgSellPrice}" type="number" /></span>
                                    </c:if>
                                </em>
                            </a>
                        </li>
                    </c:forEach>
                </ul>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div id="noSearch"><img src="${imageUrl}/2013Diary/search_noimg.jpg"/></div>
            </c:otherwise>
        </c:choose>
    </div><!-- end fourth -->
    <div class="paging"><ui:pagination name="pageHolder" url="?" parameters="orderByGbn"/></div>
</div>
</body>
</html>