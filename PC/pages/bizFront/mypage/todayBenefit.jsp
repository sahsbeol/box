<%@ page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<!-- 태그 라이브러리 -->
<%@ include file="/pages/decorators/biz/tagHeader.jsp" %>

<!-- 데코레이터에 있는 #container 요소에 클래스를 추가하기 위해 -->
<meta name="container" content="product"/>

<script type="text/javascript">
	$(document).ready(function(){
		$("#gnbTodayBenefit").addClass("on");
		obj.init();
		
		//오늘의 특가가 있을떄
	    if($(".today_sale").length > 0){ 
	        /* timer start */
	        obj.today = new Date();
	        
		    obj.changeTime();
		    obj.timer = setInterval(obj.changeTime, 1000);
	    }
	});
	
	var obj = {
		 today : new Date()
		,init : function(){			
			cardSlider();
		}
		,changeTime : function(){
			var now = new Date();
		    var end = new Date();
		    
		    end.setHours(23);
		    end.setMinutes(59);
		    end.setSeconds(59);
		    
		    var H = end.getHours() - now.getHours();
		    var M = end.getMinutes() - now.getMinutes();
		    var S = end.getSeconds() - now.getSeconds();

		    if((now.getDate() - obj.today.getDate()) > 0){
		        //alert("현재 시각 정시 기준으로\n원데이 특가가 업데이트 되었습니다.");
		        location.replace("/ht/biz/mypage/todayBenefit?"+H+M+S);
		    }
		    $("#txtOddTime").html(lpad(H, 2, '0') + ":" + lpad(M, 2, '0') + ":" + lpad(S, 2, '0'));
		}
	};
</script>

<div class="benefit_wrap">
	<div class="box_benefit <c:if test='${!isLogin}'>non</c:if>member"><!-- 회원은 memeber, 비회원은 nonmember : class 추가 -->
		<div class="aside_area">
			<h2>
				<c:set var="uName" value="${loginUser.name}" />
				<c:if test="${!isLogin}">
					<c:set var="uName" value="회원" />
				</c:if>
				<span>${uName}</span>
				<span>님의</span> <b>오늘,혜택</b>
			</h2>
			<ul class='list_advantage'>
				<li>
					<p>멤버십혜택</p>
					<a href="/ht/help/memberShip"></a>
				</li>
				<li>
					<p>월간혜택</p>
					<a href="/e/66843"></a>
				</li>
				<li>
					<p>구매사은품</p>
					<a href="/ht/biz/mypage/payGifts"></a>
				</li>
				<li>
					<p>이벤트 당첨자 발표</p>
					<a href="/ht/help/eventPrizeList"></a>
				</li>
				<li>
					<p>나의 이벤트 응모내역</p>
					<a href="/ht/mypage/myEventList"></a>
				</li>
			</ul>
		</div>
		
		<div class="<c:if test='${!isLogin}'>non</c:if>member_area clear">
			<!-- ///////////비회원/////////// -->
			<c:if test='${!isLogin}'>
			    <a href="javascript:;" onclick="login();return false;">
                    <h2>핫트랙스가 &nbsp;<em>처음</em>인<br> 당신을 위한 <em>혜택</em></h2>
                    <dl class='clear'>
                        <dt>무료배송</dt>
                        <dd>X <span class='font_t'>1</span> 장</dd>
                    </dl>
                    <dl class='clear'>
                        <dt>5 천원</dt>
                        <dd>X <span class='font_t'>1</span> 장</dd>
                    </dl>
                    <dl class='clear'>
                        <dt>1 만원</dt>
                        <dd>X <span class='font_t'>1</span> 장</dd>
                    </dl>
                    <p>첫구매 쿠폰의 할인혜택과 함께<br> 지금 쇼핑을 시작해보세요.</p>
                    <div class="go_link">
                        <img src="/images/biz/sub/benefit/arr_s_wh.png" alt="바로가기">
                    </div>
				</a>
			</c:if>
			<!-- //비회원 -->
			
			<!-- ///////////회원/////////// -->
			<c:if test='${isLogin}'>
				<div class="top_member">
					<ul class='list_mine clear'>
						<li>
							<img src="/images/biz/sub/benefit/ic_coupon_wh.png" alt="보유쿠폰">
							<p>나의 보유 쿠폰</p>
							<strong class='font_t clear'><fmt:formatNumber type="number" value="${couponCount}"/></strong>
							<a href="javascript:" onclick="location.href='/ht/mypage/coupon';return false;"></a>
						</li>
						<li>
							<img src="/images/biz/sub/benefit/ic_down_wh.png" alt="보유쿠폰">
							<p>다운로드 가능한 상품쿠폰</p>
							<strong class='font_t clear'><fmt:formatNumber type="number" value="${downCouponCount}"/></strong>
							<a href="/ht/biz/mypage/nowDownloadCoupon"></a>
						</li>
						<li>
							<img src="/images/biz/sub/benefit/ic_write_wh.png" alt="보유쿠폰">
							<p>작성 가능한 상품평</p>
							<strong class='font_t clear'><fmt:formatNumber type="number" value="${cntTargetReview}"/></strong>
							<a href="javascript:" onclick="location.href='/ht/mypage/orderDelivery';return false;"></a>
						</li>
					</ul>
				</div>
				
				<p class='comment'>쇼핑 후, 상품평 작성하고 최대 <span class="font_ns">25% 쿠폰</span>혜택을 누리세요!</p>
				<div class="bot_member">
					<h2>상품평 적립 기준</h2>
					<ul class='list_saving clear'>
						<li>
							<div class="saving_point">
								<em class='font_t'>200P</em>
							</div>
							<p>포토 상품평</p>
						</li>
						<li>
							<div class="saving_point">
								<em class='font_t'>100P</em>
							</div>
							<p>텍스트 상품평</p>
						</li>
						<li class='win'>
							<div class="saving_point">
								<em style="line-height: 117px;">
								    <i class="font_t">25%</i>
								    <i class="font_ns mgl4m">쿠폰</i>
								</em>
								<span>매월 100명</span>
							</div>
							<p>월간 후기왕 선정</p>
						</li>
					</ul>
					<ul class='list_info'>
						<li><p>구매 후 3개월 이내 작성 시, 포인트 적립 가능</p></li>
						<li><p>상품평 작성 후, 익일 PM 11시 이후 적립</p></li>
						<li><p>포인트 적립 제외 대상 (1천원 미만 또는 CD/DVD 관련 상품)</p></li>
						<li><p>무관한 포토후기 업로드 시 적립금 지급 제외될 수 있습니다.</p></li>
					</ul>
				</div>
			</c:if>	
			<!-- //회원 -->
		</div>
	</div>

	<div class="box_bargain">
		<!-- /////////오늘만 특가///////// -->
		<c:if test="${not empty hotdeal}">
			<div class="today_sale">
				<h2>오늘만 특가</h2>
				<div class="timer_inner">
					<div class="time_terr">
						<span>종료까지</span>
						<strong class='font_t' id="txtOddTime"></strong>
						<em><ui:image src="${hotdeal.productImageUrl}" size="400" server="product" alt="${hotdeal.prdtName}"/></em>
					</div>
					<div class="price_terr">
						<div class='cont_sale'>
	                        <dl class='clear'>
	                           <dt class='dt_product'>
	                           		<c:if test="${hotdeal.freeDlvyYn == 'Y'}">
	                           			<span>무료배송</span>
	                           		</c:if> ${hotdeal.prdtName}
	                           	</dt>
	                        	<c:choose>
									<c:when test="${not empty hotdeal.prdtDscntRate and hotdeal.prdtDscntRate ne '0'}">
										<fmt:parseNumber var="rate" integerOnly="true" value="${hotdeal.prdtDscntRate}"/>
									</c:when>
									<c:otherwise>
										<fmt:parseNumber var="rate" integerOnly="true" value="${hfn:rate(hotdeal.prdtSellPrice, hotdeal.lastCpnPrice)}"/>
									</c:otherwise>
								</c:choose>
								<c:if test="${rate > 0}">
	                           		<dd class='font_t'>~${rate}%</dd>
	                           	</c:if>
	                        </dl>
	                        <dl class='clear'>
	                        	<fmt:parseNumber var="price" value="${hotdeal.prdtSellPrice}"/>
	                        	<c:if test="${not empty hotdeal.prdtDscntRate and hotdeal.prdtDscntRate ne '0'}">
									<dt class='dt_price font_t'><fmt:formatNumber type="number" value="${hotdeal.prdtSellPrice}"/></dt>
									<fmt:parseNumber var="price" value="${hotdeal.prdtSellPrice * (hotdeal.prdtDscntRate / 100)}"/>
									<fmt:parseNumber var="price" integerOnly="true" value="${price+(1-(price%1))%1}"/>		<%-- 반올림후 정수 --%>		
									<fmt:parseNumber var="price" value="${hotdeal.prdtSellPrice - price}"/>				
								</c:if>
<%-- 	                        	<c:if test="${hotdeal.prdtSellPrice ne hotdeal.lastCpnPrice}"> --%>
<%-- 		                             <dt class='dt_price font_t'><fmt:formatNumber type="number" value="${hotdeal.prdtSellPrice}"/></dt> --%>
<%-- 		                        </c:if> --%>
	                            <dd class='dd_price font_t'><fmt:formatNumber type="number" value="${hotdeal.lastCpnPrice}"/></dd>
	                        </dl>
	                    </div>
					</div>
					<c:choose>
						<c:when test="${not empty hotdeal.eventId}">
							<c:set var="linkUrl" value="/ht/biz/eventDetail?eventId=${hotdeal.eventId}"/>
						</c:when>
						<c:otherwise>
							<c:set var="linkUrl" value="/m/gift/detail/${hotdeal.sellPrdtBcode}"/>
						</c:otherwise>
					</c:choose>
					<a href="javascript:;" onclick="location.href='${linkUrl}';return false;"></a>
				</div>
			</div>
		</c:if>
		<!-- //오늘만 특가 -->
		
		<div class="special_sale">
			<div class="special_deal">
				<img src="/images/biz/sub/benefit/ico_sale.png" alt="할인상품">
				<h2>지금 할인중인 상품</h2>
<%-- 				<p><em class='font_t'><fmt:formatNumber type="number" value="${todaySalePrdtCnt}"/></em>개</p> --%>
				<!-- <a href="/ht/biz/mypage/todayNewSale"></a> -->
				<a href="/ht/biz/welcome/hotAwardPage?dispMstrId=CATE_GFT_SALE"></a>
			</div>
			<div class="special_deal">
				<img src="/images/biz/sub/benefit/ico_ship.png" alt="할인상품">
				<h2>지금 무료배송 상품</h2>
<%-- 				<p><em class='font_t'><fmt:formatNumber type="number" value="${todayFreeDlvPrdtCnt}"/></em>개</p> --%>
				<!-- <a href="/ht/biz/mypage/todayFreeDelivery"></a> -->
				<a href="/ht/biz/welcome/hotFreeDeliveryPage"></a>
			</div>
		</div>
	</div>
</div>

<c:if test="${not empty cardBnrList}">
	<div class="card_wrap">
		<div class="card_inner">
			<h2>구매혜택</h2>
			<div class="card_slider">
				<ul>
					<c:forEach items="${cardBnrList}" var="l" varStatus="st">
						<li>
							<a href="${l.bnrLinkUrl}">
								<ui:image src="${l.imageUrlPc}" alt="${l.imageAlt}"/>
							</a>
						</li>
					</c:forEach>
				</ul>
			</div>
		</div>
	</div>
</c:if>

<c:if test="${not empty todayEventList}">
	<div class="benefit_wrap new_event">
		<a href='javascript:' onclick="location.href='/ht/biz/hotEventMain';return false;" class='tit_event'>오늘의 이벤트</a>
		<div class="pd_filter" style="visibility: hidden">
			<p class="pd_total"><em class="font_t"><fmt:formatNumber type="number" value="${todayEventCnt}"/></em>건 진행중</p>
		</div> 
		<div class="event_cont">
			<!-- 이벤트 목록 -->
			<div class="event_banner">
				<ul>
					<c:forEach items="${todayEventList}" var="l" varStatus="st">
						<li>
							<a href="javascript:;" onclick="location.href='/ht/biz/eventDetail?eventId=${l.eventId}';return false;">
							    <!-- 컬처이벤트의 경우 class 추가 culture -->
								<div class="img_wrap <c:if test="${l.cultZoneYn eq 'Y'}">culture</c:if>">
									<ui:image src="${l.eventImageUrl}" size="400" alt="${l.eventTitle}"/>
								</div>
								<strong>${l.eventTitle}</strong>
								<p>${l.eventDtlCont}</p>
							</a>
						</li>
					</c:forEach>
				</ul>
			</div>
			<!--// 이벤트 목록 -->
		</div>
	</div>
</c:if>
<c:import url="/menu/biz/quickMenu"/>