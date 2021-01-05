<%@ page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<head>
<!-- 태그 라이브러리 -->
<%@ include file="/pages/decorators/biz/tagHeader.jsp" %>
<ui:decorator name="bizFull"/>
<script type="text/javascript" src="/js/jquery.rwdImageMaps.min.js"></script>
<script type="text/javascript" src="/js/jquery.form.js"></script>

<!--  레코벨 스크립트 -->
<script type="text/javascript">
  var _recoUserId = getCookie('UserCookieKey');
  window._eglqueue = window._eglqueue || [];
  _eglqueue.push(['setVar','cuid','e15e978e-3623-4892-bf0a-485b9f8196ee']);
  _eglqueue.push(['setVar','planId','${detail.eventId}']);
  _eglqueue.push(['setVar','userId',SHA256(_recoUserId)]);  // optional
  _eglqueue.push(['track','view']); 
  setTimeout(function() {
    (function(s,x){s=document.createElement('script');s.type='text/x-x-javascript';
    s.async=true;s.defer=true;s.src=(('https:'==document.location.protocol)?'https':'http')+
    '://logger.eigene.io/js/logger.min.js';
    x=document.getElementsByTagName('script')[0];x.parentNode.insertBefore(s, x);})();
  }, 0);
</script>
<!--  레코벨 스크립트 끝-->

<script type="text/javascript">
//레이어 팝업 
function go_popup(img) { 
    popimg.src = img; 
    $("#popup").bPopup({
    	follow: [false, false],
        position: [000, 'auto'] //x, y
    });
}

//핫트 프라이데이 이벤트 포인트지급 참여 때문에 일회용으로 만듦(단계별이벤트형식으로 지급) - 스텝순서무시
var date = new Date(); 
var day = date.getDate(); 
var st = 1;
var shareYn = 0; 
//20일(1step), 21일(2step), 22일(3step)
switch(day) {
	case 21:
		st = 2;	
		break;
	case 22:
		st = 3;
		break;
}

function ht_dailyCheck(){ 
	if (!isLogin) {
        needLogin();
    }else{
        $.ajax({
            type: 'POST'
            ,url: '/m/hot/saveEventHistory'
            ,data: {eventId:"${detail.eventId}", step : st}
            ,dataType: 'json'
            ,async: false
            ,success: function(data) {
                alert(data.alert);
                if (data.save) {
                    location.reload(true);
                }
            }
            ,error: function(data) {
                alert('이벤트 진행 중 오류가 발생하였습니다. 잠시 후 다시 이용해주세요');
            }
        });
    }
}
/* 핫트 프라이데이 응모하기 이벤트 (1회용)*/
function ht_entryEvent(){
	
	var eventId = '${detail.eventId}';
	
	if(eventId == '65004'){
		eventId = '65101';
	}
	
	if (preValidation()) {
		if (shareYn > 0) {
	        $.ajax({
	            type: "GET"
	            ,url: "/m/hot/entryEvent"
	            ,data: "eventId="+eventId
	            ,dataType: 'json'
	            ,success: function(data) {
	                if (data.result.save) {
	                    alert(data.result.resultMsg);
	                } else {
	                    alert(data.result.errMsg);
	                }
	            }
	            ,error: function(data) {
	                alert('<fmt:message key="error.common.system"/>');
	            }
	        });
		}else{
			alert('친구에게 공유하기를 하신 후 참여가능합니다');
		}
    }	
}

function ht_shareEvent(){
	sendKakao('[핫트랙스] ' + "${detail.eventTitle}", 'http://m.hottracks.co.kr/e/${detail.eventId}');
}

function ht_eventSns(eventNum) {
    if (!isLogin) {
        needLogin();
    } else {
        $.ajax({
            type: "GET"
            ,url: "/m/getEventRequest"
            ,data: 'eventNum='+eventNum
            ,dataType: "json"
            ,success: function(data) {
                if (data.save) {
                	sendKakao('[핫트랙스] '+"${detail.eventTitle}", 'http://m.hottracks.co.kr/e/${detail.eventId}');
                } else {
                	sendKakao('[핫트랙스] '+"${detail.eventTitle}", 'http://m.hottracks.co.kr/e/${detail.eventId}');
                }
            }
            ,error: function() {
                alert('<fmt:message key="error.common.system"/>');
            }
        });
    }
}

function go_membership() {
    if (isLogin) {
        alert("이미 로그인한 상태입니다.");
    } else {
    	location.href="https://mobile.kyobobook.co.kr/member/join?partnerCode=HOT";
    }
}

$(document).ready(function() {
	eventFn(); //event
	$("#wrap").removeClass("mini");
    $("#locEvent").addClass("active");
    $(window).load(function(){
        if('${skip}' == 'skipEvent'){
            $(".ly_box_skip").addClass("active");
            $(".ly_box_skip.active").css("height", $(".event_cont").height());
            $("form[name=eventCommentForm] textarea[name=cmnt]").attr("disabled","disabled");
            }
    });
    $('img[usemap]').rwdImageMaps();
    $("img.lazy").lazyload({placeholder:'/images/no_image2.gif',effect : "fadeIn"});
    
    var date = new Date();
	
	var yy = date.getFullYear();
	var mm = date.getMonth()+1;
	var dd = date.getDate();
	var hh = date.getHours();
	
	if((mm+"").length < 2){
		mm = "0"+mm;
	}
	if((dd+"").length < 2){
		dd = "0"+dd;
	}
	if((hh+"").length < 2){
		hh = "0"+hh;
	}
	
	today = yy+''+mm+''+dd+''+hh;

	if ("70780"=="${detail.eventId}") {
		$("#loading").remove();
		fn_event_70780_count();
	};
	
	var today70221 = yy+''+mm+''+dd;
	if ("70221"=="${detail.eventId}") { 
		
// 		switch (today70221){
// 		    case '20201009' :
// 		    	$('.event_cont > div > img').attr('src','http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/2020_quiz/70221_01_m.png');
// 		        break;
// 		    case '20201010' :
// 		    	$('.event_cont > div > img').attr('src','http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/2020_quiz/70221_02_m.png');
// 		        break;
// 		    case '20201011' :
// 		    	$('.event_cont > div > img').attr('src','http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/2020_quiz/70221_03_m.png');
// 		        break;
// 		    case '20201012' :
// 		    	$('.event_cont > div > img').attr('src','http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/2020_quiz/70221_04_m.png');
// 		        break;
// 		    case '20201013' :
// 		    	$('.event_cont > div > img').attr('src','http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/2020_quiz/70221_05_m.png');
// 		        break;
// 		    default :
// 		    	$('.event_cont > div > div > img').attr('src','http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/2020_quiz/70221_01_m.png');
// 		}
		
		
	};
    
    if ("68151"=="${detail.eventId}" || "68152"=="${detail.eventId}" || "68153"=="${detail.eventId}" || "68154"=="${detail.eventId}" || "68193"=="${detail.eventId}") {
    	var menutap = $(".menutap").offset().top;
        $(window).scroll(function() {
            var window = $(this).scrollTop();

            if(menutap <= window) {
              $(".menutap").addClass("fixed");
            } else {
              $(".menutap").removeClass("fixed");
            }
        });
        $("#loading").remove();
	};

});

isLogin = ${isLogin};
isEntryTerm = ${entryTermYn};

function preValidation() {
    if (!isLogin) {
        needLogin();
        return false;
    } else if (!isEntryTerm) {
        alert("해당기간이 아닙니다.");
        return false;
    }

    return true;
}

/* 참여이벤트 */
function entryEvent(){
    if (preValidation()) {
        $.ajax({
            type: "GET"
            ,url: "/m/hot/entryEvent"
            ,data: "eventId=${detail.eventId}"
            ,dataType: 'json'
            ,success: function(data) {
                if (data.result.save) {
                    alert(data.result.resultMsg);
                } else {
                    alert(data.result.errMsg);
                }
            }
            ,error: function(data) {
                alert('<fmt:message key="error.common.system"/>');
            }
        });
    }
}


/* 참여이벤트 -주문금액 */
function entryEventAmt(){
    if (preValidation()) {
        $.ajax({
            type: "GET"
            ,url: "/m/hot/entryEventAmt"
            ,data: "eventId=${detail.eventId}"
            ,dataType: 'json'
            ,success: function(data) {
                if (data.result.save) {
                    alert(data.result.resultMsg);
                } else {
                    alert(data.result.errMsg);
                }
            }
            ,error: function(data) {
                alert('<fmt:message key="error.common.system"/>');
            }
        });
    }
}

function moveToLayer(preInseq, moveInseq){
    if(preInseq != moveInseq){
        $("#eventTypeInseq"+preInseq).find("option[value="+preInseq+"]").attr("selected", true);
        $("html,body").animate({scrollTop: $("#eventTypeInseq"+moveInseq).offset().top - $("#header").height()}, 500);
    }
}

function couponDown(couponId) {
    if (!isLogin) {
        needLogin();
    } else {
        $.ajax({
            type: "GET"
            ,url: "/m/getCouponDown"
            ,data: 'couponId=' + couponId
            ,dataType: "json"
            ,success: function(data) {
                if (data.save) {
                    alert("쿠폰이 다운로드 되었습니다.");
                } else {
                    alert(data.errorMessage);
                }
            }
            ,error: function() {
                alert('시스템오류가 발생하였습니다. 고객센터에 문의해주시기 바랍니다.');
            }
        });
    }
}

function checkEmtcId(obj, imgSrc){
    $(".comment_emtc li a.on").removeClass("on");
    obj.setAttribute("class", "on");
    $("input[name=emtcId]").val(imgSrc);
}

function _applyEvent(){
    if (!isLogin) {
        needLogin();
    } else {
        $.ajax({
            type: 'POST'
            ,url: '/m/hot/saveCheckEvent'
            ,data: { eventId:"${detail.eventId}" }
            ,dataType: 'json'
            ,success: function(data) {
                alert(data.alert);
                if (data.save) {
                    location.reload(true);
                }
            }
            ,error: function(data) {
                alert('응모 중 오류가 발생하였습니다. 잠시 후 다시 이용해주세요');
            }
        });
    }
}

function saveOff(){
    if($("input[name=userName]").val() == null ||  $("input[name=userName]").val() == ""){
        alert("이름을 입력해주세요.");
    }else if($("input[name=handPhoneNum1]").val() == null ||  $("input[name=handPhoneNum1]").val() == ""
       ||$("input[name=handPhoneNum2]").val() == null ||  $("input[name=handPhoneNum2]").val() == ""
       ||$("input[name=handPhoneNum3]").val() == null ||  $("input[name=handPhoneNum3]").val() == ""
       ){
            alert("핸드폰번호를 입력해주세요.");
    }else if($("textarea[name=userAddr]").val() == null ||  $("textarea[name=userAddr]").val() == ""){
            alert("주소지를 입력해주세요.");
    }else if($("input[name=userDtl]").val() == null ||  $("input[name=userDtl]").val() == ""){
            alert("영수증번호를 입력해주세요.");
    }else{
        var userTelNum = $("input[name=handPhoneNum1]").val() + $("input[name=handPhoneNum2]").val() + $("input[name=handPhoneNum3]").val();
        $('form[name="eventCommentForm"]').ajaxSubmit({
            url: '/m/hot/entryEventOff'
            ,dataType: 'json'
            ,data :{
            	eventId : '${detail.eventId}',
                userTelNum : userTelNum
            }
            ,success: function(data) {
                if (data.result.save) {
                    alert(data.result.resultMsg);
                    location.href="/m/welcomeMain";
                } else {
                    alert(data.result.errMsg);
                }
            }
            ,error: function(data) {
                alert('<fmt:message key="error.common.system"/>');
            }
        });
    }
}

$(document).on("touchend","#replaceBtnId",function() {
    replaceBtn($('#replaceBtnId').attr("code"));
});

$(function(){
    $('.replace-modal .close-btn').click(function(){
        $('.replace-modal').hide();
//         $('html,body').removeClass('noscroll');
    });
});

function replaceBtn(bcode){
	setRecobellRelationList(bcode);
	$('.replace-modal').show();
// 	$('html,body').addClass('noscroll');
}

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

function eventRequest(eventNum) {
    if (!isLogin) {
        needLogin();
    } else {
        $.ajax({
            type: "GET"
            ,url: "/m/getEventRequest"
            ,data: 'eventNum=' + eventNum
            ,dataType: "json"
            ,success: function(data) {
                if (data.save) {
                    alert(data.msg);
                } else {
                    alert(data.msg);
                }
            }
            ,error: function() {
                alert('<fmt:message key="error.common.system"/>');
            }
        });
    }
}

function eventRequest_69885(eventNum, couponId) {
    if (!isLogin) {
        needLogin();
    } else {
        $.ajax({
            type: "GET"
            ,url: "/m/getEventRequest"
            ,data: 'eventNum=' + eventNum
            ,dataType: "json"
            ,success: function(data) {
                if (data.save) {
                	$.ajax({
        	            type: "GET"
        	            ,url: "/m/getCouponDown"
        	            ,data: 'couponId=' + couponId
        	            ,dataType: "json"
        	            ,success: function(data) {
        	                if (data.save) {
        	                    alert("쿠폰이 다운로드 되었습니다.");
        	                } else {
        	                    alert(data.errorMessage);
        	                }
        	            }
        	            ,error: function() {
        	                alert('<fmt:message key="error.common.system"/>');
        	            }
        	        });
                } else {
                    alert(data.msg);
                }
            }
            ,error: function() {
                alert('<fmt:message key="error.common.system"/>');
            }
        });
    }
}

function _syncData(){
	if (!isLogin) {
        needLogin();
    } else {
    	 /*FingerPush 수신 여부 관련 Native App 함수 호출*/
        var userAgent = navigator.userAgent;
        //안드로이드
        if(/Android/i.test(userAgent)){
        	if(window.HybridApp != undefined && window.HybridApp.pushRcvYn != undefined){
        		window.HybridApp.pushRcvYn('Y'); 
            }
        }
        //iOS
        else if(/iPad|iPhone|iPod/i.test(userAgent) && !window.MSStream){
        	try{
        		document.location = "myScheme://pushRcvYn?Y";
        	}catch(err){
        		alert(err);
        	}
        }
    	
    	var device = '${device.devId}';
    	if(!isEmpty(device)){
    		$.ajax({
    	        type: "POST"
    	        ,url: "/m/biz/dev/syncData"
    	        ,dataType: "json"
    	        ,async: false
    	        ,data : {
    	            devId : "${device.devId}"
    	          , gcmKey : "${device.gcmKey}"
    	          , devVersion : "${device.devVersion}"
    	          , adAltRcvYn : 'Y'
    	        }
    	        ,success : function(data){
    	            //console.log("save");
    	            alert('PUSH 알림 설정이 완료되었습니다.');
    	            location.href = "/m/biz/hot/setting";
    	        } 
    	        ,error: function(data) {
    	            //console.log("fail");
    	        }
    	    });
    	}else{
    		alert('모바일 앱에서만 신청가능합니다.');
    	}
    }
}

/* 28주년 핫트 로또 이벤트_68153 (1회용)*/
function fn_event_68153(eventNum){
	if (!isLogin) {
        needLogin();
    } else {
    	var lottoNo1 = $('#lotto_no1').val();
    	var lottoNo2 = $('#lotto_no2').val();
    	var lottoNo3 = $('#lotto_no3').val();
    	var lottoNo4 = $('#lotto_no4').val();
    	
    	if(isEmpty(lottoNo1) || isEmpty(lottoNo2) || isEmpty(lottoNo3) || isEmpty(lottoNo4)){
    		alert('숫자를 모두 입력하고 도전해주세요!');
    		return false;
    	}
    	if(lottoNo1.length < 2 || lottoNo2.length < 2 || lottoNo3.length < 2 || lottoNo4.length < 2){
    		alert('숫자 입력시 두자리로 입력해주세요! (EX 07,09)');
    		return false;
    	}
    	if(lottoNo1 > 28 || lottoNo2 > 28 || lottoNo3 > 28 || lottoNo4 > 28){
    		alert('28이하 숫자를 입력해주세요!');
    		return false;
    	}
    	
    	$.ajax({
            type: "GET"
            ,url: "/m/fn_event_68153"
            ,data: 'eventNum=' + eventNum +'&lottoNo1=' + lottoNo1 +'&lottoNo2=' + lottoNo2 +'&lottoNo3=' + lottoNo3 +'&lottoNo4=' + lottoNo4  
            ,dataType: "json"
            ,success: function(data) {
                if (data.save) {
                    alert(data.msg);
                } else {
                    alert(data.msg);
                }
                
                $('#lotto_no1').val('');
                $('#lotto_no2').val('');
                $('#lotto_no3').val('');
                $('#lotto_no4').val('');
                
                fn_event_68153_count();
            }
            ,error: function() {
                alert('<fmt:message key="error.common.system"/>');
            }
        });
    }
}

/* 28주년 핫트 로또 이벤트_68153 (1회용) - 당첨자 count*/
function fn_event_68153_count(){
	$.ajax({
		type: "GET"
		,url: "/m/fn_event_68153_count"
		,data: 'eventNum=68153' 
		,dataType: "json"
		,success: function(data) {
			$("#eventCount").text(data.count);
       	}
       	,error: function() {
           alert('<fmt:message key="error.common.system"/>');
       	}
	});
}

//maxlength 체크
function maxLengthCheck(object){
	var eventId = '${detail.eventId}';

	if(eventId == '68153'){
		if (!isLogin) {
	        needLogin();
	    }
	}
	
	if (object.value.length > object.maxLength) {
		object.value = object.value.slice(0, object.maxLength);
	}
}
//68153 이벤트 1회용
function appCheck_68153(){
	if (!isLogin) {
        needLogin();
    } else {
    	var device = '${device.devId}';
    	if(!isEmpty(device)){
    		location.href = "/m/biz/hot/setting";
    	}else{
    		alert('모바일 앱에서만 신청가능합니다.');
    	}	
    }
}

/* 재구매쿠폰 다운로드 */
function couponDown_68703(couponId) {
    if (!isLogin) {
        needLogin();
    } else {
        $.ajax({
            type: "GET"
            ,url: "/m/getCouponDown"
            ,data: 'couponId=' + couponId
            ,dataType: "json"
            ,success: function(data) {
                if (data.save) {
                    alert("쿠폰 발급되었습니다. 쿠폰함을 확인하세요!");
                } else {
                	alert(data.errorMessage);
                }
            }
            ,error: function() {
                alert('<fmt:message key="error.common.system"/>');
            }
        });
    }
}

//69031 이벤트용 1회성 function
function couponDown_event69031(couponId, couponId2, couponId3) {
	if (!isLogin) {
        needLogin();
    } else {
	$.ajax({
        type: "GET"
        ,url: "/m/getCouponDown"
        ,data: 'couponId=' + couponId
        ,dataType: "json"
        ,success: function(data) {
            if (data.save) {
            	$.ajax({
                    type: "GET"
                    ,url: "/m/getCouponDown"
                    ,data: 'couponId=' + couponId2
                    ,dataType: "json"
                    ,success: function(data) {
                        if (data.save) {
                        	if(!isEmpty(couponId3)){
                        		$.ajax({
                                    type: "GET"
                                    ,url: "/m/getCouponDown"
                                    ,data: 'couponId=' + couponId3
                                    ,dataType: "json"
                                    ,success: function(data) {
                                    	if (data.save) {
                                            //alert("쿠폰 발급되었습니다. 쿠폰함을 확인하세요!");
                                        } else {
                                        	alert(data.errorMessage);
                                        }
                                    }
                                    ,error: function() {
                                        alert('<fmt:message key="error.common.system"/>');
                                    }
                                });
                        	}
                        }else{
                        	alert(data.errorMessage);
                        }
                    }
                    ,error: function() {
                        alert('<fmt:message key="error.common.system"/>');
                    }
                });
            	alert("쿠폰 발급되었습니다. 쿠폰함을 확인하세요!");
            }else{
            	alert(data.errorMessage);
            }
        }
        ,error: function() {
            alert('<fmt:message key="error.common.system"/>');
        }
    });
	}
}

/* 22%쿠폰 미션 참여여부 체크 및 쿠폰 다운 */
function fn_event_69031(couponId, couponId2, couponId3){
	if (!isLogin) {
	    needLogin();
	} else {
	    $.ajax({
	        type: "GET"
	        ,url: "/m/fn_event_69031"
	        ,data: 'couponId=' + couponId
	        ,dataType: "json"
	        ,success: function(data) {
	        	if(data.chkEvent == 'YYYYY' || data.chkEvent == 'YYYYN'){
	        		$.ajax({
	        	        type: "GET"
	        	        ,url: "/m/getCouponDown"
	        	        ,data: 'couponId=' + couponId
	        	        ,dataType: "json"
	        	        ,success: function(data) {
	        	            if (data.save) {
	        	            	$.ajax({
	        	                    type: "GET"
	        	                    ,url: "/m/getCouponDown"
	        	                    ,data: 'couponId=' + couponId2
	        	                    ,dataType: "json"
	        	                    ,success: function(data) {
	        	                        if (data.save) {
	        	                        	if(!isEmpty(couponId3)){
	        	                        		$.ajax({
	        	                                    type: "GET"
	        	                                    ,url: "/m/getCouponDown"
	        	                                    ,data: 'couponId=' + couponId3
	        	                                    ,dataType: "json"
	        	                                    ,success: function(data) {
	        	                                    	if (data.save) {
	        	                                            //alert("쿠폰 발급되었습니다. 쿠폰함을 확인하세요!");
	        	                                        } else {
	        	                                        	alert(data.errorMessage);
	        	                                        }
	        	                                    }
	        	                                    ,error: function() {
	        	                                        alert('<fmt:message key="error.common.system"/>');
	        	                                    }
	        	                                });
	        	                        	}
	        	                        }else{
	        	                        	alert(data.errorMessage);
	        	                        }
	        	                    }
	        	                    ,error: function() {
	        	                        alert('<fmt:message key="error.common.system"/>');
	        	                    }
	        	                });
	        	            	$(".stamp-list li").eq(0).addClass("on");
	        	            	$(".stamp-list li").eq(1).addClass("on");
	        	            	$(".stamp-list li").eq(2).addClass("on");
	        	            	$(".stamp-list li").eq(3).addClass("on");
	        	            	$(".stamp-list li").eq(4).addClass("on");
	        	            	alert("쿠폰 발급되었습니다. 쿠폰함을 확인하세요!");
	        	            }else{
	        	            	alert(data.errorMessage);
	        	            }
	        	        }
	        	        ,error: function() {
	        	            alert('<fmt:message key="error.common.system"/>');
	        	        }
	        	    });
	        	}else{
	        		var res1 = (data.chkEvent).substring(0,1);
	        		var res2 = (data.chkEvent).substring(1,2);
	        		var res3 = (data.chkEvent).substring(2,3);
	        		var res4 = (data.chkEvent).substring(3,4);
	        		var res5 = (data.chkEvent).substring(4,5);
	        			if(res1 == 'N'){
	        				res1 = '1,';
	        			}else{
	        				res1 = "";
	        				$(".stamp-list li").eq(0).addClass("on");
	        			}
	        			if(res2 == 'N'){
        					res2 = '2,';
	        			}else{
	        				res2 = "";
	        				$(".stamp-list li").eq(1).addClass("on");
	        			}
	        			if(res3 == 'N'){
        					res3 = '3,';
	        			}else{
	        				res3 = "";
	        				$(".stamp-list li").eq(2).addClass("on");
	        			}
	        			if(res4 == 'N'){
        					res4 = '4,';
	        			}else{
	        				res4 = "";
	        				$(".stamp-list li").eq(3).addClass("on");
	        				//$(".stamp-list li").eq(4).addClass("on");
	        			}
	        			if(res5 == 'N'){
        					//res5 = '5,';
        					res5 = "";
	        				$(".stamp-list li").eq(4).addClass("on");
	        			}else{
	        				res5 = "";
	        				$(".stamp-list li").eq(4).addClass("on");
	        			}
	        		var resStr = res1+res2+res3+res4+res5;
	        		var resMsg = resStr.slice(0,-1);
	        		alert(resMsg+"번 미션을 완료해주세요.");
	        	}
// 	            if (data.save) {
// 	                alert(data.aa);
// 	            } else {
// 	            	alert(data.errorMessage);
// 	            }
	        }
	        ,error: function() {
	            alert('<fmt:message key="error.common.system"/>');
	        }
	    });
	}
}

/* 다시돌아온 핫트 로또 이벤트_70780 (1회용)*/
function fn_event_70780(eventNum){
	if (!isLogin) {
        needLogin();
    } else {
    	var lottoNo1 = $('#lotto_no1').val();
    	var lottoNo2 = $('#lotto_no2').val();
    	var lottoNo3 = $('#lotto_no3').val();
    	var lottoNo4 = $('#lotto_no4').val();
    	
    	if(isEmpty(lottoNo1) || isEmpty(lottoNo2) || isEmpty(lottoNo3) || isEmpty(lottoNo4)){
    		alert('숫자를 모두 입력하고 도전해주세요!');
    		return false;
    	}
    	if(lottoNo1.length < 2 || lottoNo2.length < 2 || lottoNo3.length < 2 || lottoNo4.length < 2){
    		alert('숫자 입력시 두자리로 입력해주세요! (EX 01,09)');
    		return false;
    	}
    	if(lottoNo1 > 22 || lottoNo2 > 22 || lottoNo3 > 22 || lottoNo4 > 22){
    		alert('22이하 숫자를 입력해주세요!');
    		return false;
    	}
    	
    	$.ajax({
            type: "GET"
            ,url: "/m/fn_event_70780"
            ,data: 'eventNum=' + eventNum +'&lottoNo1=' + lottoNo1 +'&lottoNo2=' + lottoNo2 +'&lottoNo3=' + lottoNo3 +'&lottoNo4=' + lottoNo4  
            ,dataType: "json"
            ,success: function(data) {
                if (data.save) {
                    alert(data.msg);
                } else {
                    alert(data.msg);
                }
                
                $('#lotto_no1').val('');
                $('#lotto_no2').val('');
                $('#lotto_no3').val('');
                $('#lotto_no4').val('');
                
                fn_event_70780_count();
            }
            ,error: function() {
                alert('<fmt:message key="error.common.system"/>');
            }
        });
    }
}

/* 다시돌아온 핫트 로또 이벤트_70780 (1회용) - 당첨자 count*/
function fn_event_70780_count(){
	$.ajax({
		type: "GET"
		,url: "/m/fn_event_70780_count"
		,data: 'eventNum=70780' 
		,dataType: "json"
		,success: function(data) {
			$("#eventCount").text(data.count);
       	}
       	,error: function() {
           alert('<fmt:message key="error.common.system"/>');
       	}
	});
}

function ht_eventSns70780(eventNum) {
    if (!isLogin) {
        needLogin();
    } else {
        $.ajax({
            type: "GET"
            ,url: "/m/getEventRequest"
            ,data: 'eventNum='+eventNum
            ,dataType: "json"
            ,success: function(data) {
                if (data.save) {
                	sendKakao('[핫트랙스] '+"${detail.eventTitle}", 'http://m.hottracks.co.kr/e/${detail.eventId}');
                } else {
                	alert(data.msg);
                	//sendKakao('[핫트랙스] '+"${detail.eventTitle}", 'http://m.hottracks.co.kr/e/${detail.eventId}');
                }
            }
            ,error: function() {
                alert('<fmt:message key="error.common.system"/>');
            }
        });
    }
}

//69030 이벤트 1회용
function appCheck_70780(){
	if (!isLogin) {
        needLogin();
    } else {
    	var device = '${device.devId}';
    	if(!isEmpty(device)){
    		location.href = "/m/biz/hot/setting";
    	}else{
    		alert('모바일 앱에서만 신청가능합니다.');
    	}	
    }
}

/* 페이백 이벤트 1회성 09071 */
function eventPayback69071(eventNum) {
	if (!isLogin) {
        needLogin();
    } else {
        $.ajax({
            type: "GET"
            ,url: "/m/getEventRequest"
            ,data: 'eventNum='+eventNum
            ,dataType: "json"
            ,success: function(data) {
                if (data.save) {
                	alert("페이백 신청이 완료되었습니다.");
                } else {
                	alert(data.msg);
                	//sendKakao('[핫트랙스] '+"${detail.eventTitle}", 'http://m.hottracks.co.kr/e/${detail.eventId}');
                }
            }
            ,error: function() {
                alert('<fmt:message key="error.common.system"/>');
            }
        });
    }
}

/* 한글날쿠폰 다운로드 */
function eventRequest_70221(eventNum, requestVal,today70221) {
	var couponId1;
	var couponId2;
	var couponId3;
	var alrMsg;
	
	if(requestVal == 'Y'){
		couponId1 = '8006541765';
		couponId2 = '8006541767';
		couponId3 = '8006541769';
		alrMsg = '정답입니다! 10%쿠폰이 발급되었습니다.';
	}else{
		couponId1 = '8006541771';
		couponId2 = '8006541773';
		couponId3 = '8006541775';
		alrMsg = '오답입니다! 5%쿠폰이 발급되었습니다.';
	}
	
    if (!isLogin) {
        needLogin();
    } else {
        $.ajax({
            type: "GET"
            ,url: "/m/getEventRequest"
            ,data: 'eventNum=' + eventNum
            ,dataType: "json"
            ,success: function(data) {
                if (data.save) {
                	$.ajax({
                        type: "GET"
                        ,url: "/m/fn_get_event70221"
                        ,data: 'requestVal=' + requestVal + '&dup=' + 'Y'
                        ,dataType: "json"
                        ,success: function(data) {
                            if (data.save) {
                            	alert(alrMsg);
                            	if(today70221 == '20201009'){
                            		$('#popupDivp').addClass("p1");
                            	}
                            	else if(today70221 == '20201010'){
                            		$('#popupDivp').addClass("p2");
                            	}
                            	else if(today70221 == '20201011'){
                            		$('#popupDivp').addClass("p3");
                            	}
                            	else if(today70221 == '20201012'){
                            		$('#popupDivp').addClass("p4");
                            	}
                            	else if(today70221 == '20201013'){
                            		$('#popupDivp').addClass("p5");
                            	}
                        		$('#popupDiv').show();
                            }else{
                            	alert(data.errorMessage);
                            }
                        }
                        ,error: function() {
                            alert('<fmt:message key="error.common.system"/>');
                        }
                    });
                } else {
                    alert(data.msg);
                }
            }
            ,error: function() {
                alert('<fmt:message key="error.common.system"/>');
            }
        });
    }
}

//초성퀴즈 이벤트
function eventRequest_70380() {
	var requestVal = document.getElementById("event70380").value;
	
	if(requestVal == '문구는역시핫트랙스'){
		couponId = '8006547724';
		eventNum = '20207038001';
	}else if(requestVal == '생활속감성충전소'){
		couponId = '8006547726';
		eventNum = '20207038002';
	}else if(requestVal == '22일은핫트데이'){
		couponId = '8006547728';
		eventNum = '20207038003';
	}else if(requestVal == '핫트다꾸패키지'){
		couponId = '8006547730';
		eventNum = '20207038004';
	}else if(requestVal == '이럴때'){
		couponId = '8006547732';
		eventNum = '20207038005';
	}else{
		alert("정답이 아닙니다. 다시 도전해주세요!");
		return;
	}
	
    if (!isLogin) {
        needLogin();
    } else {
        $.ajax({
            type: "GET"
            ,url: "/m/getEventRequest"
            ,data: 'eventNum=' + eventNum
            ,dataType: "json"
            ,success: function(data) {
                if (data.save) {
                	
                	$.ajax({
                        type: "GET"
                        ,url: "/m/fn_get_event70380"
                        ,data: 'couponId=' + couponId + '&dup=' + 'Y'
                        ,dataType: "json"
                        ,success: function(data) {
                        	if (data.save) {
                                alert("쿠폰 발급되었습니다. 쿠폰함을 확인하세요!");
                            } else {
                            	alert(data.errorMessage);
                            }
                        }
                        ,error: function() {
                            alert('<fmt:message key="error.common.system"/>');
                        }
                    });
                } else {
                    alert(data.msg);
                }
            }
            ,error: function() {
                alert('<fmt:message key="error.common.system"/>');
            }
        });
    }
}

function ht_eventSns70393(eventNum, popVal) {
    if (!isLogin) {
        needLogin();
    } else {
        $.ajax({
            type: "GET"
            ,url: "/m/getEventRequest"
            ,data: 'eventNum='+eventNum
            ,dataType: "json"
            ,success: function(data) {
                if (data.save) {
                	if(popVal == '1'){
                		$('.kakao-img').attr('src','http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/70393/mobile/m_sns_1.png');
                		sendKakao('[핫트랙스] '+"${detail.eventTitle}", 'http://m.hottracks.co.kr/e/${detail.eventId}');
                	}else if(popVal == '2'){
                		$('.kakao-img').attr('src','http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/70393/mobile/m_sns_2.png');
                		sendKakao('[핫트랙스] '+"${detail.eventTitle}", 'http://m.hottracks.co.kr/e/${detail.eventId}');
                	}else if(popVal == '3'){
                		$('.kakao-img').attr('src','http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/70393/mobile/m_sns_3.png');
                		sendKakao('[핫트랙스] '+"${detail.eventTitle}", 'http://m.hottracks.co.kr/e/${detail.eventId}');
                	}else if(popVal == '4'){
                		$('.kakao-img').attr('src','http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/70393/mobile/m_sns_4.png');
                		sendKakao('[핫트랙스] '+"${detail.eventTitle}", 'http://m.hottracks.co.kr/e/${detail.eventId}');
                	}else if(popVal == '5'){
                		$('.kakao-img').attr('src','http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/70393/mobile/m_sns_5.png');
                		sendKakao('[핫트랙스] '+"${detail.eventTitle}", 'http://m.hottracks.co.kr/e/${detail.eventId}');
                	}
                } else {
                	alert(data.msg);
                	//sendKakao('[핫트랙스] '+"${detail.eventTitle}", 'http://m.hottracks.co.kr/e/${detail.eventId}');
                }
            }
            ,error: function() {
                alert('<fmt:message key="error.common.system"/>');
            }
        });
    }
}

function eventRequest_70779(eventNum) {
    if (!isLogin) {
        needLogin();
    } else {
        $.ajax({
            type: "GET"
            ,url: "/m/getEventRequest"
            ,data: 'eventNum=' + eventNum
            ,dataType: "json"
            ,success: function(data) {
                if (data.save) {
                	if(eventNum == '2020112004'){
                		multiCouponDown('8006578725,8006578727,8006578729');
                	}else if(eventNum == '2020112005'){
                		multiCouponDown('8006578731');
                	}else{
                		multiCouponDown('8006578719,8006578721,8006578723','Y');
                	}
                } else {
                    alert(data.msg);
                }
            }
            ,error: function() {
                alert('<fmt:message key="error.common.system"/>');
            }
        });
    }
}

// 다중쿠폰다운 - 쿠폰아이디 ','를 구분으로 다중입력가능, dup 'Y' 설정시 다중다운로드 가능 (생략가능)
// ex1) multiCouponDown('8006578719,8006578721,8006578723');		
// ex2) multiCouponDown('8006578719,8006578721,8006578723','Y');		
function multiCouponDown(couponIds, dup) {
	if(isEmpty(couponIds)) return false;
	if(isEmpty(dup)) dup = 'N';
	
	var couponList = new Array();
	couponList = couponIds.split(',');
	
	var params = {};
	params["dup"] = dup;
	params["couponList"] = couponList;
	
	$.ajax({
        type: "POST"
        ,contentType: 'application/json'
        ,url: "/m/coupon/multiCouponDown"
        ,data: JSON.stringify(params)
        ,dataType: "json"
        ,success: function(data) {
        	if (data.returnMsg == 'Y') {
        		alert("쿠폰이 발급되었습니다.");
            }else{
            	alert(data.returnMsg);
            }
        }
        ,error: function() {
            alert('<fmt:message key="error.common.system"/>');
        }
    });
}

</script>

<!-- 데이타 스토리  script-->
<script type="text/javascript"> 
_n_p1='${detail.eventTitle}'; // 이벤트 명 
</script> 
<!-- 데이타 스토리  script end-->

<title>${detail.eventTitle} - NEW ME HOTTRACKS</title>
</head>
<!-- content -->
<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${detail.thumUrl}" class="sns_img" style="display:none;"/>
<div id="content">
	<div class="event_view">
		<div class="event_title">
	        <h5>${detail.eventTitle}</h5>
	        <p class="date font_t">
	        <c:choose>
	        <c:when test="${not empty detail.eventRangeInfo}">${detail.eventRangeInfo}</c:when>
	        <c:otherwise><ui:mask pattern="####.##.##">${detail.eventStartDt}</ui:mask> ~ <ui:mask pattern="####.##.##">${detail.eventEndDt}</ui:mask></c:otherwise>
	        </c:choose>
	        </p>
	        <a href="javascript:layerPopup('.popup_sns');" class="share"><span>공유하기</span></a>
	    </div>

		<div class="event_view_cont">
<div>
<!-- class="event_info" -->
    <div class="ly_box_skip">
        <p>종료된 이벤트 입니다.</p>
    </div>
    <div class="event_cont">
        <c:if test="${not empty detail.thumUrl}"><div style="display:none;"><ui:image src="${detail.thumUrl}" clazz="kakao-img"/></div></c:if>
        <c:choose>
            <c:when test="${fn:contains('41488|42167|46371', detail.eventId) || not empty eventRandom}">
<script type="text/javascript" src="/js/jQueryRotate.2.3.js"></script>
<script type="text/javascript" src="/js/jQueryRotateCompressed.2.3.js"></script>
<script type="text/javascript">
    var is_rotating = false;
    var is_rotated = false;

    function call_rotate(img_id, angle, msg) {
        if(is_rotating) return;
        is_rotating = true;

        duration = 3000;  //돌리는 시간 : 1/1000초
        rotateCnt = Math.floor(Math.random()*20) * 360;

        $('#'+img_id).rotate({
            duration: duration,
            animateTo: (rotateCnt + angle),
            callback: function () {
                is_rotating = false;
                //is_rotated = true;  //한번 페이지 로딩시 한번만 돌아가도록하기 위해. 여러번 돌아가게 하려면 돌리는 이미지를 재 계산해야함. 해당 기능 필요하면 구현하는걸로~~
                alert(msg);
                // location.href = "/m/mypage/coupon";
            }
        });
    }
    
    function getRotateNum(eventId) {
        if(eventId == '41488' || eventId == '42167'){
            alert("이 이벤트는 이미 종료되었습니다.");
            return;
        }
        
        if(isLogin){
            /* if(is_rotated) {
                alert('이미 응모하신 이벤트입니다.');
                return;
            } */
            
            if(is_rotating) {
                return;			
            }
            
            // 서버에서 룰렛 값을 가져옴 ( 조작 방지 위함 )
            $.ajax({
                url: "/ht/hot/saveRandomPoint",
                dataType: "json",
                data: { eventId:'${detail.eventId}' },
                success: function(data) {
                    if(data.save){
                        call_rotate('roulette', data.rotateAngle, data.returnMsg);
                    }else{
                        alert(data.returnMsg);
                    }
                },
                error: function(data) {
                    alert('error Process');
                }
            });
        }else{
            needLogin();
        }
    }
    
  //68056 이벤트용 1회성 function
    /* function getRotateNum_event68056() {
        if(isLogin){
            if(is_rotating) {
                return;			
            }
            
            // 서버에서 룰렛 값을 가져옴 ( 조작 방지 위함 )
            $.ajax({
                url: "/ht/hot/saveRandomPoint",
                dataType: "json",
                data: { eventId:'${detail.eventId}' },
                success: function(data) {
                    if(data.save){
                    	if(data.returnMsg.indexOf('1번') > -1){
                    		couponDown_event68056('8004659035', '8004659037');
                    		$('#popupDiv').addClass('p1');
                    		event68056_popup();
                    	}else if(data.returnMsg.indexOf('2번') > -1){
                    		couponDown_event68056('8004659035', '8004659039');
                    		$('#popupDiv').addClass('p2');
                    		event68056_popup();
                    	}else if(data.returnMsg.indexOf('3번') > -1){
                    		couponDown_event68056('8004659035', '8004659043');
                    		$('#popupDiv').addClass('p3');
                    		event68056_popup();
                    	}else if(data.returnMsg.indexOf('4번') > -1){
                    		couponDown_event68056('8004659037', '8004659039');
                    		$('#popupDiv').addClass('p4');
                    		event68056_popup();
                    	}else if(data.returnMsg.indexOf('5번') > -1){
                    		couponDown_event68056('8004659037', '8004659043');
                    		$('#popupDiv').addClass('p5');
                    		event68056_popup();
                    	}else if(data.returnMsg.indexOf('6번') > -1){
                    		couponDown_event68056('8004659039', '8004659043');
                    		$('#popupDiv').addClass('p6');
                    		event68056_popup();
                    	}else if(data.returnMsg.indexOf('7번') > -1){
                    		couponDown_event68056('8004659041', '8004659037');
                    		$('#popupDiv').addClass('p7');
                    		event68056_popup();
                    	}
                    }else{
                        alert(data.returnMsg);
                    }
                },
                error:function(request,status,error){
                    console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
                   }
            });
        }else{
            needLogin();
            
        }
    }
    
  	//68056 이벤트용 1회성 function
    function couponDown_event68056(couponId, couponId2) {
    	$.ajax({
            type: "GET"
            ,url: "/m/getCouponDown"
            ,data: 'couponId=' + couponId
            ,dataType: "json"
            ,success: function(data) {
                if (data.save) {
                	$.ajax({
                        type: "GET"
                        ,url: "/m/getCouponDown"
                        ,data: 'couponId=' + couponId2
                        ,dataType: "json"
                        ,success: function(data) {
                            if (data.save) {
                            }
                        }
                        ,error: function() {
                            alert('<fmt:message key="error.common.system"/>');
                        }
                    });
                }
            }
            ,error: function() {
                alert('<fmt:message key="error.common.system"/>');
            }
        });
    } */
  	
  //68152 이벤트용 1회성 function
    function getRotateNum_event68152() {
        if(isLogin){
            
            // 서버에서 룰렛 값을 가져옴 ( 조작 방지 위함 )
            $.ajax({
                url: "/ht/hot/saveRandomPoint",
                dataType: "json",
                data: { eventId:'${detail.eventId}' },
                success: function(data) {
                    if(data.save){
                    	if(data.returnMsg.indexOf('쿠폰1') > -1){
                    		couponDown_event68152('8004663766', '8004663768', '8004663770');
                    		$('#popupDiv').addClass("p1");
                    		$('#p0').removeClass("on");
                    		$('#p1').addClass("on");
                    	}else if(data.returnMsg.indexOf('쿠폰2') > -1){
                    		couponDown_event68152('8004663772', '8004663774', '8004663776');
                    		$('#popupDiv').addClass("p2");
                    		$('#p0').removeClass("on");
                    		$('#p2').addClass("on");
                    	}else if(data.returnMsg.indexOf('쿠폰3') > -1){
                    		couponDown_event68152('8004663778', '8004663780');
                    		$('#popupDiv').addClass("p3");
                    		$('#p0').removeClass("on");
                    		$('#p3').addClass("on");
                    	}else{
                    		$('#popupDiv').addClass("p4");
                    		$('#p0').removeClass("on");
                    		$('#p4').addClass("on");
                    	}
                    	
                    	setTimeout(function(){
                			event68152_popup();
                        },2000);
                    	
                    }else{
                        alert(data.returnMsg);
                    }
                },
                error:function(request,status,error){
                    console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
                   }
            });
        }else{
            needLogin();
            
        }
    }
    
  	//68152 이벤트용 1회성 function
    function couponDown_event68152(couponId, couponId2, couponId3) {
    	$.ajax({
            type: "GET"
            ,url: "/m/getCouponDown"
            ,data: 'couponId=' + couponId
            ,dataType: "json"
            ,success: function(data) {
                if (data.save) {
                	$.ajax({
                        type: "GET"
                        ,url: "/m/getCouponDown"
                        ,data: 'couponId=' + couponId2
                        ,dataType: "json"
                        ,success: function(data) {
                            if (data.save) {
                            	if(!isEmpty(couponId3)){
                            		$.ajax({
                                        type: "GET"
                                        ,url: "/m/getCouponDown"
                                        ,data: 'couponId=' + couponId3
                                        ,dataType: "json"
                                        ,success: function(data) {
                                            if (data.save) {
                                            }
                                        }
                                        ,error: function() {
                                            alert('<fmt:message key="error.common.system"/>');
                                        }
                                    });
                            	}
                            }
                        }
                        ,error: function() {
                            alert('<fmt:message key="error.common.system"/>');
                        }
                    });
                }
            }
            ,error: function() {
                alert('<fmt:message key="error.common.system"/>');
            }
        });
    }
  	
  //70011 이벤트용 1회성 function
    function getRotateNum_event70011() {
        if(isLogin){
            // 서버에서 룰렛 값을 가져옴 ( 조작 방지 위함 )
            $.ajax({
                url: "/ht/hot/saveRandomPoint",
                dataType: "json",
                data: { eventId:'${detail.eventId}' },
                success: function(data) {
                    if(data.save){
                    	if(data.returnMsg.indexOf('10% 송편쿠폰 1,000원') > -1){
                    		$('#popupDivp').addClass("p1");
                    		$('#popupDiv').show();
                    	}else if(data.returnMsg.indexOf('10% 송편쿠폰 3,000원') > -1){
                    		$('#popupDivp').addClass("p2");
                    		$('#popupDiv').show();
                    	}else if(data.returnMsg.indexOf('10% 송편쿠폰 5,000원') > -1){
                    		$('#popupDivp').addClass("p3");
                    		$('#popupDiv').show();
                    	}else if(data.returnMsg.indexOf('10% 송편쿠폰 10,000원') > -1){
                    		$('#popupDivp').addClass("p4");
                    		$('#popupDiv').show();
                    	}else if(data.returnMsg.indexOf('15% 송편쿠폰 4,500원') > -1){
                    		$('#popupDivp').addClass("p5");
                    		$('#popupDiv').show();
                    	}else if(data.returnMsg.indexOf('15% 송편쿠폰 7,500원') > -1){
                    		$('#popupDivp').addClass("p6");
                    		$('#popupDiv').show();
                    	}else if(data.returnMsg.indexOf('15% 송편쿠폰 15,000원') > -1){
                    		$('#popupDivp').addClass("p7");
                    		$('#popupDiv').show();
                    	}else if(data.returnMsg.indexOf('50% 송편쿠폰 50,000원') > -1){
                    		$('#popupDivp').addClass("p8");
                    		$('#popupDiv').show();
                    	}
                    	return;
                    	
//                     	setTimeout(function(){
//                 			event68152_popup();
//                         },2000);
                    	
                    }else{
                        alert(data.returnMsg);
                        $('#popup_mask').css({
                            'display': 'none'
                        });
                    }
                },
                error:function(request,status,error){
                    console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
                   }
            });
        }else{
            needLogin();
            
        }
    }
</script>
                <c:if test="${not empty eventRandom}">
                    <c:if test="${detail.eventId eq '49299'}">
                        <c:set var="num"><ui:lpad length="7" padChar="0">${eventRandom.totGiftAmt}</ui:lpad></c:set>
                        <style type="text/css">
                        .event_cont .txt_scr { display: block;height:150px;font-size: 0;text-align: center;margin: 0;background:url('${imageServer}/images/event/49299/mob/bg_scr.jpg') #000 center center no-repeat;background-size:auto 135px; }
                        .event_cont .txt_scr img { height:50px;width:auto;display:inline-block;background:none;margin:50px 0; }
                        </style>
                        <div class="txt_scr">
                            <c:set var="isnon" value="true"/>
                            <c:forEach begin="0" end="6" varStatus="st">
                                <c:set var="num_idx">${fn:substring(num, st.index, st.index+1)}</c:set>
                                <c:if test="${isnon && num_idx ne '0'}"><c:set var="isnon" value="false"/></c:if>
                                <c:choose>
                                    <c:when test="${!isnon}">
                                        <c:if test="${st.index eq 1 || st.index eq 4}"><img src="${imageServer}/images/event/49299/mob/ic_num_dot.png"/></c:if>
                                        <img src="${imageServer}/images/event/49299/mob/ic_num_${num_idx}.png" alt="${num_idx}"/>
                                    </c:when>
                                    <c:otherwise><img src="${imageServer}/images/event/49299/mob/ic_num_no.jpg" alt="none"/></c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </div>
                    </c:if>
                    <c:if test="${detail.eventId ne '68152' and detail.eventId ne '70011'}">
	                    <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${eventRandom.imageUrlTop}" usemap="#eventImageTop"/>
	                    <c:if test="${not empty eventRandom.imageMapTop}">
	                        <map name="eventImageTop">
	                            ${eventRandom.imageMapTop}
	                        </map>
	                    </c:if>
	                    <div style="position:relative;display:block;">
	                        <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${eventRandom.imageUrlBg}" style="position:relative;z-index:1;width:100%;" usemap="#eventSns"/>
	                        <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${eventRandom.imageUrlPin}" style="position:absolute;bottom:80%;left:47%;z-index:3;width:6%;background:none;"/>
	                        <a href="#" onClick="getRotateNum('${eventRandom.eventId}');return false;" id="roulette" style="position:absolute;bottom:44%;width:86%;left:7%;display:block;z-index:2;background:none;" >
	                            <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${eventRandom.imageUrlRlt}" style="background:none;"/>
	                        </a>
	                    </div>
                    </c:if>
                    <c:choose>
                        <c:when test="${not empty mobImage}">
                            <div><ui:image src="${mobImage.imageUrl}" id="eventImageUrl" usemap="#eventImageMap" clazz="detail-img"/></div>
                            <c:if test="${mobImage.userTmplUseYn}"><div>${mobImage.userTmpl}</div></c:if>
                        </c:when>
                        <c:otherwise>
                            <c:if test="${not empty detail.imageUrl}"><div><ui:image src="${detail.imageUrl}" id="eventImageUrl" usemap="#eventImageMap" clazz="detail-img"/></div></c:if>
                            <c:if test="${detail.userTmplUseYn eq 'Y'}"><div>${detail.userTmpl}</div></c:if>
                        </c:otherwise>
                    </c:choose>
                </c:if>
            </c:when>
            <c:when test="${not empty mobImage}">
                <div><ui:image src="${mobImage.imageUrl}" id="eventImageUrl" usemap="#eventImageMap" clazz="detail-img"/></div>
                <c:if test="${detail.stampYn}">
                    <!-- 스탬프이벤트 -->
                    <div id="divStamp"></div>
                    <script src="/js/ht.hot.eventDetail.stamp.js" type="text/javascript"></script>
                    <script type="text/javascript">
                        _eventStamp("${detail.eventId}");
                    </script>
                    <!-- #스탬프이벤트 -->
                </c:if>
                <c:if test="${mobImage.userTmplUseYn}"><div>${mobImage.userTmpl}</div></c:if>
            </c:when>
            <c:otherwise>
                <c:if test="${not empty detail.imageUrl}"><div><ui:image src="${detail.imageUrl}" id="eventImageUrl" usemap="#eventImageMap" clazz="detail-img"/></div></c:if>
                <c:if test="${detail.stampYn}">
                    <!-- 스탬프이벤트 -->
                    <div id="divStamp"></div>
                    <script src="/js/ht.hot.eventDetail.stamp.js" type="text/javascript"></script>
                    <script type="text/javascript">
                        _eventStamp("${detail.eventId}");
                    </script>
                    <!-- #스탬프이벤트 -->
                </c:if>
                <c:if test="${detail.userTmplUseYn eq 'Y'}"><div>${detail.userTmpl}</div></c:if>
            </c:otherwise>
        </c:choose>
        <!-- swiper -->
        <c:if test="${not empty detail.userTmplHtml}">
            <div class="event_wrap">
                <!--  header img -->
                <textarea name="userTmplHtml" style="display : none;">${detail.userTmplHtml}</textarea>
                <div id="header_userTemplate"></div>
                <div class="visual swipe-main">
                    <div class="swiper-container"><ul class="swiper-wrapper"></ul></div>
                    <div class="pagination_v2"></div>
                </div>
                <div id="footer_userTemplate" ></div>
            </div>
            <script src="/js/fn_htts_event_template.js?202006231523" type="text/javascript"></script>
            <script src="/js/jquery.rwdImageMaps.min.js?20170612" type="text/javascript"></script>
            <style type="text/css"> img[usemap] {border: none;height: auto;max-width: 100%; width: auto;}</style>
            <script type="text/javascript">
            // 메인배너
            $(document).ready(function(){
                var welcomeSwiper = new Swiper('.swipe-main .swiper-container',{
                    pagination: '.swipe-main div.pagination',
                    loop:true,
                    grabCursor: true,
                    paginationClickable: true,
                    autoplay: 3000,
                    autoplayDisableOnInteraction: false
                });
                $('img[usemap]').rwdImageMaps();
                
            });
            </script>
        </c:if>
    </div>
    
    <c:if test="${detail.eventTypeCode eq 'C0192' || detail.eventTypeCode eq 'C0193' || detail.eventTypeCode eq 'C0197' || detail.eventTypeCode eq 'C019A'}">
    <c:if test="${not empty listType}">
    <div class="btn_area box_flex mt10">
        <a href="#" onclick="_moveToComment();return false;" class="btn btn_orange">코멘트 보러가기</a>
    </div>
    </c:if>
    </c:if>
    <c:forEach items="${listType}" var="lp" varStatus="st">
        <div id="event-link${lp.eventTypeInseq}" class="category_wrap">
        <c:if test="${lp.titleUseYn eq 'Y'}">
            <div class="box_flex t_select" id="eventTypeInseq${lp.eventTypeInseq}">
                <select class="select" title="정렬 순서 선택" class="eventTypeInseq" onchange="moveToLayer('${lp.eventTypeInseq}', this.value)">
                    <c:forEach items="${listType}" var="ls">
                        <c:if test="${ls.titleUseYn eq 'Y'}">
                            <option value="${ls.eventTypeInseq}"<c:if test="${lp.eventTypeInseq eq ls.eventTypeInseq}"> selected="selected"</c:if>>${ls.eventTitle}</option>
                        </c:if>
                    </c:forEach>
                </select>
            </div>
        </c:if>
        <!-- prod -->
        <div id="eventPrdt${lp.eventTypeInseq}" class="event_prod_${lp.eventPrdtTypeCode}">
        	<c:import url="/m/biz/hot/event/prdtList?eventTypeInseq=${lp.eventTypeInseq}&eventPrdtTypeCode=${lp.eventPrdtTypeCode}"/>
       	</div>
        <!-- //prod -->
        </div>
    </c:forEach>
</div>			
			<!-- COMMENT 영역 -->
			<c:if test="${(detail.eventTypeCode eq 'C0192' || detail.eventTypeCode eq 'C0193' || detail.eventTypeCode eq 'C0197' || detail.eventTypeCode eq 'C019A') && detail.eventId ne '57658'}">
			    <div id="commentArea">
			        <hr class="hr_01"/>
			        <div class="commnt_write">
			            <strong class="amount">총 <span class="col_orange"><fmt:formatNumber type="number" value="${cmntCnt}"/>개</span>의 댓글이 있습니다.</strong>
			            <form name="eventCommentForm" method="post" onsubmit="return false">
			                <input type="hidden" value="${c.eventId}" name="eventId"/>
			                <div class="textarea_box">
			                    <c:choose>
			                        <c:when test="${not empty listChoice}">
			                            <select class="select" name="emtcId" title="이모티콘 선택">
			                                <c:forEach items="${listChoice}" var="l" varStatus="st">
			                                    <option value="${l.bnrSeq}">${l.bnrTitle}</option>
			                                </c:forEach>
			                            </select>
			                        </c:when>
			                        <c:otherwise><input type="hidden" name="emtcId"/></c:otherwise>
			                    </c:choose>
			                    <textarea class="textarea" name="cmnt" title="댓글 입력" style="height:100px;" onclick="preValidation()" placeHolder="내용을 입력하세요."></textarea>
			                </div>
			                <p class="info mt5">
			                    ※ 로그인 후 글을 남길 수 있습니다.
			                    <a href="javascript:save()" class="btn btn_type01 bg_orange fl_r">등록</a>
			                </p>
			            </form>
			        </div>
			        <ul id="commentList" class="commnt_list"></ul>
			        <div id="commentPage" class="paging mb30"></div>
			    </div>
			</c:if>
			<c:if test="${detail.eventId eq '58998' || detail.eventId eq '61406' || detail.eventId eq '63447'}">
			<div id="commentArea">
			    <hr class="hr_01"/>
			    <div class="commnt_write">
			        <form name="eventCommentForm" method="post" onsubmit="return false">
			            <table class="table02">
			            <caption>개인정보입력 <span>이름, 아이디, 핸드폰, 이메일</span></caption>
			            <colgroup>
			                <col width="*" />
			            </colgroup>
			            <tbody>
			                <tr>
			                    <th scope="row"><label for="name">영수증번호<br/>※ 영수증 제일 하단의 바코드 밑 숫자 20자리를 입력해주세요.</label>
			                   </th>
			                </tr>
			                <tr>
			                <td><input name="userDtl" value="" type="text" class="i_input" id="userDtl"/></td>
			                </tr>
			                <tr>
			                    <th scope="row"><label for="name">이 름</label></th>
			                </tr>
			                <tr>
			                    <td><input name="userName" value="" type="text" class="i_input"/></td>
			                </tr>
			                <tr>
			                    <th scope="row">핸드폰 번호</th>
			                </tr>
			                <tr>
			                    <td>
			                        <input name="handPhoneNum1" value="" type="text" class="i_input handPhoneNum" maxlength="3" title="핸드폰 앞자리 입력"/> -
			                        <input name="handPhoneNum2" value="" type="text" class="i_input handPhoneNum" maxlength="4" title="핸드폰 중간자리 입력"/> -
			                        <input name="handPhoneNum3" value="" type="text" class="i_input handPhoneNum" maxlength="4" title="핸드폰 마지막자리 입력"/>
			                    </td>
			                </tr>
			                <tr>
			                    <th scope="row"><label for="name">주소</label></th>
			                </tr>
			                <tr>
			                    <td><textarea name="userAddr" id="userAddr" cols="50" rows="50" placeholder ="주소지 정보를 입력해주세요."></textarea></td>
			                </tr>
			            </tbody>
			        </table>
			            <p class="info mt5">
			                <a href="javascript:saveOff()" class="btn btn_type01 bg_orange fl_r">등록</a>
			            </p>
			        </form>
			    </div>
			</div>
			</c:if>
			<c:if test="${detail.eventTypeCode eq 'C0192' || detail.eventTypeCode eq 'C0193' || detail.eventTypeCode eq 'C0197' || detail.eventTypeCode eq 'C019A'}">
				<script type="text/javascript">
				var comments = null;
				var pageholder = null;
				
				function save(){
				    if (preValidation()) {
				        $('form[name="eventCommentForm"]').ajaxSubmit({
				            url: '/m/hot/saveEventComment'
				            ,dataType: 'json'
				            ,success: function(data) {
				                if (data.save) {
				                    alert('<fmt:message key="message.save.success"/>');
				                    $("form[name=eventCommentForm]").find("[name=cmnt]").val("");
				                    _loadComments(1, true);
				                } else {
				                    alert(data.errorMessages);
				                }
				            }
				            ,error: function(data) {
				                alert('<fmt:message key="error.common.system"/>');
				            }
				        });
				    }
				    return false;
				}
				
				
				function _moveToComment(){
				    $("html,body").animate({scrollTop: $("#commentArea").offset().top - $("#header").height()}, 500);
				}
				
				function _deleteComment(eventCmntSeq) {
				    if (preValidation()) {
				        if (confirm('삭제하시겠습니까?')) {
				            $.ajax({
				                type: 'GET'
				                ,url: '/m/hot/deleteEventComment'
				                ,data: {eventId:"${detail.eventId}",eventCmntSeq:eventCmntSeq}
				                ,dataType: 'json'
				                ,success: function(data) {
				                    if (data.save) {
				                        alert('<fmt:message key="message.delete.success"/>');
				                        _loadComments(1, true);
				                    } else {
				                        alert(data.errorMessages);
				                    }
				                }
				                ,error: function(data) {
				                    alert('<fmt:message key="error.common.system"/>');
				                }
				            });
				        }
				    }
				}
				
				function _loadComments(page, initYn){
				    if(!initYn)    _moveToComment();
				    $.ajax({
				        type: 'GET'
				        ,url: '/m/hot/event/comments'
				        ,data: {eventId:"${detail.eventId}", page:page}
				        ,dataType: 'json'
				        ,success: function(data) {
				            comments = data.list;
				            pageholder = data.pageHolder;
				            
				            _printComments();
				        }
				        ,error: function(data) {
				            alert('<fmt:message key="error.common.system"/>');
				        }
				    });
				}
				
				function _clearComments(){
				    var ul = document.getElementById("commentList");
				    while (ul.firstChild){
				        ul.removeChild(ul.firstChild);
				    }
				}
				
				function _printComments(){
				    var ul = document.getElementById("commentList");
				    
				    _clearComments();
				    
				    if(comments != null && comments.length > 0){
				        for(var i = 0; i < comments.length ; i++){
				            var li = document.createElement("li");
				            
				            // 번호
				            var span = document.createElement("span");
				            var spanTxt = document.createTextNode(comments[i].num);
				            span.setAttribute("class", "num");
				            span.appendChild(spanTxt);
				            li.appendChild(span);
				            
				            // 이모티콘
				            if(comments[i].emtcUrl != null && comments[i].emtcUrl != ""){
				                var emtc = document.createElement("p");
				                var emtcImg = document.createElement("img");
				                emtcImg.setAttribute("src", "http://image.kyobobook.co.kr/newimages/giftshop_new/work/"+comments[i].emtcUrl);
				                emtc.appendChild(emtcImg);
				                li.appendChild(emtc);
				            }
				            
				            // 내용
				            var p = document.createElement("p");
				            var pTxt = document.createTextNode(comments[i].cmnt);
				            p.appendChild(pTxt);
				            li.appendChild(p);
				            
				            // 작성자
				            var info = document.createElement("div");
				            info.setAttribute("class", "info");
				            
				            var userId = document.createElement("span");
				            userId.setAttribute("class", "writer");
				            var userIdTxt = document.createTextNode(comments[i].userId);
				            userId.appendChild(userIdTxt);
				            
				            var date = document.createElement("span");
				            date.setAttribute("class", "date");
				            var dateTxt = document.createTextNode(_formatDate(comments[i].regstDtm, 'yyyy.MM.dd'));
				            date.appendChild(dateTxt);
				            
				            info.appendChild(userId);
				            info.appendChild(document.createTextNode(" | "));
				            info.appendChild(date);
				            li.appendChild(info);
				            
				            // 삭제버튼
				            var btnDel = document.createElement("span");
				            btnDel.setAttribute("class", "btn_del");
				            if(comments[i].userNum == "${loginUser.userNum}"){
				                btnDelAnchor = document.createElement("a");
				                btnDelAnchor.setAttribute("href", "javascript:_deleteComment('" + comments[i].eventCmntSeq + "');");
				                btnDelAnchor.appendChild(document.createTextNode("삭제"));
				                btnDel.appendChild(btnDelAnchor);
				            }
				            li.appendChild(btnDel);
				            
				            ul.appendChild(li);
				        }
				    }
				    
				    _printCommentsPage("commentPage", pageholder, "_loadComments");
				}
				
				$(document).ready(function(){
				    if(${detail.eventId} != '57984'){
				        _loadComments(1, true);    
				    }
				    
				});
				</script>
				<!-- //COMMENT 영역 -->
			
				<c:if test="${not empty detail.userTmplHtml}">
				    <div id="userTmplMap"></div>
				</c:if>
			
			</c:if>
		</div>
	</div>
</div>
<!--// content -->
<!-- 신규 레이어팝업 : start --> 
<div class="layer_popup popup_sns">
    <div class="inner_layer">
        <div class="sns_content">
            <ul>
                <li><a href="javascript:goTwitter('${detail.eventTitle}', 'http://m.hottracks.co.kr/e/${detail.eventId}')" class="ic_twitter sns01"></a></li>
                <li><a href="javascript:goFaceBook('${detail.eventTitle}', 'http://m.hottracks.co.kr/e/${detail.eventId}')" class="ic_facebook sns02"></a></li>
                <li><a href="javascript:sendKakao('[핫트랙스] ${detail.eventTitle}', 'http://m.hottracks.co.kr/e/${detail.eventId}')" class="ic_kakaotalk sns03"></a></li>
            </ul>
        </div>
    </div>
	<a href="#none" class="layer_close"><span>취소</span></a>
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
<!-- 신규 레이어팝업 : end -->
