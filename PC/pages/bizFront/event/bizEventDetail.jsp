<%@page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<!-- 태그 라이브러리 -->
<%@ include file="/pages/decorators/biz/tagHeader.jsp" %>
<ui:decorator name="bizHt"/>
<html>
<head>
<title>${detail.eventTitle} - NEW ME HOTTRACKS</title>
<meta property="fb:app_id" content="981386905311018" />
<!--  SNS 공유 내용 -->
<meta property="og:type" content="website"/>
<meta property="og:title" content="${fn:escapeXml(detail.eventTitle)}"/>
<meta property="og:url" content="${defaultHost}/ht/biz/eventDetail?eventId=${detail.eventId}"/>
<c:choose>
    <c:when test="${not empty detail.eventRangeInfo}"><meta property="og:description" content="${detail.eventRangeInfo}"/></c:when>
    <c:otherwise><meta property="og:description" content="<ui:mask pattern="####.##.##">${detail.eventStartDt}</ui:mask> ~ <ui:mask pattern="####.##.##">${detail.eventEndDt}</ui:mask>"/></c:otherwise>
</c:choose>
<meta property="og:image" content="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${detail.thumUrl}" />
<link rel="image_src" href="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${detail.thumUrl}" />

<!-- 데이타 스토리  script-->
<script type="text/javascript"> 
_n_p1='${detail.eventTitle}'; // 이벤트 명 
</script> 
<!-- 데이타 스토리  script end-->

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

<script type="text/javascript" src="/js/jquery.form.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		setTimeout(function(){
			$(".event_top").attr("style","visibility: visible;");
    		$(".event_title").attr("style","visibility: visible;");
    		$(".event_view_cont").attr("style","visibility: visible;");
        },100);
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

		if ("66764"=="${detail.eventId}") {
			if(today.indexOf("20200327") != -1 && eval(today) >= '2020032714'){
				$('#hourImg').attr("src", "http://image.kyobobook.co.kr/newimages/giftshop_new/work/1575/hot_time1.png");
			}else if(today.indexOf("20200326") != -1 && eval(today) >= '2020032614'){
				$('#hourImg').attr("src", "http://image.kyobobook.co.kr/newimages/giftshop_new/work/1575/hot_time4.png");
			}else if(today.indexOf("20200325") != -1 && eval(today) >= '2020032514'){
				$('#hourImg').attr("src", "http://image.kyobobook.co.kr/newimages/giftshop_new/work/1575/hot_time2.png");
			}else if(today.indexOf("20200324") != -1 && eval(today) >= '2020032414'){
				$('#hourImg').attr("src", "http://image.kyobobook.co.kr/newimages/giftshop_new/work/1575/hot_time4.png");
			}else if(today.indexOf("20200323") != -1 && eval(today) >= '2020032314'){
				$('#hourImg').attr("src", "http://image.kyobobook.co.kr/newimages/giftshop_new/work/1575/hot_time1.png");
			}else if(today.indexOf("20200320") != -1 && eval(today) >= '2020032014'){
				$('#hourImg').attr("src", "http://image.kyobobook.co.kr/newimages/giftshop_new/work/1575/hot_time3.png");
			}else if(today.indexOf("20200319") != -1 && eval(today) >= '2020031914'){
				$('#hourImg').attr("src", "http://image.kyobobook.co.kr/newimages/giftshop_new/work/1575/hot_time2.png");
			}else if(today.indexOf("20200318") != -1 && eval(today) >= '2020031814'){
				$('#hourImg').attr("src", "http://image.kyobobook.co.kr/newimages/giftshop_new/work/1575/hot_time3.png");
			}else if(today.indexOf("20200317") != -1 && eval(today) >= '2020031714'){
				$('#hourImg').attr("src", "http://image.kyobobook.co.kr/newimages/giftshop_new/work/1575/hot_time2.png");
			}else if(today.indexOf("20200316") != -1 && eval(today) >= '2020031614'){
				$('#hourImg').attr("src", "http://image.kyobobook.co.kr/newimages/giftshop_new/work/1575/hot_time1.png");
			}
		};
		
		var today70221 = yy+''+mm+''+dd;
		//alert(today70221);
		if ("70221"=="${detail.eventId}") {
			//today = yy+''+mm+''+dd;
			switch (today70221){
			    case '20201009' :
			    	$('.event_view_cont > div > div > img').attr('src','http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/2020_quiz/70221_01_pc.png');
			        break;
			    case '20201010' :
			    	$('.event_view_cont > div > div > img').attr('src','http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/2020_quiz/70221_02_pc.png');
			        break;
			    case '20201011' :
			    	$('.event_view_cont > div > div > img').attr('src','http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/2020_quiz/70221_03_pc.png');
			        break;
			    case '20201012' :
			    	$('.event_view_cont > div > div > img').attr('src','http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/2020_quiz/70221_04_pc.png');
			        break;
			    case '20201013' :
			    	$('.event_view_cont > div > div > img').attr('src','http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/2020_quiz/70221_05_pc.png');
			        break;
// 	 		    default :
// 	 		    	$('.event_view_cont > div > div > img').attr('src','http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/2020_quiz/70221_01_pc.png');
			}
			
			
		};

		if ("70780"=="${detail.eventId}") {
			fn_event_70780_count();
		};
		
		$('#content').addClass('new_event_view');
		gnb();//gnb
		nav();//nav
		eventFn();//event
		if($('.header_wrap').length >0){
			bodyScroll();//body scroll
		}
        if('${skip}' == 'skipEvent'){
            $(".ly_box_skip").addClass("active");
            $("div.comment_box textarea[name=eventComment]").attr("disabled","disabled");
        }
		getCategory($('.c_select .location_1').attr('value'));
	});
	
	
	var categorySwiper03 = null;

	function replaceBtn(bcode){
		$fn.setRecobellRelationList(bcode);
		$('.dim, .replace-modal').css('visibility','visible');
// 		$('html,body').addClass('noscroll');
	}
	$(function(){
	    $('.replace-modal .close-btn').click(function(){
	        $fn.init();
	    	$('.dim, .replace-modal').css('visibility','hidden');
// 	        $('html,body').removeClass('noscroll');
	    });
	    
	});

	$fn = {
			init:function(){
				$('#recobellRelationList').empty();
				
			}
			

			, setRecobellRelationList:function(bcode) {
				
				$.ajax({
					url: "/ht/biz/personal/getRecobellRelationList"
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
										append += '	<li>';
										append += '	<a href="/p/'+list[i].sellPrdtBcode+'?foo=bar&rccode=pc_soldout">';
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
			        ,complete : function() {
			        	
			        	if(categorySwiper03 != null) {
			                //맨 앞으로 스와이퍼 이등
			                categorySwiper03.goToSlide(1);
			                //스와이퍼 삭제 
			        		categorySwiper03.destroySlider();
						}
			        	categorySwiper03 = $('.replace-modal .pd_list ul').bxSlider({
			        		touchEnabled: false,
			        		speed: 1000,
			        		minSlides: 4,
			        		maxSlides: 4,
			        		moveSlides: 4,
			        		slideWidth: 205,
			        		pager: true,
			        		pagerType: 'short',
			        		pagerShortSeparator: ''
			        	});
			        }
			    });
			}
	};
	
	
	function getCategory(ctgrId){
		$('.c_select .location_1').text($('li[ctgrId='+ctgrId+'] a').text()==''?'전체':$('li[ctgrId='+ctgrId+'] a').text());
		$.ajax({
		    type: "GET"
		   ,url: "/ht/biz/eventCategory"
		   ,data:{"ctgrId":ctgrId} 
		   ,dataType: "json"
		   ,success : function(data){
			   if (!isEmpty(data)) {
				   $(".e_select").attr("style","display: block;");
				   var htmlStr = "";
				   var list = data.listEvent;
				   var chkempty = false;
				   for(var i=0; i<list.length; i++){
					   if ("${detail.eventId}"==list[i].eventId) {
						   htmlStr += "<a href='javascript://' class='location_1'>"+list[i].eventTitle+"</a>";
						   chkempty = true
						};
					   if(i+1 == list.length && !chkempty){
						   htmlStr += "<a href='javascript://' class='location_1'>"+list[0].eventTitle+"</a>";
					   };
				   };
					htmlStr += "<ul class='location_nav'>";
				   for(var i=0; i<list.length; i++){
					   var select= "${detail.eventId}"==list[i].eventId?"class='active'":"";
						htmlStr += "<li><a href='javascript://' "+select+" onclick='location.href=\"/ht/biz/eventDetail?eventId="+list[i].eventId+"\";'>"+list[i].eventTitle+"</a></li>"
				   };
					htmlStr += "</ul>";
					$(".e_select").empty();
					$(".e_select").append(htmlStr);
					nav();
					if (list.length >= 30) {
						$(".e_select .location_nav").attr("style","max-height:500px; overflow:auto;");
					};
					if(list.length==0){
						$(".e_select").attr("style","display: none;");
					};
				};
			}
		   ,error: function(data) {
		       alert('<fmt:message key="error.common.system"/>');
		   }
		});
	}
	function sandEventDetail(eventId){
		if( eventId!="${detail.eventId}" && eventId!="main" && eventId!="" ){location.href="/ht/biz/eventDetail?eventId="+eventId;
		} else if( eventId == "main" ) {location.href="/ht/biz/hotEventMain";
		} else {};
	}

	function preValidation() {
		var entryTermYn = '${entryTermYn}';
		console.log(entryTermYn);
	    if (!isLogin) {
	        needLogin();
	        return false;
	    } else if (!entryTermYn) {
	        alert("해당기간이 아닙니다.");
	        $("div.comment_box textarea[name=eventComment]").attr("disabled","disabled");
	        $("div.comment_box textarea[name=eventComment]").val();
	        return false;
	    }

	    return true;
	}

	function save(){
	    if (preValidation()) {
	        $('form[name="eventCommentForm"]').ajaxSubmit({
	            url: '/ht/hot/saveEventComment'
	            ,dataType: 'json'
	            ,success: function(data) {
	                if (data.save) {
	                    alert('<fmt:message key="message.save.success"/>'); 
	                    $('div#commentArea').load('/ht/hot/comment/${detail.eventTypeCode}?eventId=${detail.eventId}');
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

	/* 참여이벤트 */
	function entryEvent(){
	    if (preValidation()) {
	        $.ajax({
	            type: "GET"
	            ,url: "/ht/hot/entryEvent"
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
	            ,url: "/ht/hot/entryEventAmt"
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



	function deleteComment(sequence) {
	    if (preValidation()) {
	        if (confirm('삭제하시겠습니까?')) {
	            $.ajax({
	                type: 'GET'
	                ,url: '/ht/hot/deleteEventComment'
	                ,data: 'eventId=${detail.eventId}&sequence=' + sequence
	                ,dataType: 'json'
	                ,success: function(data) {
	                    if (data.save) {
	                        alert('<fmt:message key="message.delete.success"/>');
	                        $('div#commentArea').load('/ht/hot/comment/${detail.eventTypeCode}?eventId=${detail.eventId}&temp='+ Math.random());
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

	function couponDown(couponId) {
	    if (!isLogin) {
	        needLogin();
	    } else {
	        $.ajax({
	            type: "GET"
	            ,url: "/ht/getCouponDown"
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
	    }
	}

	function goCommentList(page) {
	    $('div#commentArea').load('/ht/hot/comment/${detail.eventTypeCode}?eventId=${detail.eventId}&page=' + page);
	}

	function goEventList(page) {
	    if(page == null || page == undefined)    page = 1;
	    location.href="/ht/biz/eventDetail?eventId=${detail.eventId}&page=" +page + "#bucketEventList";
	}

	function checkEmtcId(obj, imgSrc){
	    $(".comment_emtc a.on").removeClass("on");
	    obj.setAttribute("class", "on");
	    $("input[name=emtcId]").val(imgSrc);
	}

	function toggleChildComment(seq){
	    if($("#btnChildCmnt"+seq).hasClass("active")){
	        $('#childComment'+seq).empty();
	        $("#btnChildCmnt"+seq).removeClass("active");
	    }else{
	        loadChildComment('1', '&eventId=${detail.eventId}&parntCmntSeq='+seq);
	        $("#btnChildCmnt"+seq).addClass("active");
	    }
	}

	function loadChildComment(page, param){
	    params = param.split("&");
	    var seq = '';
	    for(var i = 0; i<params.length; i++){
	        if(params[i].indexOf("parntCmntSeq=") == 0){
	            seq = params[i].replace("parntCmntSeq=", "");
	        }
	    }
	    $('#childComment'+seq).load('/ht/hot/comment/child/${detail.eventTypeCode}?page=' + page + param, function (){
	        $("html,body").scrollTop($('#childComment'+seq).offset().top-100);
	    });
	}

	function saveChild(parntSeq){
	    if (preValidation()) {
	        $('form[name=eventCommentForm'+parntSeq+']').ajaxSubmit({
	            url: '/ht/hot/saveEventComment'
	            ,dataType: 'json'
	            ,success: function(data) {
	                if (data.save) {
	                    alert('<fmt:message key="message.save.success"/>');
	                    $('div#commentArea').load('/ht/hot/comment/${detail.eventTypeCode}?eventId=${detail.eventId}&orderBy='+orderBy+'&page=' + $("input[name=cmntPage]").val()
	                    , function(){
	                        loadChildComment('1', '&eventId=${detail.eventId}&parntCmntSeq='+parntSeq);
	                    })
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

	function deleteChildComment(seq, parntSeq) {
	    if (preValidation()) {
	        if (confirm('삭제하시겠습니까?')) {
	            $.ajax({
	                type: 'GET'
	                ,url: '/ht/hot/deleteEventComment'
	                ,data: 'eventId=${detail.eventId}&sequence=' + seq
	                ,dataType: 'json'
	                ,success: function(data) {
	                    if (data.save) {
	                        alert('<fmt:message key="message.delete.success"/>');
	                        $('div#commentArea').load('/ht/hot/comment/${detail.eventTypeCode}?eventId=${detail.eventId}&orderBy='+orderBy+'&page=' + $("input[name=cmntPage]").val()
	                        , function(){
	                            loadChildComment('1', '&eventId=${detail.eventId}&parntCmntSeq='+parntSeq);
	                        })
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

	function likeComment(seq) {
	    if (preValidation()) {
	        $.ajax({
	            type: 'GET'
	            ,url: '/ht/hot/likeEventComment'
	            ,data: 'eventId=${detail.eventId}&sequence=' + seq
	            ,dataType: 'json'
	            ,success: function(data) {
	                if (data.save) {
	                    alert('쪼아쪼아~♥');
	                    goCommentList('1');
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

	function init() {
	    $.ajax({
	        type: "GET"
	        ,url: "/ht/getSaleUserCount"
	        ,dataType: "json"
	        ,success: function(data) {
	            $("#num1").attr("src","http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/music/" + data.cnt.cpnName + ".png");
	            $("#num2").attr("src","http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/music/" + data.cnt.usest + ".png");
	            $("#num3").attr("src","http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/music/" + data.cnt.useet + ".png");
	        }
	        ,error: function() {
	        }
	    });
	}

	function goEvent(){
	    location.href = $(".e_select .e_txt a").attr("href");
	}

	function changeOrder(type){
	    orderBy = type;
	    goCommentList("1");
	}

	function pageC019C(target, navi){
	    $("#"+target).find(".prod_page.active").removeClass("active");
	    $("#"+target+"_"+navi).addClass("active");
	    $("#"+target).find(".prod_page_navi a.active").removeClass("active");
	    $("#"+target+"_"+navi+"_page").addClass("active");
	}
	function addBannerClickInfo() {
	    if (!isLogin) {
	        needLogin();
	    }else{
	        $.ajax({
	            type: "GET"
	            ,url: "/ht/getBannerClick"
	            ,data: {'bannerGubun' : 'E${detail.eventId}', 'userNum' : '${loginUser.num}', 'clickDt':'TODAY'}
	            ,dataType: "json"
	            ,success: function (data) {
	                if(data.list.length > 0){
	                    alert("이미 출석체크하셨습니다.");
	                }else{
	                    $.ajax({
	                        type: "GET"
	                        ,url: "/ht/bannerClick"
	                        ,data: {'bannerGubun' : 'E${detail.eventId}', 'userNum' : '${loginUser.num}'}
	                        ,dataType: "json"
	                        ,success: function (data) {
	                            alert("짝!짝!짝! 출석체크되었습니다.");
	                            loadBannerClickInfo();
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
	}

	function loadBannerClickInfo() {
	    if (isLogin) {
	        $.ajax({
	            type: "GET"
	            ,url: "/ht/getBannerClick"
	            ,data: {'bannerGubun' : 'E${detail.eventId}', 'userNum' : '${loginUser.num}'}
	            ,dataType: "json"
	            ,success: function (data) {
	                for(var i = 0; i<data.list.length; i++){
	                    var id = data.list[i].clickDt;
	                    $("#dt"+id).show();
	                }
	            }
	            ,error: function() {
	                alert('<fmt:message key="error.common.system"/>');
	            }
	        });
	    }
	}

	function _applyEvent(){
	    if (!isLogin) {
	        needLogin();
	    } else {
	        $.ajax({
	            type: 'POST'
	            ,url: '/ht/hot/saveCheckEvent'
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

	/* 참여이벤트 */
	function entryEventEmtc(emtcId){
	    if (preValidation()) {
	        $.ajax({
	            type: "GET"
	            ,url: "/ht/hot/entryEventEmtc"
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
	            url: '/ht/hot/entryEventOff'
	            ,dataType: 'json'
	            ,data :{
	                eventId : '${detail.eventId}',
	                userTelNum : userTelNum
	            }
	            ,success: function(data) {
	                if (data.result.save) {
	                    alert(data.result.resultMsg);
	                    location.href="/ht/welcomeMain";
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
	
	function eventRequest(eventNum) {
	    if (!isLogin) {
	        needLogin();
	    } else {
	        $.ajax({
	            type: "GET"
	            ,url: "/ht/getEventRequest"
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
	            ,url: "/ht/getEventRequest"
	            ,data: 'eventNum=' + eventNum
	            ,dataType: "json"
	            ,success: function(data) {
	                if (data.save) {
	                	$.ajax({
	        	            type: "GET"
	        	            ,url: "/ht/getCouponDown"
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

	function ht_shareEvent(){
		alert('모바일 앱에서만 가능합니다.');
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
	            ,url: "/ht/fn_event_68153"
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
	            }
	            ,error: function() {
	                alert('<fmt:message key="error.common.system"/>');
	            }
	        });
	    }
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
	
	/* 28주년 핫트 로또 이벤트_68153 (1회용) - 당첨자 count*/
	function fn_event_68153_count(){
		$.ajax({
			url: "/ht/fn_event_68153_count"
			, data: {
				eventId : 68153
			}
			, type:"POST"
	        ,dataType: "json"
	        ,success : function(data){
	        	$("#eventCount").text(data.count);
	        }
	        ,error: function(request, status, error) {
	        	alert('<fmt:message key="error.common.system"/>');
	        }
	    });
	}
	
	/* 재구매쿠폰 다운로드 */
	function couponDown_68703(couponId) {
	    if (!isLogin) {
	        needLogin();
	    } else {
	        $.ajax({
	            type: "GET"
	            ,url: "/ht/getCouponDown"
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
	
	/* 22% 다운로드 */
	function couponDown_69031(couponId) {
	    if (!isLogin) {
	        needLogin();
	    } else {
	        $.ajax({
	            type: "GET"
	            ,url: "/ht/getCouponDown"
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
	
	/* 다시돌아온 핫트 로또 이벤트_69030 (1회용)*/
	function fn_event_69030(eventNum){
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
	    	if(lottoNo1 > 12 || lottoNo2 > 12 || lottoNo3 > 12 || lottoNo4 > 12){
	    		alert('12이하 숫자를 입력해주세요!');
	    		return false;
	    	}
	    	
	    	$.ajax({
	            type: "GET"
	            ,url: "/ht/fn_event_69030"
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
	                
	                fn_event_69030_count();
	            }
	            ,error: function() {
	                alert('<fmt:message key="error.common.system"/>');
	            }
	        });
	    }
	}
	
	/* 다시돌아온 핫트 로또 이벤트_69030 (1회용) - 당첨자 count*/
	function fn_event_69030_count(){
		$.ajax({
			url: "/ht/fn_event_69030_count"
			, data: {
				eventId : 69030
			}
			, type:"POST"
	        ,dataType: "json"
	        ,success : function(data){
	        	$("#eventCount").text(data.count);
	        }
	        ,error: function(request, status, error) {
	        	alert('<fmt:message key="error.common.system"/>');
	        }
	    });
	}
	
	/* 페이백5000원 1회성 */
	function eventPayback69071(eventNum) {
	    if (!isLogin) {
	        needLogin();
	    } else {
	        $.ajax({
	            type: "GET"
	            ,url: "/ht/getEventRequest"
	            ,data: 'eventNum=' + eventNum
	            ,dataType: "json"
	            ,success: function(data) {
	                if (data.save) {
	                    alert('페이백 신청이 완료되었습니다.');
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
	            ,url: "/ht/fn_event_70780"
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
			url: "/ht/fn_event_70780_count"
			, data: {
				eventId : 70780
			}
			, type:"POST"
	        ,dataType: "json"
	        ,success : function(data){
	        	$("#eventCount").text(data.count);
	        }
	        ,error: function(request, status, error) {
	        	alert('<fmt:message key="error.common.system"/>');
	        }
	    });
	}

	function eventRequest_70779(eventNum) {
	    if (!isLogin) {
	        needLogin();
	    } else {
	        $.ajax({
	            type: "GET"
	            ,url: "/ht/getEventRequest"
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
            ,url: "/ht/coupon/multiCouponDown"
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
	            ,url: "/ht/getEventRequest"
	            ,data: 'eventNum=' + eventNum
	            ,dataType: "json"
	            ,success: function(data) {
	                if (data.save) {
	                	$.ajax({
	                        type: "GET"
	                        ,url: "/ht/fn_get_event70380"
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
	
</script>
</head>
<body>
		<!-- Container -->
				<div class="event_top" style="visibility:hidden;">
					<c:if test="${ newEventDispTypeCode.newEventDispTypeCode ne 'C1532' && newEventDispTypeCode.newEventDispTypeCode ne 'C1533' && newEventDispTypeCode.newEventDispTypeCode ne 'C1534' }">
					<div class="location_wrap">
					<button type="button" class="btn_home" onclick="location.href='/ht/biz/welcomeMain';">홈으로</button>
					<div class="location_nav_wrap c_select">
						<c:forEach items="${listCtgr}" var="l">
						<c:if test="${l.cateId eq detail.ctgrId}"><a href="javascript://" value="${l.cateId}" class="location_1">${l.cateName}</a></c:if>
						</c:forEach>
						<c:if test="${detail.ctgrId eq '0000'}"><a href="javascript://" value="0000" class="location_1">전체</a></c:if>
						<ul class="location_nav">
						<c:forEach items="${listCtgr}" var="l">
							<li ctgrId="${l.cateId}"><a href="javascript://" onclick="javascript:getCategory('${l.cateId}');"<c:if test="${l.cateId eq detail.ctgrId}">class='active'</c:if>>${l.cateName}</a></li>
						</c:forEach>
						</ul>
					</div>
					<div class="location_nav_wrap e_select">
					</div>
					</div>
					</c:if>
					<div class="sns">
						<ul>
							<li class="sns01"><a href="javascript://" onclick="goTwitter('${detail.eventTitle}', '${defaultHost}/ht/biz/eventDetail?eventId=${detail.eventId}')"></a></li>
							<li class="sns02"><a href="javascript://" onclick="goFaceBook('${detail.eventTitle}', '${defaultHost}/ht/biz/eventDetail?eventId=${detail.eventId}')"></a></li>
							<li class="sns03"><a href="javascript://" onclick="goPinterest('${detail.eventTitle}', '${defaultHost}/ht/biz/eventDetail?eventId=${detail.eventId}')"></a></li>
						</ul>
					</div>
				</div>
				<div class="event_title" style="visibility:hidden;">
			        <h5>${detail.eventTitle}</h5>
			        <p class="date font_t">
				        <c:choose>
	                        <c:when test="${not empty detail.eventRangeInfo && detail.eventRangeInfo ne ' '}"><em class="font_ns">${detail.eventRangeInfo}</em></c:when>
	                        <c:otherwise><ui:mask pattern="####.##.##">${detail.eventStartDt}</ui:mask> <span>~</span> <ui:mask pattern="####.##.##">${detail.eventEndDt}</ui:mask></c:otherwise>
	                    </c:choose>
			        </p>
			    </div>
				<div class="event_view_cont" style="visibility:hidden;">
				<c:if test="${not empty detail.imageUrl}">
					<div class="img_wrap">
						<div class="img_area">
							<ui:image src="${detail.imageUrl}" id="eventImageUrl" usemap="#eventImageMap" clazz="sns_img"/>
						</div>
					</div>
				</c:if>
				<div class="inner950">
				<c:if test="${not empty eventRandom}">
					<c:if test="${detail.eventId eq '49299'}">
						<c:set var="num"><ui:lpad length="7" padChar="0">${eventRandom.totGiftAmt}</ui:lpad></c:set>
						<div style="display: block;position: absolute;height: 54px;top: 875px;font-size: 0;text-align: center;margin: 0 auto;width: 950px;">
							<c:set var="isnon" value="true"/>
							<c:forEach begin="0" end="6" varStatus="st">
								<c:set var="num_idx">${fn:substring(num, st.index, st.index+1)}</c:set>
		                        <c:if test="${isnon && num_idx ne '0'}"><c:set var="isnon" value="false"/></c:if>
		                        <c:if test="${st.index eq 1 || st.index eq 4}"><img src="${imageServer}/images/event/49299/pc/ic_num_dot.jpg" style="margin-right:6px;"/></c:if>
		                        <c:choose>
		                            <c:when test="${!isnon}">
		                                <img src="${imageServer}/images/event/49299/pc/ic_num_${num_idx}.jpg" alt="${num_idx}" style="margin-right:6px;"/>
		                            </c:when>
		                            <c:otherwise><img src="${imageServer}/images/event/49299/pc/ic_num_no.jpg" style="margin-right:6px;"/></c:otherwise>
		                        </c:choose>
		                    </c:forEach>
		                </div>
		            </c:if>
<!-- script -->
<script type="text/javascript" src="/js/jQueryRotate.2.3.js"></script>
<script type="text/javascript" src="/js/jQueryRotateCompressed.2.3.js"></script>
<script type="text/javascript">
    var is_rotating = false;	//룰렛 실행중 중복실행 방지
    var is_rotated = false;		//페이지에서 1회만 실행되도록 설정
    
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
                //is_rotated = true;  
                alert(msg);
                // location.href = "/ht/mypage/coupon";
            }
        });
    }
    
    function getRotateNum(eventId) {
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
                        call_rotate('roulette', data.rotateAngle, data.returnMsg);
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
            ,url: "/ht/getCouponDown"
            ,data: 'couponId=' + couponId
            ,dataType: "json"
            ,success: function(data) {
                if (data.save) {
                	$.ajax({
                        type: "GET"
                        ,url: "/ht/getCouponDown"
                        ,data: 'couponId=' + couponId2
                        ,dataType: "json"
                        ,success: function(data) {
                            if (data.save) {
                            	if(!isEmpty(couponId3)){
                            		$.ajax({
                                        type: "GET"
                                        ,url: "/ht/getCouponDown"
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
<!-- script -->
			<!-- 68056 1회용 if-->
			<c:if test="${detail.eventId ne '68152' && detail.eventId ne '70011'}">
	            	<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${eventRandom.imageUrlTop}" usemap="#eventImageTop"/>
	            <c:if test="${not empty eventRandom.imageMapTop}">
	                <map name="eventImageTop">
	                    ${eventRandom.imageMapTop}
	                </map>
	            </c:if>
	            <!-- 
	            <div style="position:relative;display:block;width:950px;height:3575px;background:url('http://image.kyobobook.co.kr/newimages/giftshop_new/work/${eventRandom.imageUrlBg}') no-repeat;">
	                <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${eventRandom.imageUrlPin}" style="position:absolute;bottom:3415px;left:calc(50% - 50px);z-index:2;"/>
	                <a href="#" onClick="getRotateNum('${eventRandom.eventId}');return false;" id="roulette" style="position:absolute;left:calc(50% - 428px);display:block;z-index:1;" >
	                    <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${eventRandom.imageUrlRlt}" width="875" height="875"/>
	                </a>
	            </div>
	             -->
	            <div style="position:relative;display:block;">
	                <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${eventRandom.imageUrlBg}" style="position:relative;z-index:1;width:100%;" usemap="#eventSns"/>
		            <c:if test="${detail.eventId == '66792'}">
		                <map name="eventSns">
		                    <area shape="rect" coords="325,973,625,1069" href="javascript:ht_shareEvent()">
		                </map>
		            </c:if>
<%-- 		            <c:if test="${detail.eventId == '70011'}"> --%>
<!-- 		                <map name="eventSns"> -->
<!-- 		                    <area shape="rect" coords="325,973,625,1069" href="javascript:ht_shareEvent()"> -->
<!-- 		                </map> -->
<%-- 		            </c:if> --%>
	                
	                <c:if test="${detail.eventId != '68152' && detail.eventId !='70011'}">
		                <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${eventRandom.imageUrlPin}" style="position:absolute;bottom:81%;left:47%;z-index:3;width:6%;background:none;"/>
		                <a href="#" onClick="getRotateNum('${eventRandom.eventId}');return false;" id="roulette" style="position:absolute;bottom:42%;width:92%;left:4%;display:block;z-index:2;background:none;" >
		                    <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${eventRandom.imageUrlRlt}" width="875" height="875" style="background:none;"/>
		                </a>
		            </c:if>
	            </div>
            </c:if>
        </c:if>
        <c:if test="${not empty detail.imageUrl950 }">
                <%-- <c:when test="${fn:startsWith(detail.ctgrId, '00002000')}">
                    <div> <!-- 이벤트 튼 배경화면 -->
                        <script type="text/javascript">
                        $("#container").css("background", "url('http://image.kyobobook.co.kr/newimages/giftshop_new/work/${detail.imageUrl950}') no-repeat 50% 534px");
                        $(".event_wrap").css("padding-top" ,"25px");
                        </script>
                    </div>
                </c:when> --%>
                <div> <!-- 이벤트 튼 배경화면 -->
                    <script type="text/javascript">
                    $("#container").css("background", "url('http://image.kyobobook.co.kr/newimages/giftshop_new/work/${detail.imageUrl950}') no-repeat 50% 336px");
                    </script>
                </div>
        </c:if>
        <div class="event_img">
            <div class="ly_box_skip" style="${isFull ne 'Y'?'height: 630px; left: 0px; top: 0px;':'left:0;'}">
                <p>종료된 이벤트 입니다.</p>
            </div>
        <c:if test="${detail.stampYn}">
            <!-- 스탬프이벤트 -->
            <div id="divStamp"></div>
            <script src="/js/ht.hot.eventDetail.stamp.js?201901071633" type="text/javascript"></script>
            <script type="text/javascript">
                _eventStamp("${detail.eventId}");
            </script>
            <!-- #스탬프이벤트 -->
        </c:if>
        <c:if test="${not empty detail.userTmplHtml}">
            <div id="userTemplate"></div>
            <textarea name="userTmplHtml" style="display:none;">${detail.userTmplHtml}</textarea>
            <script src="/js/fn_htts_event_template.js?201810041520" type="text/javascript"></script>
        </c:if>
        <c:if test="${detail.userTmplUseYn eq 'Y'}"><div>${detail.userTmpl}</div></c:if>
        </div>
					<!-- //기차형바: 상품B형이 아닌경우에만 노출 -->
			        <c:if test="${detail.eventTypeCode ne 'C019C'}">
			            <!-- link -->
			            <div class="event_link<c:if test="${not empty detail.offLineYn}"> event_link${detail.offLineYn}</c:if>">
			                <c:if test="${not empty listDisplayType}">
			                    <c:set var="isExpYn" value="false"/>
			                    <c:forEach items="${listDisplayType}" var="l">
			                        <c:if test="${l.titleUseYn eq 'Y' && l.titleExpsYn eq 'Y'}">
			                            <c:set var="isExpYn" value="true"/>
			                        </c:if>
			                    </c:forEach>
			                    <c:if test="${isExpYn}">
			                        <ul>
			                            <c:forEach items="${listDisplayType}" var="l">
			                                <c:if test="${l.titleUseYn eq 'Y' && l.titleExpsYn eq 'Y'}">
			                                    <li><a href="#event-link${l.eventTypeInseq}" title="${l.eventTitle}"><span>${l.eventTitle}</span></a></li>
			                                </c:if>
			                            </c:forEach>
			                        </ul>
			                    </c:if>
			                </c:if>
			            </div>
			            <!-- /link -->
			            <c:forEach items="${listDisplayType}" var="l">
			                <c:if test="${l.titleUseYn eq 'Y'}">
			                    <div class="image-tema-title">
			                        <c:if test="${not empty l.titleImageUrl}">
			                            <c:if test="${not empty l.eventLinkUrl}">
			                                <div class="e_bar2"><a href="${l.eventLinkUrl}"><ui:image src="${l.titleImageUrl}" id="event-link${l.eventTypeInseq}"/></a></div>
			                            </c:if>
			                            <c:if test="${empty l.eventLinkUrl}">
			                                <div class="e_bar2"><ui:image src="${l.titleImageUrl}" id="event-link${l.eventTypeInseq}"/></div>
			                            </c:if>
			                        </c:if>
			                        <c:if test="${empty l.titleImageUrl}">
			                            <div id="event-link${l.eventTypeInseq}" class="e_bar">
			                                ${l.eventTitle}
			                                <c:if test="${not empty l.eventLinkUrl}"><p class="more"><a href="${l.eventLinkUrl}">더보기</a></p></c:if>
			                            </div>
			                        </c:if>
			                    </div>
			                </c:if>
			                <c:import url="/ht/biz/bizListEventProduct?eventTypeInseq=${l.eventTypeInseq}&eventPrdtTypeCode=${l.eventPrdtTypeCode}&prdtInfoExpsYn=${l.prdtInfoExpsYn}&eventDispTypeCode=${detail.eventTypeCode}"/>
			            </c:forEach>
			        </c:if>
					<!-- Comment -->
					<!-- //기차형바: 상품B형이 아닌경우에만 노출 -->
			        <c:if test="${detail.eventTypeCode eq 'C019C'}">
			            <c:forEach items="${listDisplayType}" var="l" varStatus="st">
			                <div class="evt-list-type">
			                    <div class="list-type0${st.index%2+1}">
			                        <c:if test="${not empty l.eventLinkUrl}">
			                            <div class="evt-bnr"><a href="${l.eventLinkUrl}"><ui:image src="${l.titleImageUrl}" id="event-link${l.eventTypeInseq}"/></a></div>
			                        </c:if>
			                        <c:if test="${empty l.eventLinkUrl}">
			                            <div class="evt-bnr"><ui:image src="${l.titleImageUrl}" id="event-link${l.eventTypeInseq}"/></div>
			                        </c:if>
			                        <c:import url="/ht/biz/bizListEventProductC019C?eventTypeInseq=${l.eventTypeInseq}&eventPrdtTypeCode=${l.eventPrdtTypeCode}&prdtInfoExpsYn=${l.prdtInfoExpsYn}&eventDispTypeCode=${detail.eventTypeCode}&listSize=6"/>
			                    </div>
			                </div>
			            </c:forEach>
			        </c:if>
			        <!-- Comment -->
        <c:if test="${detail.eventTypeCode eq 'C0192' || detail.eventTypeCode eq 'C0193' || detail.eventTypeCode eq 'C0197'}">
            <div id="commentArea">
<!--             c-import부분  eq 'C0192' eq 'C0193' eq 'C0197' -->
                <c:import url="/ht/hot/comment/${detail.eventTypeCode}"/>
            </div>
        </c:if>
        <c:if test="${detail.eventId eq '61406'}">
            <div id="commentArea">
<!--             c-import부분 eq '61406' -->
                <c:import url="/ht/hot/comment/${detail.eventTypeCode}"/>
            </div>
        </c:if>
        <c:if test="${detail.eventTypeCode eq 'C019B'}">
            <c:import url="/ht/hot/curateList/${detail.eventId}"/>
        </c:if>
        <c:if test="${detail.eventTypeCode eq 'C019A'}">
            <div id="commentArea">
<!--             c-import부분  eq 'C019A' -->
                <c:import url="/ht/hot/comment/${detail.eventTypeCode}?orderBy=likeCntDesc"/>
            </div>
        </c:if>
        <c:if test="${detail.eventDispTypeCode eq 'C0219' && not empty listEvent}">
            <div id="bucketEventList">
                <p style="padding:50px;">&nbsp;</p>
                <div class="page_location" style="margin-bottom:30px;">
                    <h2 class="title"><img id="aaaaa" src="${imageServer}/images/renewal/common/tit_contentslist.gif" alt="CONTENTS LIST"></h2>
                </div>
                <div class="prod_list_normal">
                    <ul>
                        <c:forEach items="${listEvent}" var="l">
                            <li>
                                <a href="/ht/biz/eventDetail?eventId=${l.eventId}">
                                    <span class="img"><ui:image src="${l.imageUrl}" alt="${l.eventTitle}" style="width:200px;height:200px;"/></span>
                                    <span class="name mgt10">${l.eventTitle}</span>
                                </a>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
                <div class="paging">
                    <ui:paginationScript scriptName="goEventList" name="pageHolder"/>
                </div>
            </div>
        </c:if>
      </div>
</div>

			<!-- // 컨텐츠 -->
		<div class="dim"></div>
        <div class="replace-modal">
            <button type="button" class="close-btn"></button>
            <div class="title-wrap">
                <h2>하필 딱! 품절이지만 <b>괜찮아요</b></h2>
                <p>찾으시는 상품과 비슷한 상품이 여기 있어요!</p>
            </div>
            <div class="content-wrap">
	            <div class="pd_list prod_list_normal">
				<ul id="recobellRelationList">
				</ul>
				</div>
     		</div>
     	</div>
</body>
</html>