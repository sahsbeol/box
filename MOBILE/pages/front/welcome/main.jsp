<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="welcome"/>
<html>
<head>
<script type="text/javascript">
var timer;
var today;
var todayNew;
function setDate(){
    var date = todayNew.getDate();
    var month = todayNew.getMonth()+1;
    var newDate = month +""+ date;
    return newDate;
}
jQuery(function($){
    var t_rtkey;
    $("#wrap").removeClass("mini");
    $("#locWelcome").addClass("active");
    $("#header div.lang").show();
    $(document).ready(function(){
        t_rtkey = setInterval(rotateKeywords, 4000);
        
        /* timer start */
        today = new Date();
        todayNew = new Date();
        Timer();
        timer = setInterval(Timer, 1000);
        
        $(".ly-main-banner").each(function(){
             var id = $(this).attr("id").replace("#", "");
             if(getCookie(id) != ("Y"+setDate())){
                $(this).show();
             }
        });
    });
    
    // 메인배너
    var welcomeSwiper = new Swiper('.swipe-main .swiper-container',{
        pagination: '.swipe-main div.pagination',
        loop:true,
        grabCursor: true,
        paginationClickable: true,
        autoplay: 3000,
        autoplayDisableOnInteraction: false
    });
    
    // 라이브포커스온
    var liveSwiper = new Swiper('.swiper-live .swiper-container', {
        pagination: '.swiper-live div.pagination',
        loop:true,
        grabCursor: true,
        paginationClickable: true
    });
    
    // 베스트
    var best01Swiper = new Swiper('.swiper-best .swiper-container', {
        pagination: '.swiper-best div.pagination',
        loop:true,
        grabCursor: true,
        paginationClickable: true
    });
    
    // 베스트_CD/DVD
    var best02Swiper = new Swiper('.swiper-music .swiper-container', {
        pagination: '.swiper-music div.pagination',
        loop:true,
        grabCursor: true,
        paginationClickable: true
    });
    
    // 베스트_MD'S PICK
    var mdspickSwiper = new Swiper('.swiper-mdspick .swiper-container', {
        pagination: '.swiper-mdspick div.pagination',
        loop:true,
        grabCursor: true,
        paginationClickable: true,
        autoplay: 3000,
        autoplayDisableOnInteraction: false
    });
    
    // 테마상품전
    var prodsSwiper = new Swiper('.swiper-prods .swiper-container', {
        pagination: '.swiper-prods div.pagination',
        loop:true,
        grabCursor: true,
        paginationClickable: true
    });
    
     // 레코벨
    var best01Swiper = new Swiper('.swiper-recobell .swiper-container', {
        pagination: '.swiper-recobell div.pagination',
        loop:true,
        grabCursor: true,
        paginationClickable: true
    });
    
    $("#keywordMore").click(function(){
        if($(this).hasClass("active")){
            $(this).removeClass("active");
            $(".keyword_list").slideUp();
        }else{
            $(this).addClass("active");
            $(".keyword_list").slideDown();
        }
    });
    
    function rotateKeywords(){
        var keywords = $(".keyword_list span");
        var length = keywords.length;
        var idx = keywords.index($(".keyword_list span.active"));
        keywords.eq(idx).removeClass("active");
        if(idx+1 < length){
            idx++;
        }else{
            idx = 0;
        }
        keywords.eq(idx).addClass("active");
        $("#titKeyword").empty();
        $("#titKeyword").append(keywords.eq(idx).clone(true));
    }
});
function Timer(){
    var now = new Date();
    var end = new Date();
    end.setHours(23);
    end.setMinutes(59);
    end.setSeconds(59);
    
    var H = end.getHours() - now.getHours();
    var M = end.getMinutes() - now.getMinutes();
    var S = end.getSeconds() - now.getSeconds();
    
    if((now.getDate() - today.getDate()) > 0){
        //alert("현재 시각 정시 기준으로\n원데이 특가가 업데이트 되었습니다.");
        location.replace("/m/welcomeMain?"+H+M+S);
    }
    $("#txtOddTime").text(lpad(H, 2, '0') + ":" + lpad(M, 2, '0') + ":" + lpad(S, 2, '0'));
}

function goRecordBest(){
    if($(".swiper-music div.pagination .swiper-pagination-switch").eq(0).hasClass("swiper-active-switch")){
        location.href = "/m/record/best/0003";
    }else{
        location.href = "/m/record/best/000401";
    }
}
</script>
<style>
/* common.css 통합 */
.wd100 {
    width: 100%;
}
.tit_h2 {
    font-size: 18px;
    font-weight: bold;
    color: #000;
}
.bt_line {
    border-top: 1px solid #eee;
}
.bb_line {
    border-bottom: 16px solid #eee;
}
.bb_line_w {
    border-bottom: 16px solid #fff;
}
/* content.css 통합 */
.tit_today {
    padding: 20px;
    text-align: center;
    background: linear-gradient(to right, #02aab0, #00cdac);
}

.welcome_wrap .recobell_zone .tit_rlist{
    margin: 46px 20px;
    padding-bottom: 8px;
    text-align: left;
    font-size: 18px;
    color: #000;
    font-weight: bold;
    position: absolute;
    z-index: 2;
}

/* main css 추가 */
.welcome_wrap .box_cont {
	margin:0px;
}
.welcome_wrap .hotdeal_zone {
	margin-bottom:16px;
}
.welcome_wrap .recobell_zone .swiper-container {
	margin: 0 auto 16px;
}
.welcome_wrap .best_zone .swiper-container {
	margin:0px;
}
.welcome_wrap .best_box {
	margin: 32px 10px 32px;
}
.welcome_wrap .dotted_zone {
    padding: 14px 23px 24px;
    display: -webkit-box;
    background-color: #fff;
    margin:0px;
}
.welcome_wrap .dotted_zone a {
    display: block;
    -webkit-box-flex: 1;
    width: calc(100%/5);
}
.welcome_wrap .dotted_zone a img {
    max-width: 96%;
    background-color: #EFEFEF;
    border-radius: 50%;
}
.welcome_wrap .dotted_zone a p.t_c {
    font-size: 12px;
    margin-top: 7px;
}

@media only screen and (max-device-width : 320px){
	.welcome_wrap .dotted_zone a p.t_c {
		font-size: 11px;
	}
}

.welcome_wrap .dotted_zone a + a {
    margin-left: 17px;
}
.welcome_wrap .best_box .swiper-container {
	margin: 40px auto 7px !important;
}
.welcome_wrap .best_box .box_cont {
	margin: 0px;
}
.welcome_wrap .mdspick_zone {
	margin: 16px 0 16px;
}
.welcome_wrap .hotevent {
	margin-top: 16px;
}
.welcome_wrap .event_banner + .event_banner {
	margin-top: 16px;
}
.welcome_wrap .prods_zone .box_cont .tit_prods {
	margin: 10px 0 10px 5px;
}
.welcome_wrap .prods_zone .swiper-container {
	margin: 0 auto 16px;
}
</style>
</head>
<body>
<c:if test="${empty todayBnr || todayBnr eq 'N'}">
    <c:forEach items="${listBnrPop}" var="l" varStatus="st">
        <c:if test="${st.first}">
            <div id="layerBanner${l.bnrSeq}" class="ly-main-banner" style="display:none;position:fixed;left:0;top:0;width:100%;height:100%;background:url('/images/season01/bg_layer02.png');z-index:999;display:none;">
                <div style="display: block;margin:20px auto;max-width:290px;position: relative;top:50%;margin-top:-150px;">
                    <c:choose>
                        <c:when test="${l.bnrLnkUrl eq '~'}"><ui:image src="${l.bnrImgUrl}" style="width:100%;"/></c:when>
                        <c:otherwise>
                            <a href="#" onclick="location.href='${l.bnrLnkUrl}';return false;" style="position:relative;font-size:15px;font-weight:bold;"><ui:image src="${l.bnrImgUrl}" style="width:100%;"/></a>
                        </c:otherwise>
                    </c:choose>
                    <a href="#" onclick="Fn_closeLayer('#layerBanner${l.bnrSeq}', 'Y', setDate());return false;" style="display:block;color:#fff;text-decoration:underline;margin-top:10px;text-align:center;">오늘 하루 그만보기</a>
                    <a href="#" onclick="Fn_closeLayer('#layerBanner${l.bnrSeq}', 'N', setDate());return false;" style="position: absolute;top: -25px;right: 0;display: block;width: 20px;height: 20px;background: url(/images/season01/btn_close01.png) 50% 50% no-repeat;text-indent: -999px;overflow: hidden;background-size: 31px 31px;">닫기</a>
                </div>
            </div>
        </c:if>
    </c:forEach>
</c:if>
    <div class="welcome_wrap">
        <section class="welcomemain">
        <c:if test="${not empty listBnrTop}">
            <c:forEach items="${listBnrTop}" var="l" varStatus="st">
                <a href="#" onclick="location.href='${l.bnrLnkUrl}';return false;"><ui:image src="${l.bnrImgUrl}" alt="${l.bnrImgAlt}" style="width:100%;"/></a>
            </c:forEach>
        </c:if>
        <!-- swiper -->
        <div class="visual swipe-main">
            <div class="swiper-container">
                <ul class="swiper-wrapper">
                    <c:forEach items="${listBnr01}" var="l" varStatus="st" end="13">
                        <li class="swiper-slide">
                            <a href="#" onclick="location.href='${l.bnrLnkUrl}';return false;"><ui:image src="${l.bnrImgUrl}" alt="${l.bnrImgAlt}" clazz="prdt-photo MB_1_MAIN"/></a>
                        </li>
                    </c:forEach>
                </ul>
            </div>
            <div class="pagination"></div>
        </div>
        <!-- //swiper -->
        
        <!-- Realtime Keywords -->
        <div class="realtime_keyword MB_2_RANK">
            <p class="realtime_view">
                <span class="tit_realtime">실시간 검색어</span>
                <span id="titKeyword">
                    <c:forEach items="${listBestKeyword}" var="l" varStatus="st" end="0">
                        <span class="rank_arrow<c:if test="${l.prevRank eq 0 || l.prevRank > l.ranking}"> rank_up</c:if><c:if test="${l.prevRank ne 0 && l.prevRank < l.ranking}"> rank_down</c:if>"><em>${st.count}</em> <a href="#" onclick="gnbSrchKerword('${l.keyword}');return false;">${l.keyword}</a></span>
                    </c:forEach>
                </span>
            </p>
            <a id="keywordMore" class="btn_more rotate">more</a>
            <div class="keyword_list">
                <h5>인기 검색어 TOP 5</h5>
                <c:forEach items="${listBestKeyword}" var="l" varStatus="st" end="4">
                    <span class="rank_arrow<c:if test="${st.first}"> active</c:if><c:if test="${l.prevRank eq 0 || l.prevRank > l.ranking}"> rank_up</c:if><c:if test="${l.prevRank ne 0 && l.prevRank < l.ranking}"> rank_down</c:if>"><em>${st.count}</em> <a href="#" onclick="gnbSrchKerword('${l.keyword}');return false;">${l.keyword}</a></span>
                </c:forEach>
            </div>
        </div>
        <!-- //Realtime Keywords -->
        <!-- Today's Diary -->
        <c:if test="${not empty listDiary}">
            <div class="MB_2-1_DIARY">
                <div class="todays_diary"><!--  banner type01 -->
                    <c:forEach items="${listDiary}" var="l" varStatus="st">
                        <c:if test="${st.first}"><h5 class="tit_diary">${l.eventTitle}</h5></c:if>
                        <c:set var="linkUrl" value="/p/${l.sellPrdtBcode}"/>
                        <c:if test="${not empty l.eventLinkUrl}"><c:set var="linkUrl" value="${l.eventLinkUrl}"/></c:if>
                        <a href="#" onclick="location.href='${linkUrl}';return false;">
                            <span class="pic"><ui:image src="${l.productImageUrl}" server="product" alt="${l.prdtName}"/></span>
                            <span class="bnft">
                                <c:choose>
                                    <c:when test="${l.mainYn eq 'Y'}">
                                        <fmt:formatNumber pattern="##" value="${hfn:rate(l.prdtSellPrice, l.lastCpnPrice)}"/>%
                                    </c:when>
                                    <c:otherwise>1 + 1</c:otherwise>
                                </c:choose>
                            </span>
                            <span class="prdt-name">${l.prdtName}</span>
                            <span class="price">
                                <c:if test="${l.prdtSellPrice ne l.lastCpnPrice}">
                                    <em><fmt:formatNumber type="number" value="${l.prdtSellPrice}"/></em>
                                </c:if>
                                <fmt:formatNumber type="number" value="${l.lastCpnPrice}"/>
                            </span>
                        </a>
                    </c:forEach>
                </div>
            </div>
        </c:if>
        <!-- Today's Diary -->
        <!-- 1 DAY DEAL -->
        <div class="MB_3_DEAL">
            <div class="hotdeal_zone"><!--  banner type01 -->
                <h5 class="tit_hotdeal<c:if test="${isWeekend}"> week</c:if>">1 DAY DEAL</h5>
                <p class="time"><em id="txtOddTime">00:00:00</em></p>
                <c:forEach items="${listHotdeal}" var="l" varStatus="st">
                <c:set var="linkUrl" value="/m/gift/detail/${l.sellPrdtBcode}"/>
                <c:if test="${not empty l.eventId}"><c:set var="linkUrl" value="/m/biz/eventDetail?eventId=${l.eventId}"/></c:if>
                <a href="#" onclick="location.href='${linkUrl}';return false;">
                    <span class="pic"><ui:image src="${l.productImageUrl}" server="product" alt="${l.prdtName}"/></span>
                    <span class="bnft"><fmt:formatNumber pattern="##" value="${hfn:rate(l.prdtSellPrice, l.lastCpnPrice)}"/>%</span>
                    <span class="prdt-name">${l.prdtName}</span>
                    <span class="price">
                        <c:if test="${l.prdtSellPrice ne l.lastCpnPrice}">
                            <em><fmt:formatNumber type="number" value="${l.prdtSellPrice}"/></em>
                        </c:if>
                        <fmt:formatNumber type="number" value="${l.lastCpnPrice}"/>
                    </span>
                </a>
                </c:forEach>
            </div>
        </div>
        <!-- 1 DAY DEAL -->
        
        <!-- 오늘의 추천 배너 -->
        <a href="/m/hot/todayrecommend" class="wd100" style="border-bottom:13px solid #eee;">
	        <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/bnr_01.jpg" style="width:100%;" alt="ban_event" class="MB_TODAY">
        </a>
        <!-- / 오늘의 추천 배너 -->
        
        <!-- 레코벨 추천상품 start -->
        <c:if test="${not empty listRecobell}">
        <div class="recobell_zone swiper-recobell">
            <p class="tit_rlist">내게 맞는 추천상품</p>
            <div class="swiper-container">
                <div class="swiper-wrapper">
                    <c:forEach begin="0" end="29" varStatus="s0" step="6">
                        <div class="swiper-slide">
                            <div class="box_cont">
                                 <p class="tit_prods">내게 맞는 추천상품</p>
                                <c:forEach items="${listRecobell}" varStatus="s1" begin="${s0.index}" end="${s0.index+5}" step="3">
                                    <div class="row MD_10_RECO">
                                        <c:forEach items="${listRecobell}" var="l" begin="${s1.index}" end="${s1.index+2}">
                                            <a href="#" onclick="location.href='/p/${l.sellPrdtBcode}?foo=bar&rccode=mo_main1';return false;" class="box_prod row_item">
                                                <c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G'}"><p class="pic"><ui:image src="${l.productImageUrl}" server="product" alt="${fn:escapeXml(l.prdtName)}"/></p></c:if>
                                                <c:if test="${l.sellPrdtGbn eq 'R'}"><p class="pic"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="R" ratingCode="A" alt="${fn:escapeXml(l.prdtName)}"/></p></c:if>
                                                <c:if test="${l.sellPrdtGbn eq 'D'}"><p class="pic dvd"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="D" ratingCode="A" alt="${fn:escapeXml(l.prdtName)}"/></p></c:if>
                                                <p class="tit">${l.prdtName}</p>
                                                <p class="price">
                                                    <fmt:formatNumber type="number">${l.lastCpnPrice}</fmt:formatNumber>원
                                                    <fmt:parseNumber var="rate" type="number" value="${hfn:rate(l.prdtSellPrice,l.lastCpnPrice)}"/>
                                                    <fmt:parseNumber var="rate" type="number" value="${rate+(1-(rate%1))%1}" integerOnly="true"/>
                                                    <c:if test="${rate > 0}"><span class="sale">[${rate}%]</span></c:if>
                                                </p>
                                            </a>
                                        </c:forEach>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
            <div class="pagination"></div>
        </div>
        </c:if>
        <!-- 레코벨 추천상품 end -->
        
        <!-- LINE BANNER - 1 -->
        <c:forEach items="${listBnr03_1}" var="l" varStatus="st">
            <div class="event_banner bb_line"><!--  banner type01 -->
                <a href="#" onclick="location.href='${l.bnrLnkUrl}';return false;">
                    <p class="pic"><ui:image src="${l.bnrImgUrl}" alt="${l.bnrImgAlt}" clazz="MB_4_EVENT"/></p>
                </a>
            </div>
        </c:forEach>
        <!-- LINE BANNER - 1 -->
        
        <!-- DOTTED BANNER - 1 -->
        <div class="dotted_zone bb_line">
	        <c:forEach items="${listBnr03_2}" var="l" varStatus="st">
	            <a href="${l.bnrLnkUrl}">
	            	<c:choose>
		                <c:when test="${st.count eq '5'}">
		                    <p class="t_c"><ui:image src="${l.bnrImgUrl}" alt="${l.bnrImgAlt}" clazz="prdt-photo MB_MAIN_FREE" id="MB_5_CATE_${st.count }"/></p>
		                </c:when>
		                <c:otherwise>
		                    <p class="t_c"><ui:image src="${l.bnrImgUrl}" alt="${l.bnrImgAlt}" clazz="prdt-photo" id="MB_5_CATE_${st.count }"/></p>
		                </c:otherwise>
		            </c:choose>
	            	<p class="t_c">${l.bnrTitle}</p>
	            </a>
	        </c:forEach>
        </div>
        <!-- DOTTED BANNER - 1 -->
        
        <!-- Live Focus On -->
        <c:if test="${not empty listFocusOn}">
        <div class="focuson_zone swiper-live">
            <p class="tit_focuson"><img src="${imageServer}/images/mobile/content/tit_hottracks_live02.png" alt="HOTTRACKS Live"/></p>
            <div class="swiper-container">
                <div class="swiper-wrapper">
                    <c:forEach items="${listFocusOn}" varStatus="s0" step="4" end="15">
                        <div class="swiper-slide">
                            <div class="box_cont">
                                <c:forEach items="${listFocusOn}" varStatus="s1" begin="${s0.index}" end="${s0.index+3}" step="2">
                                    <div class="row" style="text-align: center;">
                                        <c:forEach items="${listFocusOn}" var="l" begin="${s1.index}" end="${s1.index+1}">
                                            <a href="#" onclick="location.href='/p/${l.sellPrdtBcode}';return false;" class="box_prod row_item">
                                                <c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G'}"><p class="pic"><ui:image src="${l.productImageUrl}" server="product" alt="${fn:escapeXml(l.prdtName)}" clazz="MB_6_LIVE"/></p></c:if>
                                                <c:if test="${l.sellPrdtGbn eq 'R'}">
                                                    <p class="pic"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="R" ratingCode="A" alt="${fn:escapeXml(l.prdtName)}" clazz="MB_6_LIVE"/></p>
                                                </c:if>
                                                <c:if test="${l.sellPrdtGbn eq 'D'}"><p class="pic dvd"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="D" ratingCode="A" alt="${fn:escapeXml(l.prdtName)}"/></p></c:if>
                                                <p class="tit">${l.prdtName}</p>
                                                <p class="price">
                                                    <fmt:formatNumber type="number">${l.lastCpnPrice}</fmt:formatNumber>원
                                                    <fmt:parseNumber var="rate" type="number" value="${hfn:rate(l.prdtSellPrice,l.lastCpnPrice)}"/>
                                                    <fmt:parseNumber var="rate" type="number" value="${rate+(1-(rate%1))%1}" integerOnly="true"/>
                                                    <c:if test="${rate > 0}"><span class="sale">[${rate}%]</span></c:if>
                                                </p>
                                            </a>
                                        </c:forEach>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
            <div class="pagination"></div>
        </div>
        </c:if>
        <!-- Live Focus On -->
        
        <!-- DOTTED BANNER - 1 -->
        <c:set var="fgColor" value="#000"/>
        <c:set var="bgColor" value="#e1b9b7"/>
        <c:if test="${not empty mstBnr04.imgAlt}">
            <c:choose>
                <c:when test="${fn:contains(mstBnr04.imgAlt, '/')}">
                    <c:set var="bgColor" value="${fn:split(mstBnr04.imgAlt, '/')[0]}"/>
                    <c:set var="fgColor" value="${fn:split(mstBnr04.imgAlt, '/')[1]}"/>
                </c:when>
                <c:otherwise>
                    <c:set var="bgColor" value="${mstBnr04.imgAlt}"/>
                </c:otherwise>
            </c:choose>
        </c:if>
        <div class="dotted_zone02"<c:if test="${not empty mstBnr04.imgAlt}"> style="background-color:${bgColor}"</c:if>>
            <c:forEach items="${listBnr04}" varStatus="s1" step="3">
                <div class="row">
                    <c:forEach items="${listBnr04}" var="l" varStatus="st" begin="${s1.index}" end="${s1.index+2}">
                        <a href="#" onclick="location.href='${l.bnrLnkUrl}';return false;">
                            <span><ui:image src="${l.bnrImgUrl}" alt="${l.bnrImgAlt}" clazz="prdt-photo"  id="MB_7_DOT_${st.count }"/></span>
                            <span style="color:${fgColor};">#${l.bnrTitle}</span>
                        </a>
                    </c:forEach>
                </div>
            </c:forEach>
        </div>
        <!-- DOTTED BANNER - 1 -->
        
        <!-- best/new -->
        <div class="best_zone swiper-best">
            <p class="tit_bestitem"><img src="${imageServer}/images/mobile/content/tit_bestitem02.png" alt="Best Item"/></p>
            <div class="swiper-container">
                <div class="swiper-wrapper">
                    <c:forEach items="${listBest}" varStatus="s0" step="4" end="11">
                        <div class="swiper-slide">
                            <div class="box_cont">
                                <c:forEach items="${listBest}" varStatus="s1" begin="${s0.index}" end="${s0.index+3}" step="2">
                                    <div class="row">
                                        <c:forEach items="${listBest}" var="l" begin="${s1.index}" end="${s1.index+1}">
                                        <div class="row_box">
                                            <a href="#" onclick="location.href='/p/${l.sellPrdtBcode}';return false;" class="box_prod row_item">
                                                    <c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G'}"><p class="pic"><ui:image src="${l.productImageUrl}" server="product" alt="${fn:escapeXml(l.prdtName)}" clazz="MB_8_BEST"/></p></c:if>
                                                    <c:if test="${l.sellPrdtGbn eq 'R'}"><p class="pic"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="R" ratingCode="A" alt="${fn:escapeXml(l.prdtName)}" clazz="MB_8_BEST"/></p></c:if>
                                                    <c:if test="${l.sellPrdtGbn eq 'D'}"><p class="pic dvd"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="D" ratingCode="A" alt="${fn:escapeXml(l.prdtName)}" clazz="MB_8_BEST"/></p></c:if>
                                                    <p class="tit">${l.prdtName}</p>
                                                    <p class="price">
                                                        <fmt:formatNumber type="number">${l.lastCpnPrice}</fmt:formatNumber>원
                                                        <fmt:parseNumber var="rate" type="number" value="${hfn:rate(l.prdtSellPrice,l.lastCpnPrice)}"/>
                                                        <fmt:parseNumber var="rate" type="number" value="${rate+(1-(rate%1))%1}" integerOnly="true"/>
                                                        <c:if test="${rate > 0}"><span class="sale">[${rate}%]</span></c:if>
                                                    </p>
                                                </a>
                                        </div>
                                        </c:forEach>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
            <div class="pagination"></div>
            <a href="#" onclick="location.href='/m/hot/best?dispMstrId=CATE_GFT_BEST';return false;" class="btn_more"><img src="${imageServer}/images/mobile/content/btn_more02.png" alt="더보기"/></a>
        </div>
        <!-- //best/new -->
        
        <div class="best_box swiper-music">
            <p class="tit_bestitem"><img src="${imageServer}/images/mobile/content/tit_cddvd_best02.png" alt="CD/DVD Best"/></p>
            <div class="swiper-container" >
                <div class="swiper-wrapper">
                    <c:forEach begin="0" end="1" varStatus="s0">
                        <c:if test="${s0.index eq 0}"><c:set var="list" value="${listRecord}"/></c:if>
                        <c:if test="${s0.index eq 1}"><c:set var="list" value="${listDvd}"/></c:if>
                        <div class="swiper-slide">
                            <div class="box_cont">
                                <c:forEach items="${list}" varStatus="s1" end="5" step="3">
                                    <div class="row">
                                        <c:forEach items="${list}" var="l" begin="${s1.index}" end="${s1.index+2}">
                                            <a href="#" onclick="location.href='/p/${l.sellPrdtBcode}';return false;" class="box_prod row_item">
                                                <c:if test="${l.sellPrdtGbn eq 'R'}"><p class="pic"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="R" ratingCode="A" alt="${l.commTitle}" clazz="MB_CDDVD"/></p></c:if>
                                                <c:if test="${l.sellPrdtGbn eq 'D'}"><p class="pic dvd"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="D" ratingCode="A" alt="${l.commTitle}" clazz="MB_CDDVD"/></p></c:if>
                                                <p class="tit">${l.commTitle}</p>
                                                <p class="price">
                                                    <fmt:formatNumber type="number">${l.lastCpnPrice}</fmt:formatNumber>원
                                                    <c:if test="${l.prdtSellPrice > l.lastCpnPrice}">
                                                        <fmt:parseNumber var="rate" integerOnly="true" value="${hfn:rate(l.prdtSellPrice,l.lastCpnPrice)}" />
                                                        <span class="sale">[${rate}%]</span>
                                                    </c:if>
                                                </p>
                                            </a>
                                        </c:forEach>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
            <div class="pagination"></div>
            <a href="#" onclick="goRecordBest();return false;" class="btn_more"><img src="${imageServer}/images/mobile/content/btn_more02.png" alt="더보기"/></a>
        </div>
        
        <!-- EVENT BANNER - 1 -->
        <div class="event_box01">
            <c:forEach items="${listBnr02}" var="l" begin="0" end="0">
                <div class="event_banner"><!--  banner type01 -->
                    <a href="#" onclick="location.href='${l.bnrLnkUrl}';return false;">
                        <p class="pic"><ui:image src="${l.bnrImgUrl}" alt="${l.bnrImgAlt}"/></p>
                        <p class="tit">${l.bnrTitle}</p>
                        <p class="txt">${l.bnrSubTitle}</p>
                    </a>
                </div>
            </c:forEach>
        </div>
        <!-- EVENT BANNER - 1 -->
        
        <!-- md's pick -->
        <c:if test="${not empty listMdsPick && fn:length(listMdsPick) > 5}">
            <div class="mdspick_zone swiper-mdspick">
                <p class="tit_mdspick"><img src="${imageServer}/images/mobile/content/tit_mdspick02.png" alt="MD's Pick"/></p>
                <div class="swiper-container">
                    <div class="swiper-wrapper">
                        <c:choose>
                            <c:when test="${fn:length(listMdsPick) eq 30}"><c:set var="size" value="30"/></c:when>
                            <c:otherwise>
                                <c:set var="size" value="${fn:length(listMdsPick)}"/>
                                <c:set var="size" value="${size - (size%6)}"/>
                            </c:otherwise>
                        </c:choose>
                        <c:forEach items="${listMdsPick}" varStatus="s0" step="6" end="${size-1}">
                            <div class="swiper-slide">
                                <div class="box_cont">
                                    <c:forEach items="${listMdsPick}" varStatus="s1" begin="${s0.index}" end="${s0.index+5}" step="3">
                                        <div class="row">
                                            <c:forEach items="${listMdsPick}" var="l" begin="${s1.index}" end="${s1.index+2}">
                                                <a href="#" onclick="location.href='/p/${l.sellPrdtBcode}';return false;" class="box_prod row_item">
                                                    <c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G'}"><p class="pic"><ui:image src="${l.productImageUrl}" server="product" alt="${fn:escapeXml(l.prdtName)}" clazz="MB_9_MDPICK"/></p></c:if>
                                                    <c:if test="${l.sellPrdtGbn eq 'R'}"><p class="pic"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="R" ratingCode="A" alt="${fn:escapeXml(l.prdtName)}" clazz="MB_9_MDPICK"/></p></c:if>
                                                    <c:if test="${l.sellPrdtGbn eq 'D'}"><p class="pic dvd"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="D" ratingCode="A" alt="${fn:escapeXml(l.prdtName)}" clazz="MB_9_MDPICK"/></p></c:if>
                                                    <p class="tit">${l.prdtName}</p>
                                                    <p class="price">
                                                        <fmt:formatNumber type="number">${l.lastCpnPrice}</fmt:formatNumber>원
                                                        <fmt:parseNumber var="rate" type="number" value="${hfn:rate(l.prdtSellPrice,l.lastCpnPrice)}"/>
                                                        <fmt:parseNumber var="rate" type="number" value="${rate+(1-(rate%1))%1}" integerOnly="true"/>
                                                        <c:if test="${rate > 0}"><span class="sale">[${rate}%]</span></c:if>
                                                    </p>
                                                </a>
                                            </c:forEach>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
                <div class="pagination"></div>
            </div>
        </c:if>
        <!-- md's pick -->
        
        <!-- EVENT BANNER - 1 -->
        <div class="event_box01">
            <c:forEach items="${listBnr02}" var="l" begin="1" end="2">
                <div class="event_banner"><!--  banner type01 -->
                    <a href="#" onclick="location.href='${l.bnrLnkUrl}';return false;">
                        <p class="pic"><ui:image src="${l.bnrImgUrl}" alt="${l.bnrImgAlt}"/></p>
                        <p class="tit">${l.bnrTitle}</p>
                        <p class="txt">${l.bnrSubTitle}</p>
                    </a>
                </div>
            </c:forEach>
        </div>
        <!-- EVENT BANNER - 1 -->
        </section>
        <section class="hotevent">
            <!-- TITLE DISP PRODUCT 1~3 -->
            <c:if test="${not empty listPrdt01 && not empty listPrdt02 && not empty listPrdt03}">
                <div class="prods_zone swiper-prods">
                    <div class="swiper-container">
                        <div class="swiper-wrapper">
                            <c:forEach begin="0" end="2" varStatus="s0">
                                <c:if test="${s0.index eq 0}"><c:set var="title" value="${mstPrdt01.title}"/><c:set var="list" value="${listPrdt01}"/></c:if>
                                <c:if test="${s0.index eq 1}"><c:set var="title" value="${mstPrdt02.title}"/><c:set var="list" value="${listPrdt02}"/></c:if>
                                <c:if test="${s0.index eq 2}"><c:set var="title" value="${mstPrdt03.title}"/><c:set var="list" value="${listPrdt03}"/></c:if>
                                <div class="swiper-slide">
                                    <div class="box_cont">
                                        <p class="tit_prods">${title}</p>
                                        <c:forEach items="${list}" varStatus="s1" end="5" step="3">
                                            <div class="row">
                                                <c:forEach items="${list}" var="l" begin="${s1.index}" end="${s1.index+2}">
                                                    <a href="#" onclick="location.href='/p/${l.sellPrdtBcode}';return false;" class="box_prod row_item">
                                                        <c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G'}"><p class="pic"><ui:image src="${l.productImageUrl}" server="product" alt="${fn:escapeXml(l.prdtName)}"/></p></c:if>
                                                        <c:if test="${l.sellPrdtGbn eq 'R'}"><p class="pic"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="R" ratingCode="A" alt="${fn:escapeXml(l.prdtName)}"/></p></c:if>
                                                        <c:if test="${l.sellPrdtGbn eq 'D'}"><p class="pic dvd"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="D" ratingCode="A" alt="${fn:escapeXml(l.prdtName)}"/></p></c:if>
                                                        <p class="tit">${l.prdtName}</p>
                                                        <p class="price">
                                                            <fmt:formatNumber type="number">${l.lastCpnPrice}</fmt:formatNumber>원
                                                            <fmt:parseNumber var="rate" type="number" value="${hfn:rate(l.prdtSellPrice,l.lastCpnPrice)}"/>
                                                            <fmt:parseNumber var="rate" type="number" value="${rate+(1-(rate%1))%1}" integerOnly="true"/>
                                                            <c:if test="${rate > 0}"><span class="sale">[${rate}%]</span></c:if>
                                                        </p>
                                                    </a>
                                                </c:forEach>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                    <div class="pagination"></div>
                </div>
            </c:if>
            <!-- TITLE DISP PRODUCT 1~3 -->
            
            <c:forEach items="${listBnr02}" var="l" begin="3">
                <div class="event_banner"><!--  banner type01 -->
                    <a href="#" onclick="location.href='${l.bnrLnkUrl}';return false;">
                        <p class="pic"><ui:image src="${l.bnrImgUrl}" alt="${l.bnrImgAlt}"/></p>
                        <p class="tit">${l.bnrTitle}</p>
                        <p class="txt">${l.bnrSubTitle}</p>
                    </a>
                </div>
            </c:forEach>
            <div class="btn_area">
                <a class="btn" href="#" onclick="location.href='/m/hot/eventMain';return false;">
                    <span class="more">MORE</span>
                </a>
            </div>
        </section>
    </div>
</body>
</html>
