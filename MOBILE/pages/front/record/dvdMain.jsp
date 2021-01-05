<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="record"/>
<html>
<head>
<link rel="stylesheet" type="text/css" href="/css/km_layout.css">
<script type="text/javascript" src="/js/main_loading_v3.js"></script>
<script type="text/javascript">
jQuery(function($){
    $("#cate-sub-menu .btn_more").click(function(){
        if($(this).hasClass("active")){
            $(this).removeClass("active");
            $("#cate-sub-menu .hid_obj").hide();
        }else{
            $(this).addClass("active");
            $("#cate-sub-menu .hid_obj").show();
        }
    });
});
var page = 1;
function loadEvent(){
    page++;
    $.ajax({
        type: "GET"
       ,url: "/m/hot/eventMore?orderBy=P&ctgrId=0004&page="+page
       ,dataType: "html"
       ,success : function(htmlStr){
           $("#eventList").append(htmlStr);
           $("input[name=eof]").val("0");
       }
       ,error: function(data) {
           alert('<fmt:message key="error.common.system"/>');
       }
   });
}
</script>
</head>
<body>
<div id="cate-sub-menu" class="twice">
    <div class="cate">
        <ul>
            <li><a href="/m/record/category/000401">전체 DVD 보기</a></li>
            <li><a href="/m/record/reserve/000401">예약DVD</a></li>
            <li><a href="/m/record/best/000401">DVD베스트</a></li>
            <c:forEach items="${childCategoryDvd}" var="l" varStatus="st" end="1">
                <li><a href="/m/record/category/${l.ctgrId}">${l.ctgrName}</a></li>
            </c:forEach>
        </ul>
        <ul class="hid_obj">
            <c:forEach items="${childCategoryDvd}" var="l" varStatus="st" begin="2">
                <li><a href="/m/record/category/${l.ctgrId}">${l.ctgrName}</a></li>
            </c:forEach>
        </ul>
    </div>
    <div class="cate">
        <ul>
            <li><a href="/m/record/category/000400">전체 BLU-RAY 보기</a></li>
            <li><a href="/m/record/reserve/000400">예약BLU-RAY</a></li>
            <li><a href="/m/record/best/000400">BLU-RAY베스트</a></li>
            <c:forEach items="${childCategoryBluray}" var="l" varStatus="st" end="1">
                <li><a href="/m/record/category/${l.ctgrId}">${l.ctgrName}</a></li>
            </c:forEach>
        </ul>
        <ul class="hid_obj">
            <c:forEach items="${childCategoryBluray}" var="l" varStatus="st" begin="2">
                <li><a href="/m/record/category/${l.ctgrId}">${l.ctgrName}</a></li>
            </c:forEach>
        </ul>
    </div>
    <a href="javascript://" class="btn_more"><span>카테고리 더보기</span></a>
    <hr class="hr_01" style="margin:0;"/>
</div>
<div class="container_box">
<!-- HOT ISSUE -->
<div id="hotIssue">
    <h3 class="hot_tit"><span>HOT</span> ISSUE</h3>
    <ul class="hotIssueSet" style="height: auto; width: auto;">
        <c:forEach items="${listPrdt01}" var="l" varStatus="st">
            <li class="slide_page" style="width: auto; margin: 0px; position: static; top: 0px; left: 0px; display: ${st.first?'list-item':'none'};">
                <a href="/m/record/detail/${l.sellPrdtBcode}">
                    <dl id="dlItem">
                        <dt class="image_album<c:if test="${l.sellPrdtGbn eq 'D'}"> dvd</c:if>"><ui:image prdtGbn="${l.sellPrdtGbn}" rcrdCd="${l.rcrdCd}" ratingCode="A" alt="${fn:escapeXml(l.prdtName)}"/></dt>
                        <dd class="title">${fn:escapeXml(l.prdtName)}</dd>
                        <dd class="artist">${l.artiName}</dd>
                        <dd class="price"><span class="p_price"><fmt:formatNumber type="number" value="${l.lastDcPrice}"/></span><span class="won">원</span> (<span class="p_sale"><fmt:formatNumber type="number">${hfn:rate(l.prdtSellPrice, l.lastDcPrice)}</fmt:formatNumber>%</span>)</dd>
                    </dl>
                </a>
            </li>
        </c:forEach>
    </ul>
    <div class="btn_move_area">
        <a href="#" class="btn_move_prev"><img src="http://image.kyobobook.com/mimages/static/images/hottracks/btn_muc_left.png" alt=""></a>
        <div class="btn_move_circle">
            <c:forEach items="${listPrdt01}" varStatus="st">
                <a href="#"<c:if test="${st.first}"> class="on"</c:if>>${st.count}</a>
            </c:forEach>
        </div>
        <a href="#" class="btn_move_next"><img src="http://image.kyobobook.com/mimages/static/images/hottracks/btn_muc_right.png" alt=""></a>
    </div>
</div>
<script>
var hotIssueItv;
function startEventItv(){
    hotIssueItv = window.setInterval(function(){
        var target = $('#hotIssue');
        targetPageMove(target,'next');
    }, 4000);
}
function stopEventItv(){
    window.clearInterval(hotIssueItv);
}
startEventItv();

$('#hotIssue .btn_move_circle a').click(function(e){
    e.preventDefault();
    stopEventItv();
    var target = $('#hotIssue');
    var dir = $(this).index();
    targetPageMove(target,dir);
    startEventItv();
});
$('#hotIssue .hotIssueSet').swipeleft(function(){
    stopEventItv();
    var target = $('#hotIssue');
    targetPageMove(target,'next');
    startEventItv();
}).swiperight(function(){
    stopEventItv();
    var target = $('#hotIssue');
    targetPageMove(target,'prev');
    startEventItv();
});
$('#hotIssue .btn_move_next').click(function(e){
    e.preventDefault();
    stopEventItv();
    var target = $('#hotIssue');
    targetPageMove(target,'next');
    startEventItv();
});
$('#hotIssue .btn_move_prev').click(function(e){
    e.preventDefault();
    stopEventItv();
    var target = $('#hotIssue');
    targetPageMove(target,'prev');
    startEventItv();
});
</script>
<!-- //HOT ISSUE -->

<!-- 강력추천/DAILY BEST -->
<div id="dailyBest">
    <h3 class="main_title2">
        <a href="#" class="title_tab on"><span>강력추천</span></a>
        <a href="#" class="title_tab"><span>DAILY BEST</span></a>
    </h3>

    <div class="dailyBestSet on">
        <c:forEach items="${listPrdt02}" step="2" varStatus="s1">
            <ul class="slide_page list_type_kbh">
                <c:forEach items="${listPrdt02}" var="l" varStatus="st" begin="${s1.index}" end="${s1.index+1}">
                    <li>
                        <a href="/m/record/detail/${l.sellPrdtBcode}">
                            <dl>
                                <dt class="img <c:if test="${l.sellPrdtGbn eq 'D'}"> dvd</c:if>"><ui:image prdtGbn="${l.sellPrdtGbn}" rcrdCd="${l.rcrdCd}" ratingCode="A" alt="${fn:escapeXml(l.prdtName)}"/></dt>
                                <dd class="tit">${fn:escapeXml(l.prdtName)}</dd>
                                <dd class="artist">${l.artiName}</dd>
                                <dd class="book_price"><strong><fmt:formatNumber type="number" value="${l.lastDcPrice}"/></strong>원 (<fmt:formatNumber type="number">${hfn:rate(l.prdtSellPrice, l.lastDcPrice)}</fmt:formatNumber>%)</dd>
                        </a>
                    </li>
                </c:forEach>
            </ul>
        </c:forEach>
        <div class="btn_move_area">
            <a href="#" class="btn_move_prev"><img src="http://image.kyobobook.com/mimages/static/images/common/btn_arow_left02.gif" alt=""></a>
            <div class="btn_move_circle">
                <c:forEach items="${listPrdt02}" step="2" varStatus="s1">
                    <a href="#"<c:if test="${s1.first}"> class="on"</c:if>>${s1.count}</a>
                </c:forEach>
            </div>
            <a href="#" class="btn_move_next"><img src="http://image.kyobobook.com/mimages/static/images/common/btn_arow_right02.gif" alt=""></a>
        </div>
    </div>

    <div class="dailyBestSet">
        <c:forEach items="${listPrdt03}" step="2" varStatus="s1">
            <ul class="slide_page list_type_kbh">
                <c:forEach items="${listPrdt03}" var="l" varStatus="st" begin="${s1.index}" end="${s1.index+1}">
                    <li>
                        <a href="/m/record/detail/${l.sellPrdtBcode}">
                            <dl>
                                <dt class="img <c:if test="${l.sellPrdtGbn eq 'D'}"> dvd</c:if>"><ui:image prdtGbn="${l.sellPrdtGbn}" rcrdCd="${l.rcrdCd}" ratingCode="A" alt="${fn:escapeXml(l.prdtName)}"/></dt>
                                <dd class="tit">${fn:escapeXml(l.prdtName)}</dd>
                                <dd class="artist">${l.artiName}</dd>
                                <dd class="book_price"><strong><fmt:formatNumber type="number" value="${l.lastDcPrice}"/></strong>원 (<fmt:formatNumber type="number">${hfn:rate(l.prdtSellPrice, l.lastDcPrice)}</fmt:formatNumber>%)</dd>
                        </a>
                    </li>
                </c:forEach>
            </ul>
        </c:forEach>
        <div class="btn_move_area">
            <a href="#" class="btn_move_prev"><img src="http://image.kyobobook.com/mimages/static/images/common/btn_arow_left02.gif" alt=""></a>
            <div class="btn_move_circle">
                <c:forEach items="${listPrdt03}" step="2" varStatus="s1">
                    <a href="#"<c:if test="${s1.first}"> class="on"</c:if>>${s1.count}</a>
                </c:forEach>
            </div>
            <a href="#" class="btn_move_next"><img src="http://image.kyobobook.com/mimages/static/images/common/btn_arow_right02.gif" alt=""></a>
        </div>
    </div>

</div>
<script>
$('#dailyBest .title_tab').click(function(e){
    e.preventDefault();
    $(this).addClass('on').siblings().removeClass('on');
    var idx = $(this).index();
    $('#dailyBest .dailyBestSet').hide().eq(idx).show();
});
$('#dailyBest .btn_move_area .btn_move_next').click(function(e){
    e.preventDefault();
    var target = $(this).closest('.dailyBestSet');
    targetPageMove(target,'next');
});
$('#dailyBest .btn_move_area .btn_move_prev').click(function(e){
    e.preventDefault();
    var target = $(this).closest('.dailyBestSet');
    targetPageMove(target,'prev');
});
$('#dailyBest .btn_move_circle a').click(function(e){
    e.preventDefault();
    var target = $(this).closest('.dailyBestSet');
    var dir = $(this).index();
    targetPageMove(target,dir);
});
$('#dailyBest .dailyBestSet').swipeleft(function(){
    var target = $('#dailyBest .dailyBestSet:visible');
    targetPageMove(target,'next');
}).swiperight(function(){
    var target = $('#dailyBest .dailyBestSet:visible');
    targetPageMove(target,'prev');
});

var isTablet = false;
$(window).bind('load resize',function(){
    if ( !isTablet && $('#gnb_wrap').is(':hidden') ) { //$(window).width() >=768   좀 더 깔끔한 조건식 없는지 확인
        $('#dailyBest .dailyBestSet ul li').width('20%');
        $('#dailyBest .dailyBestSet').each(function(){
            var idx2;
            $(this).find('li').each(function(idx){
                idx2 = Math.floor(idx/5);
                $(this).appendTo( $(this).closest('.dailyBestSet').find('ul').eq( idx2 ) );
            });
            $(this).find('ul').eq(idx2).nextAll('ul').remove();
            $(this).find('.btn_move_circle a').eq(idx2).nextAll().remove();
        });

        $('#dailyBest .dailyBestSet ul').hide().filter(':first-child').show();
        $('#dailyBest .btn_move_circle a').removeClass('on').filter(':first-child').addClass('on');

        var img_array = $('#dailyBest .dailyBestSet ul:first-child dt.img img');
        if( img_array.first().attr('src') != img_array.first().attr('data-original') ){
            for(i=0;i< img_array.size() ;i++){
                img_array.eq(i).attr('src', img_array.eq(i).attr('data-original') );
            }
        }

        isTablet = true;
    }
    if ( isTablet && $('#tgnb_wrap').is(':hidden') ) { //$(window).width() <768
        $('#dailyBest .dailyBestSet ul li').width('50%');
        $('#dailyBest .dailyBestSet').each(function(){
            var idx2;
            $(this).find('li').each(function(idx){
                idx2 = Math.floor(idx/2); // 필요한 ul 갯수
                if( !$(this).closest('.dailyBestSet').find('ul').eq( idx2 ).size() ) {
                    $(this).closest('.dailyBestSet').find('ul:last').after('<ul class="slide_page list_type_kbh"></ul>');
                    $(this).closest('.dailyBestSet').find('.btn_move_circle').append(' <a href="#">' + (idx2 + 1) + '</a>');
                }
                $(this).appendTo( $(this).closest('.dailyBestSet').find('ul').eq( idx2 ) );
            });

            $(this).find('.btn_move_circle a').click(function(e){
                e.preventDefault();
                var target = $(this).closest('.dailyBestSet');
                var dir = $(this).index();
                targetPageMove(target,dir);
            });
        });

        $('#dailyBest .dailyBestSet ul').hide().filter(':first-child').show();
        $('#dailyBest .btn_move_circle a').removeClass('on').filter(':first-child').addClass('on');

        isTablet = false;
    }
});
</script>
<!-- //강력추천/DAILY BEST -->
</div>
<hr class="hr_01 mt20">
<!-- 이벤트 NOW -->
<div class="banner_basic02">
    <p style="line-height: 40px;border-bottom:3px solid #ff6600;text-align: center;color: #2a2a2a;font-size: 20px;width:170px;margin:0 auto 20px;font-family:verdana;"><strong>Category</strong> Event</p>
    <ul id="eventList">
        <c:forEach items="${list}" var="l" varStatus="st">
            <li>
                <a href="/m/biz/eventDetail?eventId=${l.eventId}" class="full" title="${l.eventTitle}">
                    <p class="pic_full"><ui:image src="${l.imageUrl}" alt="${l.eventTitle}" /></p>
                    <p class="tit t_l"><strong>${fn:escapeXml(l.eventTitle)}</strong></p>
                    <p class="txt t_l">${fn:escapeXml(l.eventDtlCont)}</p>
                </a>
            </li>
        </c:forEach>
    </ul>
    <div class="btn_area box_flex mt30"><a class="btn btn_orange" href="javascript:loadEvent();"><span class="more">이벤트 더보기</span></a></div>
</div>
<!-- // 이벤트 NOW -->
</body>
</html>