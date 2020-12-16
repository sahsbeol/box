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
});

function doOrderBy(order){
    $('div#searchSubArea input[name="orderByGbn"]').val(order);
    $('div#searchSubArea form').submit();
}

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
<c:set var="imageUrl" value="https://simage.kyobobook.co.kr/newimages/giftshop/images"/>
<div id="top_banner">
    <c:if test="${brandId eq '10023'}"><img src="${imageServer}/images/2013Diary/plan_bestseller5.gif" class="top"/></c:if>
    <c:if test="${brandId eq '10828'}"><img src="${imageServer}/images/2013Diary/yangjisa_bestseller5.gif" class="top"/></c:if>
    <c:if test="${brandId eq '10024'}"><img src="${imageServer}/images/2013Diary/orom_bestseller5.gif" class="top"/></c:if>
    <c:if test="${brandId eq '91607'}"><img src="${imageServer}/images/2013Diary/leadership_bestseller5.gif" class="top"/></c:if>
</div><!-- end first -->
<div class="rank02">
    <ul>
        <c:forEach items="${bestSellers}" var="bestSeller" varStatus="status">
            <li>
                <p class="photo"><a href="/ht/product/detail?barcode=${bestSeller.productBarcode}"><ui:image src="${bestSeller.productImageUrl}" server="product" size="150"/></a></p>
                <p class="name">${bestSeller.brandName}</p>
                <p class="name" title="${bestSeller.productName}"><a href="/ht/product/detail?barcode=${bestSeller.productBarcode}">${bestSeller.productName}</a></p>
                <c:if test="${bestSeller.orgSellPrice ne bestSeller.sellPrice}">
                    <p class="orgSellPrice"><span><fmt:formatNumber value="${bestSeller.orgSellPrice}" pattern=",###"/></span><strong>[${hfn:rate(bestSeller.orgSellPrice, bestSeller.sellPrice)}%]</strong></p>
                </c:if>
                <p class="sellPrice"><fmt:formatNumber value="${bestSeller.sellPrice}" pattern=",###"/></p>
            </li>
        </c:forEach>
    </ul>
</div><!-- end second -->
<div id="searchSubArea">
    <form action="/ht/diary/brand/${brandId}" method="post">
        <input type="hidden" name="orderByGbn" value="${c.orderByGbn}"/>
        <div class="title">
            <c:if test="${brandId eq '10023'}"><img src="${imageUrl}/2013Diary/plan_title.jpg" class="top"/></c:if>
            <c:if test="${brandId eq '10828'}"><img src="${imageUrl}/2013Diary/yangjisa_title.jpg" class="top"/></c:if>
            <c:if test="${brandId eq '10024'}"><img src="${imageUrl}/2013Diary/orom_title.jpg" class="top"/></c:if>
            <c:if test="${brandId eq '91607'}"><img src="${imageUrl}/2013Diary/leadership_title.jpg" class="top"/></c:if>
        </div>
        <div class="innerArea">
        <table>
            <tbody>
                <tr>
                    <th><img src="${imageUrl}/2013Diary/search_title02.jpg" title="가격"/></th>
                    <td>
                        <input type="text" class="textbox inputNumberText" name="sellPriceMin" title="최소가격을 입력하세요" value="${c.sellPriceMin}"/>
                        ~
                        <input type="text" class="textbox inputNumberText" name="sellPriceMax" title="최대가격을 입력하세요" value="${c.sellPriceMax}"/>
                    </td>
                </tr>
                <tr>
                    <th><img src="${imageUrl}/2013Diary/search_title06.jpg" title="카테고리"/></th>
                    <td>
                        <c:if test="${brandId eq '10023'}">
                            <input type="radio" name="ctgrId" value="0000001700" <c:if test="${c.ctgrId eq '0000001700'}">checked="checked"</c:if>/>전체
                            <input type="radio" name="ctgrId" value="000000170000" <c:if test="${c.ctgrId eq '000000170000'}">checked="checked"</c:if>/>캐쥬얼 다이어리
                            <input type="radio" name="ctgrId" value="000000170003" <c:if test="${c.ctgrId eq '000000170003'}">checked="checked"</c:if>/>속지류
                            <input type="radio" name="ctgrId" value="000000170001" <c:if test="${c.ctgrId eq '000000170001'}">checked="checked"</c:if>/>풀세트
                            <input type="radio" name="ctgrId" value="000000170002" <c:if test="${c.ctgrId eq '000000170002'}">checked="checked"</c:if>/>바인더
                            <input type="radio" name="ctgrId" value="0000001700T" <c:if test="${c.ctgrId eq '0000001700T'}">checked="checked"</c:if>/>기타
                        </c:if>
                        <c:if test="${brandId eq '10828'}">
                            <input type="radio" name="ctgrId" value="00001812" <c:if test="${c.ctgrId eq '00001812'}">checked="checked"</c:if>/>전체
                            <input type="radio" name="ctgrId" value="0000181200" <c:if test="${c.ctgrId eq '0000181200'}">checked="checked"</c:if>/>연도다이어리
                            <input type="radio" name="ctgrId" value="0000181201" <c:if test="${c.ctgrId eq '0000181201'}">checked="checked"</c:if>/>시스템다이어리
                            <input type="radio" name="ctgrId" value="0000181202" <c:if test="${c.ctgrId eq '0000181202'}">checked="checked"</c:if>/>캘린더
                            <input type="radio" name="ctgrId" value="0000181203" <c:if test="${c.ctgrId eq '0000181203'}">checked="checked"</c:if>/>수첩
                            <input type="radio" name="ctgrId" value="0000181204" <c:if test="${c.ctgrId eq '0000181204'}">checked="checked"</c:if>/>메모지
                            <input type="radio" name="ctgrId" value="0000181205" <c:if test="${c.ctgrId eq '0000181205'}">checked="checked"</c:if>/>기타
                        </c:if>
                        <c:if test="${brandId eq '10024'}">
                            <input type="radio" name="ctgrId" value="0000001701" <c:if test="${c.ctgrId eq '0000001701'}">checked="checked"</c:if>/>전체
                            <input type="radio" name="ctgrId" value="000000170100" <c:if test="${c.ctgrId eq '000000170100'}">checked="checked"</c:if>/>다이어리
                            <input type="radio" name="ctgrId" value="000000170101" <c:if test="${c.ctgrId eq '000000170101'}">checked="checked"</c:if>/>풀세트
                            <input type="radio" name="ctgrId" value="000000170102" <c:if test="${c.ctgrId eq '000000170102'}">checked="checked"</c:if>/>커버/패드류
                            <input type="radio" name="ctgrId" value="000000170103" <c:if test="${c.ctgrId eq '000000170103'}">checked="checked"</c:if>/>리필속지
                            <input type="radio" name="ctgrId" value="0000001701T" <c:if test="${c.ctgrId eq '0000001701T'}">checked="checked"</c:if>/>기타
                        </c:if>
                        <c:if test="${brandId eq '91607'}">
                            <input type="radio" name="ctgrId" value="0000001702" <c:if test="${c.ctgrId eq '0000001702'}">checked="checked"</c:if>/>전체
                            <input type="radio" name="ctgrId" value="000000170200" <c:if test="${c.ctgrId eq '000000170200'}">checked="checked"</c:if>/>CEO풀세트
                            <input type="radio" name="ctgrId" value="000000170201" <c:if test="${c.ctgrId eq '000000170201'}">checked="checked"</c:if>/>지갑형 풀세트
                            <input type="radio" name="ctgrId" value="000000170202" <c:if test="${c.ctgrId eq '000000170202'}">checked="checked"</c:if>/>리필/속지류
                            <input type="radio" name="ctgrId" value="000000170203" <c:if test="${c.ctgrId eq '000000170203'}">checked="checked"</c:if>/>기타
                        </c:if>
                    </td>
                </tr>
                <tr>
                    <th><img src="${imageUrl}/2013Diary/search_title07.jpg" title="쇼핑혜택"/></th>
                    <td>
                        <input type="radio" name="benefitGbn" value="" <c:if test="${empty c.benefitGbn}">checked="checked"</c:if>/>전체
                        <input type="radio" name="benefitGbn" value="N" <c:if test="${c.benefitGbn eq 'N'}">checked="checked"</c:if>/>무료배송
                        <input type="radio" name="benefitGbn" value="D" <c:if test="${c.benefitGbn eq 'D'}">checked="checked"</c:if>/>할인
                        <input type="radio" name="benefitGbn" value="C" <c:if test="${c.benefitGbn eq 'C'}">checked="checked"</c:if>/>쿠폰
                        <input type="radio" name="benefitGbn" value="T" <c:if test="${c.benefitGbn eq 'T'}">checked="checked"</c:if>/>할인+쿠폰
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
<div class="productMenu third">
    <ul>
        <li onclick="doOrderBy('')"><p <c:if test="${empty c.orderByGbn}">class="on"</c:if>>전체 (<fmt:formatNumber value="${size}" pattern=",###"/>)</p></li>
        <li onclick="doOrderBy('N')"><p <c:if test="${c.orderByGbn eq 'N'}">class="on"</c:if>>신상품순</p></li>
        <li onclick="doOrderBy('T')"><p <c:if test="${c.orderByGbn eq 'T'}">class="on"</c:if>>판매순</p></li>
        <li onclick="doOrderBy('S')"><p <c:if test="${c.orderByGbn eq 'S'}">class="on"</c:if>>낮은가격순</p></li>
        <li onclick="doOrderBy('H')"><p class="no_bg <c:if test="${c.orderByGbn eq 'H'}">on</c:if>">높은가격순</p></li>
    </ul>
</div><!-- end third -->
<div class="prod_list_normal">
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
</div><!-- end fourth -->
<div class="paging"><ui:pagination name="pageHolder" url="?" parameters="orderByGbn"/></div>
</body>
</html>