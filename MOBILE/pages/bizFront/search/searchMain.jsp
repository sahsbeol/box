<%@ page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<html>
<head>
	<!-- 태그 라이브러리 -->
	<%@ include file="/pages/decorators/biz/tagHeader.jsp" %>
	<!-- 데코레이터 메뉴,푸터 없음 -->
	<ui:decorator name="bizSimpleHot"/>	
	
<!-- 레코벨 스크립트 -->
<script type="text/javascript">
$(window).load(function() {
	var userId= getCookie("UserCookieKey");

	window._eglqueue = window._eglqueue || [];
	_eglqueue.push(['setVar','cuid','e15e978e-3623-4892-bf0a-485b9f8196ee']);
	_eglqueue.push(['setVar','userId',SHA256(userId)]); // optional
	_eglqueue.push(['setVar','searchTerm','${c.searchTerm}']);
	_eglqueue.push(['track','search']);
	(function(s,x){s=document.createElement('script');s.type='text/javascript';
	s.async=true;s.defer=true;s.src=(('https:'==document.location.protocol)?'https':'http')+'://logger.eigene.io/js/logger.min.js';
	x=document.getElementsByTagName('script')[0];x.parentNode.insertBefore(s, x);})();
});
</script>

<!-- 레코벨 스크립트 끝 -->

<script type="text/javascript">
var filter = false;
var swiper2;
var recobellSwiper;
var _data;
var _cond = {
    listSize:"${c.listSize}"
  , searchMenu:"${c.searchMenu}"
  , categoryGroup:"${c.categoryGroup}"
  , brandGroup:"${c.brandGroup}"
  , ctgr_id:"${c.ctgr_id}"
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

var adultGbn = '${c.adultGbn}';

window.onpopstate = function(e) {
//	console.log(e.state);
	if(e.state){
        _cond = e.state;
        _searchProduct(false, true);
    }else{
        history.back();
    }
};

jQuery(function($){
    $(document).ready(function(){
			categoryFn(); //category
			searchFn(); //search
        $("[type=checkbox]").change(function(){
            if($(this).is(":checked"))    $(this).parents(".chk_wrap").addClass("active");
            else                          $(this).parents(".chk_wrap").removeClass("active");
        });
     
			$(document).on("touchend","#parkmin",function() {
			    replaceBtn($('#parkmin').attr("code"));
			});
			
			
        $("#soldout_check").click(function(){
           	if($("#soldout_check").hasClass("active")){
           		$("#soldout_check").removeClass("active");
           		$("#soldout_check").prop("checked", false);
           		_reSearch("saleYn", 'N');
           		location.reload();
           	}else{
           		$("#soldout_check").addClass("active");
           		$("#soldout_check").prop("checked", true);
           		_reSearch("saleYn", 'Y');
           		location.reload();
           	}
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
    
    
    $("[name=searchTerm]").keypress(function(e) {
        if (e.which == 13) {
            e.preventDefault();
            if ($(this).val().replace(/^\s\s*/, '').replace(/\s\s*$/, '') == "") {
            	alert("검색어를 입력해주세요");
        		$('[name=searchTerm]').val("");
        	    $("[name=searchTerm]").focus();
        	    return false;
			} else {
	            location.href="/m/biz/search/searchMain?searchTerm="+$(this).val();
			}
        }
    });
    
    $("[name=searchTerm]").change(function() {
        _cond.searchTerm = $(this).val();
    });
    
    $("input[name=sort]").change(function(){
        _reSearch("sort", $(this).val());
        layer_close();
    });
    $("select[name=sort]").change(function(){
        _reSearch("sort", $(this).val());
        layer_close();
    });
    $("[name=saleYn]").change(function(){
        _reSearch("saleYn", $(this).val());
        layer_close();
    });
    $("#choiceBnft input[type=checkbox]").click(function(){
    	if( $(this).parents(".form_checkbox").hasClass("checked") && $(this).attr("name") != 'saleYn' ){
    		_reSearch($(this).attr("name"), "");
    	} else {
    		_reSearch($(this).attr("name"), $(this).val());
    	} 
    });
    
    $("[name=minPrice],[name=maxPrice]").focus(function(){
        $("#searchFilter .gbn_box").animate({scrollTop:$(document).height()});
    });
    
    $("#price_btn").click(function(){
        _cond['minPrice'] = $('[name=minPrice]').val();
        _cond['maxPrice'] = $('[name=maxPrice]').val();
        
        _reSearch();
    });
    
    /* $("[name=minPrice],[name=maxPrice]").change(function(){
        _reSearch($(this).attr("name"), $(this).val());
    }); */
    
    $("#price_btn").click(function(){
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
    $(".keyword_list ul li a").click(function(){
        _search($(this).attr("title"));
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
	if($("[name=plusKeywords]").val() == ""){
		alert("검색어를 입력해주세요");
	    $("[name=plusKeywords]").focus();
	    return false;
	}
    _reSearch("plusKeywords", $("[name=plusKeywords]").val());
    
    $('body').removeClass('fixed').off('touchmove');
    TweenLite.to($('#search_detail'),0.7,{ease:Power4.easeOut,left:'100%'})
    TweenLite.to($('#wrap .search_dim'),0.3,{ease:Power4.easeOut,opacity:0,onComplete:function(){
        $('#wrap .search_dim').remove();
    }})
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
function _searchBtn(){
	if($('[name=searchTerm]').val().replace(/^\s\s*/, '').replace(/\s\s*$/, '') == ""){
		alert("검색어를 입력해주세요");
		$('[name=searchTerm]').val("");
	    $("[name=searchTerm]").focus();
	    return false;
	}else{
		location.href="/m/biz/search/searchMain?searchTerm="+$('[name=searchTerm]').val();
	}
}
function _searchKeyword(keyword){
	location.href="/m/biz/search/searchMain?searchTerm="+keyword;
}
// 단순 검색
function _search(searchTerm){
    if(searchTerm){
        _cond.searchTerm = searchTerm;
        $("[name=searchTerm]").val(searchTerm);
    }
    
    if($.trim(_cond.searchTerm).replace(/^\s\s*/, '').replace(/\s\s*$/, '') == ""){
        alert("검색어를 입력해주세요");
        $("[name=searchTerm]").focus();
        return false;
    }
    _cond = { searchMenu:_cond["searchMenu"], viewType:_cond["viewType"], searchTerm:_cond["searchTerm"], page:"1" };
    _searchProduct(false, false);
	$.ajax({
	    type: "POST"
	   ,url: "/m/biz/bizSearchTemplate"
	   ,data: {searchTerm : $("[name=searchTerm]").val() , searchMenu : _cond["searchMenu"]}
	   ,dataType: "html"
	   ,success : function(htmlStr){
			//실시간 인기&베스트
			$(".cont02").empty();
			$(".cont02").append(htmlStr);
	   		var listChoiceCnt = parseInt($("#listChoiceCnt").val());
	   		var listCnt = parseInt($("#listCnt").val());
			if ((listCnt+listChoiceCnt)==1) {
				$(".cont02").removeClass("case2");
				$(".cont02").removeClass("case1");
				$(".cont02").addClass("case1");
			}else{
				$(".cont02").removeClass("case1");
				$(".cont02").removeClass("case2");
				$(".cont02").addClass("case2");
				var searchSwiper03 = new Swiper('.search_view .cont02 .swiper-container', {
					slidesPerView: 'auto',
					spaceBetween: 20,
					slidesOffsetBefore: 30,
					freeMode: true,
					scrollbar: '.swiper-scrollbar',
					pagination: '.swiper-pagination',
					paginationType: 'fraction',
					draggable: true
				});
			}
	       	$("#loading").hide();
	   }
	   ,error: function(data) {
	       alert('<fmt:message key="error.common.system"/>');
	       $("#loading").hide();
	   }
	});
};

// 결과내 재검색
function _reSearch(key, value){
    if(key)    _cond[key] = value;
    if(key == "searchTerm")    $("[name=searchTerm]").val(value);
    if(key != "brandGroup")    _cond.brandGroup = "";
    if(key != "ctgr_id_1d" && key != "ctgr_id_2d" && key != "brandGroup"){
    	_cond.ctgr_id = "";
        _cond.ctgr_id_1d = "";
        _cond.ctgr_id_2d = "";
    }
    _cond.page = "1";
    _searchProduct(filter, false);
    $("#_bizListPager").empty();
    var pager = _getPager(_data.pageHolder);
    $("#_bizListPager").append(pager);
};

// 페이징처리
function _moveToPage(page){
    if(page)    _cond.page = page;
    else        _cond.page = "1";
    _searchProduct(true, false);
};
//카테고리토글
function _tglSearchMenu(value){
    if('RECORD' == value){
    	$('#brandArea').hide();
    }else{
    	$('#brandArea').show();
    }
    $("[name='brandOption']").prop("checked", false);
    _reSearch("searchMenu", value);
}

// 카테고리토글
function _tglCtgrId(ctgrId){
	filter = false;
    _cond.brandGroup = "";
    if(ctgrId == "0003" || (ctgrId.substring(0, 4) != "0003" && ctgrId.length == 6)){
        // 1뎁스 토글
        if(_cond.ctgr_id_1d != ctgrId){
			_cond.ctgr_id_1d = ctgrId;
			_cond.ctgr_id = ctgrId;
       	} else {
			_cond.ctgr_id_1d = "";
			_cond.ctgr_id = "";
		}
        
        _cond.ctgr_id_2d = "";
        
        _reSearch("ctgr_id_1d", _cond.ctgr_id_1d);
    }else{
        // 2뎁스 토글
		var ctgr_id2 = new Array();
		$(".dp3 [type=checkbox]:checked").each(function(){
			if ($(this).attr("name") != ctgrId) {
				ctgr_id2.push($(this).attr("name"));
			}
		});
		if ($("[name="+ctgrId+"]").is(":checked")) {
       	 	_cond.ctgr_id_2d = ctgr_id2.join(",").toString();
		}else{
       	 	_cond.ctgr_id_2d = ctgr_id2.join(",").toString()==""?ctgrId:ctgr_id2.join(",").toString()+","+ctgrId;			
		}
		_cond.ctgr_id = _cond.ctgr_id_1d;
        _reSearch("ctgr_id_2d", _cond.ctgr_id_2d);
    }
}

// 브랜드토글
function _tglBrand(obj, brandName){
    var brandArr = new Array();	
    _cond.brandGroup = "";
    
    if($(obj).find("[name='brandOption']").is(":checked")){
    	$(obj).find("[name='brandOption']").prop("checked", false);
    }else{
	    $(obj).find("[name='brandOption']").prop("checked", true);
    }
    
    $("[name='brandOption']").each(function(){
    	if($(this).is(":checked")){
	    	brandArr.push($(this).attr("brandName"));
    	}
    });
    
    _cond.brandGroup = brandArr.join(",");
    _reSearch("brandGroup", _cond.brandGroup);
}

function _cateMake(obj){
    	_tglCtgrId(obj.attributes[2].value);
};

function _searchProduct(filterYn, skipHist){
    _cond.filterYn = filterYn;
    $.ajax({
        url:"/m/biz/search/ajaxSearchProduct"
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
                
                
                if(!filterYn){
	                // STEP05: 브랜드처리
	                _mkBrand();
                    // STEP02: 연관검색어
                    _mkLinked();
                    
                    // STEP06: 가격처리
                    _mkPrice();
                }
                
                // STEP03: 이벤트처리
                _mkEvent();
                
                // STEP07: 상품로드
                //_mkProduct();
                
                // STEP08: 기타조건처리
                _mkEtc();
                
                if(_data.c && history.pushState && !skipHist){
                     var state = _cond;
                     var title = '검색결과 - NEW ME HOTTRACKS';
                     var url = '/m/biz/search/searchMain' + _data.c.query;
                     history.pushState(state, title, url);
                }
                
                $("#_bizListPager").empty();
                var pager = _getPager(_data.pageHolder);
                $("#_bizListPager").append(pager);
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
    filter = true;
}

//상품처리
function _mkRecobell(){
    // 상품 로드
    if(_data && _data.result && _data.result.listRecobell && _data.result.listRecobell.length >= 3){
        var listRecobell = _data.result.listRecobell;
    	var strHtml = '';
        var size = 0;
        var listLen = 0;
    	
        if(_data.result.listRecobell.length >= 20){
        	listLen = 20;
        }else{
        	listLen = _data.result.listRecobell.length;
        }

        for(var i = 0; i < listLen; i++){
        	var recobell = listRecobell[i];
        	 strHtml += '<div class="swiper-slide">';
             strHtml += '<a href="/p/'+recobell.sellPrdtBcode+'?foo=bar&rccode=mo_search1">';
             strHtml += '<div class="thum">';
     		if(recobell.sellPrdtGbn == "R")         strHtml += '<img src="' + _imgRecordUrl(recobell.rcrdCd, "R", "midi", (recobell.rtngCode == "C0845" && adultGbn != "Y"?"Y":"N"), "N") + '" alt="' + recobell.prdtName + '"/>';
            else if(recobell.sellPrdtGbn == "D")    strHtml += '<img src="' + _imgRecordUrl(recobell.rcrdCd, "D", "midi", (recobell.rtngCode == "C0845" && adultGbn != "Y"?"Y":"N"), "N") + '" alt="' + recobell.prdtName + '" style="width:77px;"/>';
            else                                    strHtml += '<img src="' + (recobell.nyoSellBanYn == "Y" && adultGbn != "Y"? 'http://image.kyobobook.co.kr/newimages//giftshop_new/common/images/music/img_19product.jpg':_imgUrl(recobell.productImageUrl, "product", "400")) + '" alt="' + recobell.prdtName + '"/>';
             strHtml += '</div>';
             strHtml += '<div class="desc">';
             strHtml += '<p class="tit">'+recobell.prdtName+'</p>';
             strHtml += '<p class="price font_t">'+price_format(recobell.lastCpnPrice);
             if(recobell.prdtSellPrice != recobell.lastCpnPrice){
            	 strHtml += '<span class="percent">' + Math.floor((recobell.prdtSellPrice - recobell.lastCpnPrice) / recobell.prdtSellPrice * 100) + '%</span>';
             }
             strHtml += '</p>';
             strHtml += '</div>';
             strHtml += '</a>';
             strHtml += '</div>';
             strHtml += '</div>';
        }

       	$("#_listRecobell").html(strHtml);
       	$("#_listRecobell").show();
    	recobellSwiper = new Swiper('.search_view .cont01 .swiper-container', {
    		slidesPerView: 'auto',
    		spaceBetween: 8,
    		slidesOffsetBefore: 30,
    		freeModeMomentumBounce: false,
    		freeMode: true
    	});
    }else{
    	$(".cont01").hide();
    }
}

// 연관검색어
function _mkLinked(){
    if(_data && _data.result && _data.result.listLinked && _data.result.listLinked.length > 0){
        var listLinked = _data.result.listLinked;
        var baseTerm = '${c.searchTerm}';
        
        var strHtml = '';
        for(var i = 0;i < listLinked.length; i++){
            var linked = listLinked[i];
            if(linked != baseTerm){
	            strHtml += '<div class="swiper-slide"><a href="javascript:" onclick="_search(\'' + linked + '\');return false;">' + linked + '</a></div>';
            }
        }
        $("#_listLinked").html(strHtml).show().scrollLeft(0);
    	var searchTagSwiper = new Swiper('.search_view .top_tag .swiper-container', {
    		slidesPerView: 'auto',
    		spaceBetween: 10,
    		slidesOffsetBefore: 30,
    		slidesOffsetAfter: 30,
    		freeMode: true
        });
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
            	if(_data.c.ctgr_id_1d == cate01.ctgrId){
            		strHtml += '<li class="active">';
            	}else{
    	        	strHtml += '<li>';
            	}
        		strHtml += '<a href="javascript:" class="btn_dp2" ctgrId="' + cate01.ctgrId + '" onclick="_cateMake(this);return false;">' + cate01.ctgrName + '</a>';
        		if(_data.c.ctgr_id_1d == cate01.ctgrId){
	        		strHtml += '<div class="dp3" id="choiceCtgr' + cate01.ctgrId + '" style="display:block;">';
            	}else{
	        		strHtml += '<div class="dp3" id="choiceCtgr' + cate01.ctgrId + '" >';
            	}
        		strHtml += '<ul>';
        		for(var j = 0;j < cate01.listChild.length; j++){
        			var cate02 = cate01.listChild[j];
    	    		strHtml += '<li>';
    	    		strHtml += '<a href="#' + cate02.ctgrId + '" onclick="_tglCtgrId(\'' + cate02.ctgrId + '\');return false;">';
    	    		strHtml += '<label class="form_checkbox">';
    	    		
    	    		if(cate02.checked) {
    	    			strHtml += '<input name="' + cate02.ctgrId + '" type="checkbox" checked>';
    	    		} else {
    	    			strHtml += '<input name="' + cate02.ctgrId + '" type="checkbox">';
    	    		}
    	    		strHtml += '<span class="icon"></span>' + cate02.ctgrName;	
    	    		strHtml += '</label>';
    	    		strHtml += '</a>';
    	    		strHtml += '</li>';
        		}
        		strHtml += '</ul>';
        		strHtml += '</div>';
        		strHtml += '</li>';
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
				strHtml +='<li>';
				strHtml += '<a href="javascript:' + brand.brandName + '" onclick="_tglBrand(this);return false;">';
				strHtml += '<label class="form_checkbox">';
                if(_isEmpty(_data.c.brandGroup) || $.inArray(brand.brandName, _data.c.brandGroup.split(",")) <  0){
                    strHtml += '<input type="checkbox" name="brandOption" brandName="'+brand.brandName+'">';
                }else{
					strHtml += '<input type="checkbox" name="brandOption" brandName="'+brand.brandName+'" checked>';
                }
				strHtml += '<span class="icon"></span>' + brand.brandName + '';												
				strHtml += '</label>';
				strHtml += '</a>';
				strHtml += '</li>';
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
        strHtml +='<li>';
		strHtml += '<a href="javascript:" onclick="setSrchPrice(\'\', \'\');return false;">';
		strHtml += '<label class="form_radio">';
		strHtml += '<input type="radio" name="chk_prices">';
		strHtml += '<span id="price__">전체</span>';
		strHtml += '</label>';
		strHtml += '</a>';
		strHtml +='</li>';
		for(var i = 0; i < priceRange.length; i++){
			var price = priceRange[i];
			strHtml +='<li>';
			strHtml += '<a href="javascript:" onclick="setSrchPrice(\'' + price.MIN + '\', \'' + price.MAX + '\');return false;">';
			strHtml += '<label class="form_radio">';
			strHtml += '<input type="radio" name="chk_prices">';
			strHtml += '<span id="price_' + price.MIN + '_' + price.MAX + '">' + price.TXT + '</span>'
			strHtml += '</label>';
			strHtml += '</a>';
			strHtml +='</li>';
        }
        $("#_priceRange").html(strHtml);
    }else{
    	$("#_priceRange").html("");
    }
}

// 상품처리
function _mkProduct(){
    // 상품 로드
    if(_data && _data.result && _data.result.listProduct && _data.result.listProduct.length > 0){
        var listProduct = _data.result.listProduct;
        var bizListWish = _data.bizListWish;
        var strHtml = '';
        	strHtml += '<ul>';
        for(var i = 0; i < listProduct.length;i++){
        	var product = listProduct[i];
        	var wishUserCount = bizListWish[i].wishUserCount;
            var nyoSellBanYn = bizListWish[i].nyoSellBanYn;
        	var impYn = bizListWish[i].impYn;
        	var hasPosterCaseYn = bizListWish[i].hasPosterCaseYn;
        	var rcrdStat = bizListWish[i].rcrdStat;
        	var rlseDt = bizListWish[i].rlseDt;
        	if(product.saleYn == 'Y'){
        		strHtml += '<li>';
        	}else{
        		strHtml += '<li class="sold_out">';       		
        	}
        	
        	if(product.saleYn == 'N' && !(product.ctgrId.substring(0, 4) == "0003" || product.ctgrId.substring(0, 4) == "0004")){
        		strHtml += '<a href="#none">';
        	}else{
        		strHtml += '<a href="/p/' + product.sellPrdtBcode + '">';
        	}
        	
        	strHtml += '<div class="thum">';
        	// 7개 이상일때 후 로딩 처리
            if(product.ctgrId){
                if(product.ctgrId.substring(0, 4) == "0003")         strHtml += '<img src="' + _imgRecordUrl(product.rcrdCd, "R", "midi", (product.rtngCode == "C0845" && adultGbn != "Y"?"Y":"N"), "N") + '" alt="' + product.prdtName + '"/>';
                else if(product.ctgrId.substring(0, 4) == "0004")    strHtml += '<img src="' + _imgRecordUrl(product.rcrdCd, "D", "midi", (product.rtngCode == "C0845" && adultGbn != "Y"?"Y":"N"), "N") + '" alt="' + product.prdtName + '"/>';
                    else                                                 strHtml += '<img src="' + (nyoSellBanYn == "Y" && adultGbn != "Y"? 'http://image.kyobobook.co.kr/newimages//giftshop_new/common/images/music/img_19product.jpg':_imgUrl(product.prdtImgUrl, "product", "400")) + '" alt="' + product.prdtName + '"/>';
            }else{
                strHtml += '<img src="' + (nyoSellBanYn == "Y" && adultGbn != "Y"? 'http://image.kyobobook.co.kr/newimages//giftshop_new/common/images/music/img_19product.jpg': _imgUrl(product.prdtImgUrl, "product", "400")) + '" alt="' + product.prdtName + '"/>';
            }
        	
            if(product.saleYn != 'Y'){
        		strHtml += '	<div class="soldout-wrap">';
        		strHtml += '		<div class="absol-center">';
        		strHtml += '			<p>'+'아쉽지만!'+'</p>';
        		strHtml += '			<p><b></b>'+'이에요'+'</p>';
        		if(!(product.ctgrId.substring(0, 4) == "0003" || product.ctgrId.substring(0, 4) == "0004")){
	        		strHtml += '			<button type="button" class="replace-stuff-btn" onclick="replaceBtn('+product.sellPrdtBcode+');return false;">대체상품</button>';
        		}
        		strHtml += '		</div>';
        		strHtml += ' 	</div>';
        	}
        	
        	strHtml += '</div>';
        	strHtml += '</a>';
        	if (wishUserCount == '1') {
        		strHtml += '<a href="javascript:" onclick="addBizWishProduct(this);return false;" class="btn_like active" prdtId="'+product.sellPrdtBcode+'"><span>좋아요</span></a>';
			} else {
				strHtml += '<a href="javascript:" onclick="addBizWishProduct(this);return false;" class="btn_like" prdtId="'+product.sellPrdtBcode+'"><span>좋아요</span></a>';
			}
        	strHtml += '<a href="/p/' + product.sellPrdtBcode + '">';
        	strHtml += '<div class="cont">';
            if(product.ctgrId){
                if(product.ctgrId.substring(0, 4) == "0003" || product.ctgrId.substring(0, 4) == "0004"){
                    strHtml += '<p class="brand">' + product.artiName + '</p>';
                }else{
                    strHtml += '<p class="brand">' + product.brandName + '</p>';
                }
            }else{
                strHtml += '<p class="brand">' + product.brandName + '</p>';
            }
            strHtml += '<p class="tit">' + product.prdtName + '</p>';
        	strHtml += '<p class="price font_t">';
        	if(product.prdtSellPrice != product.prdtDscntPrice)    strHtml += ' <span class="percent">' + Math.floor((product.prdtSellPrice - product.prdtDscntPrice) / product.prdtSellPrice * 100) + '%</span>';
        	strHtml += ' <span>' + price_format(product.prdtDscntPrice) + '</span>';
        	if(product.prdtSellPrice != product.prdtDscntPrice)    strHtml += ' <span class="discount">' + price_format(product.prdtSellPrice) + '</span>';
        	strHtml += '</p>';
        	strHtml += '<div class="info">';
            if(product.reviewCount > 999)      strHtml += '<span class="reply">999+</span>';
            else if(product.reviewCount >= 0)  strHtml += '<span class="reply">' + product.reviewCount + '</span>';
            if(product.wishCount > 999)        strHtml += '<span class="like">999+</span>';
            else if(product.wishCount >= 0)    strHtml += '<span class="like" code="'+product.sellPrdtBcode+'">' + product.wishCount + '</span>';
        	strHtml += '</div>';
        	strHtml += '<div class="badge">';
        	if(product.saleYn != 'Y')          strHtml += ' <span class="badge03">품절</span>';
            if(hasPosterCaseYn == 'Y')         strHtml += ' <span class="badge01">포스터</span>';
            if(product.cpnYn == 'Y')           strHtml += ' <span class="badge01">쿠폰</span>';
            if(impYn == 'Y')                   strHtml += ' <span class="badge02">수입</span>';
            if(rcrdStat == '9')                strHtml += ' <span class="badge02">예약</span>';
            if(product.dlvyVndrId == '0625')   strHtml += ' <span class="badge02">핫트랙스배송</span>';
            if(product.freeDlvyYn == 'Y')      strHtml += ' <span class="badge02">무료배송</span>';
            if(product.freeGiftYn == 'Y')      strHtml += ' <span class="badge02">사은품</span>';
        	strHtml += '</div>';
        	strHtml += '</div>';
        	if(rcrdStat == '9')                strHtml += ' <p class="date">발매일 <em class="font_t">'+rlseDt.substring(4, 6)+'월'+rlseDt.substring(6, 8)+'일'+'</em></p>';
        	strHtml += '</a>';
        	strHtml += '</li>';
        	}
       	strHtml += '</ul>';
        $("#_listProduct").html(strHtml);
    }else{
    	$("#_listProduct").html("");
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
        $(".search_tab ul li").removeClass("active");
        $(".search_tab ul li#tab" + criteria.searchMenu).addClass("active");
        
        // 품절여부
        if(criteria.saleYn != 'Y'){
			criteria.saleYn = "N";
			$("[name=saleYn]").attr("checked","checked");
        }
        
        // 정렬순서
        $("input[name=sort]").each(function(){
        	if ($(this).val()==criteria.sort) {
        		$(this).prop("checked",true);
        		$("#orderByTitle").text($(this).parents(".form_radio").find("span").text());
			} else {
				$(this).prop("checked",false);
			}
        });
        $("select[name=sort]").val(criteria.sort);
        // 상세검색
        // 혜택
        var bnfStr = "";
        $("#choiceBnft input[type=checkbox]").each(function(){
//         	console.log($(this).attr("name")+" , "+$(this).attr("value"));
//         	console.log(criteria[$(this).attr("name")]);
            if( criteria[$(this).attr("name")] == "" || criteria[$(this).attr("name")] == 'N' || criteria[$(this).attr("name")] == null ){
               	if( $(this).attr("name") == 'saleYn' && $(this).attr("value") == 'N'){
               		if (bnfStr == "") bnfStr += $(this).parents(".form_checkbox").find("p").text();	
					else bnfStr += ","+$(this).parents(".form_checkbox").find("p").text();
               		$(this).parents(".form_checkbox").addClass("checked");
	                $(this).prop("checked", true);
               	}else{
               		$(this).parents(".form_checkbox").removeClass("checked");
               		$(this).prop("checked",false);
               	}
            }else{
            	if($(this).attr("name") == 'saleYn'&&$(this).attr("value") != 'Y'){
            		$(this).parents(".form_checkbox").removeClass("checked");
            		$(this).prop("checked",false);
            	}else{
            		if (bnfStr == "") bnfStr += $(this).parents(".form_checkbox").find("p").text();	
					else bnfStr += ","+$(this).parents(".form_checkbox").find("p").text();
            		$(this).parents(".form_checkbox").addClass("checked");
	                $(this).prop("checked", true);
            	}
            }
        });
        
        $("#benTitle").text(bnfStr);
        if (criteria.ctgr_id_2d && criteria.ctgr_id_2d.length == 6){
        	$("#cateTitle").text($("input[name="+criteria.ctgr_id_2d+"]").parents(".form_checkbox").text());
        } else if (criteria.ctgr_id_1d){
        	$("#cateTitle").text($("[ctgrId="+criteria.ctgr_id_1d+"]")[0].innerText);
        } else {
        	$("#cateTitle").text("");
       	}
        // 브랜드체크
        if(criteria.brandGroup)    $("#brandTitle").text(criteria.brandGroup);
        else                       $("#brandTitle").text("");
        
        // 가격조건 수정
        $("[name=minPrice]").val(criteria.minPrice);
        $("[name=maxPrice]").val(criteria.maxPrice);

        if ( criteria.minPrice && criteria.maxPrice ){
        	$("#priceRangeTitle").text(price_format(criteria.minPrice)+'~'+price_format(criteria.maxPrice));
        }else if ( criteria.minPrice){
        	$("#priceRangeTitle").text(price_format(criteria.minPrice)+'~');
        }else if (criteria.maxPrice ){
        	$("#priceRangeTitle").text('~'+price_format(criteria.maxPrice));
       	}else{
       		$("#priceRangeTitle").text("");
       	}
        
        $("[name=chk_prices]").prop("checked",false);
        var radioPrice;
        if(criteria.minPrice || criteria.maxPrice)    radioPrice = "#price_" + criteria.minPrice + "_" + criteria.maxPrice;
        else                                          radioPrice = "#price__";
        if(radioPrice)    $(radioPrice).parents("label").find("[name=chk_prices]").prop("checked",true);
    }
}
//페이지 이동 스크립트
function goList(page){
	_moveToPage(page);
	$("html,body").scrollTop(0);
// 	_data.pageHolder
	$("#_bizListPager").empty();
    var pager = _getPager(_data.pageHolder);
    $("#_bizListPager").append(pager);
}
function _getPager(pageHolder){
    var obj = "";
    if(pageHolder && pageHolder.totalPages > 0){
        // prev
        var page = pageHolder.currentPage;
        var pageSize = pageHolder.pageSize;
        var startPage = parseInt(Math.ceil(parseFloat(page) / parseFloat(pageSize) - 1)) * pageSize + 1;
        
        if (startPage > 1) {
 	    	// arr prev
	        var anchorP = '<a title="' + (startPage - pageHolder.pageSize) + '페이지로 이동" href="javascript:goList(\'' + (startPage - pageHolder.pageSize) + '\')" class="arr prev"></a>';
	        obj += anchorP;
	        
		}else{
			// arr prev first
	        var anchorP = '<a title="" href="javascript:" class="arr prev first"></a>';
	        obj += anchorP;
	        
		}
        var i = startPage;
        for(; i < startPage + pageHolder.pageSize && i <= pageHolder.totalPages; i++){
        	var anchorNum ='';
            if(i == page){
            	anchorNum = '<a href="javascript://" class="active">'+i+'</a>';
            } else {
            	anchorNum = '<a title="' + i + '페이지로 이동" href="javascript:goList(\'' + i + '\')">'+i+'</a>';
            }
            obj += anchorNum;
        }
        
        if(i <= pageHolder.totalPages){
       		var anchorN = '<a href="javascript:goList(\'' + i + '\')" class="arr next"></a>';
       		obj += anchorN;
        } else {
			var anchorN = '<a href="javascript:" class="arr next last"></a>';
            obj += anchorN;
		}
    }
    return obj;
}
function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

//maxlength 체크
function maxLengthCheck(object){
	if (object.value.length > object.maxLength) {
		object.value = object.value.slice(0, object.maxLength);
	}
}
//최속값 및 최대값 세자리 콤마찍기
function inputNumberComma(obj) {
    obj.value = comma(uncomma(obj.value));
}

function comma(str) {
    str = String(str);
    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
}

function uncomma(str) {
    str = String(str);
    return str.replace(/[^\d]+/g, '');
}

function replaceBtn(bcode){
	setRecobellRelationList(bcode);
	$('.replace-modal').show();
//		$('html,body').addClass('noscroll');
}
$(function(){
    $('.replace-modal .close-btn').click(function(){
    	$('.replace-modal').hide();
//	        $('html,body').removeClass('noscroll');
    });
    
});

function setRecobellRelationList(bcode) {
	$.ajax({
		url: "/m/biz/personal/getRecobellRelationList"
		, data: {
			code : bcode
		}
		, type:"POST"
        ,dataType: "json"
        ,success : function(data){
        	var append = "";
           	$('#recobellRelationList').empty();
        	
            if (data) {
                if(!isEmpty(data)) {
					var list = data.recobellRelationList;
					if(!isEmpty(list)) {
						for(var i=0; i < list.length; i++) {
							var rate = 0;
							/* rate = 100 - Math.ceil(((list[i].lastCpnPrice / list[i].prdtSellPrice) * 100)); */
							rate = ((list[i].prdtSellPrice - list[i].lastCpnPrice) / list[i].prdtSellPrice) * 100;
							rate = Math.round(rate * 10);
							rate = Math.floor(rate / 10);
// 							if(i < 4){
								append += '	<li>';
// 							}else{
// 								append += '	<li style="display:none;">';
// 							}
							append += '	<a href="/p/'+list[i].sellPrdtBcode+'?foo=bar&rccode=mo_soldout">';
							append += '		<div class="thum">';
							if(list[i].sellPrdtGbn == 'R' || list[i].sellPrdtGbn == 'D'){
		                	    append += '		<img src="http://image.kyobobook.co.kr/newimages/music/midi/'+list[i].rcrdCd.substring( 1, 5 ).split("").reverse().join("")+'/'+list[i].rcrdCd+'.jpg" alt="'+list[i].prdtName+'" class="photo" >';
	                	    }else{
		                	    append += '		<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/goods/400/'+list[i].productImageUrl+'" alt="'+list[i].prdtName+'" class="photo" onerror="this.src=\'http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/no_image2.gif\';">';
	                	    }
							append += '		</div>';
							append += '	</a>';
							if(list[i].wishUserPrdtCnt > 0){
								append += '	<a href="javascript:" onclick="addBizWishProduct(this);return false;" class="btn_like active" prdtId="'+list[i].sellPrdtBcode+'">';
							}else{
								append += '	<a href="javascript:" onclick="addBizWishProduct(this);return false;" class="btn_like" prdtId="'+list[i].sellPrdtBcode+'">';
							}
							append += '		<span>'+'좋아요'+'</span>';
							append += '	</a>';
							append += '	<a href="/ht/product/detail?barcode='+list[i].sellPrdtBcode+'">';
							append += '	<div class="cont">';
							append += '		<p class="brand">'+list[i].brandName+'</p>';
							append += '		<p class="tit">'+list[i].prdtName+'</p>';
							append += '		<p class="price font_t">';
							if(rate != 0){
		                	    append += '				<span class="percent">'+rate+'%</span>';
	                	    }
							append += '					<span>'+price_format(list[i].lastCpnPrice)+'</span>';
							if(rate != 0){
								append += '					<span class="discount">'+price_format(list[i].prdtSellPrice)+'</span>';
	                	    }
							append += '		</p>';
							append += ' <div class="info">';
							if(list[i].reviewCount > 999){
								append += '<span class="reply">'+'999+'+'</span>';
							}else{
								append += '<span class="reply">'+list[i].reviewCount+'</span>';
							}
							if(list[i].wishPrdtCnt > 999){
								append += '<span class="like">'+'999+'+'</span>';
							}else{
								append += '<span class="like">'+list[i].wishPrdtCnt+'</span>';
							}
							append += ' </div>';
							append += ' <div class="badge">';
								if(list[i].prdtStatCode != 'C0312'){
									if(list[i].prdtStatCode == 'C0313'){
										append += ' <span class="badge03">'+'일시품절'+'</span>';
									}
									if(list[i].prdtStatCode != 'C0313'){
										append += ' <span class="badge03">'+'품절'+'</span>';
									}
								}else{
									if(list[i].prdtIcon.substring(0,1) == '1'){
										append += ' <span class="badge01">'+'쿠폰'+'</span>';
									}
									if(list[i].prdtIcon.substring(2,3) == '1'){
										append += ' <span class="badge01">'+'사은품'+'</span>';
									}
									if(list[i].prdtIcon.substring(8,9) == '1'){
										append += ' <span class="badge01">'+'무료배송'+'</span>';
									}
								}
							append += ' </div>';
						append += ' </div>';
					append += ' </a>';
				append += '</li>';
							
							if (i == 19)	break;
	                	}
					}
                	
					$('#recobellRelationList').html(append);
                }
            }
        }
        ,error: function(request, status, error) {
            if(request.status != 0){
                alert('서비스 수행도중 오류가 발생하였습니다. 잠시후 다시 이용해주세요.\n(※ 지속적으로 오류가 나는 경우 고객센터에 문의바랍니다.)');
            }
        }
    });
}
</script>
</head>
<body>
	<c:if test="${not empty curtainBnr}">
		<div class="top_banner" style="background:#8971ff;" onclick="location.href='${curtainBnr.bnrLinkUrl}'" >
			<ui:image src="${curtainBnr.imageUrlMo}" alt="${fn:escapeXml(curtainBnr.imageAlt)}"/>
		</div>
	</c:if>
	<div class="search_top">
	<form name="gnbSearchFrm" action="${defaultHost}/m/biz/search/searchMain" method="post">
	    <div class="inner">
	    	<input type="hidden" name="viewType"/>
            <input type="hidden" name="searchMenu"/>
			<div class="input_wrap">
				<input type="text" class="s_input" name="searchTerm" placeholder="검색어를 입력하세요" title="검색어를 입력하세요" autocomplete="off"  value="${c.searchTerm}"/>
				<span class="input_clear" onclick="_clearTerm();return false;">삭제</span>
			</div>
	    </div>
		<a href="javascript:history.back();" class="btn_back">뒤로가기</a>
		<a href="javascript:" class="btn_search" onclick="_searchBtn();return false;"><span>검색</span></a>
	</form>
	</div>

	<!-- replaced stuff modal -->
    <div class="replace-modal">
        <button type="button" class="close-btn"></button>
        <div class="title-wrap">
            <h2>하필 딱! 품절이지만<br>괜찮아요</h2>
            <p>찾으시는 상품과 비슷한 상품이 여기 있어요!</p>
        </div>
        <div class="category_wrap">
            <div class="pd_list">
                <ul id="recobellRelationList"> 
                </ul>
            </div>
        </div>
    </div>
	<!-- content -->
	<div id="content" class="mt0">
		<div class="search_wrap">
			<div class="search_view">
 				<!-- empty result.listProduct -->
				<!--not empty result.listProduct -->
				<div class="top_tag">
					<div class="swiper-container">
						<div class="swiper-wrapper" id="_listLinked">
						</div>
					</div>
				</div>
				<div class="cont01">
					<div class="swiper-container">
						<div class="swiper-wrapper" id="_listRecobell">
 						<!--rp -->
						<!--rp -->
						</div>
					</div>
				</div>
				<c:set value="${fn:length(listEvent)}" var="listCnt"/>
				<c:set value="${fn:length(listEventChoice)}" var="listChoiceCnt"/>
				<div class="cont02 <c:if test="${(listCnt+listChoiceCnt)==1}">case1</c:if><c:if test="${(listCnt+listChoiceCnt)!=1}">case2</c:if>">
				<c:if test="${(listCnt+listChoiceCnt)!=1}">
					<div class="swiper-container">
						<div class="swiper-wrapper">
						<c:forEach items="${listEvent}" varStatus="s1" step="3">
							<c:forEach items="${listEvent}" var="l" varStatus="st" begin="${s1.index}" end="${s1.index + 2}">
							<div class="swiper-slide">
								<a href="/m/biz/eventDetail?eventId=${l.eventId}">
									<span class="badge badge01">관련이벤트</span>
									<div class="thum">
										<ui:image src="${l.imageUrl}" alt="${fn:escapeXml(l.eventTitle)}"/>
									</div>
									<strong>${l.eventTitle}</strong>
									<p>${l.eventDtlCont} </p>
								</a>
							</div>
		                    </c:forEach>
							<c:if test="${s1.first && not empty listEventChoice}">
	 	                       <c:forEach items="${listEventChoice}" var="l" varStatus="st">
									<div class="swiper-slide">
		                              <a href="/m/biz/eventDetail?eventId=${l.eventId}">
											<span class="badge badge02">인기이벤트</span>
											<div class="thum">
												<ui:image src="${l.imageUrl}" alt="${fn:escapeXml(l.eventTitle)}"/>
											</div>
											<strong>${l.eventTitle}</strong>
											<p>${l.eventDtlCont} </p>
										</a>
									</div>
								</c:forEach>
							</c:if>
						</c:forEach>
						<c:if test="${empty listEvent}">
							<c:forEach items="${listEventChoice}" var="l" varStatus="st">
							<!--TODO:롤링해야함 -->
							<div class="swiper-slide">
								<a href="/m/biz/eventDetail?eventId=${l.eventId}">
									<span class="badge badge02">인기이벤트</span>
									<div class="thum">
										<ui:image src="${l.imageUrl}" alt="${fn:escapeXml(l.eventTitle)}"/>
									</div>
									<strong>${l.eventTitle}</strong>
									<p>${l.eventDtlCont} </p>
								</a>
							</div>
							</c:forEach>
						</c:if>
						</div>
						<!-- 스크롤바 -->
						<div class="swiper-scrollbar"></div>
						<!-- swiper-pagination -->
						<div class="pagination_wrap">
							<div class="swiper-pagination"></div>
						</div>
					</div>
					</c:if>
					<c:if test="${(listCnt+listChoiceCnt)==1}">
					<div class="event_banner"><!-- 이미지가 1개인 경우 -->
						<ul>
							<li>
							<c:if test="${not empty listEvent}">
							<c:forEach items="${listEvent}" var="l"> 
								<a href="/m/biz/eventDetail?eventId=${l.eventId}">
									<span class="badge badge01">관련이벤트</span>
									<div class="img_wrap">
										<ui:image src="${l.imageUrl}" alt="${fn:escapeXml(l.eventTitle)}"/>
									</div>
									<strong>${l.eventTitle}</strong>
									<p>${l.eventDtlCont} </p>
								</a>
							</c:forEach>
							</c:if>
							<c:if test="${empty listEvent}">
							<c:forEach items="${listEventChoice}" var="l" varStatus="st">
							<!--TODO:롤링해야함 -->
								<a href="/m/biz/eventDetail?eventId=${l.eventId}">
									<span class="badge badge02">인기이벤트</span>
									<div class="img_wrap">
										<ui:image src="${l.imageUrl}" alt="${fn:escapeXml(l.eventTitle)}"/>
									</div>
									<strong>${l.eventTitle}</strong>
									<p>${l.eventDtlCont} </p>
								</a>
							</c:forEach>
							</c:if>
							</li>
						</ul>
					</div>
					</c:if>
				</div>
				<div class="category_wrap cont03">
					<div class="pd_filter">
						<div class="form_select">
							<select name="sort" class="resize_select">
								<option value="ODC">인기상품순</option>
								<option value="DAT">신상품순</option>
								<option value="LOP">낮은가격순</option>
					            <option value="HIP">높은가격순</option>
					            <option value="DCR">높은할인율순</option>
					            <option value="LIK">좋아요순</option>
					            <option value="RVW">리뷰순</option>
							</select>
						</div>
					</div>

					<!-- 제품 -->
					<p class="pd_total">
						<em class="font_t" id="_totalSize">0</em>건의 검색결과
						<!-- 활성화시 active : class 추가 -->
						<a href="javascript:" class="btn_search_detail">상세조건</a>
					</p>
					<div class="search_tab">
						<ul>
							<li id="tabGIFT"><a href="javascript:" onclick="_tglSearchMenu('GIFT');return false;">문구/기프트<span class="font_t" id="_giftSize">(0)</span></a></li>
							<li id="tabRECORD"><a href="javascript:" onclick="_tglSearchMenu('RECORD');return false;">음반<span class="font_t" id="_recordSize">(0)</span></a></li>
						</ul>
					</div>
					<!--// 제품 -->
					<div class="pd_list" id="_listProduct"><ul><li><a href="/p/2310032617472"><div class="thum"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/goods/400/1170/hot1551139082751.jpg" alt="웰킵스 스마트 황사<font color = 'red'><b>마스크</b></font> KF80-1box (25개입)"></div></a><a href="javascript:" onclick="addBizWishProduct(this);return false;" class="btn_like" prdtid="2310032617472"><span>좋아요</span></a><a href="/p/2310032617472"><div class="cont"><p class="brand">웰킵스</p><p class="tit">웰킵스 스마트 황사<font color="red"><b>마스크</b></font> KF80-1box (25개입)</p><p class="price font_t"> <span class="percent">54%</span> <span>19,500</span> <span class="discount">42,500</span></p><div class="info"><span class="reply">1</span><span class="like" code="2310032617472">13</span></div><div class="badge"> <span class="badge02">핫트랙스배송</span> <span class="badge02">무료배송</span></div></div></a></li><li><a href="/p/2310032620250"><div class="thum"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/goods/400/1009/hot1551139300959.jpg" alt="웰킵스 스마트 황사<font color = 'red'><b>마스크</b></font> KF94-10개입"></div></a><a href="javascript:" onclick="addBizWishProduct(this);return false;" class="btn_like" prdtid="2310032620250"><span>좋아요</span></a><a href="/p/2310032620250"><div class="cont"><p class="brand">웰킵스</p><p class="tit">웰킵스 스마트 황사<font color="red"><b>마스크</b></font> KF94-10개입</p><p class="price font_t"> <span class="percent">50%</span> <span>9,900</span> <span class="discount">20,000</span></p><div class="info"><span class="reply">4</span><span class="like" code="2310032620250">24</span></div><div class="badge"> <span class="badge02">핫트랙스배송</span> <span class="badge02">무료배송</span></div></div></a></li><li><a href="/p/2310032620328"><div class="thum"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/goods/400/1973/hot1551139477956.jpg" alt="웰킵스 스마트 황사<font color = 'red'><b>마스크</b></font> KF80-10개입"></div></a><a href="javascript:" onclick="addBizWishProduct(this);return false;" class="btn_like" prdtid="2310032620328"><span>좋아요</span></a><a href="/p/2310032620328"><div class="cont"><p class="brand">웰킵스</p><p class="tit">웰킵스 스마트 황사<font color="red"><b>마스크</b></font> KF80-10개입</p><p class="price font_t"> <span class="percent">44%</span> <span>9,400</span> <span class="discount">17,000</span></p><div class="info"><span class="reply">3</span><span class="like" code="2310032620328">13</span></div><div class="badge"> <span class="badge02">핫트랙스배송</span> <span class="badge02">무료배송</span></div></div></a></li><li><a href="/p/2310032617168"><div class="thum"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/goods/400/1757/hot1551139002022.jpg" alt="웰킵스 스마트 황사<font color = 'red'><b>마스크</b></font> KF94-1box(25개입)"></div></a><a href="javascript:" onclick="addBizWishProduct(this);return false;" class="btn_like" prdtid="2310032617168"><span>좋아요</span></a><a href="/p/2310032617168"><div class="cont"><p class="brand">웰킵스</p><p class="tit">웰킵스 스마트 황사<font color="red"><b>마스크</b></font> KF94-1box(25개입)</p><p class="price font_t"> <span class="percent">59%</span> <span>20,500</span> <span class="discount">50,000</span></p><div class="info"><span class="reply">3</span><span class="like" code="2310032617168">104</span></div><div class="badge"> <span class="badge02">핫트랙스배송</span> <span class="badge02">무료배송</span></div></div></a></li><li class="sold_out"><a href="#none"><div class="thum"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/goods/400/1903/hot1551078143206.jpg" alt="[도부] KF94 (50개) 19년형 4중필터/미세먼지<font color = 'red'><b>마스크</b></font> ">	<div class="soldout-wrap">		<div class="absol-center">			<p>아쉽지만!</p>			<p><b></b>이에요</p>			
					<button class="replace-stuff-btn" id="parkmin" code="2310040242826" >대체상품</button>		
					</div> 	</div></div></a><a href="javascript:" onclick="addBizWishProduct(this);return false;" class="btn_like" prdtid="2310040242826"><span>좋아요</span></a><a href="/p/2310040242826"><div class="cont"><p class="brand">도부마스크</p><p class="tit">[도부] KF94 (50개) 19년형 4중필터/미세먼지<font color="red"><b>마스크</b></font> </p><p class="price font_t"> <span class="percent">58%</span> <span>28,900</span> <span class="discount">70,000</span></p><div class="info"><span class="reply">0</span><span class="like" code="2310040242826">17</span></div><div class="badge"> <span class="badge03">품절</span> <span class="badge02">무료배송</span></div></div></a></li><li><a href="/p/2315000345067"><div class="thum"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/goods/400/1824/S1547183441958.jpg" alt="[선물포장] 오가닉 미세먼지 필터교체 <font color = 'red'><b>마스크</b></font> 1+10 세트 아에르"></div></a><a href="javascript:" onclick="addBizWishProduct(this);return false;" class="btn_like" prdtid="2315000345067"><span>좋아요</span></a><a href="/p/2315000345067"><div class="cont"><p class="brand">아에르</p><p class="tit">[선물포장] 오가닉 미세먼지 필터교체 <font color="red"><b>마스크</b></font> 1+10 세트 아에르</p><p class="price font_t"> <span class="percent">33%</span> <span>19,900</span> <span class="discount">30,000</span></p><div class="info"><span class="reply">0</span><span class="like" code="2315000345067">0</span></div><div class="badge"></div></div></a></li><li><a href="/p/2315000535826"><div class="thum"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/goods/400/1637/hot1548905308697.jpg" alt="미오 <font color = 'red'><b>마스크</b></font> [스페이스 그레이]"></div></a><a href="javascript:" onclick="addBizWishProduct(this);return false;" class="btn_like" prdtid="2315000535826"><span>좋아요</span></a><a href="/p/2315000535826"><div class="cont"><p class="brand">제이에스글로벌</p><p class="tit">미오 <font color="red"><b>마스크</b></font> [스페이스 그레이]</p><p class="price font_t"> <span class="percent">33%</span> <span>20,000</span> <span class="discount">30,000</span></p><div class="info"><span class="reply">0</span><span class="like" code="2315000535826">3</span></div><div class="badge"> <span class="badge01">쿠폰</span> <span class="badge02">무료배송</span></div></div></a></li><li><a href="/p/2310034416912"><div class="thum"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/goods/400/1796/hot1551078659582.jpg" alt="[도부]  KF94 (20개) 19년형 4중필터/미세먼지<font color = 'red'><b>마스크</b></font> "></div></a><a href="javascript:" onclick="addBizWishProduct(this);return false;" class="btn_like" prdtid="2310034416912"><span>좋아요</span></a><a href="/p/2310034416912"><div class="cont"><p class="brand">도부마스크</p><p class="tit">[도부]  KF94 (20개) 19년형 4중필터/미세먼지<font color="red"><b>마스크</b></font> </p><p class="price font_t"> <span class="percent">45%</span> <span>15,300</span> <span class="discount">28,000</span></p><div class="info"><span class="reply">0</span><span class="like" code="2310034416912">1</span></div><div class="badge"> <span class="badge02">무료배송</span></div></div></a></li><li><a href="/p/2315000325908"><div class="thum"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/goods/400/1148/S1547013240920.jpg" alt="[THIERS] 티에르 패션 <font color = 'red'><b>마스크</b></font> (유해물질 차단 / 필터 교체형 / 입체형 / 피톤치드)"></div></a><a href="javascript:" onclick="addBizWishProduct(this);return false;" class="btn_like" prdtid="2315000325908"><span>좋아요</span></a><a href="/p/2315000325908"><div class="cont"><p class="brand">모앤모</p><p class="tit">[THIERS] 티에르 패션 <font color="red"><b>마스크</b></font> (유해물질 차단 / 필터 교체형 / 입체형 / 피톤치드)</p><p class="price font_t"> <span class="percent">40%</span> <span>7,180</span> <span class="discount">12,000</span></p><div class="info"><span class="reply">0</span><span class="like" code="2315000325908">16</span></div><div class="badge"></div></div></a></li><li><a href="/p/2315000536021"><div class="thum"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/goods/400/1990/hot1548906878967.jpg" alt="미오 <font color = 'red'><b>마스크</b></font>필터 [리필용-3매입]"></div></a><a href="javascript:" onclick="addBizWishProduct(this);return false;" class="btn_like" prdtid="2315000536021"><span>좋아요</span></a><a href="/p/2315000536021"><div class="cont"><p class="brand">제이에스글로벌</p><p class="tit">미오 <font color="red"><b>마스크</b></font>필터 [리필용-3매입]</p><p class="price font_t"> <span class="percent">33%</span> <span>16,000</span> <span class="discount">24,000</span></p><div class="info"><span class="reply">0</span><span class="like" code="2315000536021">3</span></div><div class="badge"> <span class="badge01">쿠폰</span> <span class="badge02">무료배송</span></div></div></a></li><li class="sold_out"><a href="#none"><div class="thum"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/goods/400/1515/hot1550562216972.jpg" alt="[도부] KF94 (1개) 19년형 4중필터/미세먼지<font color = 'red'><b>마스크</b></font> ">	<div class="soldout-wrap">		<div class="absol-center">			<p>아쉽지만!</p>			<p><b></b>이에요</p>			<button type="button" class="replace-stuff-btn" onclick="replaceBtn(2310034446223);return false;">대체상품</button>		</div> 	</div></div></a><a href="javascript:" onclick="addBizWishProduct(this);return false;" class="btn_like" prdtid="2310034446223"><span>좋아요</span></a><a href="/p/2310034446223"><div class="cont"><p class="brand">도부마스크</p><p class="tit">[도부] KF94 (1개) 19년형 4중필터/미세먼지<font color="red"><b>마스크</b></font> </p><p class="price font_t"> <span class="percent">57%</span> <span>600</span> <span class="discount">1,400</span></p><div class="info"><span class="reply">0</span><span class="like" code="2310034446223">0</span></div><div class="badge"> <span class="badge03">품절</span></div></div></a></li><li class="sold_out"><a href="#none"><div class="thum"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/goods/400/1141/hot1551853250936.jpg" alt="[바이홈] KF94 황사방역용 <font color = 'red'><b>마스크</b></font> 블랙 - 100P">	<div class="soldout-wrap">		<div class="absol-center">			<p>아쉽지만!</p>			<p><b></b>이에요</p>			<button type="button" class="replace-stuff-btn" onclick="replaceBtn(2310037438980);return false;">대체상품</button>		</div> 	</div></div></a><a href="javascript:" onclick="addBizWishProduct(this);return false;" class="btn_like" prdtid="2310037438980"><span>좋아요</span></a><a href="/p/2310037438980"><div class="cont"><p class="brand">하우스 레시피</p><p class="tit">[바이홈] KF94 황사방역용 <font color="red"><b>마스크</b></font> 블랙 - 100P</p><p class="price font_t"> <span class="percent">21%</span> <span>65,770</span> <span class="discount">84,000</span></p><div class="info"><span class="reply">0</span><span class="like" code="2310037438980">1</span></div><div class="badge"> <span class="badge03">품절</span> <span class="badge02">무료배송</span></div></div></a></li><li class="sold_out"><a href="#none"><div class="thum"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/goods/400/1762/hot1551853662602.jpg" alt="[바이홈] KF94 황사방역용 <font color = 'red'><b>마스크</b></font> 화이트 - 50P">	<div class="soldout-wrap">		<div class="absol-center">			<p>아쉽지만!</p>			<p><b></b>이에요</p>			<button type="button" class="replace-stuff-btn" onclick="replaceBtn(2310037439055);return false;">대체상품</button>		</div> 	</div></div></a><a href="javascript:" onclick="addBizWishProduct(this);return false;" class="btn_like" prdtid="2310037439055"><span>좋아요</span></a><a href="/p/2310037439055"><div class="cont"><p class="brand">하우스 레시피</p><p class="tit">[바이홈] KF94 황사방역용 <font color="red"><b>마스크</b></font> 화이트 - 50P</p><p class="price font_t"> <span class="percent">23%</span> <span>36,800</span> <span class="discount">47,800</span></p><div class="info"><span class="reply">0</span><span class="like" code="2310037439055">3</span></div><div class="badge"> <span class="badge03">품절</span> <span class="badge02">무료배송</span></div></div></a></li><li><a href="/p/8809198843879"><div class="thum"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/goods/400/1554/hot1532681639026.jpg" alt="1025 독도 <font color = 'red'><b>마스크</b></font> 1+1"></div></a><a href="javascript:" onclick="addBizWishProduct(this);return false;" class="btn_like" prdtid="8809198843879"><span>좋아요</span></a><a href="/p/8809198843879"><div class="cont"><p class="brand">라운드랩</p><p class="tit">1025 독도 <font color="red"><b>마스크</b></font> 1+1</p><p class="price font_t"> <span class="percent">50%</span> <span>5,000</span> <span class="discount">10,000</span></p><div class="info"><span class="reply">0</span><span class="like" code="8809198843879">3</span></div><div class="badge"> <span class="badge02">핫트랙스배송</span></div></div></a></li><li><a href="/p/2315000535840"><div class="thum"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/goods/400/1488/hot1548905726656.jpg" alt="미오 <font color = 'red'><b>마스크</b></font> [매쉬 블루]"></div></a><a href="javascript:" onclick="addBizWishProduct(this);return false;" class="btn_like" prdtid="2315000535840"><span>좋아요</span></a><a href="/p/2315000535840"><div class="cont"><p class="brand">제이에스글로벌</p><p class="tit">미오 <font color="red"><b>마스크</b></font> [매쉬 블루]</p><p class="price font_t"> <span class="percent">33%</span> <span>20,000</span> <span class="discount">30,000</span></p><div class="info"><span class="reply">0</span><span class="like" code="2315000535840">2</span></div><div class="badge"> <span class="badge01">쿠폰</span> <span class="badge02">무료배송</span></div></div></a></li><li class="sold_out"><a href="#none"><div class="thum"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/goods/400/1231/hot1551853298837.jpg" alt="[바이홈] KF94 황사방역용 <font color = 'red'><b>마스크</b></font> 블랙 - 30P">	<div class="soldout-wrap">		<div class="absol-center">			<p>아쉽지만!</p>			<p><b></b>이에요</p>			<button type="button" class="replace-stuff-btn" onclick="replaceBtn(2310037438904);return false;">대체상품</button>		</div> 	</div></div></a><a href="javascript:" onclick="addBizWishProduct(this);return false;" class="btn_like" prdtid="2310037438904"><span>좋아요</span></a><a href="/p/2310037438904"><div class="cont"><p class="brand">하우스 레시피</p><p class="tit">[바이홈] KF94 황사방역용 <font color="red"><b>마스크</b></font> 블랙 - 30P</p><p class="price font_t"> <span class="percent">22%</span> <span>24,800</span> <span class="discount">31,800</span></p><div class="info"><span class="reply">0</span><span class="like" code="2310037438904">2</span></div><div class="badge"> <span class="badge03">품절</span> <span class="badge02">무료배송</span></div></div></a></li><li class="sold_out"><a href="#none"><div class="thum"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/goods/400/1477/hot1551853278794.jpg" alt="[바이홈] KF94 황사방역용 <font color = 'red'><b>마스크</b></font> 블랙 - 50P">	<div class="soldout-wrap">		<div class="absol-center">			<p>아쉽지만!</p>			<p><b></b>이에요</p>			<button type="button" class="replace-stuff-btn" onclick="replaceBtn(2310037438959);return false;">대체상품</button>		</div> 	</div></div></a><a href="javascript:" onclick="addBizWishProduct(this);return false;" class="btn_like" prdtid="2310037438959"><span>좋아요</span></a><a href="/p/2310037438959"><div class="cont"><p class="brand">하우스 레시피</p><p class="tit">[바이홈] KF94 황사방역용 <font color="red"><b>마스크</b></font> 블랙 - 50P</p><p class="price font_t"> <span class="percent">23%</span> <span>36,800</span> <span class="discount">47,800</span></p><div class="info"><span class="reply">0</span><span class="like" code="2310037438959">0</span></div><div class="badge"> <span class="badge03">품절</span> <span class="badge02">무료배송</span></div></div></a></li><li><a href="/p/2315000386312"><div class="thum"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/goods/400/1148/S1547690790408.jpg" alt="[THIERS] 티에르 패션 <font color = 'red'><b>마스크</b></font>용 유해먼지 나노필터 (3중 구조 / 와이어 내장)"></div></a><a href="javascript:" onclick="addBizWishProduct(this);return false;" class="btn_like" prdtid="2315000386312"><span>좋아요</span></a><a href="/p/2315000386312"><div class="cont"><p class="brand">모앤모</p><p class="tit">[THIERS] 티에르 패션 <font color="red"><b>마스크</b></font>용 유해먼지 나노필터 (3중 구조 / 와이어 내장)</p><p class="price font_t"> <span>1,000</span></p><div class="info"><span class="reply">0</span><span class="like" code="2315000386312">2</span></div><div class="badge"></div></div></a></li><li><a href="/p/2310038232686"><div class="thum"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/goods/400/1257/hot1541731387906.jpg" alt="[필슨] 방역<font color = 'red'><b>마스크</b></font> KF94 (20매)"></div></a><a href="javascript:" onclick="addBizWishProduct(this);return false;" class="btn_like" prdtid="2310038232686"><span>좋아요</span></a><a href="/p/2310038232686"><div class="cont"><p class="brand">디피이</p><p class="tit">[필슨] 방역<font color="red"><b>마스크</b></font> KF94 (20매)</p><p class="price font_t"> <span class="percent">16%</span> <span>27,890</span> <span class="discount">33,480</span></p><div class="info"><span class="reply">0</span><span class="like" code="2310038232686">0</span></div><div class="badge"></div></div></a></li><li><a href="/p/2315000535833"><div class="thum"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/goods/400/1142/hot1548905558703.jpg" alt="미오 <font color = 'red'><b>마스크</b></font> [블랙 솔리드]"></div></a><a href="javascript:" onclick="addBizWishProduct(this);return false;" class="btn_like" prdtid="2315000535833"><span>좋아요</span></a><a href="/p/2315000535833"><div class="cont"><p class="brand">제이에스글로벌</p><p class="tit">미오 <font color="red"><b>마스크</b></font> [블랙 솔리드]</p><p class="price font_t"> <span class="percent">33%</span> <span>20,000</span> <span class="discount">30,000</span></p><div class="info"><span class="reply">0</span><span class="like" code="2315000535833">3</span></div><div class="badge"> <span class="badge01">쿠폰</span> <span class="badge02">무료배송</span></div></div></a></li><li><a href="/p/2310031328904"><div class="thum"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/goods/400/1365/S1503541601919.jpg" alt="초미세먼지 <font color = 'red'><b>마스크</b></font> 필터 fs-03/ 아에르"></div></a><a href="javascript:" onclick="addBizWishProduct(this);return false;" class="btn_like" prdtid="2310031328904"><span>좋아요</span></a><a href="/p/2310031328904"><div class="cont"><p class="brand">아에르</p><p class="tit">초미세먼지 <font color="red"><b>마스크</b></font> 필터 fs-03/ 아에르</p><p class="price font_t"> <span>3,900</span></p><div class="info"><span class="reply">1</span><span class="like" code="2310031328904">3</span></div><div class="badge"></div></div></a></li><li><a href="/p/2310035312701"><div class="thum"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/goods/400/1540/hot1524704111772.jpg" alt="( 일본직수입 ) AI WILL PM2.5 <font color = 'red'><b>마스크</b></font>"></div></a><a href="javascript:" onclick="addBizWishProduct(this);return false;" class="btn_like" prdtid="2310035312701"><span>좋아요</span></a><a href="/p/2310035312701"><div class="cont"><p class="brand">엠스키</p><p class="tit">( 일본직수입 ) AI WILL PM2.5 <font color="red"><b>마스크</b></font></p><p class="price font_t"> <span>8,900</span></p><div class="info"><span class="reply">0</span><span class="like" code="2310035312701">1</span></div><div class="badge"> <span class="badge02">무료배송</span></div></div></a></li><li class="sold_out"><a href="#none"><div class="thum"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/goods/400/1185/hot1551853644548.jpg" alt="[바이홈] KF94 황사방역용 <font color = 'red'><b>마스크</b></font> 화이트 - 100P">	<div class="soldout-wrap">		<div class="absol-center">			<p>아쉽지만!</p>			<p><b></b>이에요</p>			<button type="button" class="replace-stuff-btn" onclick="replaceBtn(2310037439109);return false;">대체상품</button>		</div> 	</div></div></a><a href="javascript:" onclick="addBizWishProduct(this);return false;" class="btn_like" prdtid="2310037439109"><span>좋아요</span></a><a href="/p/2310037439109"><div class="cont"><p class="brand">하우스 레시피</p><p class="tit">[바이홈] KF94 황사방역용 <font color="red"><b>마스크</b></font> 화이트 - 100P</p><p class="price font_t"> <span class="percent">21%</span> <span>65,770</span> <span class="discount">84,000</span></p><div class="info"><span class="reply">1</span><span class="like" code="2310037439109">2</span></div><div class="badge"> <span class="badge03">품절</span> <span class="badge02">무료배송</span></div></div></a></li><li><a href="/p/2310034795314"><div class="thum"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/goods/400/1668/S1521687104139.png" alt="[보그<font color = 'red'><b>마스크</b></font>]Hero N99 CV"></div></a><a href="javascript:" onclick="addBizWishProduct(this);return false;" class="btn_like" prdtid="2310034795314"><span>좋아요</span></a><a href="/p/2310034795314"><div class="cont"><p class="brand">보그마스크</p><p class="tit">[보그<font color="red"><b>마스크</b></font>]Hero N99 CV</p><p class="price font_t"> <span class="percent">27%</span> <span>27,390</span> <span class="discount">38,000</span></p><div class="info"><span class="reply">0</span><span class="like" code="2310034795314">2</span></div><div class="badge"> <span class="badge01">쿠폰</span></div></div></a></li><li><a href="/p/2310035316662"><div class="thum"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/goods/400/1506/hot1526446602882.jpg" alt="[블루]엄마가 찾는 그3D 입체유아<font color = 'red'><b>마스크</b></font>1~3세(10매) "></div></a><a href="javascript:" onclick="addBizWishProduct(this);return false;" class="btn_like" prdtid="2310035316662"><span>좋아요</span></a><a href="/p/2310035316662"><div class="cont"><p class="brand">쁘띠조이</p><p class="tit">[블루]엄마가 찾는 그3D 입체유아<font color="red"><b>마스크</b></font>1~3세(10매) </p><p class="price font_t"> <span class="percent">70%</span> <span>8,900</span> <span class="discount">30,000</span></p><div class="info"><span class="reply">0</span><span class="like" code="2310035316662">0</span></div><div class="badge"> <span class="badge02">핫트랙스배송</span></div></div></a></li><li><a href="/p/2310034439348"><div class="thum"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/goods/400/1811/S1519808770450.jpg" alt="KF94 황사 초미세먼지 <font color = 'red'><b>마스크</b></font> 50매(개별포장)/ 아에르"></div></a><a href="javascript:" onclick="addBizWishProduct(this);return false;" class="btn_like" prdtid="2310034439348"><span>좋아요</span></a><a href="/p/2310034439348"><div class="cont"><p class="brand">아에르</p><p class="tit">KF94 황사 초미세먼지 <font color="red"><b>마스크</b></font> 50매(개별포장)/ 아에르</p><p class="price font_t"> <span>37,000</span></p><div class="info"><span class="reply">0</span><span class="like" code="2310034439348">0</span></div><div class="badge"></div></div></a></li><li><a href="/p/2310038232563"><div class="thum"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/goods/400/1363/hot1541728350403.jpg" alt="[3Q] 프리미엄 플러스 먼지 차단 <font color = 'red'><b>마스크</b></font> 50매 (남성용/여성용/어린이용)"></div></a><a href="javascript:" onclick="addBizWishProduct(this);return false;" class="btn_like" prdtid="2310038232563"><span>좋아요</span></a><a href="/p/2310038232563"><div class="cont"><p class="brand">디피이</p><p class="tit">[3Q] 프리미엄 플러스 먼지 차단 <font color="red"><b>마스크</b></font> 50매 (남성용/여성용/어린이용)</p><p class="price font_t"> <span class="percent">20%</span> <span>4,100</span> <span class="discount">5,148</span></p><div class="info"><span class="reply">0</span><span class="like" code="2310038232563">0</span></div><div class="badge"></div></div></a></li><li><a href="/p/2310037031709"><div class="thum"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/goods/400/1154/hot1535000663104.jpg" alt="더마이리스 에어포켓 <font color = 'red'><b>마스크</b></font>팩 5매+사은품"></div></a><a href="javascript:" onclick="addBizWishProduct(this);return false;" class="btn_like" prdtid="2310037031709"><span>좋아요</span></a><a href="/p/2310037031709"><div class="cont"><p class="brand">더마이리스</p><p class="tit">더마이리스 에어포켓 <font color="red"><b>마스크</b></font>팩 5매+사은품</p><p class="price font_t"> <span>7,500</span></p><div class="info"><span class="reply">0</span><span class="like" code="2310037031709">3</span></div><div class="badge"></div></div></a></li><li><a href="/p/2315000535871"><div class="thum"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/goods/400/1669/hot1548906093170.jpg" alt="미오 <font color = 'red'><b>마스크</b></font> [양패턴-키즈]"></div></a><a href="javascript:" onclick="addBizWishProduct(this);return false;" class="btn_like" prdtid="2315000535871"><span>좋아요</span></a><a href="/p/2315000535871"><div class="cont"><p class="brand">제이에스글로벌</p><p class="tit">미오 <font color="red"><b>마스크</b></font> [양패턴-키즈]</p><p class="price font_t"> <span class="percent">33%</span> <span>20,000</span> <span class="discount">30,000</span></p><div class="info"><span class="reply">0</span><span class="like" code="2315000535871">0</span></div><div class="badge"> <span class="badge01">쿠폰</span> <span class="badge02">무료배송</span></div></div></a></li><li><a href="/p/2315000535864"><div class="thum"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/goods/400/1720/hot1548905982296.jpg" alt="미오 <font color = 'red'><b>마스크</b></font> [공룡패턴-키즈]"></div></a><a href="javascript:" onclick="addBizWishProduct(this);return false;" class="btn_like" prdtid="2315000535864"><span>좋아요</span></a><a href="/p/2315000535864"><div class="cont"><p class="brand">제이에스글로벌</p><p class="tit">미오 <font color="red"><b>마스크</b></font> [공룡패턴-키즈]</p><p class="price font_t"> <span class="percent">33%</span> <span>20,000</span> <span class="discount">30,000</span></p><div class="info"><span class="reply">0</span><span class="like" code="2315000535864">0</span></div><div class="badge"> <span class="badge01">쿠폰</span> <span class="badge02">무료배송</span></div></div></a></li><li><a href="/p/2310034815722"><div class="thum"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/goods/400/1068/hot1521782941831.jpg" alt="오펜가드 후아 <font color = 'red'><b>마스크</b></font> 리필 필터 5매/KF80"></div></a><a href="javascript:" onclick="addBizWishProduct(this);return false;" class="btn_like" prdtid="2310034815722"><span>좋아요</span></a><a href="/p/2310034815722"><div class="cont"><p class="brand">쉐이빙월드</p><p class="tit">오펜가드 후아 <font color="red"><b>마스크</b></font> 리필 필터 5매/KF80</p><p class="price font_t"> <span class="percent">42%</span> <span>4,000</span> <span class="discount">7,000</span></p><div class="info"><span class="reply">0</span><span class="like" code="2310034815722">2</span></div><div class="badge"></div></div></a></li><li><a href="/p/2310022010665"><div class="thum"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/goods/400/1961/S1460969209399.jpg" alt="소프리스 풋 필링 더블에센스 <font color = 'red'><b>마스크</b></font> / 발각질제거팩"></div></a><a href="javascript:" onclick="addBizWishProduct(this);return false;" class="btn_like" prdtid="2310022010665"><span>좋아요</span></a><a href="/p/2310022010665"><div class="cont"><p class="brand">소프리스</p><p class="tit">소프리스 풋 필링 더블에센스 <font color="red"><b>마스크</b></font> / 발각질제거팩</p><p class="price font_t"> <span class="percent">24%</span> <span>3,610</span> <span class="discount">4,800</span></p><div class="info"><span class="reply">0</span><span class="like" code="2310022010665">1</span></div><div class="badge"> <span class="badge01">쿠폰</span></div></div></a></li><li><a href="/p/2310015179751"><div class="thum"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/goods/400/1266/A201505031750115312.jpg" alt="[보그<font color = 'red'><b>마스크</b></font>] Smart Grid N99 CV"></div></a><a href="javascript:" onclick="addBizWishProduct(this);return false;" class="btn_like" prdtid="2310015179751"><span>좋아요</span></a><a href="/p/2310015179751"><div class="cont"><p class="brand">보그마스크</p><p class="tit">[보그<font color="red"><b>마스크</b></font>] Smart Grid N99 CV</p><p class="price font_t"> <span class="percent">27%</span> <span>27,390</span> <span class="discount">38,000</span></p><div class="info"><span class="reply">0</span><span class="like" code="2310015179751">3</span></div><div class="badge"> <span class="badge01">쿠폰</span></div></div></a></li><li><a href="/p/2310015172929"><div class="thum"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/goods/400/1708/A201505031155134682.jpg" alt="[보그<font color = 'red'><b>마스크</b></font>] Black Logo N99 CV"></div></a><a href="javascript:" onclick="addBizWishProduct(this);return false;" class="btn_like" prdtid="2310015172929"><span>좋아요</span></a><a href="/p/2310015172929"><div class="cont"><p class="brand">보그마스크</p><p class="tit">[보그<font color="red"><b>마스크</b></font>] Black Logo N99 CV</p><p class="price font_t"> <span class="percent">27%</span> <span>27,390</span> <span class="discount">38,000</span></p><div class="info"><span class="reply">5</span><span class="like" code="2310015172929">23</span></div><div class="badge"> <span class="badge01">쿠폰</span></div></div></a></li><li><a href="/p/2315000415654"><div class="thum"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/goods/400/1616/hot1543279968356.jpg" alt="미라클 하이드로겔 아이패치"></div></a><a href="javascript:" onclick="addBizWishProduct(this);return false;" class="btn_like" prdtid="2315000415654"><span>좋아요</span></a><a href="/p/2315000415654"><div class="cont"><p class="brand">블루캐롯</p><p class="tit">미라클 하이드로겔 아이패치</p><p class="price font_t"> <span>25,000</span></p><div class="info"><span class="reply">0</span><span class="like" code="2315000415654">1</span></div><div class="badge"></div></div></a></li><li><a href="/p/2310032145470"><div class="thum"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/goods/400/1543/hot1507861061994.png" alt="[보그<font color = 'red'><b>마스크</b></font>] Organic Black N99 C2V"></div></a><a href="javascript:" onclick="addBizWishProduct(this);return false;" class="btn_like" prdtid="2310032145470"><span>좋아요</span></a><a href="/p/2310032145470"><div class="cont"><p class="brand">보그마스크</p><p class="tit">[보그<font color="red"><b>마스크</b></font>] Organic Black N99 C2V</p><p class="price font_t"> <span class="percent">29%</span> <span>31,520</span> <span class="discount">45,000</span></p><div class="info"><span class="reply">1</span><span class="like" code="2310032145470">17</span></div><div class="badge"> <span class="badge01">쿠폰</span></div></div></a></li><li><a href="/p/2310034809387"><div class="thum"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/goods/400/1871/S1521733131617.jpg" alt="KF80 유아 어린이 미세먼지 <font color = 'red'><b>마스크</b></font> 50매(개별포장)/ 아에르"></div></a><a href="javascript:" onclick="addBizWishProduct(this);return false;" class="btn_like" prdtid="2310034809387"><span>좋아요</span></a><a href="/p/2310034809387"><div class="cont"><p class="brand">아에르</p><p class="tit">KF80 유아 어린이 미세먼지 <font color="red"><b>마스크</b></font> 50매(개별포장)/ 아에르</p><p class="price font_t"> <span>34,000</span></p><div class="info"><span class="reply">0</span><span class="like" code="2310034809387">0</span></div><div class="badge"></div></div></a></li><li><a href="/p/2310032768051"><div class="thum"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/goods/400/1656/hot1510234608132.jpg" alt="알마 스웨그쿡 미니 스크램블팬 19cm"></div></a><a href="javascript:" onclick="addBizWishProduct(this);return false;" class="btn_like" prdtid="2310032768051"><span>좋아요</span></a><a href="/p/2310032768051"><div class="cont"><p class="brand">알마</p><p class="tit">알마 스웨그쿡 미니 스크램블팬 19cm</p><p class="price font_t"> <span class="percent">47%</span> <span>9,500</span> <span class="discount">18,200</span></p><div class="info"><span class="reply">2</span><span class="like" code="2310032768051">4</span></div><div class="badge"></div></div></a></li><li><a href="/p/2310034809417"><div class="thum"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/goods/400/1505/S1521733142192.jpg" alt="KF94 유아 어린이 황사 초 미세먼지 <font color = 'red'><b>마스크</b></font>"></div></a><a href="javascript:" onclick="addBizWishProduct(this);return false;" class="btn_like" prdtid="2310034809417"><span>좋아요</span></a><a href="/p/2310034809417"><div class="cont"><p class="brand">아에르</p><p class="tit">KF94 유아 어린이 황사 초 미세먼지 <font color="red"><b>마스크</b></font></p><p class="price font_t"> <span>900</span></p><div class="info"><span class="reply">0</span><span class="like" code="2310034809417">0</span></div><div class="badge"></div></div></a></li><li><a href="/p/2310022010702"><div class="thum"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/goods/400/1903/S1460969216122.jpg" alt="소프리스 풋 필링 더블에센스 <font color = 'red'><b>마스크</b></font>/발각질제거 10매"></div></a><a href="javascript:" onclick="addBizWishProduct(this);return false;" class="btn_like" prdtid="2310022010702"><span>좋아요</span></a><a href="/p/2310022010702"><div class="cont"><p class="brand">소프리스</p><p class="tit">소프리스 풋 필링 더블에센스 <font color="red"><b>마스크</b></font>/발각질제거 10매</p><p class="price font_t"> <span class="percent">28%</span> <span>34,270</span> <span class="discount">48,000</span></p><div class="info"><span class="reply">0</span><span class="like" code="2310022010702">0</span></div><div class="badge"> <span class="badge01">쿠폰</span></div></div></a></li></ul></div>
					<!--// 제품 -->
					<div class="pagination_v2" id="_bizListPager">
						<ui:bizpaginationScript name="pageHolder" scriptName="goList"/>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--// content -->

	<!-- 상세조건 -->
	<div id="search_detail">
		<div class="search_detail_cont">
			<div class="swiper-container">
				<div class="swiper-wrapper">
					<div class="swiper-slide">
						<div class="hd">
		                    <h2>상세조건<a href="javascript:" class="btn_reset" onclick="_reset();return false;">초기화</a></h2>
		                </div>
						<div class="cont">
							<ul>
								<li>
									<a href="javascript:" class="dp1">정렬<span id="orderByTitle"></span></a>
									<div class="dp2">
										<ul>
											<li>
												<a href="javascript:">
													<label class="form_radio">
	                                                    <input type="radio" name="sort" value="ODC">
	                                                    <span>인기순</span>
	                                                </label>
												</a>
											</li>
											<li>
												<a href="javascript:">
													<label class="form_radio">
	                                                    <input type="radio" name="sort" value="DAT">
	                                                    <span>신상품순</span>
	                                                </label>
												</a>
											</li>
											<li>
												<a href="javascript:">
													<label class="form_radio">
	                                                    <input type="radio" name="sort" value="LOP">
	                                                    <span>낮은가격순</span>
	                                                </label>
												</a>
											</li>
											<li>
												<a href="javascript:">
													<label class="form_radio">
	                                                    <input type="radio" name="sort" value="HIP">
	                                                    <span>높은가격순</span>
	                                                </label>
												</a>
											</li>
											<li>
												<a href="javascript:">
													<label class="form_radio">
	                                                    <input type="radio" name="sort" value="DCR">
	                                                    <span>높은할인율순</span>
	                                                </label>
												</a>
											</li>
											<li>
												<a href="javascript:">
													<label class="form_radio">
	                                                    <input type="radio" name="sort" value="LIK">
	                                                    <span>좋아요순</span>
	                                                </label>
												</a>
											</li>
											<li>
												<a href="javascript:">
													<label class="form_radio">
	                                                    <input type="radio" name="sort" value="RVW">
	                                                    <span>리뷰순</span>
	                                                </label>
												</a>
											</li>
										</ul>
									</div>
								</li>
								<li id="choiceBnft">
									<a href="javascript:" class="dp1">혜택/상세<span id="benTitle"></span></a>
									<div class="dp2">
										<ul>
											<li>
												<a href="javascript:">
													<label class="form_checkbox">
	                                                    <input type="checkbox" name="saleYn" value="N">
	                                                    <span class="icon"></span>
														<p>품절포함</p>
	                                                </label>
												</a>
											</li>
											<li>
												<a href="javascript:">
													<label class="form_checkbox">
	                                                    <input type="checkbox" name="saleYn" value="Y">
	                                                    <span class="icon"></span>
	                                                    <p>품절제외</p>
	                                                </label>
												</a>
											</li>
											<li>
												<a href="javascript:">
													<label class="form_checkbox">
	                                                    <input type="checkbox" name="freeDeliveryYn" id="chkFreeDlvyYn" value="Y">
	                                                    <span class="icon"></span>
	                                                    <p>무료배송</p>
	                                                </label>
												</a>
											</li>
											<li>
												<a href="javascript:">
													<label class="form_checkbox">
	                                                    <input type="checkbox" name="deliveryVendorId" id="chkHottDelivery" value="0625">
	                                                    <span class="icon"></span>
	                                                    <p>핫트랙스배송</p>
	                                                </label>
												</a>
											</li>
											<li>
												<a href="javascript:">
													<label class="form_checkbox">
	                                                    <input type="checkbox" name="couponYn" id="chkCouponYn" value="Y">
	                                                    <span class="icon"></span>
	                                                    <p>쿠폰</p>
	                                                </label>
												</a>
											</li>
											<li>
												<a href="javascript:">
													<label class="form_checkbox">
	                                                    <input type="checkbox" name="discountYn" id="chkDiscountYn" value="Y">
	                                                    <span class="icon"></span>
	                                                    <p>할인</p>
	                                                </label>
												</a>
											</li>
											<c:if test="${c.searchMenu eq 'RECORD'}">
											<li>
												<a href="javascript:">
													<label class="form_checkbox">
	                                                    <input type="checkbox" name="radio27">
	                                                    <span class="icon"></span>
	                                                    <p>예약</p>
	                                                </label>
												</a>
											</li>
											</c:if>
										</ul>
									</div>
								</li>
								<li>
									<a href="javascript:" class="dp1">카테고리<span id="cateTitle"></span></a>
									<div class="dp2">
										<ul id="choiceCtgr">
										</ul>
									</div>
								</li>
								<li id="brandArea">
									<a href="javascript:" class="dp1">브랜드<span id="brandTitle"></span></a>
									<div class="dp2">
										<ul id="choiceBrand">
										</ul>
									</div>
								</li>
								<li>
									<a href="javascript:" class="dp1">가격대<span id="priceRangeTitle"></span></a>
									<div class="dp2">
										<ul id="_priceRange">
										</ul>
										<ul>
											<li>
												<div class="price">
													<p>가격대</p>
													<div class="form_search">
														<div class="input_wrap">
															<input type="number" pattern="\d*" name="minPrice"  placeholder="최저가" maxlength="7" pattern="[0-9]*" inputmode="numeric" min="0" oninput="maxLengthCheck(this)"  >
															<span class="font_t">~</span>
															<input type="number" pattern="\d*" name="maxPrice"  placeholder="최고가" maxlength="7" pattern="[0-9]*" inputmode="numeric" min="0" oninput="maxLengthCheck(this)" >
														</div>
														<a href="#" class="btns" id="price_btn">입력</a>
													</div>
												</div>
											</li>
										</ul>
									</div>
								</li>
							</ul>
							<div class="research">
								<p>결과 내 재검색</p>
								<div class="form_search">
									<input type="text" name="plusKeywords"/>
									<a href="#" class="btns" onclick="_addKeywords();return false;">검색</a>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--// 상세조건 -->
</body>
</html>