<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<ui:decorator name="record"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="/css/contents.css"/>
<script type="text/javascript">

/* 좌측메뉴 하위 메뉴 노출 컨트롤 */
function leftSubmenuShow(target){ $(".left_sub_menu_" + target).show(); }
function leftSubmenuHide(target){ $(".left_sub_menu_" + target).hide(); }


/* new_box_rolling */
var promtIdx,rightIdx,preOrdersIdx;
var isOverToPromt,isOverTRoRight,isOverToPreOrders;
var promtSize,rightSize,preOrdersSize;
var rollSpeed;
var roller;

function rollerClick(div, index){
    $('div.'+div+' ul li').each(function(i){
        if(i == index){
            $(this).fadeIn();
        }else{
            $(this).hide();
        }
    });

    $('div.'+div+' p a').each(function(i){
        if(i == index){
            $(this).addClass('on');
        }else{
            $(this).removeClass('on');
        }
    });
}

function rollerClickDiv(div, index){
    $('div.'+div+' div').each(function(i){
        if(i == index){
            $(this).fadeIn();
        }else{
            $(this).hide();
        }
    });

    $('div.'+div+' p a').each(function(i){
        if(i == index){
            $(this).addClass('on');
        }else{
            $(this).removeClass('on');
        }
    });
}

function initRoller(){
    promtIdx = 0;
    isOverToPromt = false;
    promtSize = $('div.one ul li').length;
    rightIdx = 0;
    isOverToRight = false;
    rightSize = $('div.two ul li').length;
    preOrdersIdx = 0;
    isOverToPreOrders = false;
    preOrdersSize = $('div.pre_right div').length;
    rollSpeed = 4000;
    
    roller = setInterval(nextClick, rollSpeed);
}

function nextClick(){
    if(!isOverToPromt){
        promtIdx = ((promtIdx+1)%promtSize);
        rollerClick('one', promtIdx);
    }
    if(!isOverToRight){
        rightIdx = ((rightIdx+1)%rightSize);
        rollerClick('two', rightIdx);
    }
    if(!isOverToPreOrders){
        preOrdersIdx = ((preOrdersIdx+1)%preOrdersSize);
        rollerClickDiv('pre_right', preOrdersIdx);
    }
}

function showRecordDiv(classNm, target){
   $('div.'+classNm+' div').hide();
   $('div.'+classNm+' div.'+target).fadeIn();
   
   $('div.'+classNm+' p.tab a').removeClass('on');
   $('div.'+classNm+' p.tab a.'+target).addClass('on');
}

function showRealtime(target){
    $('div.realtime_chart a').removeClass('on');
    $('div.realtime_chart a.'+target).addClass('on');
    $('div.realtimeAll').hide();
    $('div.realtimeImpY').hide();
    $('div.realtimeImpN').hide();

    $('div.'+target).fadeIn('fast');
}

jQuery(function($){
    $(document).ready(function(){
        initRoller();
    });
    
    $('div.one ul li').each(function(){
        $(this).hover(function(){isOverToPromt = true;}, function(){isOverToPromt = false;});
    });

    $('div.two ul li').each(function(){
        $(this).hover(function(){isOverToRight = true;}, function(){isOverToRight = false;});
    });
    
    $('div.pre_right div, div.pre_right p').each(function(){
        $(this).hover(function(){isOverToPreOrders = true;}, function(){isOverToPreOrders = false;});
    });
    
    $('div.snb_n_music ul li').each(function(){$(this).mouseover(function(){$(this).find('ul').show();});});
    $('div.snb_n_music ul li').each(function(){$(this).mouseout(function(){$(this).find('ul').hide();});});
});
</script>
</head>
<body>
        <div id="container"> 
            <!-- music 현재 페이지 위치 소스 입니다 -->
            <div class="page_music">
                <div class="page-location">
                    <p class="title"><img src="${imageServer}/images/music/title_music_09.gif" alt="클래식" /></p>
                    <ul>
                        <li><a href="/ht/welcomeMain">홈</a> <span>&gt;</span></li>
                        <li><a href="<ui:recordConstants key="url_record_main" />">음반</a> <span>&gt;</span></li>
                        <li><strong><ui:category id="${ctgrId}" full="false"></ui:category></strong></li>
                    </ul>
                </div>
            </div>
            <!-- //music 현재 페이지 위치 소스 입니다 -->
            <div class="music_top"> 
                <!--music_snb-->
                <div class="music_left_col">
                    <div class="snb_n_music">
                        <ul>
                            <c:forEach items="${categoryListLeft}" var="l" varStatus="s">
                                <li 
                                   onmousemove="leftSubmenuShow('${l.cateId}')" 
                                   onmouseout="leftSubmenuHide('${l.cateId}')"
                                   <c:if test="${fn:startsWith(category.cateId, l.cateId)}">class="on"</c:if>
                                >
                                    <span><a href="/ht/record/category/${l.cateId}">${l.cateName}</a></span>
                                    
                                    <c:if test="${not empty l.childCategoryList}">
                                        <ul class="left_sub_menu_${l.cateId}">
                                            <c:forEach items="${l.childCategoryList}" var="ls" varStatus="ss">
                                                <li <c:if test="${ss.index eq 0}">class="first-child"</c:if>><a href="/ht/record/category/${ls.cateId}">${ls.cateName}</a></li>
                                            </c:forEach> 
                                        </ul>
                                    </c:if>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                     <div class="box_red">
                        <ul>
                            <li><a href="/ht/record/box?searchAudioLpBoxCate=classic"><img src="${imageServer}/images/main/img_music_redbox_01.gif"  alt="box set" /></a></li>
                            <li><a href="/ht/record/audio?searchAudioLpBoxCate=classic"><img src="${imageServer}/images/main/img_music_redbox_02.gif"  alt="audio file" /></a></li>
                            <li><a href="/ht/record/lp?searchAudioLpBoxCate=classic"><img src="${imageServer}/images/main/img_music_redbox_03.gif"  alt="lp shop" /></a></li>
                        </ul>
                    </div>
                    <div class="notice">
                        <h3><img src="${imageServer}/images/main/h3_labelin.gif" alt="레이블 입고 안내" /></h3>
                        <ul>
                            <c:forEach items="${labelList}" var="l" varStatus="s">
                                <li><a href="/ht/record/lableStockedDetail?labelClassId=${l.labelClassId }" title="${l.clssName}">[<fmt:formatDate value="${l.regstDtm }" pattern="MM/dd"/>] <ui:cut isStripHtml="true" limit="9" tail="..">${l.clssName}</ui:cut></a></li>
                            </c:forEach>
                        </ul>
                        <p class="more"><a href="/ht/record/lableStockedList?labelGbn=C0902"><img src="${imageServer}/images/main/btn_more.gif" /></a></p>
                    </div>
                    <div class="music_search_sub">
                        <p><a href="/ht/search/searchDetail/Record"><img src="${imageServer}/images/main/img_music_msearch.gif" alt="음악 상세 검색" /></a></p>
                    </div> 
                    <div class="banner">
                        <ul>
                            <c:forEach items="${cateEventBanners}" var="l" varStatus="s">
                                <c:if test="${s.first}"><c:set var="imgHeight" value="150px"/></c:if>
                                <c:if test="${!s.first}"><c:set var="imgHeight" value="60px"/></c:if>
                                <li><ui:banner bnrLinkUrl="${l.bnrLinkUrl}" bannerImageUrl="${l.bannerImageUrl}" bnrTgtGbn="${l.bnrTgtGbn}" bnrSeq="${l.bnrSeq}" newWdwYn="${l.newWdwYn}" width="180px" height="${imgHeight}"/></li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
                <!--//music_snb--> 
                <!--music_contents-->
                <div class="music_contents">
                    <div class="music_event_korean">
                        <div class="one">
                            <ul>
                                <c:forEach items="${promtBanners}" var="l" varStatus="s">
                                    <li <c:if test="${!s.first}">style="display:none;"</c:if>>
                                        <ui:banner bnrLinkUrl="${l.bnrLinkUrl}" bannerImageUrl="${l.bannerImageUrl}" bnrTgtGbn="${l.bnrTgtGbn}" bnrSeq="${l.bnrSeq}" newWdwYn="${l.newWdwYn}" width="540px" height="270px"/>
                                    </li>
                                </c:forEach>
                            </ul>
                            <p class="paginate">
                                <c:forEach items="${promtBanners}" var="promt" varStatus="status">
                                    <a onclick="rollerClick('one', '${status.index}')"
                                        <c:if test="${status.first}">class="on"</c:if>
                                        <c:if test="${status.last}">class="bg_none"</c:if>
                                    >
                                        ${status.index+1}
                                    </a>
                                </c:forEach>
                            </p>
                        </div>
                        <div class="two">
                            <ul>
                                <c:forEach items="${rightBanners}" var="l" varStatus="s">
                                    <li <c:if test="${!s.first}">style="display:none;"</c:if>>
                                        <ui:banner bnrLinkUrl="${l.bnrLinkUrl}" bannerImageUrl="${l.bannerImageUrl}" bnrTgtGbn="${l.bnrTgtGbn}" bnrSeq="${l.bnrSeq}" newWdwYn="${l.newWdwYn}" width="200px" height="270px"/>
                                    </li>
                                </c:forEach>
                            </ul>
                            <p class="btn">
                                <c:forEach items="${rightBanners}" var="right" varStatus="s">
                                    <a onclick="rollerClick('two', '${s.index}')"
                                        <c:if test="${s.first}">class="on"</c:if>
                                    >
                                        ${s.index+1}
                                    </a>
                                </c:forEach>
                            </p>
                        </div>
                    </div>
                    <div class="preorder">
                        <h3><img src="${imageServer}/images/main/h3_preoder.gif"  alt="pre oder" /></h3>
                        <div class="bg">
                            <div class="pre_left">
                                <dl class="hot">
                                    <c:if test="${not empty preOrderHeader}">
                                        <dt>
                                            <a href="/ht/record/detail/${preOrderHeader[0].sellPrdtBcode}">
                                                <c:if test="${preOrderHeader[0].sellPrdtGbn eq 'R'}">
                                                    <ui:image rcrdCd="${preOrderHeader[0].rcrdCd}" prdtGbn="${preOrderHeader[0].sellPrdtGbn}" width="150" ratingCode="A"/>
                                                </c:if>
                                                <c:if test="${preOrderHeader[0].sellPrdtGbn eq 'D'}">
                                                    <ui:image rcrdCd="${preOrderHeader[0].rcrdCd}" prdtGbn="${preOrderHeader[0].sellPrdtGbn}" width="99" ratingCode="A"/>
                                                </c:if>
                                            </a>
                                        </dt>
                                        <dd class="album_name"><a href="/ht/record/detail/${preOrderHeader[0].sellPrdtBcode}"><ui:cut isStripHtml="true" limit="15" tail="...">${preOrderHeader[0].rcrdName}</ui:cut></a></dd>
                                        <dd class="singer"><a href="/ht/record/detail/${preOrderHeader[0].sellPrdtBcode}"><ui:cut isStripHtml="true" limit="15" tail="...">${preOrderHeader[0].artiName}</ui:cut></a></dd>
                                        <dd class="price">
                                            <span class="bold"><fmt:formatNumber value="${preOrderHeader[0].priceReal}" pattern="###,###,###"/>원</span>
                                            <span class="f_orange">[${hfn:rate(preOrderHeader[0].prdtSellPrice, preOrderHeader[0].priceReal)}%+${preOrderHeader[0].prdtSavedRate}%P]</span>
                                        </dd>
                                        <dd class="release_date">발매일: <ui:mask pattern="##월##일"><ui:substring beginIndex="4" endIndex="8">${preOrderHeader[0].rlseDt}</ui:substring></ui:mask></dd>
                                    </c:if>
                                </dl>
                            </div>
                            <div class="pre_right">
                                <c:forEach items="${preOrders}" var="l" varStatus="s">
                                    <c:if test="${s.index%4 eq 0}">
                                        <div <c:if test="${s.index ne 0}">style="display:none;"</c:if>>
                                    </c:if>
                                    <dl
                                        <c:if test="${(s.index+1) % 4 eq 0}">class="bor_none"</c:if>
                                    >
                                        <dt>
                                            <a href="/ht/record/detail/${l.sellPrdtBcode}">
                                                <c:if test="${l.sellPrdtGbn eq 'R'}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" width="120" ratingCode="A" /></c:if>
                                                <c:if test="${l.sellPrdtGbn eq 'D'}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" width="78" ratingCode="A" /></c:if>
                                            </a>
                                        </dt>
                                        <dd class="album_name"><a href="/ht/record/detail/${l.sellPrdtBcode}"><ui:cut isStripHtml="true" limit="10" tail="...">${l.rcrdName}</ui:cut></a></dd>
                                        <dd class="singer"><a href="/ht/record/detail/${l.sellPrdtBcode}"><ui:cut isStripHtml="true" limit="10" tail="...">${l.artiName}</ui:cut></a></dd>
                                        <dd class="price">
                                            <span class="bold"><fmt:formatNumber value="${l.priceReal}" pattern="###,###,###"/>원</span>
                                            <span class="f_orange">[${hfn:rate(l.prdtSellPrice, l.priceReal)}%+${l.prdtSavedRate}%P]</span>
                                        </dd>
                                        <dd class="release_date">발매일: <ui:mask pattern="##월##일"><ui:substring beginIndex="4" endIndex="8">${l.rlseDt}</ui:substring></ui:mask></dd>
                                    </dl>
                                    <c:if test="${s.index%4 eq 3}"></div></c:if>
                                    <c:if test="${s.last and fn:length(preOrders)%4 ne 0}"></div></c:if>
                                </c:forEach>
                                <p class="btn">
                                    <c:forEach items="${preOrders}" var="l" varStatus="s">
                                        <c:if test="${s.index % 4 eq 0}">
                                            <a onclick="rollerClickDiv('pre_right', '${(s.index/4)}')"
                                                <c:if test="${s.index eq 0}">class="on"</c:if>>${(s.index/4)}</a>
                                        </c:if>
                                    </c:forEach>
                                </p>
                                <p class="more"><a href="/ht/record/reserve/000308"><img src="${imageServer}/images/main/btn_more.gif" /></a></p>
                            </div>
                        </div>
                    </div>
                    <div class="newrel_kor">
                        <h3><img src="${imageServer}/images/main/h3_new_release.gif" alt="new relrease" /></h3>
                        <div class="one">
                            <c:forEach items="${newImportReleases}" var="l" varStatus="s">
                                <dl class="big_v">
                                    <dt>
                                        <a href="/ht/record/detail/${l.sellPrdtBcode}">
                                            <c:if test="${l.sellPrdtGbn eq 'R'}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" width="120" ratingCode="A" /></c:if>
                                            <c:if test="${l.sellPrdtGbn eq 'D'}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" width="78" ratingCode="A" /></c:if>
                                        </a>
                                    </dt>
                                    <dd class="album_name"><a href="/ht/record/detail/${l.sellPrdtBcode}"><ui:cut isStripHtml="true" limit="10" tail="...">${l.rcrdName}</ui:cut></a></dd>
                                    <dd class="singer"><a href="/ht/record/detail/${l.sellPrdtBcode}"><ui:cut isStripHtml="true" limit="10" tail="...">${l.artiName}</ui:cut></a></dd>
                                    <dd class="price">
                                        <span class="bold"><fmt:formatNumber value="${l.priceReal}" pattern="###,###,###"/>원</span>
                                        <span class="f_orange">[${hfn:rate(l.prdtSellPrice, l.priceReal)}%+${l.prdtSavedRate}%P]</span>
                                    </dd>
                                    <dd class="release_date">발매일: <ui:mask pattern="##월##일"><ui:substring beginIndex="4" endIndex="8">${l.rlseDt}</ui:substring></ui:mask></dd>
                                </dl>
                            </c:forEach>
                        </div>
                        <div class="two" style="display:none;">
                            <c:forEach items="${newLicenseReleases}" var="l" varStatus="status">
                                <dl class="big_v">
                                    <dt>
                                        <a href="/ht/record/detail/${l.sellPrdtBcode}">
                                            <c:if test="${l.sellPrdtGbn eq 'R'}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" width="120" ratingCode="A" /></c:if>
                                            <c:if test="${l.sellPrdtGbn eq 'D'}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" width="78" ratingCode="A" /></c:if>
                                        </a>
                                    </dt>
                                    <dd class="album_name"><a href="/ht/record/detail/${l.sellPrdtBcode}"><ui:cut isStripHtml="true" limit="10" tail="...">${l.rcrdName}</ui:cut></a></dd>
                                    <dd class="singer"><a href="/ht/record/detail/${l.sellPrdtBcode}"><ui:cut isStripHtml="true" limit="10" tail="...">${l.artiName}</ui:cut></a></dd>
                                    <dd class="price">
                                        <span class="bold"><fmt:formatNumber value="${l.priceReal}" pattern="###,###,###"/>원</span>
                                        <span class="f_orange">[${hfn:rate(l.prdtSellPrice, l.priceReal)}%+${l.prdtSavedRate}%P]</span>
                                    </dd>
                                    <dd class="release_date">발매일: <ui:mask pattern="##월##일"><ui:substring beginIndex="4" endIndex="8">${l.rlseDt}</ui:substring></ui:mask></dd>
                                </dl>
                            </c:forEach>
                        </div>
                        <p class="tab"><a onclick="showRecordDiv('newrel_kor', 'one');" class="one on">수입</a><a onclick="showRecordDiv('newrel_kor', 'two');" class="two bg_none">라이센스</a></p>
                    </div>
                    <div class="hotissue_kor">
                        <h3><img src="${imageServer}/images/main/h3_hotissue.gif" alt="hot issue" /></h3>
                        <div class="one">
                            <c:forEach items="${hotImportIssues}" var="l" varStatus="s">
                                <dl class="big_v">
                                    <dt>
                                        <a href="/ht/record/detail/${l.sellPrdtBcode}">
                                            <ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" width="120" ratingCode="A" />
                                        </a>
                                    </dt>
                                    <dd class="album_name"><a href="/ht/record/detail/${l.sellPrdtBcode}"><ui:cut isStripHtml="true" limit="10" tail="...">${l.rcrdName}</ui:cut></a></dd>
                                    <dd class="singer"><a href="/ht/record/detail/${l.sellPrdtBcode}"><ui:cut isStripHtml="true" limit="10" tail="...">${l.artiName}</ui:cut></a></dd>
                                    <dd class="price">
                                        <span class="bold"><fmt:formatNumber value="${l.priceReal}" pattern="###,###,###"/>원</span>
                                        <span class="f_orange">[${hfn:rate(l.prdtSellPrice, l.priceReal)}%+${l.prdtSavedRate}%P]</span>
                                    </dd>
                                    <dd class="release_date">발매일: <ui:mask pattern="##월##일"><ui:substring beginIndex="4" endIndex="8">${l.rlseDt}</ui:substring></ui:mask></dd>
                                </dl>
                            </c:forEach>
                        </div>
                        <div class="two" style="display:none;">
                            <c:forEach items="${hotLicenseIssues}" var="l" varStatus="s">
                                <dl class="big_v">
                                    <dt>
                                        <a href="/ht/record/detail/${l.sellPrdtBcode}">
                                            <ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" width="120" ratingCode="A" />
                                        </a>
                                    </dt>
                                    <dd class="album_name"><a href="/ht/record/detail/${l.sellPrdtBcode}"><ui:cut isStripHtml="true" limit="10" tail="...">${l.rcrdName}</ui:cut></a></dd>
                                    <dd class="singer"><a href="/ht/record/detail/${l.sellPrdtBcode}"><ui:cut isStripHtml="true" limit="10" tail="...">${l.artiName}</ui:cut></a></dd>
                                    <dd class="price">
                                        <span class="bold"><fmt:formatNumber value="${l.priceReal}" pattern="###,###,###"/>원</span>
                                        <span class="f_orange">[${hfn:rate(l.prdtSellPrice, l.priceReal)}%+${l.prdtSavedRate}%P]</span>
                                    </dd>
                                    <dd class="release_date">발매일: <ui:mask pattern="##월##일"><ui:substring beginIndex="4" endIndex="8">${l.rlseDt}</ui:substring></ui:mask></dd>
                                </dl>
                            </c:forEach>
                        </div>
                        <p class="tab"><a onclick="showRecordDiv('hotissue_kor', 'one');" class="one on">수입</a><a onclick="showRecordDiv('hotissue_kor', 'two');" class="two bg_none">라이센스</a></p>
                    </div>
                </div>
                <!--//music_contents--> </div>
            <div class="realtime_chart">
                <h3><img src="${imageServer}/images/main/h3_realtime_chart.gif" alt="실시간 차트" /></h3>
                <div class="md_album realtimeImpY">
                    <c:forEach items="${realtimeImpY}" var="l" varStatus="s">
                        <c:if test="${s.index < 3}">
                            <dl class="big">
                                <dt>
                                    <a href="/ht/record/detail/${l.sellPrdtBcode}">
                                        <c:if test="${l.sellPrdtGbn eq 'R'}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" width="120" ratingCode="A"/></c:if>
                                        <c:if test="${l.sellPrdtGbn eq 'D'}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" width="78" ratingCode="A"/></c:if>
                                    </a>
                                </dt>
                                <dd class="album_name"><a href="/ht/record/detail/${l.sellPrdtBcode}"><ui:cut isStripHtml="true" limit="20" tail="...">${l.rcrdName}</ui:cut></a></dd>
                                <dd class="singer"><a href="/ht/record/detail/${l.sellPrdtBcode}"><ui:cut isStripHtml="true" limit="20" tail="...">${l.artiName}</ui:cut></a></dd>
                                <dd class="price">
                                    <span class="bold"><fmt:formatNumber value="${l.priceReal}" pattern="###,###,###"/>원</span>
                                    <span class="f_orange">[${hfn:rate(l.prdtSellPrice, l.priceReal)}%+${l.prdtSavedRate}%P]</span>
                                </dd>
                                <dd class="release_date">발매일: <ui:mask pattern="##월##일"><ui:substring beginIndex="4" endIndex="8">${l.rlseDt}</ui:substring></ui:mask></dd>
                                <dd class="desc_album"><ui:cut isStripHtml="true" limit="45" tail="...">${l.description}</ui:cut></dd>
                                <dd class="no"><img src="${imageServer}/images/main/icon_no${s.index+1}.png" class="iepngfix" alt="${s.index+1}위"/></dd>
                            </dl>
                        </c:if>
                        <c:if test="${s.index >= 3}">
                            <dl class="small">
                                <dt>
                                    <a href="/ht/record/detail/${l.sellPrdtBcode}">
                                        <c:if test="${l.sellPrdtGbn eq 'R'}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" width="120" ratingCode="A"/></c:if>
                                        <c:if test="${l.sellPrdtGbn eq 'D'}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" width="78" ratingCode="A"/></c:if>
                                    </a>
                                </dt>
                                <dd class="album_name"><a href="/ht/record/detail/${l.sellPrdtBcode}"><ui:cut isStripHtml="true" limit="10" tail="...">${l.rcrdName}</ui:cut></a></dd>
                                <dd class="singer"><a href="/ht/record/detail/${l.sellPrdtBcode}"><ui:cut isStripHtml="true" limit="10" tail="...">${l.artiName}</ui:cut></a></dd>
                                <dd class="price">
                                    <span class="bold"><fmt:formatNumber value="${l.priceReal}" pattern="###,###,###"/>원</span>
                                    <span class="f_orange">[${hfn:rate(l.prdtSellPrice, l.priceReal)}%+${l.prdtSavedRate}%P]</span>
                                </dd>
                                <dd class="release_date">발매일: <ui:mask pattern="##월##일"><ui:substring beginIndex="4" endIndex="8">${l.rlseDt}</ui:substring></ui:mask></dd>
                                <dd class="no"><img src="${imageServer}/images/main/icon_no${s.index+1}.gif" alt="${s.index+1}위"/></dd>
                            </dl>
                        </c:if>
                    </c:forEach>
                </div>
                <div class="md_album realtimeImpN" style="display:none;">
                    <c:forEach items="${realtimeImpN}" var="l" varStatus="s">
                        <c:if test="${s.index < 3}">
                            <dl class="big">
                                <dt>
                                    <a href="/ht/record/detail/${l.sellPrdtBcode}">
                                        <c:if test="${l.sellPrdtGbn eq 'R'}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" width="120" ratingCode="A"/></c:if>
                                        <c:if test="${l.sellPrdtGbn eq 'D'}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" width="78" ratingCode="A"/></c:if>
                                    </a>
                                </dt>
                                <dd class="album_name"><a href="/ht/record/detail/${l.sellPrdtBcode}"><ui:cut isStripHtml="true" limit="20" tail="...">${l.rcrdName}</ui:cut></a></dd>
                                <dd class="singer"><a href="/ht/record/detail/${l.sellPrdtBcode}"><ui:cut isStripHtml="true" limit="20" tail="...">${l.artiName}</ui:cut></a></dd>
                                <dd class="price">
                                    <span class="bold"><fmt:formatNumber value="${l.priceReal}" pattern="###,###,###"/>원</span>
                                    <span class="f_orange">[${hfn:rate(l.prdtSellPrice, l.priceReal)}%+${l.prdtSavedRate}%P]</span>
                                </dd>
                                <dd class="release_date">발매일: <ui:mask pattern="##월##일"><ui:substring beginIndex="4" endIndex="8">${l.rlseDt}</ui:substring></ui:mask></dd>
                                <dd class="desc_album"><ui:cut isStripHtml="true" limit="45" tail="...">${l.description}</ui:cut></dd>
                                <dd class="no"><img src="${imageServer}/images/main/icon_no${s.index+1}.png" class="iepngfix" alt="${s.index+1}위"/></dd>
                            </dl>
                        </c:if>
                        <c:if test="${s.index >= 3}">
                            <dl class="small">
                                <dt>
                                    <a href="/ht/record/detail/${l.sellPrdtBcode}">
                                        <c:if test="${l.sellPrdtGbn eq 'R'}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" width="120" ratingCode="A"/></c:if>
                                        <c:if test="${l.sellPrdtGbn eq 'D'}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" width="78" ratingCode="A"/></c:if>
                                    </a>
                                </dt>
                                <dd class="album_name"><a href="/ht/record/detail/${l.sellPrdtBcode}"><ui:cut isStripHtml="true" limit="10" tail="...">${l.rcrdName}</ui:cut></a></dd>
                                <dd class="singer"><a href="/ht/record/detail/${l.sellPrdtBcode}"><ui:cut isStripHtml="true" limit="10" tail="...">${l.artiName}</ui:cut></a></dd>
                                <dd class="price">
                                    <span class="bold"><fmt:formatNumber value="${l.priceReal}" pattern="###,###,###"/>원</span>
                                    <span class="f_orange">[${hfn:rate(l.prdtSellPrice, l.priceReal)}%+${l.prdtSavedRate}%P]</span>
                                </dd>
                                <dd class="release_date">발매일: <ui:mask pattern="##월##일"><ui:substring beginIndex="4" endIndex="8">${l.rlseDt}</ui:substring></ui:mask></dd>
                                <dd class="no"><img src="${imageServer}/images/main/icon_no${s.index+1}.gif" alt="${s.index+1}위"/></dd>
                            </dl>
                        </c:if>
                    </c:forEach>
                </div>
                <div class="md_album realtimeAll" style="display:none;">
                    <c:forEach items="${realtimeAll}" var="l" varStatus="s">
                        <c:if test="${s.index < 3}">
                            <dl class="big">
                                <dt>
                                    <a href="/ht/record/detail/${l.sellPrdtBcode}">
                                        <c:if test="${l.sellPrdtGbn eq 'R'}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" width="120" ratingCode="A"/></c:if>
                                        <c:if test="${l.sellPrdtGbn eq 'D'}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" width="78" ratingCode="A"/></c:if>
                                    </a>
                                </dt>
                                <dd class="album_name"><a href="/ht/record/detail/${l.sellPrdtBcode}"><ui:cut isStripHtml="true" limit="20" tail="...">${l.rcrdName}</ui:cut></a></dd>
                                <dd class="singer"><a href="/ht/record/detail/${l.sellPrdtBcode}"><ui:cut isStripHtml="true" limit="20" tail="...">${l.artiName}</ui:cut></a></dd>
                                <dd class="price">
                                    <span class="bold"><fmt:formatNumber value="${l.priceReal}" pattern="###,###,###"/>원</span>
                                    <span class="f_orange">[${hfn:rate(l.prdtSellPrice, l.priceReal)}%+${l.prdtSavedRate}%P]</span>
                                </dd>
                                <dd class="release_date">발매일: <ui:mask pattern="##월##일"><ui:substring beginIndex="4" endIndex="8">${l.rlseDt}</ui:substring></ui:mask></dd>
                                <dd class="desc_album"><ui:cut isStripHtml="true" limit="45" tail="...">${l.description}</ui:cut></dd>
                                <dd class="no"><img src="${imageServer}/images/main/icon_no${s.index+1}.png" class="iepngfix" alt="${s.index+1}위"/></dd>
                            </dl>
                        </c:if>
                        <c:if test="${s.index >= 3}">
                            <dl class="small">
                                <dt>
                                    <a href="/ht/record/detail/${l.sellPrdtBcode}">
                                        <c:if test="${l.sellPrdtGbn eq 'R'}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" width="120" ratingCode="A"/></c:if>
                                        <c:if test="${l.sellPrdtGbn eq 'D'}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" width="78" ratingCode="A"/></c:if>
                                    </a>
                                </dt>
                                <dd class="album_name"><a href="/ht/record/detail/${l.sellPrdtBcode}"><ui:cut isStripHtml="true" limit="10" tail="...">${l.rcrdName}</ui:cut></a></dd>
                                <dd class="singer"><a href="/ht/record/detail/${l.sellPrdtBcode}"><ui:cut isStripHtml="true" limit="10" tail="...">${l.artiName}</ui:cut></a></dd>
                                <dd class="price">
                                    <span class="bold"><fmt:formatNumber value="${l.priceReal}" pattern="###,###,###"/>원</span>
                                    <span class="f_orange">[${hfn:rate(l.prdtSellPrice, l.priceReal)}%+${l.prdtSavedRate}%P]</span>
                                </dd>
                                <dd class="release_date">발매일: <ui:mask pattern="##월##일"><ui:substring beginIndex="4" endIndex="8">${l.rlseDt}</ui:substring></ui:mask></dd>
                                <dd class="no"><img src="${imageServer}/images/main/icon_no${s.index+1}.gif" alt="${s.index+1}위"/></dd>
                            </dl>
                        </c:if>
                    </c:forEach>
                </div>
                <p class="tab"><a onclick="showRealtime('realtimeImpY')" class="realtimeImpY on">수입</a><a onclick="showRealtime('realtimeImpN')" class="realtimeImpN">라이센스</a> <a onclick="showRealtime('realtimeAll')" class="realtimeAll bg_none">전체</a></p>
            </div>
            <div class="md_choice_kor">
                <h3><img src="${imageServer}/images/main/h3_mdchoice.gif" alt="md choice" /></h3>
                <div class="md_album">
                    <c:forEach items="${mdsChoices}" var="l" varStatus="s">
                        <c:if test="${s.index < 3}">
                            <dl class="big">
                                <dt>
                                    <a href="/ht/record/detail/${l.sellPrdtBcode}">
                                        <c:if test="${l.sellPrdtGbn eq 'R'}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" width="120" ratingCode="A"/></c:if>
                                        <c:if test="${l.sellPrdtGbn eq 'D'}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" width="78" ratingCode="A"/></c:if>
                                    </a>
                                </dt>
                                <dd class="album_name"><a href="/ht/record/detail/${l.sellPrdtBcode}"><ui:cut isStripHtml="true" limit="20" tail="...">${l.rcrdName}</ui:cut></a></dd>
                                <dd class="singer"><a href="/ht/record/detail/${l.sellPrdtBcode}"><ui:cut isStripHtml="true" limit="20" tail="...">${l.artiName}</ui:cut></a></dd>
                                <dd class="price">
                                    <span class="bold"><fmt:formatNumber value="${l.priceReal}" pattern="###,###,###"/>원</span>
                                    <span class="f_orange">[${hfn:rate(l.prdtSellPrice, l.priceReal)}%+${l.prdtSavedRate}%P]</span>
                                </dd>
                                <dd class="release_date">발매일: <ui:mask pattern="##월##일"><ui:substring beginIndex="4" endIndex="8">${l.rlseDt}</ui:substring></ui:mask></dd>
                                <dd class="desc_album"><ui:cut isStripHtml="true" limit="50" tail="...">${l.rcrdDesc}</ui:cut></dd>
                            </dl>
                        </c:if>
                        <c:if test="${s.index >= 3}">
                            <dl class="small">
                                <dt>
                                    <a href="/ht/record/detail/${l.sellPrdtBcode}">
                                        <c:if test="${l.sellPrdtGbn eq 'R'}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" width="120" ratingCode="A"/></c:if>
                                        <c:if test="${l.sellPrdtGbn eq 'D'}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" width="78" ratingCode="A"/></c:if>
                                    </a>
                                </dt>
                                <dd class="album_name"><a href="/ht/record/detail/${l.sellPrdtBcode}"><ui:cut isStripHtml="true" limit="10" tail="...">${l.rcrdName}</ui:cut></a></dd>
                                <dd class="singer"><a href="/ht/record/detail/${l.sellPrdtBcode}"><ui:cut isStripHtml="true" limit="10" tail="...">${l.artiName}</ui:cut></a></dd>
                                <dd class="price">
                                    <span class="bold"><fmt:formatNumber value="${l.priceReal}" pattern="###,###,###"/>원</span>
                                    <span class="f_orange">[${hfn:rate(l.prdtSellPrice, l.priceReal)}%+${l.prdtSavedRate}%P]</span>
                                </dd>
                                <dd class="release_date">발매일: <ui:mask pattern="##월##일"><ui:substring beginIndex="4" endIndex="8">${l.rlseDt}</ui:substring></ui:mask></dd>
                            </dl>
                        </c:if>
                    </c:forEach>
                </div>
            </div>
            <div class="classic_bluray">
                <h3><img src="${imageServer}/images/main/h3_classic_blu-ray.gif" alt="classic" /></h3>
                <div class="md_album one">
                    <c:forEach items="${bluRays}" var="l" varStatus="status">
                        <dl class="small">
                            <dt>
                                <a href="/ht/record/detail/${l.sellPrdtBcode}">
                                    <c:if test="${l.sellPrdtGbn eq 'R'}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" width="120" ratingCode="A"/></c:if>
                                    <c:if test="${l.sellPrdtGbn eq 'D'}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" width="78" ratingCode="A"/></c:if>
                                </a>
                            </dt>
                            <dd class="album_name"><a href="/ht/record/detail/${l.sellPrdtBcode}"><ui:cut isStripHtml="true" limit="20" tail="...">${l.rcrdName}</ui:cut></a></dd>
                            <dd class="price">
                                <span class="bold"><fmt:formatNumber value="${l.priceReal}" pattern="###,###,###"/>원</span>
                                <span class="f_orange">[${hfn:rate(l.prdtSellPrice, l.priceReal)}%+${l.prdtSavedRate}%P]</span>
                            </dd>
                            <dd class="release_date">발매일: <ui:mask pattern="##월##일"><ui:substring beginIndex="4" endIndex="8">${l.rlseDt}</ui:substring></ui:mask></dd>
                        </dl>
                    </c:forEach>
                </div>
                <div class="md_album two" style="display:none;">
                    <c:forEach items="${dvds}" var="l" varStatus="s">
                        <dl class="small">
                            <dt>
                                <a href="/ht/record/detail/${l.sellPrdtBcode}">
                                    <c:if test="${l.sellPrdtGbn eq 'R'}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" width="120" ratingCode="A"/></c:if>
                                    <c:if test="${l.sellPrdtGbn eq 'D'}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" width="78" ratingCode="A"/></c:if>
                                </a>
                            </dt>
                            <dd class="album_name"><a href="/ht/record/detail/${l.sellPrdtBcode}"><ui:cut isStripHtml="true" limit="20" tail="...">${l.rcrdName}</ui:cut></a></dd>
                            <dd class="price">
                                <span class="bold"><fmt:formatNumber value="${l.priceReal}" pattern="###,###,###"/>원</span>
                                <span class="f_orange">[${hfn:rate(l.prdtSellPrice, l.priceReal)}%+${l.prdtSavedRate}%P]</span>
                            </dd>
                            <dd class="release_date">발매일: <ui:mask pattern="##월##일"><ui:substring beginIndex="4" endIndex="8">${l.rlseDt}</ui:substring></ui:mask></dd>
                        </dl>
                    </c:forEach>
                </div>
                <p class="btn">
                    <a onclick="showRecordDiv('classic_bluray', 'one');"><img src="${imageServer}/images/main/btn_classic_blu-ray.gif" alt="blu-ray" /></a>
                    <a onclick="showRecordDiv('classic_bluray', 'two');" class="right"><img src="${imageServer}/images/main/btn_classic_dvd.gif" alt="dvd" /></a> 
                </p>
            </div>
        </div>
    </body>
</html>