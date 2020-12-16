<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<ui:decorator name="popup"/>
<html>
<head>
<style type="text/css">
.pop_tit {padding: 20px 0;margin: 0 25%; position: absolute; top:53px;}
.tbl_top {padding:0 20px; position:relative; top:83px;}
.list_type02{padding: 20px; top: 61px; position: relative;}
.search_cate_tab {margin-left: 0;}
.srch_tit {text-align: center; padding: 10px;}
#gnbSearchMenu{position: absolute; top: 75px;left: 43px; font-size: 11px; width: 100px; height: 22px;}
#gnbSearchMenu span.button { display: inline-block; height: 18px; padding: 0 9px 0 8px; border: 1px solid #c3c3c3; font-size: 11px; color: #898989; line-height: 19px;} 
#gnbSearchMenu ul li a { display: block; color: #6b6b69; padding: 6px 0 9px;}
</style>
<title>${c.searchTerm} - HOTTRACKS</title>
<script type="text/javascript" src="/js/jquery.form.js"></script>
<script language="javascript" src="http://image.kyobobook.co.kr/ink/js/acecounter_V70_function.js"></script>
<c:set var="_skey_kind">디자인</c:set>
<c:if test="${c.searchMenu eq 'GIFT'}"><c:set var="_skey_kind">디자인</c:set></c:if>
<c:if test="${c.searchMenu eq 'RECORD'}"><c:set var="_skey_kind">음반/영상</c:set></c:if>

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
        
        $("form[name=searchedForm] input[name='searchMenu']").val("GIFT");
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
        //$("form[name=searchedForm] input[name=cateChkAll]").attr("checked", false);
        //$("form[name=searchedForm] input[name=ctgrIds]").attr("checked", false);
        //$("form[name=searchedForm] input[name='categoryGroup']").val("");
        //$("form[name=searchedForm] input[name='ctgr_id']").val("");
        //$("form[name=searchedForm] input[name='ctgr_id_2d']").val("");
        //$("form[name=searchedForm] input[name='ctgr_name_2d']").val("");
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
     
});


function clickGnbSrchMenu(){
    $("form[name=searchedForm] input[name=searchMenu]").val($("#gnbSearchMenu option:selected").val());
}
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

function setProduct(sellPrdtBcode, prdtName){
    var setStr = "["+sellPrdtBcode+"]" + prdtName;
    parent.opener.setProduct(setStr.substring(0, 100));
    window.close();
}


/* Facebook Pixel Code */
fbq('track', 'Search');
/* End Facebook Pixel Code */

</script>
</head>
<body>
<div style="width:715px;">
<h1><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/renewal/common/tit_pop_buz_top.gif"/></h1>
<form name="searchedForm" method="post" action="/ht/searchProduct">
    <input type="hidden" name="listSize" value="20"/>
    <input type="hidden" name="saleYn" value="N"/>
    <input type="hidden" name="musicAlbumTrack" value="${c.musicAlbumTrack}"/>
    <input type="hidden" name="searchMenu" value="${c.searchMenu}"/>
    <input type="hidden" name="sort" value="${c.sort}"/>
    <input type="hidden" name="categoryGroup" value="${c.categoryGroup}" class="srchFlg"/>
    <input type="hidden" name="brandGroup" value="${c.brandGroup}" class="srchFlg"/>
    <input type="hidden" name="searchFlag" value="${c.searchFlag}" class="srchFlg"/>
    <input type="hidden" name="minPrice" value="${c.minPrice}" class="srchFlg"/>
    <input type="hidden" name="maxPrice" value="${c.maxPrice}" class="srchFlg"/>
    <input type="hidden" name="baseMinPrice" value="${c.baseMinPrice}" class="srchFlg"/>
    <input type="hidden" name="baseMaxPrice" value="${c.baseMaxPrice}" class="srchFlg"/>
    <input type="hidden" name="viewType" value="${c.viewType}"/>
    <input type="hidden" name="prevQuery" value="${result.marinerCriteria.prevQuery}" class="srchFlg"/>
    <input type="hidden" name="categoryBrandCount" value="0"/>
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
    <input type="hidden" name="couponYn" value="true"/>
    <input type="hidden" name="freeDeliveryYn" value="false"/>
    <input type="hidden" name="ajaxCallYn" value="Y"/>
    <input type="hidden" name="page" value="1"/>
    <input type="hidden" name="viewType"/>
    <input type="hidden" name="exLink" value="${krywordsUrl}"/>
    <input type="hidden" name="exTxt" value="${keywords}"/>
    <select id="gnbSearchMenu" class="search_menu" onchange="clickGnbSrchMenu();">
        <option value="GIFT" <c:if test="${c.searchMenu eq 'GIFT' ||  empty c.searchMenu }">selected="selected"</c:if>>기프트</option>
        <option value="RECORD" <c:if test="${c.searchMenu eq 'RECORD'}">selected="selected"</c:if>>음반/영상</option>
    </select>
    
    <div class="pop_tit">
        <input type="text" name="searchTerm" value="${c.searchTerm}" class="input_txt" style="width:250px;"/>
        <a href="javascript://" onclick="document.searchedForm.submit()" class="btn_type01" id="btnSearch">검색</a>
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
    </div>
    <div id="searchProduct" style="display: inline-block; margin-top: 85px;">
        <c:if test="${not empty c.searchTerm && empty result.listProduct}">
            <p style="text-align:center;"><img src="${imageServer}/images/renewal/shop/img_no_result.jpg" alt="죄송합니다. 고객님께서 찾으시는 상품이 없네요."/></p>
        </c:if>
        <c:if test="${not empty result.listProduct}">
            <div class="prod_list_brd">
                <ul>
                    <c:forEach items="${result.listProduct}" var="l" varStatus="st">
                        <c:set var="prdtName"><ui:cut isStripHtml="true">${l.prdtName}</ui:cut></c:set>
                        <!-- 기프트 -->
                        <c:if test="${fn:startsWith(l.ctgrId, '0000')}">
                            <li>
                                <div class="cover"><!-- 2014-10-02 수정 -->
                                    <div>
                                        <a href="#" onclick="setProduct('${l.sellPrdtBcode}', '${prdtName}');return false;">
                                            <ui:image src="${l.prdtImgUrl}" server="product" size="100" alt="${prdtName}" style="width:96px;height:96px;"/>
                                        </a>
                                    </div>
                                </div>
                                <div class="p_txt">
                                    <div class="txt_info">
                                        <a href="#" onclick="setProduct('${l.sellPrdtBcode}', '${prdtName}');return false;" class="tit">${l.brandName} - ${l.prdtName}</a>
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
                            </li>
                        </c:if>
                        <!-- //기프트 -->
                        <!-- CD/DVD -->
                        <c:if test="${fn:startsWith(l.ctgrId, '0003') || fn:startsWith(l.ctgrId, '0004')}">
                            <li>
                                <div class="cover"><!-- 2014-10-02 수정 -->
                                    <div>
                                        <c:if test="${fn:startsWith(l.ctgrId, '0003')}"><a href="#" onclick="setProduct('${l.sellPrdtBcode}', '${prdtName}');return false;"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="R" ratingCode="${l.rtngCode }" width="96" height="96" alt="${fn:escapeXml(l.ctgrName)}" /></a></c:if>
                                        <c:if test="${fn:startsWith(l.ctgrId, '0004')}"><a href="#" onclick="setProduct('${l.sellPrdtBcode}', '${prdtName}');return false;"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="D" ratingCode="${l.rtngCode }" width="63" height="96" alt="${fn:escapeXml(l.ctgrName)}" /></a></c:if>
                                    </div>
                                </div>
                                <div class="p_txt">
                                    <div class="txt_info">
                                        <a href="#" onclick="setProduct('${l.sellPrdtBcode}', '${prdtName}');return false;" class="tit">${l.artiName} - ${l.prdtName}</a>
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
                            </li>
                        </c:if>
                        <!-- //CD/DVD -->
                    </c:forEach>
                </ul>
            </div>
            <div class="paging"><ui:paginationScript name="pageHolder" scriptName="srchPageMove"/></div><!-- end pager -->
        </c:if>
    </div>
</form>
</div>
</body>
</html>
