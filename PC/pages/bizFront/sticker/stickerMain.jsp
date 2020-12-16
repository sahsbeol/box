<%@ page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<!-- 태그 라이브러리 -->
<%@ include file="/pages/decorators/biz/tagHeader.jsp" %>
<!DOCTYPE ui:decorator PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<ui:decorator name="bizSticker"/>
<html>
<head>
<script>
	$(function(){
		$('.layer-slide ul').bxSlider({
            auto: true,
            autoHover: true,
            touchEnabled: false,
            infniiteLoop: true,
            hideControlOnEnd: true,
            speed: 2000,
            pause: 3000,
            moveSlides: 1,
            pager: true,
            pagerType: 'short',
            pagerShortSeparator: '',
		    onSlideBefore: function(){
			    $('.bx-clone').addClass('active')
		    },
		    onSlideAfter: function(){
			    $('.bx-clone').removeClass('active')
		    }
        })
	
	    $(window).scroll(function(){
	        var sct = $(window).scrollTop()
	        var winY = sct + $(window).height()
	        // var nowFrame = Math.floor(((sct - sectionSpot[4]) / $('.frame-wrap .wrap').height()) * fps)
	        var toTop = $('.toTop-wrap').offset().top - 80
	        
	        sectionSpot = []
	
	        if(sct >= toTop ){
	            $('.fixed-wrap').css({'opacity': 1})
	        }else {
	            $('.fixed-wrap').css({'opacity': 0})
	        }
	        $('.section').each(function(i,e){
	            sectionSpot.push($(e).offset().top)
	            if(winY > sectionSpot[i] && !$(e).is('.on')){
	                $(e).addClass('on')
	                $(e).find('.section-title').addClass('active')
	            } else if(winY < sectionSpot[i] && $(e).is('.on')){
	                $(e).removeClass('on')
	                $(e).find('.section-title').removeClass('active')
	            }
	            if(winY >= sectionSpot[4] && $('.frame-wrap').is('.on')){
	                $(".frame-wrap").addClass('active')
	                playVideo();
	            } else if( winY < sectionSpot[4] ) {
	                $(".frame-wrap").removeClass('active')
	                stopVideo();
	            } else {
	                $(".frame-wrap").removeClass('active')
	            }
	        });
	    });
	});

	$(document).ready(function(){
		$('.layer-slide .bx-pager').click(function(){
            $('body').addClass('noscroll');
            $('.layer_fullban').addClass('active');
        });
        $('.btn_fullclose').click(function(){
            $('body').removeClass('noscroll');
            $('.layer_fullban').removeClass('active');
        });

        var sectionSpot = [];

        $('.fixed-wrap .go-top-btn').click(function(){
            $('html, body').animate({scrollTop: 0},1000);
        });
		
        $('.tab-btn li').click(function(){
            $('.tab-btn li ,.tab-content>div, .tab-content .see-more-btn').removeClass('active');
            $('.item-content li:nth-child(n+9)').slideUp();
            if(!$(this).is('.active')){
                $(this).addClass('active');
            }
            
            $fn.getAllStickerList();
        });
        $('.archive-wrap .see-more-btn').click(function(){
            if(!$(this).is('.active')){
                var archTop = $('.archive-wrap').offset().top
                $(this).addClass('active')
                $('.archive-list').addClass('see-active')
                $('.archive-list li:nth-child(n+10)').css('display','inline-block!important').slideDown()
                $('html,body').animate({scrollTop: archTop},700)
            } else if($(this).is('.active')){
                $(this).removeClass('active')
                $('.archive-list').removeClass('see-active')
                $('.archive-list li:nth-child(n+10)').slideUp()
            }
        })
        $('.tab-content .see-more-btn').click(function(){
            if(!$(this).is('.active')){
                var tabTop = $('.all-wrap').offset().top
                $(this).addClass('active')
                $('.item-content li:nth-child(n+9)').slideDown()
                $('html,body').animate({scrollTop: tabTop},700)
            } else if($(this).is('.active')){
                $(this).removeClass('active')
                $('.item-content li:nth-child(n+9)').slideUp()
            }
        })
        
		$fn.init();
	});

	$fn = {
		init:function(){
			//스티커 페이지 초기 데이터 세팅
		    $fn.getArchiveList();			// Stticker Archive
		    $fn.getNewStickerList();		// New in
		    $fn.getAllStickerList();		// All Item
		    $fn.getDecoStlyeList();			// Deco&Styling
		    $fn.getEventList(1);			// now is
		}
		, getArchiveList:function() {
			var archiveList1 = [
								{archiveId : "archive1"		, brandId : "30360"		, brandName : "러브미모어"},
								{archiveId : "archive3"		, brandId : "33945"		, brandName : "람찌네"},
								{archiveId : "archive5"		, brandId : "28060"		, brandName : "영이의숲"},
								{archiveId : "archive7"		, brandId : "91615"		, brandName : "데일리라이크"},
								{archiveId : "archive9"		, brandId : "20588"		, brandName : "바이나쿠"},
								{archiveId : "archive11"	, brandId : "33205"		, brandName : "베베"},
								{archiveId : "archive13"	, brandId : "28060"		, brandName : "에뚜알의세삐공방"},
								{archiveId : "archive15"	, brandId : "32429"		, brandName : "한톨상점"},
								{archiveId : "archive17"	, brandId : "33998"		, brandName : "후하후카스튜디오"},
								{archiveId : "archive19"	, brandId : "34201"		, brandName : "고양이다방"},
								{archiveId : "archive21"	, brandId : "91711"		, brandName : "비온뒤"}
		                    ];
			
			var archiveList2 = [
								{archiveId : "archive2"		, brandId : "31939"		, brandName : "푸르름디자인"},
								{archiveId : "archive4"		, brandId : "28060"		, brandName : "밤토리상점"},
								{archiveId : "archive6"		, brandId : "21916"		, brandName : "리훈"},
								{archiveId : "archive8"		, brandId : "33344"		, brandName : "두들두들"},
								{archiveId : "archive10"	, brandId : "14172"		, brandName : "워너디스"},
								{archiveId : "archive12"	, brandId : "33314"		, brandName : "쪼람쥐"},
								{archiveId : "archive14"	, brandId : "33809"		, brandName : "푸푸남"},
								{archiveId : "archive16"	, brandId : "33566"		, brandName : "햐니닐리"},
								{archiveId : "archive18"	, brandId : "32466"		, brandName : "호호문방구"},
								{archiveId : "archive20"	, brandId : "33809"		, brandName : "푸푸남"},
								{archiveId : "archive22"	, brandId : "10002"		, brandName : "아이코닉"}
		                    ];
			
			shuffle(archiveList1);
			shuffle(archiveList2);
			
			var append = '';
			for(var i=0; i < 11; i++) {
				append += '<li>';
				append += '    <a href="/b/'+archiveList1[i].brandId+'">';
				append += '        <div class="thum">';
				append += '            <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/sticker-page/archive/'+archiveList1[i].archiveId+'.jpg" alt="아이템 이미지">';
				append += '        </div>';
				append += '        <div class="hover">';
                append += '            <p>'+archiveList1[i].brandName+'</p>';
                append += '        </div>';
                append += '   </a>';
                append += '</li>';
                
                append += '<li>';
				append += '    <a href="/b/'+archiveList2[i].brandId+'">';
				append += '        <div class="thum">';
				append += '            <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/sticker-page/archive/'+archiveList2[i].archiveId+'.jpg" alt="아이템 이미지">';
				append += '        </div>';
				append += '        <div class="hover">';
                append += '            <p>'+archiveList2[i].brandName+'</p>';
                append += '        </div>';
                append += '   </a>';
                append += '</li>';
			}
			
			$('#archiveList').html(append);
		}
		, getNewStickerList:function() {
			$.ajax({
				url: "/ht/biz/sticker/getStickerPrdtList"
				,data: $fn.setStickerPrdtListParams('new')
				,type:"POST"
		        ,dataType: "json"
		        ,success : function(data){
		        	var append = '';
		        	
		        	$('#newStickerList').empty();
		        	
		        	if (data) {
		                if(!isEmpty(data)) {
		                	var list = data.stickerList;
		                	
		                	shuffle(list);
		                	
		                	for(var i in list) {
		                		append += '	<li>';
		                		append += '		<a href="/p/'+list[i].sellPrdtBcode+'">';
		                		append += '			<div class="img-wrap">';
		                		append += '				<div class="img-cont">';
		                		append += '					<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/goods/400/'+list[i].productImageUrl+'" alt="'+list[i].prdtName+'" onerror="this.src=\'http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/no_image2.gif\';">';
		                		append += '				</div>';
		                		append += '			</div>';
		                		append += '         <div class="text-wrap">';
		                		append += '             <p class="item-text">'+list[i].prdtName+'</p>';
		                		append += '             <div class="price-wrap">';
		                		if(list[i].lastDcRate != 0){
			                	    append += '				<em>'+list[i].lastDcRate+'%</em>';
		                	    }
		                		append += '					<strong>'+price_format(list[i].lastCpnPrice)+'</strong>';
		                		append += '				</div>';
		                		append += '			</div>';
		                		append += '		</a>';
		                		append += '	</li>';
		                	}

		                	$('#newStickerList').html(append);
		                }
		            }
		        }
		        ,error: function(request, status, error) {
		            if(request.status != 0){
		                alert('서비스 수행도중 오류가 발생하였습니다. 잠시후 다시 이용해주세요.\n(※ 지속적으로 오류가 나는 경우 고객센터에 문의바랍니다.)');
		            }
		        }
		        ,complete : function() {
	        		$('#newStickerList').bxSlider({
		                auto: false,
		                infniiteLoop: false,
		                touchEnabled: false,
		                hideControlOnEnd: true,
		                speed: 1000,
		                pause: 3000,
		                moveSlides: 4,
		                maxSlides: 4,
		                minSlides: 4,
		                slideWidth: 228,
		                slideMargin: 12,
		                pager: true,
		                pagerType: 'short',
		                pagerShortSeparator: ''
		            });
		        }
		    });
		}
		, getAllStickerList:function() {
			$.ajax({
				url: "/ht/biz/sticker/getStickerPrdtList"
				,data: $fn.setStickerPrdtListParams('all')
				,type:"POST"
		        ,dataType: "json"
		        ,success : function(data){
		        	var append = '';
		        	
		        	$('#allStickerList').empty();

		        	if (data) {
		                if(!isEmpty(data)) {
		                	var list = data.stickerList;
		                	
		                	shuffle(list);
		                	
		                	for(var i in list) {
		                		append += '	<li>';
		                		append += '		<a href="/p/'+list[i].sellPrdtBcode+'">';
		                		append += '			<div class="img-wrap">';
		                		append += '				<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/goods/400/'+list[i].productImageUrl+'" alt="'+list[i].prdtName+'" onerror="this.src=\'http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/no_image2.gif\';">';
		                		append += '         	<div class="hover-wrap">';
		                		append += '             	<p>'+list[i].prdtName+'</p>';
		                		append += '             	<div class="price-wrap">';
		                		if(list[i].lastDcRate != 0){
			                	    append += '					<em>'+list[i].lastDcRate+'%</em>';
		                	    }
		                		append += '						<strong>'+price_format(list[i].lastCpnPrice)+'</strong>';
		                		append += '					</div>';
		                		append += '				</div>';
		                		append += '			</div>';
		                		append += '		</a>';
		                		append += '	</li>';
		                	}

		                	$('#allStickerList').html(append);
		                }
		            }
		        }
		        ,error: function(request, status, error) {
		            if(request.status != 0){
		                alert('서비스 수행도중 오류가 발생하였습니다. 잠시후 다시 이용해주세요.\n(※ 지속적으로 오류가 나는 경우 고객센터에 문의바랍니다.)');
		            }
		        }
		        ,complete : function() {
		        }
		    });
		}
		, getDecoStlyeList:function() {
			var decoList = [
								{decoId : "deco1"		, sellPrdtBcode : "2310041272549"},
								{decoId : "deco2"		, sellPrdtBcode : "8809732181085"},
								{decoId : "deco3"		, sellPrdtBcode : "2310041831814"},
								{decoId : "deco4"		, sellPrdtBcode : "2310041409501"},
								{decoId : "deco5"		, sellPrdtBcode : "2300186016948"},
								{decoId : "deco6"		, sellPrdtBcode : "8801800401255"},
								{decoId : "deco7"		, sellPrdtBcode : "2310041874545"},
								{decoId : "deco8"		, sellPrdtBcode : "2310041800612"},
								{decoId : "deco9"		, sellPrdtBcode : "2310041655564"},
								{decoId : "deco10"		, sellPrdtBcode : "8809684574430"},
								{decoId : "deco11"		, sellPrdtBcode : "2310041923984"},
								{decoId : "deco12"		, sellPrdtBcode : "8809722410515"},
								{decoId : "deco13"		, sellPrdtBcode : "2310041977796"},
								{decoId : "deco14"		, sellPrdtBcode : "2300186026268"},
								{decoId : "deco15"		, sellPrdtBcode : "2310041799411"},
								{decoId : "deco16"		, sellPrdtBcode : "2310042098438"},
								{decoId : "deco17"		, sellPrdtBcode : "8801800641613"},
								{decoId : "deco18"		, sellPrdtBcode : "2310041981748"},
								{decoId : "deco19"		, sellPrdtBcode : "2310041759910"},
								{decoId : "deco20"		, sellPrdtBcode : "2310042007997"}
		                    ];
			
			shuffle(decoList);
			
			var append = '';
			for(var i=0; i < 6; i++) {
				append += '<li>';
				append += '    <a href="/p/'+decoList[i].sellPrdtBcode+'">';
				append += '    <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/sticker-page/deco/'+decoList[i].decoId+'.jpg" alt="썸네일 이미지">';
				append += '    </a>';
				append += '</li>';
			}
			
			$('#decoStyleList').html(append);
		}
		, getEventList:function(page) {
			$.ajax({
				url: "/ht/biz/sticker/getEventList"
				, data: {page : page}
				, type:"POST"
		        ,dataType: "json"
		        ,success : function(data){
					var append = '';
		        	
					$('#stickerEventList').empty();
		        	
		        	if (data) {
		                if(!isEmpty(data)) {
		                	var list = data.eventList;
		                	
		                	for(var i in list) {
		                		append += '	<li>';
		                		append += '	    <a href="/e/'+list[i].eventId+'">';
		                		append += '	        <div class="img-wrap">';
		                		append += '	            <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/'+list[i].imageUrl+'" alt="'+list[i].eventTitle+'" onerror="this.src=\'http://image.kyobobook.co.kr/images/no_image.gif\';">';
		                		append += '	        </div>';
		                		append += '	        <div class="text-wrap">';
		                		if(!isEmpty(list[i].dispDscntRate)){
		                			append += '	            <em class="discount">'+list[i].dispDscntRate+'%</em>';
		                	    }
		                		append += '	            <strong class="item-title">'+list[i].eventTitle+'</strong>';
		                		append += '	            <p class="description">'+list[i].eventDtlCont+'</p>';
		                		append += '	            <span class="during-date">'+formatDate_toString(list[i].eventStartDt,'yyyy.MM.dd')+' ~ '+formatDate_toString(list[i].eventEndDt,'yyyy.MM.dd')+'</span>';
		                		append += '	        </div>';
		                		append += '	    </a>';
		                		append += '	</li>';
		                		
		                		if(i == 5)  break;
		                	}

		                	$('#stickerEventList').html(append);
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
		, setStickerPrdtListParams:function(type) {
			var params = {};
			//카테고리 분류
			switch (type) {
			  case 'new' :
				//새로 나왔어요!
			  	params.ctgrId = '0000200800';
			  	params.listSize = '20';
			  	params.productOrderBy = 'R';
			    break;
			  case 'all' :
				//이 세상 스티커! 여기 다 있어요
				params.ctgrId = $('.tab-btn li.active').attr('ctgrNum');
				params.listSize = '16';
			  	params.productOrderBy = 'P';
			    break;
			  default :
				//스티커
				params.ctgrId = '0000200800';
			  	params.listSize = '20';
			  	params.productOrderBy = 'R';
			    break;
			}
			
			return params;
		}
	};
	
	function shuffle(a) {
	    var j, x, i;
	    for (i = a.length; i; i -= 1) {
	        j = Math.floor(Math.random() * i);
	        x = a[i - 1];
	        a[i - 1] = a[j];
	        a[j] = x;
	    }
	}	
</script>
</head>

<body class="">
	<!-- 슬라이드 영역 -->
	<div class="layer-slide">
	    <ul>
	    	<li>
	            <a href="/p/2300186032641">
	                <div class="item-list">
	                    <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/sticker-page/slide/9/9-1.png" class="bg" alt="">
	                    <div class="item-wrap">
	                        <div class="text-wrap">
	                            <strong></strong>
	                            <p></p>
	                        </div>
	                        <div class="layer layer1">
	                            <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/sticker-page/slide/9/9-2.png" alt="">
	                        </div>
	                        <div class="layer layer2">
	                            <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/sticker-page/slide/9/9-3.png" alt="">
	                        </div>
	                    </div>
	                </div>
	            </a>
	        </li>
	    	<li>
	            <a href="/p/2300186032634">
	                <div class="item-list">
	                    <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/sticker-page/slide/10/10-1.png" class="bg" alt="">
	                    <div class="item-wrap">
	                        <div class="text-wrap">
	                            <strong></strong>
	                            <p></p>
	                        </div>
	                        <div class="layer layer1">
	                            <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/sticker-page/slide/10/10-2.png" alt="">
	                        </div>
	                        <div class="layer layer2">
	                            <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/sticker-page/slide/10/10-3.png" alt="">
	                        </div>
	                    </div>
	                </div>
	            </a>
	        </li>
	 		<li>
	            <a href="/b/30360">
	                <div class="item-list">
	                    <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/sticker-page/slide/1/1-1.png" class="bg" alt="">
	                    <div class="item-wrap">
	                        <div class="text-wrap">
	                            <strong></strong>
	                            <p></p>
	                        </div>
	                        <div class="layer layer1">
	                            <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/sticker-page/slide/1/1-2.png" alt="">
	                        </div>
	                        <div class="layer layer2">
	                            <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/sticker-page/slide/1/1-3.png" alt="">
	                        </div>
	                    </div>
	                </div>
	            </a>
	        </li>
	        <li>
	            <a href="/b/31939">
	                <div class="item-list">
	                    <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/sticker-page/slide/2/2-1.png" class="bg" alt="">
	                    <div class="item-wrap">
	                        <div class="text-wrap">
	                            <strong></strong>
	                            <p></p>
	                        </div>
	                        <div class="layer layer1">
	                            <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/sticker-page/slide/2/2-2.png" alt="">
	                        </div>
	                        <div class="layer layer2">
	                            <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/sticker-page/slide/2/2-3.png" alt="">
	                        </div>
	                    </div>
	                </div>
	            </a>
	        </li>
	        <li>
	            <a href="/b/33205">
	                <div class="item-list">
	                    <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/sticker-page/slide/3/1.png" class="bg" alt="">
	                    <div class="item-wrap">
	                        <div class="text-wrap">
	                            <strong></strong>
	                            <p></p>
	                        </div>
	                        <div class="layer layer1">
	                            <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/sticker-page/slide/3/2.png" alt="">
	                        </div>
	                        <div class="layer layer2">
	                            <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/sticker-page/slide/3/3.png" alt="">
	                        </div>
	                    </div>
	                </div>
	            </a>
	        </li>
	        <li>
	            <a href="/b/32429">
	                <div class="item-list">
	                    <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/sticker-page/slide/4/1.png" class="bg" alt="">
	                    <div class="item-wrap">
	                        <div class="text-wrap">
	                            <strong></strong>
	                            <p></p>
	                        </div>
	                        <div class="layer layer1">
	                            <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/sticker-page/slide/4/2.png" alt="">
	                        </div>
	                        <div class="layer layer2">
	                            <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/sticker-page/slide/4/3.png" alt="">
	                        </div>
	                    </div>
	                </div>
	            </a>
	        </li>
	        <li>
	            <a href="/b/28060">
	                <div class="item-list">
	                    <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/sticker-page/slide/5/1.png" class="bg" alt="">
	                    <div class="item-wrap">
	                        <div class="text-wrap">
	                            <strong></strong>
	                            <p></p>
	                        </div>
	                        <div class="layer layer1">
	                            <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/sticker-page/slide/5/2.png" alt="">
	                        </div>
	                        <div class="layer layer2">
	                            <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/sticker-page/slide/5/3.png" alt="">
	                        </div>
	                    </div>
	                </div>
	            </a>
	        </li>
	        <li>
	            <a href="/b/33998">
	                <div class="item-list">
	                    <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/sticker-page/slide/6/1.png" class="bg" alt="">
	                    <div class="item-wrap">
	                        <div class="text-wrap">
	                            <strong></strong>
	                            <p></p>
	                        </div>
	                        <div class="layer layer1">
	                            <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/sticker-page/slide/6/2.png" alt="">
	                        </div>
	                        <div class="layer layer2">
	                            <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/sticker-page/slide/6/3.png" alt="">
	                        </div>
	                    </div>
	                </div>
	            </a>
	        </li>
	        <li>
	            <a href="/b/33945">
	                <div class="item-list">
	                    <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/sticker-page/slide/7/1.png" class="bg" alt="">
	                    <div class="item-wrap">
	                        <div class="text-wrap">
	                            <strong></strong>
	                            <p></p>
	                        </div>
	                        <div class="layer layer1">
	                            <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/sticker-page/slide/7/2.png" alt="">
	                        </div>
	                        <div class="layer layer2">
	                            <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/sticker-page/slide/7/3.png" alt="">
	                        </div>
	                    </div>
	                </div>
	            </a>
	        </li>
	        <li>
	            <a href="/b/33314">
	                <div class="item-list">
	                    <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/sticker-page/slide/8/1.png" class="bg" alt="">
	                    <div class="item-wrap">
	                        <div class="text-wrap">
	                            <strong></strong>
	                            <p></p>
	                        </div>
	                        <div class="layer layer1">
	                            <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/sticker-page/slide/8/2.png" alt="">
	                        </div>
	                        <div class="layer layer2">
	                            <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/sticker-page/slide/8/3.png" alt="">
	                        </div>
	                    </div>
	                </div>
	            </a>
	        </li>
	    </ul>
	</div>
	<!-- 슬라이드 풀 배너 -->
	<div class="layer_fullban">
		<div class="list_fullbox">
			<a href="#n" class="btn_fullclose"><span>닫기</span></a>
			<div class="list_fullban_a">
	        	<div class="layer-wrap">
	            	<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/sticker-page/slide/9/9-2.png"" class="layer1">
	                	<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/sticker-page/slide/9/9-3.png"" class="layer2">
				</div>
	            <div class="list_fullban">
	            	<a href="/p/2300186032641">
						<div class="thum">
		                	<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/sticker-page/slide/9/9-1.png"">
						</div>
				 	</a>
				</div>
	        </div>
	        <div class="list_fullban_a">
	        	<div class="layer-wrap">
	            	<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/sticker-page/slide/10/10-2.png"" class="layer1">
	                	<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/sticker-page/slide/10/10-3.png"" class="layer2">
				</div>
	            <div class="list_fullban">
	            	<a href="/p/2300186032634">
						<div class="thum">
		                	<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/sticker-page/slide/10/10-1.png"">
						</div>
				 	</a>
				</div>
	        </div>
			
	        <div class="list_fullban_a">
	        	<div class="layer-wrap">
	            	<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/sticker-page/slide/1/1-2.png"" class="layer1">
	                	<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/sticker-page/slide/1/1-3.png"" class="layer2">
				</div>
	            <div class="list_fullban">
	            	<a href="/b/30360">
						<div class="thum">
		                	<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/sticker-page/slide/1/1-1.png"">
						</div>
				 	</a>
				</div>
	        </div>
	        <div class="list_fullban_a">
	            <div class="layer-wrap">
	                <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/sticker-page/slide/2/2-2.png" class="layer1">
	                <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/sticker-page/slide/2/2-3.png" class="layer2">
	            </div>
	            <div class="list_fullban">
		            <a href="/b/31939">
						<div class="thum">
		                	<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/sticker-page/slide/2/2-1.png">
						</div>
					</a>
	        	</div>
	        </div>
	        <div class="list_fullban_a">
	            <div class="layer-wrap">
	                <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/sticker-page/slide/3/2.png" class="layer1">
	                <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/sticker-page/slide/3/3.png" class="layer2">
	            </div>
	            <div class="list_fullban">
		            <a href="/b/33205">
						<div class="thum">
		                	<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/sticker-page/slide/3/1.png">
						</div>
					</a>
	        	</div>
	        </div>
	        <div class="list_fullban_a">
	            <div class="layer-wrap">
	                <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/sticker-page/slide/4/2.png" class="layer1">
	                <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/sticker-page/slide/4/3.png" class="layer2">
	            </div>
	            <div class="list_fullban">
		            <a href="/b/32429">
						<div class="thum">
		                	<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/sticker-page/slide/4/1.png">
						</div>
					</a>
	        	</div>
	        </div>
	        <div class="list_fullban_a">
	            <div class="layer-wrap">
	                <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/sticker-page/slide/5/2.png" class="layer1">
	                <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/sticker-page/slide/5/3.png" class="layer2">
	            </div>
	            <div class="list_fullban">
		            <a href="/b/28060">
						<div class="thum">
		                	<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/sticker-page/slide/5/1.png">
						</div>
					</a>
	        	</div>
	        </div>
	        <div class="list_fullban_a">
	            <div class="layer-wrap">
	                <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/sticker-page/slide/6/2.png" class="layer1">
	                <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/sticker-page/slide/6/3.png" class="layer2">
	            </div>
	            <div class="list_fullban">
		            <a href="/b/33998">
						<div class="thum">
		                	<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/sticker-page/slide/6/1.png">
						</div>
					</a>
	        	</div>
	        </div>
	        <div class="list_fullban_a">
	            <div class="layer-wrap">
	                <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/sticker-page/slide/7/2.png" class="layer1">
	                <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/sticker-page/slide/7/3.png" class="layer2">
	            </div>
	            <div class="list_fullban">
		            <a href="/b/33945">
						<div class="thum">
		                	<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/sticker-page/slide/7/1.png">
						</div>
					</a>
	        	</div>
	        </div>
	        <div class="list_fullban_a">
	            <div class="layer-wrap">
	                <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/sticker-page/slide/8/2.png" class="layer1">
	                <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/sticker-page/slide/8/3.png" class="layer2">
	            </div>
	            <div class="list_fullban">
		            <a href="/b/33314">
						<div class="thum">
		                	<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/sticker-page/slide/8/1.png">
						</div>
					</a>
	        	</div>
	        </div>
		</div>
	</div>
	            <!-- 탑버튼 영역 -->
	<div class="toTop-wrap wrap">
	    <div class="fixed-wrap">
	        <div class="go-top-btn">
	            <img src="/images/biz/common/go_top.png">
	            TOP
	        </div>
	    </div>
	</div>
	<!-- 작가별 스티커 리스트 -->
	<div class="archive-wrap section wrap">
	    <div class="section-title">
	        <h2><em>Sticker</em> <strong>Archive</strong></h2>
	    </div>
	    <div class="archive-list">
	        <ul id="archiveList" class="clear">
	        </ul>
	    </div>
	    <div class="see-more-wrap">
	        <button type="button" class="see-more-btn"></button>
	    </div>
	</div>
	<!-- 새로 나온 제품 영역 -->
	<div class="new-wrap section wrap">
	    <div class="section-title">
	        <h2>New in</h2>
	        <p>새로 나왔어요!</p>
	    </div>
	    <div class="new-slide">
	        <ul id="newStickerList">
	        </ul>
	    </div>
	</div>
	
	<!-- 이미지 배너 -->
	<div class="img-banner-wrap">
	    <a href="/e/69841">
	        <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/sticker-page/banner/banner.jpg" alt="이미지 배너">
	    </a>
	</div>
	
	<!-- 아이템 전체 -->
	<div class="all-wrap section">
	    <div class="wrap">
	        <div class="section-title">
	            <h2>All Item</h2>
	            <p>이 세상 스티커! 여기 다 있어요</p>
	        </div>
	        <div class="tab-btn">
	            <ul>
	                <li ctgrNum="000020080014" class="active">
	                    <span class="tab-img"></span>
	                    <p>캐릭터</p>
	                </li>
	                <li ctgrNum="000020080013">
	                    <span class="tab-img"></span>
	                    <p>컨페티</p>
	                </li>
	                <li ctgrNum="000020080015">
	                    <span class="tab-img"></span>
	                    <p>숫자/알파벳</p>
	                </li>
	                <li ctgrNum="000020080016">
	                    <span class="tab-img"></span>
	                    <p>도형</p>
	                </li>
	                <li ctgrNum="000020080012">
	                    <span class="tab-img"></span>
	                    <p>스티커팩</p>
	                </li>
	            </ul>
	        </div>
	        <div class="tab-content">
	            <div class="item-content">
	                <ul id="allStickerList" class="clear">
	                </ul>
	            </div>
	            <div class="see-more-wrap">
	                <button type="button" class="see-more-btn"></button>
	            </div>
	        </div>
	    </div>
	</div>
	
	<!-- 디자인 예시 리스트 -->
	<div class="goody-wrap section">
	    <div class="wrap">
	        <div class="section-title">
	            <h2>Deco <b>&</b> Styling</h2>
	            <p>하늘아래 같은 스티커는 없는 법!</p>
	        </div>
	        <div class="goody-list">
	            <ul id="decoStyleList" class="clear">
	            </ul>
	        </div>
	    </div>
	</div>
	
	<!-- 프레임 비디오 -->
	<div class="frame-wrap section">
	    <div class="wrap">
	        <div class="section-title">
	            <h2>Viewer x 오메베어</h2>
	            <p>브랜드 발견</p>
	        </div>
	        <div class="frame" id="frameApi"></div>
	        <div class="text-wrap">
	            <div class="bar"></div>
	            <p>핫트랙스의 시선으로 브랜드를 바라보다</p>
	        </div>
	    </div>
	</div>
	
	<!-- 지금 할인중 -->
	<div class="now-wrap section wrap">
	    <div class="section-title">
	        <h2>Now is</h2>
	        <p>진행중인 이벤트</p>
	    </div>
	    <div class="now-list">
	        <ul id="stickerEventList" class="clear">
	        </ul>
	    </div>
	</div>

    <script>
        var tag = document.createElement('script');
        tag.src = "https://www.youtube.com/player_api";
        var firstScriptTag = document.getElementsByTagName('script')[0];
        firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);
        var frameApi
    
        function onYouTubeIframeAPIReady() {
            frameApi = new YT.Player('frameApi', {
                width: '950',
                height: '534',
                videoId: 'Zbu600qz3HQ',
                playerVars: {rel: 0},
                events: {
                'onReady': playVideo
                }
            });
        }
        function playVideo() {
            frameApi.mute()
            if($(window).scrollTop() !== 0) frameApi.playVideo();
        }
        function stopVideo() {
            frameApi.stopVideo();
        }
    </script>
</body>
</html>
