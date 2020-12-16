<%@ page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<!-- 태그 라이브러리 -->
<%@ include file="/pages/decorators/biz/tagHeader.jsp" %>
<!DOCTYPE ui:decorator PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%-- <ui:decorator name="bizdiary"/> --%>
<html>
<head>
<title>다이어리 메인 - NEW ME HOTTRACKS</title>
<c:set var="tmpKey" value="202006100101"/>
<%-- <link rel="stylesheet" type="text/css" href="/css/diary.css?${tmpKey}"> --%>
<link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:100,300,400,500,700|Titillium+Web:400,600&display=swap&subset=korean">
<link rel="stylesheet" type="text/css" href="/css/diary.css?${tmpKey }"/>
<script type="text/javascript" src="/js/jquery.form.js"></script>
<script type="text/javascript" src="/js/fn_htts_slide.js?20180830155"></script>
<script type="text/javascript" src="/js/biz/jquery/jquery.bxslider.min.js"></script>
<!-- <script type="text/javascript" src="/scripts/loadingBar.js"></script> -->
<script type="text/javascript">
var brand;

$(document).ready(function(){
	$('#content.content').addClass('diary-page');
	
	$('.main_sec1 .slide_view').bxSlider({
        auto: true,
        autoHover: true,
        touchEnabled: false,
        infniiteLoop: true,
        hideControlOnEnd: true,
        speed: 2000,
        pause: 3000,
        moveSlides: 1,
        pager: true,
        pagerType: 'full',
        pagerShortSeparator: '',
        onSlideBefore: function($slideElement, currentIndex) {
            $(".bx-pager-item").removeClass("active");
            $(".bx-pager-item").eq(currentIndex + 1).addClass("active");
            if(currentIndex + 1 == 7){
                $(".bx-pager-item").eq(0).addClass('active')
            }
        },
        onSliderLoad: function () {
            $(".bx-pager-item").eq(0).addClass('active')
        }
    })
    $(window).scroll(function(){
        var sct = $(window).scrollTop()
        var winY = sct + $(window).height()
        
        sectionSpot = []

        $('.tit_today_box').each(function(i,e){
            sectionSpot.push($(e).offset().top)
            if(winY > sectionSpot[i] && !$(e).is('.active')){
                $(this).addClass('active')
            } else if(winY < sectionSpot[i] && $(e).is('.active')){
                $(this).removeClass('active')
            }
        })
    })
    $('.diary-page .spot-btn-wrap span:first-child').click(function(){
        var realtimeTop = $('.diary-page .today_box').offset().top - 50
        $('html,body').animate({scrollTop: realtimeTop},700)
    })
    $('.diary-page .spot-btn-wrap span+span').click(function(){
        var filterTop = $('.diary-page .diarycloud_a').offset().top - 50
        $('html,body').animate({scrollTop: filterTop},700)
    })
    $('.today_box .btn_more_a').click(function(){
        if(!$(this).is('.active')){
            var realtimeTop = $('.diary-page .today_box').offset().top - 50
            $(this).addClass('active')
            $('.diary-page .today_box li:nth-child(n+13)').slideDown()
            $('html,body').animate({scrollTop: realtimeTop},700)
        } else if($(this).is('.active')){
            $(this).removeClass('active')
            $('.diary-page .today_box li:nth-child(n+13)').slideUp()
        }
    })
//     $('.bestevent_a .btn_more_a').click(function(){
//         if(!$(this).is('.active')){
//             var bestTop = $('.diary-page .bestevent_a').offset().top - 50
//             $(this).addClass('active')
//             $('.diary-page .bestevent_a li:nth-child(n+8)').slideDown()
//             $('.diary-page .bestevent_a li:nth-child(n+8)').css('display','inline-block')
//             $('html,body').animate({scrollTop: bestTop},700)
//         } else if($(this).is('.active')){
//             $(this).removeClass('active')
//             $('.diary-page .bestevent_a li:nth-child(n+8)').slideUp()
//         }
//     })
    
    $('.bestevent_a .btn_more_a').click(function(){
    	if(!$(this).is('.active')){
            var realtimeTop = $('.diary-page .bestevent_a').offset().top - 50
            $(this).addClass('active')
            $('.diary-page .bestevent_a li:nth-child(n+4)').slideDown()
            $('html,body').animate({scrollTop: realtimeTop},700)
        } else if($(this).is('.active')){
            $(this).removeClass('active')
            $('.diary-page .bestevent_a li:nth-child(n+4)').slideUp()
        }
    })
    
    
    
	
	today = new Date();
    todayNew = new Date();
    Timer();
    timer = setInterval(Timer, 1000);
	
//     slideDiv(".main_sec1", 4000, ".main_sec1");
//     $("html,body").scrollTop(0);

//     var divs = [
//          "#diary_mspot"
//         ,"div.diary-event-banner ul.diary_tab"
//         ,"#m_diary div.diary-event-banner div.prod_list_normal"
//     ];
    
//     $("#wrap,#content").css("width", "100%");
//     $(divs.join(",")).css({"width":"950px","margin":"0 auto"});
//     $("#m_diary div.diary-event-banner h2.tit").css({"width":"100%","background":"url('http://image.kyobobook.co.kr/newimages/giftshop_new/work/1546/1542076443075_barbanner.jpg') no-repeat center center"});
//     var left = $(window).width()/2 + 285;
//     $("#m_diary div.diary-event-banner h2.tit img").css({"top":"185px","float":"none","left":left+"px"});
    
	
	$(document).on("click","#diaryPaging li",function() {
        if($(this).find('a').html() === '1'){
            $('.diarycloud .tlist_a.top3').addClass('active')
        }else{
            $('.diarycloud .tlist_a.top3').removeClass('active')
        }
    });
	
    $('#recobellMenu li').click(function(){
    	$('#recobellMenu li').removeClass("on");
		$(this).addClass("on");
		$('#recobellMore').find("a").removeClass("off");
		$('#recobell_recType').val($(this).attr("recType"));
		
		$fn.getRecobellList();
		$('#recobellMore').removeClass("active");
	});
	$('#recobellMore').click(function(){
		$('#recobellList li').show();
		$('#recobellBrandList li').show();
		$('#recobellMore').find("a").addClass("off");
	});
	$('#bestEventMore').click(function(){
		$('#bestEvent li').show();
		$(this).find("a").addClass("off");
	});
	$('#diaryCategory li').click(function(){
		$('#diaryCategory li').removeClass("on");
		$(this).addClass("on");
		$('#diary_ctgrNum').val($(this).attr("ctgrNum"));
		$('#diary_curPage').val("1");
		
		$fn.getDiaryList();
	});
	$('#diarySort li').click(function(){
		$('#diarySort li').removeClass("on");
		$(this).addClass("on");
		$('#diary_sortNum').val($(this).attr("sortNum"));
		$('#diary_curPage').val("1");
		
		$fn.getDiaryList();
	});
	
	$(document).on("click","#recobellBrandList li dl",function() {
    	$('#recobellBrandList li dl').removeClass("on");
		$('#recobell_brandId').val($(this).attr("brandId"));
		$('#recobellMore').find("a").removeClass("off");
		
		$fn.getRecobellList();
	});
	
	$fn.init();
});
$fn = {
	init:function(){
		$fn.getRecobellList();
	    $fn.getDiaryList();
	    $fn.getEventList(1);
	    $fn.setRecobellBrand();
	}
	, setRecobellBrand:function() {
		var brandList = [
							{brandName : "건망증"		, brandId : "10014"},
							{brandName : "공장"		, brandId : "10793"},
							{brandName : "대쉬앤도트"	, brandId : "10856"},
							{brandName : "데일리라이크"	, brandId : "91615"},
							{brandName : "라이브워크"	, brandId : "10019"},
							{brandName : "루카랩"		, brandId : "24663"},
							{brandName : "리훈"		, brandId : "21916"},
							{brandName : "모노폴리"		, brandId : "10001"},
							{brandName : "모닝글로리"	, brandId : "22055"},
							{brandName : "모트모트"		, brandId : "27946"},
							{brandName : "미도리"		, brandId : "10545"},
							{brandName : "바이.풀디자인"	, brandId : "10003"},
							{brandName : "비온뒤"		, brandId : "91711"},
							{brandName : "세컨드맨션"	, brandId : "15193"},
							{brandName : "아르디움"		, brandId : "12446"},
							{brandName : "아이씨엘"		, brandId : "24180"},
							{brandName : "아이코닉"		, brandId : "10002"},
							{brandName : "워너디스"		, brandId : "14172"},
							{brandName : "이든디자인"	, brandId : "10018"},
							{brandName : "인디고"		, brandId : "10623"},
							{brandName : "인바이트엘"	, brandId : "10575"},
							{brandName : "칠삼이일 디자인"	, brandId : "91870"},
							{brandName : "투영디자인"	, brandId : "10573"},
							{brandName : "퍼니디"		, brandId : "21501"},
							{brandName : "페이퍼리안"	, brandId : "24577"},
							{brandName : "플라잉 웨일즈"	, brandId : "24807"},
							{brandName : "플레플레"		, brandId : "10755"},
							{brandName : "플레픽"		, brandId : "91853"},
							{brandName : "핑크풋"		, brandId : "25831"} 
	                    ];
		
		shuffle(brandList);
		
		brand = '<li>';
		for(var i=0; i < 5; i++) {
			if(i==0)	$('#recobell_brandId').val(brandList[i].brandId);
			
			brand += '<dl brandId="'+brandList[i].brandId+'" '+brandList[i].brandId+'><a href="#" onclick="javacript:event.preventDefault();">'+brandList[i].brandName+'</a></dl>';
		}
		brand += '</li>';
	}
	, getRecobellList:function() {
		$.ajax({
			url: "/ht/biz/diary/getRecobellList"
			, data: $fn.setRecobellParams()
			, type:"POST"
	        ,dataType: "json"
	        ,success : function(data){
	        	var append = "";
	        	var rcCode = "";
	        	var recType = $('#recobell_recType').val();
	        	var brandId = $('#recobell_brandId').val();
	        	
               	$('#recobellList').empty();
               	$('#recobellBrandList').empty();
	        	
               	switch (recType) {
	                case 'p001' :
	                  rcCode = "&foo=bar&rccode=pc_d_person";
	                	break;
	                case 'b004' :
	                	rcCode = "&foo=bar&rccode=pc_d_brand";
	                	break;
	                case 'm002' :
	                	rcCode = "&foo=bar&rccode=pc_d_click";
	                	break;
	                case 'm012' :
                		rcCode = "&foo=bar&rccode=pc_d_cart";
						break;
				}
               	
	            if (data) {
	                if(!isEmpty(data)) {
	                	var target;
						var list = data.recobellList;
						var basicLength = 12;
						var totalLength = 20;
						
						if( recType == 'b004'){
							append += brand;
							basicLength = basicLength -1;
							totalLength = totalLength -1;
							target = $('#recobellBrandList');
							$('#recobellList').hide();
						}else{
							target = $('#recobellList');
							$('#recobellList').show();
						}	

						for(var i=0; i < (list.length < totalLength?list.length:totalLength); i++) {
							if(i < basicLength){
								append += '	<li>';
							}else{
								append += '	<li style="display:none;">';
							}
// 							if(recType != "p001"){
// 								if(i<3){
// 									append += '		<span class="ic_tagnum">'+(i+1)+'</span>';
// 								}else{
// 									append += '		<span class="ic_tagnum gray">'+(i+1)+'</span>';
// 								}
// 		                	    append += '		<span class="img">';
// 							}else{
								append += '		<span class="img mt31">';
// 							}
	                	    if(list[i].sellPrdtGbn == 'R' || list[i].sellPrdtGbn == 'D'){
	                	    	append += '			<a href="/ht/product/detail?barcode='+list[i].sellPrdtBcode+rcCode+'"><img src="http://image.kyobobook.co.kr/newimages/music/midi/'+list[i].rcrdCd.substring( 1, 5 ).split("").reverse().join("")+'/'+list[i].rcrdCd+'.jpg" alt="'+list[i].prdtName+'" class="photo" width="200" height="200" onerror="this.src=\'http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/no_image2.gif\';"></a>';
	                	    }else{
	                	    	append += '			<a href="/ht/product/detail?barcode='+list[i].sellPrdtBcode+rcCode+'"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/goods/400/'+list[i].prdtImgUrl+'" alt="'+list[i].prdtName+'" class="photo" width="200" height="200" onerror="this.src=\'http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/no_image2.gif\';"></a>';
	                	    }
// 	                	    append += '			<div class="hide_util">';
// 	                	    append += '			    <a href="javascript://" onclick="productPreview('+list[i].sellPrdtBcode+')" class="zoom"><span>확대</span></a>';
// 	                	    append += '			    <a href="/ht/product/detail?barcode='+list[i].sellPrdtBcode+'" target="_blank" class="nblank"><span>새창</span></a>';
// 	                	    append += '			    <a href="javascript://" onclick="addWishProduct('+list[i].sellPrdtBcode+')" class="zzim"><span>좋아요</span></a>';
// 	                	    append += '			</div>';
	                	    append += '		</span>';
	                	    append += '		<a href="/ht/product/detail?barcode='+list[i].sellPrdtBcode+rcCode+'">';
	                	    append += '		<span class="make txt_line1">'+list[i].brandName+'</span>';
	                	    append += '			<span class="name">';
	                	    if(list[i].prdtName.length > 40){
	                	    	append += list[i].prdtName.substring(0,40)+'...';
	                	    }else{
	                	    	append += list[i].prdtName;
	                	    }
	                	    append += '</span>';
	                	    append += '				<span class="price">';
	                	    append += '					<span class="sale">'+price_format(list[i].lastCpnPrice)+'</span>';
	                	    if(list[i].lastDcRate != 0){
		                	    append += '					<span class="pc">'+list[i].lastDcRate+'%</span>';
	                	    }
	                	    append += '			</span>';
	                	    append += '			<span class="icon">  ';
	                	    if (list[i].reviewCount != 0 || list[i].wishPrdtCnt != 0){
// 	                	    if(list[i].reviewCount != 0){
		                	    append += '		    <span class="ico_review">'+list[i].reviewCount+'</span>';
// 	                	    }
// 	                	    if(list[i].reviewCount != 0){
		                	    append += '		    <span class="ico_like on">'+list[i].wishPrdtCnt+'</span>';
// 	                	    }
	                	    }
	                	    append += '			</span>';
	                	    append += '		</a>';
	                	    append += '	</li>';
	                	}
	                	
						target.html(append);
						
						if (list.length < 8 && list.length < 20) {
							$('#recobellMore').hide();
						}
						if(recType == 'b004'){
							$('#recobellBrandList li dl[brandid='+brandId+']').addClass('on');
						}	
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
	, setRecobellParams:function() {
		var params = {};
		var recType = $('#recobell_recType').val();
		var brandId = $('#recobell_brandId').val();
		
		params.recType = recType;
		if(recType = "b004"){
			params.brandId = brandId;
		}	
		
		return params;
	}
	, getDiaryList:function() {
		/* $("#loadingBar").show(); */
		$.ajax({
			url: "/ht/biz/diary/getDiaryList"
			, data: $fn.setDiaryListParams()
			, type:"POST"
	        ,dataType: "json"
	        ,success : function(data){
	        	var append_top = "";
	        	var append = "";
	        	
               	$('#diaryPaging').empty();
               	$('#diaryCloudList_top').empty();
               	$('#diaryCloudList').empty();
	        	
	            if (data) {
	                if(!isEmpty(data)) {
	                	var pageHolder = data.pageHolder;
	                	var list = data.diaryList;
	                	
	                	for(var i in list) {
	                		if(i < 3){
	                			append_top += '	<li>';
								if(list[i].dispSeq <= 3){
									append_top += '		<span class="ic_tagnum">'+list[i].dispSeq+'</span>';
								}else{
									append_top += '		<span class="ic_tagnum gray">'+list[i].dispSeq+'</span>';
								}
	                			append_top += '		<span class="img">';
	                			append_top += '			<a href="/ht/product/detail?barcode='+list[i].sellPrdtBcode+'"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/goods/400/'+list[i].prdtImgUrl+'" alt="'+list[i].prdtName+'" class="photo" width="200" height="200" onerror="this.src=\'http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/no_image2.gif\';"></a>';
	                			append_top += '		</span>';
	                			
// 	                			append_top += '			<div class="hide_util">';
// 	                			append_top += '			    <a href="javascript://" onclick="productPreview('+list[i].sellPrdtBcode+')" class="zoom"><span>확대</span></a>';
// 	                			append_top += '			    <a href="/ht/product/detail?barcode='+list[i].sellPrdtBcode+'" target="_blank" class="nblank"><span>새창</span></a>';
// 	                			append_top += '			    <a href="javascript://" onclick="addWishProduct('+list[i].sellPrdtBcode+')" class="zzim"><span>좋아요</span></a>';
// 	                			append_top += '			</div>';
	                			append_top += '		<a href="/p/'+list[i].sellPrdtBcode+'">';
		                	    append_top += '		<span class="make txt_line1">'+list[i].brandEngName+'</span>';
		                	    append_top += '			<span class="name">';
		                	    if(list[i].prdtName.length > 40){
		                	    	append_top += list[i].prdtName.substring(0,40)+'...';
		                	    }else{
		                	    	append_top += list[i].prdtName;
		                	    }
		                	    append_top += '</span>';
		                	    append_top += '				<span class="price">';
		                	    append_top += '					<span class="sale">'+price_format(list[i].lastCpnPrice)+'</span>';
		                	    if(list[i].lastDcRate != 0){
			                	    append_top += '					<span class="pc">'+list[i].lastDcRate+'%</span>';
		                	    }
		                	    append_top += '			</span>';
		                	    append_top += '			<span class="icon">  ';
		                	    append_top += '		    <span class="ico_review">'+list[i].reviewCount+'</span>';
		                	    append_top += '		    <span class="ico_like on">'+list[i].wishPrdtCnt+'</span>';
		                	    append_top += '			</span>';
		                	    append_top += '		</a>';
		                	    append_top += '	</li>';
	                		}else{
	                			append += '	<li>';
		                	    append += '		<span class="ic_tagnum">'+list[i].dispSeq+'</span>';
		                	    append += '		<span class="img">';
		                	    append += '			<a href="/ht/product/detail?barcode='+list[i].sellPrdtBcode+'"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/goods/400/'+list[i].prdtImgUrl+'" alt="'+list[i].prdtName+'" class="photo" width="200" height="200" onerror="this.src=\'http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/no_image2.gif\';"></a>';
// 		                	    append += '			<div class="hide_util">';
// 		                	    append += '			    <a href="javascript://" onclick="productPreview('+list[i].sellPrdtBcode+')" class="zoom"><span>확대</span></a>';
// 		                	    append += '			    <a href="/ht/product/detail?barcode='+list[i].sellPrdtBcode+'" target="_blank" class="nblank"><span>새창</span></a>';
// 		                	    append += '			    <a href="javascript://" onclick="addWishProduct('+list[i].sellPrdtBcode+')" class="zzim"><span>좋아요</span></a>';
// 		                	    append += '			</div>';
		                	    append += '		</span>';
		                	    append += '		<a href="/p/'+list[i].sellPrdtBcode+'">';
		                	    append += '		<span class="make txt_line1">'+list[i].brandEngName+'</span>';
		                	    append += '			<span class="name">';
		                	    if(list[i].prdtName.length > 40){
		                	    	append += list[i].prdtName.substring(0,40)+'...';
		                	    }else{
		                	    	append += list[i].prdtName;
		                	    }
		                	    append += '</span>';
		                	    append += '				<span class="price">';
		                	    append += '					<span class="sale">'+price_format(list[i].lastCpnPrice)+'</span>';
		                	    if(list[i].lastDcRate != 0){
			                	    append += '					<span class="pc">'+list[i].lastDcRate+'%</span>';
		                	    }
		                	    append += '			</span>';
		                	    append += '			<span class="icon">  ';
		                	    if (list[i].reviewCount != 0 || list[i].wishPrdtCnt != 0){
// 		                	    if(list[i].reviewCount != 0){
			                	    append += '		    <span class="ico_review">'+list[i].reviewCount+'</span>';
// 		                	    }
// 		                	    if(list[i].reviewCount != 0){
			                	    append += '		    <span class="ico_like on">'+list[i].wishPrdtCnt+'</span>';
// 		                	    }
		                	    }
		                	    append += '			</span>';
		                	    append += '		</a>';
		                	    append += '	</li>';
	                		}
	                	}
	                	
		                $('#diaryCloudList_top').html(append_top);
		                $('#diaryCloudList').html(append);

		                var obj = document.getElementById("diaryPaging");
		                var hndl = function(page){ return function(e){ 
	                			e.preventDefault();
	                			$('#diary_curPage').val($(this).attr("href").replace("#",""));
	                			
	                			$fn.getDiaryList();
	                			//fnMove('diary');
	                		};
	                	};
		                obj.appendChild(_getPager(pageHolder, hndl));
	                }
	            }
	        }
	        ,error: function(request, status, error) {
	            if(request.status != 0){
	                alert('서비스 수행도중 오류가 발생하였습니다. 잠시후 다시 이용해주세요.\n(※ 지속적으로 오류가 나는 경우 고객센터에 문의바랍니다.)');
	            }
	        }
	        , complete : function() {
	        	/* $("#loadingBar").hide(); */
	        }
	    });
	}
	, setDiaryListParams:function() {
		var params = {};

		var ctgrNum = $('#diary_ctgrNum').val();
		var sortNum = $('#diary_sortNum').val();
		var curPage = $('#diary_curPage').val();
		
		//카테고리 분류
		switch (ctgrNum) {
		case '1':
			//심플
//				params.ctgrNum = '000020001100,000020000000,000020001102,000020000004,00000725,00002004';
			params.ctgrNum = '000020001100,000020000000,000020040005,000020041200';
			break;
		case '2':
			//일러스트
//				params.ctgrNum = '000020001101,000020000003';
			params.ctgrNum = '000020001101,000020000003';
			break;
		case '3':
			//날짜형
//				params.ctgrNum = '000020001100,000020001101,000020001102,000020001103,0000200010,000020040005,0000072500,0000072501,0000072502';
			params.ctgrNum = '000020040005,000020041200,000020001100,000020001101,000020001102,000020001105';
			break;
		case '4':
			//만년형
//				params.ctgrNum = '000020000000,000020000004,000020000003,000020040001,000020040002,000020040006';
			params.ctgrNum = '000020000000,000020000004,000020000003,000020000006';
			break;
		case '5':
			//6공
//				params.ctgrNum = '000020000006,000020001105,0000200007';
			params.ctgrNum = '000020001105,000020000006,000020040201,000020040202';
			break;
		case '6':
			//스케줄러
//				params.ctgrNum = '0000200010,0000200002,0000200003';
			params.ctgrNum = '0000200010,0000200002,0000200003';
			break;
		case '7':
			//캘린더
//				params.ctgrNum = '0000201100,0000201101,0000201102,0000201103,0000201104,0000201105,0000201106,0000201107,0000201108,0000201109,0000201110';
			params.ctgrNum = '0000201110,0000201100,0000201101';
			break;
		default:
			//전체
			params.ctgrNum = '000020001100,000020000000,000020040005,000020041200,000020001101,000020000003,000020040005,000020041200,000020001100,000020001101,000020001102,000020001105,000020000000,000020000004,000020000003,000020000006,000020001105,000020000006,000020040201,000020040202,0000200010,0000200002,0000200003,0000201110,0000201100,0000201101';
			break;
		}
		
		//정렬
		params.sortNum = sortNum;
		params.curPage = curPage;
		
		return params;
	}
	, getEventList:function(page) {
		$.ajax({
			url: "/ht/biz/diary/getEventList"
			, data: {page : page}
			, type:"POST"
	        ,dataType: "json"
	        ,success : function(data){
	        	var append = "";
	        	
               	$('#eventPaging').empty();
               	$('#diaryEventList').empty();
	        	
	            if (data) {
	                if(!isEmpty(data)) {
	                	var pageHolder = data.pageHolder;
	                	var list = data.eventList;
	                	
	                	for(var i in list) {
	                		append += '<li> ';
	                		append += '	<a href="/ht/biz/eventDetail?eventId='+list[i].eventId+'"> ';
	                		append += ' <div class="img-wrap"> ';
// 	                		append += '	<span class="img">';
	                		append += '		<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/'+list[i].imageUrl+'" alt="일상의 시그니처가 되다." onerror="this.src=\'http://image.kyobobook.co.kr/images/no_image.gif\';">';
// 	                		append += '	</span> ';
							append += ' </div> ';
	                		append += '	<div class="text-wrap"> ';
// 	                		append += '  	<em class="discount">'+ list[i].stdDscntRate + '%''</em> ';
							if(!isEmpty(list[i].dispDscntRate)){
							append += ' <em class="discount">'
													+ list[i].dispDscntRate + '%'
							append += '	</em>';
							}
	                		append += '  	<strong class="item-title">'+list[i].eventTitle+'</strong> ';
	                		append += '  	<p class="description">'+list[i].eventDtlCont+'</p> ';
// 	                		append += '	</span> ';
	                		if(list[i].eventRangeInfo != null){
		                		append += '	<span class="during-date">'+list[i].eventRangeInfo+'</span> ';
	                		}else if(list[i].eventEndDt == '99991231' || list[i].eventEndDt == '99999999'){
		                		append += '	<span class="during-date">'+formatDate_toString(list[i].eventStartDt, "yyyy.MM.dd")+' ~ </span> ';
	                		}else{
	                			append += '	<span class="during-date">'+formatDate_toString(list[i].eventStartDt, "yyyy.MM.dd")+' ~ '+formatDate_toString(list[i].eventEndDt, "yyyy.MM.dd")+'</span> ';
	                		}
	                		append += ' </div> ';
	                		append += '	</a> ';
	                		append += '</li>';
	                	}
	                	
		                $('#diaryEventList').html(append);

		                var obj = document.getElementById("eventPaging");
		                var hndl = function(page){ return function(e){ 
	                			e.preventDefault();
	                			
	                			$fn.getEventList($(this).attr("href").replace("#",""));
	                			fnMove('event');
	                		};
	                	};
		                obj.appendChild(_getPager(pageHolder, hndl));
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
    $("#timeHour").text(lpad(H, 2, '0'));
    $("#timeMin").text(lpad(M, 2, '0'));
    $("#timeSec").text(lpad(S, 2, '0'));
}

</script>

</head>
<body>
<div class="diary-page">
<div class="diary-title clear">
        <div class="title-wrap">
            <p>매일매일나의이야기</p>
            <h2>2021 DIARY</h2>
        </div>
        <div class="spot-btn-wrap">
            <span>실시간 추천</span>
            <span>다이어리 필터</span>
        </div>
</div>
<!-- <div class="content" id="content"> -->
<div id="m_diary" class="c_both">
<input type="hidden" id="diary_ctgrNum" value="0">
<input type="hidden" id="diary_sortNum" value="0">
<input type="hidden" id="diary_curPage" value="1">
<input type="hidden" id="recobell_recType" value="p001">
<input type="hidden" id="recobell_brandId" value="">

<!-- 메인 슬라이드 -->
<div>
    <div class="main_sec1">
        <ul class="main_slide_btn slide_view">
            <c:forEach items="${listBnr}" var="l" varStatus="st">
                <li class="main_slide_img">
                    <a href="${l.bnrLnkUrl}">
                        <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${l.bnrImgUrl}" alt="${l.bnrImgAlt}"/>
                        <div class="text-wrap">
                        
<%-- 	                        <div class="imgAlt ${st.first?'active':''}">${l.bnrImgAlt }</div> --%>
<%-- 	                        <div class="bnrTitle ${st.first?'active':''}">${l.bnrTitle }</div> --%>
<%-- 	                        <div class="bnrSubTitle ${st.first?'active':''}">${l.bnrSubTitle }</div> --%>

							<div class="imgAlt">${l.bnrImgAlt }</div>
	                        <div class="bnrTitle">${l.bnrTitle }</div>
	                        <div class="bnrSubTitle">${l.bnrSubTitle }</div>
                        </div>
                    </a>
                </li>
            </c:forEach>
                
            
        </ul>
    </div>
</div>

<!-- 오늘만 1+1 증정 -->
	<c:if test="${not empty hotdeal}">
    <a href="/e/${hotdeal.eventId}" class="plus-stuff">
        <div class="plus-title-wrap">
            <strong>오늘만 1+1증정</strong>
        </div>
        <div class="clear-wrap clear">
            <div class="left">
                <div class="time-count-wrap">
                    <div>
                        <b class="font_t time" id="timeHour"></b><strong>HOUR</strong>
                    </div>
                    <div>
                        <b class="font_t time" id="timeMin"></b><strong>MIN</strong>
                    </div>
                    <div>
                        <b class="font_t time" id="timeSec"></b><strong>SEC</strong>
                    </div>
                </div>
                <div class="plus-info">
                    <div class="free-ship">
                        <c:if test = "${hotdeal.freeDlvyYn eq 'Y'}">
							<img src="/images/biz/diary/ic-freeship.png"><b>무료배송</b>
						</c:if>
                    </div>
                    <div class="plus-text">
                        <p class="plus-title">${hotdeal.prdtName}</p>
                        <c:if test="${hotdeal.prdtDscntRate ne '0'}">
                         <b class="discount-pay"><fmt:formatNumber type="number" value="${hotdeal.prdtSellPrice}"/></b>
                         </c:if>
                         <b class="sale-pay"><fmt:formatNumber type="number" value="${hotdeal.lastCpnPrice}"/></b>
                         
<%--                          <c:set var="minus_price" value="${hotdeal.prdtSellPrice * (hotdeal.prdtDscntRate / 100)}"/> --%>
<%--                          <c:set var="event_dc_price" value="${hotdeal.prdtSellPrice - minus_price}"/> --%>
<%--                          <c:set var="round" value="${event_dc_price % 10}"/> --%>
<%--                          <c:set var="event_dc_price" value="${event_dc_price - round}"/> --%>
<%--                          <c:if test="${round >= 5}"><c:set var="event_dc_price" value="${event_dc_price + 10}"/></c:if> --%>
<%--                          <b class="sale-pay"><fmt:formatNumber type="number">${event_dc_price}</fmt:formatNumber></b> --%>
                    </div>
                </div>
            </div>
            <div class="right">
                <div class="img-wrap">
                	<ui:image src="${hotdeal.productImageUrl}" size="400" server="product" alt="${hotdeal.prdtName}"/>
                </div>
            </div>
        </div>
    </a>
    </c:if>


<!-- 선착순 사은품 -->
<div class="cgift">
        <div class="gift-title-wrap">
            <strong>GIFT EVENT</strong>
        </div>
        <a href="/e/70114">
            <img src="/images/biz/diary/pc_사은품배너_1920_470_re_1.jpg"/>
        </a>
</div>

<!-- 오늘의 추천 -->
<div class="today_box max-width">
	<div class="tit_today_box">
       	<span class="txtline_name">실시간 추천</span>
       	<p>당신만을 위한</p>
     </div>
    <ul class="today_a" id="recobellMenu">
		<li class="ic_today on" recType="p001">
		<img/>
			<p>맞춤추천순</p>
		</li>
<!-- 		<li class="ic_bbest" recType="b004"> -->
<!-- 			<p>인기브랜드 베스트</p> -->
<!-- 		</li> -->
		<li class="ic_cbest" recType="m002">
		<img/>
			<p>인기순</p>
		</li>
		<li class="ic_cartbest" recType="m012">
		<img/>
			<p>장바구니인기</p>
		</li>
	</ul>
    
    <div class="prod_list_normal c_both">
            <!-- 이건 어때요 -->
            <div class="pannel1">
                <ul class="tlist_a" id="recobellList">
                </ul>
            </div>
            <!-- / 이건 어때요 -->
            
            <!-- 인기브랜드 베스트 -->
<!--             <div class="pannel2"> -->
<!--                 <ul class="tlist_a" id="recobellBrandList"> -->
<!--                 </ul> -->
<!--             </div> -->
            <!-- / 인기브랜드 베스트 -->
    </div>
    
    <div class="btn_more_a" id="recobellMore">
    	<a href="#" onclick="javacript:event.preventDefault();">
    	</a>
    </div>
    
</div>

<!-- 많이 보고 있는 이벤트  -->
<div class="bestevent_a max-width">
	<div class="bestevent">
		<div class="event_list_a">
			<div class="tit_today_box">
                <span class="txtline_name">많이 보고 있는 이벤트</span>
                <p>인기 급상승</p>
            </div>
            <div class="event-text-deco">
                <p class="stroke-text">Rapid Rise In</p>
                <p class="popular-text">Popularity</p>
            </div>
			<div class="event_list">
				<ul class="list" id="bestEvent">
				  	<c:forEach items="${listBestEvent}" var="l" varStatus="st">
				  		<fmt:parseDate value="${l.eventStartDt}" var="sdt" pattern="yyyyMMdd"/>
				  		<fmt:parseDate value="${l.eventEndDt}" var="edt" pattern="yyyyMMdd"/>
				  		<c:choose>
				  			<c:when test="${st.first}">
				  				<li class="best"> 
								    <a href="/ht/biz/eventDetail?eventId=${l.eventId}"> 
								    	<div class="img-wrap">
		                                    <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${l.imageUrl}" alt="${l.eventTitle}" onerror="this.src='http://image.kyobobook.co.kr/images/no_image.gif';">
		                                </div>
		                                <div class="text-wrap">
		                                    <strong class="title-text">${l.eventTitle}</strong>
		                                    <b class="description-text">${l.eventDtlCont} 
		                                    <c:if test="${not empty l.dispDscntRate}">~${l.dispDscntRate}%</c:if>
		                                    </b>
		                                </div>
		                                <span class="during-date">
		                                    <b><fmt:formatDate value="${sdt}" pattern="yyyy.MM.dd"/></b>
		                                    <b><fmt:formatDate value="${edt}" pattern="yyyy.MM.dd"/></b>
		                                </span>
								    
<!-- 									    <span class="img"> -->
<%-- 									    	<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${l.imageUrl}" alt="${l.eventTitle}" onerror="this.src='http://image.kyobobook.co.kr/images/no_image.gif';"> --%>
<!-- 									    </span>  -->
<!-- 									    <span class="tit">  -->
<%-- 										    <strong class="txt_line1">${l.eventTitle}</strong>  --%>
<%-- 										    <em class="txt_line1">${l.eventDtlCont}</em>  --%>
<!-- 									    </span> -->
								    </a>
<!-- 							    	<p class="txt_eventday"> -->
<%-- 								    	<span class="date mgr5"><fmt:formatDate value="${sdt}" pattern="yyyy.MM.dd"/></span> --%>
<!-- 								    	<span class="line_center"></span> -->
<%-- 								    	<span class="date"><fmt:formatDate value="${edt}" pattern="yyyy.MM.dd"/></span> --%>
<!-- 							    	</p> -->
					    		</li>
				  			</c:when>
				  			<c:otherwise>
				  				<li <c:if test="${st.count > 3}">style="display:none;"</c:if>> 
							    	<a href="/ht/biz/eventDetail?eventId=${l.eventId}"> 
							    		<div class="img-wrap">
		                                    <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${l.imageUrl}" alt="${l.eventTitle}" onerror="this.src='http://image.kyobobook.co.kr/images/no_image.gif';">
		                                </div>
		                                <div class="text-wrap">
		                                    <strong class="title-text">${l.eventTitle}</strong>
		                                    <b class="description-text">${l.eventDtlCont}
		                                    <c:if test="${not empty l.dispDscntRate}">~${l.dispDscntRate}%</c:if>
		                                    </b>
		                                </div>
		                                <span class="during-date">
		                                    <b><fmt:formatDate value="${sdt}" pattern="yyyy.MM.dd"/></b>
		                                    <b><fmt:formatDate value="${edt}" pattern="yyyy.MM.dd"/></b>
		                                </span>
							    	
							    	
<!-- 							    		<span class="img"> -->
<%-- 							    			<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${l.imageUrl}" alt="${l.eventTitle}" onerror="this.src='http://image.kyobobook.co.kr/images/no_image.gif';" /> --%>
<!-- 							    		</span>  -->
<!-- 							    		<span class="tit">  -->
<%-- 							    			<strong class="txt_line1">${l.eventTitle}</strong>  --%>
<%-- 							    			<em class="txt_line1" style="width:290px;display:block;">${l.eventDtlCont}</em>  --%>
<!-- 							    		</span>  -->
<%-- 							    		<span class="date"><fmt:formatDate value="${sdt}" pattern="yyyy.MM.dd"/> ~ <fmt:formatDate value="${edt}" pattern="yyyy.MM.dd"/></span>  --%>
							    	</a> 
							    </li>
				  			</c:otherwise>
				  		</c:choose>
				    </c:forEach>
				</ul>
			</div>
			<div class="btn_more_a" id="bestEventMore">
    			<a href="#" onclick="javacript:event.preventDefault();">
    			</a>
    		</div>
		</div>
	</div>
</div>

<!-- 다이어리 클라우드 -->
<div class="diarycloud_a" id="diary_area">
	<div class="diarycloud">
		<div class="tit_today_box">
            <span class="txtline_name">다이어리 필터</span>
            <p>내가 찾던 다이어리</p>
        </div>
		<ul class="diarycloud_tab"  id="diaryCategory">
			<li class="diaryc00 btn on" ctgrNum="0">
                    <span>ALL</span>
                    <p>전체</p>
                </li>
                <li class="diaryc01 btn" ctgrNum="1">
                    <img src="/images/biz/diary/filter-img1.png"/>
                    <p>심플</p>
                </li>
                <li class="diaryc02 btn" ctgrNum="2">
                    <img src="/images/biz/diary/filter-img2.png"/>
                    <p>일러스트</p>
                </li>
                <li class="diaryc03 btn" ctgrNum="3">
                    <img src="/images/biz/diary/filter-img5.png"/>
                    <p>날짜형</p>
                </li>
                <li class="diaryc04 btn" ctgrNum="4">
                    <img src="/images/biz/diary/filter-img6.png"/>
                    <p>만년형</p>
                </li>
                <li class="diaryc05 btn" ctgrNum="5">
                    <img src="/images/biz/diary/filter-img3.png"/>
                    <p>6공</p>
                </li>
                <li class="diaryc06 btn" ctgrNum="6">
                    <img src="/images/biz/diary/filter-img4.png"/>
                    <p>스케줄러</p>
                </li>
                <li class="diaryc07 btn" ctgrNum="7">
                    <img src="/images/biz/diary/filter-img7.png"/>
                    <p>캘린더</p>
                </li>
		</ul>
		
		<ul class="snb_a" id="diarySort">
			<li class="btn on" sortNum="0">
				<p>베스트순</p>
			</li>
			<li class="btn" sortNum="1">
				<p>최신순</p>
			</li>
			<li class="btn" sortNum="2">
				<p>높은할인율순</p>
			</li>
			<li class="btn" sortNum="3" >
				<p>후기순</p>
			</li>
		</ul>
		
	    <div class="prod_list_normal c_both">
			<div class="pannel1">
				<!-- TOP3 -->
		        <ul class="tlist_a top3 active" id="diaryCloudList_top">
		    	</ul>
			         
				<ul class="tlist_a" id="diaryCloudList">
				</ul>
			</div>
	<div class="paging" id="diaryPaging"></div>
	    </div>
	</div>
</div>

<!-- 스티커 배너 영역 -->
<div class="cgift">
    <a href="http://www.hottracks.co.kr/ht/biz/sticker/stickerMain">
        <img src="/images/biz/diary/pc_스티커배너영역_1920_500.jpg"/>
    </a>
</div>

<!-- 다꾸존 -->
<div class="diarydeco_a">
	<div class="diarydeco">
		<div class="tit_today_box">
            <span class="txtline_name">다꾸 X다꾸</span>
            <p>다꾸 세상으로</p>
        </div>
		<div class="decolist_p">
			<div class="deco_p01">			
                    <a href="/ht/gift/giftCategorySub?ctgrId=00002003" >
                        <img class="deco-bg" src="/images/biz/diary/dakku-pen-bg.png">
                        <img class="deco-item" src="/images/biz/diary/dakku-pen.png">
                    </a>
                </div>
                <div class="deco_p02">			
                    <a href="/ht/gift/giftCategorySub?ctgrId=0000200505" >
                        <img class="deco-bg" src="/images/biz/diary/dakku-memo1.png">
                        <img class="deco-item" src="/images/biz/diary/dakku-memo.png">
                        <img class="deco-bg2" src="/images/biz/diary/dakku-memo2.png">
                    </a>
                </div>
                <div class="deco_p03">			
                    <a href="/ht/gift/giftCategorySub?ctgrId=00002006" >
                        <img class="deco-bg" src="/images/biz/diary/dakku-case1.png">
                        <img class="deco-item" src="/images/biz/diary/dakku-case.png">
                        <img class="deco-bg2" src="/images/biz/diary/dakku-case2.png">
                    </a>
                </div>
                <div class="deco_p04">			
                    <a href="/ht/gift/giftCategorySub?ctgrId=00002013" >
                        <img class="deco-bg" src="/images/biz/diary/dakku-tape1.png">
                        <img class="deco-item" src="/images/biz/diary/dakku-tape.png">
                    </a>
                </div>
		</div>
	</div>
</div>

<!-- 이벤트 리스트 -->
<div class="diaryevent_a" id="event_area">
	<div class="diaryevent">
		<div class="event_list_a">
			<div class="tit_today_box">
                <span class="txtline_name">DIARY EVENT</span>
                <p>혜택을 누리자</p>
            </div>
<!-- 			<h2> -->
<!-- 				<span> -->
<!-- 					<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/diary/2019/tit_diaryevent.png" alt="이벤트리스트"/> -->
<!-- 				</span> -->
<!-- 			</h2> -->
			<div class="event_list">
				<ul class="list" id="diaryEventList">
				</ul>
				<div class="paging" id="eventPaging">
				</div>
		    </div>
		</div>
	</div>
</div>
</div>
</div>
</body>
</html>