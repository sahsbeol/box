<%@ page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<html>
<head>
<!-- 태그 라이브러리 -->
<%@ include file="/pages/decorators/biz/tagHeader.jsp" %>
<ui:decorator name="bizWelcome"/>
<style>
.bnr_topbox {position: fixed; top:0px; width:100%; height:44px; z-index:99999;}
.bnr_topbox img {width:100%; height:auto;}
.bnr_topbox .btn_btclose {position: absolute;top: 10px;width: 24px;height: 24px;right: 10px;text-indent: -999999px;background: url(http://image.kyobobook.co.kr/newimages/giftshop_new/resources/img/device/ic_topclose.png) no-repeat;background-size: 24px 24px;}
.bnr_topbox + #header.bnr_top {top: 44px !important;}
.bnr_topbox + #header.bnr_top.active {top: -65px !important;}
.popup_sbox {position: fixed; width: 100%; height: 314px; z-index: 9999; background: #fff; bottom: 0; border-radius: 20px 20px 0px 0px; -moz-border-radius: 20px 20px 0px 0px; -webkit-border-radius: 20px 21px 0px 0px; -webkit-box-shadow: 0px -4px 8px #0000001A; -moz-box-shadow: 0px -4px 8px #0000001A; box-shadow: 0px -4px 8px #0000001A;}    
.popup_sbox .tit_a {position: absolute;padding: 15px 30px 0 40px;width: calc(100% - 70px);font-size: 14px;}
.popup_sbox .tit_a .btn_tclose {text-decoration: underline;color: #777;}
.popup_sbox .tit_a .btn_pclose {float: right;color: #777;padding-right: 20px;}
.popup_sbox .tit_a .btn_pclose:after {position: absolute;content: '';width: 24px;height: 24px;background: url('http://image.kyobobook.co.kr/newimages/giftshop_new/resources/img/common/ic_pclose.png') no-repeat;background-size: 24px 24px;margin-left: -3px;} 
.popup_sbox .swiper-container{margin: 50px 0 0 40px;overflow: inherit;}
/* <!-- 2020.07.21 김지우 커밋 --> */
@media screen and ( max-width: 320px ) {
	.popup_sbox .swiper-container{margin: 50px 0 0 10px;}
}
/* <!-- 2020.07.21 김지우 커밋 끝--> */
.popup_sbox .swiper-slide{width:300px;}
.popup_sbox .swiper-slide a{display:block; height: 230px;}
.popup_sbox .swiper-slide .thum{position:relative; width: 300px; height: 100%; overflow: hidden;}
.popup_sbox .swiper-slide .thum img{width: 100%;}
.popup_sbox .swiper-slide .label{position:absolute; display:inline-block; bottom:-5px; right:0; font-weight:bold; width:70px; padding:7px 0 4px; text-align:center; font-size:1.333em; color:#fff; background:rgba(0,0,0,1);}
.popup_sbox .swiper-slide .txt_a {position: absolute; bottom: 0; left: 0; width: 100%; height: 50px; background: #fff; line-height: 1.2; padding-top: 8px;}
.popup_sbox .swiper-slide strong{display:block; width: calc(100% - 58px); padding: 0 10px; color:#000;font-size: 1.667em;white-space:nowrap;overflow:hidden;text-overflow:ellipsis; box-sizing: border-box;}
.popup_sbox .swiper-slide p{font-size: 1.167em; width: calc(100% - 58px); padding: 0px 10px; color:#000;white-space:nowrap;overflow:hidden;text-overflow:ellipsis; box-sizing: border-box;}
.popup_sbox .pagination_wrap{position:absolute;width: 67px;height: 24px;right: 0;bottom: -24px;}
.popup_sbox .pagination_wrap .swiper-pagination {left: -10px;top: 5.5px;font-family:font_gs, sans-serif;display: inline-block;color: rgba(255,255,255,0.5);font-size:0;}
.popup_sbox .pagination_wrap .swiper-pagination span{font-size:11px;}
.popup_sbox .pagination_wrap .swiper-pagination-current{font-size:11px;font-weight:600;opacity:1;color: #000;}
.popup_sbox .pagination_wrap .swiper-pagination-total{position:relative;font-size:11px;opacity:0.5;color: #000;margin-left: 5px;}
.dim{position:fixed; top:0; right:0; bottom:0; left:0; z-index:99; opacity:0.7; background-color:#000;}
</style>
<script>
	var timer;
	var today;
	var todayNew;
	function setDate(){
	    var date = todayNew.getDate();
	    var month = todayNew.getMonth()+1;
	    var newDate = month +""+ date;
	    return newDate;
	}

	function Timer(){
	    var now = new Date();
	    var end = new Date();
	    end.setHours(23);
	    end.setMinutes(59);
	    end.setSeconds(59);
	    
	    var H = end.getHours() - now.getHours();
	    var M = end.getMinutes() - now.getMinutes();
	    var S = end.getSeconds() - now.getSeconds();
	    
	    if((now.getDate() - today.getDate()) > 0){
	        //alert("현재 시각 정시 기준으로\n원데이 특가가 업데이트 되었습니다.");
	        location.replace("/m/welcomeMain?"+H+M+S);
	    }
	    $("#txtOddTime").text(lpad(H, 2, '0') + ":" + lpad(M, 2, '0') + ":" + lpad(S, 2, '0'));
	}
	
	var munguGift = {
	 today : new Date()
	,timer : null
	,mainBannerSwiper01 : null
	,mainBannerSwiper04 : null
	,mainBannerSwiper05 : null
	,mainBannerSwiper06 : null
	,changeTime : function(){
		var now = new Date();
	    var end = new Date();
	    
	    end.setHours(23);
	    end.setMinutes(59);
	    end.setSeconds(59);
	    
	    var H = end.getHours() - now.getHours();
	    var M = end.getMinutes() - now.getMinutes();
	    var S = end.getSeconds() - now.getSeconds();
	    
	    //36e5는 60 * 60 * 1000의 과학 표기법. 남은시간 / 24 * 100. 소수점 첫째자리까지 가져오기
	    var percent = ((Math.abs(end - now) / 36e5) / 24 * 100).toFixed(1);
	    $("#gauge").css("height" , percent + "%");
	    
	    if((now.getDate() - munguGift.today.getDate()) > 0){
	        //alert("현재 시각 정시 기준으로\n원데이 특가가 업데이트 되었습니다.");
	        location.replace("/m/biz/welcomeMain?"+H+M+S);
	    }
	    $("#txtOddTime").html(lpad(H, 2, '0') + "<span> : </span>" + lpad(M, 2, '0') + "<span> : </span>" + lpad(S, 2, '0'));
	}
	,bestKeywordMore : function(){
		if($("#bestKeywordArea").children().last().is(":hidden")){
			$(".cont03 .btn_more").addClass("on");
			$(".cont03 .btn_more span").text("인기검색어 접기");
			$("#bestKeywordArea").children().show();
		}else{
			$(".cont03 .btn_more").removeClass("on");
			$(".cont03 .btn_more span").text("인기검색어 더보기");
			$("#bestKeywordArea").children(':gt(2)').hide();
		}
	}
	,swiperLoad : function(){
		var bnrObj = mainFn();
		munguGift.mainBannerSwiper01 = bnrObj["mainBannerSwiper01"];
		munguGift.mainBannerSwiper02 = bnrObj["mainBannerSwiper02"];
		munguGift.mainBannerSwiper03 = bnrObj["mainBannerSwiper03"];
		munguGift.mainBannerSwiper04 = bnrObj["mainBannerSwiper04"];
	}
	, getLiveBestList:function(type){
		if(isEmpty(type)){
			type = 'liveBest';
		}
		
		$.ajax({
			url: "/m/biz/welcome/getLiveBestList"
			, async:true
			, type:"POST"
			, data:{
				type: type
			}
	        ,dataType: "json"
	        ,success : function(data){
	        	var append = '';
               	$('#liveBest').empty();
               	
               	
                if(!isEmpty(data)) {
					var list = data.list;
					if(!isEmpty(list)) {
						var endInt = list.length<20?list.length:20;
						for(var i=0; i < endInt; i++) {
							append += '<div class="swiper-slide">';
							append += '	<a href="javascript:;" class="MB_MAIN_GIFT_4_2" onclick="location.href=\'/p/'+list[i].sellPrdtBcode+'\';return false;">';
							append += '		<div class="thum">';
							if(list[i].sellPrdtGbn == 'R' || list[i].sellPrdtGbn == 'D'){
		                	    append += '		<img src="http://image.kyobobook.co.kr/newimages/music/midi/'+list[i].rcrdCd.substring( 1, 5 ).split("").reverse().join("")+'/'+list[i].rcrdCd+'.jpg" alt="'+list[i].prdtName+'" class="photo" >';
	                	    }else{
		                	    append += '		<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/goods/400/'+list[i].productImageUrl+'" alt="'+list[i].prdtName+'" class="photo" onerror="this.src=\'http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/no_image2.gif\';">';
	                	    }
							append += '		</div>';
							append += '		<p class="tit">'+list[i].prdtName+'</p>';
							append += '			<p class="price font_t">';
							append += 				price_format(list[i].lastCpnPrice);
							if(list[i].lastCpnPrice != list[i].prdtSellPrice){
								var rate = 100 - ((list[i].lastCpnPrice / list[i].prdtSellPrice) * 100);
		                	    append += '				<span class="percent">'+parseInt(rate)+'%</span>';
	                	    }
							append += '			</p>';
							append += '	</a>';
							append += '</div>';
						}
						$('#liveBest').html(append);
						
						var nowPage = Number($("#pdPage").text());
				   		var totalPage = Number($("#pdTotalPage").text());
				   		var page = nowPage + 1;
				   		
				   		if(page <= totalPage){
				   			$("#pdPage").text(page);
				   		}else if(page > totalPage){
				   			$("#pdPage").text(1);
				   		}
					}
                }
	        }
			,complete: function(){
				new Swiper('.main_wrapper .cont04 .swiper-container', {
					slidesPerView: 'auto',
					spaceBetween: 8,
					speed: 1000,
					freeMode: true,
					scrollbar: '.swiper-scrollbar',
					draggable: true
				});
			}
	        ,error: function(request, status, error) {
	            if(request.status != 0){
	                $('.cont04').hide();
	            }
	        }
	    });
	}
	, getRecobellMainList:function() {
		$.ajax({
			url: "/m/biz/welcome/getRecobellMainList"
			, async:true
			, type:"POST"
	        ,dataType: "json"
	        ,success : function(data){
	        	var append = '';
               	$('#recobellList').empty();
	        	
	            if (data) {
	                if(!isEmpty(data)) {
						var list = data.list;
						if(!isEmpty(list)) {
							append += '<h3 class="MB_MAIN_GIFT_7">내게 맞는 <strong>추천상품</strong><a href="/m/biz/personal/personalRecommend" return false;" class="btn_detail">더보기</a></h3>';
							append += '<div class="swiper-container">';
							append += '	<div class="swiper-wrapper">';
							for(var i=0; i < list.length; i++) {
								append += '	<div class="swiper-slide">';
								append += '		<a href="javascript:;" class="MB_MAIN_GIFT_7_1" onclick="javascript:goPrdtPage('+list[i].sellPrdtBcode+'); return false;">';
								append += '			<div class="thum">';
								if(list[i].sellPrdtGbn == 'R' || list[i].sellPrdtGbn == 'D'){
			                	    append += '		<img src="http://image.kyobobook.co.kr/newimages/music/midi/'+list[i].rcrdCd.substring( 1, 5 ).split("").reverse().join("")+'/'+list[i].rcrdCd+'.jpg" alt="'+list[i].prdtName+'" class="photo" >';
		                	    }else{
			                	    append += '		<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/goods/400/'+list[i].productImageUrl+'" alt="'+list[i].prdtName+'" class="photo" onerror="this.src=\'http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/no_image2.gif\';">';
		                	    }
								append += '			</div>';
								append += '			<p class="tit">'+list[i].prdtName+'</p>';
								append += '			<p class="price font_t">';
								append += 				price_format(list[i].lastCpnPrice);
								if(list[i].lastDcRate != 0){
			                	    append += '				<span class="percent">'+list[i].lastDcRate+'%</span>';
		                	    }
								append += '			</p>';
								append += '		</a>';
								append += '	</div>';
		                	}
							append += '	</div>';
							append += '	<div class="swiper-scrollbar"></div>';
							append += '</div>';
						}
						$('#recobellList').html(append);
	                }
	            }
	        }
			,complete: function(){
				new Swiper('.main_wrapper .cont05 .swiper-container', {
					slidesPerView: 'auto',
					spaceBetween: 8,
					speed: 1000,
					slidesPerColumn: 2,
					freeMode: true,
					scrollbar: '.swiper-scrollbar',
					draggable: true
				});
			}
	        ,error: function(request, status, error) {
	            if(request.status != 0){
	                /* alert('서비스 수행도중 오류가 발생하였습니다. 잠시후 다시 이용해주세요.\n(※ 지속적으로 오류가 나는 경우 고객센터에 문의바랍니다.)'); */
	            	$('.cont05').hide();
	            }
	        }
	    });
	}
	, getSpecialItemList:function(type){
		$.ajax({
			url: "/m/biz/welcome/getSpecialItemList"
			, async:true
			, type:"POST"
			, data:{
				type: type
			}
	        ,dataType: "json"
	        ,success : function(data){
	        	var append = '';
               	$('.cont08ListArea').empty();
               	
                if(!isEmpty(data)) {
					var list = data.list;
					if(!isEmpty(list)) {
						for(var i=0; i < list.length; i++) {
							append += '<li class="MB_MAIN_GIFT_11">';
							append += '	<a href="javascript:;" onclick="location.href=\'/m/gift/detail/'+list[i].sellPrdtBcode+'\';return false;">';
							append += '		<div class="thum">';
							if(list[i].sellPrdtGbn == 'R' || list[i].sellPrdtGbn == 'D'){
		                	    append += '		<img src="http://image.kyobobook.co.kr/newimages/music/midi/'+list[i].rcrdCd.substring( 1, 5 ).split("").reverse().join("")+'/'+list[i].rcrdCd+'.jpg" alt="'+list[i].prdtName+'" class="photo" >';
	                	    }else{
		                	    append += '		<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/goods/400/'+list[i].productImageUrl+'" alt="'+list[i].prdtName+'" class="photo" onerror="this.src=\'http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/no_image2.gif\';">';
	                	    }
							append += '		</div>';
							append += '		<p class="tit">'+list[i].prdtName+'</p>';
							append += '			<p class="price font_t">';
							append += 				price_format(list[i].lastCpnPrice);
							if(list[i].lastCpnPrice != list[i].prdtSellPrice){
								var rate = 100 - ((list[i].lastCpnPrice / list[i].prdtSellPrice) * 100);
		                	    append += '				<span class="percent">'+parseInt(rate)+'%</span>';
	                	    }
							append += '			</p>';
							append += '	</a>';
							append += '</li>';
						}
						$('.cont08ListArea').html(append);
					}
                }
	        }
	        ,error: function(request, status, error) {
	            if(request.status != 0){
	                /* alert('서비스 수행도중 오류가 발생하였습니다!!. 잠시후 다시 이용해주세요.\n(※ 지속적으로 오류가 나는 경우 고객센터에 문의바랍니다.)'); */
	            	$('.cont08').hide();
	            }
	        }
	    });
	}
	, getMainCtgrBestList:function() {
		$.ajax({
			url: "/m/biz/welcome/getMainCtgrBestList"
			, type:"POST"
			, async:true
	        ,dataType: "json"
	        ,success : function(data){
	        	var append = '';
               	$('#ctgrBest').empty();
	            if (data) {
	                if(!isEmpty(data)) {
						var list = data.list;
						var data = data.ctgryData;
						if(!isEmpty(list)) {
							for(var i=0; i < list.length; i++) {
								var list2 = list[i];
									for(var j=0; j < list2.length; j++) {
										if(j==0){
											var ctId= '';
											switch ( list2[j].ctgrId ) {
										        case 'C1491': ctId = '000020'; break;
										        case 'C1492': ctId = '000022'; break;
										        case 'C1493': ctId = '000007'; break;
										        case 'C1494': ctId = '000021'; break;
										        case 'C1495': ctId = '000025'; break;
										        case 'C1496': ctId = '000026'; break;
										        case 'C1497': ctId = '000024'; break;
										        case 'C1498': ctId = '000028'; break;
										        case 'C1499': ctId = '000006'; break;
										        case 'C149A': ctId = '000027'; break;
										        case 'C149B': ctId = '000023'; break;
										        case 'C149C': ctId = '000029'; break;
										      }
											
											append += '<div class="cont category">';
											append += '<h3 class="MB_MAIN_GIFT_15"><strong>'+list2[j].ctgrName+'</strong><a href="/m/gift/biz/category/'+ctId+'" class="btn_detail">더보기</a></h3>';
										 	append += '<div class="top_banner">';
											append += '	<a href="/m/biz/eventDetail?eventId='+data[i].eventId+'" class="MB_MAIN_GIFT_15_1">';
											append += '		<div class="img_wrap">';
											append += '		<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/'+data[i].bnrImgUrl+'" alt="'+data[i].bnrImgAlt+'" onerror="this.src=\'http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/no_image2.gif\';">';
											append += '		</div>';
											if(data[i].discRate != null && data[i].discRate != '0'){
												append += '	<span class="font_t percent">'+data[i].discRate+'%</span>';
											}
													
											append += '		<strong>'+data[i].eventTitle+'</strong>';
											if(data[i].eventDtlCont != null){
												append += '	<p>'+data[i].eventDtlCont+'</p>';
											}
											append += '	</a>';
											append += '</div>';
											append += '<div class="pd_list">';
											append += '	<ul>';
										}
								
										append += '	<li class="MB_MAIN_GIFT_15_1">';
										append += '	<a href="javascript:;" onclick="location.href=\'/m/gift/detail/'+list2[j].sellPrdtBcode+'\';return false;">';
										append += '		<div class="thum">';
										if(list2[j].sellPrdtGbn == 'R' || list2[j].sellPrdtGbn == 'D'){
					                	    append += '		<img src="http://image.kyobobook.co.kr/newimages/music/midi/'+list2[j].rcrdCd.substring( 1, 5 ).split("").reverse().join("")+'/'+list2[j].rcrdCd+'.jpg" alt="'+list2[j].prdtName+'" class="photo" >';
				                	    }else{
					                	    append += '		<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/goods/400/'+list2[j].productImageUrl+'" alt="'+list2[j].prdtName+'" class="photo" onerror="this.src=\'http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/no_image2.gif\';">';
				                	    }
										append += '		</div>';
										append += '			<p class="tit">'+list2[j].prdtName+'</p>';
										append += '			<p class="price font_t">';
										append += 				price_format(list2[j].lastCpnPrice);
										if(list2[j].lastCpnPrice != list2[j].prdtSellPrice){
											var rate = 100 - ((list2[j].lastCpnPrice / list2[j].prdtSellPrice) * 100);
					                	    append += '				<span class="percent">'+parseInt(rate)+'%</span>';
				                	    }
										append += '			</p>';
										append += '	</a>';
										append += '</li>';
								}
								append += '	</ul>';
								append += '	</div>';
								append += '</div>';
							}
						}
						$('#ctgrBest').html(append);
	                }
	            }
	        }
	        ,error: function(request, status, error) {
	            if(request.status != 0){
	                /* alert('서비스 수행도중 오류가 발생하였습니다. 잠시후 다시 이용해주세요.\n(※ 지속적으로 오류가 나는 경우 고객센터에 문의바랍니다.)'); */
	            	$('#ctgrBest').hide();
	            }
	        }
	    });
	}
};
$(document).ready(function(){
	
	
	$('.popup_sbox .btn_tclose, .popup_sbox .btn_pclose').click(function(){
		//슬라이드 닫기 버튼 클릭시 슬라이드 닫히면서 dim도 닫힘
		$('.popup_sbox').hide();
		$('.dim').hide();
		$("body").removeClass("noscroll");
	});
	
	//띠배너
	var arry = [];
	$('.banner_wrap li p').each(function (i, e){
		if( $(e).is(':empty') ){
			$(e).hide();
		}else{
			arry.push($(e).addClass('other'+i));
		}
	});
	//띠배너 종료
	
	$('#gnbMunguGift').addClass('active');
	
	sideMenu(); //side menu
	topMenu(); //main tob menu
	//배너 스와이퍼 셋팅
	munguGift.swiperLoad();
	
	$("#layer_banner").appendTo("body");
	
	//배너 레이어 팝업
	subFn();
	
	today = new Date();
    todayNew = new Date();
    Timer();
    timer = setInterval(Timer, 1000);
	
    //앱다운로드 레이어 팝업
	var userAgent = navigator.userAgent.toUpperCase();
	if (!userAgent.match(/APP:HOTTRACKS/)){
		$(".ly-main-banner").each(function(){
			var id = $(".ly-main-banner").attr("id").replace("#", "");
			
			if(getCookie(id) != ("Y"+setDate())){
				$(".ly-main-banner").show();
				$("body").addClass("noscroll");
	        }	
	    });
	}
	
	
	$('#appDownPop a').click(function(){
		//앱다운로드 클릭시 앱다운로드 닫히면서 dim의 투명도 변경
		$('#appDownPop').hide();
		if($('.popup_sbox').length <= 0){
			$('.dim').hide();
			$("body").removeClass("noscroll");
		}else{
			$('.dim').css('opacity', '0.7');
			$("body").addClass("noscroll");
		}
	});

	//이벤트 슬라이드 레이어
	$(".popup_sbox").each(function(){
		var popupSboxId = $(".popup_sbox").attr("id").replace("#", "");
		
		if(getCookie(popupSboxId) != ("Y"+setDate())){
			$(".popup_sbox").show();
			$("body").addClass("noscroll");
		}else{
			$('.dim').hide();
		}
    });
	
	//딤처리
	dimSort();
	//딤처리 종료
	
    //오늘의 특가가 있을떄
    if($("#gauge").length > 0){ 
        /* timer start */
        munguGift.today = new Date();
        
	    munguGift.changeTime();
	    munguGift.timer = setInterval(munguGift.changeTime, 1000);
    }
    
    $('.cont04Menu').click(function(e){
    	$('.cont04Menu').removeClass('active');
    	$(this).addClass('active');
    	
    	munguGift.getLiveBestList($(this).attr('type'));
    });

    $('#pdBtn').click(function(e){
    	var nowPage = Number($("#pdPage").text());
   		var totalPage = Number($("#pdTotalPage").text());
   		var page = nowPage + 1;
   		var type = $('.main_wrapper .pdTitle:visible').next().attr('type');
   		
   		if(type == null || type == undefined){
			type = $('.main_wrapper .pdTitle').first().attr('type');
		}
   		
   		if(page <= totalPage){
   			$("#pdPage").text(page);
   		}else if(page > totalPage){
   			$("#pdPage").text(1);
   		}
   		
       	$('.main_wrapper .pdTitle').hide();
       	$('.main_wrapper .pdTitle[type=' + type + ']').show();
    	
    	munguGift.getSpecialItemList(type);
    });
    
    $(".layer_banner_top").bind("touchmove", function(e) {
    	e.preventDefault();
    });
    
	var swiperpopup = new Swiper('.popup_sbox .swiper-container', {
        slidesPerView: 'auto',
        spaceBetween: 5,
        speed: 1000,
        autoplay: 1000,
        draggable: true,
        pagination: '.swiper-pagination',
        paginationType: 'fraction'
	});
    
    munguGift.getLiveBestList('liveBest');	// 실시간 인기/베스트
    munguGift.getRecobellMainList();	// 내게 맞는 추천 상품
    munguGift.getSpecialItemList($('.main_wrapper .pdTitle:visible').attr('type')); // 기획상품
    munguGift.getMainCtgrBestList();	// 카테고리별 추천
    
    $('.page-menu.menu-gift').addClass('active');
    $('.coin-wrap .coin').html("음반");
});
function goPrdtPage(url){
	location.href='/p/'+url+'?foo=bar&rccode=mo_main1';
}
function dimSort(){
	if( $('#appDownPop').length <= 0 ){
		$('.dim').css('opacity', '0');
		$("body").addClass("noscroll");
	}
	if($('.popup_sbox').length <= 0){
		$('.dim').hide();
	}
	
} 


</script>	
</head>

<body>
 	<%-- <c:if test="${empty todayBnr || todayBnr eq 'N'}">
		<c:forEach items="${listBnrPop}" var="l" varStatus="st">
		    <c:if test="${st.first}">
		        <div id="layerBanner${l.bnrSeq}" class="ly-main-banner" style="display:none;position:fixed;left:0;top:0;width:100%;height:100%;background:url('/images/season01/bg_layer02.png');z-index:999;display:none;">
		            <div style="display: block;margin:20px auto;max-width:290px;position: relative;top:50%;margin-top:-150px;">
		                <c:choose>
		                    <c:when test="${l.bnrLnkUrl eq '~'}"><ui:image src="${l.bnrImgUrl}" style="width:100%;"/></c:when>
		                    <c:otherwise>
		                        <a href="#" onclick="location.href='${l.bnrLnkUrl}';return false;" style="position:relative;font-size:15px;font-weight:bold;"><ui:image src="${l.bnrImgUrl}" style="width:100%;"/></a>
		                    </c:otherwise>
		                </c:choose>
		                <a href="#" onclick="Fn_closeLayer('#layerBanner${l.bnrSeq}', 'Y', setDate());return false;" style="display:block;color:#fff;text-decoration:underline;margin-top:10px;text-align:center;">오늘 하루 그만보기</a>
		                <a href="#" onclick="Fn_closeLayer('#layerBanner${l.bnrSeq}', 'N', setDate());return false;" style="position: absolute;top: -25px;right: 0;display: block;width: 20px;height: 20px;background: url(/images/season01/btn_close01.png) 50% 50% no-repeat;text-indent: -999px;overflow: hidden;background-size: 31px 31px;">닫기</a>
		            </div>
		        </div>
		    </c:if>
		</c:forEach>
	</c:if> --%>
	
	<div class="dim"></div>
	
	<!-- 앱다운 팝업 배너 -->
    <div id="appDownPop" class="ly-main-banner" style="display:none;position:fixed;left: 0px;top: 0px;width: 100%;height: 100%;background: url(&quot;/images/season01/bg_layer02.png&quot;);z-index: 99999;">
        <div style="display:block;margin:20px auto;max-width:290px;position: relative;top:50%;margin-top:-150px;">
            <a href="#n" onclick="linkToDevice('Y');return false;" style="position:relative;font-size:15px;font-weight:bold;">
                <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/resources/img/device/btn_appdown.png" style="width:100%;">
            </a>
            <a href="#n" onclick="Fn_closeLayer('#appDownPop', 'Y', setDate());return false;" style="display:block;color:#fff;text-decoration:underline;margin-top:25px;text-align:center;">괜찮아요, 모바일웹으로 볼게요</a>
        </div>
    </div>
    <!--/ 앱다운 팝업 배너 -->
    
    <!-- 팝업 슬라이드 배너 -->
    <c:if test="${empty todayBnr || todayBnr eq 'N'}">
    	<c:if test="${not empty listBnrPop}">
    		<div id="eventPopSlide" class="popup_sbox" style="display:none;">
		        <div class="tit_a">
		            <a href="#n" onclick="Fn_closeLayer('#eventPopSlide', 'Y', setDate());return false;" class="btn_tclose">오늘 하루 그만보기</a>
		            <a href="#n" onclick="Fn_closeLayer('#eventPopSlide', 'N', setDate());return false;" class="btn_pclose">닫기</a>
		        </div>
		        <div class="swiper-container">
	            	<div class="swiper-wrapper">
						<c:forEach items="${listBnrPop}" var="l" varStatus="st">
				    		<div class="swiper-slide">
			                    <a href="#" onclick="location.href='${l.bnrLnkUrl}';return false;">
			                        <div class="thum">
			                            <ui:image src="${l.bnrImgUrl}" style="width:100%;"/>
			                        </div>
			                        <c:if test="${not empty l.bnrTitle}">
				                        <div class="txt_a">
				                            <strong>${l.bnrTitle}</strong>
				                            <p>${l.bnrSubTitle}</p>
					                        <c:if test="${not empty l.flagCd}">
												<c:if test="${l.flagCd eq 'C1481'}">
													<div class="discount-box hot">
														<i>~</i>
														<em>NEW</em>
													</div>
												</c:if>
												<c:if test="${l.flagCd eq 'C1482'}">
													<div class="discount-box hot">
														<i>~</i>
														<em>HOT</em>
													</div>
												</c:if>
												<c:if test="${l.flagCd eq 'C1483'}">
													<div class="discount-box gift">
														<i>~</i>
														<em>사은품</em>
													</div>
												</c:if>
												<c:if test="${l.flagCd eq 'C1484'}">
													<div class="discount-box ship">
														<i>~</i>
														<em>무료<br>배송</em>
													</div>
												</c:if>
												<c:if test="${l.flagCd eq 'C1485'}">
													<c:if test="${not empty l.discRate}">
														<div class="discount-box">
															<i>~</i>
															<em>${l.discRate}%</em>
														</div>
													</c:if>	
												</c:if>								
												<c:if test="${l.flagCd eq 'C1486'}">
													<div class="discount-box hot">
														<i>~</i>
														<em>1+1</em>
													</div>
												</c:if>								
											</c:if>
				                        </div>
			                        </c:if>
			                    </a>
			                </div>
				    	</c:forEach>
		    		</div>
		            <div class="pagination_wrap">
		                <div class="swiper-pagination"></div>
		            </div>
		        </div>
	    	</div>
		</c:if>
	</c:if>
    <!--/ 팝업 슬라이드 배너 -->

	<input type="hidden" name="eof" value="0"/>
	
	<!-- content -->
	<div id="content">
		<div class="main_wrapper">
	<!-- /////////상단 롤링 배너///////// -->
	<c:if test="${not empty mgftRollBnrList and fn:length(mgftRollBnrList) > 0}">
		<div class="cont cont01">
			<div class="swiper-container">
				<div class="swiper-wrapper">
					<c:forEach items="${mgftRollBnrList}" var="l" varStatus="st">
						<div class="swiper-slide ${l.signWayGbn eq 'C1451' ? 'type02' : 'type01'}">
							<a href="javascript:;" class="MB_MAIN_GIFT_1" onclick="location.href='${l.bnrLnkUrl}';return false;">
								<c:if test="${not empty l.flagCd}">
									<c:if test="${l.flagCd eq 'C1481'}">
										<span class="tag_new">NEW</span>
									</c:if>
									<c:if test="${l.flagCd eq 'C1482'}">
										<span class="tag_hot">HOT</span>
									</c:if>
									<c:if test="${l.flagCd eq 'C1483'}">
										<span class="tag_gift">사은품</span>
									</c:if>
									<c:if test="${l.flagCd eq 'C1484'}">
										<span class="tag_free"><p>무료</p><p>배송</p></span>
									</c:if>
									<c:if test="${l.flagCd eq 'C1485'}">
										<c:if test="${not empty l.discRate}">
											<span class="tag_percent"><p>~</p><strong>${l.discRate}</strong>%</span>
										</c:if>	
									</c:if>								
								</c:if>
								<ui:image src="${l.bnrImgUrl}" alt="${l.bnrImgAlt}"/>
								
								<c:if test="${l.signWayGbn ne 'C1451'}">
									<div class="info">
										<p class="tit">${l.bnrTitle}</p>
										<c:if test="${l.signWayGbn eq 'C1453'}">
											<p class="txt">${l.bnrSubTitle}</p>
										</c:if>
									</div>
								</c:if>
							</a>
						</div>
					</c:forEach>	
				</div>
				
				<!-- swiper-pagination -->
				<div class="pagination_wrap">
					<a href="javascript:" class='paging_link'>
						<div class="swiper-pagination"></div>
						<div class="plus_inner MB_MAIN_GIFT_1_1">
							<a href="javascript:" class="btn_plus"></a>
						</div>
					</a>
				</div>
			</div>
		</div>
	</c:if>
	<!--// 상단 롤링 배너 -->
	
	<!-- 메인 탑링크 -->
	<div class="main_toplink_a">
	    <ul class="main_toplink">
            <li class="MB_MAIN_QUICK_1">							
                <a href="javascript:;" onclick="location.href='/m/biz/hot/best/';return false;">
                    <i class="ico01"></i>
                    <span>베스트</span>
                </a>	
            </li>
            <li class="MB_MAIN_QUICK_2">							
                <a href="javascript:;" onclick="location.href='/m/biz/hot/eventMain';return false;">
<!-- 				<a href="javascript:;" onclick="location.href='/m/biz/hot/eventMain?type=type02&newEventDispTypeCode=C1533';return false;"> -->
                    <i class="ico02"></i>
                    <span>이벤트</span>
                </a>	
            </li>
            <li class="MB_MAIN_QUICK_3">							
                <a href="javascript:;" onclick="location.href='/m/biz/hot/best?dispMstrId=CATE_GFT_NEW';return false;">
                    <i class="ico03"></i>
                    <span>신상품</span>
                </a>	
            </li>
            <li class="MB_MAIN_QUICK_4">							
                <a href="javascript:;" onclick="location.href='/m/biz/hot/best?dispMstrId=CATE_GFT_SALE';return false;">
                    <i class="ico04"></i>
                    <span>할인</span>
                </a>	
            </li>
            <li class="MB_MAIN_QUICK_5">							
                <a href="javascript:;" onclick="location.href='/m/biz/hot/best?dispMstrId=FREE_DELIVERY_BEST';return false;">
                    <i class="ico05"></i>
                    <span>무료배송</span>
                </a>	
            </li>
        </ul>
	</div>
	<!-- / 메인 탑링크 -->

	<!-- /////////오늘만 특가 [최대 4개]///////// -->
	<c:if test="${not empty hotdeal}">
		<div class="cont cont02">
			<c:choose>
				<c:when test="${not empty hotdeal.eventId}">
					<c:set var="linkUrl" value="/m/biz/eventDetail?eventId=${hotdeal.eventId}"/>
				</c:when>
				<c:otherwise>
					<c:set var="linkUrl" value="/m/gift/detail/${hotdeal.sellPrdtBcode}"/>
				</c:otherwise>
			</c:choose>
			<h3 class="MB_MAIN_GIFT_2">오늘만 <strong>특가</strong><a href="javascript:;" onclick="location.href='${linkUrl}';return false;" class="btn_detail">더보기</a></h3>
			<strong class="font_t time" id="txtOddTime"></strong>	
						
			<div class="product">
				<span class="percent font_t">				
					<c:choose>
						<c:when test="${not empty hotdeal.prdtDscntRate and hotdeal.prdtDscntRate ne '0'}">
							<fmt:parseNumber var="rate" integerOnly="true" value="${hotdeal.prdtDscntRate}"/>
						</c:when>
						<c:otherwise>
							<fmt:parseNumber var="rate" integerOnly="true" value="0"/>
<%-- 							<fmt:parseNumber var="rate" integerOnly="true" value="${hfn:rate(hotdeal.prdtSellPrice, hotdeal.lastCpnPrice)}"/> --%>
						</c:otherwise>
					</c:choose>
					<c:if test="${rate > 0}">
						<em>${rate}</em>%
					</c:if>
				</span>
				<a href="javascript:;" class="main_pd MB_MAIN_GIFT_2_1" onclick="location.href='${linkUrl}';return false;">
					<div class="thum">
						<ui:image src="${hotdeal.productImageUrl}" server="product" alt="${hotdeal.prdtName}"/>
					</div>
					
					<c:if test="${hotdeal.freeDlvyYn == 'Y'}">
						<span class="label">무료배송</span>
					</c:if>
					
					<p class="tit">${hotdeal.prdtName}</p>
					<p class="price font_t">
						<c:if test="${not empty hotdeal.prdtDscntRate and hotdeal.prdtDscntRate ne '0'}">
							<em class="discount"><fmt:formatNumber type="number" value="${hotdeal.prdtSellPrice}"/></em>
							<fmt:formatNumber type="number" value="${hotdeal.lastCpnPrice}"/>			
						</c:if>
<%-- 						<c:if test="${hotdeal.prdtSellPrice ne hotdeal.lastCpnPrice}"> --%>
<%--                             <em class="discount"><fmt:formatNumber type="number" value="${hotdeal.prdtSellPrice}"/></em> --%>
<%--                         </c:if> --%>
						<fmt:formatNumber type="number" value="${price}"/>
					</p>
				</a>
			</div>
			
			<ul class="event">
				<c:forEach items="${listHotdeal}" var="l" varStatus="st">
					<li class="MB_MAIN_GIFT_2_2">
						<a href="javascript:;" onclick="location.href='${linkUrl}';return false;">
							<div class="thum">
								<ui:image src="${l.productImageUrl}" server="product" alt="${l.prdtName}"/>
							</div>
							<span class="percent font_t">
<%-- 								<c:choose> --%>
<%-- 									<c:when test="${not empty l.eventDscntRate and l.eventDscntRate ne '0'}"> --%>
<%-- 										<fmt:parseNumber var="rate" integerOnly="true" value="${l.eventDscntRate}"/> --%>
<%-- 									</c:when> --%>
<%-- 									<c:otherwise> --%>
										<fmt:parseNumber var="rate" integerOnly="true" value="${hfn:rate(l.prdtSellPrice, l.lastCpnPrice)}"/>
<%-- 									</c:otherwise> --%>
<%-- 								</c:choose> --%>
								<c:if test="${rate > 0}">
									${rate}%
								</c:if>
							</span>
						</a>
					</li>
				</c:forEach>
			</ul>
			
			<!-- 남은 시간 -->
			<div class="time_line">
				<span class="txt">남은시간</span>
				<div class="bar">
					<span id="gauge" style="height:0%;"></span>
				</div>
			</div>
		</div>
	</c:if>
	<!--// 오늘만 특가 -->

	<!-- /////////급상승 인기 검색어///////// -->
	<c:if test="${not empty listBestKeyword}">
		<div class="cont cont03">
			<h3>급상승 <strong>인기 검색어</strong></h3>
			<div class="keyword_wrap">
				<ul id="bestKeywordArea">
					<c:forEach items="${listBestKeyword}" var="l" varStatus="st" end="9">
						<li class="MB_MAIN_GIFT_3" style="<c:if test="${st.count > 3}">display:none;</c:if>">
							<a href="javascript:;" onclick="gnbSrchKerword('${l.keyword}');return false;">
								<em class="font_t">${st.count}</em>
								<p>${l.keyword}</p>
								<!-- ▲ up , ▼ down : class 추가 -->
								<c:choose>
		                        	<c:when test="${l.prevRank == 0}">
		                        		<span class="txt"><strong>NEW</strong></span>
		                        	</c:when>
		                        	<c:when test="${(l.prevRank - l.ranking) == 0}">
		                        		<span class="txt">-</span>
		                        	</c:when>
		                        	<c:when test="${l.prevRank < l.ranking}">
		                        		<span class="num down">${(l.prevRank - l.ranking) * -1}</span>
		                        	</c:when>
		                        	<c:otherwise>
	                        			<span class="num up">${l.prevRank - l.ranking}</span>
		                        	</c:otherwise>
		                        </c:choose>
							</a>
						</li>
	                </c:forEach>
				</ul>
				<a href="javascript:;" onclick="munguGift.bestKeywordMore();return false;" class="btn_more MB_MAIN_GIFT_3_1"><span>인기검색어 더보기</span></a>
			</div>
		</div>
	</c:if>
	<!--// 급상승 인기 검색어 -->

	<!-- /////////실시간 인기 / 베스트///////// -->
	<div class="cont cont04">
		<div class="tab">
			<ul>
				<li type="liveBest" class="cont04Menu MB_MAIN_GIFT_4 active"><a href="#" onclick="javacript:event.preventDefault();">실시간 인기</a></li>
				<li type="best"  class="cont04Menu MB_MAIN_GIFT_4_1"><a href="#" onclick="javacript:event.preventDefault();">베스트</a></li>
			</ul>
		</div>
		<div class="swiper-container">
			<div class="swiper-wrapper" id="liveBest">
			</div>
			<!-- 스크롤바 -->
			<div class="swiper-scrollbar"></div>
		</div>
	</div>
	<!--// 실시간 인기 / 베스트 -->
	
	<!-- /////////띠배너///////// -->
	<c:if test="${not empty mgftTextBnrList}">
			<div class="banner_wrap">
				<c:forEach items="${mgftTextBnrList}" var="l" varStatus="st">
				<ul>
					<li>
						<a href="${l.bnrLnkUrl}">
							<c:choose>
								<c:when test="${l.bnrImgUrl eq ' '}">
									<p>${l.bnrTitle}</p>
								</c:when>
								<c:otherwise>
									<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${l.bnrImgUrl}">
								</c:otherwise>
							</c:choose>
						</a>
					</li>
				</ul>
				</c:forEach>
			</div>
	</c:if>
	
	
<%-- 	<c:if test="${not empty mgftImgBnrList}"> --%>
<!-- 		<div class="banner_wrap type02"> -->
<!-- 			<ul> -->
<%-- 	            <c:forEach items="${mgftImgBnrList}" var="l"> --%>
<!-- 	            	<li> -->
<%-- 		                <a href="${l.bnrLnkUrl}" class="MB_MAIN_VIEWER"> --%>
<%-- 		                	<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${l.bnrImgUrl}"> --%>
<!-- 		                </a> -->
<!-- 	            	</li> -->
<%--                	</c:forEach> --%>
<!-- 	        </ul> -->
<!-- 		</div> -->
<%-- 	</c:if> --%>
	
<%-- 	<c:if test="${not empty mgftTextBnrList}"> --%>
<!-- 		<div class="banner_wrap type01"> -->
<!-- 			<ul> -->
<%-- 				<c:forEach items="${mgftTextBnrList}" var="l" varStatus="st"> --%>
<%-- 					<li class="banner0${st.count} MB_MAIN_GIFT_5 mt0"> --%>
<%-- 						<a href="javascript:;" onclick="location.href='${l.bnrLnkUrl}';return false;"> --%>
<%-- 							${l.bnrTitle} --%>
<!-- 						</a> -->
<!-- 					</li> -->
<%-- 				</c:forEach> --%>
<!-- 			</ul> -->
<!-- 		</div> -->
<%-- 	</c:if> --%>
	<!--// 띠배너  -->

	<!-- /////////내게 맞는 추천상품(레코벨 추천상품)///////// -->
	<div class="cont cont05" id="recobellList">
	</div>
	<!--// 내게 맞는 추천상품(레코벨 추천상품) -->

	<!-- /////////이벤트2단배너 배너///////// -->
	<c:if test="${not empty mgftEvent2BnrList}">
		<c:forEach items="${mgftEvent2BnrList}" var="l" varStatus="st">
			<div class="event_banner">
				<a href="javascript:;" class="MB_MAIN_GIFT_8" onclick="location.href='/m/biz/eventDetail?eventId=${l.eventId}';return false;">
					<div class="img_wrap">
						<ui:image src="${l.eventImageUrl}" alt="${l.eventTitle}"/>
					</div>
					<c:if test="${not empty l.discRate && l.discRate > 0}">
                       	<span class="font_t percent">${l.discRate}%</span>
                       </c:if>
					<strong>${l.eventTitle}</strong>
					<p>${l.eventDtlCont}</p>
				</a>
			</div>
		</c:forEach>
	</c:if>
	<!--// 이벤트2단배너 배너 -->

	<!-- /////////앵콜특가///////// -->
	<c:if test="${not empty encoreList}">
		<div class="cont cont06">
			<h3>앵콜 특가</h3>
			<p>한 주간 최다 판매 베스트를 모아 한정 세일</p>
			<div class="pd_list">
				<ul>
					<c:forEach items="${encoreList}" var="l" varStatus="st">
						<li class="MB_MAIN_GIFT_8">
							<a href="javascript:;" onclick="location.href='/m/biz/eventDetail?eventId=${l.eventId}';return false;">
								<div class="thum">
									<c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G'}">
										<ui:image src="${l.productImageUrl}" server="product" alt="${fn:escapeXml(l.prdtName)}"/>
									</c:if>
									<c:if test="${l.sellPrdtGbn eq 'R'}">
										<ui:image rcrdCd="${l.rcrdCd}" prdtGbn="R" ratingCode="A" alt="${fn:escapeXml(l.prdtName)}"/>
									</c:if>
									<c:if test="${l.sellPrdtGbn eq 'D'}">
										<ui:image rcrdCd="${l.rcrdCd}" prdtGbn="D" ratingCode="A" alt="${fn:escapeXml(l.prdtName)}"/>
									</c:if>
								</div>
								<div class="info">
									<p class="tit">${l.prdtName}</p>
									<p class="price font_t">
										<c:if test="${l.prdtSellPrice ne l.lastCpnPrice}">
				                            <em class="discount"><fmt:formatNumber type="number" value="${l.prdtSellPrice}"/></em>
				                        </c:if>
										<fmt:formatNumber type="number" value="${l.lastCpnPrice}"/>
										<fmt:parseNumber var="rate" integerOnly="true" value="${hfn:rate(hotdeal.prdtSellPrice, hotdeal.lastCpnPrice)}"/>
										<c:if test="${rate > 0}">
											<span class="percent">${rate}%</span>
										</c:if>
									</p>
								</div>
							</a>
						</li>
					</c:forEach>
				</ul>
			</div>
		</div>
	</c:if>
	<!--// 앵콜특가 -->
	
	<!-- /////////가로 통 배너///////// -->
	<c:if test="${not empty mgftWidthBnrList}">
		<div class="banner_wrap type02">
			<ul>
				<c:forEach items="${mgftWidthBnrList}" var="l" varStatus="st">
					<li class="MB_MAIN_GIFT_8">
						<a href="javascript:;" onclick="location.href='${l.bnrLnkUrl}';return false;">
							<ui:image src="${l.bnrImgUrl}" alt="${l.bnrImgAlt}"/>
						</a>
					</li>
				</c:forEach>
			</ul>
		</div>
	</c:if>
	<!--// 가로 통 배너 -->
	
	<!-- /////////에디터 추천///////// -->
	<c:if test="${not empty mgftEditorPrdtList}">
		<div class="cont cont07">
			<h5>에디터 <strong>추천</strong></h5>
			<div class="swiper-container">
				<div class="swiper-wrapper">
					<c:forEach items="${mgftEditorPrdtList}" var="l" varStatus="st">
						<div class="swiper-slide">
							<a href="javascript:;" class="MB_MAIN_GIFT_9" onclick="location.href='/m/gift/detail/${l.sellPrdtBcode}';return false;" class="box_prod row_item">
								<div class="thum">
                               		<c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G'}">
                                 		<ui:image src="${l.productImageUrl}" server="product" alt="${fn:escapeXml(l.prdtName)}"/>
                                 	</c:if>
                                 	<c:if test="${l.sellPrdtGbn eq 'R'}">
                                 		<ui:image rcrdCd="${l.rcrdCd}" prdtGbn="R" ratingCode="A" alt="${fn:escapeXml(l.prdtName)}"/>
                                 	</c:if>
                                 	<c:if test="${l.sellPrdtGbn eq 'D'}">
                                 		<ui:image rcrdCd="${l.rcrdCd}" prdtGbn="D" ratingCode="A" alt="${fn:escapeXml(l.prdtName)}"/>
                                 	</c:if>
                          		</div>
                           		<p class="tit">${l.prdtName}</p>
								<p class="price font_t">
									<fmt:formatNumber type="number">${l.lastCpnPrice}</fmt:formatNumber>
									<fmt:parseNumber var="rate" type="number" integerOnly="true" value="${hfn:rate(l.prdtSellPrice,l.lastCpnPrice)}"/>
                                	<c:if test="${rate > 0}">
                                		<span class="percent">${rate}%</span>
                                	</c:if>
                                 </p>
                             </a>
                            </div>
					</c:forEach>
				</div>
			</div>
		</div>
	</c:if>
	<!--// 에디터 추천 -->

	<!-- /////////세로통배너///////// -->
	<c:if test="${not empty mgftHeightBnrList}">
		<c:forEach items="${mgftHeightBnrList}" var="l" varStatus="st">
			<div class="banner_wrap type03">
				<a href="javascript:;" class="MB_MAIN_GIFT_10" onclick="location.href='${l.bnrLnkUrl}';return false;">
					<ui:image src="${l.bnrImgUrl}" alt="${l.bnrImgAlt}"/>
				</a>
			</div>
		</c:forEach>
	</c:if>
	<!--// 세로통배너 -->
	
	<!-- /////////기획상품///////// -->
	<c:if test="${mgftTheme1stMst.dispPrdtYn eq 'Y' || mgftTheme2ndMst.dispPrdtYn eq 'Y' || mgftTheme3rdMst.dispPrdtYn eq 'Y'
				 || mgftTheme4thMst.dispPrdtYn eq 'Y' || not mgftTheme5thMst.dispPrdtYn eq 'Y'}">
		<div class="cont cont08">	
			<h3>
				<c:set var="totalPage" value="0"/>
				<c:if test="${mgftTheme1stMst.dispPrdtYn eq 'Y'}" >
					<c:set var="totalPage" value="${totalPage + 1}"/>
					<strong type="pd1ST" class="pdTitle" style="display:block;">${mgftTheme1stMst.title}</strong>
				</c:if>
				<c:if test="${mgftTheme2ndMst.dispPrdtYn eq 'Y'}" >
					<c:set var="totalPage" value="${totalPage + 1}"/>
					<c:set var="dispFlag" value="display:none;"/>
					<c:if test="${totalPage == 1}">
						<c:set var="dispFlag" value="display:block;"/>
					</c:if>
					<strong type="pd2ND" class="pdTitle" style="${dispFlag}">${mgftTheme2ndMst.title}</strong>
				</c:if>
				<c:if test="${mgftTheme3rdMst.dispPrdtYn eq 'Y'}" >
					<c:set var="totalPage" value="${totalPage + 1}"/>
					<c:set var="dispFlag" value="display:none;"/>
					<c:if test="${totalPage == 1}">
						<c:set var="dispFlag" value="display:block;"/>
					</c:if>
					
					<strong type="pd3RD" class="pdTitle" style="${dispFlag}">${mgftTheme3rdMst.title}</strong>
				</c:if>
				<c:if test="${mgftTheme4thMst.dispPrdtYn eq 'Y'}" >
					<c:set var="totalPage" value="${totalPage + 1}"/>
					<c:set var="dispFlag" value="display:none;"/>
					<c:if test="${totalPage == 1}">
						<c:set var="dispFlag" value="display:block;"/>
					</c:if>
					
					<strong type="pd4TH" class="pdTitle" style="${dispFlag}">${mgftTheme4thMst.title}</strong>
				</c:if>
				<c:if test="${mgftTheme5thMst.dispPrdtYn eq 'Y'}" >
					<c:set var="totalPage" value="${totalPage + 1}"/>
					<c:set var="dispFlag" value="display:none;"/>
					<c:if test="${totalPage == 1}">
						<c:set var="dispFlag" value="display:block;"/>
					</c:if>
					
					<strong type="pd5TH" class="pdTitle" style="${dispFlag}">${mgftTheme5thMst.title}</strong>
				</c:if>
			</h3>
			
			<div class="pd_list">
				<ul class="cont08ListArea">
					
				</ul>
			</div>
			<a href="#" class="btn_change MB_MAIN_GIFT_11_1" id="pdBtn" onclick="javacript:event.preventDefault();"><span>다른 테마 또 보여줘<em class="font_t"><strong id="pdPage">0</strong>/<font id="pdTotalPage">${totalPage}</font></em></span></a>
		</div>
	</c:if>
	<!--// 기획상품 -->

	<!-- /////////이벤트전체배너 ///////// -->
	<c:if test="${not empty mgftEventBnrList}">	            
		<div class="event_banner">
			<ul>
				<c:forEach items="${mgftEventBnrList}" var="l" varStatus="st">
	            	<li class="MB_MAIN_GIFT_12">
		            	<a href="javascript:;" onclick="location.href='/m/biz/eventDetail?eventId=${l.eventId}';return false;">
	                        <div class="img_wrap">
	                        	<ui:image src="${l.eventImageUrl}" alt="${l.eventTitle}"/>
	                        </div>
	                        <c:if test="${not empty l.discRate && l.discRate > 0}">
	                        	<span class="font_t percent">${l.discRate}%</span>
	                        </c:if>
	                        <strong>${l.eventTitle}</strong>
							<p>${l.eventDtlCont}</p>
	                    </a>
                    </li>
	            </c:forEach>
			</ul>
		</div>
	</c:if>
	<!-- //이벤트전체배너 -->
		
	<!-- /////////스페셜 에디션 ///////// -->
	<c:if test="${not empty seList[0] || not empty seList[1] || not empty seList[2] || not empty seList[3] || not empty seList[4]}">
		<div class="cont cont09">
			<h3><strong>스페셜 에디션&#59;</strong></h3>
			<div class="tit_wrap">
				<h5>핫트랙스 PB</h5>
			</div>
			<div class="swiper-container">
				<div class="swiper-wrapper">
					<c:forEach items="${seList}" var="lst" varStatus="stMst">
						<c:if test="${not empty lst}">
							<c:forEach items="${lst}" var="l" varStatus="st">
								<c:if test="${st.first}">
									<div class="swiper-slide">
										<a href="javascript:;" class="MB_MAIN_GIFT_13" onclick="location.href='/m/gift/detail/${l.sellPrdtBcode}';return false;">
											<div class="thum">
												<c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G'}">
													<ui:image src="${l.productImageUrl}" size="400" server="product" alt="${fn:escapeXml(l.prdtName)}"/>
												</c:if>
												<c:if test="${l.sellPrdtGbn eq 'R'}">
													<ui:image rcrdCd="${l.rcrdCd}" size="400" prdtGbn="R" ratingCode="A" alt="${fn:escapeXml(l.prdtName)}"/>
												</c:if>
												<c:if test="${l.sellPrdtGbn eq 'D'}">
													<ui:image rcrdCd="${l.rcrdCd}" size="400" prdtGbn="D" ratingCode="A" alt="${fn:escapeXml(l.prdtName)}"/>
												</c:if>
											</div>
											<p class="tit">${l.title}</p>
											<p class="txt">${l.subTitle}</p>
										</a>
										<div class="thum_list">
											<ul>
									</c:if>
										<c:if test="${st.count > 1}">
											<li class="MB_MAIN_GIFT_13">
												<a href="javascript:;" onclick="location.href='/m/gift/detail/${l.sellPrdtBcode}';return false;">
													<c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G'}">
														<ui:image src="${l.productImageUrl}" size="100" server="product" alt="${fn:escapeXml(l.prdtName)}"/>
													</c:if>
													<c:if test="${l.sellPrdtGbn eq 'R'}">
														<ui:image rcrdCd="${l.rcrdCd}" size="100" prdtGbn="R" ratingCode="A" alt="${fn:escapeXml(l.prdtName)}"/>
													</c:if>
													<c:if test="${l.sellPrdtGbn eq 'D'}">
														<ui:image rcrdCd="${l.rcrdCd}" size="100" prdtGbn="D" ratingCode="A" alt="${fn:escapeXml(l.prdtName)}"/>
													</c:if>
												</a>
											</li>
										</c:if>
								<c:if test="${st.last}">
											</ul>
										</div>	
									</div>
								</c:if>			
							</c:forEach>
						</c:if>
					</c:forEach>
				</div>
			</div>
		</div>
	</c:if>
	<!--// 스페셜 에디션 -->
	
	<!-- /////////도트배너 ///////// -->
	<c:if test="${not empty mgftDotBnrList}">	 
		<div class="dot_banner">
			<div class="swiper-container">
				<div class="swiper-wrapper">
					<c:forEach items="${mgftDotBnrList}" var="l" varStatus="st">
		            	<div class="swiper-slide">
		            		<a href="javascript:;" class="MB_MAIN_GIFT_14" onclick="location.href='${l.bnrLnkUrl}';return false;">
								<div class="thum">
									<ui:image src="${l.bnrImgUrl}" alt="${l.bnrImgAlt}"/>
								</div>
								<c:if test="${l.signWayGbn eq 'C1452'}">
									<p class="tit">${l.bnrTitle}</p>
								</c:if>
							</a>
	                    </div>
		            </c:forEach>
				</div>
			</div>
		</div>
	</c:if>
	<!--// 도트배너 -->
	
	<!--  /////////카테고리별 추천 /////////  -->
	<div id="ctgrBest">
	</div>
	<!--// 카테고리별 추천 -->
</div>

	<!-- /////////상단 롤링 배너 레이어///////// -->
	<c:if test="${not empty mgftRollBnrList and fn:length(mgftRollBnrList) > 0}">
		<div id="layer_banner">
			<div class="layer_banner_top">
				<h2>전체보기</h2>
				<a href="javascript:;" class="btn_close">닫기</a>
			</div>
			<div class="layer_wrap">
				<div class="layer_cont">
					<ul>
						<c:forEach items="${mgftRollBnrList}" var="l" varStatus="st">
							<li class="${l.signWayGbn eq 'C1451' ? 'type02' : 'type01'}">
								<a href="javascript:;" onclick="location.href='${l.bnrLnkUrl}';return false;">
									<c:if test="${not empty l.flagCd}">
										<c:if test="${l.flagCd eq 'C1481'}">
											<span class="tag_new">NEW</span>
										</c:if>
										<c:if test="${l.flagCd eq 'C1482'}">
											<span class="tag_hot">HOT</span>
										</c:if>
										<c:if test="${l.flagCd eq 'C1483'}">
											<span class="tag_gift">사은품</span>
										</c:if>
										<c:if test="${l.flagCd eq 'C1484'}">
											<span class="tag_free"><p>무료</p><p>배송</p></span>
										</c:if>
										<c:if test="${l.flagCd eq 'C1485'}">
											<c:if test="${not empty l.discRate}">
												<span class="tag_percent"><p>~</p><strong>${l.discRate}</strong>%</span>
											</c:if>	
										</c:if>								
									</c:if>
									<ui:image src="${l.bnrImgUrl}" alt="${l.bnrImgAlt}"/>
									<c:if test="${l.signWayGbn ne 'C1451'}">
										<div class="info">
											<p class="tit">${l.bnrTitle}</p>
											<c:if test="${l.signWayGbn eq 'C1453'}">
												<p class="txt">${l.bnrSubTitle}</p>
											</c:if>
										</div>
									</c:if>
								</a>
							</li>
						</c:forEach>
					</ul>
				</div>
			</div>
		</div>
	</c:if>
<!--// 상단 롤링 배너 레이어 -->
</div>
<!--// content -->
</body>
</html>