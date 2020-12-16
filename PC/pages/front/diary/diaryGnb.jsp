<%@ page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui"%>
<script type="text/javascript">
jQuery(function($){
    $("#moreCategoryList").click(
        function(event){
            event.preventDefault();
            if($(".diary-gnb-menu").hasClass("detail-mode")){
                $(".diary-gnb-menu").removeClass("detail-mode");
            }else{
                $(".diary-gnb-menu").addClass("detail-mode");
            }
        }
    );
});

function fnMove(id){
	
	//카테고리 분류
	switch (id) {
	  case 'diary' :
		id = 'diary_area';
	    break;
	  case 'calender' :
		id = 'diary_area';

		$('#diary_ctgrNum').val("7");
		$('#diary_sortNum').val("0");
		$('#diary_curPage').val("1");
		
		$('#diaryCategory li').removeClass("on");
		$('.diaryc07').addClass("on");
		
		$('#diarySort li').removeClass("on");
		$("#diarySort li:first").addClass("on");
		
		$fn.getDiaryList();

	    break;
	  case 'event' :
		id = 'event_area';
	    break;
	  default :
	  	id = 'diary_area';
	  	
	  	$('#diaryCategory li').removeClass("on");
		$('.diaryc00').addClass("on");
	  
	  	$('#diarySort li').removeClass("on");
		$("#diarySort li:first").addClass("on");
		
		$('#diary_ctgrNum').val("0");
		$('#diary_sortNum').val("0");
	    $('#diary_curPage').val("1");
	  	$fn.getDiaryList();
	  	
	    break;
	}
	
    var offset = $("#" + id).offset();
    $('html, body').animate({scrollTop : offset.top}, 400);
}
</script>
<div id="diary-header" class="diary-gnb">
    <div id="top-banner" class="diary-header">
        <div class="f_left mgt40"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/diary/2019/tit_img.png"/></div>
			<ul class="gnb_a f_right">
				<li class="ic_diary on">
					<a href="#" onclick="javascript:fnMove('diary');">
						<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/diary/2019/ic_diary.png"/>
						<p>다이어리</p>
					</a>
				</li>
				<li class="ic_calender">
					<a href="#" onclick="javascript:fnMove('calender');">
						<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/diary/2019/ic_calender.png"/>
						<p>캘린더</p>
					</a>
				</li>
				<li class="ic_even">
					<a href="#" onclick="javascript:fnMove('event');">
						<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/diary/2019/ic_even.png"/>
						<p>이벤트</p>
					</a>
				</li>
				<li class="ic_best">
					<a href="#" onclick="javascript:fnMove('best');">
						<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/diary/2019/ic_best.png"/>
						<p>BEST20</p>
					</a>
				</li>
			</ul>
    </div>
</div>