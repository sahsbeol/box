<%@ page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<!-- 태그 라이브러리 -->
<%@ include file="/pages/decorators/biz/tagHeader.jsp" %>
<style>
.bnr_topbox {position: fixed; top:0px; width:100%; height:44px; z-index:99999;}
.bnr_topbox img {width:100%; height:auto;}
.bnr_topbox .btn_btclose {
    position: absolute;
    top: 10px;
    width: 24px;
    height: 24px;
    right: 10px;
    text-indent: -999999px;
    background: url(http://image.kyobobook.co.kr/newimages/giftshop_new/resources/img/device/ic_topclose.png) no-repeat;
    background-size: 24px 24px;}

.bnr_topbox + #header.bnr_top {top: 44px !important;}
.bnr_topbox + #header.bnr_top.active {top: -65px !important;}
</style>
<script type="text/javascript">
jQuery(function($){
    var chkInt = 6; // sessionStorage.getItem('chkInt')를 출력
    //console.log(chkInt);
    /*if (chkInt && chkInt<5) {
			sessionStorage.setItem('chkInt', (parseInt(chkInt)+1));
			$("input[name=exLink]").val($("input[name=exLink"+(parseInt(chkInt)+1)+"]").val());
			$("input[name=exTxt]").val($("input[name=exTxt"+(parseInt(chkInt)+1)+"]").val());
			if ($("input[name=exLink"+(parseInt(chkInt)+1)+"]").val() != undefined) {
				$("#srcBtn").attr("onclick","location.href='"+$("input[name=exLink"+(parseInt(chkInt)+1)+"]").val()+"';return false;");
			} else {
				$("#srcBtn").attr("onclick","searchOpen();return false;");
			}
			$("#srcInput").attr("placeholder",$("input[name=exTxt"+(parseInt(chkInt)+1)+"]").val());
	}else{
	    sessionStorage.setItem('chkInt', 1);
		$("input[name=exLink]").val($("input[name=exLink1]").val());
		$("input[name=exTxt]").val($("input[name=exTxt1]").val());
		if ($("input[name=exLink1]").val() != null) {
			
		}
	}*/
	
	var userAgent = navigator.userAgent.toUpperCase();
	if (!userAgent.match(/APP:HOTTRACKS/)){
		var id = $(".bnr_topbox").attr("id").replace("#", "");
		
		if(getCookie(id) != ("Y"+setDate())){
			$(".bnr_topbox").show();
			$("#header").addClass("bnr_top");
			$("#content").css("padding-top","44px");
        }
	}
	
	$("#srcBtn").attr("onclick","location.href='"+$("input[name=exLink1]").val()+"';return false;");
	$("#srcInput").attr("placeholder",$("input[name=exTxt1]").val());
});
function searchOpen(){
	$('body').addClass('fixed').on('touchmove', function(e){e.preventDefault();return false;});
	$('#wrap').append('<div class="search_dim"></div>');
	TweenLite.to($('#wrap .search_dim'),0.7,{ease:Power4.easeOut,opacity:0.8})
	TweenLite.to($('#search_menu'),0.7,{ease:Power4.easeOut,left:0,onComplete:function(){
		searchMenuSwiper.onResize();
	}});
}

function setDate(){
	var nowDate = new Date();
	
    var date = nowDate.getDate();
    var month = nowDate.getMonth()+1;
    var newDate = month +""+ date;
    return newDate;
}
</script>

<!-- 모바일웹 전용 상단 배너 -->
<div id="bnrTopbox" class="bnr_topbox" style="display:none;">
   <a href="#n" onclick="linkToDevice('Y');return false;" class="wd100"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/resources/img/device/bnr_appdown.png"/></a>
   <a href="#n" onclick="Fn_closeLayerTopBnr('#bnrTopbox', 'Y', setDate());return false;" class="btn_btclose">닫기</a>        
</div>

<!-- header -->
<div id="header">
    <div class="inner">
    	<a href="javascript:;" class="btn_home" onclick="location.href='${defaultHost}/';return false;">홈버튼</a>
    	<!-- 메인 -->
		<div class="main_wrap">
            <c:if test="${not empty listTrendKeyword}">
                <c:forEach items="${listTrendKeyword}" var="l" varStatus="st">
                    <c:set var="keywords" value="${l.keyword}"/>
                	<c:if test="${not empty l.requested}">
	                    <c:if test="${l.prevRank ne 2 || l.prevRank ne 3}"><c:set var="keywordsUrl" value="/e/${l.requested}"/></c:if>
	                    <c:if test="${l.prevRank eq 2}"><c:set var="keywordsUrl" value="/p/${l.requested}"/></c:if>
	                    <c:if test="${l.prevRank eq 3}"><c:set var="keywordsUrl" value="/b/${l.requested}"/></c:if>
	                	<input type="hidden" name="exLink${st.count}" value="${keywordsUrl}"/>
                    </c:if>
	                <input type="hidden" name="exTxt${st.count}" value="${keywords}"/>
                </c:forEach>
            </c:if>
			<input type="hidden" name="exLink" value="${krywordsUrl}"/>
			<input type="hidden" name="exTxt" value="${keywords}"/>
			<input type="text" class="MB_MAIN_TOP_1" id="srcInput" placeholder="">
	        <a href="javascript:;" class="btn_category MB_MAIN_TOP_3"><span>카테고리 보기</span></a>
	        <a href="javascript:;" onclick="location.href='${keywordsUrl}';return false;" id="srcBtn" class="btn_search MB_MAIN_TOP_2"><span>검색</span></a>
		</div>
		<!--// 메인 -->
        
		<!-- 서브 -->
		<div class="sub_wrap">
			<a href="javascript:;" onclick="locBack();return false;" class="btn_back">뒤로가기</a>
	        <a href="javascript:;" class="btn_category MB_MAIN_TOP_3">카테고리 보기</a>
	        <a href="javascript:;" class="btn_search MB_MAIN_TOP_2">검색</a>
	        <a href="/" class="btn_bhome" style="display: none;">홈으로</a>
			<h2 id="subTitle">${subTitle}</h2>
		</div>
		<!--// 서브 -->
    </div>
	<div class="top_menu">
		<ul>
			<li id="gnbMunguGift" class="MB_MAIN_GNB_1"><a href="/m/biz/welcomeMain">문구&middot;기프트</a></li>
			<li id="gnbRecord" class="MB_MAIN_GNB_2"><a href="/m/biz/musicMain">음반</a></li>
			<li id="gnblife" class="MB_MAIN_GNB_4"><a href="/m/biz/lifeMain?productOrderBy=R">이럴 때,<i class="this"></i></a></li>
			<li id="gnbAgit" class="MB_MAIN_GNB_3"><a href="/m/biz/agitMain?agitTypeCd=ALL">아지트</a></li>			
		</ul>
	</div>
	
	<!-- 아지트 탑메뉴 -->
	<div class="agit_menu" id="agit_navi" style="display:none;">
		<div class="swiper-container agit_menu">
	        <ul class="swiper-wrapper">
	            <!-- 선택 시 active 클래스 추가 -->
	            <li class="swiper-slide"><a href="#n" data-type="ALL"><i class="icon icon00"></i>전체보기</a></li>
				<li class="swiper-slide"><a href="#n" data-type="C1511"><i class="icon icon01"></i>핫트연구소</a></li>
				<li class="swiper-slide"><a href="#n" data-type="C1515"><i class="icon icon02"></i>뷰어</a></li>
				<li class="swiper-slide"><a href="#n" data-type="C1514"><i class="icon icon03"></i>핫트뿅뿅</a></li>
				<li class="swiper-slide"><a href="#n" data-type="C1512"><i class="icon icon04"></i>문구하울</a></li>
				<li class="swiper-slide"><a href="#n" data-type="C1513"><i class="icon icon05"></i>보이는이야기</a></li>
			</ul>
		</div>
	</div>
	<!--// 아지트 탑메뉴 -->
		
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
 									<!-- <a href="javascript:;" class="MB_SIDE_TOP_2" onclick="login();return false;"> -->
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
				<!-- 햄버거 상단 배너 -->
				<c:if test="${not empty bizBnrList1}">
					<div class="banner">
						<div class="swiper-container">
							<div class="swiper-wrapper">
								<c:forEach items="${bizBnrList1}" var="bnrList1" varStatus="status">
									<div class="swiper-slide">
										<a href="javascript:;" class="MB_SIDE_TOP_7" onclick="location.href='${bnrList1.bnrLinkUrl}';return false;">
											<div class="text"><span><em>${bnrList1.mainText}</em></span></div>
											<ui:image src="${bnrList1.imageUrlMo}" alt="${bnrList1.imageAlt}"/>
										</a>
									</div>
								</c:forEach>
							</div>
							<div class="swiper-pagination"></div>
						</div>
					</div>
				</c:if>
				<!-- //햄버거 상단 배너 -->
				
				<div class="category">
					<ul>
						<li>
							<a href="javascript:;" class="MB_SIDE_CATE_1" onclick="location.href='/m/gift/biz/category/000020';return false;">
								<i class="ico01"></i>
								<span>디자인문구</span>
							</a>
						</li>
						<li>
							<a href="javascript:;" class="MB_SIDE_CATE_2" onclick="location.href='/m/gift/biz/category/000022';return false;">
								<i class="ico02"></i>
								<span>디지털</span>
							</a>
						</li>
						<li>
							<a href="javascript:;" class="MB_SIDE_CATE_3" onclick="location.href='/m/gift/biz/category/000007';return false;">
								<i class="ico03"></i>
								<span>고급필기구</span>
							</a>
						</li>
						<li>
							<a href="javascript:;" class="MB_SIDE_CATE_4" onclick="location.href='/m/gift/biz/category/000021';return false;">
								<i class="ico04"></i>
								<span>오피스</span>
							</a>
						</li>
						<li>
							<a href="javascript:;" class="MB_SIDE_CATE_5" onclick="location.href='/m/gift/biz/category/000025';return false;">
								<i class="ico05"></i>
								<span>리빙/생활가전</span>
							</a>
						</li>
						<li>
							<a href="javascript:;" class="MB_SIDE_CATE_6" onclick="location.href='/m/gift/biz/category/000026';return false;">
								<i class="ico06"></i>
								<span>키친/푸드</span>
							</a>
						</li>
						<li>
							<a href="javascript:;" class="MB_SIDE_CATE_7" onclick="location.href='/m/gift/biz/category/000024';return false;">
								<i class="ico07"></i>
								<span>가구/수납</span>
							</a>
						</li>
						<li>
							<a href="javascript:;" class="MB_SIDE_CATE_8" onclick="location.href='/m/gift/biz/category/000028';return false;">
								<i class="ico08"></i>
								<span>패션잡화</span>
							</a>
						</li>
						<li>
							<a href="javascript:;" class="MB_SIDE_CATE_9" onclick="location.href='/m/gift/biz/category/000006';return false;">
								<i class="ico09"></i>
								<span>뷰티/헬스</span>
							</a>
						</li>
						<li>
							<a href="javascript:;" class="MB_SIDE_CATE_10" onclick="location.href='/m/gift/biz/category/000027';return false;">
								<i class="ico10"></i>
								<span>여행/자동차</span>
							</a>
						</li>
						<li>
							<a href="javascript:;" class="MB_SIDE_CATE_11" onclick="location.href='/m/gift/biz/category/000023';return false;">
								<i class="ico11"></i>
								<span>취미/펫</span>
							</a>
						</li>
						<li>
							<a href="javascript:;" class="MB_SIDE_CATE_12" onclick="location.href='/m/gift/biz/category/000029';return false;">
								<i class="ico12"></i>
								<span>유아동</span>
							</a>
						</li>
						<li>
							<a href="javascript:;" class="MB_SIDE_CATE_13" onclick="location.href='/m/biz/eventDetail?eventId=47389';return false;">
								<i class="ico13"></i>
								<span>직수입/PB</span>
							</a>
						</li>
						<li>
							<a href="javascript:;" class="MB_SIDE_CATE_14" onclick="location.href='/m/record/biz/category/0003';return false;">
								<i class="ico14"></i>
								<span>CD/LP</span>
							</a>
						</li>
						<li>
							<a href="javascript:;" class="MB_SIDE_CATE_15" onclick="location.href='/m/dvd/biz/category/000401';return false;">
								<i class="ico15"></i>
								<span>DVD/BD</span>
							</a>
						</li>
					</ul>
				</div>
				<div class="sales">
					<ul>
						<li class="MB_SIDE_MENU_1"><a href="javascript:;" onclick="location.href='/m/biz/hot/best/';return false;">베스트</a></li>
						<li class="MB_SIDE_MENU_2"><a href="javascript:;" onclick="location.href='/m/biz/hot/best?dispMstrId=FREE_DELIVERY_BEST';return false;">무료배송</a></li>
						<li class="MB_SIDE_MENU_3"><a href="javascript:;" onclick="location.href='/m/biz/hot/best?dispMstrId=CATE_GFT_NEW';return false;">신상품</a></li>
						<li class="MB_SIDE_MENU_4"><a href="javascript:;" onclick="location.href='/m/biz/hot/best?dispMstrId=CATE_GFT_SALE';return false;">할인</a></li>
						<li class="MB_SIDE_MENU_5"><a href="javascript:;" onclick="location.href='/m/biz/hot/eventMain';return false;">이벤트</a></li>
						<li class="MB_SIDE_MENU_6"><a href="javascript:;" onclick="location.href='/m/biz/personal/personalRecommend';return false;">개인의 취향</a></li>
					</ul>
				</div>
				
				<!-- 햄버거 하단 배너 -->
				<c:if test="${not empty bizBnrList2}">
					<div class="service_banner">
						<div class="tit">
							<h5></h5>
						</div>
						<div class="swiper-container">
							<div class="swiper-wrapper">
								<c:forEach items="${bizBnrList2}" var="bnrList2" varStatus="status">
									<div class="swiper-slide <c:if test="${status.first}">first</c:if>">
										<a href="javascript:;" class="MB_SIDE_MENU_7" onclick="location.href='${bnrList2.bnrLinkUrl}';return false;">
											<c:if test="${bnrList2.signWayGbn eq 'C1452'}">
												<p class="txt">${bnrList2.mainText}</p>
											</c:if>
											<ui:image src="${bnrList2.imageUrlMo}" alt="${bnrList2.imageAlt}"/>
										</a>
									</div>
								</c:forEach>
							</div>
						</div>
					</div>
				</c:if>
				<!-- //햄버거 하단 배너 -->
				
				<div class="content">
					<ul>
						<li>
							<a href="javascript:;" class="MB_SIDE_MENU_8" onclick="location.href='/m/biz/agitMain?agitTypeCd=C1511';return false;">
								<span><img src="https://simage.kyobobook.co.kr/newimages/giftshop_new/resources/img/common/img_thumb01.jpg" alt="핫트연구소"></span>핫트연구소
							</a>
						</li>
						<li>
							<a href="javascript:;" class="MB_SIDE_MENU_9" onclick="location.href='/m/biz/idol/news';return false;">
								<span><img src="https://simage.kyobobook.co.kr/newimages/giftshop_new/resources/img/common/img_thumb02.jpg" alt="뮤직매거진"></span>뮤직매거진
							</a>
						</li>
						<li>
							<a href="javascript:;" class="MB_SIDE_MENU_10" onclick="location.href='/m/help/signMain/';return false;">
								<span><img src="https://simage.kyobobook.co.kr/newimages/giftshop_new/resources/img/common/img_thumb03.jpg" alt="팬사인회"></span>팬사인회
							</a>
						</li>
					</ul>
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
					<dl>
						<dt>고객센터</dt>
						<dd>
							1661-1112
							<span>월-금<em>오전9시~오후6시</em></span>
						</dd>
					</dl>
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
</div>
<!--// header -->

<script type="text/javascript">
	var exType = ''; 
	var iosCnt = 0;
	$(document).ready(function() {
		//회원등급 텍스트
		$("#memberTxt").on("click", function(){
			location.href = "/m/help/memberShip";
		});
		
		$('#header .btn_category').on('click', function(){//sidemenu open
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
	
	// 아지트
	$(".agit_menu ul li a").on("click", function (e) {
		e.preventDefault();
		var type = $(this).data('type');
		if(exType != null && exType != '') {
			if(exType == type) {
				type = null;
			}
		}
		
		exType = type;
		
		if($(this).parent('li').hasClass('active')){
		   $(this).parent('li').removeClass('active');
		}else {
		   $(this).parent('li').addClass('active');
   		   $(this).parent('li').siblings().removeClass('active');
		}
		
		var $obj = $("#tabSwiper .gnbAgit");
		if(type != ""){
			location.href="/m/biz/agitMain?agitTypeCd="+type;		
		}else{
			location.href="/m/biz/agitMain";	
		}
	});
	
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

<!-- 신규 수정 추가 -->
<script>
	$(document).ready(function(){
	      var agitmenuswiper = new Swiper('.swiper-container.agit_menu', {
	      slidesPerView: 'auto',
	      speed: 300,
	      freeMode: true,
	      freeModeMomentumBounce: false
	    });
	});
</script>