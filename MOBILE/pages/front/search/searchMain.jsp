<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="search"/>
<html>
<head>
<title>검색결과 - NEW ME HOTTRACKS</title>
<script type="text/javascript" src="/js/jquery.form.js"></script>

<!-- 레코벨 스크립트 -->
<script type="text/javascript">
	var userId= getCookie("UserCookieKey");

	window._rblq = window._rblq || [];
	_rblq.push(['setVar','cuid','e15e978e-3623-4892-bf0a-485b9f8196ee']);
	_rblq.push(['setVar','device','MW']);
	_rblq.push(['setVar','userId',SHA256(userId)]); // optional
	_rblq.push(['setVar','searchTerm','${c.searchTerm}']);
	_rblq.push(['track','search']);
	(function(s,x){s=document.createElement('script');s.type='text/javascript';
	s.async=true;s.defer=true;s.src=(('https:'==document.location.protocol)?'https':'http')+'://assets.recobell.io/rblc/js/rblc-apne1.min.js';
	x=document.getElementsByTagName('script')[0];x.parentNode.insertBefore(s, x);})();
</script>
<!-- 레코벨 스크립트 끝 -->

<script type="text/javascript">
var swiper2;
var recobellSwiper;
var _data;
var _cond = {
    listSize:"${c.listSize}"
  , searchMenu:"${c.searchMenu}"
  , categoryGroup:"${c.categoryGroup}"
  , brandGroup:"${c.brandGroup}"
  , ctgr_id_1d:"${c.ctgr_id_1d}"
  , ctgr_id_2d:"${c.ctgr_id_2d}"
  , page:"1"
  , searchTerm:"${c.searchTerm}"
  , saleYn:"${c.saleYn}"
  , sort:"${c.sort}"
  , freeDeliveryYn:"${c.freeDeliveryYn}"
  , deliveryVendorId:"${c.deliveryVendorId}"
  , discountYn:"${c.discountYn}"
  , couponYn:"${c.couponYn}"
  , minPrice:"${c.minPrice}"
  , maxPrice:"${c.maxPrice}"
  , viewType:"${c.viewType}"
  , plusKeywords:"${c.plusKeywords}"
  , minusKeywords:"${c.minusKeywords}"
};


window.onpopstate = function(e) {
    if(e.state){
        _cond = e.state;
        _searchProduct(false, true);
    }else{
        history.back();
    }
};

jQuery(function($){
    $(document).ready(function(){
        $("[type=checkbox]").change(function(){
            if($(this).is(":checked"))    $(this).parents(".chk_wrap").addClass("active");
            else                          $(this).parents(".chk_wrap").removeClass("active");
        });
        
        _searchProduct(false, false);
        
        $("#footer").hide();
    });
    
    $(".ns_body").scroll(function(){
        if($("#_listLinked").find("a").length > 0){
            var height = 35;
            if($(this).scrollTop() > height)    $(".ns_related").height(0);
            else                                $(".ns_related").height(height - $(".ns_body").scrollTop());
        }else{
            $(".ns_related").height(0);
        }
        
        if($(this).scrollTop() > 0)    $(".ns_head").addClass("scroll");
        else                           $(".ns_head").removeClass("scroll");
        
        // 뒤로가기/위로가기 버튼 노출
        var timeCheck01;
        if($("#btnBack").is(":hidden")){
            $("#btnBack,#btnTop").fadeIn("fast");
            $("#btnBack,#btnTop").addClass("moved");
            moveCheck();
        }
        function moveCheck(){
            clearTimeout(timeCheck01);
            timeCheck01 = setTimeout(function(){
                if($("#btnBack").hasClass("moved")){
                    $("#btnBack,#btnTop,#btnDown").removeClass("moved");
                    moveCheck();
                } else{
                    $("#btnBack,#btnTop,#btnDown").fadeOut("slow");
                } 
            }, 2000);
        }
    });
    
    $("[name=searchTerm]").focus(function(){
        $(this).select();
        $("#layer-search").addClass("active");
        $("html,body").addClass("freezed");
        $(".txt_reset").show();
    });
    
    $("#layer-search").click(function(e) {
        if(!$(e.target).parents(".ly_keybox").length > 0) {
            $("#layer-search").removeClass("active");
            $("html,body").removeClass("freezed");
            $(".txt_reset").hide();
        }
    });
    
    $("[name=searchTerm]").keypress(function(e) {
        if (e.which == 13) {
            e.preventDefault();
            
            _cond.searchTerm = $(this).val();
            _search();
        }
    });
    
    $("[name=searchTerm]").change(function() {
        _cond.searchTerm = $(this).val();
    });
    
    $("[name=sort]").change(function(){
        _reSearch("sort", $(this).val());
        layer_close();
    });
    
    $("[name=saleYn]").change(function(){
        _reSearch("saleYn", $(this).val());
        layer_close();
    });
    
    $("#choiceBnft input[type=checkbox]").change(function(){
        if($(this).is(":checked"))    _reSearch($(this).attr("name"), $(this).val());
        else                          _reSearch($(this).attr("name"), "");
    });
    
    $("[name=minPrice],[name=maxPrice]").focus(function(){
        $("#searchFilter .gbn_box").animate({scrollTop:$(document).height()});
    });
    
    $("[name=minPrice],[name=maxPrice]").change(function(){
        _reSearch($(this).attr("name"), $(this).val());
    });
    
    $(".layer_lbox").click(function(e){
        if($(e.target).hasClass("layer_lbox") && !$(e.target).hasClass("gbn_box")) closeFilter();
    });
    
    $(".ly_keybox .side_menu li a").click(function(){
        if(!$(this).hasClass("active")){
            $(".ly_keybox .side_menu li a.active").removeClass("active");
            $(".ly_keybox .srch_list_item.active").removeClass("active");
            
            $(this).addClass("active");
            $(".ly_keybox .srch_list_item").eq($(".ly_keybox .side_menu li").index($(this).parent())).addClass("active");
        }
    });
});

function openFilter() {
    $("#searchFilter").addClass("active");
    $("html,body").addClass("freezed");
}

function closeFilter(){
    $("#searchFilter").removeClass("active");
    $("html,body").removeClass("freezed");
};

function _reset(){
    _cond = { searchMenu:_cond["searchMenu"], searchTerm:_cond["searchTerm"] };
    _reSearch();
}

function setSrchPrice(minPrice, maxPrice){
    _cond["minPrice"] = minPrice;
    _cond["maxPrice"] = maxPrice;
    
    _reSearch();
}

function _addKeywords(){
    _reSearch("plusKeywords", $("[name=plusKeywords]").val());
}

function layer_close(){
    $(".layer_box").hide();
}

function _clearTerm(){
    $("[name=searchTerm]").val("").focus();
}

function tglLayer(obj, id){
    if(obj.classList.contains("active")){
        obj.classList.remove("active");
        $(id).hide();
        
        if(id == "#choiceCtgr")    $(".gbn_box").scrollTop(0);
    }else{
        obj.classList.add("active");
        $(id).show();
        if(id == "#choiceCtgr")    $(".gbn_box").scrollTop($("#optnCtgr").offset().top);
    }
}

// 단순 검색
function _search(searchTerm){
    if(searchTerm){
        _cond.searchTerm = searchTerm;
        $("[name=searchTerm]").val(searchTerm);
    }
    
    if($.trim(_cond.searchTerm) == ""){
        alert("검색어를 입력해주세요");
        $("[name=searchTerm]").focus();
        return false;
    }
    _cond = { searchMenu:_cond["searchMenu"], viewType:_cond["viewType"], searchTerm:_cond["searchTerm"], page:"1" };
    _searchProduct(false, false);
    
    $("#layer-search").removeClass("active");
    $(".txt_reset").hide();
    $("[name=searchTerm]").blur();
};

// 결과내 재검색
function _reSearch(key, value){
    if(key)    _cond[key] = value;
    if(key == "searchTerm")    $("[name=searchTerm]").val(value);
    if(key != "brandGroup")    _cond.brandGroup = "";
    if(key != "ctgr_id_1d" && key != "ctgr_id_2d" && key != "brandGroup"){
        _cond.ctgr_id_1d = "";
        _cond.ctgr_id_2d = "";
    }
    _cond.page = "1";
    _searchProduct(true, false);
};

// 페이징처리
function _moveToPage(page){
    if(page)    _cond.page = page;
    else        _cond.page = "1";
    _searchProduct(true, false);
};
//카테고리토글
function _tglSearchMenu(value){
    _reSearch("searchMenu", value);
}

// 카테고리토글
function _tglCtgrId(ctgrId){
    if(ctgrId == "0003" || (ctgrId.substring(0, 4) != "0003" && ctgrId.length == 6)){
        // 1뎁스 토글
        if(_cond.ctgr_id_1d != ctgrId)    _cond.ctgr_id_1d = ctgrId;
        else                              _cond.ctgr_id_1d = "";
        
        _cond.ctgr_id_2d = "";
        
        _reSearch("ctgr_id_1d", _cond.ctgr_id_1d);
    }else{
        // 2뎁스 토글
        if(_cond.ctgr_id_2d != ctgrId)    _cond.ctgr_id_2d = ctgrId;
        else                              _cond.ctgr_id_2d = "";
        
        _reSearch("ctgr_id_2d", _cond.ctgr_id_2d);
    }
}

// 브랜드토글
function _tglBrand(obj, brandName){
    var brandGroup = "";
    if(_isEmpty(_cond.brandGroup))            _cond.brandGroup = brandName;
    else if(_cond.brandGroup == brandName)    _cond.brandGroup = "";
    else{
        var arr = _cond.brandGroup.split(",");
        if($.inArray(brandName, _cond.brandGroup.split(",")) <  0)    arr.push(brandName);
        else                                                          arr.pop(brandName);
        _cond.brandGroup = arr.join(",");
    }
    _reSearch("brandGroup", _cond.brandGroup);
}

// 혜택 토글
function _tglBenefit(obj, key, value){
    if(obj.classList.contains("active")){
        obj.classList.remove("active");
        _cond[key] = "";
    }else{
        obj.classList.add("active");
        _cond[key] = value;
    }
    _reSearch();
}

function _searchProduct(filterYn, skipHist){
    _cond.filterYn = filterYn;
    
    $.ajax({
        url:"/m/search/ajaxSearchProduct"
      , async:false
      , data: JSON.stringify(_cond)
      , type:"POST"
      , headers: {
           "Accept": "application/json"
         , "Content-Type": "application/json"
        }
      , dataType:"json"
      , success:function(data){
            _data = data;
            
            if(data){
                //console.log(_data);
                // STEP01: 레코벨처리
                _mkRecobell();
                
                // STEP04: 카테고리처리
                _mkCategory();
                
                // STEP05: 브랜드처리
                _mkBrand();
                
                if(!filterYn){
                    // STEP02: 연관검색어
                    _mkLinked();
                    
                    // STEP06: 가격처리
                    _mkPrice();
                }
                
                // STEP03: 이벤트처리
                _mkEvent();
                
                // STEP07: 상품로드
                _mkProduct();
                
                // STEP08: 페이징처리
                _mkPage();
                
                // STEP09: 기타조건처리
                _mkEtc();
                
                if(_data.c && history.pushState && !skipHist){
                     var state = _cond;
                     var title = '검색결과 - NEW ME HOTTRACKS';
                     var url = '/m/search/searchMain' + _data.c.query;
                     history.pushState(state, title, url);
                }
            }
            
            // $(".s_cont").css("marginTop", $(".s_result").outerHeight());
            
            if(filterYn)    $(".ns_body").scrollTop(0);
            setTimeout(function(){
                $(".ns_body").css("padding-top", $(".ns_head").outerHeight());
                $(".ns_body").css("height", $(window).height() - $(".ns_head").outerHeight() - $(".ns_foot").outerHeight());
            }, 500);
            
        }
      ,error: function(request, status, error) {
            alert("검색 중 오류가 발생하였습니다. 잠시 후 다시 이용해주세요");
            // alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
        }
    });
}

//상품처리
function _mkRecobell(){
    // 상품 로드
    if(_data && _data.result && _data.result.listRecobell && _data.result.listRecobell.length >= 3){
        var listRecobell = _data.result.listRecobell;
    	var strHtml = '';
        var size = 0;
        var listLen = 0;
    	
        if(_data.result.listRecobell.length >= 15){
        	listLen = 5;
        }else{
        	listLen = parseInt(_data.result.listRecobell.length / 3);
        }

        strHtml += '<div class="swiper-container">';
        strHtml += '<div class="swiper-wrapper">';
        for(var i = 0; i < listLen; i++){
        	strHtml += '<div class="swiper-slide">';
        	strHtml += '<div class="box_cont">';
        	strHtml += '<div class="row">';
        	for(var j = size; j < size+3; j++){
        		var recobell = listRecobell[j];
        		strHtml += '<a href="/p/'+recobell.sellPrdtBcode+'?foo=bar&rccode=mo_search1" class="box_prod row_item">';
        		if(recobell.sellPrdtGbn == "R")         strHtml += '<span class="pic"><img src="' + _imgRecordUrl(recobell.rcrdCd, "R", "midi", (recobell.rtngCode == "C0845"?"Y":"N"), "N") + '" alt="' + recobell.prdtName + '"/></span>';
                else if(recobell.sellPrdtGbn == "D")    strHtml += '<span class="pic"><img src="' + _imgRecordUrl(recobell.rcrdCd, "D", "midi", (recobell.rtngCode == "C0845"?"Y":"N"), "N") + '" alt="' + recobell.prdtName + '" style="width:77px;"/></span>';
                else                                    strHtml += '<span class="pic"><img src="' + _imgUrl(recobell.productImageUrl, "product", "400") + '" alt="' + recobell.prdtName + '"/></span>';
        		strHtml += '<p class="tit">'+recobell.prdtName+'</p>';
        		strHtml += '<p class="price">';
        		strHtml += '<em>'+price_format(recobell.lastCpnPrice)+'원</em>';
        		if(recobell.prdtSellPrice != recobell.lastCpnPrice){
        			strHtml += '<em class="sale">[' + _calDscntRate(recobell.prdtSellPrice, recobell.lastCpnPrice, 1) + '%]</em>';
        		}
        		strHtml += '</p>';
        		strHtml += '</a>';
            }
       		strHtml += '</div>';
       		strHtml += '</div>';
       		strHtml += '</div>';
       		size = size + 3;
        }
    	strHtml += '</div>';
       	strHtml += '</div>';
       	strHtml += '<div class="pagination"></div>';

       	$("#_listRecobell").html(strHtml);
       	$("#_listRecobell").show();
	    
       	recobellSwiper = new Swiper('.pbest_list .swiper-container',{
	        pagination: '.pbest_list div.pagination',
	        loop:true,
	        grabCursor: true,
	        paginationClickable: true
	    });
    }else{
    	$("#_listRecobell").hide();
    }
}

// 연관검색어
function _mkLinked(){
    if(_data && _data.result && _data.result.listLinked && _data.result.listLinked.length > 0){
        var listLinked = _data.result.listLinked;
        
        var strHtml = '';
        for(var i = 0;i < listLinked.length; i++){
            var linked = listLinked[i];
            strHtml += '<a href="#" onclick="_search(\'' + linked + '\');return false;">' + linked + '</a>';
        }
        $("#_listLinked").html(strHtml).show().scrollLeft(0);
    }else{
        $("#_listLinked").html("").hide();
    }
}

// 이벤트처리
function _mkEvent(){
    if(_data && _data.listEvent && _data.listEvent.length > 0 && _data.c.page == 1){
        var listEvent = _data.listEvent;
        
        var strHtml = '';
        strHtml += '<div class="visual">';
        strHtml += '<div class="swiper-container">';
        strHtml += '<ul class="swiper-wrapper">';
        
        for(var i = 0; i < listEvent.length && i < 5; i++){
            var event = listEvent[i];
            strHtml += '<li class="swiper-slide">';
            strHtml += '<a href="/m/biz/eventDetail?eventId=' + event.eventId + '">';
            strHtml += '<p><img src="' + _imgUrl(event.imageUrl) + '" alt="' + event.eventTitle + '" class="prdt-photo"/></p>';
            strHtml += '<p class="tit">' + event.eventTitle + '</p>';
            strHtml += '<p class="txt">' + _isEmpty(event.eventDtlCont)?'':event.eventDtlCont + '</p>';
            strHtml += '</a>';
            strHtml += '</li>';
        }
        
        strHtml += '</ul>';
        strHtml += '</div>';
        strHtml += '<div class="pagination"></div>';
        strHtml += '</div>';
        $("#listEvent").html(strHtml);
        $("#listEvent").show();
        
        swiper2 = new Swiper('.ns_evt .swiper-container',{
            pagination: '.ns_evt div.pagination',
            loop:true,
            grabCursor: true,
            paginationClickable: true
        });
    }else{
        $("#listEvent").hide();
    }
}

// 카테고리 로드
function _mkCategory(){
    if(_data && _data.result && _data.result.listCategory && _data.result.listCategory.length > 0){
        var listCategory = _data.result.listCategory;
        
        var strHtml = '';
        for(var i = 0; i < listCategory.length;i++){
            var cate01 = listCategory[i];
            
            if(   (_data.c.searchMenu == "GIFT" && cate01.ctgrId.substring(0, 4) == "0000")
               || (_data.c.searchMenu == "RECORD" && cate01.ctgrId.substring(0, 4) != "0000")
              ){
                if(_data.c.ctgr_id_1d == cate01.ctgrId)    strHtml += '<dl id="chkCate' + cate01.ctgrId + '" class="active" title="' + cate01.ctgrName + '">';
                else                                       strHtml += '<dl id="chkCate' + cate01.ctgrId + '" title="' + cate01.ctgrName + '">';
                strHtml += '<dt><a href="#" onclick="_tglCtgrId(\'' + cate01.ctgrId + '\');return false;">' + cate01.ctgrName + ' ' + price_format(cate01.prdtCnt) + '</a></dt>';
                strHtml += '<dd class="layer_cont1 chk_area" id="choiceCtgr' + cate01.ctgrId + '">';
                for(var j = 0;j < cate01.listChild.length; j++){
                    var cate02 = cate01.listChild[j];
                    if(_data.c.ctgr_id_2d == cate02.ctgrId)    strHtml += '<a href="#' + cate02.ctgrId + '" class="chk_cate active" onclick="_tglCtgrId(\'' + cate02.ctgrId + '\');return false;">┗ ' + cate02.ctgrName + '<em>' + price_format(cate02.prdtCnt) + '</em></a>';
                    else                                       strHtml += '<a href="#' + cate02.ctgrId + '" class="chk_cate" onclick="_tglCtgrId(\'' + cate02.ctgrId + '\');return false;">┗ ' + cate02.ctgrName + '<em>' + price_format(cate02.prdtCnt) + '</em></a>';
                }
                strHtml += '</dd>';
                strHtml += '</dl>';
            }
        }
        $("#choiceCtgr").html(strHtml);
    }else{
        $("#choiceCtgr").html("");
    }
}

// 브랜드 로드
function _mkBrand(){
    if(_data && _data.c && _data.c.searchMenu == "GIFT"){
        if(_data && _data.result && _data.result.listBrandByCnt && _data.result.listBrandByCnt.length > 0){
            var listBrandByCnt = _data.result.listBrandByCnt;
            
            var strHtml = '';
            for(var i = 0; i < listBrandByCnt.length;i++){
                var brand = listBrandByCnt[i];
                if(_isEmpty(_data.c.brandGroup) || $.inArray(brand.brandName, _data.c.brandGroup.split(",")) <  0){
                    strHtml += '<a href="#' + brand.brandName + '" class="chk_brand" onclick="_tglBrand(this, \'' + brand.brandName + '\');return false;">' + brand.brandName + '<em>' + price_format(brand.prdtCnt) + '</em></a>';
                }else{
                    strHtml += '<a href="#' + brand.brandName + '" class="chk_brand active" onclick="_tglBrand(this, \'' + brand.brandName + '\');return false;">' + brand.brandName + '<em>' + price_format(brand.prdtCnt) + '</em></a>';
                }
            }
            $("#choiceBrand").html(strHtml);
        }else{
            $("#choiceBrand").html("");
        }
        $("#optnBrand").show();
    }else{
        $("#optnBrand").hide();
    }
}

// 가격대
function _mkPrice(){
    if(_data && _data.priceRange){
        var priceRange = _data.priceRange;
        var strHtml = '';
        strHtml += '<div class="chk_area">';
        strHtml += '<p id="price__" class="chk_wrap chk_prices"><label><a href="#" onclick="setSrchPrice(\'\', \'\');return false;">전체</a></label></p>';
        for(var i = 0; i < priceRange.length; i++){
            var price = priceRange[i];
            strHtml += '<p id="price_' + price.MIN + '_' + price.MAX + '" class="chk_wrap chk_prices"><label><a href="#" onclick="setSrchPrice(\'' + price.MIN + '\', \'' + price.MAX + '\');return false;">' + price.TXT + '</a></label></p>';
        }
        strHtml += '</div>';
        $("#_priceRange").html(strHtml);
    }
}

// 상품처리
function _mkProduct(){
    // 상품 로드
    if(_data && _data.result && _data.result.listProduct && _data.result.listProduct.length > 0){
        var listProduct = _data.result.listProduct;
        
        var strHtml = '';
        for(var i = 0; i < listProduct.length;i++){
            var product = listProduct[i];
            strHtml += '<a href="/p/' + product.sellPrdtBcode + '">';
            
            // 7개 이상일때 후 로딩 처리
            if(product.ctgrId){
                if(product.ctgrId.substring(0, 4) == "0003")         strHtml += '<span class="pic"><img src="' + _imgRecordUrl(product.rcrdCd, "R", "midi", (product.rtngCode == "C0845"?"Y":"N"), "N") + '" alt="' + product.prdtName + '"/></span>';
                else if(product.ctgrId.substring(0, 4) == "0004")    strHtml += '<span class="pic dvd"><img src="' + _imgRecordUrl(product.rcrdCd, "D", "midi", (product.rtngCode == "C0845"?"Y":"N"), "N") + '" alt="' + product.prdtName + '"/></span>';
                else                                                 strHtml += '<span class="pic"><img src="' + _imgUrl(product.prdtImgUrl, "product", "400") + '" alt="' + product.prdtName + '"/></span>';
            }else{
                strHtml += '<span class="pic"><img src="' + _imgUrl(product.prdtImgUrl, "product", "400") + '" alt="' + product.prdtName + '"/></span>';
            }
            
            // 상품기본정보
            strHtml += '<span class="txt_box">';
            if(product.ctgrId){
                if(product.ctgrId.substring(0, 4) == "0003" || product.ctgrId.substring(0, 4) == "0004"){
                    strHtml += '<em class="brand">' + product.labelName + '</em>';
                }else{
                    strHtml += '<em class="brand">' + product.brandName + '</em>';
                }
            }else{
                strHtml += '<em class="brand">' + product.brandName + '</em>';
            }
            strHtml += '<em class="tit">' + product.prdtName + '</em>';
            strHtml += '<em class="price">' + price_format(product.prdtDscntPrice) + '원</em>';
            if(product.prdtSellPrice != product.prdtDscntPrice)    strHtml += '<em class="sale">[' + _calDscntRate(product.prdtSellPrice, product.prdtDscntPrice, 1) + '%]</em>';
            strHtml += '</span>';
            
            // 리뷰 및 좋아요 개수
            strHtml += '<span class="ico_box">';
            if(product.reviewCount > 99)        strHtml += '<em class="ico_review">99+</em>';
            else if(product.reviewCount > 0)    strHtml += '<em class="ico_review">' + product.reviewCount + '</em>';
            if(product.wishCount > 99)        strHtml += '<em class="ico_like">99+</em>';
            else if(product.wishCount > 0)    strHtml += '<em class="ico_like">' + product.wishCount + '</em>';
            strHtml += '</span>';
            
            // 아이콘
            strHtml += '<span class="bnf_box">';
            if(product.saleYn != 'Y')                strHtml += '<em class="ico_soldout">품절</em>';
            else{
                if(product.freeDlvyYn == 'Y')        strHtml += '<em class="ico_free">무료배송</em>';
                if(product.cpnYn == 'Y')             strHtml += '<em class="ico_coupon">쿠폰</em>';
                if(product.freeGiftYn == 'Y')        strHtml += '<em class="ico_gift">GIFT</em>';
                if(product.dlvyVndrId == '0625')     strHtml += '<em class="ico_hottracks">핫트랙스배송</em>';
            }
            strHtml += '</span>';
            
            strHtml += '</a>';
        }
        $("#_listProduct").html(strHtml);
    }else{
        if(_data && _data.c){
            if(_data.c.searchMenu == "GIFT" && _data.result.recordSize > 0){
                $("#_listProduct").html('<p class="info t_c" style="font-weight:300;font-size: 20px;line-height: 1.3em;background: url(http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/search/ico_onlymusic01.png) center 20px no-repeat;background-size:56px;padding: 94px 0 60px;color: #555555;letter-spacing: -1px;">해당 검색어는 기프트 상품에는 없으나<br><span style="color: #da2128;">음반 상품</span>으로는 있습니다.</p>');
            }else if(_data.c.searchMenu == "RECORD" && _data.result.giftSize > 0){
                $("#_listProduct").html('<p class="info t_c" style="font-weight:300;font-size: 20px;line-height: 1.3em;background: url(http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/search/ico_onlygift01.png) center 20px no-repeat;background-size:56px;padding: 94px 0 60px;color: #555555;letter-spacing: -1px;">해당 검색어는 음반 상품에는 없으나<br><span style="color: #da2128;">기프트 상품</span>으로는 있습니다.</p>');
            }else if(_data.result.saleTotalSize > 0){
                $("#_listProduct").html('<p class="info t_c" style="font-weight:300;font-size: 20px;line-height: 1.3em;background: url(http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/search/ico_soldout01.png) center 20px no-repeat;background-size:56px;padding: 94px 0 60px;color: #555555;letter-spacing: -1px;">검색 결과에는 없지만<br><span style="color: #da2128;">품절 상품</span>에는 포함되어 있습니다.</p>');
            }else{
                $("#_listProduct").html('<p class="info t_c" style="font-weight:300;font-size: 28px;line-height: 1.3em;background: url(http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/search/ico_noresult01.png) center 20px no-repeat;background-size: 66px;padding: 110px 0 30px;color: #555555;letter-spacing: -1px;">검색어와 일치하는<br><span style="color: #da2128;">내용</span>이 없습니다.<br><span style="display: block;font-size: 12px;text-align: left;width: 200px;margin: 15px auto;font-weight:normal;line-height: 1.75em;">- 단어의 철자를 다시 확인해 주세요.<br>- 단어의 절차나 띄어쓰기를 다르게 해보세요.</span></p>');
            }
        }else{
            $("#_listProduct").html('<p class="info t_c" style="font-weight:300;font-size: 28px;line-height: 1.3em;background: url(http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/search/ico_noresult01.png) center 20px no-repeat;background-size: 66px;padding: 110px 0 30px;color: #555555;letter-spacing: -1px;">검색어와 일치하는<br><span style="color: #da2128;">내용</span>이 없습니다.<br><span style="display: block;font-size: 12px;text-align: left;width: 200px;margin: 15px auto;font-weight:normal;line-height: 1.75em;">- 단어의 철자를 다시 확인해 주세요.<br>- 단어의 절차나 띄어쓰기를 다르게 해보세요.</span></p>');
        }
    }
}

// 페이징처리
function _mkPage(){
    var hndlPage = function(page){ return function(){ _moveToPage(page); }; };
    var pgObj = document.getElementById("_listPager");
    if(pgObj){
        _removeChild(pgObj);
        var pager = _getPager(_data.pageHolder, hndlPage);
        pager.classList.add("mb30");
        pgObj.appendChild(pager);
    }
}

function _mkEtc(){
    var criteria = _data.c;
    if(_data.result){
        var result = _data.result;
        $("#_totalSize").text(price_format(result.giftSize + result.recordSize));
        $("#_giftSize").text("(" + price_format(result.giftSize) + ")");
        $("#_recordSize").text("(" + price_format(result.recordSize) + ")");
    }
    
    // 조건 처리
    if(criteria){
        if(   !_isEmpty(criteria.categoryGroup)
           || !_isEmpty(criteria.brandGroup)
           || !_isEmpty(criteria.ctgr_id_1d)
           || !_isEmpty(criteria.ctgr_id_2d)
           || criteria.freeDeliveryYn == "Y"
           || !_isEmpty(criteria.deliveryVendorId)
           || criteria.discountYn == "Y"
           || criteria.couponYn == "Y"
           || !_isEmpty(criteria.minPrice)
           || !_isEmpty(criteria.maxPrice)
          ){
            $(".btn_reset").show();
            $(".btn_filter").addClass("active");
        }else{
            $(".btn_reset").hide();
            $(".btn_filter").removeClass("active");
        }
        $("[name=searchTerm]").val(criteria.searchTerm);
        $(".tab_btn a").removeClass("active");
        $(".tab_btn a#tab" + criteria.searchMenu).addClass("active");
        
        // 품절여부
        if(criteria.saleYn != 'Y')    criteria.saleYn = "N";
        $("[name=saleYn]").val(criteria.saleYn);
        
        // 정렬순서
        $("[name=sort]").val(criteria.sort);
        
        // 상세검색
        // 혜택
        $("#choiceBnft input[type=checkbox]").each(function(){
            if(!criteria[$(this).attr("name")] || criteria[$(this).attr("name")] == 'N'){
                $(this).removeAttr("checked");
                $(this).parents(".chk_wrap").removeClass("active");
            }else{
                $(this).attr("checked", "checked");
                $(this).parents(".chk_wrap").addClass("active");
            }
        });
        
        // 브랜드체크
        if(criteria.brandGroup)    $("#selBrand").text(criteria.brandGroup);
        else                       $("#selBrand").text("");
        
        // 가격조건 수정
        $("[name=minPrice]").val(criteria.minPrice);
        $("[name=maxPrice]").val(criteria.maxPrice);
        
        $(".chk_prices").removeClass("active");
        var radioPrice;
        if(criteria.minPrice || criteria.maxPrice)    radioPrice = document.getElementById("price_" + criteria.minPrice + "_" + criteria.maxPrice);
        else                                          radioPrice = document.getElementById("price__");
        if(radioPrice)    radioPrice.classList.add("active");
    }
}
</script>
</head>
<body>
<style type="text/css">
.ns_cont { display:block;font-size: 14px;font-family: 'Noto Sans KR', AppleGothic, sans-serif; }
.ns_cont .ns_head { position:absolute;z-index:3;top:0;left:0;display:block;padding-top:env(safe-area-inset-top);width:100%; }
.ns_cont .ns_head.scroll { background: url(http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/search/bg_gradient01.png) bottom repeat-x;padding-bottom:12px; }
.ns_cont .ns_head .ns_inbox { background-color:#fff;padding-bottom:12px; }
.ns_cont .ns_head .ns_form { position: relative;width: calc(100% - 2em);top: 0;padding: .75em 1em;text-align: center;display: -webkit-box;border-bottom: 3px solid #ca0e22;margin-bottom: .25em; }
.ns_cont .ns_head .ns_form input[type=text] { display: block;-webkit-box-flex: 1;padding-right: 40px;height: 31px;border: 0;font-size: 21px;font-weight: bold; }
.ns_cont .ns_head .ns_form .txt_reset { display: none;width: 30px;height: 30px;background: url(/images/season01/btn_txt_x.png) no-repeat center center;background-size: 20px 20px;overflow: hidden;text-indent: -999px;position: absolute;top: .85em;right: 55px; }
.ns_cont .ns_head .ns_form .btn_submit { -webkit-box-flex: 1;margin-left: 1em;width: 30px;height: 30px;background: url(http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/search/ico_search02.png) no-repeat center center;background-size: 30px;overflow: hidden;text-indent: -999px; }
.ns_cont .ns_head .ns_related { display: block;white-space: nowrap;overflow-x: scroll;overflow-y: hidden;-webkit-overflow-scrolling: touch;padding:10px .75em 0;height: 35px; }
.ns_cont .ns_head .ns_related a { font-size: .9em;margin-top:1px;margin-right: 6px;height: 1em;line-height: 1em;background-color: #e2e2e2;border-radius: 1em;color: #000000;padding: .5em 1em; }
.ns_cont .ns_head .ns_option { display: block;position: relative;padding: 0 1em;font-size: 14px;line-height: 25px; }
.ns_cont .ns_head .ns_option:after { display:block;clear:both;content:' '; }
.ns_cont .ns_head .ns_option .txt_result { font-family: 'Malgun Gothic', 'Apple Gothic', 'Droid Sans','돋움','Dotum',sans-serif;display: block;float: left;text-align: center;font-size: 14px;letter-spacing: -1px; }
.ns_cont .ns_head .ns_option .btn_select { font-family: 'Malgun Gothic', 'Apple Gothic', 'Droid Sans','돋움','Dotum',sans-serif;display: block;float: right;height: 25px;line-height: 25px;background: url(http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/search/ico_arrow_down01.png) no-repeat right center;-webkit-appearance: none;background-size: 10px 6px;border: none;padding: 0 1em 0 0;border-radius: 0;margin-right: .5em;font-size: 14px;letter-spacing: -1px; }
.ns_cont .ns_head .ns_option .btn_filter { display: block;float: right;overflow: hidden;text-align: left;background: url(http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/search/ico_filter_off02.png) no-repeat 10px center;padding: 0 10px 0 30px;border-radius: 1em;line-height: 1.5em;background-size: 18px 16px;border: 1px solid #999999;position: relative;color: #000;font-family: 'Malgun Gothic', 'Apple Gothic', 'Droid Sans','돋움','Dotum',sans-serif;font-size: 13px;letter-spacing: -1px;height: 23px;line-height: 23px; }
.ns_cont .ns_head .ns_option .btn_filter em { display: none;position: absolute;width: 13px;height: 13px;background: url(http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/search/ico_check01.png) no-repeat center center;background-size: 13px;overflow: hidden;text-indent: -999px;text-align: center;left: 18px;top: 0px; }
.ns_cont .ns_head .ns_option .btn_filter.active em { display:block; }

.ns_cont .ns_head .ly_keyword { width:100%;display:none;background:url('/images/season01/bg_layer01.png');position: fixed;top: 55px;height: calc(100% - 110px);z-index:3; }
.ns_cont .ns_head .ly_keyword.active { display:block;-webkit-transform: translate3d(0,0,0); }
.ns_cont .ns_head .ly_keyword .ly_keybox { z-index:10;position:relative;background-color:#fff;overflow-y:auto; }
.ns_cont .ns_head .ly_keyword .ly_keybox .side_menu {position:relative;display:-webkit-box;width:100%;background-color:#eee;}
.ns_cont .ns_head .ly_keyword .ly_keybox .side_menu li {-webkit-box-flex: 1; text-align: center; border-right: 1px solid #dadada; margin: 10px 0; font-size: 14px; font-weight: normal; color: #2b2b2b;}
.ns_cont .ns_head .ly_keyword .ly_keybox .side_menu li.t_l { text-align:left;margin-left:10px; }
.ns_cont .ns_head .ly_keyword .ly_keybox .side_menu li:last-child { border-right:none; }
.ns_cont .ns_head .ly_keyword .ly_keybox .side_menu li a { display: block; padding: 2px 0; font-size: 14px; font-weight: normal; color: #2b2b2b; border-right: 1px solid #f2f2f2;}
.ns_cont .ns_head .ly_keyword .ly_keybox .side_menu li a.active { color:#ca0e22;font-weight:bold; }
.ns_cont .ns_head .ly_keyword .ly_keybox .srch_box02 .srch_list { padding: 10px; }
.ns_cont .ns_head .ly_keyword .ly_keybox .srch_box02 .srch_list .srch_list_item { display:none;width:170px;margin:.5em auto; }
.ns_cont .ns_head .ly_keyword .ly_keybox .srch_box02 .srch_list .srch_list_item.active { display:block; }
.ns_cont .ns_head .ly_keyword .ly_keybox .srch_box02 .srch_list .srch_list_item p { position:relative; }
.ns_cont .ns_head .ly_keyword .ly_keybox .srch_box02 .srch_list .srch_list_item p a { display: block;padding: 10px 15px 10px 15px;border-bottom: 1px solid #f2f2f2;font-size: 13px;font-weight: normal;color: #858585;color:#2b2b2b;overflow:hidden;white-space:nowrap;text-overflow:ellipsis; }
.ns_cont .ns_head .ly_keyword .ly_keybox .srch_box02 .srch_list .srch_list_item p .num { position: absolute;left: -15px;width: 20px;font-weight: bold;font-size: 1.2em;font-family: Arial;top: 12px; }
.ns_cont .ns_head .ly_keyword .ly_keybox .srch_box02 .srch_list .srch_list_item.arrow { width:200px; }
.ns_cont .ns_head .ly_keyword .ly_keybox .srch_box02 .srch_list .srch_list_item.arrow p a { padding-right:45px;background: url("http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/mobile/content/ic_arrow_none01.png") no-repeat calc(100% - 10px) center;background-size:10px 3px; }
.ns_cont .ns_head .ly_keyword .ly_keybox .srch_box02 .srch_list .srch_list_item.arrow p a.up { background: url("http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/mobile/content/ic_arrow_up01.png") no-repeat calc(100% - 10px) center;background-size:auto 13px; }
.ns_cont .ns_head .ly_keyword .ly_keybox .srch_box02 .srch_list .srch_list_item.arrow p a.down { background: url("http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/mobile/content/ic_arrow_down01.png") no-repeat calc(100% - 10px) center;background-size:auto 13px; }

.ns_cont .ns_body { position: absolute;display: block;width: 100%;top:0;padding-top: 105px;height: calc(100% - 145px);overflow-y: auto;-webkit-overflow-scrolling: touch; }
.ns_cont .ns_body:after { display:block;clear:both;content:' '; }

.ns_cont .ns_body .ns_evt .visual { position:relative;padding-bottom: 30px; }
.ns_cont .ns_body .ns_evt .visual .swiper-container { overflow:hidden;margin:0 auto 7px;}
.ns_cont .ns_body .ns_evt .visual .swiper-container .swiper-wrapper { height:auto !important; }
.ns_cont .ns_body .ns_evt .visual .swiper-container .swiper-wrapper .swiper-slide {position:relative;float:left;width:100%;text-align:center;height:auto !important; }
.ns_cont .ns_body .ns_evt .visual .swiper-container .swiper-wrapper .swiper-slide a { display:block; }
.ns_cont .ns_body .ns_evt .visual .swiper-container .swiper-wrapper .swiper-slide img { width:100%;max-height:181px; }
.ns_cont .ns_body .ns_evt .visual .swiper-container .swiper-wrapper .swiper-slide .tit {padding-top:12px;white-space:nowrap;width:100%;overflow:hidden;text-overflow:ellipsis;display:inline-block;font-size:1.2em;color:#010101}
.ns_cont .ns_body .ns_evt .visual .swiper-container .swiper-wrapper .swiper-slide .txt {padding-top:6px;white-space:nowrap;width:100%;overflow:hidden;text-overflow:ellipsis;display:inline-block;font-size:1em;color:#6a6a6a;height:14px;line-height:14px;}
.ns_cont .ns_body .ns_evt .visual .pagination {  text-align: center;position: relative;width: 100%;margin-top:1.5em; }
.ns_cont .ns_body .ns_evt .visual .pagination .swiper-pagination-switch {display:inline-block;width:10px;height:10px;overflow:hidden;margin:0 3px;background:url('http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/search/ico_dot_off01.png') no-repeat;background-size:contain;}
.ns_cont .ns_body .ns_evt .visual .pagination .swiper-active-switch {background:url('http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/search/ico_dot_on01.png') no-repeat;background-size:contain;}

.ns_cont .ns_body .tab_btn { border-bottom: 3px solid #000; }
.ns_cont .ns_body .tab_btn:after { display:block;clear:both;content:' '; }
.ns_cont .ns_body .tab_btn li { float: left;display: block;width: 50%; }
.ns_cont .ns_body .tab_btn li a { display: block;background-color: #e2e2e2;color: #989898;text-align: center;line-height: 3.5em; }
.ns_cont .ns_body .tab_btn li a.active { background-color: #000;color: #fff; }

.ns_cont .ns_foot { position:absolute;bottom:0;z-index:2;height:55px;padding-bottom:env(safe-area-inset-bottom);width:100%;background-color:#f1f2f3; }
.ns_cont .ns_foot .my_quick_box { padding:0 10px;height:55px;display:-webkit-box; }
.ns_cont .ns_foot .my_quick_box a { -webkit-box-flex:1;display:block;text-align:center; width : 50px;padding-top:5px;letter-spacing:-1px; }
.ns_cont .ns_foot .my_quick_box a .txt { display:none; }
.ns_cont .ns_foot .my_quick_box .ic_quick { background-size:32px;background-repeat:no-repeat;background-position:center center;padding-top:0;position:relative; }
.ns_cont .ns_foot .my_quick_box .ic_quick .alt_cnt { position: absolute;text-align: center;border: 1px solid #f00;display: block;left:calc(50% + 7px);border-radius: 50%;background-color: #f00;color: white;font-weight: bold;width: 18px;height: 18px;line-height: 18px;font-size: 10px;font-family: Arial;top:2px; }
.ns_cont .ns_foot .my_quick_box .ic_home { background-image:url('http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/mobile/quick/ic_home_off02.png'); }
.ns_cont .ns_foot .my_quick_box .ic_coupon { background-image:url('http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/mobile/quick/ic_coupon_off02.png'); }
.ns_cont .ns_foot .my_quick_box .ic_myroom { background-image:url('http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/mobile/quick/ic_myroom_off02.png'); }
.ns_cont .ns_foot .my_quick_box .ic_delivery { background-image:url('http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/mobile/quick/ic_delivery_off02.png'); }
.ns_cont .ns_foot .my_quick_box .ic_category { background: url(http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/mobile/quick/ic_category_off02.png) center 13px no-repeat;background-size: 21px 16px; }
.ns_cont .ns_foot .my_quick_box .ic_search { background-image:url('http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/mobile/quick/ic_search_off02.png'); }
.ns_cont .ns_foot .my_quick_box .ic_cart { background-image:url('http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/mobile/quick/ic_cart_off02.png'); }
.ns_cont .ns_foot .my_quick_box .ic_event { background-image:url('http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/mobile/quick/ic_event_off02.png'); }

/* 레코벨 상품 추천 */
.pbest_list {position:relative; background-color:#fff;}
.pbest_list .tit_prods {margin-left: 20px;text-align: left;font-size: 18px;color: #000;font-weight: bold;z-index: 2;}
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
<div class="ns_cont">
<div class="ns_head">
    <div class="ns_inbox">
    <form name="searchedForm" method="post" action="/m/search/searchMain">
        <legend>검색결과</legend>
        <div class="ns_form">
            <input type="text" name="searchTerm" placeholder="검색어 입력" title="검색어 입력" autocomplete="off"/>
            <a href="#" class="txt_reset" onclick="_clearTerm();return false;"><span>초기화</span></a>
            <a href="#" class="btn_submit" onclick="_search();return false;"><span>검색</span></a>
        </div>
    </form>
    <div class="ns_related" id="_listLinked"></div>
    <div class="ns_option">
        <span class="txt_result">검색결과  <strong class="col_red" id="_totalSize">0</strong>건</span>
        <a href="#" onclick="openFilter();return false;" class="btn_filter"><em>check</em>필터</a>
        <select name="sort" class="btn_select">
            <option value="ODC">인기상품순</option>
            <option value="DAT">신상품순</option>
            <option value="LOP">낮은가격순</option>
            <option value="HIP">높은가격순</option>
            <option value="DCR">할인율순</option>
            <option value="LIK">좋아요♥</option>
            <option value="RVW">상품평</option>
        </select>
        <select name="saleYn" class="btn_select">
            <option value="N">품절포함</option>
            <option value="Y">품절제외</option>
        </select>
    </div>
    <div id="layer-search" class="ly_keyword">
        <div class="ly_keybox">
            <div class="srch_box02">
                <ul class="side_menu">
                    <li><a href="#" onclick="return false;" class="active">인기 검색어</a></li>
                    <li><a href="#" onclick="return false;">추천 검색어</a></li>
                </ul>
                <div class="srch_list">
                    <div class="srch_list_item popular arrow active">
                        <c:forEach items="${listKeywordBest}" var="l" varStatus="st">
                            <p><a href="#" onclick="_search('${l.keyword}');return false;" class="<c:if test="${l.prevRank eq 0 || l.prevRank > l.ranking}"> up</c:if><c:if test="${l.prevRank ne 0 && l.prevRank < l.ranking}"> down</c:if>"><em class="num">${st.count}</em>${l.keyword}</a></p>
                        </c:forEach>
                    </div>
                    <div class="srch_list_item recomend">
                        <c:forEach items="${listKeywordPick}" var="l" varStatus="st">
                            <p><a href="#" onclick="_search('${l.keyword}');return false"><em class="num">${st.count}</em>${l.keyword}</a></p>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </div>
</div>

<div class="ns_body">
   	<!-- 레코벨 상품 추천 -->
	<section id="_listRecobell" class="pbest_list"></section>
	<!-- 레코벨 상품 추천  -->
    <div id="listEvent" class="ns_evt"></div>
    <ul class="tab_btn">
        <li><a href="#" id="tabGIFT" onclick="_tglSearchMenu('GIFT');return false;">기프트 <em id="_giftSize">(0)</em></a></li>
        <li><a href="#" id="tabRECORD" onclick="_tglSearchMenu('RECORD');return false;">음반/DVD/블루레이 <em id="_recordSize">(0)</em></a></li>
    </ul>
    <div class="prod_box" id="_listProduct"></div>
    <div id="_listPager"></div>
</div>
<div class="ns_foot">
    <div class="my_quick_box">
        <a href="#" class="ic_home ic_quick" onclick="location.href='/m/welcomeMain';return false;"><span class="txt">홈</span></a>
        <a href="#" class="ic_myroom ic_quick" onclick="location.href='/m/mypage/main';return false;"><span class="txt">마이룸</span></a>
        <a href="#" class="ic_delivery ic_quick" onclick="location.href='/m/mypage/orderDelivery';return false;"><span class="txt">주문배송</span></a>
        <a href="#" class="ic_cart ic_quick" onclick="location.href='/m/order/cart';return false;"><span class="txt">주문배송</span></a>
        <a href="#" class="ic_coupon ic_quick" onclick="location.href='/m/mypage/coupon';return false;"><span class="txt">쿠폰</span></a>
    </div>
</div>
</div>

<!-- .searchFilter -->
<div class="layer_lbox" id="searchFilter">
    <div class="gbn_box">
        <h4>필터</h4>
        <div class="optn_box01">
            <a href="#" class="chk_dlvy" onclick="_tglBenefit(this, 'deliveryVendorId', '0625');return false;">핫트랙스배송</a>
        </div>
        <div class="optn_box01">
            <a href="#" onclick="tglLayer(this, '#choiceBnft');return false;" class="tit active">혜택</a>
            <div class="layer_cont1 chk_area" id="choiceBnft" style="display:block;">
                <p class="chk_wrap"><input type="checkbox" name="freeDeliveryYn" id="chkFreeDlvyYn" value="Y" title="무료배송"/><label for="chkFreeDlvyYn">무료배송</label></p>
                <p class="chk_wrap"><input type="checkbox" name="discountYn" id="chkDiscountYn" value="Y" title="할인"/><label for="chkDiscountYn">할인</label></p>
                <p class="chk_wrap"><input type="checkbox" name="couponYn" id="chkCouponYn" value="Y" title="쿠폰"/><label for="chkCouponYn">쿠폰</label></p>
            </div>
        </div>
        <div class="optn_box01" id="optnCtgr">
            <a href="#" onclick="tglLayer(this, '#choiceCtgr');return false;" class="tit">카테고리</a>
            <span id="selCtgr" class="optn_hint01"></span>
            <div class="layer_cont1 chk_area" id="choiceCtgr"></div>
        </div>
        <div class="optn_box01" id="optnBrand">
            <a href="#" onclick="tglLayer(this, '#choiceBrand');return false;" class="tit">브랜드</a>
            <span id="selBrand" class="optn_hint01"></span>
            <div class="layer_cont1 chk_area" id="choiceBrand"></div>
        </div>
        <div class="optn_box01">
            <a href="#" onclick="tglLayer(this, '#choicePrce');return false;" class="tit">가격대</a>
            <div class="layer_cont1" id="choicePrce">
                <div id="_priceRange"></div>
                <div class="num_area t_c">
                    <input type="number" name="minPrice" class="i_input" placeHolder="최저가"/>
                    ~
                    <input type="number" name="maxPrice" class="i_input" placeHolder="최고가"/>
                </div>
            </div>
        </div>
        <div class="optn_box02">
            <p class="tit2">결과 내 재검색</p>
            <div class="s_in_searchTerm">
                <input type="text" name="plusKeywords"/>
                <a href="#" class="btn_search" onclick="_addKeywords();return false;">검색</a>
            </div>
        </div>
        <a href="#" onclick="_reset();return false;" class="btn_reset">초기화</a>
    </div>
</div>
<!-- //#searchFilter -->
</body>
</html>