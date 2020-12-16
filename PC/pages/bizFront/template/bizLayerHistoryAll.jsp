<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@ page import="java.util.Date" %>
<ui:decorator name="none"/>
<div class="empty_history">
	<img src="/images/biz/sub/history/no_history.png" alt="히스토리 없음">	
	<p><span>아직 쇼핑 히스토리가 없어요<br> 핫트랙스에는<br> 보물 같은 아이들이 많답니다</span><br><br>우리 함께 찾아볼까요?</p>
    <a class="btn_type02_v2 mgt30" href="javascript:;" onclick="location.href='/ht/biz/personal/personalRecommend';return false;">이대로만 따라가요</a>
</div>
<c:set var="now" value="<%=new java.util.Date()%>" />
<div class="box_history pd_list" id="listRecent0">
	<h4 class='tdy font_t'>Today</h4>
	<ul class='catalog_history edit'><!-- 편집 비활성 -->
	</ul>						
</div>
<div class="box_history pd_list" id="listRecent1">
	<h4 class='lst font_t'><fmt:formatDate value="${now}" pattern="yyyy" /></h4>
	<ul class='catalog_history edit'><!-- 편집 비활성 -->
	</ul>						
</div>
<div class="box_history pd_list" id="listRecent2">
	<h4 class='lst font_t'><fmt:formatDate value="${now}" pattern="MMdd" /></h4>
	<ul class='catalog_history edit'><!-- 편집 비활성 -->
	</ul>						
</div>
<script type="text/javascript">
var date = new Date();
var week = new Array('sun', 'mon', 'tue', 'wed', 'thur', 'fri', 'sat');

var date2 = new Date();
date2.setTime(date2.getTime() - (1 * 24 * 60 * 60 * 1000));

var date3 = new Date();
date3.setTime(date2.getTime() - (2 * 24 * 60 * 60 * 1000));

var yy = date.getFullYear();
var mm = date.getMonth()+1;
var dd = date.getDate();

if((mm+"").length < 2){
	mm = "0"+mm;
}
if((dd+"").length < 2){
	dd = "0"+dd;
}

today = yy+''+mm+''+dd;

$(document).ready(function(){
	historyDelete(); //delete
	loadHistoryAllList();
	
	// 편집 이벤트
	$('.txt_blue').unbind().on('click', function(){		
		if($('.lastest_prd .history_inner').hasClass('case01')){
			$('.lastest_prd .history_inner').addClass('case02');
			$('.lastest_prd .history_inner').removeClass('case01');
			$('.catalog_history').addClass('cancel');
			$('.catalog_history').removeClass('edit');
			$('.catalog_history').find('li').addClass('chk_off');			
		}else{
			$('.lastest_prd .history_inner').addClass('case01');
			$('.lastest_prd .history_inner').removeClass('case02');
			$('.catalog_history').addClass('edit');
			$('.catalog_history').removeClass('cancel');
			$('.catalog_history').find('li').removeClass('chk_off');
		}
	});
	
	// 최근 본 상품 필터값 설정시
    $('.history_inner .list_kind li').click(function(){    	
    	$(this).parent('li').toggleClass('active');
   
    	// 1. 클릭한 구분값 처리
    	var gbnLen = $('#filterDiv li').length;
    	var gbnActiveLen = $('#filterDiv .active').length;
    	    	
    	// 활성화된 필터값이 있을 경우
    	if(gbnActiveLen > 0){    		    		
    		for(var i=0; i<gbnLen; i++){
        		// 구분값이 활성화되어 있을 경우 구분값을 가져옴
        		if($('.category_type li:eq('+i+')').hasClass("active")){
        			var gbnNm = $('.category_type li:eq('+i+')').find('i').attr('class');
        			gbnNm = gbnNm.substr(0,5);        			
        			$(".area_overflow ."+gbnNm).removeClass('hide');
        		}else{
        			var gbnNm = $('.category_type li:eq('+i+')').find('i').attr('class');
        			gbnNm = gbnNm.substr(0,5);
        			$(".area_overflow ."+gbnNm).addClass('hide');
        		}               		
        	}
    	}else{	// 모든 필터값이 비활성화일경우
    		$('.box_history ul li').removeClass('hide');	
    	}
    	
		var listLiLen = $('.box_history li').length;	// 리스트 아이템 수
		var listActiveLen = $('.box_history .hide').length;		// 감춰진 아이템 수
		
		if(listLiLen == listActiveLen){        			
// 			$('.vacant_history').show();
			$('.box_history').hide();
			$('.area_overflow').addClass('no');
		}else{
// 			$('.vacant_history').hide();
			$('.area_overflow').removeClass('no');
			$('.box_history').show();
		}
    	    	    	
    	// 날짜별 영역 컨트롤
    	fn_dayByDayControl();
    
    });
});

function loadHistoryAllList(){
	$.ajax({
		url: "/menu/biz/getHistoryAllList"
		, type:"POST"
        ,dataType: "json"
        ,success : function(data){
           	$('#listRecent0 ul').empty();
           	$('#listRecent1 ul').empty();
           	$('#listRecent2 ul').empty();
        	
            if(!isEmpty(data)) {
				var list = data.list;

				if(!isEmpty(list)) {
					for(var i=0; i < list.length; i++) {
						var append = '';
						
						if(list[i].prdtStatCode == 'N'){
							append += '<li class="'+list[i].rcntGbn+' sold_out">';
						}else{
							if(list[i].sellPrdtGbn == 'R' || list[i].sellPrdtGbn == 'D' || list[i].sellPrdtGbn == 'C'){
	                	    	if(list[i].rcrdStat =='2' || list[i].rcrdStat =='3' || list[i].rcrdStat =='4'){
	                	    		append += '<li class="'+list[i].rcntGbn+' sold_out">';
	                	    	}else{
	                	    		append += '<li class="'+list[i].rcntGbn+'">';
	                	    	}
							}else{
								if(list[i].prdtStatCode =='C0313' || list[i].prdtStatCode =='C0314' || list[i].prdtStatCode =='C0315'){
	                	    		append += '<li class="'+list[i].rcntGbn+' sold_out">';
	                	    	}else{
	                	    		append += '<li class="'+list[i].rcntGbn+'">';
	                	    	}
	                	    }
						}
						append += '	<input type="hidden" name="sellPrdtBcode" value="'+list[i].sellPrdtBcode+'"/>';
						if(list[i].rcntGbn == 'ic_01'){
							append += '	<a href="/p/'+list[i].sellPrdtBcode+'" class="btn_erase">';
						}else if(list[i].rcntGbn == 'ic_02'){
							append += '	<a href="/ht/biz/bizSearchMain?searchTerm='+list[i].prdtName+'" class="btn_erase">';
						}else if(list[i].rcntGbn == 'ic_03'){
							append += '	<a href="/ht/biz/eventDetail?eventId='+list[i].sellPrdtBcode+'" class="btn_erase">';
						}else if(list[i].rcntGbn == 'ic_04'){
							append += '	<a href="/ht/biz/eventDetail?eventId='+list[i].sellPrdtBcode+'" class="btn_erase">';
						}else{
							append += '	<a href="/ht/product/detail?barcode='+list[i].sellPrdtBcode+'" class="btn_erase">';
						}
						
						if(list[i].rcntGbn == 'ic_01'){
							append += '		<i>';
							if(list[i].sellPrdtGbn == 'R' || list[i].sellPrdtGbn == 'D'){
	                	    	append += '			<img src="http://image.kyobobook.co.kr/newimages/music/midi/'+list[i].rcrdCd.substring( 1, 5 ).split("").reverse().join("")+'/'+list[i].rcrdCd+'.jpg" alt="'+list[i].prdtName+'" class="photo" width="200" height="200" onerror="this.src=\'http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/no_image2.gif\';">';
	                	    }else{
	                	    	append += '			<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/goods/200/'+list[i].productImageUrl+'" alt="'+list[i].prdtName+'" class="photo" width="200" height="200" onerror="this.src=\'http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/no_image2.gif\';">';
	                	    }
							append += '		</i>';														
							append += '		<div class="desc_type01">';
							append += '			<h2>'+list[i].prdtName+'</h2>';
							append += '			<p>';
							if(list[i].lastCpnPrice != list[i].prdtSellPrice){
								var rate = 100 - ((list[i].lastCpnPrice / list[i].prdtSellPrice) * 100);
		                	    append += '				<span class="font_t percent">'+parseInt(rate)+'%</span>';
	                	    }
							append += '				<span>'+price_format(list[i].lastCpnPrice)+'</span>';
							append += '			</p>';
							append += '		</div>';
						}else{
							append += '		<div class="desc_type02">';
							append += '			<h2>'+list[i].prdtName+'</h2>';
							append += '		</div>';
						}
						append += '		</a>';
						append += '		<a href="javascript:" class="chk_delete"></a>';
						
						if(list[i].rcntGbn == 'ic_01'){
							if(list[i].wishUserPrdtCnt > 0){
								append += '		<a href="javascript:" onclick="addBizWishProduct(this);return false;" class="btn_like active" prdtId="'+list[i].sellPrdtBcode+'"><span>좋아요</span></a>';
							}else{
								append += '		<a href="javascript:" onclick="addBizWishProduct(this);return false;" class="btn_like" prdtId="'+list[i].sellPrdtBcode+'"><span>좋아요</span></a>';
							}
						}else if(list[i].rcntGbn == 'ic_05'){
							append += '		<a href="javascript:" onclick="addBizWishBrand('+list[i].sellPrdtBcode+');return false;" class="btn_like" id="'+list[i].sellPrdtBcode+'"><span>좋아요</span></a>';
						}
						if(list[i].prdtStatCode == 'N'){
							append += '		<div class="run_out out03">';
						}else{
							if(list[i].sellPrdtGbn == 'R' || list[i].sellPrdtGbn == 'D' || list[i].sellPrdtGbn == 'C'){
	                	    	if(list[i].rcrdStat =='2'){
	                	    		append += '		<div class="run_out out01">';
	                	    	}else if(list[i].rcrdStat =='3' || list[i].rcrdStat =='4'){
	                	    		append += '		<div class="run_out out02">';
	                	    	}else{
	                	    		append += '		<div class="run_out">';
	                	    	}
							}else{
								if(list[i].prdtStatCode =='C0313'){
									append += '		<div class="run_out out01">';
	                	    	}else if(list[i].prdtStatCode =='C0314' || list[i].prdtStatCode =='C0315'){
	                	    		append += '		<div class="run_out out02">';
	                	    	}else{
	                	    		append += '		<div class="run_out">';
	                	    	}
	                	    }
						}
						append += '		<span class="out01">일시<br>품절</span>';
						append += '		<span class="out02">품절</span>';
						append += '		<span class="out03">종료</span>';
						append += '	</div>';												
						append += '</li>';

						if(today == (list[i].yyyy+''+list[i].mmdd).replace(/ /gi, "")){
							$('#listRecent0 ul').append(append);
						}else if(today-1 == (list[i].yyyy+''+list[i].mmdd).replace(/ /gi, "")){
							$('#listRecent1 ul').append(append);
						}else if(today-2 == (list[i].yyyy+''+list[i].mmdd).replace(/ /gi, "")){
							$('#listRecent2 ul').append(append);
						}
                	}
					$('#listRecent1 h4').html('<span class="year">'+((today-1)+'').substring(0,4)+'</span> '+((today-1)+'').substring(4,6)+' <em>'+((today-1)+'').substring(6,8)+'</em> <i class="'+week[date2.getDay()]+'"></i>');
					$('#listRecent2 h4').html('<span class="year">'+((today-2)+'').substring(0,4)+'</span> '+((today-2)+'').substring(4,6)+' <em>'+((today-2)+'').substring(6,8)+'</em> <i class="'+week[date3.getDay()]+'"></i>');
				}else{
					$('.area_overflow').addClass('no');
				}
		    	fn_dayByDayControl();
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