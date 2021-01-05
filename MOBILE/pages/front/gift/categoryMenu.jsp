<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<html>
<head>
<script type="text/javascript">
jQuery(function($){
    $("body").css("background-color", "#eeeeee");
    
    $("#cate-sub-menu .btn_more").click(function(){
        if($(this).hasClass("active")){
            $(this).removeClass("active");
            $("#cate-sub-menu .hid_obj").hide();
        }else{
            $(this).addClass("active");
            $("#cate-sub-menu .hid_obj").show();
        }
    });
    
    // BEST
    var cateBest = new Swiper('#prod01 .swiper-container',{
        pagination: '#prod01 .pagination',
        loop:true,
        grabCursor: true,
        paginationClickable: true
    });
    
    var cateNew = new Swiper('#prod02 .swiper-container',{
        pagination: '#prod02 .pagination',
        loop:true,
        grabCursor: true,
        paginationClickable: true
    });
    
    var cateLike = new Swiper('#prod03 .swiper-container',{
        pagination: '#prod03 .pagination',
        loop:true,
        grabCursor: true,
        paginationClickable: true
    });
    
    $(".gift_best .prod_basic02").each(function(idx){
        if(idx != 0)    $(this).hide();
    });
    
    $(".tab_basic a").click(function(e){
        e.preventDefault();
        var idx = $(".tab_basic a").index($(this));
        switch(idx){
        case 0:reinitSwiper(cateBest);break;
        case 1:reinitSwiper(cateNew);break;
        case 2:reinitSwiper(cateLike);break;
        }
        
        $(".tab_basic a").removeClass("on");
        $(".gift_best .prod_basic02").hide();
        
        $(this).addClass("on");
        $($(this).attr('href')).show();
    });
    
    $("img.lazy").lazyload({placeholder:'/images/no_image2.gif',effect : "fadeIn"});
});
function reinitSwiper(swiper) {
  setTimeout(function () {swiper.reInit();}, 500);
}
function goList(page){
    location.href="?ctgrId=${c.ctgrId}&productOrderBy=${c.productOrderBy}&page="+page;
}
var page = 1;
function loadEvent(){
    $("#loading").show();
    page++;
    $.ajax({
        type: "GET"
       ,url: "/m/hot/eventMore?ctgrId=${c.ctgrId}&page="+page
       ,dataType: "html"
       ,success : function(htmlStr){
           $("#eventList").append(htmlStr);
           $("input[name=eof]").val("0");
           $("#loading").hide();
       }
       ,error: function(data) {
           alert('<fmt:message key="error.common.system"/>');
           $("#loading").hide();
       }
   });
}
</script>
</head>
<body style="background-color:#eeeeee;">
<c:set var="lnkUrl" value="/m/gift/category/"/>
<div id="cate-sub-menu">
    <div class="cate">
        <ul>
            <li><a href="${lnkUrl}${c.ctgrId}">전체 상품 보기</a></li>
            <c:forEach items="${childCategory}" var="l" varStatus="st" end="8">
                <li><a href="${lnkUrl}${l.ctgrId}">${l.ctgrName}</a></li>
            </c:forEach>
        </ul>
        <ul class="hid_obj">
            <c:forEach items="${childCategory}" var="l" varStatus="st" begin="9">
                <li><a href="${lnkUrl}${l.ctgrId}">${l.ctgrName}</a></li>
            </c:forEach>
        </ul>
    </div>
    <a href="javascript://" class="btn_more"><span>카테고리 더보기</span></a>
</div>
<div class="pt20">
    <c:if test="${not empty listBest && not empty listSale && not empty listWish}">
        <div class="gift_best">
            <ul class="tab_basic"><!-- tab produnt -->
                <li><a href="#prod01" class="on"><span>BEST</span></a></li>
                <li><a href="#prod02"><span>SALE</span></a></li>
                <li><a href="#prod03"><span><em class="like">좋아요</em></span></a></li>
            </ul>
            <c:forEach begin="0" end="2" varStatus="s1">
                <c:if test="${s1.index eq 0}"><c:set var="listm" value="${listBest}"/></c:if>
                <c:if test="${s1.index eq 1}"><c:set var="listm" value="${listSale}"/></c:if>
                <c:if test="${s1.index eq 2}"><c:set var="listm" value="${listWish}"/></c:if>
                <div id="prod0${s1.count}" class="prod_basic02"><!--  banner type01 col2-->
                    <div class="swiper-container">
                        <div class="swiper-wrapper">
                            <c:forEach items="${listm}" varStatus="s2" step="2" end="5">
                                <div class="swiper-slide">
                                    <c:forEach items="${listm}" var="l" begin="${s2.index}" end="${s2.index+1}">
                                        <span>
                                            <a href="/m/gift/detail/${l.sellPrdtBcode}">
                                                <p class="thum"><ui:image src="${l.productImageUrl}" server="product" alt="${l.prdtName}"/></p>
                                                <p class="txt">${l.prdtName}</p>
                                                <p class="price">
                                                    <fmt:formatNumber type="number">${l.lastCpnPrice}</fmt:formatNumber>원
                                                    <c:if test="${l.prdtSellPrice>l.lastCpnPrice}"><em class="sale">[<fmt:formatNumber type="number">${hfn:rate(l.prdtSellPrice,l.lastCpnPrice)}</fmt:formatNumber>%]</em></c:if>
                                                </p>
                                            </a>
                                        </span>
                                    </c:forEach>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                    <div class="pagination"></div>
                </div>
            </c:forEach>
        </div>
    </c:if>
    <!-- 이벤트 NOW -->
    <div class="banner_basic02">
        <p style="border-left: 5px solid #ff6600;font-size: 1.2em;margin:20px 0 10px 0;padding-left: 5px;"><strong>Category</strong> Event</p>
        <ul id="eventList">
            <c:forEach items="${listEvent}" var="l" varStatus="st">
                <li>
                    <a href="/m/biz/eventDetail?eventId=${l.eventId}" class="full" title="${l.eventTitle}">
                        <p class="pic_full"><ui:image src="${l.imageUrl}" alt="${l.eventTitle}" lazy="Y" clazz="lazy"/></p>
                        <p class="tit"><strong>${fn:escapeXml(l.eventTitle)}</strong></p>
                        <p class="txt">${fn:escapeXml(l.eventDtlCont)}</p>
                    </a>
                </li>
            </c:forEach>
        </ul>
        <div class="gift_event">
            <div class="btn_area mt10 mb30"><a class="btn" href="javascript:loadEvent();"><span class="more">MORE</span></a></div>
        </div>
    </div>
    <!-- // 이벤트 NOW -->
</div>
</body>
</html>