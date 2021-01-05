<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="welcome"/>
<html>
<head>
<c:set value="12221444" var="temp"/>
<link rel="stylesheet" type="text/css" href="/css/chart.css?${temp }">
<title>음반 메인 - NEW ME HOTTRACKS</title>
<script type="text/javascript">
jQuery(function($){
    $("#wrap").removeClass("mini");
    $("#locMusic").addClass("active");
    
    $(document).ready(function(){
         // 메인배너
         var musiceSwiper = new Swiper('.swipe-main .swiper-container',{
             pagination: '.swipe-main div.pagination',
             loop:true,
             grabCursor: true,
             paginationClickable: true
         });
         
         // 예약음반
         var liveSwiper = new Swiper('.swiper-live .swiper-container', {
             pagination: '.swiper-live div.pagination',
             loop:true,
             grabCursor: true,
             paginationClickable: true
         });
         
         
         // 뮤직메인
         var musiceSwiper02 = new Swiper('.swipe-main02 .swiper-container',{
             grabCursor: true,
             slidesPerView: 2.7,
             freeMode:true
         });
         
    });
});
</script>
</head>
<body>
<!-- 롤링배너 -->
<div class="music_wrap">
    <section class="musicmain">
    <!-- visual swipe-main 시작 -->
        <div class="visual swipe-main">
            <div class="swiper-container">
                <ul class="swiper-wrapper" >
                    <c:forEach items="${listBnr01}" var="l" varStatus="st">
                        <li class="swiper-slide">
                            <a href="${l.bnrLnkUrl}"<c:if test="${l.bnrNewWinYn eq 'Y'}"> target="_blank"</c:if>><ui:image src="${l.bnrImgUrl}" alt="${l.bnrImgAlt}" clazz="prdt-photo"/></a>
                            <%-- <ui:image prdtGbn="${l.sellPrdtGbn}" rcrdCd="${l.rcrdCd}" ratingCode="A" alt="${fn:escapeXml(l.prdtName)}"/> --%>
                        </li>
                    </c:forEach>
                </ul>
            </div>
            <div class="pagination ">
                <span class="swiper-pagination-switch"></span>
            </div> <!-- pagination -->
        </div> <!-- visual swipe-main 끝 -->
    
        <!--  예약 음반 (Re_music swiper-live) 시작-->
        <div class="Re_music swiper-live mt10">
            <p class="box_tit"><span>예약음반</span></p>
            <div class="swiper-container">
                <ul class="swiper-wrapper">
                    <c:forEach items="${listBnr02}" varStatus="s1" begin="0" end="17" step="6" > 
                        <li class="swiper-slide">
                            <div class="box_cont roundbox mt10 mb0">
                                <c:forEach items="${listBnr02}" var="l" begin="${s1.index}" end="${s1.index+5}">
                                <div class="music_div">
                                    <a href="/m/record/detail/${l.sellPrdtBcode}" class="music_prod" >
                                        <p class="pic"><ui:image prdtGbn="${l.sellPrdtGbn}" rcrdCd="${l.rcrdCd}" ratingCode="A" alt="${fn:escapeXml(l.prdtName)}"/></p>
                                        <p class="tit"><strong>${fn:escapeXml(l.basePrdtName)}</strong></p>  
                                        <p class="stit">${fn:escapeXml(l.artiName)}</p> 
                                        <p class="price">
                                            <strong><!--  판매가격 -->
                                                <fmt:formatNumber type="number" value="${l.lastDcPrice }"/>
                                                <!--  쿠폰 적용 가격 -->
                                                <c:if test="${l.prdtSellPrice ne l.lastDcPrice}">
                                                    <span class="sale">[<fmt:formatNumber type="number">${hfn:rate(l.prdtSellPrice, l.lastDcPrice)}</fmt:formatNumber>%]</span>
                                                </c:if>
                                            </strong>
                                        </p>
                                    </a>
                                </div>
                                </c:forEach>
                            </div>
                        </li>
                    </c:forEach>
                </ul><!-- swiper wrapper -->
            </div> <!-- swiper-container -->
            <div class="pagination">
                <span class="swiper-active-switch"></span>
            </div><!-- pagination -->
        </div>
        <!--  예약 음반 (Re_music swiper-live) 끝-->
        
        <!--  뮤직매거진 시작-->
        <div class="visual02 swipe-main02 mt10">
            <p class="box_tit">
                <span>뮤직 매거진</span>
                <a id="more" href="/m/idol/news"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/common/plus.png" alt="더보기"/></a>
            </p>
            <div class="swiper-container">
                <ul class="swiper-wrapper" >
                    <c:forEach items="${idolNews}" var="l" varStatus="st" begin="0" end="9">
                        <li class="swiper-slide">
                            <a href="/m/idol/newsDetail?cntid=${l.cntid }">
                                <p class="img" style="background:url('${l.image }') center center no-repeat; background-size:cover;"></p>
                                <div class="div_bnr">
                                    <span class="title">${l.title } </span>
                                    <span class="date">${l.pubdt }</span>
                                </div>
                            </a>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </div>
        <!--  뮤직매거진 끝-->
        
        <!--  뮤직매거진 기사 시작-->
        <div class="music_news">
            <ul class="music_news1">
                <c:forEach items="${idolNews}" var="l"  begin="10" end="11" varStatus="st">
                    <li>
                        <div class="music_news_div">
                            <a href="/m/idol/newsDetail?cntid=${l.cntid }">
                                <div class="music_news_detail">
                                    <span class="title">${l.title } </span>
                                    <span class="date">${l.pubdt }</span>
                                </div>
                                <div class="music_news_pic">
                                <p class="img" style="background:url('${l.image }') center center no-repeat; background-size: cover;"></p>
                                </div>
                            </a>
                        </div>
                    </li>
                </c:forEach>
            </ul>
            <!-- 뮤직 메거진 -->
            <ul class="music_news2">
                <c:forEach items="${idolReport }" var="l" begin="0" end="4" varStatus="st">
                    <li>
                        <div class="music_report">
                            <a href="/m/idol/specialDetail?cntid=${l.cntid }">
                                <div class="music_report_detail">
                                    <span class="title">${l.title }</span>
                                </div>
                            </a>
                        </div>
                    </li>
                </c:forEach>
            </ul>
        </div>
        <!--  뮤직매거진 끝-->
        
        
        <div class="charts mt30"> <!-- 실시간 음반 시작 -->
            <p class="box_tit"><span>데일리 베스트</span> </p>
            <p class="box_data"><ui:mask pattern="####.##.##">${date }</ui:mask></p>
            <!-- CD 리스트 -->
            <div class="charts_con">
                <div class="box_cont roundbox mt10 mb0">
                    <div class="cdvd"><img src="${imageServer }/images/music/cd02.png" alt="CD"></div>
                    <div class="charts_blx">
                        <c:forEach items="${list1}" var="l" begin="0" end="0">
                        <div class="charts_big">
                            <a href="/m/record/detail/${l.sellPrdtBcode}">
                                <span class="photo"><ui:image prdtGbn="${l.sellPrdtGbn}" rcrdCd="${l.rcrdCd}" ratingCode="A" alt="${fn:escapeXml(l.prdtName)}" style="border-radius: 50%;"/></span>
                            </a>
                            <p class="tit"><strong>0${l.rank}.</strong> ${fn:escapeXml(l.rcrdName)}</p>
                            <p class="sit">${l.artiName}</p>
                       </div> <!-- chyart_big -->
                   </c:forEach>
                   <div class="charts_list">
                    <ul>
                        <c:forEach items="${list1}" var="l" begin="1" end="4" varStatus="st">
                            <li>
                                <a href="/m/record/detail/${l.sellPrdtBcode}">
                                    <span class="photo"><ui:image prdtGbn="${l.sellPrdtGbn}" rcrdCd="${fn:escapeXml(l.rcrdCd)}" ratingCode="A" alt="${fn:escapeXml(l.prdtName)}"/></span>
                                    <div>
                                       <p class="tit"><strong<c:if test="${st.index < 3}"> class="col_red"</c:if>>0${st.index+1}.</strong> ${fn:escapeXml(l.rcrdName)}</p>
                                        <span class="sit">${fn:escapeXml(l.artiName)}</span>
                                    </div> 
                                </a>
                            </li>
                        </c:forEach>
                    </ul>
                    </div>
                </div><!-- charts_blx -->
              </div><!--  box_cont roundbox -->
            <!-- DVD 실시간 -->
            <div class="box_cont roundbox mt20 mb0">
                <div class="cdvd">
                    <img src="${imageServer }/images/music/dvd02.png" alt="DVD">
                </div>
                <div class="charts_blx">
                    <c:forEach items="${list2}" var="l" begin="0" end="0">
                        <div class="charts_big">
                            <a href="/m/record/detail/${l.sellPrdtBcode}">
                                <span class="photo"><ui:image prdtGbn="${l.sellPrdtGbn}" rcrdCd="${fn:escapeXml(l.rcrdCd)}" ratingCode="A" alt="${fn:escapeXml(l.prdtName)}"/></span>
                            </a>
                            <p class="tit"><strong>0${l.rank}.</strong> ${fn:escapeXml(l.rcrdName)}</p>
                            <p class="sit">${fn:escapeXml(l.artiName)}</p>
                        </div> <!-- charts_big -->
                    </c:forEach>
                    <div class="charts_list">
                       <ul>
                         <c:forEach items="${list2}" var="l" begin="1" end="4" varStatus="st">
                             <li>
                                 <a href="/m/record/detail/${l.sellPrdtBcode}">
                                    <span class="photo"><ui:image prdtGbn="${l.sellPrdtGbn}" rcrdCd="${fn:escapeXml(l.rcrdCd)}" ratingCode="A" alt="${fn:escapeXml(l.prdtName)}"/></span>
                                    <div>
                                       <p class="tit"><strong<c:if test="${st.index < 3}"> class="col_red"</c:if>>0${st.index+1}.</strong> ${fn:escapeXml(l.rcrdName)}</p>
                                       <p class="sit">${fn:escapeXml(l.artiName)}</p>
                                    </div>
                                  </a>
                              </li>
                         </c:forEach>
                     </ul>
                     </div>
                </div> <!--  charts_blx -->
                </div> <!-- box_cont roundbox -->
                </div>  
        </div><!--  실시간음반 끝-->
    
        <div class="best_box mt10">
            <p class="box_tit"><strong>MD's</strong> Pick</p>
                <div class="stab_basic stab_btn">
                    <ul><!-- tab produnt -->
                        <li><a href="#prod03" class="on"><c:set var="list" value="${listKpop}"/><span>가요</span></a></li>
                        <li><a href="#prod04"><c:set var="list" value="${listPop}"/><span>팝</span></a></li>
                        <li><a href="#prod05"><c:set var="list" value="${listClassic}"/><span>클래식</span></a></li>
                        <li><a href="#prod06"><c:set var="list" value="${listBlu}"/><span>블루레이</span></a></li>
                        <li><a href="#prod07"><c:set var="list" value="${listDvd}"/><span>DVD</span></a></li>
                    </ul>
                </div> <!--  stab_basic stab_btn -->
                <div class="pre_pannels tab_pannels">
                    <c:forEach begin="3" end="7" varStatus="s1">
                       <div id="prod0${s1.index}" class="box_cont stab_cont prod_music pis3" >
                            <c:if test="${s1.index eq 3}"><c:set var="list" value="${listKpop}"/></c:if>
                            <c:if test="${s1.index eq 4}"><c:set var="list" value="${listPop}"/></c:if>
                            <c:if test="${s1.index eq 5}"><c:set var="list" value="${listClassic}"/></c:if>
                            <c:if test="${s1.index eq 6}"><c:set var="list" value="${listBlu}"/></c:if>
                            <c:if test="${s1.index eq 7}"><c:set var="list" value="${listDvd}"/></c:if>
                            <ul>
                                <li>
                                    <c:forEach items="${list}" var="l" varStatus="st" end="2">
                                        <a class="box_prod"  href="/m/record/detail/${l.sellPrdtBcode}">
                                            <c:if test="${l.sellPrdtGbn eq 'R'}"><p class="pic"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="R" ratingCode="A" alt="${fn:escapeXml(l.prdtName)}"/></p></c:if>
                                            <c:if test="${l.sellPrdtGbn eq 'D'}"><p class="pic dvd"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="D" ratingCode="A" alt="${fn:escapeXml(l.prdtName)}"/></p></c:if>
                                            <p class="be_tt">${fn:escapeXml(l.prdtName)}</p>
                                            <p class="be_st">${l.artiName}</p>
                                        </a>
                                    </c:forEach>
                                </li>
                           </ul>
                       </div>
                    </c:forEach>
                </div>
        </div> <!-- best_box -->
    </section>
    <section class="hotevent">
        <p class="box_tit"><strong>HOT</strong> Event</p>
            <div class="mt10">
                <c:forEach items="${hotEventlist}" varStatus="st" var="l">
                    <div class="banner_basic t_c"> <!--  banner type01 -->
                        <a href="/m/biz/eventDetail?eventId=${l.eventId}" >
                            <p><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${l.imageUrl}" alt="${l.eventDtlCont }" onerror="this.src='http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/no_image2.gif';" /></p>
                            <p class="tit"><strong>${fn:escapeXml(l.eventTitle) }</strong></p>
                            <p class="txt">${fn:escapeXml(l.eventDtlCont)}</p>
                        </a>
                    </div>
                </c:forEach>
            </div>
            <div class="btn_area mt10 mb30"><a class="btn" href="/m/hot/eventMain?ctgrId=0003"><span class="more">MORE</span></a></div>
    </section>
</div><!-- music wrap -->
</body>
</html>