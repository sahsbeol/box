<%@ page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="diary"/>
<html>
<head>
<title>다이어리 메인 - NEW ME HOTTRACKS</title>
<link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:100,300,400,500,700|Titillium+Web:400,600&display=swap&subset=korean">
<script type="text/javascript" src="/js/jquery.form.js"></script>
<script type="text/javascript" src="/js/fn_htts_slide.js?20180830155"></script>
<!-- <script type="text/javascript" src="/scripts/loadingBar.js"></script> -->
<script type="text/javascript">
var brand;

$(document).ready(function(){
    slideDiv(".main_sec1", 4000, ".main_sec1");
    $("html,body").scrollTop(0);

    var divs = [
         "#diary_mspot"
        ,"div.diary-event-banner ul.diary_tab"
        ,"#m_diary div.diary-event-banner div.prod_list_normal"
    ];
    
    $("#wrap,#content").css("width", "100%");
    $(divs.join(",")).css({"width":"950px","margin":"0 auto"});
    $("#m_diary div.diary-event-banner h2.tit").css({"width":"100%","background":"url('http://image.kyobobook.co.kr/newimages/giftshop_new/work/1546/1542076443075_barbanner.jpg') no-repeat center center"});
    var left = $(window).width()/2 + 285;
    $("#m_diary div.diary-event-banner h2.tit img").css({"top":"185px","float":"none","left":left+"px"});
    
	
    $('#recobellMenu li').click(function(){
    	$('#recobellMenu li').removeClass("on");
		$(this).addClass("on");
		$('#recobellMore').find("img").removeClass("off");
		$('#recobell_recType').val($(this).attr("recType"));
		
		$fn.getRecobellList();
	});
	$('#recobellMore').click(function(){
		$('#recobellList li').show();
		$('#recobellBrandList li').show();
		$('#recobellMore').find("img").addClass("off");
	});
	$('#bestEventMore').click(function(){
		$('#bestEvent li').show();
		$(this).find("img").addClass("off");
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
		$('#recobellMore').find("img").removeClass("off");
		
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
			url: "/ht/diary/getRecobellList"
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
						var basicLength = 8;
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
							if(recType != "p001"){
								if(i<3){
									append += '		<span class="ic_tagnum">'+(i+1)+'</span>';
								}else{
									append += '		<span class="ic_tagnum gray">'+(i+1)+'</span>';
								}
		                	    append += '		<span class="img">';
							}else{
								append += '		<span class="img mt31">';
							}
	                	    if(list[i].sellPrdtGbn == 'R' || list[i].sellPrdtGbn == 'D'){
	                	    	append += '			<a href="/ht/product/detail?barcode='+list[i].sellPrdtBcode+rcCode+'"><img src="http://image.kyobobook.co.kr/newimages/music/midi/'+list[i].rcrdCd.substring( 1, 5 ).split("").reverse().join("")+'/'+list[i].rcrdCd+'.jpg" alt="'+list[i].prdtName+'" class="photo" width="200" height="200" onerror="this.src=\'http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/no_image2.gif\';"></a>';
	                	    }else{
	                	    	append += '			<a href="/ht/product/detail?barcode='+list[i].sellPrdtBcode+rcCode+'"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/goods/400/'+list[i].prdtImgUrl+'" alt="'+list[i].prdtName+'" class="photo" width="200" height="200" onerror="this.src=\'http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/no_image2.gif\';"></a>';
	                	    }
	                	    append += '			<div class="hide_util">';
	                	    append += '			    <a href="javascript://" onclick="productPreview('+list[i].sellPrdtBcode+')" class="zoom"><span>확대</span></a>';
	                	    append += '			    <a href="/ht/product/detail?barcode='+list[i].sellPrdtBcode+'" target="_blank" class="nblank"><span>새창</span></a>';
	                	    append += '			    <a href="javascript://" onclick="addWishProduct('+list[i].sellPrdtBcode+')" class="zzim"><span>좋아요</span></a>';
	                	    append += '			</div>';
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
	                	    if(list[i].reviewCount != 0){
		                	    append += '		    <span class="ico_review">'+list[i].reviewCount+'</span>';
	                	    }
	                	    if(list[i].reviewCount != 0){
		                	    append += '		    <span class="ico_like">'+list[i].wishPrdtCnt+'</span>';
	                	    }
	                	    append += '			</span>';
	                	    append += '		</a>';
	                	    append += '	</li>';
	                	}
	                	
						target.html(append);
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
			url: "/ht/diary/getDiaryList"
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
	                			append_top += '			<div class="hide_util">';
	                			append_top += '			    <a href="javascript://" onclick="productPreview('+list[i].sellPrdtBcode+')" class="zoom"><span>확대</span></a>';
	                			append_top += '			    <a href="/ht/product/detail?barcode='+list[i].sellPrdtBcode+'" target="_blank" class="nblank"><span>새창</span></a>';
	                			append_top += '			    <a href="javascript://" onclick="addWishProduct('+list[i].sellPrdtBcode+')" class="zzim"><span>좋아요</span></a>';
	                			append_top += '			</div>';
	                			append_top += '		</span>';
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
		                	    append_top += '		    <span class="ico_like">'+list[i].wishPrdtCnt+'</span>';
		                	    append_top += '			</span>';
		                	    append_top += '		</a>';
		                	    append_top += '	</li>';
	                		}else{
	                			append += '	<li>';
		                	    append += '		<span class="ic_tagnum gray">'+list[i].dispSeq+'</span>';
		                	    append += '		<span class="img">';
		                	    append += '			<a href="/ht/product/detail?barcode='+list[i].sellPrdtBcode+'"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/goods/400/'+list[i].prdtImgUrl+'" alt="'+list[i].prdtName+'" class="photo" width="200" height="200" onerror="this.src=\'http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/no_image2.gif\';"></a>';
		                	    append += '			<div class="hide_util">';
		                	    append += '			    <a href="javascript://" onclick="productPreview('+list[i].sellPrdtBcode+')" class="zoom"><span>확대</span></a>';
		                	    append += '			    <a href="/ht/product/detail?barcode='+list[i].sellPrdtBcode+'" target="_blank" class="nblank"><span>새창</span></a>';
		                	    append += '			    <a href="javascript://" onclick="addWishProduct('+list[i].sellPrdtBcode+')" class="zzim"><span>좋아요</span></a>';
		                	    append += '			</div>';
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
		                	    if(list[i].reviewCount != 0){
			                	    append += '		    <span class="ico_review">'+list[i].reviewCount+'</span>';
		                	    }
		                	    if(list[i].reviewCount != 0){
			                	    append += '		    <span class="ico_like">'+list[i].wishPrdtCnt+'</span>';
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
	                			fnMove('diary');
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
		  case '1' :
			//심플
		  	params.ctgrNum = '000020001100,000020000000,000020001102,000020000004,00000725,00002004';
		    break;
		  case '2' :
			//일러스트
			params.ctgrNum = '000020001101,000020000003';
		    break;
		  case '3' :
			//6공
			params.ctgrNum = '000020000006,000020001105,0000200007';
		    break;
		  case '4' :
			//스케줄러
			params.ctgrNum = '0000200010,0000200002,0000200003';
		    break;
		  case '5' :
			//날짜형
			params.ctgrNum = '000020001100,000020001101,000020001102,000020001103,0000200010,000020040005,0000072500,0000072501,0000072502';
		    break;
		  case '6' :
			//만년형
			params.ctgrNum = '000020000000,000020000004,000020000003,000020040001,000020040002,000020040006';
		    break;
		  case '7' :
			//캘린더
			params.ctgrNum = '0000201100,0000201101,0000201102,0000201103,0000201104,0000201105,0000201106,0000201107,0000201108,0000201109,0000201110';
		    break;
		  default :
			//전체
			params.ctgrNum = '000020001100,000020000000,000020001102,000020000004,00000725,00002004,000020001101,000020000003,000020000006,000020001105,0000200007,0000200010,0000200002,0000200003,000020001100,000020001101,000020001102,000020001103,0000200010,000020040005,0000072500,0000072501,0000072502,000020000000,000020000004,000020000003,000020040001,000020040002,000020040006,00002011';
		    break;
		}
		
		//정렬
		params.sortNum = sortNum;
		params.curPage = curPage;
		
		return params;
	}
	, getEventList:function(page) {
		$.ajax({
			url: "/ht/diary/getEventList"
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
	                		append += '	<span class="img">';
	                		append += '		<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/'+list[i].imageUrl+'" alt="일상의 시그니처가 되다." onerror="this.src=\'http://image.kyobobook.co.kr/images/no_image.gif\';">';
	                		append += '	</span> ';
	                		append += '	<span class="tit"> ';
	                		append += '  	<strong class="txt_line1">'+list[i].eventTitle+'</strong> ';
	                		append += '  	<em class="txt_line1">'+list[i].eventDtlCont+'</em> ';
	                		append += '	</span> ';
	                		if(list[i].eventRangeInfo != null){
		                		append += '	<span class="date">'+list[i].eventRangeInfo+'</span> ';
	                		}else if(list[i].eventEndDt == '99991231' || list[i].eventEndDt == '99999999'){
		                		append += '	<span class="date">'+formatDate_toString(list[i].eventStartDt, "yyyy.MM.dd")+' ~ </span> ';
	                		}else{
	                			append += '	<span class="date">'+formatDate_toString(list[i].eventStartDt, "yyyy.MM.dd")+' ~ '+formatDate_toString(list[i].eventEndDt, "yyyy.MM.dd")+'</span> ';
	                		}
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
</script>

</head>
<body>
<input type="hidden" id="diary_ctgrNum" value="0">
<input type="hidden" id="diary_sortNum" value="0">
<input type="hidden" id="diary_curPage" value="1">
<input type="hidden" id="recobell_recType" value="p001">
<input type="hidden" id="recobell_brandId" value="">

<!-- 메인 슬라이드 -->
<div id="diary_mspot">
    <div class="main_sec1">
        <ul class="main_slide_btn slide_view">
            <c:forEach items="${listBnr}" var="l" varStatus="st">
                <li class="main_slide_img">
                    <a href="${l.bnrLnkUrl}">
                        <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${l.bnrImgUrl}" alt="${l.bnrImgAlt}"/>
                        <div class="bnrTitle ${st.first?'active':''}">${l.bnrTitle }</div>
                        <div class="bnrSubTitle ${st.first?'active':''}">${l.bnrSubTitle }</div>
                        <div class="imgAlt ${st.first?'active':''}">${l.bnrImgAlt }</div>
                    </a>
                </li>
            </c:forEach>
        </ul>
        <ul class="main_slide_navi">
            <c:forEach items="${listBnr}" var="l" varStatus="st">
                <li class="slide_navi ${st.first?'active':''}"><a href="javascript://"></a></li>
            </c:forEach>
            <li class="slide_ctrl">
                <a class="prev" href="javascript://"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/diary/2018/btn_left.png"/></a>
                <a class="next" href="javascript://"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/diary/2018/btn_right.png"/></a>
            </li>
        </ul>
    </div>
</div>

<!-- 선착순 사은품 -->
<div class="cgift c_both">
	<a href="http://www.hottracks.co.kr/ht/biz/eventDetail?eventId=63478" target="_blank">
    	<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/diary/2019/btn_cgift.png"/>
    </a>
</div>

<!-- 오늘의 추천 -->
<div class="today_box c_both">
	<h2><span class="txtline_name">
		<c:choose>
		    <c:when test="${not empty userName}">
				${userName}
		    </c:when>
		    <c:otherwise>
				고객
		    </c:otherwise>
		</c:choose>
		<em>님</em>
		</span><span class="fontw100"> 만을 위한</span> 오늘의 추천</h2>
    <ul class="today_a" id="recobellMenu">
		<li class="ic_today on" recType="p001">
			<span class="ic_img"></span>
			<p>이건 어때요</p>
		</li>
		<li class="ic_bbest" recType="b004">
			<span class="ic_img"></span>
			<p>인기브랜드 베스트</p>
		</li>
		<li class="ic_cbest" recType="m002">
			<span class="ic_img"></span>
			<p>클릭 베스트</p>
		</li>
		<li class="ic_cartbest" recType="m012">
			<span class="ic_img"></span>
			<p>장바구니 베스트</p>
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
            <div class="pannel2">
                <ul class="tlist_a" id="recobellBrandList">
                </ul>
            </div>
            <!-- / 인기브랜드 베스트 -->
    </div>
    
    <div class="btn_more_a" id="recobellMore">
    	<a href="#" onclick="javacript:event.preventDefault();"><img class="btn_more" src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/diary/2019/btn_more.png"/></a>
    </div>
    
</div>

<!-- 많이 보고 있는 이벤트  -->
<div class="bestevent_a">
	<div class="bestevent">
		<div class="event_list_a">
			<h2><span>많이 보고 있는 이벤트</span></h2>
			<div class="event_list">
				<ul class="list" id="bestEvent">
				  	<c:forEach items="${listBestEvent}" var="l" varStatus="st">
				  		<fmt:parseDate value="${l.eventStartDt}" var="sdt" pattern="yyyyMMdd"/>
				  		<fmt:parseDate value="${l.eventEndDt}" var="edt" pattern="yyyyMMdd"/>
				  		<c:choose>
				  			<c:when test="${st.first}">
				  				<li class="best"> 
								    <a href="/ht/biz/eventDetail?eventId=${l.eventId}"> 
									    <span class="img">
									    	<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${l.imageUrl}" alt="${l.eventTitle}" onerror="this.src='http://image.kyobobook.co.kr/images/no_image.gif';">
									    </span> 
									    <span class="tit"> 
										    <strong class="txt_line1">${l.eventTitle}</strong> 
										    <em class="txt_line1">${l.eventDtlCont}</em> 
									    </span>
								    </a>
							    	<p class="txt_eventday">
								    	<span class="date mgr5"><fmt:formatDate value="${sdt}" pattern="yyyy.MM.dd"/></span>
								    	<span class="line_center"></span>
								    	<span class="date"><fmt:formatDate value="${edt}" pattern="yyyy.MM.dd"/></span>
							    	</p>
					    		</li>
				  			</c:when>
				  			<c:otherwise>
				  				<li <c:if test="${st.count > 3}">style="display:none;"</c:if>> 
							    	<a href="/ht/biz/eventDetail?eventId=${l.eventId}"> 
							    		<span class="img">
							    			<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${l.imageUrl}" alt="${l.eventTitle}" onerror="this.src='http://image.kyobobook.co.kr/images/no_image.gif';" />
							    		</span> 
							    		<span class="tit"> 
							    			<strong class="txt_line1">${l.eventTitle}</strong> 
							    			<em class="txt_line1" style="width:290px;display:block;">${l.eventDtlCont}</em> 
							    		</span> 
							    		<span class="date"><fmt:formatDate value="${sdt}" pattern="yyyy.MM.dd"/> ~ <fmt:formatDate value="${edt}" pattern="yyyy.MM.dd"/></span> 
							    	</a> 
							    </li>
				  			</c:otherwise>
				  		</c:choose>
				    </c:forEach>
				</ul>
			</div>
			<div class="btn_more_a" id="bestEventMore">
    			<a href="#" onclick="javacript:event.preventDefault();"><img class="btn_more" src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/diary/2019/btn_more.png"/></a>
    		</div>
		</div>
	</div>
</div>

<!-- 다이어리 클라우드 -->
<div class="diarycloud_a" id="diary_area">
	<div class="diarycloud">
		<h2><span>다이어리 클라우드</span></h2>
		<ul class="diarycloud_tab"  id="diaryCategory">
			<li class="diaryc00 btn on" ctgrNum="0">
				<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/diary/2019/btn_diaryc00.png"/>
				<p>전체보기</p>
			</li>
			<li class="diaryc01 btn" ctgrNum="1">
				<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/diary/2019/btn_diaryc01.png"/>
				<p>심플</p>
			</li>
			<li class="diaryc02 btn" ctgrNum="2">
				<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/diary/2019/btn_diaryc02.png"/>
				<p>일러스트</p>
			</li>
			<li class="diaryc03 btn" ctgrNum="3">
				<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/diary/2019/btn_diaryc03.png"/>
				<p>6공</p>
			</li>
			<li class="diaryc04 btn" ctgrNum="4">
				<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/diary/2019/btn_diaryc04.png"/>
				<p>스케줄러</p>
			</li>
			<li class="diaryc05 btn" ctgrNum="5">
				<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/diary/2019/btn_diaryc05.png"/>
				<p>날짜형</p>
			</li>
			<li class="diaryc06 btn" ctgrNum="6">
				<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/diary/2019/btn_diaryc06.png"/>
				<p>만년형</p>
			</li>
			<li class="diaryc07 btn" ctgrNum="7">
				<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/diary/2019/btn_diaryc07.png"/>
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
		        <ul class="tlist_a top3" id="diaryCloudList_top">
		    	</ul>
			         
				<ul class="tlist_a" id="diaryCloudList">
				</ul>
			</div>
	    </div>
	</div>
	<div class="paging" id="diaryPaging">
    </div>
</div>

<!-- 다꾸존 -->
<div class="diarydeco_a">
	<div class="diarydeco">
		<div class="decolist_p">
			<div class="deco_p01">			
				<a href="/ht/gift/giftCategorySub?ctgrId=00002003" >
					<img class="btn_deco1" src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/diary/2019/btn_deco01.png" alt="필기구"/>
					<img class="deco1" src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/diary/2019/img_deco01.png" alt="필기구"/>
				</a>
			</div>
			<div class="deco_p02">			
				<a href="/ht/gift/giftCategorySub?ctgrId=0000200505" >
					<img class="btn_deco2" src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/diary/2019/btn_deco02.png" alt="메모지"/>
					<img class="deco2" src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/diary/2019/img_deco02.png" alt="메모지"/>
				</a>
			</div>
			<div class="deco_p03 c_both">			
				<a href="/ht/gift/giftCategorySub?ctgrId=00002006" >
					<img class="btn_deco3" src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/diary/2019/btn_deco03.png" alt="필통"/>
					<img class="deco3" src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/diary/2019/img_deco03.png" alt="필통"/>
				</a>
			</div>
			<div class="deco_p04">			
				<a href="/ht/gift/giftCategorySub?ctgrId=00002013" >
					<img class="btn_deco4" src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/diary/2019/btn_deco04.png" alt="데코테이프"/>
					<img class="deco4"  src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/diary/2019/img_deco04.png" alt="데코테이프"/>
				</a>
			</div>
			<div class="deco_p05 c_both">			
				<a href="/ht/gift/giftCategorySub?ctgrId=0000200800" >
					<img class="btn_deco5" src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/diary/2019/btn_deco05.png" alt="스티커"/>
					<img class="deco5" src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/diary/2019/img_deco05.png" alt="스티커"/>
				</a>
			</div>
		</div>
	</div>
</div>

<!-- 이벤트 리스트 -->
<div class="diaryevent_a" id="event_area">
	<div class="diaryevent">
		<div class="event_list_a">
			<h2>
				<span>
					<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/diary/2019/tit_diaryevent.png" alt="이벤트리스트"/>
				</span>
			</h2>
			<div class="event_list">
				<ul class="list" id="diaryEventList">
				</ul>
				<div class="paging" id="eventPaging">
				</div>
		    </div>
		</div>
	</div>
</div>

</body>
</html>