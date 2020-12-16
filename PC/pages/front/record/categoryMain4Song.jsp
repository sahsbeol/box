<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>가요 | CD - HOTTRACKS</title>
<script type="text/javascript" src="/js/owl.carousel.min.js"></script>
<script type="text/javascript" src="/js/fn_htts_slide.js"></script>
<script>
    $(document).ready(function() {
        $("#orders_carousel").owlCarousel({
            navigation : true,
            slideSpeed : 0,
            paginationSpeed : 0,
            singleItem : true,
            rewindSpeed :  0
        });
        slideDiv(".main_sec7", 6000, ".main_sec7");
    });
</script>
</head>
<body>
<!-- record_cd -->
<div class="record_cd02 mgb25 mgt50">
    <div class="cate03">
        <h2 class="tit"><img src="${imageServer}/images/renewal/shop/sub_tit08.gif" alt="가요" /></h2>
        <ul>
            <c:forEach items="${categoryListLeft}" var="l" varStatus="st">
                <li><a href="/ht/record/category/${l.cateId}">${l.cateName}</a></li>
            </c:forEach>
        </ul>
    </div>
    <div class="record_carousel type02">
        <div class="page_location record">
            <div class="loc"><a href="/" class="home">Home</a><a href="/ht/biz/record/recordCategoryMain?ctgrId=0003">CD</a><em>가요</em></div>
        </div>
        <div class="main_sec7">
            <ul class="main_slide_btn slide_view">
                <c:forEach items="${list1St}" var="l" varStatus="st">
                    <li class="main_slide_img"><ui:banner bannerImageUrl="${l.bnrImgUrl}" bnrLinkUrl="${l.bnrLnkUrl}" bnrSeq="${l.bnrSeq}" bnrTgtGbn="L" newWdwYn="${l.bnrNewWinYn}" alt="${l.bnrImgAlt}"/></li>
                </c:forEach>
            </ul>
            <ul class="main_slide_navi">
                <c:forEach items="${list1St}" var="l" varStatus="st">
                    <li class="slide_navi ${st.first?'active':''}"><a href="javascript://"><img src="${imageServer}/images/common/ic_navi<ui:lpad length="2" padChar="0">${st.count}</ui:lpad>.png"/></a></li>
                </c:forEach>
                <li class="slide_ctrl">
                    <a class="stop" href="javascript://">일시정지</a>
                </li>
            </ul>
        </div>
    </div>
    <div class="single_banner">
        <c:forEach items="${list2St}" var="l" varStatus="st" end="0">
            <span><ui:banner bannerImageUrl="${l.bnrImgUrl}" bnrLinkUrl="${l.bnrLnkUrl}" bnrSeq="${l.bnrSeq}" bnrTgtGbn="L" newWdwYn="${l.bnrNewWinYn}" alt="${l.bnrImgAlt}"/></span>
        </c:forEach>
    </div>
</div>
<!-- //record_cd -->

<p class="main_bg_line03"></p>

<!--Pre orders -->
<div class="pre_orders mgt45 mgb55">
    <h2 class="tit"><img src="${imageServer}/images/renewal/shop/sub_tit04.gif" alt="pre orders" /></h2>
    <a href="/ht/record/reserve/000300" class="btn_more">MORE +</a>
    <div id="orders_carousel" class="orders_carousel">
        <c:forEach items="${preOrdersList}" varStatus="s1" begin="0" step="5">
            <div class="item">
                <div class="prod_list">
                    <ul>
                        <c:forEach items="${preOrdersList}" var="l" varStatus="st" begin="${s1.index}" end="${s1.index+4}">
                            <li>
                                <a href="/ht/record/detail/${l.sellPrdtBcode}" title="${l.artiName} - ${l.prdtName}">
                                    <p class="img"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" width="${l.sellPrdtGbn eq 'R'?'133':'87'}" alt="${l.prdtName}" ratingCode="A" /></p>
                                    <span class="artist txt_line1"><ui:cut isStripHtml="true">${l.artiName}</ui:cut></span>
                                    <span class="tit"><ui:cut isStripHtml="true">${l.prdtName}</ui:cut></span>
                                    <em class="price">
                                        <c:if test="${l.orgSellPrice eq l.dscntPrice}">
                                            <span class="sale"><fmt:formatNumber value="${l.orgSellPrice}" pattern=",###"/></span>
                                        </c:if>
                                        <c:if test="${l.orgSellPrice ne l.dscntPrice}">
                                            <span class="dc"><fmt:formatNumber value="${l.orgSellPrice}" pattern=",###"/></span>
                                            <span class="sale"><fmt:formatNumber value="${l.dscntPrice}" pattern=",###"/></span>
                                            <span class="pc"><fmt:formatNumber value="${hfn:rate(l.orgSellPrice,l.dscntPrice)}" pattern=",###"/>%</span>
                                        </c:if>
                                    </em>
                                </a>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
<!--// Pre orders -->

<div class="event_list">
    <ul class="list">
        <c:forEach items="${list3St}" var="l" varStatus="st">
            <li>
                <a href="${l.bnrLnkUrl}"<c:if test="${l.bnrNewWinYn eq 'Y'}"> target="_blank"</c:if>>
                    <span class="img"><ui:image src="${l.bnrImgUrl}" alt="${l.bnrImgAlt}" style="width:290px;height:140px;"/></span>
                    <span class="tit">
                        <strong>${l.bnrTitle}</strong>
                        <em>${l.bnrSubTitle}</em>
                    </span>
                </a>
            </li>
        </c:forEach>
    </ul>
</div>

<p class="main_bg_line03" style="margin-top:-25px"></p>

<div class="pre_orders mgt70">
    <h2 class="tit"><img src="${imageServer}/images/renewal/shop/sub_tit05.gif" alt="New Releases" /></h2>
    <div class="pre_pannels frame_box">
        <div class="pannel">
            <ul>
                <c:forEach items="${newReleasesList}" var="l" varStatus="st" end="6">
                    <li class="c${st.count}">
                        <a href="/ht/record/detail/${l.sellPrdtBcode}" title="${l.artiName} - ${l.prdtName}">
                            <c:if test="${st.first}"><span class="img"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" rcrdImgType="large" width="${l.sellPrdtGbn eq 'R'?'260':'171'}" alt="${l.prdtName}" ratingCode="A"/></span></c:if>
                            <c:if test="${!st.first}"><span class="img"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" width="${l.sellPrdtGbn eq 'R'?'133':'87'}" alt="${l.prdtName}" ratingCode="A"/></span></c:if>
                            <span class="artist txt_line1">${l.artiName}</span>
                            <span class="tit">${l.prdtName}</span>
                            <em class="price">
                                <c:if test="${l.orgSellPrice eq l.dscntPrice}">
                                    <span class="sale"><fmt:formatNumber value="${l.orgSellPrice}" pattern=",###"/></span>
                                </c:if>
                                <c:if test="${l.orgSellPrice ne l.dscntPrice}">
                                    <span class="dc"><fmt:formatNumber value="${l.orgSellPrice}" pattern=",###"/></span>
                                    <span class="sale"><fmt:formatNumber value="${l.dscntPrice}" pattern=",###"/></span>
                                    <span class="pc"><fmt:formatNumber value="${hfn:rate(l.orgSellPrice,l.dscntPrice)}" pattern=",###"/>%</span>
                                </c:if>
                            </em>
                        </a>
                    </li>
                </c:forEach>
            </ul>
        </div>

    </div>
</div>

<div class="event_list">
    <ul class="list">
        <c:forEach items="${list4St}" var="l" varStatus="st">
            <li>
                <a href="${l.bnrLnkUrl}"<c:if test="${l.bnrNewWinYn eq 'Y'}"> target="_blank"</c:if>>
                    <span class="img"><ui:image src="${l.bnrImgUrl}" alt="${l.bnrImgAlt}" style="width:290px;height:140px;"/></span>
                    <span class="tit">
                        <strong>${l.bnrTitle}</strong>
                        <em>${l.bnrSubTitle}</em>
                    </span>
                </a>
            </li>
        </c:forEach>
    </ul>
</div>

<p class="main_bg_line03" style="margin-top:-25px"></p>

<div class="best_banner tab_wrap">
    <ul class="best_tab tab_btn">
        <li><a href="#bb01" class="on"><span>BEST 1~5</span></a></li>
        <li><a href="#bb02"><span>BEST 6~10</span></a></li>
    </ul>
    
    <div class="prod_list tab_pannels">
        <c:forEach items="${bestSellers}" varStatus="s1" step="5" begin="0" end="9">
            <ul id="bb0${s1.count}" class="pannel" >
                <c:forEach items="${bestSellers}" var="l" varStatus="st" begin="${s1.index}" end="${s1.index+4}">
                    <li>
                        <a href="/ht/record/detail/${l.sellPrdtBcode}" title="${l.artiName} - ${l.commTitle}">
                            <p class="img"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" width="${l.sellPrdtGbn eq 'R'?'176':'117'}" height="176" alt="${l.prdtName}" ratingCode="A"/></p>
                            <span class="artist txt_line1">${l.artiName}</span>
                            <span class="tit">${l.commTitle}</span>
                            <em class="price">
                                <c:if test="${l.prdtSellPrice eq l.priceReal}">
                                    <span class="sale"><fmt:formatNumber value="${l.prdtSellPrice}" pattern=",###"/></span>
                                </c:if>
                                <c:if test="${l.prdtSellPrice ne l.priceReal}">
                                    <span class="dc"><fmt:formatNumber value="${l.prdtSellPrice}" pattern=",###"/></span>
                                    <span class="sale"><fmt:formatNumber value="${l.priceReal}" pattern=",###"/></span>
                                    <span class="pc"><fmt:formatNumber value="${hfn:rate(l.prdtSellPrice,l.priceReal)}" pattern=",###"/>%</span>
                                </c:if>
                            </em>
                        </a>
                    </li>
                </c:forEach>
            </ul>
        </c:forEach>
    </div>
    <a href="/ht/record/bestList/000300?bestRangeType=C1003" class="btn_more">MORE +</a>
</div>

<div class="pre_orders mgt0">
    <h2 class="tit"><img src="${imageServer}/images/renewal/shop/sub_tit02.gif" alt="Md's pick"></h2>
    <div class="pre_pannels frame_box">
        <div class="pannel">
            <ul>
                <c:forEach items="${mdsPickList}" var="l" varStatus="st" end="6">
                    <li class="c${st.count}">
                        <a href="/ht/record/detail/${l.sellPrdtBcode}">
                            <c:if test="${st.first}"><span class="img"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" rcrdImgType="large" width="${l.sellPrdtGbn eq 'R'?'260':'171'}" alt="${l.prdtName}" ratingCode="A"/></span></c:if>
                            <c:if test="${!st.first}"><span class="img"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" width="${l.sellPrdtGbn eq 'R'?'133':'87'}" alt="${l.prdtName}" ratingCode="A"/></span></c:if>
                            <span class="artist">${l.artiName}</span>
                            <span class="tit">${l.prdtName}</span>
                            <em class="price">
                                <c:if test="${l.orgSellPrice eq l.dscntPrice}">
                                    <span class="sale"><fmt:formatNumber value="${l.orgSellPrice}" pattern=",###"/></span>
                                </c:if>
                                <c:if test="${l.orgSellPrice ne l.dscntPrice}">
                                    <span class="dc"><fmt:formatNumber value="${l.orgSellPrice}" pattern=",###"/></span>
                                    <span class="sale"><fmt:formatNumber value="${l.dscntPrice}" pattern=",###"/></span>
                                    <span class="pc"><fmt:formatNumber value="${hfn:rate(l.orgSellPrice,l.dscntPrice)}" pattern=",###"/>%</span>
                                </c:if>
                            </em>
                        </a>
                    </li>
                </c:forEach>
            </ul>
        </div>
    </div>
</div>
</body>
</html>