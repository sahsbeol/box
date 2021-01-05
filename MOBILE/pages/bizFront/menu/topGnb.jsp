<%@ page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<!-- 태그 라이브러리 -->
<%@ include file="/pages/decorators/biz/tagHeader.jsp" %>
<ui:decorator name="none"/>
<script type="text/javascript">
jQuery(function($)
		{
		    var ticker = function()
		    {
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
		});
</script>
<!-- header -->
<div id="header">
	<!-- util menu -->
	<div class="util_menu">
		<ul>
			<c:choose>				
				<c:when test="${not empty loginOrderNum}">
					<li><a href="${defaultHost}/ht/mypage/mypageMain">마이핫트랙스</a></li>
				</c:when>				
				<c:otherwise>
					<li><a href="javascript://" onclick="login()">로그인</a></li>
					<li><a href="javascript://" onclick="goMemJoin()">회원가입</a></li>
				</c:otherwise>
			</c:choose>
			<li><a href="${defaultHost}/ht/help/helpMain">고객센터</a></li>
			<li><a href="${defaultHost}/company/main/">매장안내</a></li>
			<li><a href="${defaultHost}/company/story/sign">팬사인회</a></li>
		</ul>
	</div>
	<!--// util menu -->
	<!-- gnb -->
       <nav id="gnb">
		<div class="header_wrap">
			<h1 class="g_logo"><a href="${defaultHost}/ht/biz/welcomeMain">HOTTRACKS</a></h1>
			<div class="g_search">
				<form name="gnbSearchForm" action="/ht/biz/bizSearchMain" method="post" onsubmit="return false;">
					<div class="form_select">
						<select id="gnbSearchMenu" name="gnbSearchMenu">
							<option value='GIFT'>문구/기프트</option>
							<option value='RECORD'>음반</option>						
						</select>
					</div>				
					<div class="form_search">
						<input type="text" placeholder="샤오미를 쓰는 이유" name="searchTerm" value="${keywords}">
						<a href="#" class="btn_search" onclick="gnbSrchFrm();return false;"></a>
					</div>
				</form>
				<div class="keyword_wrap" id="ticker">
				<c:if test="${not empty listBestKeyword}">
				<c:forEach items="${listBestKeyword}" var="l" varStatus="st">
					<a href="javascript:;" onclick="gnbSrchKerword('${l.keyword}');return false;">
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
			<div class="g_menu">
				<ul>
					<li class="icon_my">
						<c:choose>				
							<c:when test="${not empty loginOrderNum}">								
								<a href="${defaultHost}/ht/mypage/mypageMain"><img src="/images/biz/common/icon_my.png" alt=""></a>
							</c:when>				
							<c:otherwise>
								<a href="javascript://" onclick="login()"><img src="/images/biz/common/icon_my.png" alt=""></a>
							</c:otherwise>
						</c:choose>																								
					</li>
					<li class="icon_today">
						<a href="${defaultHost}/ht/biz/mypage/todayBenefit">
							<img src="/images/biz/common/icon_today.png" alt="">
							<em>오늘,<strong>혜택</strong></em>
						</a>
					</li>
					<li class="icon_cart">
						<a href="${defaultHost}/ht/order/cart">
							<img src="/images/biz/common/icon_cart.png" alt="">
							<em class="font_t bizCartCount"></em>
						</a>
					</li>
				</ul>
			</div>
		</div>
		<div class="gnb_wrap">
			<div class="inner">
				<div class="category_wrap">
					<div class="btn_category">
						<a href="#">카테고리</a>
					</div>
					<div class="category_cont">
						<ul>
							<li>
								<a href="/ht/biz/gift/giftCategoryMain?ctgrId=000020" class="dp1" value="000020">디자인문구</a>								
							</li>
							<li>
								<a href="/ht/biz/gift/giftCategoryMain?ctgrId=000022" class="dp1" value="000022">디지털</a>
							</li>
							<li>
								<a href="/ht/biz/gift/giftCategoryMain?ctgrId=000007" class="dp1" value="000007">고급필기구</a>
							</li>
							<li>
								<a href="/ht/biz/gift/giftCategoryMain?ctgrId=000021" class="dp1" value="000021">오피스</a>
							</li>
							<li>
								<a href="/ht/biz/gift/giftCategoryMain?ctgrId=000025" class="dp1" value="000025">리빙/생활가전</a>
							</li>
							<li>
								<a href="/ht/biz/gift/giftCategoryMain?ctgrId=000026" class="dp1" value="000026">키친/푸드</a>
							</li>
							<li>
								<a href="/ht/biz/gift/giftCategoryMain?ctgrId=000024" class="dp1" value="000024">가구/수납</a>
							</li>
							<li>
								<a href="/ht/biz/gift/giftCategoryMain?ctgrId=000028" class="dp1" value="000028">패션잡화</a>
							</li>
							<li>
								<a href="/ht/biz/gift/giftCategoryMain?ctgrId=000006" class="dp1" value="000006">뷰티/헬스</a>
							</li>
							<li>
								<a href="/ht/biz/gift/giftCategoryMain?ctgrId=000027" class="dp1" value="000027">여행/자동차</a>
							</li>
							<li>
								<a href="/ht/biz/gift/giftCategoryMain?ctgrId=000023" class="dp1" value="000023">취미/펫</a>
							</li>
							<li>
								<a href="/ht/biz/gift/giftCategoryMain?ctgrId=000029" class="dp1" value="000029">유아동</a>
							</li>
							<li>
								<a href="/ht/hot/eventDetail?eventId=47389" class="dp1 c_call" value="999999">직수입/PB</a>
							</li>
							<li>
								<a href="/ht/biz/record/recordCategoryMain?ctgrId=0003" class="dp1" value="0003">CD/LP</a>
							</li>
							<li>
								<a href="/ht/biz/record/dvdCategoryMain?ctgrId=000401" class="dp1" value="000401">DVD/BLU-RAY</a>
							</li>
						</ul>
						<div class="banner" id="gnbLbrnImgDiv">
<!-- 							<a href="#"><img src="" alt=""></a>								 -->
						</div>
					</div>
				</div>
				<ul class="gnb_menu">
					<li><a href="${defaultHost}/ht/biz/welcomeMain">다이어리<em></em></a></li>
					<li><a href="${defaultHost}/ht/biz/welcomeMain">음반<em></em></a></li>
					<li><a href="${defaultHost}/ht/biz/welcomeMain">특가딜</a></li>
					<li><a id="gnbBest" href="${defaultHost}/ht/biz/welcome/hotAwardPage">베스트</a></li>
					<li><a id="gnbFree" href="${defaultHost}/ht/biz/welcome/hotFreeDeliveryPage">무료배송</a></li>
					<li><a id="gnbNew" href="${defaultHost}/ht/biz/welcome/hotAwardRecentPage">신상품</a></li>
					<li><a id="gnbSale" href="${defaultHost}/ht/biz/welcome/hotAwardPage?dispMstrId=CATE_GFT_SALE">세일</a></li>
					<li><a href="${defaultHost}/ht/biz/hotEventMain">이벤트</a></li>
				</ul>
				<ul class="sub_menu">
					<li><a href="${defaultHost}/ht/biz/personal/personalRecommend">개인의취향</a></li>
					<li><a href="${defaultHost}/ht/biz/welcomeMain">라이프</a></li>
					<li><a href="${defaultHost}/ht/biz/welcomeMain">아지트</a></li>
				</ul>
			</div>
		</div>
	</nav>
</div>
<!--// header -->
<script type="text/javascript">
jQuery(function($){

});
</script>