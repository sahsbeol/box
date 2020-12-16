<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="recordMain"/>
<html>
<head>
<title>CD메인 - HOTTRACKS</title>
<c:set value="${2019031400}" var="temp"/>
<link rel="stylesheet" type="text/css" href="/css/chart.css?${temp }">
<script type="text/javascript" src="/js/fn_htts_slide.js"></script>
<script type="text/javascript">
jQuery(function($){
    $(document).ready(function() {
        slideDiv(".main_sec6", 6000, ".main_sec6");
        
        $(".realtime").load("/ht/record/realtimeRecord", function(){
            $('.tab_wrap .tab_btn  a').on('mouseenter focus click',function(){
                var taget_link = $(this).attr('href');
                if($(taget_link).is(':hidden')){
                    $(this).parents('.tab_wrap').find('.tab_pannels .pannel').hide();
                    $(taget_link).show();
                    $(this).parents('.tab_wrap').find('.tab_btn li a').removeClass('on');
                    $(this).addClass('on');
                }
                return false;
            });
        });
        
        $.ajax({
            url: "/ht/record/notice"
            ,dataType: "json"
            ,data : { ctgrId:"0003" }
            ,success : function(data){
                if(data.notice != null){
                    $("#categoryList").append("<li><a href='javascript://' onclick=\"location.href=\'/ht/help/listNotice?notiSeq="+notice.notiSeq+"\';\"><span>Notice i "+notice.title+"</span></a></li>");
                }
            } 
            ,error: function(data) {
                alert('<fmt:message key="error.common.system"/>');
            }
        });
        
        setGnbSrchMenu("RECORD");
    });
    
    $.ajax({
        type: "GET"
        ,url: "/ht/getPopupList"
        ,data: {dispGbn : 'R'}
        ,dataType: "json"
        ,success: function getPopup(data) {
            if(data && data.popupList) {
                var popupList = data.popupList;
                for(var i=0;i<popupList.length;i++) {
                    var options =   "width=" + popupList[i].popupSizeX
                                  + ",height=" + (popupList[i].popupSizeY + 20)
                                  + ",left=" + popupList[i].popupPosX
                                  + ",top=" + popupList[i].popupPosY;
                    window.open("/ht/getPopup?popupseq="+popupList[i].popupSeq, "giftPopup" + i, options);
                }
            }
        }
        ,error: function(xhr, status, error) {
            console.log("<fmt:message key='error.common.system'/>");
        }
    });
});
</script>
</head>

<!-- 컨텐츠 -->
<div class="content">
    <!-- Record_main -->
    <c:forEach items="${list1St}" var="l" varStatus="s1" end="0">
        <div class="mgt25">
            <c:if test="${l.bnrLnkUrl ne '#'}">
                <ui:banner bnrLinkUrl="${l.bnrLnkUrl}" bannerImageUrl="${l.bnrImgUrl}" bnrTgtGbn="L" bnrSeq="${l.bnrSeq}" newWdwYn="${l.bnrNewWinYn}" width="950px"/>
            </c:if>
            <c:if test="${l.bnrLnkUrl eq '#'}">
                <ui:banner bnrLinkUrl="${l.bnrImgMap}" bannerImageUrl="${l.bnrImgUrl}" bnrTgtGbn="T" bnrSeq="${l.bnrSeq}" newWdwYn="${l.bnrNewWinYn}" width="950px"/>
            </c:if>
        </div>
    </c:forEach>
    <!-- //Record_main -->
    
    <!-- record_cd -->
    <div class="record_cd">
        <div class="cate02">
            <h2 class="tit"><img src="${imageServer}/images/renewal/shop/sub_tit03.gif" alt="CD" /></h2>
            <div class="btn_wrap">
                <a href="/ht/record/bestList/0003?bestRangeType=C1002" class="btn_type01 bg_orange">BEST</a>
                <a href="/ht/record/newRecord/0003" class="btn_type01">NEW</a>
                <a href="/ht/record/reserve/0003" class="btn_type01">예약상품</a>
            </div>
            <ul id="categoryList">
                <li>
                    <ul style="display:block;">
                        <c:forEach items="${categoryListLeft}" var="l" varStatus="st">
                            <c:if test="${l.cateId ne '000312'}">
                                <li>
                                    <c:if test="${l.cateId eq '000303'}"><a href="javascript://" onclick="location.href='/ht/record/category/00030300'"><span>${l.cateName}</span></a></c:if>
                                    <c:if test="${l.cateId ne '000303'}"><a href="javascript://" onclick="location.href='/ht/record/category/${l.cateId}'"><span>${l.cateName}</span></a></c:if>
                                </li>
                            </c:if>
                        </c:forEach>
                        <li><a href="javascript://" onclick="location.href='/ht/record/category/00040009'"><span>Blu-Ray</span></a></li>
                        <li><a href="javascript://" onclick="location.href='/ht/record/category/00040108'"><span>DVD</span></a></li>
                        <li><a href="javascript://" onclick="location.href='/ht/record/category/000312'"><span>GOODS</span></a></li>
                    </ul>
                </li>
                <li><a href="javascript://" onclick="location.href='/ht/record/box'"><span>BOX SET</span></a></li>
                <li><a href="javascript://" onclick="location.href='/ht/record/audio'"><span>AUDIO FILE </span></a></li>
                <li><a href="javascript://" onclick="location.href='/ht/record/lp'"><span>LP SHOP</span></a></li>
                <li><a href="javascript://" onclick="location.href='/ht/search/searchDetail/Record'"><span>음반 상세 검색 </span></a></li>
            </ul>
        </div>
        
        <div class="main_sec6">
            <ul class="main_slide_btn slide_view">
                <c:forEach items="${list2St}" var="l" varStatus="st">
                    <li class="main_slide_img"><ui:banner bannerImageUrl="${l.bnrImgUrl}" bnrLinkUrl="${l.bnrLnkUrl}" bnrSeq="${l.bnrSeq}" bnrTgtGbn="L" newWdwYn="${l.bnrNewWinYn}" alt="${l.bnrImgAlt}"/></li>
                </c:forEach>
            </ul>
            <ul class="main_slide_navi">
                <c:forEach items="${list2St}" var="l" varStatus="st">
                    <li class="slide_navi ${st.first?'active':''}"><a href="javascript://"><img src="${imageServer}/images/common/ic_navi<ui:lpad length="2" padChar="0">${st.count}</ui:lpad>.png"/></a></li>
                </c:forEach>
                <li class="slide_ctrl">
                    <a class="stop" href="javascript://">일시정지</a>
                </li>
            </ul>
        </div>
        
        <div class="record_banner mgt30">
            <ul>
                <c:forEach items="${list3St}" var="l" varStatus="st">
                    <li><a href="${l.bnrLnkUrl}"<c:if test="${l.bnrNewWinYn eq 'Y'}"> target="_blank"</c:if>><ui:image src="${l.bnrImgUrl}" alt="${l.bnrImgAlt}" style="width:361px;height:105px;"/></a></li>
                </c:forEach>
            </ul>
        </div>
    </div>
    
    <!-- //record_cd -->
    <p class="main_bg_line03"></p>

    <!--Pre orders -->
    <div class="pre_orders tab_wrap">
        <h2 class="tit"><img src="${imageServer}/images/renewal/shop/sub_tit04.gif" alt="pre orders" /></h2>
        <ul class="pre_tab tab_btn">
            <li><a href="#po01" class="on"><span>전체</span></a></li>
            <li><a href="#po02"><span>가요</span></a></li>
            <li><a href="#po03"><span>팝</span></a></li>
            <li><a href="#po04"><span>클래식</span></a></li>
        </ul>
        <div class="pre_pannels tab_pannels">
            <c:forEach begin="0" end="3" varStatus="s1">
                <c:if test="${s1.index eq 0}"><c:set var="list" value="${preOrdersList4Record}"/></c:if>
                <c:if test="${s1.index eq 1}"><c:set var="list" value="${preOrdersList4Song}"/></c:if>
                <c:if test="${s1.index eq 2}"><c:set var="list" value="${preOrdersList4Pop}"/></c:if>
                <c:if test="${s1.index eq 3}"><c:set var="list" value="${preOrdersList4Classic}"/></c:if>
                <div id="po0${s1.count}" class="pannel">
                    <ul>
                        <c:forEach items="${list}" var="l" varStatus="st" end="6">
                            <li class="c${st.count}">
                                <a href="/ht/record/detail/${l.sellPrdtBcode}">
                                    <c:if test="${st.first}"><span class="img"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" rcrdImgType="large" width="${l.sellPrdtGbn eq 'R'?'260':'171'}" alt="${l.prdtName}" ratingCode="A"/></span></c:if>
                                    <c:if test="${!st.first}"><span class="img"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" width="${l.sellPrdtGbn eq 'R'?'133':'87'}" alt="${l.prdtName}" ratingCode="A"/></span></c:if>
                                    <span class="artist txt_line1">${l.artiName}</span>
                                    <span class="tit txt_line1">${l.prdtName}</span>
                                    <span class="rlsedt txt_line1">발매일:<ui:mask pattern="##월##일">${fn:substring(l.rlseDt, 4, 8)}</ui:mask></span>
                                    <em class="price">
                                        <c:if test="${l.prdtSellPrice eq l.dscntPrice}">
                                            <span class="sale"><fmt:formatNumber value="${l.prdtSellPrice}" pattern=",###"/></span>
                                        </c:if>
                                        <c:if test="${l.prdtSellPrice ne l.dscntPrice}">
                                            <span class="dc"><fmt:formatNumber value="${l.prdtSellPrice}" pattern=",###"/></span>
                                            <span class="sale"><fmt:formatNumber value="${l.dscntPrice}" pattern=",###"/></span>
                                            <span class="pc"><fmt:formatNumber value="${hfn:rate(l.prdtSellPrice,l.dscntPrice)}" pattern=",###"/>%</span>
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
    <!--// Pre orders -->
        
    <!--music Magazine -->
    <div class="music_magazine mgt45 mgb55">
        <h2 class="tit"><span style="font-weight: bold;">Music</span> Magazine</h2>
        <a href="/ht/idol/news" class="btn_more">MORE +</a>
        <div class="magazine_1">
            <c:forEach items="${idolNews }" var="l" begin="0" end="1" varStatus="st" >
                <div class="magazine_detail">
                    <a href="/ht/idol/newsDetail?cntid=${l.cntid }">
                        <p class="img" style="background:url('${l.image}') center center no-repeat; background-size: cover;"></p>
                        <span class="title">
                            <c:choose>
                                <c:when test="${not empty l.title && fn:length(l.title) >= 43 }">
                                    ${l.title}<span class="content_after">...</span>
                                </c:when>
                                <c:otherwise>${l.title}</c:otherwise>
                            </c:choose>
                        </span>
                        <span class="date">${l.pubdt }</span>
                    </a>
                </div>
            </c:forEach>
            <c:forEach items="${idolNews }" var="l" begin="2" end="4" varStatus="st" >
                <div class="magazine_detail">
                    <a href="/ht/idol/newsDetail?cntid=${l.cntid }">
                        <p class="img" style="background: url('${l.image}') center center no-repeat; background-size: cover; "></p>
                        <span class="title">
                            <c:choose>
                                <c:when test="${not empty l.title && fn:length(l.title) >= 29}">${l.title}<span class="content_after">...</span></c:when>
                                <c:otherwise>${l.title}</c:otherwise>
                            </c:choose>
                        </span> 
                        <span class="date">${l.pubdt }</span>
                    </a>
                </div>
            </c:forEach>
        </div>
        <div class="magazine_2">
           <c:forEach items="${idolReport }" var="l" begin="0" end="5" varStatus="st" >
                <div class="news_detail">
                    <a href="/ht/idol/specialDetail?cntid=${l.cntid }">
                        <span class="title">
                            <c:choose>
                                <c:when test="${not empty l.title && fn:length(l.title) >= 34 }">${l.title}<span class="content_after">...</span></c:when>
                                <c:otherwise>${l.title}</c:otherwise>
                            </c:choose>
                        </span>
                    </a>
                </div>
            </c:forEach>
            <c:forEach items="${idolReport }" var="l" begin="6" end="8" varStatus="st" >
                <div class="news_content">
                    <a href="/ht/idol/specialDetail?cntid=${l.cntid }">
                        <p class="img" style="background:url('${l.image}') center center no-repeat; background-size: cover; "></p>
                        <span class="title">
                            <c:choose>
                                <c:when test="${not empty l.title && fn:length(l.title) >= 73 }">${l.title}<span class="content_after">...</span></c:when>
                                <c:otherwise>${l.title}</c:otherwise>
                            </c:choose>
                        </span>
                        <span class="date">${l.pubdt }</span>
                    </a>
                </div>
            </c:forEach>
        </div>
    </div>
    
    <p class="main_bg_line03"></p>

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

    <p class="main_bg_line03"></p>

    <!-- New Releases -->
    <div class="pre_orders tab_wrap">
        <h2 class="tit"><img src="${imageServer}/images/renewal/shop/sub_tit05.gif" alt="New Releases" /></h2>
        <ul class="pre_tab tab_btn">
            <li><a href="#nr01" class="on"><span>전체</span></a></li>
            <li><a href="#nr02"><span>가요</span></a></li>
            <li><a href="#nr03"><span>팝</span></a></li>
            <li><a href="#nr04"><span>클래식</span></a></li>
            <!-- <li style="width:158px;"><a href="#nr05"><span>재즈</span></a></li>
            <li style="width:158px;"><a href="#nr06"><span>O.S.T.</span></a></li> -->
        </ul>
        <div class="pre_pannels tab_pannels">
            <c:forEach begin="0" end="5" varStatus="s1">
                <c:if test="${s1.index eq 0}"><c:set var="list" value="${newReleasesList4Record}"/></c:if>
                <c:if test="${s1.index eq 1}"><c:set var="list" value="${newReleasesList4Song}"/></c:if>
                <c:if test="${s1.index eq 2}"><c:set var="list" value="${newReleasesList4Pop}"/></c:if>
                <c:if test="${s1.index eq 3}"><c:set var="list" value="${newReleasesList4Classic}"/></c:if>
                <%-- <c:if test="${s1.index eq 4}"><c:set var="list" value="${newReleasesList4Jazz}"/></c:if>
                <c:if test="${s1.index eq 5}"><c:set var="list" value="${newReleasesList4Ost}"/></c:if> --%>
                <div id="nr0${s1.count}" class="pannel">
                    <ul>
                        <c:forEach items="${list}" var="l" varStatus="st" end="6">
                            <li class="c${st.count}">
                                <a href="/ht/record/detail/${l.sellPrdtBcode}">
                                    <c:if test="${st.first}"><span class="img"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" rcrdImgType="large" width="${l.sellPrdtGbn eq 'R'?'260':'171'}" alt="${l.prdtName}" ratingCode="A"/></span></c:if>
                                    <c:if test="${!st.first}"><span class="img"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" width="${l.sellPrdtGbn eq 'R'?'133':'87'}" alt="${l.prdtName}" ratingCode="A"/></span></c:if>
                                    <span class="artist txt_line1">${l.artiName}</span>
                                    <span class="tit txt_line1">${l.prdtName}</span>
                                    <em class="price">
                                        <c:if test="${l.prdtSellPrice eq l.dscntPrice}">
                                            <span class="sale"><fmt:formatNumber value="${l.prdtSellPrice}" pattern=",###"/></span>
                                        </c:if>
                                        <c:if test="${l.prdtSellPrice ne l.dscntPrice}">
                                            <span class="dc"><fmt:formatNumber value="${l.prdtSellPrice}" pattern=",###"/></span>
                                            <span class="sale"><fmt:formatNumber value="${l.dscntPrice}" pattern=",###"/></span>
                                            <span class="pc"><fmt:formatNumber value="${hfn:rate(l.prdtSellPrice,l.dscntPrice)}" pattern=",###"/>%</span>
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
    <!--// New Releases -->

    <div class="event_list">
        <ul class="list">
            <c:forEach items="${list5St}" var="l" varStatus="st">
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

    <p class="main_bg_line03"></p>

    <div class="best_banner tab_wrap realtime"></div>

    <p class="main_bg_line03"></p>

    <div class="mds_pick02">
        <h2 class="tit"><img src="${imageServer}/images/renewal/shop/sub_tit02.gif" alt="Md's pick"></h2>
        <ul class="best_album">
            <c:forEach begin="0" end="4" varStatus="s1">
                <c:if test="${s1.index eq 0}"><c:set var="bgCls" value="active"/><c:set var="master" value="${mst6St}"/><c:set var="list" value="${list6St}"/></c:if>
                <c:if test="${s1.index eq 1}"><c:set var="bgCls" value="bg_white"/><c:set var="master" value="${mst7St}"/><c:set var="list" value="${list7St}"/></c:if>
                <c:if test="${s1.index eq 2}"><c:set var="bgCls" value=""/><c:set var="master" value="${mst8St}"/><c:set var="list" value="${list8St}"/></c:if>
                <c:if test="${s1.index eq 3}"><c:set var="bgCls" value="bg_white"/><c:set var="master" value="${mst9St}"/><c:set var="list" value="${list9St}"/></c:if>
                <c:if test="${s1.index eq 4}"><c:set var="bgCls" value=""/><c:set var="master" value="${mst10St}"/><c:set var="list" value="${list10St}"/></c:if>
                <li class="${bgCls}">
                    <a href="#n" class="tab"><span></span>${master.title}</a>
                    <div class="depth2">
                        <c:forEach items="${list}" varStatus="s2" step="4" end="7">
                            <ul>
                                <c:forEach items="${list}" var="l" varStatus="st" begin="${s2.index}" end="${s2.index+3}">
                                    <li class="txt_line1">
                                        <a href="/ht/record/detail/${l.sellPrdtBcode}" title="${l.artiName} - ${l.prdtName}">
                                            <span class="cover"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" width="${l.sellPrdtGbn eq 'R'?'133':'87'}" alt="${l.prdtName}" ratingCode="A"/></span>
                                            <span class="artist">${l.prdtDesc}</span>
                                            <strong class="tit">${l.prdtName}</strong>
                                        </a>
                                    </li>
                                </c:forEach>
                            </ul>
                        </c:forEach>
                    </div>
                </li>
            </c:forEach>
        </ul>
    </div>
</div>
<!-- //컨텐츠 -->
</body>
</html>