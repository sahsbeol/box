<%@page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<!-- 태그 라이브러리 -->
<%@ include file="/pages/decorators/biz/tagHeader.jsp" %>
<ui:decorator name="none"/>
<script type="text/javascript">
$(document).ready(function(){
	$('#app_bar .btn_today').on('click', function(e) {
		$("#wrap").addClass("today");
		$("#app_bar").after("<div id='benefit_wrapper' class='confirm'></div>");
		$.ajax({
		    type: "POST"
		    ,url: "/m/biz/todayBenefit"
		    ,dataType: "html"
		    ,success : function(html){		        	
		        $("#benefit_wrapper").append(html);
				benefitOpen();
		    }
		    ,error: function(data) {
		    }
		});
	});

	$('.close-my').on('click', function(e) {
		benefitClose();
	});
	
	$('#app_bar .btn_category').on('click', function(){//sidemenu open
        if($(".storeArea").hasClass("first")){
        	$(".storeArea").removeClass("first");
        	var device = '${device.devId}';

        	if(!isEmpty(device)){
    			var userAgent = navigator.userAgent;
	            //안드로이드
	            if(/Android/i.test(userAgent)){
	            	if(window.HybridApp != undefined){
	            		findStore();
	                }
	            }
	            //iOS
	            else if(/iPad|iPhone|iPod/i.test(userAgent)){
	            	try{
	            		document.location = "myScheme://sendGeoLocationiOS";
	            	}catch(err){
	            	}
	            }
    		}
        }
    });
	
	$('#app_bar .btn_home').on('click touchend', function(e) {
		location.href = "/m/biz/welcomeMain";
	});
	
	var f = (function(){
        var startPos = window.scrollY;
        function hamsoo(e){
            var endPos = window.scrollY;
            if(startPos < endPos && startPos > 10){
                $('#app_bar.confirm').addClass('active');
            } else{
              $('#app_bar.confirm').removeClass('active');
            } startPos = endPos;
        } return hamsoo;
    })();
	  window.addEventListener('scroll', f);
	  $(window).scroll(function(){
		  var sct =$(window).scrollTop()
		  if(sct >= 50){
			  $('.float-wrap').addClass('active')
			  $('.detail_input').addClass('activeTop')
			  if($('.float-wrap').is('active')){
				  setTimeout(() => {
					$('.float-wrap').removeClass('active') 
				  }, 2500);
			  }
		  } else if(sct < 50){
			  $('.float-wrap').removeClass('active')
			  $('.detail_input').removeClass('activeTop')
		  } 
	  })
});

function benefitOpen(){
	$("#app_bar .btn_today").addClass('active');
    $("#app_bar .btn_today").children('span').hide(0);
    $('#header').append('<div class="dim"></div>');
    $('.close-my').addClass('active');
    $('body').addClass('fixed').on('touchmove', function(e){e.preventDefault();return false;});
    TweenLite.to($('#header .dim'),0.7,{ease:Power4.easeOut,opacity:0.8});
    TweenLite.to($('#benefit_wrapper'),0.7,{ease:Power4.easeOut,top:0,onComplete:function(){
    }});
}

function benefitClose(){
	$("#app_bar .btn_today").children('span').show(0);
    $('body').removeClass('fixed').off('touchmove');
    $('.btn_today').removeClass('active');
    $('.close-my').removeClass('active');
    TweenLite.to($('#benefit_wrapper'),0.7,{ease:Power4.easeOut,top:'120%'});
    TweenLite.to($('#header .dim'),0.7,{ease:Power4.easeOut,opacity:0,onComplete:function(){
        $('#header .dim').remove();
    }});
}

function historyOpen(){
	$('body').addClass('fixed').on('touchmove', function(e){e.preventDefault();return false;});
    $('#header').append('<div class="dim"></div>').css({zIndex:98});
    gnbClose();
    TweenLite.to($('#header .dim'),0.7,{ease:Power4.easeOut,opacity:0.8});
    TweenLite.to($('#history_wrapper'),0.6,{ease:Power4.easeOut,left:0,onComplete:function(){
//         histSwiper.onResize();
    }});
}

function gnbClose(){
    $('body').removeClass('fixed').off('touchmove');
    TweenLite.to($('#sidemenu_wrapper'),0.7,{ease:Power4.easeOut,left:'100%'});
    TweenLite.to($('#header .dim'),0.7,{ease:Power4.easeOut,opacity:0,onComplete:function(){
        $('#header .dim').remove();
        $('#gnb .dp2').css('height','0');
        $('#gnb .dp1').removeClass('active');
    }})
}

function openHistory(){
	$.ajax({
        type: "POST"
        ,url: "/m/biz/history"
        ,dataType: "html"
        ,success : function(html){
            $("#ly_biz_recent").append(html);
            historyOpen();
        } 
        ,error: function(data) {
        }
    });
}

/* $(function(){
	$('.row-item').click(function(){
		var activeNumb = $('.row-item.active').parent().index();

		if( activeNumb !== $(this).parent().index() ){
			$('.sub-depth').slideUp();
		}else if( $(this).is('.active') == true ){
			$('.sub-depth').slideUp();
		}else{
			$('.sub-depth').slideUp(10);
		}

		$('.row-item, .sub-depth').removeClass('active');
		if(!$('#'+$(this).data('id')).is(":visible")){
			$(this).addClass('active');
			$('#'+$(this).data('id')).slideDown();
		}
	});
}); */
</script>
<!-- app bar -->
<button class="close-my"></button>
<div id="app_bar" class="confirm">
	<div class="btn_home-wrap">
		<a href="/m/biz/welcomeMain" class="btn_home">HOTTRACKS</a>
	</div>
	<a href="/m/biz/agitMain?agitTypeCd=ALL" class="MB_MAIN_GNB_9 live-btn">
		<span class="live-icon"></span>
		<strong class="live-text">PLAY</strong>
	</a>
	<!-- <a href="javascript:" class="btn_today">
		<em class="counting">3</em>
	</a> -->
	
	<a href="javascript:" class="btn_today MB_MAIN_GNB_6" onclick="javascript:;">
		<c:if test="${orderStatusTotalCnt > 0}"><em class="counting">${orderStatusTotalCnt}</em></c:if>
	</a>
	
    <a href="javascript:;" class="btn_category MB_MAIN_TOP_3"><span>카테고리 보기</span></a>
    
    <div class="float-wrap">
		<c:choose>
		    <c:when test="${not empty listRecent}">
		    	<a href="#" onclick="openHistory();return false;" class="btn_recent">
		         <c:forEach items="${listRecent}" var="l" varStatus="st" end="0">
		             <c:if test="${l.sellPrdtGbn ne 'R' && l.sellPrdtGbn ne 'D'}"><ui:image src="${l.productImageUrl}" server="product" size="150" ssl="${pageContext.request.scheme eq 'http'?'N':'Y'}"/></c:if>
		             <c:if test="${l.sellPrdtGbn eq 'R'}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="R" ratingCode="A" alt="${l.prdtName}" ssl="${pageContext.request.scheme eq 'http'?'N':'Y'}"/></c:if>
		             <c:if test="${l.sellPrdtGbn eq 'D'}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="D" ratingCode="A" alt="${l.prdtName}" ssl="${pageContext.request.scheme eq 'http'?'N':'Y'}"/></c:if>
		         </c:forEach>
		        </a>
		    </c:when>
		    <c:otherwise><a href="#" onclick="openHistory();return false;" id="btnSidem" class="btn_history" /></c:otherwise>
		</c:choose>
		<a href="#" onclick="moveTop();return false;" id="btnTop" class="btn-totop" />
    </div>
</div>
<div id="sidemenu_wrapper">
	<div class="sidemenu_cont">
		<!-- 로그인시 프렌즈,실버,골드,플래티넘,임직원 grade01 ~ grade05 : class 추가 -->
		<div class="hd <c:choose><c:when test="${isLogin}">grade${user.userGradeId}</c:when><c:otherwise>no_login</c:otherwise></c:choose>">
			<div class="cont">
				<c:choose>
					<c:when test="${isLogin}">
						<p class="MB_SIDE_TOP_1">
							<span>${user.userName}</span>님. 
							<strong id="memberTxt">
								<c:if test="${user.userGradeId eq '01'}">프렌즈</c:if>
                                <c:if test="${user.userGradeId eq '02'}">실버</c:if>
                                <c:if test="${user.userGradeId eq '03'}">골드</c:if>
                                <c:if test="${user.userGradeId eq '04'}">플래티넘</c:if>
                                <c:if test="${user.userGradeId eq '99'}">직원</c:if>
                               </strong>
                              </p>
					</c:when>
					<c:otherwise>
						<p>안녕하세요 회원님.</p>
					</c:otherwise>
				</c:choose>
				
				<ul>
					<!-- 첫번째 아이콘 -->
					<li>
						<c:choose>
							<c:when test="${isLogin}">
								<a href="javascript:;" class="MB_SIDE_TOP_9" onclick="location.href='/m/mypage/main';return false;">
									<i class="ico01"></i>
									<span>마이핫트랙스</span>
								</a>
							</c:when>
							<c:otherwise>
<!-- 									<a href="javascript:;" class="MB_SIDE_TOP_2" onclick="login();return false;"> -->
									<a href="javascript:;" onclick="location.href='/m/temp/loginForm?totMileAmt=0&returnUrl='+escape((document.location.href).split('#')[0]);return false;">
									<i class="ico05"></i>
									<span>로그인</span>
								</a>
							</c:otherwise>
						</c:choose>	
					</li>
					
					<!-- 두번째 아이콘 -->
					<li>
						<c:choose>
							<c:when test="${isLogin}">
								<a href="javascript:;" class="MB_SIDE_TOP_3" onclick="location.href='/m/mypage/orderDelivery';return false;">
									<i class="ico02"><c:if test="${orderCount > 0}"><em class="font_t">${orderCount}</em></c:if></i>
									<span>주문조회<c:if test="${orderCount > 0}"><em></em></c:if></span>
								</a>
							</c:when>
							<c:otherwise>
									<!-- <a href="javascript:;" onclick="login();return false;"> -->
									<a href="javascript:;" class="MB_SIDE_TOP_3" onclick="location.href='/m/mypage/main'; return false;">
								<!-- <a href="javascript:;" onclick="location.href='/m/temp/loginForm?totMileAmt=0&returnUrl='+escape((document.location.href).split('#')[0]);return false;"> -->
									<i class="ico02"></i>
									<span>주문조회</span>
								</a>
							</c:otherwise>
						</c:choose>				
					</li>
					
					<!-- 세번째 아이콘(비회원은 쿠폰 없음) -->
					<li>
						<c:choose>
							<c:when test="${isLogin}">
								<a href="javascript:;" class="MB_SIDE_TOP_4" onclick="location.href='/m/mypage/coupon';return false;">
									<i class="ico03">
										<c:choose>
											<c:when test="${couponCnt > 99}">
												<em class="font_t">99+</em>
											</c:when>
											<c:when test="${couponCnt > 0 && couponCnt < 100}">
												<em class="font_t">${couponCnt}</em>
											</c:when>
										</c:choose>
									</i>
									<span>쿠폰<c:if test="${couponCnt > 0}"><em></em></c:if></span>
								</a>
							</c:when>
							<c:otherwise>
									<a href="javascript:;" class="MB_SIDE_TOP_4" onclick="login();return false;">
								<!-- <a href="javascript:;" onclick="location.href='/m/temp/loginForm?totMileAmt=0&returnUrl='+escape((document.location.href).split('#')[0]);return false;"> -->
									<i class="ico03"></i>
									<span>쿠폰</span>
								</a>
							</c:otherwise>
						</c:choose>	
					</li>
					
					<!-- 네번째 아이콘 -->
					<li>
						<a href="javascript:;" class="MB_SIDE_TOP_5" onclick="location.href='/m/order/cart';return false;">
							<i class="ico04">
								<c:choose>
									<c:when test="${cartCount > 99}">
										<em class="font_t">99+</em>
									</c:when>
									<c:when test="${cartCount > 0 && cartCount < 100}">
										<em class="font_t">${cartCount}</em>
									</c:when>
								</c:choose>
							</i>
							<span>장바구니<c:if test="${cartCount > 0}"><em></em></c:if></span>
						</a>
					</li>
				</ul>
			</div>			
			<div class="store storeArea first">
				<dl class= "MB_SIDE_TOP_6">
					<dt><a href="/m/help/listStore">지금 가장 가까운 매장,</a></dt>
					<dd>
						<a href="/m/help/listStore">${store.deptname}</a>
					</dd>
				</dl>
			</div>
			<div class="btn_wrap">
				<!-- 앱이고 로그인회원일때 노출 -->
				<c:if test="${not empty devInfo}">
					<button type="button" class="btn_alarm MB_SIDE_TOP_8" onclick="location.href='/m/biz/help/listAlarm';return false;"><c:if test="${alarmCount > 0}"><em class="font_t">${alarmCount}</em></c:if></button>
				</c:if>
				<!-- //앱이고 로그인회원일때 노출 -->
				
				<button type="button" class="btn_sidemenu_close"></button>
			</div>
		</div>
		<!--// 로그인시 -->

		<!-- gnb -->
		<nav id="gnb">
			<!-- UI 개선 구간 -->
			<div class="l-category">
				<div class="row clear">
					<div class="row-item" data-id="cate1">
						<div class="item-wrap">
							<a href="javascript:;" class="MB_SIDE_CATE_1" onclick="location.href='/m/gift/biz/category/000020';return false;">
								<img src="/images/biz/sidemenu/design_icon.png" alt="디자인문구 카테고리 아이콘">
								<p>디자인문구</p>
							</a>
						</div>
					</div>
					<div class="row-item" data-id="cate2">
						<div class="item-wrap">
							<a href="javascript:;" class="MB_SIDE_CATE_2" onclick="location.href='/m/gift/biz/category/000022';return false;">
								<img src="/images/biz/sidemenu/digital_icon.png" alt="디지털 카테고리 아이콘">
								<p>디지털</p>
							</a>
						</div>
					</div>
					<div class="row-item" data-id="cate3">
						<div class="item-wrap">
							<a href="javascript:;" class="MB_SIDE_CATE_3" onclick="location.href='/m/gift/biz/category/000007';return false;">
								<img src="/images/biz/sidemenu/pancy_icon.png" alt="고급필기구 카테고리 아이콘">
								<p>고급필기구</p>
							</a>
						</div>
					</div>
					<div class="row-item" data-id="cate4">
						<div class="item-wrap">
							<a href="javascript:;" class="MB_SIDE_CATE_4" onclick="location.href='/m/gift/biz/category/000021';return false;">
								<img src="/images/biz/sidemenu/office_icon.png" alt="오피스 카테고리 아이콘">
								<p>오피스</p>
							</a>
						</div>
					</div>
				</div>
				<%-- <div class="sub-depth-wrap">
					<div class="sub-depth" id="cate1">
						<ul class="clear">
							<c:forEach items="${cateList1}" var="l">
								<li class="MB_SIDE_CATE_1"><a href="/m/gift/biz/category/${l.ctgrId}">${l.ctgrName}</a></li>
							</c:forEach>
							<li><a href="/m/gift/biz/category/000020">전체보기</a></li>
						</ul>
					</div>
					<div class="sub-depth" id="cate2">
						<ul class="clear">
							<c:forEach items="${cateList2}" var="l">
								<li class="MB_SIDE_CATE_2"><a href="/m/gift/biz/category/${l.ctgrId}">${l.ctgrName}</a></li>
							</c:forEach>
							<li><a href="/m/gift/biz/category/000022">전체보기</a></li>
						</ul>
					</div>
					<div class="sub-depth" id="cate3">
						<ul class="clear">
							<c:forEach items="${cateList3}" var="l">
								<li class="MB_SIDE_CATE_3"><a href="/m/gift/biz/category/${l.ctgrId}">${l.ctgrName}</a></li>
							</c:forEach>
							<li><a href="/m/gift/biz/category/000007">전체보기</a></li>
						</ul>
					</div>
					<div class="sub-depth" id="cate4">
						<ul class="clear">
							<c:forEach items="${cateList4}" var="l">
								<li class="MB_SIDE_CATE_4"><a href="/m/gift/biz/category/${l.ctgrId}">${l.ctgrName}</a></li>
							</c:forEach>
							<li><a href="/m/gift/biz/category/000021">전체보기</a></li>
						</ul>
					</div>
				</div> --%>
				<div class="row clear">
					<div class="row-item" data-id="cate5">
						<div class="item-wrap">
							<a href="javascript:;" class="MB_SIDE_CATE_5" onclick="location.href='/m/gift/biz/category/000025';return false;">
								<img src="/images/biz/sidemenu/living_icon.png" alt="리빙/생활가전 카테고리 아이콘">
								<p>리빙/생활가전</p>
							</a>
						</div>
					</div>
					<div class="row-item" data-id="cate6">
						<div class="item-wrap">
							<a href="javascript:;" class="MB_SIDE_CATE_6" onclick="location.href='/m/gift/biz/category/000026';return false;">
								<img src="/images/biz/sidemenu/kitchen_icon.png" alt="키친/푸드 카테고리 아이콘">
								<p>키친/푸드</p>
							</a>
						</div>
					</div>
					<div class="row-item" data-id="cate7">
						<div class="item-wrap">
							<a href="javascript:;" class="MB_SIDE_CATE_7" onclick="location.href='/m/gift/biz/category/000024';return false;">
								<img src="/images/biz/sidemenu/chair_icon.png" alt="가구/수납 카테고리 아이콘">
								<p>가구/수납</p>
							</a>
						</div>
					</div>
					<div class="row-item" data-id="cate8">
						<div class="item-wrap">
							<a href="javascript:;" class="MB_SIDE_CATE_8" onclick="location.href='/m/gift/biz/category/000028';return false;">
								<img src="/images/biz/sidemenu/fashion_icon.png" alt="패션잡화 카테고리 아이콘">
								<p>패션잡화</p>
							</a>
						</div>
					</div>
				</div>
				<%-- <div class="sub-depth-wrap">
					<div class="sub-depth" id="cate5">
						<ul class="clear">
							<c:forEach items="${cateList5}" var="l">
								<li class="MB_SIDE_CATE_5"><a href="/m/gift/biz/category/${l.ctgrId}">${l.ctgrName}</a></li>
							</c:forEach>
							<li><a href="/m/gift/biz/category/000025">전체보기</a></li>
						</ul>
					</div>
					<div class="sub-depth" id="cate6">
						<ul class="clear">
							<c:forEach items="${cateList6}" var="l">
								<li class="MB_SIDE_CATE_6"><a href="/m/gift/biz/category/${l.ctgrId}">${l.ctgrName}</a></li>
							</c:forEach>
							<li><a href="/m/gift/biz/category/000026">전체보기</a></li>
						</ul>
					</div>
					<div class="sub-depth" id="cate7">
						<ul class="clear">
							<c:forEach items="${cateList7}" var="l">
								<li class="MB_SIDE_CATE_7"><a href="/m/gift/biz/category/${l.ctgrId}">${l.ctgrName}</a></li>
							</c:forEach>
							<li><a href="/m/gift/biz/category/000024">전체보기</a></li>
						</ul>
					</div>
					<div class="sub-depth" id="cate8">
						<ul class="clear">
							<c:forEach items="${cateList8}" var="l">
								<li class="MB_SIDE_CATE_8"><a href="/m/gift/biz/category/${l.ctgrId}">${l.ctgrName}</a></li>
							</c:forEach>
							<li><a href="/m/gift/biz/category/000028">전체보기</a></li>
						</ul>
					</div>
				</div> --%>
				<div class="row clear">
					<div class="row-item" data-id="cate9">
						<div class="item-wrap">
							<a href="javascript:;" class="MB_SIDE_CATE_9" onclick="location.href='/m/gift/biz/category/000006';return false;">
								<img src="/images/biz/sidemenu/beauty_icon.png" alt="뷰티/헬스 카테고리 아이콘">
								<p>뷰티/헬스</p>
							</a>
						</div>
					</div>
					<div class="row-item" data-id="cate10">
						<div class="item-wrap">
							<a href="javascript:;" class="MB_SIDE_CATE_10" onclick="location.href='/m/gift/biz/category/000027';return false;">
								<img src="/images/biz/sidemenu/travel_icon.png" alt="여행/자동차 카테고리 아이콘">
								<p>여행/자동차</p>
							</a>
						</div>
					</div>
					<div class="row-item" data-id="cate11">
						<div class="item-wrap">
							<a href="javascript:;" class="MB_SIDE_CATE_11" onclick="location.href='/m/gift/biz/category/000023';return false;">
								<img src="/images/biz/sidemenu/hobby_icon.png" alt="취미/펫 카테고리 아이콘">
								<p>취미/펫</p>
							</a>
						</div>
					</div>
					<div class="row-item" data-id="cate12">
						<div class="item-wrap">
							<a href="javascript:;" class="MB_SIDE_CATE_12" onclick="location.href='/m/gift/biz/category/000029';return false;">
								<img src="/images/biz/sidemenu/kids_icon.png" alt="유아동 카테고리 아이콘">
								<p>유아동</p>
							</a>
						</div>
					</div>
				</div>
				<%-- <div class="sub-depth-wrap">
					<div class="sub-depth" id="cate9">
						<ul class="clear">
							<c:forEach items="${cateList9}" var="l">
								<li class="MB_SIDE_CATE_9"><a href="/m/gift/biz/category/${l.ctgrId}">${l.ctgrName}</a></li>
							</c:forEach>
							<li><a href="/m/gift/biz/category/000006">전체보기</a></li>
						</ul>
					</div>
					<div class="sub-depth" id="cate10">
						<ul class="clear">
							<c:forEach items="${cateList10}" var="l">
								<li class="MB_SIDE_CATE_10"><a href="/m/gift/biz/category/${l.ctgrId}">${l.ctgrName}</a></li>
							</c:forEach>
							<li><a href="/m/gift/biz/category/000027">전체보기</a></li>
						</ul>
					</div>
					<div class="sub-depth" id="cate11">
						<ul class="clear">
							<c:forEach items="${cateList11}" var="l">
								<li class="MB_SIDE_CATE_11"><a href="/m/gift/biz/category/${l.ctgrId}">${l.ctgrName}</a></li>
							</c:forEach>
							<li><a href="/m/gift/biz/category/000023">전체보기</a></li>
						</ul>
					</div>
					<div class="sub-depth" id="cate12">
						<ul class="clear">
							<c:forEach items="${cateList12}" var="l">
								<li class="MB_SIDE_CATE_12"><a href="/m/gift/biz/category/${l.ctgrId}">${l.ctgrName}</a></li>
							</c:forEach>
							<li><a href="/m/gift/biz/category/000029">전체보기</a></li>
						</ul>
					</div>
				</div> --%>
				<div class="row clear">
					<div class="row-item" data-id="cate13">
						<div class="item-wrap MB_SIDE_CATE_13">
							<a href="javascript:;" class="MB_SIDE_CATE_13" onclick="location.href='/m/biz/eventDetail?eventId=47389';return false;">
								<img src="/images/biz/sidemenu/PB_icon.png" onclick="location.href='/m/biz/eventDetail?eventId=69042'" alt="직수입/PB 카테고리 아이콘">
								<p>직수입/PB</p>
							</a>
						</div>
					</div>
					<div class="row-item" data-id="cate14">
						<div class="item-wrap">
							<a href="javascript:;" class="MB_SIDE_CATE_14" onclick="location.href='/m/record/biz/category/0003';return false;">
								<img src="/images/biz/sidemenu/music_icon.png" alt="CD/LP 카테고리 아이콘">
								<p>CD/LP</p>
							</a>
						</div>
					</div>
					<div class="row-item" data-id="cate15">
						<div class="item-wrap">
							<a href="javascript:;" class="MB_SIDE_CATE_15" onclick="location.href='/m/dvd/biz/category/000401';return false;">
								<img src="/images/biz/sidemenu/dvd_icon.png" alt="DVD/BLU-RAY 카테고리 아이콘">
								<p>DVD/BLU-RAY</p>
							</a>
						</div>
					</div>
				</div>
				<%-- <div class="sub-depth-wrap">
					<div class="sub-depth" id="cate14">
						<ul class="clear">
							<c:forEach items="${cateList14}" var="l">
								<li class="MB_SIDE_CATE_14"><a href="/m/record/biz/category/${l.ctgrId}">${l.ctgrName}</a></li>
							</c:forEach>
							<li><a href="/m/gift/biz/category/0003">전체보기</a></li>
						</ul>
					</div>
					<div class="sub-depth" id="cate15">
						<ul class="clear">
							<li class="MB_SIDE_CATE_15"><a href="/m/dvd/biz/category/000401">DVD</a></li>
							<li class="MB_SIDE_CATE_15"><a href="/m/dvd/biz/category/000400">BLU-RAY</a></li>
						</ul>
					</div>
				</div> --%>
			</div>
			<div class="contents-wrap">
				<div class="content-list clear">
					<div class="content-item">
						<a onclick="location.href='/m/biz/lifeMain?productOrderBy=R'">
						<img src="/images/biz/sidemenu/when_bg.png" alt="이럴때 이미지">
						<div class="MB_SIDE_MENU_11 overlap">
							<div class="text-wrap">
								<strong>이럴 때,</strong>
								<p>우리의 느슨한 연대</p>
							</div>
						</div>
						</a>
					</div>
					<div class="content-item">
						<a onclick="location.href='/m/biz/agitMain?agitTypeCd=ALL'">
						<img src="/images/biz/sidemenu/agit_bg.png" alt="아지트 이미지">
						<div class="MB_SIDE_MENU_12 overlap">
							<div class="text-wrap">
								<strong>아지트</strong>
								<p>숏폼, 영상 콘텐츠</p>
							</div>
						</div>
						</a>
					</div>
					<div class="content-item">
						<a onclick="location.href='/m/biz/agitMain?agitTypeCd=C1515'">
						<img src="/images/biz/sidemenu/viewer_bg.png" alt="뷰어 이미지">
						<div class="MB_SIDE_MENU_13 overlap">
							<div class="text-wrap">
							<strong>뷰어</strong>
							<p>브랜드에 대한 새로운 시선</p>
						</div>
						</div>
						</a>
					</div>
					<div class="content-item">
						<a onclick="location.href='/m/biz/agitMain?agitTypeCd=C1511'">
						<img src="/images/biz/sidemenu/hott_bg.png" alt="핫트연구소 이미지">
						<div class="MB_SIDE_MENU_14 overlap">
							<div class="text-wrap">
								<strong>핫트연구소</strong>
								<p>별걸 다 리뷰하는 소통방송</p>
							</div>
						</div>
						</a>
					</div>
					<div class="content-item">
						<a class="MB_SIDE_MENU_9" onclick="location.href='/m/biz/idol/news'">
							<img src="/images/biz/sidemenu/music.png" alt="뮤직 매거진 아이콘" class="content-icon">
							<strong>뮤직 매거진</strong>
						</a>
					</div>
					<div class="content-item">
						<a class="MB_SIDE_MENU_10" onclick="location.href='/m/help/signMain'">
							<img src="/images/biz/sidemenu/sign.png" alt="팬사인회 아이콘" class="content-icon">
							<strong>팬사인회</strong>
						</a>
					</div>
				</div>
			</div>
		
			<!-- 공지사항 +당첨자발표 최근 1건 -->
			<c:if test="${not empty userNotice}">
				<div class="notice">
					<h5>공지사항<em></em></h5>
					<p><a href="javascript:;" class="MB_SIDE_ANNOUNCE_1" onclick="location.href='/m/help/listNotice';return false;">${userNotice.notiTitle}</a></p>
				</div>
			</c:if>
			<c:if test="${not empty userEventNotice}">
				<div class="notice">
					<h5>공지사항<em></em></h5>
					<p><a href="javascript:;" class="MB_SIDE_ANNOUNCE_1" onclick="location.href='/m/help/listEventPrize';return false;">${userEventNotice.eventTitle}</a></p>
				</div>
			</c:if>
			<!-- //공지사항 최근 1건 -->
			
			<div class="cs">
				<a href="tel:1661-1112">
					<dl>
						<dt>고객센터</dt>
						<dd>
							1661-1112
							<span>월-금<em>오전9시~오후6시</em></span>
						</dd>
					</dl>
				</a>
			</div>
			<div class="util">
				 <ul>
					<!-- 로그인상태일때 노출 -->
					<c:if test="${isLogin}">
						<li>
							<a href="javascript:;" class="MB_SIDE_ANNOUNCE_3" onclick="_logout();return false;" class="btn_logout">
								<i class="ico04"></i>
								<span>로그아웃</span>
							</a>
						</li>
					</c:if>
					<!-- //로그인상태일때 노출 -->
					
					<li>
						<a href="javascript:;" class="MB_SIDE_ANNOUNCE_2" onclick="location.href='/m/help/main';return false;" class="btn_inquiry">
							<i class="ico01"></i>
							<span>고객센터</span>
						</a>
					</li>
					
					<!-- 앱이고 로그인회원일때 노출 -->
					<c:if test="${not empty devInfo}">
						<c:if test="${isLogin}">
							<li>
								<a href="javascript:;" class="MB_SIDE_ANNOUNCE_4" onclick="bizGoSetting();return false;" class="btn_alarm">
									<i class="ico02"></i>
									<span>설정</span>
								</a>
							</li>
						</c:if>
					</c:if>
					<!-- //앱이고 로그인회원일때 노출 -->
					
					<li>
						<a href="javascript:;" onclick="pcVerConfirm();return false;" class="btn_pc">
							<i class="ico03"></i>
							<span>PC화면</span>
						</a>
					</li>
				 </ul>
			</div>
		</nav>
		<!--// gnb -->
	</div>

</div>
<!--// app bar -->
<div id="ly_biz_recent"></div>

<script type="text/javascript">
	var exType = ''; 
	var iosCnt = 0;
	$(document).ready(function() {
		//회원등급 텍스트
		$("#memberTxt").on("click", function(){
			location.href = "/m/help/memberShip";
		});
	});
	
	function bizGoSetting(){
    	location.href = '${defaultHost}/m/biz/hot/setting';
	}
	
	function findStore(){
		//가까운 지점 찾기
		if(window.HybridApp != undefined && window.HybridApp.enhanceLocation != undefined){
            var data = window.HybridApp.enhanceLocation();
            var json = JSON.parse(data);
            var lat = json["LOC_LATITUDE"];
            var long = json["LOC_LONGITUDE"];
            if(lat == undefined || lat == null){
                loadStore("", "");
            } else{
                loadStore(lat, long);
            }
        }else{
            if(navigator && "geolocation" in navigator){
                // var timecheck = setTimeout('loadStore("${latitude}", "${latitude}")', 5000);
                
                var geo_success = (function (position) {
                    loadStore(position.coords.latitude, position.coords.longitude);
                });
                
                var tryAPIGeolocation = function() {
                    jQuery.post( "https://www.googleapis.com/geolocation/v1/geolocate?key=AIzaSyDCa1LUe1vOczX1hO_iGYgyo8p_jYuGOPU", function(success) {
                        geo_success({coords: {latitude: success.location.lat, longitude: success.location.lng}});
                    })
                    .fail(function(err) {
                        // showMsg("위치 정보를 불러오는데 실패하였습니다.[API Fail]");
                        loadStore("${latitude}", "${latitude}");
                        // alert("API Geolocation error! \n\n"+err);
                    });
                };
                
                var geo_error = function(error) {
                    switch (error.code) {
                    case error.TIMEOUT:
                        showMsg("위치 정보를 불러오는데 실패하였습니다.[Timeout]");
                        loadStore("${latitude}", "${latitude}");
                        break;
                    case error.PERMISSION_DENIED:
                        if(error.message.indexOf("Only secure origins are allowed") == 0) {
                            tryAPIGeolocation();
                        }
                        break;
                    case error.POSITION_UNAVAILABLE:
                        // dirty hack for safari
                        if(error.message.indexOf("Origin does not have permission to use Geolocation service") == 0) {
                            tryAPIGeolocation();
                        } else {
                            showMsg("위치 정보를 불러오는데 실패하였습니다.[Position unavailable]");
                            loadStore("${latitude}", "${latitude}");
                        }
                        break;
                }
                };
                
                var geo_options = {
                  enableHighAccuracy: true, 
                  maximumAge        : 50000, 
                  timeout           : 20000
                };
                
                var wpid = navigator.geolocation.watchPosition(geo_success, geo_error, geo_options);
            }else{
                loadStore("${latitude}", "${longitude}");
            }
        }
	}
	
	function pcVerConfirm(){
		if(confirm("PC버전보기는 PC환경에 최적화 되어있어 일부 기능이 제대로 작동하지 않을 수 있습니다.")){
			showPcVer();
		}
	}
	
	function sendGeoLocationiOS(latitude,longitude){
		if(iosCnt == 0){
			loadStore(latitude, longitude);
		}
		iosCnt ++;
	}
	
	function loadStore(latitude, longitude){
		$.ajax({
            type: "GET"
           ,data : { "locLat"	: latitude
        	   		,"locLong" 	: longitude	}
           ,url: "/m/biz/layerStore"
           ,dataType: 'json'
           ,success : function(data) {
        	   $(".storeArea a").attr("href", "/m/help/listStore");
        	   $(".storeArea dd a").text(data.store.deptname);
           }
           ,error: function(data) {
               alert('<fmt:message key="error.common.system"/>');
               $("#loading").hide();
           }
        });
	}
	
	function _logout(){
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
		          , autoLoginYn : 'N'
		        }
		        ,success : function(data){
		            //console.log("save");
		        } 
		        ,error: function(data) {
		            //console.log("fail");
		        }
		    });
		}
	    
	    logout();
	}
</script>