<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="welcomeMain"/>
<!DOCTYPE ui:decorator PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!--  SNS 공유 내용 -->
<meta property="og:type" content="website"/>
<meta property="og:title" content="HOTTRACKS - 생활 속 감성충전소"/>
<meta property="og:url" content="${defaultHost}/ht/welcomeMain"/>
<meta property="og:image" content="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/renewal/common/logo_over.gif"/>
<!--  SNS 공유 내용 -->
<!-- 레이어팝업 -->
<c:if test="${not empty list21St}">
<style type="text/css">
<!--
.window { display:none;position:fixed;z-index:1002; }
.window .bnr-btn { position:relative;padding:5px 100px;color:#eaeaea;font-weight:bold;line-height:25px; }
.window .bnr-btn a { color:#eaeaea;font-weight:bold;font-size:15px; }
.window .bnr-btn .left { position:absolute;left:0; }
.window .bnr-btn .right { position:absolute;right:0; }
-->
</style>
<script type="text/javascript">
<!--
// 툴바감추기
window.addEventListener('load', function(){
    setTimeout(scrollTo, 0, 0, 1);
}, false);

function wrapWindowByMask(){
    //화면의 높이와 너비를 구한다.
    var maskHeight = $(document).height();  
    var maskWidth = $(document).width();
    
    var bnrTop = $(window).height()/2 - $(".window .bnr-img img:first").height()/2;
    var bnrLeft = $(window).width()/2 - $(".window .bnr-img img:first").width()/2;
    
    //마스크의 높이와 너비를 화면 것으로 만들어 전체 화면을 채운다.
    $('#mask').css({'width':maskWidth,'height':maskHeight});
    $('.window').css({'left':bnrLeft,'top':bnrTop});

    //애니메이션 효과
    // $('#mask').fadeIn(500);
    $('#mask').fadeTo(10,0.6);
    
    $('.window').show();
}

jQuery(function($){
    $(document).ready(function(){
        //if(navigator.appName.charAt(0) == "N" && navigator.userAgent.indexOf("Chrome") != -1){   // 크롬에서만 작동
            if(getCookie("NOT_ANIMORE") == null || getCookie("NOT_ANIMORE") == ""){
                wrapWindowByMask();
            }
        //}
    });
    
    //검은 막 띄우기
    $('.window .close').click(function(e){
        e.preventDefault();
        if($("input#notAnymore").is(":checked")){
            setCookie("NOT_ANIMORE", "Y", 1);
        }
        
        $(".window").hide();
        $("#mask").hide();
    });
    
});
//-->
</script>
</c:if>

<script type="text/javascript" src="/js/fn_htts_slide.js"></script>
<script type="text/javascript">
<!--
jQuery(function($){
    $(document).ready(function(){
        slideDiv(".main_sec1", 6000, ".main_sec1");
        slideDiv(".main_sec2", 0, "#rBnrItem01");
        slideDiv(".main_sec3", 0, "#rBnrItem02");
        
        initRand(".main_sec2");         // 우측상단배너
        initRand(".main_sec3");         // 우측하단배너
        initRandTab(".prod_tab01");     // New item/Hot Brand/펜슬파우치
        initRandTab(".prod_tab02");     // Trend Issue
        initRandTab(".prod_tab03");     // Hot Event
        initRandTab(".prod_tab04");     // Best Award/Wish List
        initRandTab(".prod_tab05");     // Sytle/Idea/Design
        initRandTab(".prod_tab06");     // Culture Event/Music Event
        initRandTab(".prod_tab07");     // FOCUS ON
        
        jpPopup();
    });
    
    $.ajax({
        type: "GET"
        ,url: "/ht/getPopupList"
        ,data: {dispGbn : 'W'}
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

// 일본전용 팝업
function jpPopup(){
    var language;
    if (navigator.language) {
      // 비 IE에서 작동
      language = navigator.language
    } else {
      // IE에서 작동
      $.ajax({
        url: "http://ajaxhttpheaders.appspot.com",
        dataType: 'jsonp',
        success: function(headers) {
          language = headers['Accept-Language'];
          // alert(language) // 요청 헤더에서 추출한 사용자 브라우저의 언어를 열거합니다.
        }
      });
    }
    // console.log(language);
    if(language == undefined || language == null)    return;
    if(language.indexOf('ja') > -1){
        $.ajax({
            type: "GET"
            ,url: "/ht/getPopupList"
            ,data: {dispGbn : 'J'}
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
    }else if(language.indexOf('en-us') > -1){
        $.ajax({
            type: "GET"
            ,url: "/ht/getPopupList"
            ,data: {dispGbn : 'U'}
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
    }
}

function initRandTab(clsName){
    var length = $(clsName).length;
    var now = new Date();
    var idx = Math.floor(now.getSeconds()%length);
    // console.log(clsName + "::" + length + "::" + now.getMinutes() + "::" + idx);
    // var idx = Math.floor((Math.random() * length) + 1);
    $(clsName).eq(idx).click();
}
//-->
</script>
</head>
<body>
<c:if test="${not empty list21St}">
<!-- //레이어팝업 -->
<div class="window"> 
    <c:forEach items="${list21St}" var="l" end="0">
        <div class="bnr-img">
            <a href="${l.bnrLnkUrl}"<c:if test="${l.bnrNewWinYn eq 'Y'}"> target="_blank"</c:if>>
                <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${l.bnrImgUrl}" alt="${l.bnrImgAlt}"
                    <c:if test="${not empty l.bnrImgUrl2}">class="roll_img"</c:if>
                    hover="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${l.bnrImgUrl2}"
                    default="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${l.bnrImgUrl}"
                    onerror="this.src='${imageServer}/images/no_image2.gif';"
                    width="${l.orgBnrWidth}"
                    height="${l.orgBnrHeight}"
                />
            </a>
        </div>
    </c:forEach>
    <p class="bnr-btn">
        <span class="left">
            <input type="checkbox" value="notAnymore" id="notAnymore"/>
            <label for="notAnymore">오늘 하루 창 열지 않기</label>
        </span>
        <span class="right"><a href="#" class="close">닫기X</a></span>
    </p> 
</div> 
</c:if>
<!-- 메인배너 -->
<div id="main_spot">
    <%--
    <c:forEach items="${listGnb01}" var="l" end="0">
        <div class="mgt25">
            <ui:banner bnrLinkUrl="${l.bnrLnkUrl}" bannerImageUrl="${l.bnrImgUrl}" bnrTgtGbn="L" bnrSeq="${l.bnrSeq}" newWdwYn="${l.bnrNewWinYn}"/>
        </div>
    </c:forEach>
    --%>
    <div class="main_sec1">
        <ul class="main_slide_btn slide_view">
            <c:forEach items="${list22St}" var="l" varStatus="st" begin="0" end="13">
                <li class="main_slide_img"><ui:banner bannerImageUrl="${l.bnrImgUrl}" bnrLinkUrl="${l.bnrLnkUrl}" bnrSeq="${l.bnrSeq}" bnrTgtGbn="L" newWdwYn="${l.bnrNewWinYn}" alt="${l.bnrImgAlt}" clazz="PC_MAIN"/></li>
            </c:forEach>
        </ul>
        <ul class="main_slide_navi">
            <c:forEach items="${list22St}" var="l" varStatus="st"  begin="0" end="13">
                <li class="slide_navi ${st.first?'active':''}"><a href="javascript://"><img src="${imageServer}/images/common/ic_navi0${st.count}.png"/></a></li>
            </c:forEach>
            <li class="slide_ctrl">
                <a class="stop" href="javascript://">일시정지</a>
            </li>
        </ul>
    </div>
    <!-- //메인배너 -->
    <!-- 메인우측배너 -->
    <div class="main_rbanner">
        <div class="rbanner_item" id="rBnrItem01">
            <div class="rbnr_area main_sec2">
                <ul class="slide_view rbnr_slide_btn">
                    <c:forEach items="${list23St}" var="l" varStatus="st">
                        <li class="control_item<c:if test="${st.first}"> active</c:if>"><ui:banner bnrLinkUrl="${l.bnrLnkUrl}" bannerImageUrl="${l.bnrImgUrl}" bnrTgtGbn="L" bnrSeq="${l.bnrSeq}" newWdwYn="${l.bnrNewWinYn}" clazz="PC_RIGHT_1"/></li>
                    </c:forEach>
                </ul>
                <ul class="rbnr_slide_navi">
                    <c:forEach items="${list23St}" var="l" varStatus="st">
                        <li class="slide_navi ${st.first?'active':''}"><a href="javascript://"><img src="${imageServer}/images/common/ic_navi0${st.count}.gif"/></a></li>
                    </c:forEach>
                </ul>
            </div>
        </div>
        <div class="rbanner_item02" id="rBnrItem02">
            <div class="rbnr_area main_sec3">
                <ul class="slide_view rbnr_slide_btn">
                    <c:forEach items="${list24St}" var="l" varStatus="st">
                        <li class="control_item<c:if test="${st.first}"> active</c:if>"><ui:banner bnrLinkUrl="${l.bnrLnkUrl}" bannerImageUrl="${l.bnrImgUrl}" bnrTgtGbn="L" bnrSeq="${l.bnrSeq}" newWdwYn="${l.bnrNewWinYn}" clazz="PC_RIGHT_2"/></li>
                    </c:forEach>
                </ul>
                <ul class="rbnr_slide_navi">
                    <c:forEach items="${list24St}" var="l" varStatus="st">
                        <li class="slide_navi ${st.first?'active':''}"><a href="javascript://"><img src="${imageServer}/images/common/ic_navi0${st.count}.gif"/></a></li>
                    </c:forEach>
                </ul>
            </div>
        </div>
    </div>
    <!-- //메인우측배너 -->
     <!-- 메인서브배너 -->
    <div class="main_sbanner">
        <ul>
            <c:forEach items="${list25St}" var="l" varStatus="st" end="1">
                <li><ui:banner bnrLinkUrl="${l.bnrLnkUrl}" bannerImageUrl="${l.bnrImgUrl}" bnrTgtGbn="L" bnrSeq="${l.bnrSeq}" newWdwYn="${l.bnrNewWinYn}" alt="${l.bnrImgAlt}" clazz="PC_MAIN_BOT_${st.count }"/></li>
            </c:forEach>
        </ul>
    </div>
</div>
<!-- //메인배너 -->

 <!-- Only today -->
<c:forEach items="${list2St}" var="l" varStatus="st">
 <div class="only_today">
     <ui:banner bnrLinkUrl="${l.bnrLnkUrl}" bannerImageUrl="${l.bnrImgUrl}" bnrTgtGbn="L" bnrSeq="${l.bnrSeq}" newWdwYn="${l.bnrNewWinYn}" alt="${l.bnrImgAlt}" id="PC_MAIN_BOT_3" />
 </div>
 </c:forEach>
 <!-- //Only today -->

<!-- 레코벨 추천 리스트 -->
<c:if test="${not empty listRecobell}">
	<div class="recobell tab_wrap">
	    <h1 class="tit fs18">내게 맞는 추천상품</h1>
	    <div class="tab_pannels">
	        <c:forEach items="${listRecobell}" varStatus="s1" step="5" end="14">
	            <ul id="recobell0${s1.count}" class="pannel">
	                <c:forEach items="${listRecobell}" var="l" varStatus="st" begin="${s1.index}" end="${s1.index+4}">
	                    <li class="PC_RECO">
	                        <span class="img">
	                            <c:if test="${l.sellPrdtGbn eq 'R' || l.sellPrdtGbn eq 'D'}"><a href="/ht/record/detail/${l.sellPrdtBcode}?foo=bar&rccode=pc_main1"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" ratingCode="A" rcrdImgType="large" width="${l.sellPrdtGbn eq 'R'?'150':'99'}" clazz="photo" alt="${fn:escapeXml(l.prdtName)}"/></a></c:if>
	                            <c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G' || l.sellPrdtGbn eq 'S'}"><a href="/ht/product/detail?barcode=${l.sellPrdtBcode}&foo=bar&rccode=pc_main1"><ui:image src="${l.prdtImgUrl}" src2="${l.productImageUrl2}" size="150" server="product" clazz="photo" alt="${fn:escapeXml(l.prdtName)}"/></a></c:if>
	                        </span>
	                        <c:if test="${l.sellPrdtGbn eq 'R' || l.sellPrdtGbn eq 'D'}"><a href="/ht/record/detail/${l.sellPrdtBcode}?foo=bar&rccode=pc_main1"></c:if>
	                        <c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G' || l.sellPrdtGbn eq 'S'}"><a href="/ht/product/detail?barcode=${l.sellPrdtBcode}&foo=bar&rccode=pc_main1"></c:if>
	                            <span class="name txt_line1">${fn:escapeXml(l.prdtName)}</span>
	                            <em class="price">
	                                <c:if test="${l.basePrdtSellPrice ne l.lastCpnPrice}">
	                                    <span class="dc"><fmt:formatNumber type="number">${l.basePrdtSellPrice}</fmt:formatNumber></span>
	                                </c:if>
	                                <span class="sale"><fmt:formatNumber type="number">${l.lastCpnPrice}</fmt:formatNumber></span>
	                                <c:if test="${l.basePrdtSellPrice ne l.lastCpnPrice}">
	                                    <c:if test="${l.prdtStatCode ne 'C0312'}"><span class="pc"><img src="${imageServer}/images/renewal/common/ic_status_soldout.gif" alt="품절"/></span></c:if>
	                                    <c:if test="${l.prdtStatCode eq 'C0312'}"><span class="pc"><fmt:formatNumber value="${hfn:rate(l.basePrdtSellPrice,l.lastCpnPrice)}" pattern=",###"/>%</span></c:if>
	                                </c:if>
	                            </em>
	                        </a>
	                    </li>
	                </c:forEach>
	            </ul>
	        </c:forEach>
	    </div>
	    <ul class="recobell_navi tab_btn">
	        <c:forEach items="${listRecobell}" varStatus="s1" step="5" end="14">
	            <li><a href="#recobell0${s1.count}" class="prod_tab07<c:if test="${s1.first}"> on</c:if>">${s1.count}</a></li>
	        </c:forEach>
	    </ul>
	</div>
</c:if>
<!-- 레코벨 추천 리스트 -->

 <!-- Promotion_banner -->
 <div class="promotion_banner tab_wrap">
    <ul class="prod_tab tab_btn">
        <li><a href="#pl01" class="prod_tab01 on"><span>${mst3St.title}</span></a></li>
        <li><a href="#pl02" class="prod_tab01"><span>${mst4St.title}</span></a></li>
        <li><a href="#pl03" class="prod_tab01"><span>${mst5St.title}</span></a></li>
    </ul>
    
    <div class="prod_list tab_pannels">
        <c:forEach begin="0" end="2" varStatus="s1">
            <c:if test="${s1.index eq 0}"><c:set var="list" value="${list3St}"/></c:if>
            <c:if test="${s1.index eq 1}"><c:set var="list" value="${list4St}"/></c:if>
            <c:if test="${s1.index eq 2}"><c:set var="list" value="${list5St}"/></c:if>
            <ul id="pl0${s1.count}"  class="pannel"><!-- 1 -->
                <c:forEach items="${list}" var="l" varStatus="st">
                    <li>
                        <a href="${l.bnrLnkUrl}" <c:if test="${l.bnrNewWinYn eq 'Y'}"> target="_blank"</c:if>>
                            <p class="img"><ui:image src="${l.bnrImgUrl}" alt="${l.bnrImgAlt}" width="${l.bnrWidth}" height="${l.bnrHeight}" clazz="PC_BOT_5ITEM_${s1.count}"/></p>
                            <strong class="tit">${l.bnrTitle}</strong>
                            <p class="descript">${l.bnrSubTitle}</p>
                        </a>
                    </li>
                </c:forEach>
            </ul>
        </c:forEach>
    </div>
</div>
<!-- //Promotion_banner -->

<!-- Trend event-->
<c:forEach items="${list6St}" var="l" varStatus="st">
    <div class="wide_banner trend_event">
        <p class="img"><a href="${l.bnrLnkUrl}" <c:if test="${l.bnrNewWinYn eq 'Y'}"> target="_blank"</c:if>><ui:image src="${l.bnrImgUrl}" alt="${l.bnrImgAlt}" clazz="PC_BOT_WIDE_1"/></a></p>
    </div>
</c:forEach>
<!--//Trend event-->

<!-- Event banner -->
<div class="event_banner">
    <!-- Trend issue -->
    <div class="trend_issue tab_wrap">
        <strong class="tit"><ui:image src="${mst7St.imgUrl}" alt="${mst7St.imgAlt}"/></strong>
        <ul class="event_tab tab_btn">
            <c:forEach items="${list7St}" var="l" varStatus="st">
                <li><a href="#tr0${st.count}" class="prod_tab02<c:if test="${st.first}"> on</c:if>"><span>0${st.count}</span></a></li>
            </c:forEach>
        </ul>
        <div class="trend_pannels tab_pannels">
            <c:forEach items="${list7St}" var="l" varStatus="st">
                <div id="tr0${st.count}" class="pannel">
                    <span class="img"><a href="${l.bnrLnkUrl}"<c:if test="${l.bnrNewWinYn eq 'Y'}"> target="_blank"</c:if>><ui:image src="${l.bnrImgUrl}" alt="${l.bnrImgAlt}" clazz="PC_BOT_L"/></a></span>
                    <a href="${l.bnrLnkUrl}"<c:if test="${l.bnrNewWinYn eq 'Y'}"> target="_blank"</c:if>><strong class="slogan">${l.bnrTitle}</strong></a>
                    <p class="descrip">${l.bnrSubTitle}</p>
                </div>
            </c:forEach>
        </div>
    </div>
    <!-- //Trend issue -->
    <!-- Thank you -->
    <div class="thank_you tab_wrap">
        <strong class="tit"><ui:image src="${mst8St.imgUrl}" alt="${mst7St.imgAlt}"/></strong>
        <ul class="event_tab tab_btn">
            <c:forEach items="${list8St}" var="l" varStatus="st">
                <li><a href="#ty0${st.count}" class="prod_tab03<c:if test="${st.first}"> on</c:if>"><span>0${st.count}</span></a></li>
            </c:forEach>
        </ul>
        <div class="trend_pannels tab_pannels">
            <c:forEach items="${list8St}" var="l" varStatus="st">
                <div id="ty0${st.count}" class="pannel">
                    <span class="img"><a href="${l.bnrLnkUrl}"<c:if test="${l.bnrNewWinYn eq 'Y'}"> target="_blank"</c:if>><ui:image src="${l.bnrImgUrl}" alt="${l.bnrImgAlt}" clazz="PC_BOT_R"/></a></span>
                    <a href="${l.bnrLnkUrl}"<c:if test="${l.bnrNewWinYn eq 'Y'}"> target="_blank"</c:if>><strong class="slogan">${l.bnrTitle}</strong></a>
                    <p class="descrip">${l.bnrSubTitle}</p>
                </div>
            </c:forEach>
        </div>
    </div>
    <!-- //Thank you -->
</div>
<!-- //Event banner -->

<p class="main_bg_line03"></p>

<!-- Theme box -->
<div class="theme_box tab_wrap02">
    <ul class="prod_tab tab_btn">
        <li><a href="#PC_BOT_3ITEM_1" class="prod_tab04 on"><span>${mst9St.title}</span></a></li>
        <li><a href="#PC_BOT_3ITEM_2" class="prod_tab04"><span>${mst10St.title}</span></a></li>
    </ul>
    <!-- Best Award -->
    <div id="PC_BOT_3ITEM_1" class="theme_pannels tab_pannels" style="display:block;">
        <c:forEach begin="0" end="2" varStatus="s1">
            <div class="pannel">
                <ul class="theme_tab">
                    <c:forEach items="${list9St}" var="l" varStatus="st">
                        <c:if test="${l.groupNum eq s1.count}">
                            <li><a href="#tt0${s1.index*3+st.count}"><span><ui:image src="${l.bnrImgUrl2}" alt="${l.bnrImgAlt}" width="84" height="84"/></span></a></li>
                        </c:if>
                    </c:forEach>
                </ul>
                <div class="theme_list">
                    <c:forEach items="${list9St}" var="l" varStatus="st">
                        <c:if test="${l.groupNum eq s1.count}">
                            <div id="tt0${s1.index*3+st.count}" class="prod">
                                <a href="${l.bnrLnkUrl}"<c:if test="${l.bnrNewWinYn eq 'Y'}"> target="_blank"</c:if>>
                                    <span class="img"><ui:image src="${l.bnrImgUrl}" alt="${l.bnrImgAlt}" width="298" height="237" clazz="PC_BOT_3ITEM_1"/></span>
                                    <span class="name">${l.bnrTitle}</span>
                                    <span class="price">${l.bnrSubTitle}</span>
                                </a>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
            </div>
        </c:forEach>
    </div>
    <!-- //Best Award -->

    <!-- Wish List -->
    <div id="PC_BOT_3ITEM_2" class="theme_pannels tab_pannels">
        <c:forEach begin="0" end="2" varStatus="s1">
            <div class="pannel">
                <ul class="theme_tab">
                    <c:forEach items="${list10St}" var="l" varStatus="st">
                        <c:if test="${l.groupNum eq s1.count}">
                            <li><a href="#tt${s1.index*3+st.count+9}"><span><ui:image src="${l.bnrImgUrl2}" alt="${l.bnrImgAlt}" width="84" height="84"/></span></a></li>
                        </c:if>
                    </c:forEach>
                </ul>
                <div class="theme_list">
                    <c:forEach items="${list10St}" var="l" varStatus="st">
                        <c:if test="${l.groupNum eq s1.count}">
                            <div id="tt${s1.index*3+st.count+9}" class="prod">
                                <a href="${l.bnrLnkUrl}"<c:if test="${l.bnrNewWinYn eq 'Y'}"> target="_blank"</c:if>>
                                    <span class="img"><ui:image src="${l.bnrImgUrl}" alt="${l.bnrImgAlt}" width="298" height="237"  clazz="PC_BOT_3ITEM_2"/></span>
                                    <span class="name">${l.bnrTitle}</span>
                                    <span class="price">${l.bnrSubTitle}</span>
                                </a>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
            </div>
        </c:forEach>
    </div>
    <!-- //Wish List -->
</div>
<!-- Theme box -->

<c:forEach items="${list11St}" var="l" varStatus="st">
    <div class="wide_banner">
        <p class="img"><a href="${l.bnrLnkUrl}"<c:if test="${l.bnrNewWinYn eq 'Y'}"> target="_blank"</c:if>><ui:image src="${l.bnrImgUrl}" alt="${l.bnrImgAlt}" clazz="PC_BOT_WIDE_2"/></a></p>
    </div>
</c:forEach>


<!-- Promotion_banner -->
<div class="promotion_banner tab_wrap">
    <ul class="prod_tab tab_btn">
        <li><a href="#pl04" class="prod_tab05 on"><span>${mst12St.title}</span></a></li>
        <li><a href="#pl05" class="prod_tab05"><span>${mst13St.title}</span></a></li>
        <li><a href="#pl06" class="prod_tab05"><span>${mst14St.title}</span></a></li>
    </ul>
    
    <div class="prod_list tab_pannels">
        <ul id="pl04" class="pannel"><!-- 1 -->
            <c:forEach items="${list12St}" var="l" varStatus="st">
                <li>
                    <a href="${l.bnrLnkUrl}"<c:if test="${l.bnrNewWinYn eq 'Y'}"> target="_blank"</c:if>>
                        <p class="img"><ui:image src="${l.bnrImgUrl}" alt="${l.bnrImgAlt}" width="${l.bnrWidth}" height="${l.bnrHeight}"/></p>
                        <strong class="tit">${l.bnrTitle}</strong>
                        <p class="descript">${l.bnrSubTitle}</p>
                    </a>
                </li>
            </c:forEach>
        </ul>
        <ul id="pl05" class="pannel"><!-- 2 -->
            <c:forEach items="${list13St}" var="l" varStatus="st">
                <li>
                    <a href="${l.bnrLnkUrl}"<c:if test="${l.bnrNewWinYn eq 'Y'}"> target="_blank"</c:if>>
                        <p class="img"><ui:image src="${l.bnrImgUrl}" alt="${l.bnrImgAlt}" width="${l.bnrWidth}" height="${l.bnrHeight}"/></p>
                        <strong class="tit">${l.bnrTitle}</strong>
                        <p class="descript">${l.bnrSubTitle}</p>
                    </a>
                </li>
            </c:forEach>
        </ul>
        <ul id="pl06" class="pannel"><!-- 3 -->
            <c:forEach items="${list14St}" var="l" varStatus="st">
                <li>
                    <a href="${l.bnrLnkUrl}"<c:if test="${l.bnrNewWinYn eq 'Y'}"> target="_blank"</c:if>>
                        <p class="img"><ui:image src="${l.bnrImgUrl}" alt="${l.bnrImgAlt}" width="${l.bnrWidth}" height="${l.bnrHeight}"/></p>
                        <strong class="tit">${l.bnrTitle}</strong>
                        <p class="descript">${l.bnrSubTitle}</p>
                    </a>
                </li>
            </c:forEach>
        </ul>
    </div>
</div>
<!-- //Promotion_banner -->

<!--Pre orders -->
<div class="tab_wrap">
    <h2 class="tit"><img src="${imageServer}/images/renewal/shop/sub_tit17.gif" alt="CD/DVD Best" /></h2>
    <ul class="pre_tab tab_btn mgt20">
        <li style="width:160px;"><a href="#po01" class="on"><span>전체</span></a></li>
        <li style="width:158px;"><a href="#po02"><span>가요</span></a></li>
        <li style="width:158px;"><a href="#po03"><span>팝</span></a></li>
        <li style="width:158px;"><a href="#po04"><span>클래식</span></a></li>
        <li style="width:158px;"><a href="#po05"><span>Blu-Ray</span></a></li>
        <li style="width:158px;"><a href="#po06"><span>DVD</span></a></li>
    </ul>
    <div class="pre_pannels tab_pannels" style="height:417px;">
            <div id="po01" class="pannel">
                <ul class="PC_CDDVD">
                    <c:forEach begin="0" end="6" varStatus="st">
                        <c:if test="${st.index eq 0}"><c:set var="l" value="${listBestSong[0]}"/></c:if>
                        <c:if test="${st.index eq 1}"><c:set var="l" value="${listBestPop[0]}"/></c:if>
                        <c:if test="${st.index eq 2}"><c:set var="l" value="${listBestClassic[0]}"/></c:if>
                        <c:if test="${st.index eq 3}"><c:set var="l" value="${listBestSong[1]}"/></c:if>
                        <c:if test="${st.index eq 4}"><c:set var="l" value="${listBestBluray[0]}"/></c:if>
                        <c:if test="${st.index eq 5}"><c:set var="l" value="${listBestDvd[0]}"/></c:if>
                        <c:if test="${st.index eq 6}"><c:set var="l" value="${listBestSong[2]}"/></c:if>
                        <li class="c${st.count}">
                            <a href="/ht/record/detail/${l.sellPrdtBcode}">
                                <c:if test="${st.first}"><span class="img"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" rcrdImgType="large" width="${l.sellPrdtGbn eq 'R'?'260':'171'}" alt="${l.prdtName}" ratingCode="A"/></span></c:if>
                                <c:if test="${!st.first}"><span class="img"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" width="${l.sellPrdtGbn eq 'R'?'133':'87'}" alt="${l.prdtName}" ratingCode="A"/></span></c:if>
                                <span class="artist txt_line1">${l.artiName}</span>
                                <span class="tit txt_line1">${l.commTitle}</span>
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
            </div>
            <c:forEach begin="0" end="4" varStatus="s1">
            <c:if test="${s1.index eq 0}"><c:set var="list" value="${listBestSong}"/></c:if>
            <c:if test="${s1.index eq 1}"><c:set var="list" value="${listBestPop}"/></c:if>
            <c:if test="${s1.index eq 2}"><c:set var="list" value="${listBestClassic}"/></c:if>
            <c:if test="${s1.index eq 3}"><c:set var="list" value="${listBestBluray}"/></c:if>
            <c:if test="${s1.index eq 4}"><c:set var="list" value="${listBestDvd}"/></c:if>
            <div id="po0${s1.count+1}" class="pannel">
                <ul>
                    <c:forEach items="${list}" var="l" varStatus="st" end="6">
                        <li class="c${st.count}">
                            <a href="/ht/record/detail/${l.sellPrdtBcode}">
                                <c:if test="${st.first}"><span class="img"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" rcrdImgType="large" width="${l.sellPrdtGbn eq 'R'?'260':'171'}" alt="${l.prdtName}" ratingCode="A"/></span></c:if>
                                <c:if test="${!st.first}"><span class="img"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" width="${l.sellPrdtGbn eq 'R'?'133':'87'}" alt="${l.prdtName}" ratingCode="A"/></span></c:if>
                                <span class="artist txt_line1">${l.artiName}</span>
                                <span class="tit txt_line1">${l.commTitle}</span>
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
            </div>
        </c:forEach>
    </div>
    
</div>
<!--// Pre orders -->

<!-- Focus On -->
<div class="focus_on tab_wrap">
    <p class="tit"><img src="${imageServer}/images/renewal/content/tit_focuson.gif" alt="FOCUS ON"/></p>
    <div class="tab_pannels">
        <c:forEach items="${listFocusOn}" varStatus="s1" step="5" end="14">
            <ul id="focus0${s1.count}" class="pannel">
                <c:forEach items="${listFocusOn}" var="l" varStatus="st" begin="${s1.index}" end="${s1.index+4}">
                    <li>
                        <span class="img">
                            <c:if test="${l.sellPrdtGbn eq 'R' || l.sellPrdtGbn eq 'D'}"><a href="/ht/record/detail/${l.sellPrdtBcode}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" ratingCode="A" rcrdImgType="large" width="${l.sellPrdtGbn eq 'R'?'150':'99'}" clazz="photo" alt="${fn:escapeXml(l.prdtName)}"/></a></c:if>
                            <c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G' || l.sellPrdtGbn eq 'S'}"><a href="/ht/product/detail?barcode=${l.sellPrdtBcode}"><ui:image src="${l.prdtImgUrl}" src2="${l.productImageUrl2}" size="150" server="product" clazz="photo" alt="${fn:escapeXml(l.prdtName)}"/></a></c:if>
                        </span>
                        <a href="/p/${l.sellPrdtBcode}">
                            <span class="name txt_line1">${fn:escapeXml(l.prdtName)}</span>
                            <em class="price">
                                <c:if test="${l.basePrdtSellPrice ne l.lastCpnPrice}">
                                    <span class="dc"><fmt:formatNumber type="number">${l.basePrdtSellPrice}</fmt:formatNumber></span>
                                </c:if>
                                <span class="sale"><fmt:formatNumber type="number">${l.lastCpnPrice}</fmt:formatNumber></span>
                                <c:if test="${l.basePrdtSellPrice ne l.lastCpnPrice}">
                                    <c:if test="${l.prdtStatCode ne 'C0312'}"><span class="pc"><img src="${imageServer}/images/renewal/common/ic_status_soldout.gif" alt="품절"/></span></c:if>
                                    <c:if test="${l.prdtStatCode eq 'C0312'}"><span class="pc"><fmt:formatNumber value="${hfn:rate(l.basePrdtSellPrice,l.lastCpnPrice)}" pattern=",###"/>%</span></c:if>
                                </c:if>
                            </em>
                        </a>
                    </li>
                </c:forEach>
            </ul>
        </c:forEach>
    </div>
    <ul class="focus_navi tab_btn">
        <c:forEach items="${listFocusOn}" varStatus="s1" step="5" end="14">
            <li><a href="#focus0${s1.count}" class="prod_tab07<c:if test="${s1.first}"> on</c:if>">${s1.count}</a></li>
        </c:forEach>
    </ul>
</div>
<!-- //Focus On -->

<!-- Main review -->
<div class="main_review tab_wrap mgt40">
    <ul class="review_tab tab_btn">
        <li><a href="#mr01" class="prod_tab06 on"><span>${mst19St.title}</span></a></li>
        <li><a href="#mr02" class="prod_tab06"><span>${mst20St.title}</span></a></li>
    </ul>
    
    <div class="review_pannels tab_pannels">
        <div id="mr01" class="pannel">
            <ul>
                <c:forEach items="${list19St}" var="l" varStatus="st">
                    <li>
                        <span><ui:image src="${l.bnrImgUrl}" alt="${l.bnrImgAlt}" width="${l.bnrWidth}" height="${l.bnrHeight}"/></span>
                        <div class="hide_box">
                            <a href="${l.bnrLnkUrl}"<c:if test="${l.bnrNewWinYn eq 'Y'}"> target="_blank"</c:if>><span>${l.bnrTitle}<c:if test="${not empty l.bnrSubTitle}"><br/>${l.bnrSubTitle}</span></c:if></a>
                        </div>
                    </li>
                </c:forEach>
            </ul>
        </div>
        <div id="mr02" class="pannel">
            <ul>
                <c:forEach items="${list20St}" var="l" varStatus="st">
                    <li>
                        <span><ui:image src="${l.bnrImgUrl}" alt="${l.bnrImgAlt}" width="${l.bnrWidth}" height="${l.bnrHeight}"/></span>
                        <div class="hide_box">
                            <a href="${l.bnrLnkUrl}"<c:if test="${l.bnrNewWinYn eq 'Y'}"> target="_blank"</c:if>><span>${l.bnrTitle}<c:if test="${not empty l.bnrSubTitle}"><br/>${l.bnrSubTitle}</c:if></span></a>
                        </div>
                    </li>
                </c:forEach>
            </ul>
        </div>
    </div>
</div>


<!-- //Main review-->


<!-- 빠른 메뉴 -->
<div class="main_quick_menu">
    <ul>
        <li class="c1"><a href="/ht/help/memberShip"><span>멤버십 혜택</span></a></li>
        <li class="c2"><a href="/ht/help/faqListC0393"><span>반품/교환안내</span></a></li>
        <li class="c3"><a href="/ht/help/faqSearchList"><span>자주묻는 질문</span></a></li>
        <li class="c4"><a href="/ht/help/eventPrizeList"><span>이벤트 당첨자</span></a></li>
        <li class="c6"><a href="/ht/help/vendorInquiry"><span>입점신청</span></a></li>
        <li class="c7"><a href="/ht/help/businessBuy"><span>대량구매문의</span></a></li>
    </ul>
</div>
<!-- //빠른 메뉴 -->
</body>
</html>