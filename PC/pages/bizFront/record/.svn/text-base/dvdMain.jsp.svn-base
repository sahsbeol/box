<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="recordMain"/>
<html>
<head>
<title>DVD메인 - HOTTRACKS</title>
<script type="text/javascript" src="/js/fn_htts_slide.js"></script>
<script type="text/javascript">
jQuery(function($){
    $(document).ready(function() {
        slideDiv(".main_sec6", 6000, ".main_sec6");
        
        $(".realtime").load("/ht/record/realtimeDvd", function(){
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
            ,data : { ctgrId:"0004" }
            ,success : function(data){
                if(data.notice != null){
                    $("#categoryList1").append("<li class='last_ev'><a href='javascript://' onclick='location.href=\"/ht/help/listNotice?notiSeq="+notice.notiSeq+"\";'>Notice i "+notice.title+"</a></li>");
                    $("#categoryList2").append("<li class='last_ev'><a href='javascript://' onclick='location.href=\"/ht/help/listNotice?notiSeq="+notice.notiSeq+"\";'>Notice i "+notice.title+"</a></li>");
                }
            } 
            ,error: function(data) {
                alert('<fmt:message key="error.common.system"/>');
            }
        });
        
        setGnbSrchMenu("RECORD");
    });
});
</script>
</head>
<body>
<!-- 컨텐츠 -->
<div class="content">
    <!-- record_cd -->
    <div class="record_cd">
        <div class="cate03 dvd">
            <div class="tab_wrap">
                <ul class="tab_dvd tab_btn">
                    <li><a href="#blu" class="on"><span>Blu-Ray</span></a></li>
                    <li><a href="#dvd"><span>DVD</span></a></li>
                </ul>
                <div class="tab_pannels"> 
                    <div id="blu" class="pannel">
                        <div class="btn_wrap">
                            <a href="/ht/record/bestList/000400?bestRangeType=C1002" class="btn_type01 bg_orange">BEST</a>
                            <a href="/ht/record/newRecord/000400" class="btn_type01">NEW</a>
                            <a href="/ht/record/reserve/000400" class="btn_type01">예약상품</a>
                        </div>
                        <ul id="categoryList1">
                            <li><a href="/ht/record/category/000400">전체보기</a></li>
                            <li><a href="/ht/record/category/00040000">드라마/로맨스</a></li>
                            <li><a href="/ht/record/category/00040001">애니메이션</a></li>
                            <li><a href="/ht/record/category/00040002">TV시리즈</a></li>
                            <li><a href="/ht/record/category/00040003">SF/판타지</a></li>
                            <li><a href="/ht/record/category/00040004">액션/모험</a></li>
                            <li><a href="/ht/record/category/00040005">공포/스릴러</a></li>
                            <li><a href="/ht/record/category/00040006">코메디</a></li>
                            <li><a href="/ht/record/category/00040007">뮤지컬영화</a></li>
                            <li><a href="/ht/record/category/00040008">다큐멘터리</a></li>
                            <li><a href="/ht/record/category/00040009">MUSIC BLU-RAY</a></li>
                            <li><a href="/ht/search/searchDetail/Dvd" class="fs11 on">BLU-RAY / DVD 상세 검색</a></li>
                            <!-- li><a href="/ht/record/bluray3dList">3D BLU-RAY</a></li -->
                        </ul>
                    </div>
                    <div id="dvd" class="pannel" style="display:none;">
                        <div class="btn_wrap">
                            <a href="/ht/record/bestList/000401?bestRangeType=C1002" class="btn_type01 bg_orange">BEST</a>
                            <a href="/ht/record/newRecord/000401" class="btn_type01">NEW</a>
                            <a href="/ht/record/reserve/000401" class="btn_type01">예약상품</a>
                        </div>
                        <ul id="categoryList2">
                            <li><a href="/ht/record/category/000401">전체보기</a></li>
                            <li><a href="/ht/record/category/00040100">드라마/로맨스</a></li>
                            <li><a href="/ht/record/category/00040101">애니메이션</a></li>
                            <li><a href="/ht/record/category/00040102">TV시리즈</a></li>
                            <li><a href="/ht/record/category/00040103">SF/판타지</a></li>
                            <li><a href="/ht/record/category/00040104">액션/모험</a></li>
                            <li><a href="/ht/record/category/00040105">공포/스릴러</a></li>
                            <li><a href="/ht/record/category/00040106">코메디</a></li>
                            <li><a href="/ht/record/category/00040107">뮤지컬영화</a></li>
                            <li><a href="/ht/record/category/00040109">다큐멘터리</a></li>
                            <li><a href="/ht/record/category/00040110">유아/어린이</a></li>
                            <li><a href="/ht/record/category/00040108">MUSIC DVD</a></li>
                            <li><a href="/ht/search/searchDetail/Dvd" class="fs11 on">BLU-RAY / DVD 상세 검색</a></li>
                        </ul>
                    </div>
                    <div class="brand_wrap ">
                        <ul class="bw_tab">
                            <c:forEach items="${labelMaster}" var="l" varStatus="st">
                                <li><a href="#bw${st.count}"<c:if test="${st.first}"> class="on"</c:if><c:if test="${not empty l.linkUrl}"> onclick="location.href='${l.linkUrl}';"</c:if>><span><ui:image src="${l.imageUrl}" width="35px" height="23px" alt="${st.count}"/></span></a></li>
                            </c:forEach>
                        </ul>
                        <c:forEach items="${labelMaster}" var="l" varStatus="st">
                            <div id="bw${st.count }" class="bw_pannels"<c:if test="${!st.first}"> style="display:none;"</c:if>>
                                <ul>
                                    <c:forEach items="${l.labelEventList}" var="l2" varStatus="s" end="3">
                                        <li>
                                            <c:if test="${not empty l2.sellPrdtBcode}"><a href="/ht/record/detail/${l2.sellPrdtBcode}" title="${l2.title}">${l2.title}</a></c:if>
                                            <c:if test="${not empty l2.eventId}"><a href="/ht/biz/eventDetail?eventId=${l2.eventId}" title="${l2.title}">${l2.title}</a></c:if>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </c:forEach>
                    </div>
                 </div>
             </div>
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
        <ul class="pre_tab col2 tab_btn">
            <li><a href="#po01" class="on"><span>BLU - RAY</span></a></li>
            <li><a href="#po02"><span>DVD</span></a></li>
        </ul>
        <div class="pre_pannels tab_pannels">
            <c:forEach begin="0" end="1" varStatus="s1">
                <c:if test="${s1.index eq 0}"><c:set var="list" value="${preOrdersList4BluRay}"/></c:if>
                <c:if test="${s1.index eq 1}"><c:set var="list" value="${preOrdersList4Dvd}"/></c:if>
                <div id="po0${s1.count}" class="pannel">
                    <ul>
                        <c:forEach items="${list}" var="l" varStatus="st" end="6">
                            <li class="c${st.count}">
                                <a href="/ht/record/detail/${l.sellPrdtBcode}">
                                    <c:if test="${st.first}"><span class="img"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" width="${l.sellPrdtGbn eq 'R'?'260':'171'}" rcrdImgType="large" alt="${l.prdtName}" ratingCode="A"/></span></c:if>
                                    <c:if test="${!st.first}"><span class="img"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" width="${l.sellPrdtGbn eq 'R'?'133':'87'}" alt="${l.prdtName}" ratingCode="A"/></span></c:if>
                                    <span class="artist">${l.artiName}</span>
                                    <span class="tit">${l.prdtName}</span>
                                    <span class="rlsedt">발매일:<ui:mask pattern="##월##일">${fn:substring(l.rlseDt, 4, 8)}</ui:mask></span>
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
    
    <c:if test="${not empty list4St}">
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
    </c:if>
    
    <p class="main_bg_line03"></p>
    
    <!-- New Releases -->
    <div class="pre_orders tab_wrap">
        <h2 class="tit"><img src="${imageServer}/images/renewal/shop/sub_tit05.gif" alt="New Releases" /></h2>
        <ul class="pre_tab col2 tab_btn">
            <li><a href="#nr01" class="on"><span>BLU - RAY</span></a></li>
            <li><a href="#nr02"><span>DVD</span></a></li>
        </ul>
        <div class="pre_pannels tab_pannels">
            <c:forEach begin="0" end="1" varStatus="s1">
                <c:if test="${s1.index eq 0}"><c:set var="list" value="${newReleasesList4BluRay}"/></c:if>
                <c:if test="${s1.index eq 1}"><c:set var="list" value="${newReleasesList4Dvd}"/></c:if>
                <div id="nr0${s1.count}" class="pannel">
                    <ul>
                        <c:forEach items="${list}" var="l" varStatus="st" end="6">
                            <li class="c${st.count}">
                                <a href="/ht/record/detail/${l.sellPrdtBcode}">
                                    <c:if test="${st.first}"><span class="img"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" width="${l.sellPrdtGbn eq 'R'?'260':'171'}" alt="${l.prdtName}" ratingCode="A"/></span></c:if>
                                    <c:if test="${!st.first}"><span class="img"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" width="${l.sellPrdtGbn eq 'R'?'133':'87'}" alt="${l.prdtName}" ratingCode="A"/></span></c:if>
                                    <span class="artist">${l.artiName}</span>
                                    <span class="tit">${l.prdtName}</span>
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
    
    <c:if test="${not empty list6St}">
    <div class="event_list">
        <ul class="list">
            <c:forEach items="${list6St}" var="l" varStatus="st">
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

    <div class="best_banner tab_wrap realtime"></div>

    <p class="main_bg_line03"></p>

    <div class="mds_pick02">
        <h2 class="tit"><img src="${imageServer}/images/renewal/shop/sub_tit02.gif" alt="Md's pick"></h2>
        <ul class="best_album">
            <c:forEach begin="0" end="4" varStatus="s1">
                <c:if test="${s1.index eq 0}"><c:set var="bgCls" value="active"/><c:set var="master" value="${mst7St}"/><c:set var="list" value="${list7St}"/></c:if>
                <c:if test="${s1.index eq 1}"><c:set var="bgCls" value="bg_white"/><c:set var="master" value="${mst8St}"/><c:set var="list" value="${list8St}"/></c:if>
                <c:if test="${s1.index eq 2}"><c:set var="bgCls" value=""/><c:set var="master" value="${mst9St}"/><c:set var="list" value="${list9St}"/></c:if>
                <c:if test="${s1.index eq 3}"><c:set var="bgCls" value="bg_white"/><c:set var="master" value="${mst10St}"/><c:set var="list" value="${list10St}"/></c:if>
                <c:if test="${s1.index eq 4}"><c:set var="bgCls" value=""/><c:set var="master" value="${mst11St}"/><c:set var="list" value="${list11St}"/></c:if>
                <li class="${bgCls}">
                    <a href="#n" class="tab"><span></span>${master.title}</a>
                    <div class="depth2">
                        <c:forEach items="${list}" varStatus="s2" step="4" end="7">
                            <ul>
                                <c:forEach items="${list}" var="l" varStatus="st" begin="${s2.index}" end="${s2.index+3}">
                                    <li class="txt_line1">
                                        <a href="/ht/record/detail/${l.sellPrdtBcode}" title="${l.artiName} - ${l.prdtName}">
                                            <span class="cover02"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" width="${l.sellPrdtGbn eq 'R'?'133':'87'}" alt="${l.prdtName}" ratingCode="A"/></span>
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