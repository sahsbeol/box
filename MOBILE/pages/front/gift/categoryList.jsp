<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<html>
<head>
<script type="text/javascript">
var page = 1;
var validPage = true;

jQuery(function($){
    $("#locCate${c.ctgrId}").addClass("active");
    $("img.lazy").lazyload({placeholder:'/images/no_image2.gif',effect : "fadeIn"});
    
    // 테마상품전
    var prodsSwiper = new Swiper('.cate_mds_zone .swiper-container', {
        pagination: '.cate_mds_zone div.pagination',
        loop:true,
        grabCursor: true,
        paginationClickable: true,
        initialSlide: randomSlide(".cate_mds_zone")
    });
    
    // 포커스상품전
    var prodsSwiper = new Swiper('.cate_focus_zone .swiper-container', {
        pagination: '.cate_focus_zone div.pagination',
        loop:true,
        grabCursor: true,
        paginationClickable: true,
        initialSlide: randomSlide(".cate_focus_zone")
    });
    
    // 이벤트배너
    var welcomeSwiper = new Swiper('.event_banner .swiper-container',{
        pagination: '.event_banner div.pagination',
        loop:true,
        grabCursor: true,
        paginationClickable: true
    });
    
 	// 레코벨 상품 추천
    var welcomeSwiper = new Swiper('.pbest_list .swiper-container',{
        pagination: '.pbest_list div.pagination',
        loop:true,
        grabCursor: true,
        paginationClickable: true
    });
    
    // 텍스트배너 애니메이션 추가
    aniText(".cate_keywords_zone .zone_cont a", "19px", "28px");
});

// 페이지 이동
function goList(page){
    location.href="?ctgrId=${c.ctgrId}&productOrderBy=${c.productOrderBy}&page="+page;
}
</script>
<style>
/* 레코벨 상품 추천 */
.pbest_list {position:relative; background-color:#fff;}
.pbest_list .tit_mdspick {margin:0 20px;padding-bottom:5px;border-bottom:1px solid #eee;}
.pbest_list .tit_mdspick img {height:19px;padding-bottom:7px;}
.pbest_list .box_cont {border:none;box-shadow:none; background-color: #fff; padding:10px 0px; background-color: #fff; margin:0px;}
.pbest_list .box_cont .raw + .raw {margin-top:22px;}
.pbest_list .row {display:-webkit-box;}
.pbest_list .row .row_item {-webkit-box-flex:1;display:block;width:100%;}
.pbest_list .row .row_item .dvd img {width:66%;}
.pbest_list .swiper-container {overflow:hidden;}
.pbest_list .swiper-container .swiper-wrapper {height:auto !important;}
.pbest_list .swiper-container .swiper-wrapper .swiper-slide {position:relative;float:left;width:100%;text-align:center;height:auto !important;}
.pbest_list .swiper-container .swiper-wrapper .swiper-slide .tit {margin-top:12px;font-size:13px;color:#555;}
.pbest_list .swiper-container .swiper-wrapper .swiper-slide .price {font-size:13px;color:#000;}
.pbest_list .swiper-container .swiper-wrapper .swiper-slide .price .sale {color:#f51d1d; margin-left:5px;}
.pbest_list .pagination {text-align:center; padding-bottom:30px;}
.pbest_list .pagination .swiper-pagination-switch {display:inline-block;width:12px;height:12px;overflow:hidden;margin:0 5px;background:url('http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/mobile/content/btn_dot04_off.png') no-repeat;background-size:contain;}
.pbest_list .pagination .swiper-active-switch {background:url('http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/mobile/content/btn_dot04_on.png') no-repeat;background-size:contain;}
</style>

</head>
<body>
<div class="gray_box cate_wrap">
    <c:if test="${mainYn}">
        <section class="cate_main">
            <c:if test="${not empty listPrdt01 && not empty listPrdt02 && not empty listPrdt03}">
                <!-- DISP PRODUCT 1~3 -->
                <div class="cate_mds_zone swiper-prods">
                    <div class="swiper-container">
                        <div class="swiper-wrapper">
                            <c:forEach begin="0" end="2" varStatus="s0">
                                <c:if test="${s0.index eq 0}"><c:set var="title" value="${mstPrdt01.title}"/><c:set var="list" value="${listPrdt01}"/></c:if>
                                <c:if test="${s0.index eq 1}"><c:set var="title" value="${mstPrdt02.title}"/><c:set var="list" value="${listPrdt02}"/></c:if>
                                <c:if test="${s0.index eq 2}"><c:set var="title" value="${mstPrdt03.title}"/><c:set var="list" value="${listPrdt03}"/></c:if>
                                <div class="swiper-slide ">
                                    <div class="box_cont">
                                        <p class="tit_prods"><em>${title}</em></p>
                                        <div class="box_incont">
                                            <c:forEach items="${list}" var="l" varStatus="st">
                                                <c:set var="clsName" value="small"/>
                                                <c:if test="${s0.index eq 0 && st.index eq 0}"><c:set var="clsName" value="big"/></c:if>
                                                <c:if test="${s0.index eq 1 && st.index eq 4}"><c:set var="clsName" value="big right"/></c:if>
                                                <c:if test="${s0.index eq 2 && st.index eq 1}"><c:set var="clsName" value="big right"/></c:if>
                                                <a href="#" onclick="location.href='/p/${l.sellPrdtBcode}';return false;" class="${clsName}">
                                                    <c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G'}"><p class="pic"><ui:image src="${l.productImageUrl}" server="product" alt="${fn:escapeXml(l.prdtName)}"/></p></c:if>
                                                    <c:if test="${l.sellPrdtGbn eq 'R'}"><p class="pic"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="R" ratingCode="A" alt="${fn:escapeXml(l.prdtName)}"/></p></c:if>
                                                    <c:if test="${l.sellPrdtGbn eq 'D'}"><p class="pic dvd"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="D" ratingCode="A" alt="${fn:escapeXml(l.prdtName)}"/></p></c:if>
                                                    <p class="price"><fmt:formatNumber type="number">${l.lastCpnPrice}</fmt:formatNumber></p>
                                                </a>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                    <div class="pagination"></div>
                </div>
                <!-- // DISP PRODUCT 1~3 -->
            </c:if>
            <c:if test="${not empty listKeyBnr}">
                <!-- BNR KEYWORDS 5 -->
                <div class="cate_keywords_zone">
                    <p class="zone_tit"><em>${mstKeyBnr.title}</em></p>
                    <div class="zone_cont">
                        <c:forEach items="${listKeyBnr}" var="l">
                            <a href="${l.bnrLnkUrl}">${l.bnrTitle}</a>
                        </c:forEach>
                    </div>
                </div>
                <!-- // BNR KEYWORDS 5 -->
            </c:if>
            <c:if test="${not empty listFocus}">
                <!-- PRDT FOCUSON 1~3 -->
                <div class="cate_focus_zone focuson_zone">
                    <p class="tit_prods"><em>${mstFocus.title}</em></p>
                    <div class="swiper-container">
                        <div class="swiper-wrapper">
                            <c:forEach items="${listFocus}" varStatus="s0" step="4" end="11">
                                <div class="swiper-slide">
                                    <div class="box_cont">
                                        <c:forEach items="${listFocus}" var="l" varStatus="s1" begin="${s0.index}" end="${s0.index+3}">
                                            <a href="#" onclick="location.href='/p/${l.sellPrdtBcode}';return false;" class="box_prod row_item">
                                                <c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G'}"><p class="pic"><ui:image src="${l.productImageUrl}" server="product" alt="${fn:escapeXml(l.prdtName)}"/></p></c:if>
                                                <c:if test="${l.sellPrdtGbn eq 'R'}">
                                                    <p class="pic"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="R" ratingCode="A" alt="${fn:escapeXml(l.prdtName)}"/></p>
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
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                    <div class="pagination"></div>
                </div>
                <!-- // PRDT FOCUSON 1~3 -->
            </c:if>
            <c:if test="${not empty listEvent}">
                <hr class="hr_01"/>
                <!-- EVENT 1~3 -->
                <div class="event_banner">
                    <div class="swiper-container">
                        <div class="swiper-wrapper">
                            <c:forEach items="${listEvent}" var="l" varStatus="st" begin="0" end="4">
                                <li class="swiper-slide">
                                    <a href="/m/biz/eventDetail?eventId=${l.eventId}" class="full" title="${l.eventTitle}">
                                        <p class="pic"><ui:image src="${l.imageUrl}" alt="${l.eventTitle}" /></p>
                                        <p class="tit" style="margin: auto 10px;width: auto;display: block;"><strong>${fn:escapeXml(l.eventTitle)}</strong></p>
                                        <p class="txt" style="margin: auto 10px 10px;width: auto;display: block;">${fn:escapeXml(l.eventDtlCont)}</p>
                                    </a>
                                </li>
                            </c:forEach>
                        </div>
                    </div>
                    <div class="pagination"></div>
                </div>
                <!-- // EVENT 1~3 -->
            </c:if>
        </section>
    </c:if>
    
    <!-- 레코벨 상품 추천 -->
    <c:if test="${empty c.ctgrId}"><c:set var="ctgrLength" value="${fn:length(ctgrId)}"/></c:if>
    <c:if test="${not empty c.ctgrId}"><c:set var="ctgrLength" value="${fn:length(c.ctgrId)}"/></c:if>
    <%-- <c:if test="${not empty listRecobell}"> --%>
    <fmt:parseNumber var="recobellLength" integerOnly="true" value="${fn:length(listRecobell)/3}" />
    <c:if test="${recobellLength >= 1}">
    <section class="pbest_list">
        <div class="swiper-container">
            <div class="swiper-wrapper">
	            <%-- <c:forEach begin="0" end="14" varStatus="s0" step="3"> --%>
	            <c:forEach begin="0" end="${(recobellLength*3) >= 15 ? 14 : (recobellLength*3)-1}" varStatus="s0" step="3">
	                <div class="swiper-slide">
	                    <div class="box_cont">
	                        <div class="row">
	                            <c:forEach items="${listRecobell}" var="l" begin="${s0.index}" end="${s0.index+2}">
	                                <a href="#" onclick="location.href='/p/${l.sellPrdtBcode}?foo=bar<c:if test="${ctgrLength eq 6}">&rccode=mo_category1</c:if><c:if test="${ctgrLength eq 8}">&rccode=mo_category2</c:if><c:if test="${ctgrLength eq 10}">&rccode=mo_category3</c:if><c:if test="${ctgrLength eq 12}">&rccode=mo_category4</c:if>';return false;" class="box_prod row_item">
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
	                    </div>
	                </div>
	            </c:forEach>
            </div>
        </div>
        <div class="pagination"></div>
    </section>
    </c:if>
    <!-- 레코벨 상품 추천  -->
    
    <section class="cate_list">
        <!-- 정렬 -->
        <div class="option_box t_select">
            <div class="select_box">
                <c:if test="${c.ctgrId eq ctgrId}"><p>${category.ctgrName}</p></c:if>
                <c:if test="${c.ctgrId ne ctgrId}">
                    <c:forEach items="${childCategory}" var="l">
                        <c:if test="${c.ctgrId eq l.ctgrId}"><p>${l.ctgrName}</p></c:if>
                    </c:forEach>
                </c:if>
                <div class="option_box twice">
                    <dl>
                        <dd>
                            <a href="/m/gift/category/${ctgrId}?productOrderBy=${c.productOrderBy}"<c:if test="${c.ctgrId eq ctgrId}"> class="active"</c:if>>테마 전체보기</a>
                            <c:forEach items="${childCategory}" var="l" varStatus="st" end="0">
                                <a href="/m/gift/category/${ctgrId}?ctgrId=${l.ctgrId}&productOrderBy=${c.productOrderBy}"<c:if test="${l.ctgrId eq c.ctgrId}"> class="active"</c:if>>${l.ctgrName}</a>
                            </c:forEach>
                        </dd>
                        <c:forEach items="${childCategory}" varStatus="s1" begin="1" step="2">
                            <dd>
                                <c:forEach items="${childCategory}" var="l" varStatus="st" begin="${s1.index}" end="${s1.index+1}">
                                    <a href="/m/gift/category/${ctgrId}?ctgrId=${l.ctgrId}&productOrderBy=${c.productOrderBy}"<c:if test="${l.ctgrId eq c.ctgrId}"> class="active"</c:if>>${l.ctgrName}</a>
                                </c:forEach>
                            </dd>
                        </c:forEach>
                    </dl>
                </div>
            </div>
            <div class="select_box">
                <c:if test="${c.productOrderBy eq 'R'}"><p>신상품순</p></c:if>
                <c:if test="${c.productOrderBy eq 'W'}"><p>좋아요♥순</p></c:if>
                <c:if test="${c.productOrderBy eq 'T'}"><p>할인율순</p></c:if>
                <c:if test="${c.productOrderBy eq 'L'}"><p>낮은가격순</p></c:if>
                <c:if test="${c.productOrderBy eq 'H'}"><p>높은가격순</p></c:if>
                <c:if test="${c.productOrderBy eq 'P'}"><p>인기상품순</p></c:if>
                <c:if test="${c.productOrderBy eq 'C'}"><p>후기순</p></c:if>
                <div class="option_box">
                    <dl>
                        <dd><a href="/m/gift/category/${ctgrId}?ctgrId=${c.ctgrId}&productOrderBy=R"<c:if test="${c.productOrderBy eq 'R'}"> class="active"</c:if>>신상품순</a></dd>
                        <dd><a href="/m/gift/category/${ctgrId}?ctgrId=${c.ctgrId}&productOrderBy=W"<c:if test="${c.productOrderBy eq 'W'}"> class="active"</c:if>>좋아요♥순</a></dd>
                        <dd><a href="/m/gift/category/${ctgrId}?ctgrId=${c.ctgrId}&productOrderBy=C"<c:if test="${c.productOrderBy eq 'C'}"> class="active"</c:if>>후기순</a></dd>
                        <dd><a href="/m/gift/category/${ctgrId}?ctgrId=${c.ctgrId}&productOrderBy=T"<c:if test="${c.productOrderBy eq 'T'}"> class="active"</c:if>>할인율순</a></dd>
                        <dd><a href="/m/gift/category/${ctgrId}?ctgrId=${c.ctgrId}&productOrderBy=L"<c:if test="${c.productOrderBy eq 'L'}"> class="active"</c:if>>낮은가격순</a></dd>
                        <dd><a href="/m/gift/category/${ctgrId}?ctgrId=${c.ctgrId}&productOrderBy=H"<c:if test="${c.productOrderBy eq 'H'}"> class="active"</c:if>>높은가격순</a></dd>
                        <dd><a href="/m/gift/category/${ctgrId}?ctgrId=${c.ctgrId}&productOrderBy=P"<c:if test="${c.productOrderBy eq 'P'}"> class="active"</c:if>>인기상품순</a></dd>
                    </dl>
                </div>
            </div>
        </div>
        <!-- //정렬 -->
        <hr class="hr_01"/>
    
        <!-- prod -->
        <c:import url="../template/layerProduct.jsp" charEncoding="UTF-8">
            <c:param name="best" value="N"/>
            <c:param name="lazy" value="N"/>
        </c:import>
        <!-- //prod -->
        
        <div class="paging">
            <ui:paginationScript name="pageHolder" scriptName="goList"/>
        </div>
    </section>
</div>
</body>
</html>