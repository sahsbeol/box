<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
<!-- 검색 키워드[보기용] -->
<c:set var="searchTxt" value="${fn:trim(c.searchTerm)}"/>
<c:if test="${not empty c.cmpsr}"><c:set var="searchTxt"><c:if test="${not empty searchTxt}">${searchTxt}, </c:if>${c.cmpsr}</c:set></c:if>
<c:if test="${not empty c.rcrd_name}"><c:set var="searchTxt"><c:if test="${not empty searchTxt}">${searchTxt}, </c:if>${c.rcrd_name}</c:set></c:if>
<c:if test="${not empty c.cndtr}"><c:set var="searchTxt"><c:if test="${not empty searchTxt}">${searchTxt}, </c:if>${c.cndtr}</c:set></c:if>
<c:if test="${not empty c.prfmr_kor}"><c:set var="searchTxt"><c:if test="${not empty searchTxt}">${searchTxt}, </c:if>${c.prfmr_kor}</c:set></c:if>
<c:if test="${not empty c.vocal}"><c:set var="searchTxt"><c:if test="${not empty searchTxt}">${searchTxt}, </c:if>${c.vocal}</c:set></c:if>
<c:if test="${not empty c.oscal}"><c:set var="searchTxt"><c:if test="${not empty searchTxt}">${searchTxt}, </c:if>${c.oscal}</c:set></c:if>
<c:if test="${not empty c.istmt_kor}"><c:set var="searchTxt"><c:if test="${not empty searchTxt}">${searchTxt}, </c:if>${c.istmt_kor}</c:set></c:if>
<c:if test="${not empty c.label_name}"><c:set var="searchTxt"><c:if test="${not empty searchTxt}">${searchTxt}, </c:if>${c.label_name}</c:set></c:if>
<c:if test="${not empty c.maker_name}"><c:set var="searchTxt"><c:if test="${not empty searchTxt}">${searchTxt}, </c:if>${c.maker_name}</c:set></c:if>
<c:if test="${not empty c.jmcode}"><c:set var="searchTxt"><c:if test="${not empty searchTxt}">${searchTxt}, </c:if>${c.jmcode}</c:set></c:if>
<c:if test="${not empty c.trk_name}"><c:set var="searchTxt"><c:if test="${not empty searchTxt}">${searchTxt}, </c:if>${c.trk_name}</c:set></c:if>
<c:if test="${not empty c.arti_name}"><c:set var="searchTxt"><c:if test="${not empty searchTxt}">${searchTxt}, </c:if>${c.arti_name}</c:set></c:if>
<c:if test="${not empty c.drctr}"><c:set var="searchTxt"><c:if test="${not empty searchTxt}">${searchTxt}, </c:if>${c.drctr}</c:set></c:if>
<c:if test="${not empty c.actor}"><c:set var="searchTxt"><c:if test="${not empty searchTxt}">${searchTxt}, </c:if>${c.actor}</c:set></c:if>
<!-- 검색 키워드[보기용] -->
<title>${searchTxt} - HOTTRACKS</title>
<script type="text/javascript" src="/js/jquery.form.js"></script>
<script type="text/javascript" src="/js/idangerous.swiper.min.js"></script>
<c:set var="_skey_kind">기프트</c:set>
<c:if test="${c.searchMenu eq 'GIFT'}"><c:set var="_skey_kind">기프트</c:set></c:if>
<c:if test="${c.searchMenu eq 'RECORD'}"><c:set var="_skey_kind">음반/영상</c:set></c:if>

<!-- Facebook Pixel Code -->
<script type="text/javascript">
!function(f,b,e,v,n,t,s){if(f.fbq)return;n=f.fbq=function(){n.callMethod?
n.callMethod.apply(n,arguments):n.queue.push(arguments)};if(!f._fbq)f._fbq=n;
n.push=n;n.loaded=!0;n.version='2.0';n.queue=[];t=b.createElement(e);t.async=!0;
t.src=v;s=b.getElementsByTagName(e)[0];s.parentNode.insertBefore(t,s)}(window,
document,'script','//connect.facebook.net/en_US/fbevents.js');

fbq('init', '2595348470556537');
fbq('track', "PageView");</script>
<noscript><img height="1" width="1" style="display:none" src="https://www.facebook.com/tr?id=1053245131399072&ev=PageView&noscript=1"/></noscript>
<!-- End Facebook Pixel Code -->

<!--  레코벨 스크립트 -->
<script type="text/javascript">
  var _recoUserId = getCookie('UserCookieKey');

  window._eglqueue = window._eglqueue || [];
  _eglqueue.push(['setVar','cuid','e15e978e-3623-4892-bf0a-485b9f8196ee']);
  _eglqueue.push(['setVar','userId',SHA256(_recoUserId)]); // optional
  _eglqueue.push(['setVar','searchTerm','${c.searchTerm}']);
  _eglqueue.push(['track','search']);
  (function(s,x){s=document.createElement('script');s.type='text/javascript';
  s.async=true;s.defer=true;s.src=(('https:'==document.location.protocol)?'https':'http')+'://logger.eigene.io/js/logger.min.js';
  x=document.getElementsByTagName('script')[0];x.parentNode.insertBefore(s, x);})();
</script>
<!--  레코벨 스크립트 끝-->


<!-- Loginside eCommerce (Prouct_Search) v3.0 Start -->
<script language='javascript'>
  var _skey_kind = '${_skey_kind}';  // 검색카테고리
  var _skey = '${c.searchTerm}';  // 검색어
  var _skey_result = '${result.totalSize}';   // 검색결과수
</script>
<!-- Loginside eCommerce (Prouct_Search) v3.0 Start -->
<script type="text/javascript">
isLogin = ${isLogin};
var evtSwiper;

jQuery(function($){
    $(document).ready(function(){
        $("html,body").scrollTop($("form[name=searchedForm]").offset().top);
        
        if("${c.searchTerm}" == ""){
            fn_FocusTerm();
        }
        
        if ("${c.searchMenu}" == "GIFT" && ${result.recordSize} > 0 && ${result.giftSize} == 0) {
        	menuChange('RECORD');
        }
    });
    
    // 이벤트스와이프
    evtSwiper = new Swiper('.swiper-container');
    if(evtSwiper && evtSwiper.slides){
        $("#evtPage").html("<strong>" + (evtSwiper.activeIndex + 1) + "/</strong>" + evtSwiper.slides.length);
        evtSwiper.addCallback('SlideChangeEnd', function(swiper){
            $("#evtPage").html("<strong>" + (evtSwiper.activeIndex + 1) + "/</strong>" + evtSwiper.slides.length);
        });
    }
    
    /* 카테고리 클릭시 */
    $(".cond_tab_btn .cate_item .chkbox").click(function(){
        var parntCtgrId = $(this).find("input[type=checkbox]").val();
        var isChecked = $(this).hasClass("active");
        
        if(isChecked)    $(this).removeClass("active");
        else             $(this).addClass("active");
        
        isChecked = isChecked?false:true;
        $(this).find("input[type=checkbox]").attr("checked", isChecked);
        
        $(".tab_pannels .cate_item .chkbox").each(function(){
           if($(this).find("input[name=ctgrIds]").val().indexOf(parntCtgrId) == 0){
               if(isChecked)    $(this).addClass("active");
               else             $(this).removeClass("active");
               $(this).find("input[name=ctgrIds]").attr("checked", isChecked);
           }
        });
        
        $("form[name=searchedForm] input[name=brandGroup]").val("");
        $("form[name=searchedForm] input[name=page]").val("1");
    });
    
    $(".tab_pannels .cate_item .chkbox").click(function(){
        var isChecked = $(this).hasClass("active");
        
        if(isChecked)    $(this).removeClass("active");
        else             $(this).addClass("active");
        isChecked = isChecked?false:true;
        $(this).find("input[type=checkbox]").attr("checked", isChecked);
        
        $("form[name=searchedForm] input[name=brandGroup]").val("");
        $("form[name=searchedForm] input[name=page]").val("1");
        
        chkCateAll();
    });
    
    $(".cond_tab_btn a").click(function(e){
        e.preventDefault();
        
        $(".tab_pannels .cate_item .chkbox.active").removeClass("active");
        $($(this).attr("href")).find(".chkbox").each(function(){
            $(this).addClass("active");
        });
        
        $("form[name=searchedForm] input[name=brandGroup]").val("");
        $("form[name=searchedForm] input[name=page]").val("1");
        
        submitFrm();
    });
    
    $(".tab_pannels cate_area a").click(function(e){
        e.preventDefault();
        
        $(".tab_pannels .cate_item .chkbox.active").removeClass("active");
        $(this).parents(".cate_item").find(".chkbox").addClass("active");
        
        $("form[name=searchedForm] input[name=brandGroup]").val("");
        $("form[name=searchedForm] input[name=page]").val("1");
        
        submitFrm();
    });
    
    $(".cond_cate .tab_spannels a").click(function(event) {
        event.preventDefault();
        var input = $(this).find("input");
        
        $(".chkbox").removeClass("active");
        $("form[name=searchedForm] input[name=page]").val("1");
        $("form[name=searchedForm] input[name=cateChkAll]").attr("checked", false);
        $("form[name=searchedForm] input[name=ctgrIds]").attr("checked", false);
        $("form[name=searchedForm] input[name='ctgr_id_2d']").val("");
        $("form[name=searchedForm] input[name='ctgr_name_2d']").val("");
        $("form[name=searchedForm] input[name='categoryGroup']").val(input.attr("name"));
        if($.trim(input.val()) == ""){
            $("form[name=searchedForm] input[name=categoryBrandCount]").val(0);
        }else{
            $("form[name=searchedForm] input[name=categoryBrandCount]").val(input.val());
        }
        $("form[name=searchedForm] input[name=brandGroup]").val("");
        $("form[name=searchedForm]").submit();
    });
    
    $(".tab_brand_ordr a").click(function(e){
        e.preventDefault();
        if($(this).hasClass("active")){
            
        }else{
            var searchBrandTab = $($(this).attr("href"));
            var brandGroups = $("form[name=searchedForm] input[name=brandGroup]").val().split(",");
            searchBrandTab.find(".brand_item .chkbox").each(function(){
                if($.inArray($(this).find("input[name=brandNames]").val(), brandGroups) >= 0){
                    $(this).addClass("active");
                    $(this).find("input[type=checkbox]").attr("checked", true);
                }else{
                    $(this).removeClass("active");
                    $(this).find("input[type=checkbox]").attr("checked", false);
                }
            });
            
            $($(".tab_brand_ordr a.active").attr("href")).removeClass("active");
            $(".tab_brand_ordr a.active").removeClass("active");
            
            searchBrandTab.addClass("active");
            $(this).addClass("active");
        }
    });
    
    /* 브랜드 클릭시 */
    $(".search_brand_tab02 .brand_item .chkbox").click(function(){
        var isChecked = $(this).hasClass("active");
        var brandNames = new Array();
        
        if(isChecked)$(this).removeClass("active");
        else             $(this).addClass("active");
        isChecked = isChecked?false:true;
        $(this).find("input[type=checkbox]").attr("checked", isChecked);
        
        $(".search_brand_tab02.active .brand_item .chkbox.active").each(function(){
            brandNames.push($(this).find("input[name=brandNames]").val());
        });
        
        $(".cate_item .chkbox.active").removeClass("active");
        
        $("form[name=searchedForm] input[name=ctgr_id_2d]").val("");
        $("form[name=searchedForm] input[name=ctgr_name_2d]").val("");
        $("form[name=searchedForm] input[name=categoryGroup]").val("");
        $("form[name=searchedForm] input[name=brandGroup]").val(brandNames.join(","));
        $("form[name=searchedForm] input[name=page]").val("1");
    });
    
    /* 브랜드 클릭시 */
    $(".search_brand_tab02 .brand_item a").click(function(e){
        e.preventDefault();
        
        var brandName = $(this).attr("href");
        brandName = brandName.substr(1, brandName.length);
        
        $(".cate_item .chkbox.active").removeClass("active");
        
        $("form[name=searchedForm] input[name='categoryGroup']").val("");
        $("form[name=searchedForm] input[name='brandGroup']").val(brandName);
        $("form[name=searchedForm] input[name=page]").val("1");
        
        submitFrm();
    });
    
    /* 검색어 입력시 */
    $("form[name=searchedForm] input[name=searchTerm]").keypress(function(e) {
        if (e.which == 13) {
            $(this).val($.trim($(this).val()));
            $(".s_search").click();
        }
    });
    
    /* 검색버튼 클릭시 */
    $(".s_search").click(function(event){
        event.preventDefault();
        if ($(".flag_item .chkbox.active").length < 1) {
            $("form[name=searchedForm] input.srchFlg").each(function(){$(this).val("");});
        }
        
        $("<input />").attr({"type":"hidden","name":"keywordSubmit","value":"Y"}).appendTo("form[name=searchedForm]");
        
        if ($(".flag_item .chkbox.active").length < 1) {
            $("input[name=ajaxCallYn]").val("N");    // ajax call을 하지 않고 Submit하기
        }
        
        $("form[name=searchedForm] input[name=viewType]").val("");
        $("form[name=searchedForm] input[name=page]").val("1");
        $("form[name=searchedForm]").submit();
    });
    
    
    /* 검색 폼 전송 시 */
    $("form[name=searchedForm]").submit(function() {
        var searchFlag = $("form[name=searchedForm] input[name=searchFlag]").val();
        if($("input[name=prevQuery]").val() == "" && (searchFlag == "R" || searchFlag == "E" )){
            $("input[name=prevQuery]").val("@where { }");
        }
        
        if(searchFlag != "R" && searchFlag != "E")    $("input[name=prevQuery]").val("");
        
        var _str = $("form[name=searchedForm] input[name=searchTerm]").val();
        if (_str.replace(/^\s\s*/, '').replace(/\s\s*$/, '') == "" && $("input[name=detailSearch]").val() != 'Y') {
            alert("검색어를 입력해주세요!");
            return false;
        }
        
        if($("input[name=detailSearch]").val() == 'Y' && $("input[name=keywordSubmit]").val() == 'Y') {
            var tmp = $("form[name=searchedForm]").find("input[name=searchTerm]").val();
            $("form[name=searchedForm]").find("input[name=searchTerm]").val(tmp);
        }
        
        return true;
    });
    
    /* 혜택여부 */
    $(".search_benefit_tab a").click(function(e){
        e.preventDefault();
        name = $(this).attr("href");
        name = name.substring(1, name.length);
        checkbox = $(this).find(".chkbox");
        // alert(name);
        if(checkbox.hasClass("active")){
            checkbox.removeClass("active");
            $("form[name=searchedForm] input[name="+name+"]").val("");
        }else{
            checkbox.addClass("active");
            if(name == "deliveryVendorId"){
                $("form[name=searchedForm] input[name=deliveryVendorId]").val("0625");
            }else{
                $("form[name=searchedForm] input[name="+name+"]").val("Y");
            }
        }
    });
    
    /* 정렬순서 */
    $("#ulSort a").click(function(){
        $("form[name=searchedForm] input[name=sort]").val($(this).attr("id"));
        $("form[name=searchedForm]").submit();
    });
    
    /* 품절포함여부 */
    $("#ulSaleYn").change(function(){
        // 음반/DVD/BLU-RAY 만 가능
        $("form[name=searchedForm] input[name=page]").val("1");
        $("form[name=searchedForm] input[name=saleYn]").val($(this).val());
        $("form[name=searchedForm]").submit();
    });
    
    /* 리스트사이즈 */
    $("#ulListSize").change(function(){
        $("form[name=searchedForm] input[name=page]").val("1");
        $("form[name=searchedForm] input[name=listSize]").val($(this).val());
        $("form[name=searchedForm]").submit();
    });
    
    $(".flag_item .chkbox").click(function() {
        var checkbox = $(this);
        toggleSearchFlag(checkbox);
    });
    
    $(".flag_item a").click(function(e) {
        e.preventDefault();
        var checkbox = $($(this).attr("href"));
        toggleSearchFlag(checkbox);
    });
    
    function toggleSearchFlag(checkbox){
        if (checkbox.hasClass("active")) {
            checkbox.find("input[type=checkbox]").attr("checked", false);
            checkbox.removeClass("active");
            
            $("input[name=searchFlag]").val("");
        }else{
            $(".flag_item .chkbox.active").find("input[type=checkbox]").attr("checked", false);
            $(".flag_item .chkbox.active").removeClass("active");
            
            checkbox.find("input[type=checkbox]").attr("checked", true);
            checkbox.addClass("active");
            
            $("input[name=searchFlag]").val(checkbox.find("input[type=checkbox]").val());
        }
    }
   
    $(".search_link dd .keyword_area a").click(function(){
        initFrm();
        $("form[name=searchedForm] input[name=searchTerm]").val($(this).attr("title"));
        $(".s_search").click();
    });
    
    $("form[name=searchedForm] input[name=searchMenuText]").click(function(){
        if($("form[name=searchedForm] .search_menu").hasClass("active"))    $("form[name=searchedForm] .search_menu").removeClass("active");
        else                                                                $("form[name=searchedForm] .search_menu").addClass("active");
    });
    
    $("form[name=searchedForm] .search_menu a").click(function(){
        var idx = $("form[name=searchedForm] .search_menu a").index($(this));
        switch(idx){
        case 0:menuSubmenSetMain("GIFT");break;       // 기프트
        case 1:menuSubmenSetMain("RECORD");break;   // CD
        }
        $("form[name=searchedForm] input[name=searchMenuText]").val($(this).text());
        $("form[name=searchedForm] .search_menu").removeClass("active");
    });
    
    $("[name=searchedForm]").find("[name=searchTerm]").focus(function(){
        $(".over_txt").hide();
        $(this).select();
    });
    
    $(".s_text,.over_txt").click(function(e){
        e.preventDefault();
        fn_FocusTerm();
    });
    
    // 검색창 아닌 곳에 클릭을 하는 경우
    $("body").click(function(e){
        if($(".over_txt").css("display") == "none"){
            if(!$(".search_box").has(e.target).length){
                $("form[name=searchedForm] input[name=searchTerm]").hide();
                $("#overTxt").text($("form[name=searchedForm] input[name=searchTerm]").val());
                $(".over_txt").show();
            }
        }
    });
    
    var cnt = 0;
    $(document).keydown(function(e){
        if(e.keyCode == 84){
            cnt++;
        }else{
            cnt = 0;
        }
        if(cnt > 5){
            $(".hidden_obj").removeClass("hidden_obj");
        }
    });
});

function swipeEvt(dir){
    if(evtSwiper){
        if(dir == "P"){
            evtSwiper.swipePrev();
        }else if(dir == "N"){
            evtSwiper.swipeNext();
        }
    }
}

function menuChange(menu){
    menuSubmenSetMain(menu);
    
    $(".chkbox").removeClass("active");
    $("form[name=searchedForm] input[name=page]").val("1");
    $("form[name=searchedForm] input[name=cateChkAll]").attr("checked", false);
    $("form[name=searchedForm] input[name=ctgrIds]").attr("checked", false);
    $("form[name=searchedForm] input[name='ctgr_id_2d']").val("");
    $("form[name=searchedForm] input[name='ctgr_name_2d']").val("");
    $("form[name=searchedForm] input[name='categoryGroup']").val("");
    $("form[name=searchedForm] input[name=brandGroup]").val("");
    
    submitFrm();
}

function moreBrand(openYn){
    if(openYn)    $(".cond_brand").addClass("active");
    else          $(".cond_brand").removeClass("active");
}

function chkCateAll(){
    $(".cond_tab_btn .cate_item .chkbox.active").each(function(){
        var parntCtgr = $(this);
        var isChecked = true;
        $(".tab_pannels .cate_item .chkbox").each(function(){
            if($(this).find("input[type=checkbox]").val().indexOf(parntCtgr.find("input[type=checkbox]").val()) == 0 && !$(this).hasClass("active")){
                parntCtgr.find("input[type=checkbox]").attr("checked", false);
                parntCtgr.removeClass("active");
            }
        });
     });
}

/* 페이지 이동 */
function srchPageMove(page){
    $("input[name=page]").val(page);
    $("form[name=searchedForm]").submit();
}

function menuSubmenSetMain(searchMenu) {
    $("form[name=searchedForm] input[name=searchMenu]").val(searchMenu);
    $("form[name=searchedForm] input[name=subMenu]").val("");
}

function submitFrm(){
    var ctgr_id = new Array();
    var ctgr_name = new Array();
    $(".tab_pannels .cate_item .chkbox.active").each(function(){
        ctgr_id.push($(this).find("input[type=checkbox]").val());
        ctgr_name.push($(this).find("input[type=checkbox]").attr("title"));
    });
    
    $("input[name=ctgr_id_2d]").val(ctgr_id.join(","));
    $("input[name=ctgr_name_2d]").val(ctgr_name.join(","));
    
    $("form[name=searchedForm] input[name=minPrice]").val($("#srchMinPrice").val());
    $("form[name=searchedForm] input[name=maxPrice]").val($("#srchMaxPrice").val());
    
    $("form[name=searchedForm]").submit();
}

function initFrm(){
    $(".chkbox").removeClass("active");
    $("form[name=searchedForm] input[name=searchFlag]").val("");
    $("form[name=searchedForm] input[name=cateChkAll]").attr("checked", false);
    
    $("form[name=searchedForm] input[name=ctgrIds]").attr("checked", false);
    $("form[name=searchedForm] input[name=categoryGroup]").val("");
    $("form[name=searchedForm] input[name=ctgr_id]").val("");
    $("form[name=searchedForm] input[name=ctgr_id_2d]").val("");
    $("form[name=searchedForm] input[name=ctgr_name_2d]").val("");
    $("form[name=searchedForm] input[name=categoryGroup]").val("");
    
    $("form[name=searchedForm] input[name=freeDeliveryYn]").val("");
    $("form[name=searchedForm] input[name=deliveryVendorId]").val("");
    $("form[name=searchedForm] input[name=discountYn]").val("");
    $("form[name=searchedForm] input[name=couponYn]").val("");
    $("form[name=searchedForm] input[name=savedYn]").val("");
    
    $(".search_brand_tab02 .brand_item .chkbox").removeClass("active");
    $("[name=brandNames]").attr("checked", false);
    $("form[name=searchedForm] input[name=brandGroup]").val("");
    
    $("form[name=searchedForm] input[name=minPrice]").val("");
    $("form[name=searchedForm] input[name=maxPrice]").val("");
    
    $("form[name=searchedForm]").submit();
}

function setSrchPrice(minPrice, maxPrice){
    $("#srchMinPrice").val(minPrice);
    $("#srchMaxPrice").val(maxPrice);
    
    $(".chk_prices.active").removeClass("active");
    $("#price_"+minPrice+"_"+maxPrice).addClass("active");
}

function fn_FocusTerm(){
    $(".over_txt").hide();
    $("[name=searchedForm]").find("[name=searchTerm]").show().focus();
    $("html,body").scrollTop($("form[name=searchedForm]").offset().top);
}

/* Facebook Pixel Code */
fbq('track', 'Search');
/* End Facebook Pixel Code */

</script>
</head>
<body>
<form name="searchedForm" method="post" action="/ht/search/searchMain">
    <input type="hidden" name="listSize" value="${c.listSize}"/>
    <input type="hidden" name="saleYn" value="${c.saleYn}"/>
    <input type="hidden" name="musicAlbumTrack" value="${c.musicAlbumTrack}"/>
    <input type="hidden" name="searchMenu" value="${c.searchMenu}"/>
    <input type="hidden" name="viewType" value="${c.viewType}"/>
    <input type="hidden" name="subMenu" value="${c.subMenu}"/>
    <input type="hidden" name="sort" value="${c.sort}"/>
    <input type="hidden" name="categoryGroup" value="${c.categoryGroup}" class="srchFlg"/>
    <input type="hidden" name="brandGroup" value="${c.brandGroup}" class="srchFlg"/>
    <input type="hidden" name="searchFlag" value="${c.searchFlag}" class="srchFlg"/>
    <input type="hidden" name="minPrice" value="${c.minPrice}" class="srchFlg"/>
    <input type="hidden" name="maxPrice" value="${c.maxPrice}" class="srchFlg"/>
    <input type="hidden" name="baseMinPrice" value="${c.baseMinPrice}" class="srchFlg"/>
    <input type="hidden" name="baseMaxPrice" value="${c.baseMaxPrice}" class="srchFlg"/>
    <input type="hidden" name="prevQuery" value="${result.marinerCriteria.prevQuery}" class="srchFlg"/>
    <input type="hidden" name="categoryBrandCount" value="${c.categoryBrandCount}"/>
    <input type="hidden" name="cmpsr" value="${c.cmpsr}"/>
    <input type="hidden" name="rcrd_name" value="${c.rcrd_name}"/>
    <input type="hidden" name="cndtr" value="${c.cndtr}"/>
    <input type="hidden" name="prfmr_kor" value="${c.prfmr_kor}"/>
    <input type="hidden" name="vocal" value="${c.vocal}"/>
    <input type="hidden" name="oscal" value="${c.oscal}"/>
    <input type="hidden" name="istmt_kor" value="${c.istmt_kor}"/>
    <input type="hidden" name="label_name" value="${c.label_name}"/>
    <input type="hidden" name="maker_name" value="${c.maker_name}"/>
    <input type="hidden" name="jmcode" value="${c.jmcode}"/>
    <input type="hidden" name="trk_name" value="${c.trk_name}"/>
    <input type="hidden" name="arti_name" value="${c.arti_name}"/>
    <input type="hidden" name="drctr" value="${c.drctr}"/>
    <input type="hidden" name="actor" value="${c.actor}"/>
    <input type="hidden" name="ctgr_id" value="${c.ctgr_id}" class="srchFlg"/>
    <input type="hidden" name="ctgr_name" value="${c.ctgr_name}" class="srchFlg"/>
    <input type="hidden" name="ctgr_id_2d" value="${c.ctgr_id_2d}" class="srchFlg"/>
    <input type="hidden" name="ctgr_name_2d" value="${c.ctgr_name_2d}" class="srchFlg"/>
    <input type="hidden" name="minDay" value="${c.minDay}"/>
    <input type="hidden" name="maxDay" value="${c.maxDay}"/>
    <input type="hidden" name="detailSearch" value="${c.detailSearch}"/>
    <input type="hidden" name="deliveryVendorId" value="${c.deliveryVendorId}"/>
    <input type="hidden" name="couponYn" value="${c.couponYn}"/>
    <input type="hidden" name="freeDeliveryYn" value="${c.freeDeliveryYn}"/>
    <input type="hidden" name="discountYn" value="${c.discountYn}"/>
    <input type="hidden" name="savedYn" value="${c.savedYn}"/>
    <input type="hidden" name="ajaxCallYn" value="Y"/>
    <input type="hidden" name="page" value="1"/>
    
    <div class="search_wrap02">
        <p class="info_result"><span>${searchTxt}</span> 검색결과 <strong class="c_red"><fmt:formatNumber type="number">${result.xmlTotalSize}</fmt:formatNumber></strong>개 상품</p>
        <fieldset>
            <legend>검색</legend>
            <div class="search_box">
                <div class="s_text">
                    <input name="searchMenuText" type="text" readonly="readonly" value="${_skey_kind}" class="search_menu_txt" onfocus="this.blur();return false;"/>
                    <input type="text" class="text search_keyword" name="searchTerm" value="${c.searchTerm}" title="검색어 입력" style="ime-mode:active;"/>
                    <a href="#" class="over_txt" id="overTxt">${searchTxt}</a>
                    <a href="#" class="s_search"><span>검색</span></a>
                </div>
                <div class="search_menu">
                    <ul>
                        <li><a href="javascript://">기프트</a></li>
                        <li><a href="javascript://">음반/영상</a></li>
                    </ul>
                </div>
            </div>
            
            <div class="s_checkbox">
                <p class="flag_item"><em class="chkbox<c:if test="${c.searchFlag eq 'R'}"> active</c:if>" id="searchFlag1"><input type="checkbox" name="searchFlag1" value="R"<c:if test="${c.searchFlag eq 'R'}"> checked="checked"</c:if>></em><a href="#searchFlag1">결과 내 재검색</a></p>
                <p class="flag_item"><em class="chkbox<c:if test="${c.searchFlag eq 'E'}"> active</c:if>" id="searchFlag2"><input type="checkbox" name="searchFlag2" value="E"<c:if test="${c.searchFlag eq 'E'}"> checked="checked"</c:if>></em><a href="#searchFlag2">특정 검색어 제외</a></p>
            </div>
            
            <c:if test="${not empty result.listLinked}">
                <div class="search_link">
                    <dl>
                        <dt>연관검색어</dt>
                        <dd>
                            <div class="keyword_area">
                                <c:forEach var="keyword" items="${result.listLinked}" end="4" varStatus="st">
                                    <a href="javascript://" title="${keyword}">${keyword}</a>
                                </c:forEach>
                            </div>
                        </dd>
                    </dl>
                </div>
            </c:if>
            <p class="btn_more"><a href="/ht/search/searchDetail/Record">CD,DVD 상세검색</a></p>
        </fieldset>
    </div>
    <c:if test="${not empty listEvent || not empty listEventChoice}">
        <div class="s_evt_box">
            <div class="swiper-container">
                <div class="swiper-wrapper">
                    <c:forEach items="${listEvent}" varStatus="s1" step="3">
                        <div class="swiper-slide">
                            <!-- TODO:롤링해야함 -->
                            <c:forEach items="${listEvent}" var="l" varStatus="st" begin="${s1.index}" end="${s1.index + 2}">
                                <a href="/ht/biz/eventDetail?eventId=${l.eventId}">
                                    <c:if test="${not empty listEventChoice}"><em class="pick01">관련이벤트</em></c:if>
                                    <span class="img"><ui:image src="${l.imageUrl}" alt="${fn:escapeXml(l.eventTitle)}" width="290px" height="140px"/></span>
                                    <span class="tit">
                                        <strong>${l.eventTitle}</strong>
                                        <em>${l.eventDtlCont} </em>
                                    </span>
                                </a>
                            </c:forEach>
                            <c:if test="${s1.first && not empty listEventChoice}">
                                <c:forEach items="${listEventChoice}" var="l" varStatus="st">
                                    <a href="/ht/biz/eventDetail?eventId=${l.eventId}">
                                        <em class="pick02">인기이벤트</em>
                                        <span class="img"><ui:image src="${l.imageUrl}" alt="${fn:escapeXml(l.eventTitle)}" width="290px" height="140px"/></span>
                                        <span class="tit">
                                            <strong>${l.eventTitle}</strong>
                                            <em>${l.eventDtlCont} </em>
                                        </span>
                                    </a>
                                </c:forEach>
                            </c:if>
                        </div>
                    </c:forEach>
                    <c:if test="${empty listEvent}">
                        <div class="swiper-slide">
                            <c:forEach items="${listEventChoice}" var="l" varStatus="st">
                                <a href="/ht/biz/eventDetail?eventId=${l.eventId}">
                                    <em class="pick02">인기이벤트</em>
                                    <span class="img"><ui:image src="${l.imageUrl}" alt="${fn:escapeXml(l.eventTitle)}" width="290px" height="140px"/></span>
                                    <span class="tit">
                                        <strong>${l.eventTitle}</strong>
                                        <em>${l.eventDtlCont} </em>
                                    </span>
                                </a>
                            </c:forEach>
                        </div>
                    </c:if>
                </div>
                <c:if test="${fn:length(listEvent) > 3}">
                    <div class="s_controll">
                        <div id="evtPage" class="swiper-pagination"></div>
                        <a href="#" onclick="swipeEvt('P');return false;" class="swiper-button-prev">PREV</a>
                        <a href="#" onclick="swipeEvt('N');return false;" class="swiper-button-next">NEXT</a>
                    </div>
                </c:if>
            </div>
        </div>
    </c:if>

    <!-- 레코벨 추천 리스트 -->
	<c:if test="${not empty listRecobell}">
		<div class="recobell tab_wrap">
		    <h1 class="ltit fs18">검색 연관상품</h1>
		    <div class="tab_pannels">
		        <c:forEach items="${listRecobell}" varStatus="s1" step="5" end="14">
		            <ul id="recobell0${s1.count}" class="pannel">
		                <c:forEach items="${listRecobell}" var="l" varStatus="st" begin="${s1.index}" end="${s1.index+4}">
		                    <li>
		                        <span class="img">
		                            <c:if test="${l.sellPrdtGbn eq 'R' || l.sellPrdtGbn eq 'D'}"><a href="/ht/record/detail/${l.sellPrdtBcode}?foo=bar&rccode=pc_search1"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" ratingCode="A" rcrdImgType="large" width="${l.sellPrdtGbn eq 'R'?'150':'99'}" clazz="photo" alt="${fn:escapeXml(l.prdtName)}"/></a></c:if>
		                            <c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G' || l.sellPrdtGbn eq 'S'}"><a href="/ht/product/detail?barcode=${l.sellPrdtBcode}&foo=bar&rccode=pc_search1"><ui:image src="${l.prdtImgUrl}" src2="${l.productImageUrl2}" size="150" server="product" clazz="photo" alt="${fn:escapeXml(l.prdtName)}"/></a></c:if>
		                        </span>
		                        <c:if test="${l.sellPrdtGbn eq 'R' || l.sellPrdtGbn eq 'D'}"><a href="/ht/record/detail/${l.sellPrdtBcode}?foo=bar&rccode=pc_search1"></c:if>
		                        <c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G' || l.sellPrdtGbn eq 'S'}"><a href="/ht/product/detail?barcode=${l.sellPrdtBcode}&foo=bar&rccode=pc_search1"></c:if>
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
    
    <div class="s_cond01">
        <div class="tab_btn_box">
            <a href="#" onclick="menuChange('GIFT');return false;" class="tab_gift<c:if test="${c.searchMenu eq 'GIFT'}"> active</c:if>"><strong>기프트</strong> (<fmt:formatNumber pattern=",###">${result.giftSize}</fmt:formatNumber>)</a>
            <a href="#" onclick="menuChange('RECORD');return false;" class="tab_record<c:if test="${c.searchMenu eq 'RECORD'}"> active</c:if>"><strong>음반/DVD/블루레이</strong> (<fmt:formatNumber pattern=",###">${result.recordSize}</fmt:formatNumber>)</a>
        </div>
        <c:if test="${not empty result.listCategory}">
            <div class="cond_cate">
                <h2 class="s_tit">카테고리</h2>
                <c:forEach items="${result.listCategory}" varStatus="s1" step="4">
                    <ul class="cond_tab_btn" id="cate${s1.count}deptList">
                        <c:forEach items="${result.listCategory}" var="l1" varStatus="st1" begin="${s1.index}" end="${s1.index+3}">
                            <li<c:if test="${l1.openChild}"> class="contain"</c:if> title="${l1.ctgrName}"><p class="cate_item"><em class="chkbox<c:if test="${l1.checked}"> active</c:if>"><input type="checkbox" name="cateChkAll" value="${l1.ctgrId}" <c:if test="${l1.checked}"> checked="checked"</c:if>></em><a value="${l1.ctgrIdNm}" href="#sc<ui:lpad length="2" padChar="0">${st1.index+1}</ui:lpad>"<c:if test="${l1.checked || l1.openChild}"> class="on"</c:if>>${l1.ctgrName}<span> (<fmt:formatNumber type="number">${l1.prdtCnt}</fmt:formatNumber>)</span></a></p></li>
                        </c:forEach>
                    </ul>
                    <c:forEach items="${result.listCategory}" var="l1" varStatus="st1" begin="${s1.index}" end="${s1.index+3}">
                        <div id="sc<ui:lpad length="2" padChar="0">${st1.index+1}</ui:lpad>" class="tab_pannels pannel_box${st1.count} cate_area"<c:if test="${l1.openChild}"> style="display:block;"</c:if>>
                            <!-- 하위카테고리 -->
                            <c:forEach items="${l1.listChild}" varStatus="s2" step="4">
                                <ul>
                                    <c:forEach items="${l1.listChild}" var="l2" varStatus="st" begin="${s2.index}" end="${s2.index+3}">
                                        <li><p class="cate_item" title="${l2.ctgrName}"><em class="chkbox<c:if test="${l2.checked}"> active</c:if>"><input type="checkbox" name="ctgrIds" value="${l2.ctgrId}" <c:if test="${l2.checked}"> checked="checked"</c:if>></em><a href="#${l2.ctgrId}"<c:if test="${l2.checked || l2.openChild}"> class="on"</c:if>><ui:cut isStripHtml="true" limit="9" tail="..">${l2.ctgrName}</ui:cut> <span>(<fmt:formatNumber type="number">${l2.prdtCnt}</fmt:formatNumber>)</span></a></p></li>
                                    </c:forEach>
                                </ul>
                                <c:forEach items="${l1.listChild}" var="l2" varStatus="st" begin="${s2.index}" end="${s2.index+3}">
                                    <div class="tab_spannels pannel_box${st.count}" id="${l2.ctgrId}"<c:if test="${l2.openChild}"> style="display:block;"</c:if>>
                                        <c:forEach items="${l2.listChild}" varStatus="s2" step="4">
                                            <ul>
                                                <c:forEach items="${l2.listChild}" var="l3" begin="${s2.index}" end="${s2.index+3}">
                                                    <li title="${l3.ctgrName}"><a href="#"<c:if test="${l3.checked}"> class="on"</c:if>><input type="hidden" name="${l3.ctgrIdNm}" value="${l3.prdtCnt}"/><ui:cut isStripHtml="true" limit="12" tail="..">${l3.ctgrName}</ui:cut> <span>(<fmt:formatNumber type="number">${l3.prdtCnt}</fmt:formatNumber>)</span></a></li>
                                                </c:forEach>
                                            </ul>
                                        </c:forEach>
                                    </div>
                                </c:forEach>
                            </c:forEach>
                        </div>
                    </c:forEach>
                </c:forEach>
            </div>
        </c:if>
        <c:if test="${not empty result.listBrandByCnt && c.searchMenu eq 'GIFT'}">
            <div class="cond_brand">
                <h2 class="s_tit">브랜드</h2>
                <ul class="tab_brand_ordr">
                    <li><a href="#brandOrdrCnt" class="active">상품순 &gt;</a></li>
                    <li><a href="#brandOrdrName">가나다순  &gt;</a></li>
                </ul>
                <div class="search_brand_tab02 active" id="brandOrdrCnt">
                    <c:forEach items="${result.listBrandByCnt}" varStatus="s0" step="4">
                        <ul>
                            <c:forEach items="${result.listBrandByCnt}" var="l" varStatus="st" begin="${s0.index}" end="${s0.index+3}">
                                <li><p class="brand_item"><em class="chkbox<c:if test="${l.checked}"> active</c:if>"><input type="checkbox" name="brandNames" value="${l.brandName}" title="${l.brandName}"<c:if test="${l.checked}"> checked="checked"</c:if>></em><a href="#${l.brandName}"><ui:cut isStripHtml="true" limit="10" tail="..">${l.brandName}</ui:cut> (<fmt:formatNumber type="number">${l.prdtCnt}</fmt:formatNumber>)</a></p></li>
                            </c:forEach>
                        </ul>
                    </c:forEach>
                </div>
                <div class="search_brand_tab02" id="brandOrdrName">
                    <c:forEach items="${result.listBrandByName}" varStatus="s0" step="4">
                        <ul>
                            <c:forEach items="${result.listBrandByName}" var="l" varStatus="st" begin="${s0.index}" end="${s0.index+3}">
                                <li><p class="brand_item"><em class="chkbox<c:if test="${l.checked}"> active</c:if>"><input type="checkbox" name="brandNames" value="${l.brandName}" title="${l.brandName}"<c:if test="${l.checked}"> checked="checked"</c:if>></em><a href="#${l.brandName}"><ui:cut isStripHtml="true" limit="10" tail="..">${l.brandName}</ui:cut> (<fmt:formatNumber type="number">${l.prdtCnt}</fmt:formatNumber>)</a></p></li>
                            </c:forEach>
                        </ul>
                    </c:forEach>
                </div>
                <c:choose>
                    <c:when test="${fn:length(result.listBrandByCnt) > 4}">
                        <a href="#" onclick="moreBrand(true);return false;" class="btn_more type01">+</a>
                        <a href="#" onclick="moreBrand(false);return false;" class="btn_more type02">-</a>
                    </c:when>
                    <c:otherwise>
                        <a href="#" onclick="return false;" class="btn_more type03">+</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </c:if>
        <div class="search_optn_area area_sp">
            <h2 class="s_tit">가&nbsp;&nbsp;&nbsp;격</h2>
            <div class="search_optn_tab">
                <c:if test="${not empty priceRange}">
                    <ul>
                        <c:forEach items="${priceRange}" var="l">
                            <li><p class="optn_item"><em class="chkbox rdobox chk_prices<c:if test="${l.MIN eq c.minPrice && l.MAX eq c.maxPrice}"> active</c:if>" id="price_${l.MIN}_${l.MAX}" onclick="setSrchPrice('${l.MIN}', '${l.MAX}');return false;"><input type="checkbox"/></em><a href="#" onclick="setSrchPrice('${l.MIN}', '${l.MAX}');return false;">${l.TXT}</a></p></li>
                        </c:forEach>
                    </ul>
                </c:if>
                <div class="search_price_box">
                    <span>직접입력</span>
                    <input type="text" name="minPrice" id="srchMinPrice" value="${c.minPrice}" size="10">원
                    ~
                    <input type="text" name="maxPrice" id="srchMaxPrice" value="${c.maxPrice}" size="10"/>원
                </div>
            </div>
        </div>
        <div class="search_optn_area">
            <h2 class="s_tit">혜&nbsp;&nbsp;&nbsp;택</h2>
            <div class="search_optn_tab search_benefit_tab">
                <ul>
                    <li><p class="optn_item"><a href="#freeDeliveryYn"><em class="chkbox<c:if test="${c.freeDeliveryYn eq 'Y'}"> active</c:if>"><input type="checkbox"/></em><input type="checkbox"/></em>무료배송</a></p></li>
                    <li><p class="optn_item"><a href="#deliveryVendorId" class="expt"><em class="chkbox<c:if test="${c.deliveryVendorId eq '0625'}"> active</c:if>"><input type="checkbox"/></em><input type="checkbox"/></em>핫트랙스배송</a></p></li>
                    <li><p class="optn_item"><a href="#discountYn" class="expt"><em class="chkbox<c:if test="${c.discountYn eq 'Y'}"> active</c:if>"><input type="checkbox"/></em><input type="checkbox"/></em>할인</a></p></li>
                    <li><p class="optn_item"><a href="#couponYn" class="expt"><em class="chkbox<c:if test="${c.couponYn eq 'Y'}"> active</c:if>"><input type="checkbox"/></em><input type="checkbox"/></em>쿠폰</a></p></li>
                    <li><p class="optn_item"><a href="#savedYn" class="expt"><em class="chkbox<c:if test="${c.savedYn eq 'Y'}"> active</c:if>"><input type="checkbox"/></em><input type="checkbox"/></em>적립</a></p></li>
                </ul>
            </div>
        </div>
    </div>
    <div class="search_btn_box">
        <a href="#" onclick="initFrm();return false;" class="btn btn_reset">선택초기화</a>
        <a href="#" onclick="submitFrm();return false;" class="btn btn_search">선택조건 검색</a>
    </div>
    <div class="search_sort_tab03">
        <a href="#" onclick="return false;" class="on" id="totalCnt02"><strong>ALL</strong> (<fmt:formatNumber pattern=",###">${result.totalSize}</fmt:formatNumber>)</a>
    </div>
    <div class="search_sort_tab04">
        <div id="ulSort" class="f_left">
            <a href="javascript://" id="ODC"<c:if test="${c.sort eq 'ODC'}"> class="active"</c:if>>인기순</a>
            <a href="javascript://" id="DAT"<c:if test="${c.sort eq 'DAT'}"> class="active"</c:if>>신상품순</a>
            <a href="javascript://" id="LOP"<c:if test="${c.sort eq 'LOP'}"> class="active"</c:if>>낮은가격순</a>
            <a href="javascript://" id="HIP"<c:if test="${c.sort eq 'HIP'}"> class="active"</c:if>>높은가격순</a>
            <a href="javascript://" id="DCR"<c:if test="${c.sort eq 'DCR'}"> class="active"</c:if>>높은할인율순</a>
            <a href="javascript://" id="LIK"<c:if test="${c.sort eq 'LIK'}"> class="active"</c:if>>좋아요♥</a>
            <a href="javascript://" id="RVW"<c:if test="${c.sort eq 'RVW'}"> class="active"</c:if>>상품평</a>
        </div>
        <div class="btn_l">
            <select class="select" id="ulSaleYn" style="margin-left:3px;">
                <option value="N"<c:if test="${c.saleYn eq 'N' || empty c.saleYn}"> selected="selected"</c:if>>품절포함</option>
                <option value="Y"<c:if test="${c.saleYn eq 'Y'}"> selected="selected"</c:if>>품절제외</option>
            </select>
            <select class="select" id="ulListSize" style="margin-left:3px;">
                <option value="40"<c:if test="${c.listSize eq '40'}"> selected="selected"</c:if>>40개</option>
                <option value="80"<c:if test="${c.listSize eq '80'}"> selected="selected"</c:if>>80개</option>
                <option value="120"<c:if test="${c.listSize eq '120'}"> selected="selected"</c:if>>120개</option>
            </select>
        </div>
    </div>
    
    <div id="searchProduct" class="mgt30">
        <c:if test="${empty result.listProduct}">
            <c:choose>
                <c:when test="${c.searchMenu eq 'GIFT' && result.recordSize > 0}"><p style="text-align:center;"><img src="${imageServer}/images/search/img_result_onlymusic01.jpg" alt="해당 검색어는 기프트 상품에는 없으나 음반 상품으로는 있습니다."/></p></c:when>
                <c:when test="${c.searchMenu eq 'RECORD' && result.giftSize > 0}"><p style="text-align:center;"><img src="${imageServer}/images/search/img_result_onlygift01.jpg" alt="해당 검색어는 음반 상품에는 없으나 기프트 상품으로는 있습니다."/></p></c:when>
                <c:when test="${result.saleTotalSize > 0}"><p style="text-align:center;"><img src="${imageServer}/images/search/img_result_onlysoldout01.jpg" alt="검색 결과에는 없지만 품절 상품에는 포함되어 있습니다."/></p></c:when>
                <c:otherwise><p style="text-align:center;"><img src="${imageServer}/images/search/img_no_result01.png" alt="죄송합니다. 고객님께서 찾으시는 상품이 없습니다.ㅠㅠ"/></p></c:otherwise>
            </c:choose>
        </c:if>
        <c:if test="${not empty result.listProduct}">
            <div class="prod_list_normal">
                <c:forEach items="${result.listProduct}" varStatus="s1" step="4">
                    <ul><!-- 1 -->
                        <c:forEach items="${result.listProduct}" var="l" varStatus="st" begin="${s1.index}" end="${s1.index+3}">
                            <li>
                                <c:choose>
                                    <c:when test="${fn:startsWith(l.ctgrId, '0000')}">
                                        <!-- 기프트 -->
                                        <span class="img">
                                            <a href="/ht/product/detail?barcode=${l.sellPrdtBcode}"><ui:image src="${l.prdtImgUrl}" server="product" size="200" alt="${fn:escapeXml(l.prdtName)}"/></a>
                                            <div class="hide_util">
                                                <a href="javascript://" onclick="productPreview('${l.sellPrdtBcode}')" class="zoom"><span>확대</span></a>
                                                <a href="/ht/product/detail?barcode=${l.sellPrdtBcode}" target="_blank" class="nblank"><span>새창</span></a>
                                                <a href="#" onclick="addWishProduct('${l.sellPrdtBcode}');return false;" class="zzim"><span>좋아요</span></a>
                                            </div>
                                        </span>
                                        <a href="/ht/hot/brandDetail?brandId=${l.brandId}"><span class="make">${l.brandName}</span></a>
                                        <a href="/ht/product/detail?barcode=${l.sellPrdtBcode}">
                                            <span class="name">${l.prdtName}</span>
                                            <span class="icon">
                                                <c:set var="reviewCount" value="${l.reviewCount}"/>
                                                <c:set var="wishCount" value="${l.wishCount}"/>
                                                <c:if test="${l.reviewCount > 99}"><c:set var="reviewCount" value="99+"/></c:if>
                                                <c:if test="${l.wishCount > 99}"><c:set var="wishCount" value="99+"/></c:if>
                                                <c:if test="${l.freeDlvyYn eq 'Y'}"><em class="ico_free">무료배송</em></c:if>
                                                <c:if test="${l.cpnYn eq 'Y'}"><em class="ico_coupon">쿠폰</em></c:if>
                                                <c:if test="${l.freeGiftYn eq 'Y'}"><em class="ico_gift">GIFT</em></c:if>
                                                <c:if test="${l.wishCount > 0}"><em class="ico_like">${wishCount}</em></c:if>
                                                <c:if test="${l.reviewCount > 0}"><em class="ico_review">${reviewCount}</em></c:if>
                                            </span>
                                            <em class="price">
                                                <fmt:parseNumber var="prdtSellPrice" value="${l.prdtSellPrice}"/>
                                                <fmt:parseNumber var="prdtDscntPrice" value="${l.prdtDscntPrice}"/>
                                                <c:if test="${prdtSellPrice > prdtDscntPrice}"><span class="dc"><fmt:formatNumber value="${prdtSellPrice}" pattern="#,###"/></span></c:if>
                                                <span class="sale"><fmt:formatNumber value="${prdtDscntPrice}" pattern="#,###"/></span>
                                                <c:if test="${l.saleYn ne 'Y'}"><span class="pc"><img src="${imageServer}/images/renewal/common/ic_status_soldout.gif" alt="품절"/></span></c:if>
                                                <c:if test="${l.saleYn eq 'Y' && prdtSellPrice > prdtDscntPrice}"><span class="pc">${hfn:rate(prdtSellPrice, prdtDscntPrice)}%</span></c:if>
                                            </em>
                                        </a>
                                        <!-- //기프트 -->
                                    </c:when>
                                    <c:otherwise>
                                        <!-- CD/DVD -->
                                        <span class="img">
                                            <c:choose>
                                                <c:when test="${fn:startsWith(l.ctgrId, '0004')}"><a href="/ht/record/detail/${l.sellPrdtBcode}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="D" ratingCode="${l.rtngCode }" width="132" height="200" alt="${fn:escapeXml(l.ctgrName)}" /></a></c:when>
                                                <c:otherwise><a href="/ht/record/detail/${l.sellPrdtBcode}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="R" ratingCode="${l.rtngCode }" width="200" height="200" alt="${fn:escapeXml(l.ctgrName)}" /></a></c:otherwise>
                                            </c:choose>
                                            <div class="hide_util">
                                                <a href="/ht/record/detail/${l.sellPrdtBcode}" target="_blank" class="nblank"><span>새창</span></a>
                                                <a href="#" onclick="addWishProduct('${l.sellPrdtBcode}');return false;" class="zzim"><span>좋아요</span></a>
                                            </div>
                                        </span>
                                        <a href="/ht/record/detail/${l.sellPrdtBcode}">
                                            <span class="make">${l.artiName}</span>
                                            <span class="name">${l.prdtName}</span>
                                            <span class="icon">
                                                <c:set var="reviewCount" value="${l.reviewCount}"/>
                                                <c:set var="wishCount" value="${l.wishCount}"/>
                                                <c:if test="${l.reviewCount > 99}"><c:set var="reviewCount" value="99+"/></c:if>
                                                <c:if test="${l.wishCount > 99}"><c:set var="wishCount" value="99+"/></c:if>
                                                <c:if test="${l.freeDlvyYn eq 'Y'}"><em class="ico_free">무료배송</em></c:if>
                                                <c:if test="${l.cpnYn eq 'Y'}"><em class="ico_coupon">쿠폰</em></c:if>
                                                <c:if test="${l.wishCount > 0}"><em class="ico_like">${wishCount}</em></c:if>
                                                <c:if test="${l.reviewCount > 0}"><em class="ico_review">${reviewCount}</em></c:if>
                                            </span>
                                            <em class="price">
                                                <fmt:parseNumber var="prdtSellPrice" value="${l.prdtSellPrice}"/>
                                                <fmt:parseNumber var="prdtDscntPrice" value="${l.prdtDscntPrice}"/>
                                                <c:if test="${prdtSellPrice > prdtDscntPrice}"><span class="dc"><fmt:formatNumber value="${prdtSellPrice}" pattern="#,###"/></span></c:if>
                                                <span class="sale"><fmt:formatNumber value="${prdtDscntPrice}" pattern="#,###"/></span>
                                                <c:if test="${l.saleYn ne 'Y'}"><span class="pc"><img src="${imageServer}/images/renewal/common/ic_status_soldout.gif" alt="품절"/></span></c:if>
                                                <c:if test="${l.saleYn eq 'Y' && prdtSellPrice > prdtDscntPrice}"><span class="pc">${hfn:rate(prdtSellPrice, prdtDscntPrice)}%</span></c:if>
                                            </em>
                                        </a>
                                       <!-- //CD/DVD -->
                                    </c:otherwise>
                                </c:choose>
                                <span class="hidden_obj">
                                카테고리 : ${l.ctgrName}<br/>
                                매입처명 : ${l.vndrCntrtName}<br/>
                                주문건수 : <fmt:formatNumber type="number">${l.orderCount}</fmt:formatNumber><br/>
                                판매수량 : <fmt:formatNumber type="number">${l.orderPrdtCount}</fmt:formatNumber><br/>
                                후기개수 : <fmt:formatNumber type="number">${l.reviewCount}</fmt:formatNumber><br/>
                                클릭수 : <fmt:formatNumber type="number">${l.clickCount}</fmt:formatNumber><br/>
                                상품코드 : ${l.sellPrdtBcode}<br/>
                                키워드 : ${l.prdtSrchWord}
                                </span>
                            </li>
                        </c:forEach>
                    </ul>
                </c:forEach>
            </div>
            <div class="paging"><ui:paginationScript name="pageHolder" scriptName="srchPageMove"/></div><!-- end pager -->
        </c:if>
    </div>
</form>
</body>
</html>
