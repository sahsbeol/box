<%@ page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<!-- 태그 라이브러리 -->
<%@ include file="/pages/decorators/biz/tagHeader.jsp" %>
<ui:decorator name="none"/>

<style>

#header.fixed #gnb .keyword_list_v2 {display:none !important;}
#gnb .keyword_list_v2{border: 1px solid #dbdbdb;box-sizing:border-box;border-radius: 20px;background: #fff;z-index: 10;width: 270px;position: relative;top: -70px;margin: 0 auto;left: 510px;padding: 20px 10px 30px 36px;display:none;-webkit-box-shadow: 0px 10px 20px 0px rgba(0,0,0,0.3);-moz-box-shadow: 0px 10px 20px 0px rgba(0,0,0,0.3);box-shadow: 0px 10px 20px 0px rgba(0,0,0,0.3);}

#gnb .keyword_list_v2 h5{color:#000;font-size: 15px;font-weight:bold;}
#gnb .keyword_list_v2 .keyword_close {display:none; position:absolute;top: 17.5px;width:20px;height:20px;right: 33px;text-indent:-9999px;background:url('http://image.kyobobook.co.kr/newimages/giftshop_new/resources/img/common/btn_closeb_top.png') 50% 50% no-repeat;}
#gnb .keyword_list_v2 ul{margin-top: 20px;}
#gnb .keyword_list_v2 ul li{position:relative;background: #fff;}
#gnb .keyword_list_v2 ul li + li{margin-top:20px;}
#gnb .keyword_list_v2 a {display:block;}
#gnb .keyword_list_v2 a > *{display:inline-block; vertical-align:top;}
#gnb .keyword_list_v2 .font_t{width:20px;color: #999;font-size: 12px;padding: 2px 0 0 0;font-weight: normal;vertical-align:top;position: inherit;}
#gnb .keyword_list_v2 p{width:70%;font-size: 14px;/* margin: 10px 0 0 0; */line-height: 14px;color:#000;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;}
#gnb .keyword_list_v2 span{position:absolute;min-width: 26px;text-align:center;padding-top:7px;right:20px;font-size: 8px;vertical-align:top;box-sizing:border-box;font-family:font_gs, sans-serif;}
#gnb .keyword_list_v2 .new{font-weight:bold;color: #000000;letter-spacing: -0.1em;}
#gnb .keyword_list_v2 .num{padding-top: 6px;}
#gnb .keyword_list_v2 .num:before{content:'';position:absolute;right:50%;margin-right: -5px;top: -2px;width: 10px;height: 6px;}
#gnb .keyword_list_v2 .num.up:before{background:url('../../images/biz/common/icon_updown.png') no-repeat;background-size: 20px 6px;}
#gnb .keyword_list_v2 .num.down:before{background:url('../../images/biz/common/icon_updown.png') no-repeat;background-size: 20px 6px;background-position: -10px 0;}
#gnb .keyword_list_v2 .txt{color: #777;font-size: 12px;padding-top: 10px;}
#gnb .keyword_list_v2 .txt strong{font-weight: normal; font-family: 'font_gs', 'AppleGothic', sans-serif;}

</style>
<script type="text/javascript">
jQuery(function($){
	var ticker = function(){
	        timer = setTimeout(function(){
	            $('#ticker a:first').animate( {marginTop: '-34px'}, 400, function()
	            {
	                $(this).detach().appendTo('#ticker').removeAttr('style');
	            });
	            ticker();
	        }, 2000);         
	};
	var autoplay = true;
    ticker();
    
    /*var chkInt = sessionStorage.getItem('chkInt');
    if (chkInt && chkInt<5) {
			sessionStorage.setItem('chkInt', (parseInt(chkInt)+1));
			$("input[name=exLink]").val($("input[name=exLink"+(parseInt(chkInt)+1)+"]").val());
			$("input[name=exTxt]").val($("input[name=exTxt"+(parseInt(chkInt)+1)+"]").val());
			$("input[name=searchTerm]").attr("placeholder",$("input[name=exTxt"+(parseInt(chkInt)+1)+"]").val());
	}else{
	    sessionStorage.setItem('chkInt', 1);
	}*/

});
$(document).ready(function(){
    $(".keyword_wrap").mouseover(function(){
      $(".keyword_list_v2").show();
    });
    $(".keyword_list_v2").mouseover(function(){
      $(".keyword_list_v2").show();
    });
    $(".keyword_list_v2").mouseout(function(){
      $(".keyword_list_v2").hide();
    });
    $('.keyword_close').click(function(){
      $('.keyword_list_v2').hide();
    });
});
function gnbSearchKerword(keyword){
	document.location.href="/ht/biz/bizSearchMain?searchTerm="+keyword;
};
</script>
<!-- header -->
<div id="header">
	<!-- util menu -->
	<div class="util_menu">
		<ul>
			<li class="gnbLoginStat PC_MAIN_TOP_8_N" style="display:none;"><a href="${defaultHost}/ht/user/logout">로그아웃</a></li>
			<li class="gnbLoginStat PC_MAIN_TOP_9_N" style="display:none;"><a href="${defaultHost}/ht/mypage/mypageMain">마이핫트랙스</a></li>
			<li class="gnbLogoutStat PC_MAIN_TOP_2_N" style="display:none;"><a href="javascript://" onclick="login()">로그인</a></li>
			<li class="gnbLogoutStat PC_MAIN_TOP_3_N" style="display:none;"><a href="${defaultHost}/ht/biz/mypage/loginForm?returnUrl=http://www.hottracks.co.kr/ht/mypage/mypageMain">주문조회</a></li>
<!-- 			<li class="gnbLogoutStat PC_MAIN_TOP_4" style="display:none;"><a href="javascript://" onclick="goMemJoin()">회원가입</a></li> -->
			<li class="icon_topcart PC_MAIN_TOP_14_N"><a href="${defaultHost}/ht/order/cart">장바구니<c:if test="${cartCount > 0}"><em class="font_t">${cartCount}</em></c:if></a></li>
			<li class="PC_MAIN_TOP_5_N"><a href="${defaultHost}/ht/help/helpMain">고객센터</a></li>
			<li class="PC_MAIN_TOP_7_N"><a href="${defaultHost}/company/story/sign" target="_blank">팬사인회</a></li>
			<li class="PC_MAIN_TOP_6_N"><a href="${defaultHost}/company/main/" target="_blank">매장안내</a></li>
		</ul>
	</div>
	<!--// util menu -->
	<!-- gnb -->
       <nav id="gnb">
		<div class="header_wrap">
			<h1 class="g_logo PC_MAIN_TOP_10"><a href="${defaultHost}/ht/biz/welcomeMain">HOTTRACKS</a></h1>
			<!-- 신규 수정추가 -->
			<ul class="gnb_bmenu">
				<c:if test="${not empty gnbTitleList}">
					<c:forEach items="${gnbTitleList}" var="l" varStatus="st">
						<c:choose>
							<c:when test="${st.first}">
                      			<li class="PC_MAIN_GNB_12_N"><a href="${defaultHost}${l.bnrLnkUrl}">
									${l.bnrTitle}
                      			<em></em></a></li>
							</c:when>
							<c:when test="${st.last}">
                      			<li class="PC_MAIN_GNB_13_N"><a href="${defaultHost}${l.bnrLnkUrl}">
									${l.bnrTitle}
                      			<em></em></a></li>
							</c:when>
							<c:otherwise>
                      			<li class="PC_MAIN_GNB_15_N"><a href="${defaultHost}${l.bnrLnkUrl}">
                      				${l.bnrTitle}
                      			<em></em></a></li>
							</c:otherwise>
						</c:choose>
                    </c:forEach>
                </c:if>
                      <li class="PC_MAIN_GNB_2_N"><a href="${defaultHost}/ht/biz/record/recordCategoryMain?ctgrId=0003">음반</a></li>
            </ul>
			
			<div class="g_search">
                <c:if test="${not empty listTrendKeyword}">
	                <c:forEach items="${listTrendKeyword}" var="l" varStatus="st">
	                    <c:if test="${l.prevRank ne 2 || l.prevRank ne 3}"><c:set var="krywordsUrl" value="/e/${l.requested}"/></c:if>
	                    <c:if test="${l.prevRank eq 2}"><c:set var="krywordsUrl" value="/p/${l.requested}"/></c:if>
	                    <c:if test="${l.prevRank eq 3}"><c:set var="krywordsUrl" value="/b/${l.requested}"/></c:if>
	                    <c:set var="keywords" value="${l.keyword}"/>
		                <input type="hidden" name="exLink${st.count}" value="${krywordsUrl}"/>
		                <input type="hidden" name="exTxt${st.count}" value="${keywords}"/>
	                </c:forEach>
                </c:if>
				<form name="gnbSearchForm" action="/ht/biz/bizSearchMain" method="post" onsubmit="return false;">
                <input type="hidden" name="exLink" value="${krywordsUrl}"/>
                <input type="hidden" name="exTxt" value="${keywords}"/>
					<div class="form_search">
						<input type="text" name="searchTerm" value="" placeholder="" title="검색어 키워드" autocomplete="off" >
 						<div class="PC_MAIN_TOP_11_N"> 
							<a href="#" class="btn_search" onclick="gnbSrchFrm();return false;"></a>
 						</div>
					</div>
				</form>
				<script type="text/javascript">
					$("input[name=exLink]").val($("input[name=exLink1]").val());
					$("input[name=exTxt]").val($("input[name=exTxt1]").val());
					$("input[name=searchTerm]").attr("placeholder",$("input[name=exTxt1]").val());
				</script>
				<div class="keyword_wrap" id="ticker">
					<c:if test="${not empty listBestKeyword}">
						<c:forEach items="${listBestKeyword}" var="l" varStatus="st">
							<a href="javascript:;" onclick="gnbSearchKerword('${l.keyword}');return false;" class="PC_MAIN_TOP_12_N">
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
						</c:forEach>
					</c:if>
				</div>
			</div>
			
			<!-- 인기검색레이어 -->
			<c:if test="${not empty listBestKeyword}">
			<c:set var="now" value="<%=new java.util.Date()%>" />
	            <div class="keyword_list_v2">
		            <h5>인기 검색어</h5>
		            <p class="txt"><strong><fmt:formatDate value="${now}" pattern="yyyy.MM.dd HH:00" /></strong> 기준</p>
		            <a href="#none" class="keyword_close">닫기</a>
		            <ul>
		            	<c:forEach items="${listBestKeyword}" var="l" varStatus="st">
		            		<li>
								<a href="javascript:;" onclick="gnbSearchKerword('${l.keyword}');return false;" class="PC_MAIN_TOP_12_N">
									<em class="font_t">${st.count}.</em>
									<p>${l.keyword}</p>
									<!-- ▲ up , ▼ down : class 추가 -->
									<c:choose>
										<c:when test="${l.prevRank == 0}">
											<span class="new">NEW</span>
										</c:when>
										<c:when test="${(l.prevRank - l.ranking) == 0}">
											<span>-</span>
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
	            </div>
			</c:if>
			
			<div class="g_menu">
				<ul>
					<li class="icon_my">
						<a class="gnbLoginStat" style="display:none;" href="${defaultHost}/ht/mypage/mypageMain"><img src="/images/biz/common/icon_my.png" alt=""></a>
						<a class="gnbLogoutStat" style="display:none;" href="javascript://" onclick="login()"><img src="/images/biz/common/icon_my.png" alt=""></a>																						
					</li>
					<li class="icon_today">
						<a href="${defaultHost}/ht/biz/mypage/todayBenefit" class="PC_MAIN_TOP_13">
							<img src="/images/biz/common/icon_today.png" alt="">
							<em>오늘,<strong>혜택</strong></em>
						</a>
					</li>
					<li class="icon_cart">
						<a href="${defaultHost}/ht/order/cart" class="PC_MAIN_TOP_14">
							<img src="/images/biz/common/icon_cart.png" alt="">
							<c:if test="${cartCount > 0}"><em class="font_t">${cartCount}</em></c:if>
						</a>
					</li>
				</ul>
			</div>
		</div>
		<div class="gnb_wrap">
			<div class="inner">
				<div class="category_wrap">
					<div class="btn_category PC_MAIN_GNB_1">
						<a href="javascript:;">카테고리</a>
					</div>
					<div class="category_cont">
						<ul>
							<li class="PC_SIDE_CATE_1">
								<a href="/ht/biz/gift/giftCategoryMain?ctgrId=000020" class="dp1" value="000020">디자인문구</a>								
							</li>
							<li class="PC_SIDE_CATE_1">
								<a href="/ht/biz/gift/giftCategoryMain?ctgrId=000022" class="dp1" value="000022">디지털</a>
							</li>
							<li class="PC_SIDE_CATE_1">
								<a href="/ht/biz/gift/giftCategoryMain?ctgrId=000007" class="dp1" value="000007">고급필기구</a>
							</li>
							<li class="PC_SIDE_CATE_1">
								<a href="/ht/biz/gift/giftCategoryMain?ctgrId=000021" class="dp1" value="000021">오피스</a>
							</li>
							<li class="PC_SIDE_CATE_1">
								<a href="/ht/biz/gift/giftCategoryMain?ctgrId=000025" class="dp1" value="000025">리빙/생활가전</a>
							</li>
							<li class="PC_SIDE_CATE_1">
								<a href="/ht/biz/gift/giftCategoryMain?ctgrId=000026" class="dp1" value="000026">키친/푸드</a>
							</li>
							<li class="PC_SIDE_CATE_1">
								<a href="/ht/biz/gift/giftCategoryMain?ctgrId=000024" class="dp1" value="000024">가구/수납</a>
							</li>
							<li class="PC_SIDE_CATE_1">
								<a href="/ht/biz/gift/giftCategoryMain?ctgrId=000028" class="dp1" value="000028">패션잡화</a>
							</li>
							<li class="PC_SIDE_CATE_1">
								<a href="/ht/biz/gift/giftCategoryMain?ctgrId=000006" class="dp1" value="000006">뷰티/헬스</a>
							</li>
							<li class="PC_SIDE_CATE_1">
								<a href="/ht/biz/gift/giftCategoryMain?ctgrId=000027" class="dp1" value="000027">여행/자동차</a>
							</li>
							<li class="PC_SIDE_CATE_1">
								<a href="/ht/biz/gift/giftCategoryMain?ctgrId=000023" class="dp1" value="000023">취미/펫</a>
							</li>
							<li class="PC_SIDE_CATE_1">
								<a href="/ht/biz/gift/giftCategoryMain?ctgrId=000029" class="dp1" value="000029">유아동</a>
							</li>
<!-- 							<li> -->
<!-- 								<a href="/ht/biz/eventDetail?eventId=47389" class="dp1 c_call" value="999999">직수입/PB</a> -->
<!-- 							</li> -->
							<li class="PC_SIDE_CATE_1">
								<a href="/ht/biz/record/recordCategoryMain?ctgrId=0003" class="dp1" value="0003">CD/LP</a>
							</li>
							<li class="PC_SIDE_CATE_1">
								<a href="/ht/biz/record/dvdCategoryMain?ctgrId=000401" class="dp1" value="000401">DVD/BLU-RAY</a>
							</li>
						</ul>
						<div class="banner PC_SIDE_CATE_IMG" id="gnbLbrnImgDiv">
<!-- 							<a href="#"><img src="" alt=""></a>								 -->
						</div>
					</div>
				</div>
				<ul class="gnb_menu">
					<li class="PC_MAIN_GNB_8_N"><a id="gnbEvent" href="${defaultHost}/ht/biz/hotEventMain">이벤트</a></li>
					<li class="PC_MAIN_TOP_13_N"><a id="gnbTodayBenefit" href="${defaultHost}/ht/biz/mypage/todayBenefit">쿠폰&amp;혜택</a></li>
					<li class="PC_MAIN_GNB_9_N"><a id="gnbPersonalRecommend" href="${defaultHost}/ht/biz/personal/personalRecommend">추천</a></li>
					<li class="PC_MAIN_GNB_4_N"><a id="gnbBest" href="${defaultHost}/ht/biz/welcome/hotAwardPage">베스트</a></li>
					<li class="PC_MAIN_GNB_5_N"><a id="gnbFree" href="${defaultHost}/ht/biz/welcome/hotFreeDeliveryPage">무료배송</a></li>
					<li class="PC_MAIN_GNB_6_N"><a id="gnbNew" href="${defaultHost}/ht/biz/welcome/hotAwardRecentPage">신상</a></li>
					<li class="PC_MAIN_GNB_7_N"><a id="gnbSale" href="${defaultHost}/ht/biz/welcome/hotAwardPage?dispMstrId=CATE_GFT_SALE">할인</a></li>
				</ul>
				<ul class="sub_menu">
					<li class="PC_MAIN_GNB_10_N"><a id="gnbLifeMain" href="${defaultHost}/ht/biz/life/lifeMain">이럴 때,</a></li>
					<li class="PC_MAIN_GNB_11_N"><a id="gnbAgit" href="${defaultHost}/ht/biz/agit">아지트</a></li>
					<li class="PC_MAIN_GNB_14_N"><a id="gnbNews" href="${defaultHost}/ht/idol/news">뮤직매거진</a></li>
				</ul>
			</div>
		</div>
	</nav>
</div>
<!--// header -->
<script type="text/javascript">
var vid = getCookie('UserCookieKey');
if (isEmpty(vid)) {//로그인이 안되있으면
    $('.gnbLogoutStat').show();
    $('.gnbLoginStat').hide();
} else {
    $('.gnbLogoutStat').hide(); 
    $('.gnbLoginStat').show();
    $(".gnbMypageBtn").find(".inner").addClass("member");
}
</script>