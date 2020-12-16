<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<html>
<head>
<c:set var="ctgrName"><ui:category id="${c.ctgrId}" full="false"/></c:set>
<title>${ctgrName} - HOTTRACKS</title>
<script type="text/javascript" src="/js/fn_htts_slide.js"></script>
<script type="text/javascript" src="/js/owl.carousel.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    slideDiv(".main_sec4", 6000, ".main_sec4");
    
    $.ajax({
        type: "GET"
        ,url: "/ht/getPopupList"
        ,data: {dispGbn : 'C', ctgrId : '${c.ctgrId}'}
        ,dataType: "json"
        ,success: function getPopup(data) {
            if(data && data.popupList) {
                var popupList = data.popupList;
                for(var i=0;i<popupList.length;i++) {
                    var options =   "width=" + popupList[i].popupSizeX
                                  + ",height=" + (popupList[i].popupSizeY + 20)
                                  + ",left=" + popupList[i].popupPosX
                                  + ",top=" + popupList[i].popupPosY;
                    window.open("/ht/getPopup?popupseq="+popupList[i].popupSeq, "giftCategoryPopup" + i, options);
                }
            }
        }
        ,error: function(xhr, status, error) {
            alert("<fmt:message key='error.common.system'/>");
        }
    });
    
    $("#orders_carousel").owlCarousel({
        navigation : true,
        slideSpeed : 0,
        paginationSpeed : 0,
        singleItem : true,
        rewindSpeed :  0,
        beforeInit : function(elem){
            random(elem);
        }
    });
    
    $("#orders_carousel02").owlCarousel({
        navigation : true,
        slideSpeed : 0,
        paginationSpeed : 0,
        singleItem : true,
        rewindSpeed :  0
    });
    
    function random(owlSelector){
        owlSelector.children().sort(function(){
            return Math.round(Math.random()) - 0.5;
        }).each(function(){
            $(this).appendTo(owlSelector);
        });
    }
});
</script>
</head>
<body>

<!-- Location -->
<div class="page_location shop">
    <div class="loc">
        <a href="/" class="home">Home</a>
        <c:forEach varStatus="st" begin="6" end="${fn:length(c.ctgrId)}" step="2">
            <c:if test="${st.last}"><em><ui:category id="${ctgrId}" full="false"/></em></c:if>
            <c:if test="${!st.last && st.first}"><a href="/ht/gift/giftCategoryMain?ctgrId=${fn:substring(c.ctgrId, 0, st.index)}"><ui:category id="${fn:substring(c.ctgrId, 0, st.index)}" full="false"/></a></c:if>
            <c:if test="${!st.last && !st.first}"><a href="/ht/gift/giftCategorySub?ctgrId=${fn:substring(c.ctgrId, 0, st.index)}"><ui:category id="${fn:substring(c.ctgrId, 0, st.index)}" full="false"/></a></c:if>
        </c:forEach>
    </div>
    <a href="/ht/welcome/hotEventMain?ctgrId=${fn:substring(c.ctgrId, 0, 6)}" class="more_event"><span><ui:category id="${fn:substring(c.ctgrId, 0, 6)}" full="false"/> 이벤트 더보기</span></a>
    <%-- <c:if test="${fn:startsWith(c.ctgrId, '000020')}"> 
        <img src="${imageServer}/images/diary/2017/bnr_diary_top.jpg" alt="2017 다이어리배너" style="margin: 10px 0;" usemap="#diaryMap"/>
        <map name="diaryMap" id="diaryMap">
            <area shape="rect" coords="25,6,731,73" href="/ht/diary/main" />
            <area shape="rect" coords="735,7,928,72" href="/ht/biz/eventDetail?eventId=40651" />
        </map>
    </c:if> --%>
</div>
<!-- //Location -->

<!-- Office_design -->
<div class="office_design02">
    <c:import url="/menu/gift/lnb">
        <c:param name="ctgrId">${c.ctgrId}</c:param>
    </c:import>
    
    <!-- 서브배너 -->
    <div class="sub_banner">
        <!-- 왼쪽배너 -->
        <div class="main_sec4">
            <ul class="main_slide_btn slide_view">
                <c:forEach items="${list1St}" var="l" varStatus="st">
                    <li class="main_slide_img"><ui:banner bannerImageUrl="${l.bnrImgUrl}" bnrLinkUrl="${l.bnrLnkUrl}" bnrSeq="${l.bnrSeq}" bnrTgtGbn="L" newWdwYn="${l.bnrNewWinYn}" alt="${l.bnrImgAlt}"/></li>
                </c:forEach>
            </ul>
            <ul class="main_slide_navi">
                <c:forEach items="${list1St}" var="l" varStatus="st">
                    <li class="slide_navi ${st.first?'active':''}"><a href="javascript://"><img src="${imageServer}/images/common/ic_navi0${st.count}.png"/></a></li>
                </c:forEach>
                <li class="slide_ctrl">
                    <a class="stop" href="javascript://">일시정지</a>
                </li>
            </ul>
        </div>
        <!-- //왼쪽배너 -->
        <!-- //오른쪽 상품 전시 -->
        <div class="main_sec5">
            <ul>
                <c:forEach items="${list2St}" var="l" varStatus="st" end="1">
                    <li>
                        <a href="/ht/product/detail?barcode=${l.sellPrdtBcode}">
                            <span class="img"><ui:image src="${l.prdtImgUrl}" server="product" size="120" alt="${l.prdtName}" /></span>
                            <span class="tit">${l.prdtName}</span>
                            <em class="price"><span class="sale"><fmt:formatNumber type="number" value="${l.lastCpnPrice}"/></span></em>
                        </a>
                    </li>
                </c:forEach>
            </ul>
        </div>
        <!-- //오른쪽 상품 전시 -->
    </div>
    <!-- //서브배너 -->
    
</div>
<!-- //Office_design -->

<p class="main_bg_line03"></p>

<!-- prod_col2 -->
<c:if test="${not empty list3St}">
<div class="office_design03">
    <ul>
        <c:forEach items="${list3St}" var="l" varStatus="st" end="3">
            <li id="dsn03_bnr0${st.count}"><ui:banner bannerImageUrl="${l.bnrImgUrl}" bnrLinkUrl="${l.bnrLnkUrl}" bnrSeq="${l.bnrSeq}" bnrTgtGbn="L" newWdwYn="${l.bnrNewWinYn}" alt="${l.bnrImgAlt}"/></li>
        </c:forEach>
    </ul>
</div>
</c:if>

<!-- //prod_col2 -->
<p class="main_bg_line03"></p>

<!-- new arriaval -->
<c:set var="list" value="${listNew}"/>
<c:if test="${not empty list}">
<div class="newarrival mgt70 mgb65">
    <h2 class="tit"><img src="${imageServer}/images/renewal/shop/sub_tit_newarrival.gif" alt="new arrival" /></h2>
    <a href="/ht/welcome/hotAwardRecentPage?dispMstrId=CATE_GFT_NEW&ctgrId=000029" class="btn_more">MORE +</a>
    <div id="orders_carousel" class="orders_carousel">
        <c:forEach items="${list}" varStatus="s1" begin="0" step="10">
            <div class="item">
                <div class="prod_list">
                    <ul>
                        <c:forEach items="${list}" var="l" varStatus="st" begin="${s1.index}" end="${s1.index+9}">
                            <li>
                                <a href="/ht/product/detail?barcode=${l.sellPrdtBcode}" title="${l.prdtName}">
                                    <p class="img"><ui:image src="${l.prdtImgUrl}" server="product" size="120" alt="${l.prdtName}" /></p>
                                    <span class="tit"><ui:cut isStripHtml="true">${l.prdtName}</ui:cut></span>
                                    <em class="price"><span class="sale"><fmt:formatNumber value="${l.lastCpnPrice}" pattern="###,###,###"/></span></em>
                                </a>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
</c:if>
<!--// new arrival -->

<!-- best20 -->
<c:set var="list" value="${listBest}"/>
<c:if test="${not empty list}">
<div class="best20 mgt70 mgb50">
    <h2 class="tit"><img src="${imageServer}/images/renewal/shop/sub_tit_hotbest20.gif" alt="hot best 20" /></h2>
    <div id="orders_carousel02" class="orders_carousel">
        <c:forEach items="${list}" varStatus="s1" begin="0" step="20">
            <div class="item">
                <div class="prod_list">
                    <ul>
                        <c:forEach items="${list}" var="l" varStatus="st" begin="${s1.index}" end="${s1.index+19}">
                            <li>
                                <a href="/ht/product/detail?barcode=${l.sellPrdtBcode}" title="${l.prdtName}">
                                    <p class="img"><ui:image src="${l.prdtImgUrl}" server="product" size="120" alt="${l.prdtName}" /></p>
                                    <span class="tit"><ui:cut isStripHtml="true">${l.prdtName}</ui:cut></span>
                                    <em class="price"><span class="sale"><fmt:formatNumber value="${l.lastCpnPrice}" pattern="###,###,###"/></span></em>
                                </a>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
</c:if>
<!--// best20 -->
</body>
</html>