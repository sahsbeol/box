<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
<title>클래식 | CD - HOTTRACKS</title>
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
   $("#newre_carousel").owlCarousel({
       navigation : true,
       slideSpeed : 0,
       paginationSpeed : 0,
       singleItem : true,
       rewindSpeed :  0
   });
   $("#newre_carousel02").owlCarousel({
       navigation : true,
       slideSpeed : 0,
       paginationSpeed : 0,
       singleItem : true,
       rewindSpeed :  0
   });
   slideDiv(".main_sec6", 6000, ".main_sec6");
   
   $.ajax({
       url: "/ht/record/notice"
       ,dataType: "json"
       ,data : { ctgrId:"000308" }
       ,success : function(data){
           if(data.notice != null){
               $("#categoryList").append("<li><a href='javascript://' onclick=\"location.href=\'/ht/help/listNotice?notiSeq="+notice.notiSeq+"\';\"><span>Notice i "+notice.title+"</span></a></li>");
           }
       } 
       ,error: function(data) {
           alert('<fmt:message key="error.common.system"/>');
       }
   });
});
</script>
</head>
<body>
<!-- record_cd -->
<div class="record_cd classic mgt50">
    <div class="cate02">
        <h2 class="tit"><img src="${imageServer}/images/renewal/shop/sub_tit06.gif" alt="Classic" /></h2>
        <ul id="categoryList">
            <li>
                <a href="javascript://" onclick="location.href='/ht/search/searchDetail/Record'" class="on"><span>음반 상세 검색 </span></a>
                <ul style="display:block;">
                    <c:forEach items="${categoryListLeft}" var="l" varStatus="st">
                        <li><a href="javascript://" onclick="location.href='/ht/record/category/${l.cateId}';">${l.cateName}</a></li>
                    </c:forEach>
                </ul>
            </li>
            <li><a href="javascript://" onclick="location.href='/ht/record/box?searchAudioLpBoxCate=classic';"><span>BOX SET</span></a></li>
            <li><a href="javascript://" onclick="location.href='/ht/record/audio?searchAudioLpBoxCate=classic';"><span>AUDIO FILE </span></a></li>
            <li><a href="javascript://" onclick="location.href='/ht/record/lp?searchAudioLpBoxCate=classic';"><span>LP SHOP</span></a></li>
        </ul>
    </div>
    <div class="record_carousel">
        <div class="page_location record">
            <div class="loc"><a href="/" class="home">Home</a><a href="/ht/biz/record/recordCategoryMain?ctgrId=0003">CD</a><em>Classic</em></div>
        </div>
        <div class="main_sec6">
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
    
    <div class="record_banner">
        <ul>
            <c:forEach items="${list2St}" var="l" varStatus="st" end="1">
                <li><a href="${l.bnrLnkUrl}"<c:if test="${l.bnrNewWinYn eq 'Y'}"> target="_blank"</c:if>><ui:image src="${l.bnrImgUrl}" alt="${l.bnrImgAlt}" style="width:361px;height:105px;"/></a></li>
            </c:forEach>
        </ul>
    </div>
</div>
<!-- //record_cd -->

<p class="main_bg_line03"></p>

<!--Pre orders -->
<div class="pre_orders mgt70 mgb65">
    
    <h2 class="tit"><img src="${imageServer}/images/renewal/shop/sub_tit04.gif" alt="pre orders" /></h2>
    <a href="/ht/record/reserve/000308" class="btn_more">MORE +</a>
    <div id="orders_carousel" class="orders_carousel">
        <c:forEach items="${list5St}" varStatus="s1" begin="0" step="5">
            <div class="item">
                <div class="prod_list">
                    <ul>
                        <c:forEach items="${list5St}" var="l" varStatus="st" begin="${s1.index}" end="${s1.index+4}">
                            <li>
                                <a href="/ht/record/detail/${l.sellPrdtBcode}" title="${l.artiName} - ${l.prdtName}">
                                    <p class="img"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" width="${l.sellPrdtGbn eq 'R'?'133':'87'}" alt="${l.prdtName}" ratingCode="A" /></p>
                                    <span class="artist txt_line1"><ui:cut isStripHtml="true">${l.artiName}</ui:cut></span>
                                    <span class="tit"><ui:cut isStripHtml="true">${l.prdtName}</ui:cut></span>
                                    <em class="price">
                                        <c:if test="${l.prdtSellPrice eq l.lastDcPrice}">
                                            <span class="sale"><fmt:formatNumber value="${l.prdtSellPrice}" pattern=",###"/></span>
                                        </c:if>
                                        <c:if test="${l.prdtSellPrice ne l.lastDcPrice}">
                                            <span class="dc"><fmt:formatNumber value="${l.prdtSellPrice}" pattern=",###"/></span>
                                            <span class="sale"><fmt:formatNumber value="${l.lastDcPrice}" pattern=",###"/></span>
                                            <span class="pc"><fmt:formatNumber value="${hfn:rate(l.prdtSellPrice,l.lastDcPrice)}" pattern=",###"/>%</span>
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

<c:if test="${not empty list3St}">
<div class="event_list mgb60">
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
</c:if>

<p class="main_bg_line03"></p>

<div class="pre_orders tab_wrap mgt65">
    <h2 class="tit"><img src="${imageServer}/images/renewal/shop/sub_tit05.gif" alt="New Releases" /></h2>
    <ul class="pre_tab col2 tab_btn">
        <li><a href="#pp01" class="on"><span>수입</span></a></li>
        <li><a href="#pp02"><span>라이선스</span></a></li>
    </ul>
    <div class="pre_pannels tab_pannels">
        <c:forEach begin="0" end="1" varStatus="s1">
            <c:if test="${s1.index eq 0}"><c:set var="list" value="${list6StImp}"/></c:if>
            <c:if test="${s1.index eq 1}"><c:set var="list" value="${list6StLis}"/></c:if>
            <div id="pp0${s1.count}" class="pannel">
                <div id="newre_carousel${!s1.first?'02':''}" class="newre_carousel">
                    <c:forEach items="${list}" varStatus="s1" step="7">
                        <ul class="item">
                            <c:forEach items="${list}" var="l" varStatus="st" begin="${s1.index}" end="${s1.index+6}">
                                <li class="c${st.count}"<c:if test="${st.first}"> style="top:28px;"</c:if>>
                                    <a href="/ht/record/detail/${l.sellPrdtBcode}" title="${l.artiName} - ${l.prdtName}">
                                        <c:if test="${st.first}"><span class="img"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" rcrdImgType="large" width="${l.sellPrdtGbn eq 'R'?'260':'171'}" alt="${l.prdtName}" ratingCode="A"/></span></c:if>
                                        <c:if test="${!st.first}"><span class="img"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" width="${l.sellPrdtGbn eq 'R'?'133':'87'}" alt="${l.prdtName}" ratingCode="A"/></span></c:if>
                                        <span class="artist txt_line1">${l.artiName}</span>
                                        <span class="tit">${l.prdtName}</span>
                                        <em class="price">
                                            <c:if test="${l.basePrdtSellPrice eq l.lastDcPrice}">
                                                <span class="sale"><fmt:formatNumber value="${l.basePrdtSellPrice}" pattern=",###"/></span>
                                            </c:if>
                                            <c:if test="${l.basePrdtSellPrice ne l.lastDcPrice}">
                                                <span class="dc"><fmt:formatNumber value="${l.basePrdtSellPrice}" pattern=",###"/></span>
                                                <span class="sale"><fmt:formatNumber value="${l.lastDcPrice}" pattern=",###"/></span>
                                                <span class="pc"><fmt:formatNumber value="${hfn:rate(l.basePrdtSellPrice,l.lastDcPrice)}" pattern=",###"/>%</span>
                                            </c:if>
                                        </em>
                                    </a>
                                </li>
                            </c:forEach>
                        </ul>
                    </c:forEach>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<c:if test="${not empty list4St}">
<div class="event_list mgt65 mgb65">
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
</c:if>

 <p class="main_bg_line03"></p>

<div class="best_banner tab_wrap">
    <ul class="best_tab tab_btn">
        <li><a href="#bb01" class="on"><span>BEST 1~5</span></a></li>
        <li><a href="#bb02"><span>BEST 6~10</span></a></li>
    </ul>
    
    <div class="prod_list tab_pannels">
        <c:forEach items="${realtimeRecord}" varStatus="s1" step="5" begin="0" end="9">
            <ul id="bb0${s1.count}" class="pannel" >
                <c:forEach items="${realtimeRecord}" var="l" varStatus="st" begin="${s1.index}" end="${s1.index+4}">
                    <li>
                        <a href="/ht/record/detail/${l.sellPrdtBcode}" title="${l.artiName} - ${l.prdtName}">
                            <p class="img" style="width: auto; height: auto;"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" width="${l.sellPrdtGbn eq 'R'?'145':'95'}" height="145" alt="${l.prdtName}" ratingCode="A"/></p>
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
    <a href="/ht/record/bestList/000308?bestRangeType=C1003" class="btn_more">MORE +</a>
</div>

<!-- Classic  -->
<div class="clasic_val c_tab_wrap mgt5">
    <div class="tit_box">
        <h2 class="tit"><img src="${imageServer}/images/renewal/shop/sub_tit07.gif" alt="Class" /></h2>
        <ul class="tab_dvd">
            <li><a href="#cv01" class="on"><span>Blu-Ray</span></a></li>
            <li><a href="#cv02"><span>DVD</span></a></li>
        </ul>
    </div>
    <c:forEach begin="0" end="1" varStatus="s1">
        <c:if test="${s1.index eq 0}"><c:set var="list" value="${listBlu}"/></c:if>
        <c:if test="${s1.index eq 1}"><c:set var="list" value="${listDvd}"/></c:if>
        <div id="cv0${s1.count}" class="tab_wrap c_pannel"<c:if test="${!s1.first}"> style="display:none;"</c:if>>
            <div class="prod_list tab_pannels">
                <ul class="pannel">
                    <c:forEach items="${list}" var="l" varStatus="st" end="4">
                        <li>
                            <a href="/ht/record/detail/${l.sellPrdtBcode}" title="${l.artiName} - ${l.prdtName}">
                                <p class="img"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" width="${l.sellPrdtGbn eq 'R'?'133':'87'}" alt="${l.prdtName}" ratingCode="A"/></p>
                                <span class="date txt_line1">${l.artiName}</span>
                                <span class="tit02">${l.prdtName}</span>
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
<!-- //Classic  -->

    <p class="main_bg_line03"></p>

    <div class="mds_pick03 tab_wrap">
        <h2 class="tit"><img src="${imageServer}/images/renewal/shop/sub_tit02.gif" alt="Md's pick"></h2>
        <ul class="pre_tab col13 tab_btn">
            <li><a href="#mpt01" class="on"><span>교향곡</span></a></li>
            <li><a href="#mpt02"><span>협주곡</span></a></li>
            <li><a href="#mpt03"><span>독주곡</span></a></li>
            <li><a href="#mpt04"><span>실내악</span></a></li>
            <li><a href="#mpt05"><span>관현악</span></a></li>
            <li><a href="#mpt06"><span>성악</span></a></li>
            <li><a href="#mpt07"><span>팝페라</span></a></li>
            <li><a href="#mpt08"><span>바로크</span></a></li>
            <li><a href="#mpt09"><span>크로스오버</span></a></li>
            <li><a href="#mpt10"><span>모음집</span></a></li>
            <li><a href="#mpt11"><span>박스세트</span></a></li>
            <li><a href="#mpt12"><span>LP</span></a></li>
            <li><a href="#mpt13"><span>오디오파일</span></a></li>
        </ul>
        <div class="pre_pannels tab_pannels">
            <c:forEach begin="0" end="12" varStatus="s1">
                <c:if test="${s1.index eq 0}"><c:set var="list" value="${list7St01}"/></c:if>
                <c:if test="${s1.index eq 1}"><c:set var="list" value="${list7St02}"/></c:if>
                <c:if test="${s1.index eq 2}"><c:set var="list" value="${list7St03}"/></c:if>
                <c:if test="${s1.index eq 3}"><c:set var="list" value="${list7St04}"/></c:if>
                <c:if test="${s1.index eq 4}"><c:set var="list" value="${list7St05}"/></c:if>
                <c:if test="${s1.index eq 5}"><c:set var="list" value="${list7St06}"/></c:if>
                <c:if test="${s1.index eq 6}"><c:set var="list" value="${list7St07}"/></c:if>
                <c:if test="${s1.index eq 7}"><c:set var="list" value="${list7St10}"/></c:if>
                <c:if test="${s1.index eq 8}"><c:set var="list" value="${list7St09}"/></c:if>
                <c:if test="${s1.index eq 9}"><c:set var="list" value="${list7St08}"/></c:if>
                <c:if test="${s1.index eq 10}"><c:set var="list" value="${list7St11}"/></c:if>
                <c:if test="${s1.index eq 11}"><c:set var="list" value="${list7St12}"/></c:if>
                <c:if test="${s1.index eq 12}"><c:set var="list" value="${list7St13}"/></c:if>
                <div id="mpt<ui:lpad length="2" padChar="0">${s1.count}</ui:lpad>" class="pannel">
                    <ul>
                        <c:forEach items="${list}" var="l" varStatus="st" end="6">
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
            </c:forEach>
        </div>
    </div>
</body>
</html>