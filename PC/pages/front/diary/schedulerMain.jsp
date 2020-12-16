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
        $('div#searchSubArea form input[name="ctgrId"]').val('00000001');
        $('div#searchSubArea form').submit();
    });

    $('div#searchSubArea span.reset').click(function(){
        $('div#searchSubArea form').find('input').each(function(){
            $(this).val('');
        });
        
        resetColor();
    });
    
    $('div.selectBox').hover(function(){$(this).find('div').show();},function(){$(this).find('div').hide();});
    
    $('ul#selectOrderBy li').each(function(){
        $(this).click(function(){
            $('div#searchSubArea form input[name="orderByGbn"]').val($(this).attr('id'));
            $('div#searchSubArea form').submit();
        });
    });
});

function goToCategory(ctgrId){
    $('div#searchSubArea form input[name="ctgrId"]').val(ctgrId);
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
    <img src="${imageServer}/images/2013Diary/scheduler_bestseller5.gif" class="top"/>
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
    <form action="/ht/diary/scheduler" method="post">
        <input type="hidden" name="ctgrId" value="${c.ctgrId}"/>
        <input type="hidden" name="orderByGbn" value="${c.orderByGbn}"/>
        <div class="title"><img src="${imageUrl}/2013Diary/scheduler_title.jpg" class="top"/></div>
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
<!--                         
                        <tr class="line2">
                            <th><img src="${imageUrl}/2013Diary/search_title05.jpg" title="컬러"/></th>
                            <td>
                                <input type="hidden" name="searchColor" value="${c.searchColor}"/>
                                <ul class="color">
                                    <li id="cc0001"><span><a href="javascript://" onclick="mngColorKey('cc0001')"><img src="${imageUrl}/2013Diary/s_colorR.jpg" title="빨강 "/></a></span></li>
                                    <li id="f56600"><span><a href="javascript://" onclick="mngColorKey('f56600')"><img src="${imageUrl}/2013Diary/s_colorO.jpg" title="주황"/></a></span></li>
                                    <li id="9e4c12"><span><a href="javascript://" onclick="mngColorKey('9e4c12')"><img src="${imageUrl}/2013Diary/s_colorBr.jpg" title="갈색"/></a></span></li>
                                    <li id="fdd400"><span><a href="javascript://" onclick="mngColorKey('fdd400')"><img src="${imageUrl}/2013Diary/s_colorY.jpg" title="노랑"/></a></span></li>
                                    <li id="ebe3ce"><span><a href="javascript://" onclick="mngColorKey('ebe3ce')"><img src="${imageUrl}/2013Diary/s_colorBe.jpg" title="베이지 "/></a></span></li>
                                    <li id="6f7604"><span><a href="javascript://" onclick="mngColorKey('6f7604')"><img src="${imageUrl}/2013Diary/s_colorK.jpg" title="풀색 "/></a></span></li>
                                    <li id="21ba21"><span><a href="javascript://" onclick="mngColorKey('21ba21')"><img src="${imageUrl}/2013Diary/s_colorGr.jpg" title="초록 "/></a></span></li>
                                    <li id="60d9a3"><span><a href="javascript://" onclick="mngColorKey('60d9a3')"><img src="${imageUrl}/2013Diary/s_colorM.jpg" title="민트 "/></a></span></li>
                                    <li id="46bbdc"><span><a href="javascript://" onclick="mngColorKey('46bbdc')"><img src="${imageUrl}/2013Diary/s_colorSK.jpg" title="하늘 "/></a></span></li>
                                    <li id="3082c0"><span><a href="javascript://" onclick="mngColorKey('3082c0')"><img src="${imageUrl}/2013Diary/s_colorBu.jpg" title="파랑"/></a></span></li>
                                    <li id="104384"><span><a href="javascript://" onclick="mngColorKey('104384')"><img src="${imageUrl}/2013Diary/s_colorNg.jpg" title="남색 "/></a></span></li>
                                    <li id="82017f"><span><a href="javascript://" onclick="mngColorKey('82017f')"><img src="${imageUrl}/2013Diary/s_colorV.jpg" title="보라 "/></a></span></li>
                                    <li id="b264b0"><span><a href="javascript://" onclick="mngColorKey('b264b0')"><img src="${imageUrl}/2013Diary/s_colorPU.jpg" title="연보라"/></a></span></li>
                                    <li id="e989b9"><span><a href="javascript://" onclick="mngColorKey('e989b9')"><img src="${imageUrl}/2013Diary/s_colorLP.jpg" title="연핑크 "/></a></span></li>
                                    <li id="eb3d96"><span><a href="javascript://" onclick="mngColorKey('eb3d96')"><img src="${imageUrl}/2013Diary/s_colorP.jpg" title="핫핑크"/></a></span></li>
                                    <li id="000000"><span><a href="javascript://" onclick="mngColorKey('000000')"><img src="${imageUrl}/2013Diary/s_colorB.jpg" title="검정"/></a></span></li>
                                    <li id="666666"><span><a href="javascript://" onclick="mngColorKey('666666')"><img src="${imageUrl}/2013Diary/s_colorG.jpg" title="회색 "/></a></span></li>
                                    <li id="d9d9d9"><span><a href="javascript://" onclick="mngColorKey('d9d9d9')"><img src="${imageUrl}/2013Diary/s_colorS.jpg" title="은색 "/></a></span></li>
                                    <li id="ffffff"><span><a href="javascript://" onclick="mngColorKey('ffffff')"><img src="${imageUrl}/2013Diary/s_colorW.jpg" title="화이트"/></a></span></li>
                                </ul>
                            </td>
                        </tr>
 -->
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
<div class="productMenu schTabMenu">
    <div style="float:left;">
        <ul>
            <li onclick="goToCategory('00000001')"><p <c:if test="${empty c.ctgrId || c.ctgrId eq '00000001'}">class="on"</c:if>>전체 (<fmt:formatNumber value="${size.allPrdtCnt}" pattern=",###"/>)</p></li>
            <li onclick="goToCategory('0000000101')"><p <c:if test="${c.ctgrId eq '0000000101'}">class="on"</c:if>>먼슬리 (<fmt:formatNumber value="${size.monPrdtCnt}" pattern=",###"/>)</p></li>
            <li onclick="goToCategory('0000000102')"><p <c:if test="${c.ctgrId eq '0000000102'}">class="on"</c:if>>위클리 (<fmt:formatNumber value="${size.wekPrdtCnt}" pattern=",###"/>)</p></li>
            <li onclick="goToCategory('0000000103')"><p <c:if test="${c.ctgrId eq '0000000103'}">class="on"</c:if>>데일리 (<fmt:formatNumber value="${size.dayPrdtCnt}" pattern=",###"/>)</p></li>
            <li onclick="goToCategory('0000000100')"><p <c:if test="${c.ctgrId eq '0000000100'}">class="on"</c:if>>스터디 플래너 (<fmt:formatNumber value="${size.stdPrdtCnt}" pattern=",###"/>)</p></li>
            <li onclick="goToCategory('0000000106')"><p class="no_bg <c:if test="${c.ctgrId eq '0000000106'}">on</c:if>">프로젝트 플래너 (<fmt:formatNumber value="${size.pjtPrdtCnt}" pattern=",###"/>)</p></li>
        </ul>
    </div>
    <div class="selectBox">
        <p>
            <a href="#list-size">
                <c:if test="${empty c.orderByGbn || c.orderByGbn eq 'N'}">신상품순</c:if>
                <c:if test="${c.orderByGbn eq 'T'}">판매순</c:if>
                <c:if test="${c.orderByGbn eq 'S'}">낮은가격순</c:if>
                <c:if test="${c.orderByGbn eq 'H'}">높은가격순</c:if>
            </a>
        </p>
        <div>
            <ul id="selectOrderBy">
                <li id="N"><a href="javascript:">신상품순</a></li>
                <li id="T"><a href="javascript:">판매순</a></li>
                <li id="S"><a href="javascript:">낮은가격순</a></li>
                <li id="H"><a href="javascript:">높은가격순</a></li>
            </ul>
        </div>
    </div>
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