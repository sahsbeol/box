<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
<title>${c.searchTerm} - HOTTRACKS</title>
<script type="text/javascript" src="/js/jquery.form.js"></script>
<script language="javascript" src="http://image.kyobobook.co.kr/ink/js/acecounter_V70_function.js"></script>
<c:set var="_skey_kind">통합검색</c:set>
<c:if test="${c.menuGroup eq 'TOTAL'}"><c:set var="_skey_kind">통합검색</c:set></c:if>
<c:if test="${c.menuGroup eq 'GIFT'}"><c:set var="_skey_kind">디자인</c:set></c:if>
<c:if test="${c.menuGroup eq 'RECORD'}"><c:set var="_skey_kind">CD</c:set></c:if>
<c:if test="${c.menuGroup eq 'R_CLASSIC'}"><c:set var="_skey_kind">CD</c:set></c:if>
<c:if test="${c.menuGroup eq 'BLURAY'}"><c:set var="_skey_kind">BLU-RAY</c:set></c:if>
<c:if test="${c.menuGroup eq 'DVD'}"><c:set var="_skey_kind">DVD</c:set></c:if>

<!-- Facebook Pixel Code -->
<script>
!function(f,b,e,v,n,t,s){if(f.fbq)return;n=f.fbq=function(){n.callMethod?
n.callMethod.apply(n,arguments):n.queue.push(arguments)};if(!f._fbq)f._fbq=n;
n.push=n;n.loaded=!0;n.version='2.0';n.queue=[];t=b.createElement(e);t.async=!0;
t.src=v;s=b.getElementsByTagName(e)[0];s.parentNode.insertBefore(t,s)}(window,
document,'script','//connect.facebook.net/en_US/fbevents.js');

fbq('init', '2595348470556537');
fbq('track', "PageView");</script>
<noscript><img height="1" width="1" style="display:none"
src="https://www.facebook.com/tr?id=1053245131399072&ev=PageView&noscript=1"
/></noscript>
<!-- End Facebook Pixel Code -->

<!-- Loginside eCommerce (Prouct_Search) v3.0 Start -->
<script language='javascript'>
  var _skey_kind = '${_skey_kind}';  // 검색카테고리
  var _skey = '${c.searchTerm}';  // 검색어
  var _skey_result = '${result.totalSize}';   // 검색결과수
</script>
<!-- Loginside eCommerce (Prouct_Search) v3.0 Start -->
<script type="text/javascript">
isLogin = ${isLogin};
var condList = new Array();

jQuery(function($){
    $(document).ready(function(){
        $("html,body").scrollTop($("form[name=searchedForm]").offset().top-30);
        loadCondition();
    });
    /*
    $(".search_cate_tab ul li a").each(function(){
        var cnt = $($(this).attr("href")).find("li").length;
        $(this).find("span").html("("+cnt+")");
    });
    */
    $(".search_brand_area .more").click(function(event){
        event.preventDefault();
        if($(this).hasClass("on")){
            $(this).removeClass("on");
            $(".search_brand_tab").find("ul.hidden").each(function(){
                $(this).hide();
            });
        }else{
            $(this).addClass("on");
            $(".search_brand_tab").find("ul.hidden").each(function(){
                $(this).show();
            });
        }
    });
    
    /* 카테고리 클릭시 */
    $(".search_tab_btn .cate_item .chkbox").click(function(){
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
        
        $("form[name=searchedForm] input[name='menuGroup']").val("TOTAL");
        $("form[name=searchedForm] input[name='categoryGroup']").val("");
        $("form[name=searchedForm] input[name='brandGroup']").val("");
        $("form[name=searchedForm] input[name=page]").val("1");
        submitFrm();
    });
    
    $(".tab_pannels .cate_item .chkbox").click(function(){
        var isChecked = $(this).hasClass("active");
        
        if(isChecked)    $(this).removeClass("active");
        else             $(this).addClass("active");
        isChecked = isChecked?false:true;
        $(this).find("input[type=checkbox]").attr("checked", isChecked);
        
        $("form[name=searchedForm] input[name='menuGroup']").val("TOTAL");
        $("form[name=searchedForm] input[name='categoryGroup']").val("");
        $("form[name=searchedForm] input[name='brandGroup']").val("");
        $("form[name=searchedForm] input[name=page]").val("1");
        submitFrm();
        
        chkCateAll();
        loadCondition();
    });
    
    $(".search_tab_btn a").click(function(e){
        e.preventDefault();
        
        if($(this).parents("li").hasClass("on")){
            $($(this).attr("href")).hide();
            $(this).parents("li").removeClass("on");
        }else{
            var onItem = $(".search_cate_tab .search_tab_btn li.on");
            $(onItem.find("a").attr("href")).hide();
            onItem.removeClass("on");
            
            $($(this).attr("href")).show();
            $(this).parents("li").addClass("on");
        }
    });
    
    $(".tab_pannels a").click(function(e){
        e.preventDefault();
        if($(this).parents("li").hasClass("on")){
            $($(this).attr("href")).hide();
            $(this).parents("li").removeClass("on");
        }else{
            var onItem = $(".tab_pannels li.on");
            $(onItem.find("a").attr("href")).hide();
            onItem.removeClass("on");
            
            $($(this).attr("href")).show();
            $(this).parents("li").addClass("on");
        }
    });
    
    $(".search_cate_tab .tab_spannels a").click(function(event) {
        event.preventDefault();
        var input = $(this).find("input");
        console.log(input.attr("name"));
        if(input.attr("name").indexOf("0000") == 0)           $("form[name=searchedForm] input[name='menuGroup']").val("GIFT");
        else if(input.attr("name").indexOf("0003") == 0)      $("form[name=searchedForm] input[name='menuGroup']").val("RECORD");
        else if(input.attr("name").indexOf("000400") == 0)    $("form[name=searchedForm] input[name='menuGroup']").val("BLURAY");
        else if(input.attr("name").indexOf("000401") == 0)    $("form[name=searchedForm] input[name='menuGroup']").val("DVD");
        
        $(".chkbox").removeClass("active");
        $("form[name=searchedForm] input[name=page]").val("1");
        $("form[name=searchedForm] input[name=cateChkAll]").attr("checked", false);
        $("form[name=searchedForm] input[name=ctgrIds]").attr("checked", false);
        $("form[name=searchedForm] input[name='ctgr_id_2d']").val("");
        $("form[name=searchedForm] input[name='ctgr_name_2d']").val("");
        $("form[name=searchedForm] input[name='categoryGroup']").val(input.attr("name"));
        if($.trim(input.val()) == ""){
            $("form[name=searchedForm] input[name='categoryBrandCount']").val(0);
        }else{
            $("form[name=searchedForm] input[name='categoryBrandCount']").val(input.val());
        }
        $("form[name=searchedForm] input[name='brandGroup']").val("");
        $("form[name=searchedForm]").submit();
        loadCondition();
    });
    
    /* 브랜드 클릭시 */
    $(".search_brand_tab a").click(function(event) {
        event.preventDefault();
        var input = $(this).find("input");
        $(".chkbox").removeClass("active");
        $("form[name=searchedForm] input[name=page]").val("1");
        $("form[name=searchedForm] input[name='brandGroup']").val(input.attr("name"));
        $("form[name=searchedForm] input[name='menuGroup']").val("TOTAL");
        $("form[name=searchedForm] input[name=cateChkAll]").attr("checked", false);
        $("form[name=searchedForm] input[name=ctgrIds]").attr("checked", false);
        $("form[name=searchedForm] input[name='categoryGroup']").val("");
        $("form[name=searchedForm] input[name='ctgr_id']").val("");
        $("form[name=searchedForm] input[name='ctgr_id_2d']").val("");
        $("form[name=searchedForm] input[name='ctgr_name_2d']").val("");
        $("form[name=searchedForm] input[name='categoryBrandCount']").val(input.val());
        $("form[name=searchedForm]").submit();
        loadCondition();
        $(".search_brand_area .more").click();
    });
    
    /* 검색어 입력시 */
    $("form[name=searchedForm] input[name=searchTerm]").keypress(function(e) {
        if (e.which == 13) {
            $(this).val($.trim($(this).val()));
            $(".s_search").click();
        }
    });
    
    /* 검색어 입력시 */
    $("form[name=searchedForm] input[name=searchTerm]").focusin(function(e) {
        $(this).select();
    });
    
    /* 검색버튼 클릭시 */
    $(".s_search").click(function(event){
        event.preventDefault();
        if (!$("form[name=searchedForm] input[name=searchFlag1]").is(":checked")
                && !$("form[name=searchedForm] input[name=searchFlag2]").is(":checked")) {
            $("form[name=searchedForm] input.srchFlg").each(function(){$(this).val("");});
        }
        $("<input />").attr({"type":"hidden","name":"keywordSubmit","value":"Y"}).appendTo("form[name=searchedForm]");
        
        if (!$("input[name=searchFlag1]").is(":checked") && !$("input[name=searchFlag2]").is(":checked", false)){
            $("input[name=ajaxCallYn]").val("N");    // ajax call을 하지 않고 Submit하기
        }
        
        $("form[name=searchedForm] input[name=page]").val("1");
        $("form[name=searchedForm]").submit();
    });
    
    
    /* 검색 폼 전송 시 */
    $("form[name=searchedForm]").submit(function() {
        var searchFlag = $("form[name=searchedForm] input[name=searchFlag]");
        if ($("form[name=searchedForm] input[name=searchFlag1]").is(":checked"))         searchFlag.val("R");
        else if ($("form[name=searchedForm] input[name=searchFlag2]").is(":checked"))    searchFlag.val("E");
        
        if($("input[name=prevQuery]").val() == "" && (searchFlag.val() == "R" || searchFlag.val() == "E" )){
            $("input[name=prevQuery]").val("@where { }");
        }
        
        if(searchFlag.val() != "R" && searchFlag.val() != "E")    $("input[name=prevQuery]").val("");
        
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
    
    /* 할인여부 */
    $("#ulCouponYn").change(function(){
        $("form[name=searchedForm] input[name=page]").val("1");
        $("form[name=searchedForm] input[name=couponYn]").val($(this).val());
        $("form[name=searchedForm]").submit();
    });
    
    /* 정렬순서 */
    $("#ulSort li a").click(function(){
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
    
    /* 핫트랙스배송여부 */
    $("#chkHttsDLvy").change(function(){
        $("form[name=searchedForm] input[name=page]").val("1");
        if($(this).is(":checked")){
            $("form[name=searchedForm] input[name=deliveryVendorId]").val("0625");
        }else{
            $("form[name=searchedForm] input[name=deliveryVendorId]").val("");
        }
        $("form[name=searchedForm]").submit();
    });
    
    /* 리스트유형 */
    $("#ulListType li a").click(function(){
        $("#ulListType li a.on").removeClass("on");
        $(this).addClass("on");
        
        $("form[name=searchedForm] input[name=viewType]").val($(this).attr("id").replace("listType", "type"));
        $("form[name=searchedForm]").submit();
    });
    
    /* 검색어 포함 클릭시 */
    $("input[name=searchFlag1]").click(function() {
        if ($(this).is(":checked")) {
            $("input[name=searchFlag2]").attr("checked", false);
        }
    });
    
    /* 검색어 제외 클릭시 */
    $("input[name=searchFlag2]").click(function() {
        if ($(this).is(":checked")) {
            $("input[name=searchFlag1]").attr("checked", false);
        }
    });
    
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
        case 1:menuSubmenSetMain("GIFT", "", "GIFT");break;       // 디자인
        case 2:menuSubmenSetMain("RECORD", "", "RECORD");break;   // CD
        case 3:menuSubmenSetMain("BLURAY", "", "BLURAY");break;   // BLU-RAY
        case 4:menuSubmenSetMain("DVD", "", "DVD");break;          // DVD
        default:menuSubmenSetMain("TOTAL", "", "TOTAL");break;    // 통합검색
        }
        $("form[name=searchedForm] input[name=searchMenuText]").val($(this).text());
        $("form[name=searchedForm] .search_menu").removeClass("active");
    });
});

function chkCateAll(){
    $(".search_tab_btn .cate_item .chkbox.active").each(function(){
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

function srchPrntCtgr(ctgrId){
    if(ctgrId.indexOf("0000") == 0)           $("form[name=searchedForm] input[name='menuGroup']").val("GIFT");
    else if(ctgrId.indexOf("0003") == 0)      $("form[name=searchedForm] input[name='menuGroup']").val("RECORD");
    else if(ctgrId.indexOf("000400") == 0)    $("form[name=searchedForm] input[name='menuGroup']").val("BLURAY");
    else if(ctgrId.indexOf("000401") == 0)    $("form[name=searchedForm] input[name='menuGroup']").val("DVD");
    else                                      $("form[name=searchedForm] input[name='menuGroup']").val("TOTAL");
    
    $("form[name=searchedForm] input[name='categoryGroup']").val(ctgrId);
    if(isEmpty($("input[name='"+ctgrId+"']").val())){
        $("form[name=searchedForm] input[name='categoryBrandCount']").val(0);
    }else{
        $("form[name=searchedForm] input[name='categoryBrandCount']").val($("input[name='"+ctgrId+"']").val());
    }
    $("form[name=searchedForm] input[name='brandGroup']").val("");
    $("form[name=searchedForm]").submit();
    
    $("form[name=searchedForm] input[name='categoryGroup']").val($(this).val());
    if(isEmpty($("input[name='"+$(this).val()+"']").val())){
        $("form[name=searchedForm] input[name='categoryBrandCount']").val(0);
    }else{
        $("form[name=searchedForm] input[name='categoryBrandCount']").val($("input[name='"+$(this).val()+"']").val());
    }
    $("form[name=searchedForm] input[name='brandGroup']").val("");
    $("form[name=searchedForm]").submit();
}

function menuSubmenSetMain(searchMenu, subMenu, menuGroup) {
    $("form[name=searchedForm] input[name=searchMenu]").val(searchMenu);
    $("form[name=searchedForm] input[name=subMenu]").val(subMenu);
    $("form[name=searchedForm] input[name=menuGroup]").val(menuGroup);
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
    $("form[name=searchedForm]").submit();
}

function initFrm(){
    $(".chkbox").removeClass("active");
    $("form[name=searchedForm] input[name=searchFlag1]").attr("checked", false);
    $("form[name=searchedForm] input[name=searchFlag2]").attr("checked", false);
    $("form[name=searchedForm] input[name=cateChkAll]").attr("checked", false);
    $("form[name=searchedForm] input[name=ctgrIds]").attr("checked", false);
    $("form[name=searchedForm] input[name='categoryGroup']").val("");
    $("form[name=searchedForm] input[name='ctgr_id']").val("");
    $("form[name=searchedForm] input[name='ctgr_id_2d']").val("");
    $("form[name=searchedForm] input[name='ctgr_name_2d']").val("");
    $("form[name=searchedForm] input[name='categoryGroup']").val("");
    $("form[name=searchedForm] input[name='brandGroup']").val("");
    $("form[name=searchedForm]").submit();
    loadCondition();
}

function loadCondition(){
    condList = new Array();
    
    $(".tab_pannels .cate_item .chkbox.active").each(function(){
        condList.push($(this).find("input[type=checkbox]").attr("title"));
    });
    
    if(condList.length > 0){
        $("#condList").html("<strong>선택카테고리 &gt;&gt; </strong> "+condList.join(", ")).show();
    }else{
        $("#condList").hide().empty();
    }
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
    <input type="hidden" name="subMenu" value="${c.subMenu}"/>
    <input type="hidden" name="sort" value="${c.sort}"/>
    <input type="hidden" name="menuGroup" value="${c.menuGroup}"/>
    <input type="hidden" name="categoryGroup" value="${c.categoryGroup}" class="srchFlg"/>
    <input type="hidden" name="brandGroup" value="${c.brandGroup}" class="srchFlg"/>
    <input type="hidden" name="searchFlag" value="${c.searchFlag}" class="srchFlg"/>
    <input type="hidden" name="minPrice" value="${c.minPrice}" class="srchFlg"/>
    <input type="hidden" name="maxPrice" value="${c.maxPrice}" class="srchFlg"/>
    <input type="hidden" name="baseMinPrice" value="${c.baseMinPrice}" class="srchFlg"/>
    <input type="hidden" name="baseMaxPrice" value="${c.baseMaxPrice}" class="srchFlg"/>
    <input type="hidden" name="viewType" value="${c.viewType}"/>
    <input type="hidden" name="prevQuery" value="${result.searchParam.prevQuery}" class="srchFlg"/>
    <input type="hidden" name="categoryBrandCount" value="${c.categoryBrandCount}"/>
    <input type="hidden" name="cmpsr" value="${c.cmpsr}"/>
    <input type="hidden" name="rcrd_name" value="${c.rcrd_name}"/>
    <input type="hidden" name="cndtr" value="${c.cndtr}"/>
    <input type="hidden" name="prfmr_kor" value="${c.prfmr_kor}"/>
    <input type="hidden" name="vocal" value="${c.vocal}"/>
    <input type="hidden" name="oscal" value="${c.oscal}"/>
    <input type="hidden" name="istmt_kor" value="${c.istmt_kor}"/>
    <input type="hidden" name="label_name" value="${c.label_name}"/>
    <input type="hidden" name="jmcode" value="${c.jmcode}"/>
    <input type="hidden" name="trk_name" value="${c.trk_name}"/>
    <input type="hidden" name="arti_name" value="${c.arti_name}"/>
    <input type="hidden" name="ctgr_id" value="${c.ctgr_id}" class="srchFlg"/>
    <input type="hidden" name="ctgr_name" value="${c.ctgr_name}" class="srchFlg"/>
    <input type="hidden" name="ctgr_id_2d" value="${c.ctgr_id_2d}" class="srchFlg"/>
    <input type="hidden" name="ctgr_name_2d" value="${c.ctgr_name_2d}" class="srchFlg"/>
    <input type="hidden" name="minDay" value="${c.minDay}"/>
    <input type="hidden" name="maxDay" value="${c.maxDay}"/>
    <input type="hidden" name="drctr" value="${c.drctr}"/>
    <input type="hidden" name="actor" value="${c.actor}"/>
    <input type="hidden" name="detailSearch" value="${c.detailSearch}"/>
    <input type="hidden" name="deliveryVendorId" value="${c.deliveryVendorId}"/>
    <input type="hidden" name="couponYn" value="${c.couponYn}"/>
    <input type="hidden" name="freeDeliveryYn" value="${c.freeDeliveryYn}"/>
    <input type="hidden" name="ajaxCallYn" value="Y"/>
    <input type="hidden" name="page" value="1"/>
    <div class="search_result">
        <p class="result"><em class="point01">'${c.searchTerm}'</em> 검색결과 <em class="point01"><fmt:formatNumber type="number">${result.xmlTotalSize}</fmt:formatNumber></em>개 상품</p>
        <p class="result02"><a href="/ht/search/searchDetail/Record">CD,DVD 상세검색</a></p>
    </div>
    <div class="search_wrap">
        <fieldset>
            <legend>검색</legend>
            <div class="search_box">
                <label class="s_checkbox"><input type="checkbox" id="sFlag1" name="searchFlag1" <c:if test="${c.searchFlag eq 'R'}">checked="checked"</c:if> class="checkbox" title="검색어 포함 선택" /> <span>검색어 포함</span></label>
                <label class="s_checkbox"><input type="checkbox" id="sFlag2" name="searchFlag2" <c:if test="${c.searchFlag eq 'E'}">checked="checked"</c:if> class="checkbox" title="검색어 포함 선택" /> <span>검색어 제외</span></label>
                <div class="s_text">
                    <input name="searchMenuText" type="text" readonly="readonly" value="${_skey_kind}" class="search_menu_txt"/>
                    <input type="text" class="text search_keyword" name="searchTerm" value="${c.searchTerm}" title="검색어 입력" style="ime-mode:active;"/>
                    <a href="#" class="s_search"><span>검색</span></a>
                </div>
                <div class="search_menu">
                    <ul>
                        <li><a href="javascript://">통합검색</a></li>
                        <li><a href="javascript://">디자인</a></li>
                        <li><a href="javascript://">CD</a></li>
                        <li><a href="javascript://">BLU-RAY</a></li>
                        <li><a href="javascript://">DVD</a></li>
                    </ul>
                </div>
            </div>
            <c:if test="${not empty result.listLinked}">
                <script>
                jQuery(function($){
                    $(document).ready(function(){
                        $(".search_wrap .search_link").each(function(){
                            var width = 35;
                            $(this).find(".keyword_area").find("a").each(function(){
                                width += parseInt($(this).css("margin-left").replace("px"));
                                width += parseInt($(this).css("padding-left").replace("px"));
                                width += $(this).width();
                            });
                            if($(this).find("dd").width() < width){
                                $(this).find(".btn_more_r").show();
                            }
                        });
                    });
                    
                    $(".search_wrap .search_link").each(function(){
                        var area = $(this);
                        var term = 300;
                        var width = 35;
                        $(this).find(".keyword_area").find("a").each(function(){
                            width += parseInt($(this).css("margin-left").replace("px"));
                            width += parseInt($(this).css("padding-left").replace("px"));
                            width += $(this).width();
                        });
                        
                        area.find(".btn_more_r").click(function(e){
                            e.preventDefault();
                            var dd = area.find("dd").width();
                            var karea = width;
                            var gab = parseInt(area.find(".keyword_area").css("margin-left").replace("px",""));
                            
                            if(dd < karea + gab){
                                if(dd >= karea + gab - term){
                                    var a = $(this);
                                    area.find(".keyword_area").animate({marginLeft:dd-karea}, function(){ a.hide(); });
                                }else{
                                    area.find(".keyword_area").animate({marginLeft:gab-term});
                                }
                            }else{
                                $(this).hide();
                            }
                            area.find(".btn_more_l").show();
                        });
                        
                        area.find(".btn_more_l").click(function(e){
                            e.preventDefault();
                            var dd = area.find("dd").width();
                            var karea = area.find(".keyword_area").width();
                            var gab = parseInt(area.find(".keyword_area").css("margin-left").replace("px",""));
                            if(gab < 0){
                                if(gab + term >= 0){
                                    var a = $(this);
                                    area.find(".keyword_area").animate({marginLeft:0}, function(){ a.hide(); });
                                }else{
                                    area.find(".keyword_area").animate({marginLeft:gab+term});
                                }
                            }else{
                                $(this).hide();
                            }
                            area.find(".btn_more_r").show();
                        });
                    });
                });
                </script>
                <div class="search_link">
                    <dl>
                        <dt>연관검색어</dt>
                        <dd>
                            <a href="#" class="btn_more_l">왼쪽</a>
                            <div class="keyword_area">
                                <c:forEach var="keyword" items="${result.listLinked}" begin="0" end="7" varStatus="st">
                                    <a href="javascript://" title="${keyword}">${keyword}</a>
                                </c:forEach>
                            </div>
                            <a href="#" class="btn_more_r">오른쪽</a>
                        </dd>
                    </dl>
                </div>
            </c:if>
            <c:if test="${not empty listKeywordPick}">
                <div class="search_link">
                    <dl>
                        <dt>추천검색어</dt>
                        <dd>
                            <a href="#" class="btn_more_l">왼쪽</a>
                            <div class="keyword_area">
                                <c:forEach var="l" items="${listKeywordPick}" begin="0" end="7" varStatus="st">
                                    <a href="javascript://" title="${l.keyword}">${l.keyword}</a>
                                </c:forEach>
                            </div>
                            <a href="#" class="btn_more_r">오른쪽</a>
                        </dd>
                    </dl>
                </div>
            </c:if>
        </fieldset>
    </div>
    
    <!-- Location -->
    <div class="page_location shop">
        <div class="loc">
            <a href="/" class="home">Home</a>
            <c:if test="${empty c.categoryGroup}"><a href="#">전체</a></c:if>
            <c:if test="${not empty c.categoryGroup}">
                <c:set var="ctgrId" value="${fn:split(c.categoryGroup, '_')[0]}"/>
                <c:forEach varStatus="st" begin="6" end="${fn:length(ctgrId)}" step="2">
                    <c:if test="${st.last}"><em><ui:category id="${ctgrId}" full="false"/></em></c:if>
                    <c:if test="${!st.last && st.first}"><a href="#"><ui:category id="${fn:substring(ctgrId, 0, st.index)}" full="false"/></a></c:if>
                    <c:if test="${!st.last && !st.first}"><a href="#"><ui:category id="${fn:substring(ctgrId, 0, st.index)}" full="false"/></a></c:if>
                </c:forEach>
            </c:if>
        </div>
    </div>
    <!-- //Location -->
    
    <c:if test="${not empty result.listCategory}">
        <div class="tab_wrap02 search_cate_area">
        <!-- li.on -->
        <!-- chkbox.active -->
            <h2 class="srch_tit"><span><strong>카테고리</strong> (<fmt:formatNumber pattern=",###">${result.xmlTotalSize}</fmt:formatNumber>)</span></h2>
            <div class="search_cate_tab">
                <c:forEach items="${result.listCategory}" varStatus="s1" step="5">
                    <ul class="search_tab_btn" id="cate${s1.count}deptList">
                        <c:forEach items="${result.listCategory}" var="l1" varStatus="st1" begin="${s1.index}" end="${s1.index+4}">
                            <li<c:if test="${l1.chkCnt > 0}"> class="contain"</c:if>><p class="cate_item"><em class="chkbox<c:if test="${l1.checked}"> active</c:if>"><input type="checkbox" name="cateChkAll" value="${l1.ctgrId}" title="${l1.ctgrName}"<c:if test="${l1.checked}"> checked="checked"</c:if>></em><a value="${l1.ctgrIdNm}" href="#sc<ui:lpad length="2" padChar="0">${st1.index+1}</ui:lpad>"<c:if test="${fn:startsWith(c.categoryGroup, l1.ctgrId)}"> class="on"</c:if>>${l1.ctgrName}<span>(<fmt:formatNumber type="number">${l1.prdtCnt}</fmt:formatNumber>)</span></a></p></li>
                        </c:forEach>
                    </ul>
                    <c:forEach items="${result.listCategory}" var="l1" varStatus="st1" begin="${s1.index}" end="${s1.index+4}">
                        <div id="sc<ui:lpad length="2" padChar="0">${st1.index+1}</ui:lpad>" class="tab_pannels">
                            <!-- 하위카테고리 -->
                            <c:forEach items="${l1.listChild}" varStatus="s2" step="5">
                                <ul>
                                    <c:forEach items="${l1.listChild}" var="l2" varStatus="st" begin="${s2.index}" end="${s2.index+4}">
                                        <li><p class="cate_item"><em class="chkbox<c:if test="${l2.checked}"> active</c:if>"><input type="checkbox" name="ctgrIds" value="${l2.ctgrId}" title="${l2.ctgrName}"<c:if test="${fn:contains(c.ctgr_id_2d, l2.ctgrId)}"> checked="checked"</c:if>></em><a href="#${l2.ctgrId}"<c:if test="${c.categoryGroup eq l2.ctgrIdNm}"> class="on"</c:if>><ui:cut isStripHtml="true" limit="7" tail="..">${l2.ctgrName}</ui:cut> (<fmt:formatNumber type="number">${l2.prdtCnt}</fmt:formatNumber>)</a></p></li>
                                    </c:forEach>
                                </ul>
                                <c:forEach items="${l1.listChild}" var="l2" varStatus="st" begin="${s2.index}" end="${s2.index+4}">
                                    <div class="tab_spannels" id="${l2.ctgrId}">
                                        <c:forEach items="${l2.listChild}" varStatus="s2" step="5">
                                            <ul>
                                                <c:forEach items="${l2.listChild}" var="l3" begin="${s2.index}" end="${s2.index+4}">
                                                    <li><a href="#"<c:if test="${l.checked}"> class="on"</c:if>><input type="hidden" name="${l3.ctgrIdNm}" value="${l3.prdtCnt}"/><ui:cut isStripHtml="true" limit="7" tail="..">${l3.ctgrName}</ui:cut> (<fmt:formatNumber type="number">${l3.prdtCnt}</fmt:formatNumber>)</a></li>
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
        </div>
    </c:if>
    <c:if test="${not empty result.listBrand}">
        <div class="tab_wrap02 search_brand_area">
            <h2 class="srch_tit">
                <span><strong>브랜드</strong> (<fmt:formatNumber pattern=",###">${fn:length(result.listBrand)}</fmt:formatNumber>)</span>
                <c:if test="${fn:length(result.listBrand) > 15}"><a href="#" class="more">더보기</a></c:if>
            </h2>
            <div class="search_brand_tab">
                <c:forEach items="${result.listBrand}" varStatus="s0" step="5">
                    <ul<c:if test="${!s0.first}"> class="hidden" style="display:none;"</c:if>>
                        <c:forEach items="${result.listBrand}" var="l" varStatus="st" begin="${s0.index}" end="${s0.index+4}">
                            <li><a href="#"<c:if test="${c.brandGroup eq l.brandName}"> class="on"</c:if>><input type="hidden" name="${l.brandName}" value="${l.prdtCnt}" /><ui:cut isStripHtml="true" limit="7" tail="..">${l.brandName}</ui:cut> (<fmt:formatNumber type="number">${l.prdtCnt}</fmt:formatNumber>)</a></li>
                        </c:forEach>
                    </ul>
                </c:forEach>
            </div>
        </div>
    </c:if>
    <div class="t_left mgt10" id="condList" style="display:none;line-height:17px;"></div>
    <c:if test="${not empty listCategory || not empty listBrand}">
        <div class="t_right mgt10 btn_wrap">
            <a href="javascript://" onclick="initFrm()" class="btn_type05 br_orange"><span>선택조건 초기화</span></a>
            <a href="javascript://" onclick="submitFrm()" class="btn_type05 bg_orange"><span>선택조건 검색</span></a>
        </div>
    </c:if>
    <div class="search_sort_tab mgt30">
        <ul>
            <li><a href="javascript://" class="on" id="totalCnt02"><strong>ALL</strong> (<fmt:formatNumber pattern=",###">${result.totalSize}</fmt:formatNumber>)<span class="arrow"></span></a></li>
        </ul>
    </div>
    <div class="tbl_top">
        <div class="f_left">
            <ul class="tab_btn02" id="ulSort">
                <li<c:if test="${c.sort eq 'ODC'}"> class="active"</c:if>><a href="javascript://" id="ODC">인기상품순</a></li>
                <li<c:if test="${c.sort eq 'DAT'}"> class="active"</c:if>><a href="javascript://" id="DAT">신상품순</a></li>
                <li<c:if test="${c.sort eq 'LOP'}"> class="active"</c:if>><a href="javascript://" id="LOP">낮은가격순</a></li>
                <li<c:if test="${c.sort eq 'HIP'}"> class="active"</c:if>><a href="javascript://" id="HIP">높은가격순</a></li>
                <li<c:if test="${c.sort eq 'DCR'}"> class="active"</c:if>><a href="javascript://" id="DCR">높은할인율순</a></li>
            </ul>
        </div>
        <div class="btn_l">
            <select class="select" id="ulCouponYn">
                <option value="false"<c:if test="${!c.couponYn}"> selected="selected"</c:if>>전체상품</option>
                <option value="true"<c:if test="${c.couponYn}"> selected="selected"</c:if>>할인상품</option>
            </select>
            <select class="select" id="ulSaleYn" style="margin-left:3px;">
                <option value="N"<c:if test="${c.saleYn eq 'N' || empty c.saleYn}"> selected="selected"</c:if>>품절포함</option>
                <option value="Y"<c:if test="${c.saleYn eq 'Y'}"> selected="selected"</c:if>>품절제외</option>
            </select>
            <select class="select" id="ulListSize" style="margin-left:3px;">
                <option value="40"<c:if test="${c.listSize eq '40'}"> selected="selected"</c:if>>40개</option>
                <option value="80"<c:if test="${c.listSize eq '80'}"> selected="selected"</c:if>>80개</option>
                <option value="120"<c:if test="${c.listSize eq '120'}"> selected="selected"</c:if>>120개</option>
            </select>
            <label class="s_checkbox" style="margin-left:3px;"><input type="checkbox" class="checkbox" id="chkHttsDLvy"<c:if test="${c.deliveryVendorId eq '0625'}"> checked="checked"</c:if>/>&nbsp;핫트랙스 배송</label>
            <ul class="view_type" id="ulListType"> <!-- 활성화댄 항목에 클래스 on 추가 -->
                <li><a href="javascript://" class="type01<c:if test="${c.viewType eq 'type01'}"> on</c:if>" id="listType01"><span>전체보기</span></a></li>
                <li><a href="javascript://" class="type02<c:if test="${c.viewType eq 'type02'}"> on</c:if>" id="listType02"><span>이미지형보기</span></a></li>
                <li><a href="javascript://" class="type03<c:if test="${c.viewType eq 'type03'}"> on</c:if>" id="listType03"><span>리스트형보기</span></a></li>
            </ul>
        </div>
    </div>
    <div id="searchProduct">
        <c:if test="${empty result.listProduct}">
            <c:if test="${empty listEvent}"><p style="text-align:center;"><img src="${imageServer}/images/renewal/shop/img_no_result.jpg" alt="죄송합니다. 고객님께서 찾으시는 상품이 없네요."/></p></c:if>
            <c:if test="${not empty listEvent}"><p style="text-align:center;"><img src="${imageServer}/images/renewal/shop/img_result_onlyevent.jpg" alt="죄송합니다. 고객님께서 찾으시는 상품이 없네요."/></p></c:if>
        </c:if>
        <c:if test="${not empty result.listProduct}">
            <c:if test="${c.viewType eq 'type02'}">
                <div class="prod_list_normal">
                    <c:forEach items="${result.listProduct}" varStatus="s1" step="4">
                        <ul><!-- 1 -->
                            <c:forEach items="${result.listProduct}" var="l" varStatus="st" begin="${s1.index}" end="${s1.index+3}">
                                <!-- 기프트 -->
                                <c:if test="${fn:startsWith(l.ctgrId, '0000')}">
                                    <li>
                                        <!-- AceCounter eCommerce (Product_Detail) v6.5 Start -->
                                        <script language='javascript'>
                                         _A_amt[_ace_countvar]="${l.prdtDscntPrice}";
                                         _A_nl[_ace_countvar]="1";
                                         _A_pl[_ace_countvar]="${l.sellPrdtBcode}";
                                         _A_pn[_ace_countvar]="${l.prdtName}";
                                         _A_ct[_ace_countvar]="";    // ex) 음반/가요/락 -- 매핑불가능한 경우 '' 처리
                                         _ace_countvar++;
                                        </script>
                                        <!-- AceCounter eCommerce (Product_detail) v6.4 Start -->
                                        <span class="img">
                                            <a href="/ht/product/detail?barcode=${l.sellPrdtBcode}"><ui:image src="${l.prdtImgUrl}" server="product" size="200" alt="${fn:escapeXml(l.prdtName)}"/></a>
                                            <div class="hide_util">
                                                <a href="javascript://" onclick="productPreview('${l.sellPrdtBcode}')" class="zoom"><span>확대</span></a>
                                                <a href="/ht/product/detail?barcode=${l.sellPrdtBcode}" target="_blank" class="nblank"><span>새창</span></a>
                                                <a href="javascript://" onclick="addWishProduct('${l.sellPrdtBcode}')" class="zzim"><span>좋아요</span></a>
                                            </div>
                                        </span>
                                        <a href="/ht/product/detail?barcode=${l.sellPrdtBcode}">
                                            <span class="make">${l.brandName}</span>
                                            <span class="name">${l.prdtName}</span>
                                            <span class="icon">
                                                <c:if test="${fn:substring(l.prdtIcon,8,9) eq '1'}"><img src="${imageServer}/images/product/ico_free.jpg" alt="무료배송"/></c:if>
                                                <c:if test="${fn:substring(l.prdtIcon,2,3) eq '1'}"><img src="${imageServer}/images/product/ico_gift.jpg" alt="GIFT"/></c:if>
                                                <c:if test="${fn:substring(l.prdtIcon,0,1) eq '1'}"><img src="${imageServer}/images/product/ico_coupon.jpg" alt="쿠폰"/></c:if>
                                            </span>
                                            <em class="price">
                                                <fmt:parseNumber var="prdtSellPrice" value="${l.prdtSellPrice}"/>
                                                <fmt:parseNumber var="prdtDscntPrice" value="${l.prdtDscntPrice}"/>
                                                <c:if test="${prdtSellPrice > prdtDscntPrice}"><span class="dc"><fmt:formatNumber value="${prdtSellPrice}" pattern="#,###"/></span></c:if>
                                                <span class="sale"><fmt:formatNumber value="${prdtDscntPrice}" pattern="#,###"/></span>
                                                <c:if test="${fn:substring(l.prdtIcon,13,14) eq 'X'}"><span class="pc"><img src="${imageServer}/images/renewal/common/ic_status_soldout.gif" alt="품절"/></span></c:if>
                                                <c:if test="${fn:substring(l.prdtIcon,13,14) ne 'X' && prdtSellPrice > prdtDscntPrice}"><span class="pc">${hfn:rate(prdtSellPrice, prdtDscntPrice)}%</span></c:if>
                                            </em>
                                        </a>
                                    </li>
                                </c:if>
                                <!-- //기프트 -->
                                <!-- CD/DVD -->
                                <c:if test="${fn:startsWith(l.ctgrId, '0003') || fn:startsWith(l.ctgrId, '0004')}">
                                    <li>
                                        <!-- AceCounter eCommerce (Product_Detail) v6.5 Start -->
                                        <script language='javascript'>
                                        _A_amt[_ace_countvar]="${l.prdtDscntPrice}";
                                        _A_nl[_ace_countvar]="1";
                                        _A_pl[_ace_countvar]="${l.sellPrdtBcode}";
                                        _A_pn[_ace_countvar]="${l.prdtName}";
                                        _A_ct[_ace_countvar]="";    // ex) 음반/가요/락 -- 매핑불가능한 경우 '' 처리
                                        _ace_countvar++;
                                        </script>
                                        <!-- AceCounter eCommerce (Product_detail) v6.4 Start -->
                                        <span class="img">
                                            <c:if test="${fn:startsWith(l.ctgrId, '0003')}"><a href="/ht/record/detail/${l.sellPrdtBcode}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="R" ratingCode="${l.rtngCode }" width="200" height="200" alt="${fn:escapeXml(l.ctgrName)}" /></a></c:if>
                                            <c:if test="${fn:startsWith(l.ctgrId, '0004')}"><a href="/ht/record/detail/${l.sellPrdtBcode}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="D" ratingCode="${l.rtngCode }" width="132" height="200" alt="${fn:escapeXml(l.ctgrName)}" /></a></c:if>
                                            <div class="hide_util">
                                                <a href="/ht/record/detail/${l.sellPrdtBcode}" target="_blank" class="nblank"><span>새창</span></a>
                                                <a href="javascript://" onclick="addMyListRecord('${l.rcrdCd}')" class="zzim"><span>담기</span></a>
                                            </div>
                                        </span>
                                        <a href="/ht/record/detail/${l.sellPrdtBcode}">
                                            <span class="make">${l.artiName}</span>
                                            <span class="name">${l.prdtName}</span>
                                            <span class="icon">
                                                <c:if test="${not empty l.freeDlvyYn and l.freeDlvyYn eq 'Y'}"><img src="${imageServer}/images/product/ico_free.jpg" alt="무료배송"/></c:if>
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
                                    </li>
                                </c:if>
                                <!-- //CD/DVD -->
                            </c:forEach>
                        </ul>
                    </c:forEach>
                </div>
            </c:if>
            <c:if test="${c.viewType eq 'type01'}">
                <div class="prod_list_large">
                    <c:forEach items="${result.listProduct}" varStatus="s1" step="2">
                        <ul><!-- 1 -->
                            <c:forEach items="${result.listProduct}" var="l" varStatus="st" begin="${s1.index}" end="${s1.index+1}">
                                <!-- 기프트 -->
                                <c:if test="${fn:startsWith(l.ctgrId, '0000')}">
                                    <li>
                                        <!-- AceCounter eCommerce (Product_Detail) v6.5 Start -->
                                        <script language='javascript'>
                                        _A_amt[_ace_countvar]="${l.prdtDscntPrice}";
                                        _A_nl[_ace_countvar]="1";
                                        _A_pl[_ace_countvar]="${l.sellPrdtBcode}";
                                        _A_pn[_ace_countvar]="${l.prdtName}";
                                        _A_ct[_ace_countvar]="";    // ex) 음반/가요/락 -- 매핑불가능한 경우 '' 처리
                                        _ace_countvar++;
                                        </script>
                                        <!-- AceCounter eCommerce (Product_detail) v6.4 Start -->
                                        <span class="img">
                                            <a href="/ht/product/detail?barcode=${l.sellPrdtBcode}"><ui:image src="${l.prdtImgUrl}" server="product" size="400" alt="${fn:escapeXml(l.prdtName)}"/></a>
                                            <div class="hide_util">
                                                <a href="javascript://" onclick="productPreview('${l.sellPrdtBcode}')" class="zoom"><span>확대</span></a>
                                                <a href="/ht/product/detail?barcode=${l.sellPrdtBcode}" target="_blank" class="nblank"><span>새창</span></a>
                                                <a href="javascript://" onclick="addWishProduct('${l.sellPrdtBcode}')" class="zzim"><span>좋아요</span></a>
                                            </div>
                                        </span>
                                        <a href="/ht/product/detail?barcode=${l.sellPrdtBcode}">
                                            <span class="make">${l.brandName}</span>
                                            <span class="name">${l.prdtName}</span>
                                            <span class="icon">
                                                <c:if test="${fn:substring(l.prdtIcon,8,9) eq '1'}"><img src="${imageServer}/images/product/ico_free.jpg" alt="무료배송"/></c:if>
                                                <c:if test="${fn:substring(l.prdtIcon,2,3) eq '1'}"><img src="${imageServer}/images/product/ico_gift.jpg" alt="GIFT"/></c:if>
                                                <c:if test="${fn:substring(l.prdtIcon,0,1) eq '1'}"><img src="${imageServer}/images/product/ico_coupon.jpg" alt="쿠폰"/></c:if>
                                            </span>
                                            <em class="price">
                                                <fmt:parseNumber var="productPrice" value="${l.prdtSellPrice}"/>
                                                <fmt:parseNumber var="productDcPrice" value="${l.prdtDscntPrice}"/>
                                                <c:if test="${productPrice > productDcPrice}"><span class="dc"><fmt:formatNumber value="${productPrice}" pattern="#,###"/></span></c:if>
                                                <span class="sale"><fmt:formatNumber value="${l.prdtDscntPrice}" pattern="#,###"/></span>
                                                <c:if test="${fn:substring(l.prdtIcon,13,14) eq 'X'}"><span class="pc"><img src="${imageServer}/images/renewal/common/ic_status_soldout.gif" alt="품절"/></span></c:if>
                                                <c:if test="${fn:substring(l.prdtIcon,13,14) ne 'X' && productPrice > productDcPrice}"><span class="pc">${hfn:rate(productPrice, productDcPrice)}%</span></c:if>
                                            </em>
                                        </a>
                                    </li>
                                </c:if>
                                <!-- //기프트 -->
                                <!-- CD/DVD -->
                                <c:if test="${fn:startsWith(l.ctgrId, '0003') || fn:startsWith(l.ctgrId, '0004')}">
                                    <li>
                                        <!-- AceCounter eCommerce (Product_Detail) v6.5 Start -->
                                        <script language='javascript'>
                                        _A_amt[_ace_countvar]="${l.prdtDscntPrice}";
                                        _A_nl[_ace_countvar]="1";
                                        _A_pl[_ace_countvar]="${l.sellPrdtBcode}";
                                        _A_pn[_ace_countvar]="${l.prdtName}";
                                        _A_ct[_ace_countvar]="";    // ex) 음반/가요/락 -- 매핑불가능한 경우 '' 처리
                                        _ace_countvar++;
                                        </script>
                                        <!-- AceCounter eCommerce (Product_detail) v6.4 Start -->
                                        <span class="img">
                                            <c:if test="${fn:startsWith(l.ctgrId, '0003')}"><a href="/ht/record/detail/${l.sellPrdtBcode}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="R" ratingCode="${l.rtngCode }" width="400" height="400" alt="${fn:escapeXml(l.ctgrName)}" /></a></c:if>
                                            <c:if test="${fn:startsWith(l.ctgrId, '0004')}"><a href="/ht/record/detail/${l.sellPrdtBcode}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="D" ratingCode="${l.rtngCode }" width="264" height="400" alt="${fn:escapeXml(l.ctgrName)}" /></a></c:if>
                                            <div class="hide_util">
                                                <a href="/ht/record/detail/${l.sellPrdtBcode}" target="_blank" class="nblank"><span>새창</span></a>
                                                <a href="javascript://" onclick="addMyListRecord('${l.rcrdCd}')" class="zzim"><span>담기</span></a>
                                            </div>
                                        </span>
                                        <a href="/ht/record/detail/${l.sellPrdtBcode}">
                                            <span class="make">${l.artiName}</span>
                                            <span class="name">${l.prdtName}</span>
                                            <span class="icon">
                                                <c:if test="${not empty l.freeDlvyYn and l.freeDlvyYn eq 'Y'}"><img src="${imageServer}/images/product/ico_free.jpg" alt="무료배송"/></c:if>
                                            </span>
                                            <em class="price">
                                                <fmt:parseNumber var="prdt_sell_price" value="${l.prdtSellPrice}"/>
                                                <fmt:parseNumber var="fc_get_dc_price" value="${l.prdtDscntPrice}"/>
                                                <c:if test="${prdt_sell_price > fc_get_dc_price}"><span class="dc"><fmt:formatNumber value="${prdt_sell_price}" pattern="#,###"/></span></c:if>
                                                <span class="sale"><fmt:formatNumber value="${fc_get_dc_price}" pattern="#,###"/></span>
                                                <c:if test="${l.saleYn ne 'Y'}"><span class="pc"><img src="${imageServer}/images/renewal/common/ic_status_soldout.gif" alt="품절"/></span></c:if>
                                                <c:if test="${l.saleYn eq 'Y' && prdt_sell_price > fc_get_dc_price}"><span class="pc">${hfn:rate(prdt_sell_price, fc_get_dc_price)}%</span></c:if>
                                            </em>
                                        </a>
                                    </li>
                                </c:if>
                                <!-- //CD/DVD -->
                            </c:forEach>
                        </ul>
                    </c:forEach>
                </div>
            </c:if>
            <c:if test="${c.viewType eq 'type03'}">
                <div class="prod_list_brd">
                    <ul>
                        <c:forEach items="${result.listProduct}" var="l" varStatus="st">
                            <!-- 기프트 -->
                            <c:if test="${fn:startsWith(l.ctgrId, '0000')}">
                                <li>
                                    <!-- AceCounter eCommerce (Product_Detail) v6.5 Start -->
                                    <script language='javascript'>
                                     _A_amt[_ace_countvar]="${l.prdtDscntPrice}";
                                     _A_nl[_ace_countvar]="1";
                                     _A_pl[_ace_countvar]="${l.sellPrdtBcode}";
                                     _A_pn[_ace_countvar]="${l.prdtName}";
                                     _A_ct[_ace_countvar]="";    // ex) 음반/가요/락 -- 매핑불가능한 경우 '' 처리
                                     _ace_countvar++;
                                    </script>
                                    <!-- AceCounter eCommerce (Product_detail) v6.4 Start -->
                                    <div class="cover"><!-- 2014-10-02 수정 -->
                                        <div>
                                            <a href="/ht/product/detail?barcode=${l.sellPrdtBcode}" title="새창열림">
                                                <ui:image src="${l.prdtImgUrl}" server="product" size="100" alt="${fn:escapeXml(l.prdtName)}" style="width:96px;height:96px;"/>
                                            </a>
                                            <a href="/ht/product/detail?barcode=${l.sellPrdtBcode}" target="_blank" title="새창열림" class="blank"><span>새창</span></a>
                                        </div>
                                    </div>
                                    <div class="p_txt">
                                        <div class="txt_info">
                                            <a href="/ht/product/detail?barcode=${l.sellPrdtBcode}" class="tit">${l.brandName} - ${l.prdtName}</a>
                                            <c:if test="${fn:substring(l.prdtIcon,8,9) eq '1'}"><img src="${imageServer}/images/product/ico_free.jpg" alt="무료배송"/></c:if>
                                            <c:if test="${fn:substring(l.prdtIcon,2,3) eq '1'}"><img src="${imageServer}/images/product/ico_gift.jpg" alt="GIFT"/></c:if>
                                            <c:if test="${fn:substring(l.prdtIcon,0,1) eq '1'}"><img src="${imageServer}/images/product/ico_coupon.jpg" alt="쿠폰"/></c:if>
                                        </div>
                                        <span class="price">
                                            <fmt:parseNumber var="productPrice" value="${l.prdtSellPrice}"/>
                                            <fmt:parseNumber var="productDcPrice" value="${l.prdtDscntPrice}"/>
                                            <c:if test="${productPrice > productDcPrice}">
                                                <span class="ori_price"><fmt:formatNumber value="${productPrice}" type="number" /></span>
                                                <span class="dis_price"><strong><fmt:formatNumber value="${productDcPrice}" type="number" /></strong> (${hfn:rate(productPrice, productDcPrice)}%)</span>
                                            </c:if>
                                            <c:if test="${productPrice <= productDcPrice}">
                                                <span class="dis_price"><strong><fmt:formatNumber value="${productDcPrice}" type="number" /></strong></span>
                                            </c:if>
                                            <c:if test="${l.prdtSavedRate > 0.0}">
                                                <c:set var="savedPrice" value="${l.prdtDscntPrice * l.prdtSavedRate / 100}"/>
                                                <span class="save_price"> | <fmt:formatNumber value="${savedPrice+(10-(savedPrice%10))%10}" type="number" />원 (${l.prdtSavedRate}%적립)</span>
                                            </c:if>
                                            <c:if test="${fn:substring(l.prdtIcon,13,14) eq 'X'}"><span class="pc"><img src="${imageServer}/images/renewal/common/ic_status_soldout.gif" alt="품절"/></span></c:if>
                                        </span>
                                    </div>
                                    <div class="down">
                                        <c:if test="${fn:substring(l.prdtIcon,13,14) ne 'X'}">
                                            <a href="javascript://" onclick="addRecordCart('${l.sellPrdtBcode}')" class="btn_type01">장바구니</a>
                                        </c:if>
                                        <a href="javascript://" onclick="addWishProduct('${l.sellPrdtBcode}')" class="btn_type02">좋아요♥</a>
                                    </div>
                                </li>
                            </c:if>
                            <!-- //기프트 -->
                            <!-- CD/DVD -->
                            <c:if test="${fn:startsWith(l.ctgrId, '0003') || fn:startsWith(l.ctgrId, '0004')}">
                                <li>
                                    <!-- AceCounter eCommerce (Product_Detail) v6.5 Start -->
                                    <script language='javascript'>
                                    _A_amt[_ace_countvar]="${l.prdtDscntPrice}";
                                    _A_nl[_ace_countvar]="1";
                                    _A_pl[_ace_countvar]="${l.sellPrdtBcode}";
                                    _A_pn[_ace_countvar]="${l.prdtName}";
                                    _A_ct[_ace_countvar]="";    // ex) 음반/가요/락 -- 매핑불가능한 경우 '' 처리
                                    _ace_countvar++;
                                    </script>
                                    <!-- AceCounter eCommerce (Product_detail) v6.4 Start -->
                                    <div class="cover"><!-- 2014-10-02 수정 -->
                                        <div>
                                            <c:if test="${fn:startsWith(l.ctgrId, '0003')}"><a href="/ht/record/detail/${l.sellPrdtBcode}" title="새창열림"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="R" ratingCode="${l.rtngCode }" width="96" height="96" alt="${fn:escapeXml(l.ctgrName)}" /></a></c:if>
                                            <c:if test="${fn:startsWith(l.ctgrId, '0004')}"><a href="/ht/record/detail/${l.sellPrdtBcode}" title="새창열림"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="D" ratingCode="${l.rtngCode }" width="63" height="96" alt="${fn:escapeXml(l.ctgrName)}" /></a></c:if>
                                            <a href="/ht/record/detail/${l.sellPrdtBcode}" target="_blank" title="새창열림" class="blank"><span>새창</span></a>
                                        </div>
                                    </div>
                                    <div class="p_txt">
                                        <div class="txt_info">
                                            <a href="/ht/record/detail/${l.sellPrdtBcode}" class="tit">${l.artiName} - ${l.prdtName}</a>
                                            <c:if test="${not empty l.freeDlvyYn and l.freeDlvyYn eq 'Y'}"><img src="${imageServer}/images/product/ico_free.jpg" alt="무료배송"/></c:if>
                                        </div>
                                        <span class="price">
                                            <fmt:parseNumber var="prdt_sell_price" value="${l.prdtSellPrice}"/>
                                            <fmt:parseNumber var="fc_get_dc_price" value="${l.prdtDscntPrice}"/>
                                            <c:if test="${prdt_sell_price > fc_get_dc_price}">
                                                <span class="ori_price"><fmt:formatNumber value="${prdt_sell_price}" type="number" /></span>
                                                <span class="dis_price"><strong><fmt:formatNumber value="${fc_get_dc_price}" type="number" /></strong> (${hfn:rate(prdt_sell_price, fc_get_dc_price)}%)</span>
                                            </c:if>
                                            <c:if test="${prdt_sell_price <= fc_get_dc_price}">
                                                <span class="dis_price"><strong><fmt:formatNumber value="${prdt_sell_price}" type="number" /></strong></span>
                                            </c:if>
                                            <c:if test="${l.prdtSavedRate > 0.0}">
                                                <c:set var="savedPrice" value="${l.prdtDscntPrice * l.prdtSavedRate / 100}"/>
                                                <span class="save_price"> | <fmt:formatNumber value="${savedPrice+(10-(savedPrice%10))%10}" type="number" />원 (${l.prdtSavedRate}%적립)</span>
                                            </c:if>
                                            <c:if test="${l.saleYn ne 'Y'}"><span class="pc"><img src="${imageServer}/images/renewal/common/ic_status_soldout.gif" alt="품절"/></span></c:if>
                                        </span>
                                    </div>
                                    <div class="down">
                                        <c:if test="${l.saleYn eq 'Y'}">
                                            <a href="javascript://" onclick="addRecordCart('${l.sellPrdtBcode}')" class="btn_type01">장바구니</a>
                                            <a href="javascript://" onclick="addRecordBuy('${l.sellPrdtBcode}')" class="btn_type02">바로구매</a>
                                        </c:if>
                                        <a href="javascript://" onclick="addMyListRecord('${l.rcrdCd}')" class="btn_type02">마이리스트 담기</a>
                                    </div>
                                </li>
                            </c:if>
                            <!-- //CD/DVD -->
                        </c:forEach>
                    </ul>
                </div>
            </c:if>
            <div class="paging"><ui:paginationScript name="pageHolder" scriptName="srchPageMove"/></div><!-- end pager -->
        </c:if>
    </div>
    <c:if test="${not empty listEvent}">
        <div class="tit_wrap02 mgt70">
            <h2><img src="${imageServer}/images/renewal/shop/sub_tit16.gif" alt="hot event"/></h2><span>검색어와 매칭되는 이벤트입니다.</span>
        </div>
        
        <div class="event_list">
            <ul class="list">
                <c:forEach items="${listEvent}" var="l" varStatus="st">
                    <li>
                        <a href="/ht/biz/eventDetail?eventId=${l.eventId}">
                            <span class="img"><ui:image src="${l.imageUrl}" alt="${fn:escapeXml(l.eventTitle)}" width="290px" height="140px"/></span>
                            <span class="tit">
                                <strong>${l.eventTitle}</strong>
                                <em>${l.eventDtlCont} </em>
                            </span>
                        </a>
                    </li>
                </c:forEach>
            </ul>
        </div>
    </c:if>
</form>
</body>
</html>
