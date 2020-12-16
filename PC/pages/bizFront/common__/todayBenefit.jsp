<%@ page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<!-- 태그 라이브러리 -->
<%@ include file="/pages/decorators/biz/tagHeader.jsp" %>

<ui:decorator name="none"/>
<script type="text/javascript">
	var obj = {
		 today : new Date()
		,init : function(){
            benefitFn(); //slide
            
            $(".btn_check > input").off("change");
        	$(".btn_check > input").change(function(){
       			if($(this).is(":checked")){
       				$(this).parent().addClass("set_on");
				}
  				else {
               		$(this).parent().removeClass("set_on");
 				}
           		obj.syncData();
        	});
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
		        alert("현재 시각 정시 기준으로\n원데이 특가가 업데이트 되었습니다.");
		        location.replace("/m/biz/welcomeMain?"+H+M+S);
		    }
		    $("#txtOddTime2").html(lpad(H, 2, '0') + ":" + lpad(M, 2, '0') + ":" + lpad(S, 2, '0'));
		}
		,syncData : function(){
		    var adAltRcvYn = $("#btnAdAltRcvYn").hasClass("set_on")?"N":"Y";

		    $.ajax({
		        type: "POST"
		        ,url: "/m/biz/dev/syncData"
		        ,dataType: "json"
		        ,async: false
		        ,data : {
		            devId : "${device.devId}"
		          , gcmKey : "${device.gcmKey}"
		          , devVersion : "${device.devVersion}"
		          , adAltRcvYn : adAltRcvYn
		        }
		        ,success : function(data){
		            //console.log("save");
		        } 
		        ,error: function(data) {
		            //console.log("fail");
		        }
		    });
		}
	};
	
	$(document).ready(function(){	
	    obj.init();
	    
		//오늘의 특가가 있을떄
    	if($("#benefit_wrapper .timer_inner").length > 0){ 
        	/* timer start */
        	obj.today = new Date();
        
	    	obj.changeTime();
	    	obj.timer = setInterval(obj.changeTime, 1000);
    	}
	});
</script>


<div class='benefit_wrap'>
	<div class='tit_benefit'>
		<c:set var="uName" value="${user.userName}" />
		<c:if test="${!isLogin}">
			<c:set var="uName" value="회원" />
		</c:if>
     	<h2><span>${uName}님</span>의 오늘,<b>혜택</b></h2>
             	
  		<!-- 앱일때 노출 -->
    	<c:if test="${not empty devInfo}">
         	<p>
         		<c:if test="${!isLogin}">핫트랙스 회원가입 후</c:if>
         		<c:if test="${isLogin}">혹시 놓치고 있지 않으세요?</c:if>
         		<br> <small>알림 수신 시,</small> 더 많은 쿠폰, 상품할인 혜택을 받으실 수 있습니다.
         	</p>
		</c:if>
		<!-- //앱일때 노출 -->
	</div>
	<div class='box_alarm'>
		<!-- 앱일때 노출 -->
		<c:if test="${not empty device}">
			<div class="box_check">
       			<em href="javascript:" class='chk_alarm'>푸시알림</em>
           		<label class="btn_check<c:if test="${!isLogin || device.adAltRcvYn ne 'Y'}"> set_on</c:if>" id="btnAdAltRcvYn">
             		<em>받기</em>
               		<em>괜찮아요</em>
             		<input type="checkbox"<c:if test="${!isLogin || device.adAltRcvYn ne 'Y'}"> checked="true"</c:if>>
					<span></span>
           		</label>
         	</div>
		</c:if>
		<!-- //앱일때 노출 -->
                	
		<!-- ///////////비회원/////////// -->
		<c:if test="${!isLogin}">
			<div class="nonmember_area clear" onclick="join();return false;">
				<a href="javascript:;" onclick="join();return false;">
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
                        <img src="/images/biz/common/arr_wh_s.png" alt="바로가기">
                    </div>
				</a>
			</div>
		</c:if>
		<!-- //비회원 -->
			
		<!-- ///////////회원/////////// -->
		<c:if test='${isLogin}'>
			<ul class='list_coupon'>
          		<li>
                 	<dl class='num_coupon clear'>
                 		<dt><img src="/images/biz/sub/ic_coupon.png" alt="나의 보유 쿠폰">나의 보유 쿠폰</dt>
                     	<dd><em class='font_t'><fmt:formatNumber type="number" value="${couponCount}"/></em> 개</dd>
                	</dl>
					<a href="javascript:" onclick="location.href='/m/mypage/coupon';return false;"></a>
              	</li>
       			<li>
                	<dl class='num_coupon clear'>
                    	<dt><img src="/images/biz/sub/ic_down.png" alt="다운로드 가능한 쿠폰">다운로드 가능한 쿠폰</dt>
                     	<dd><em class='font_t'><fmt:formatNumber type="number" value="${downCouponCount}"/></em> 개</dd>
                	</dl>
					<a href="javascript:" onclick="location.href='/m/biz/mypage/nowDownloadCoupon';return false;"></a>
              	</li>
             	<li>
                  	<dl class='num_coupon clear'>
                    	<dt><img src="/images/biz/sub/ic_comment.png" alt="작성 가능한 상품평">작성 가능한 상품평</dt>
                      	<dd><em class='font_t'><fmt:formatNumber type="number" value="${cntTargetReview}"/></em> 개</dd>
                   	</dl>
					<a href="javascript:" onclick="location.href='/m/mypage/listMyReview';return false;"></a>
           		</li>
        	</ul>
        	<div class='box_comment'>
				<h3>쇼핑 후, 상품평 작성하고<br> 최대 <span><fmt:formatNumber type="number" value="${expectedPoint}"/>ⓟ</span>혜택을 누리세요!</h3>
				<div class="desc_comment">
					<ul class='list_saving clear'>
						<li>
							<div class="saving_point">
								<em class='font_t'>200P</em>
							</div>
							<p>최초 작성시</p>
						</li>
						<li>
							<div class="saving_point">
								<em class='font_t'>100P</em>
							</div>
							<p>상품평 작성시</p>
						</li>
						<li class='win'>
							<div class="saving_point">
								<em class='font_t'>5,000P</em>
								<span>매월 10명</span>
							</div>
							<p>월간후기왕 선정</p>
						</li>
					</ul>
					<h2>[ 상품평 적립 기준 ]</h2>
					<ul class='list_info'>
						<li><p>구매 후 3개월 이내 작성 시, 포인트 적립 가능</p></li>
						<li><p>상품평 작성 후, 익일 PM 11시 이후 적립</p></li>
						<li><p>포인트 적립 제외 대상 (1천원 미만 또는 CD/DVD 관련 상품)</p></li>
					</ul>
				</div>
				<a href="javascript:" class='btn_comment'></a>
			</div>
		</c:if>
		<!-- //회원 -->
	</div>
	
	<c:if test="${not empty moBanner}">
		<div class='box_shade'>
			<ui:image src="${moBanner.imageUrlMo}" alt="${moBanner.imageAlt}"/>
			<a href="${moBanner.bnrLinkUrl}"></a>
		</div>
	</c:if>
		
	<div class='box_benefit'>
		<ul class='list_benefits clear'>
        	<li>
              	<a href="javascript:" onclick="location.href='/m/help/memberShip';return false;"><img src="/images/biz/sub/ic_membership.png" alt="멤버십 혜택">
					멤버십혜택
                </a>
          	</li>
         	<li>
              	<a href="javascript:"><img src="/images/biz/sub/ic_attend.png" alt="출석체크">
					월간혜택
             	</a>
        	</li>
          	<li>
            	<a href="javascript:" onclick="location.href='/m/biz/mypage/payGifts';return false;"><img src="/images/biz/sub/ic_gift.png" alt="사은품">
					구매사은품
           		</a>
     		</li>
		</ul>
		<ul class='list_myevent clear'>
       		<li>
				<a href="javascript:" onclick="location.href='/m/help/listEventPrize';return false;">이벤트 당첨자 발표</a>
           	</li>
           	<li>
				<a href="javascript:" onclick="location.href='/m/mypage/listMyEvent';return false;">이벤트 응모내역</a>
           	</li>
       	</ul>
	</div>
	<div class='timeSale_wrap'>
		<!-- /////////오늘만 특가///////// -->
		<c:if test="${not empty hotdeal}">
			<c:choose>
				<c:when test="${not empty hotdeal.eventId}">
					<c:set var="linkUrl" value="/m/biz/eventDetail?eventId=${hotdeal.eventId}"/>
				</c:when>
				<c:otherwise>
					<c:set var="linkUrl" value="/m/gift/detail/${hotdeal.sellPrdtBcode}"/>
				</c:otherwise>
			</c:choose>
			
      		<h2>오늘의 특가!</h2>
       		<div class='timer_inner'>
        		<em>종료까지</em>
             	<strong class='font_t' id="txtOddTime2"></strong>
             	<span><ui:image src="${hotdeal.productImageUrl}" server="product" alt="${hotdeal.prdtName}"/></span>
              	<a href="javascript:;" onclick="location.href='${linkUrl}';return false;"></a>
         	</div>
  		</c:if>
  		
		<div class='cont_sale'>
			<!-- /////////오늘만 특가///////// -->
			<c:if test="${not empty hotdeal}">
        		<dl class='clear'>
                	<dt class='dt_product'>
                  		<c:if test="${hotdeal.freeDlvyYn == 'Y'}">
                        	<small>무료배송</small>
                       	</c:if> ${hotdeal.prdtName}
                	</dt>
	               	<c:choose>
						<c:when test="${not empty hotdeal.prdtDscntRate and hotdeal.prdtDscntRate ne '0'}">
							<fmt:parseNumber var="rate" integerOnly="true" value="${hotdeal.prdtDscntRate}"/>
						</c:when>
						<c:otherwise>
							<fmt:parseNumber var="rate" integerOnly="true" value="0"/>
	<%-- 										<fmt:parseNumber var="rate" integerOnly="true" value="${hfn:rate(hotdeal.prdtSellPrice, hotdeal.lastCpnPrice)}"/> --%>
						</c:otherwise>
					</c:choose>
					<c:if test="${rate > 0}">
                    	<dd class='font_t'>~${rate}%</dd>
                  	</c:if>
                   	<a href="javascript:;" onclick="location.href='${linkUrl}';return false;"></a>
          		</dl>
              	<dl class='clear'>
              		<fmt:parseNumber var="price" value="${hotdeal.prdtSellPrice}"/>
              		<c:if test="${not empty hotdeal.prdtDscntRate and hotdeal.prdtDscntRate ne '0'}">
						<dt class='dt_price font_t'><fmt:formatNumber type="number" value="${hotdeal.prdtSellPrice}"/></dt>
						<fmt:parseNumber var="price" value="${hotdeal.prdtSellPrice * (hotdeal.prdtDscntRate / 100)}"/>
						<fmt:parseNumber var="price" integerOnly="true" value="${price+(1-(price%1))%1}"/>		<%-- 반올림후 정수 --%>		
						<fmt:parseNumber var="price" value="${hotdeal.prdtSellPrice - price}"/>				
					</c:if>
<%-- 	                  	<c:if test="${hotdeal.prdtSellPrice ne hotdeal.lastCpnPrice}"> --%>
<%-- 		                    <dt class='dt_price font_t'><fmt:formatNumber type="number" value="${hotdeal.prdtSellPrice}"/></dt> --%>
<%-- 		                </c:if> --%>
                	<dd class='dd_price font_t'><fmt:formatNumber type="number" value="${price}"/></dd>
                		<a href="javascript:;" onclick="location.href='${linkUrl}';return false;"></a>
				</dl>
 			</c:if>
          	<ul class='list_sale clear'>
          		<li>
                	<span>오늘 신규 할인상품</span>
                  	<p><em class='font_t'><fmt:formatNumber type="number" value="${todaySalePrdtCnt}"/></em>개</p>
					<a href="/m/biz/mypage/todayNewSale"></a>
                 </li>
       			<li>
            		<span>무료배송 상품</span>
                 	<p><em class='font_t'><fmt:formatNumber type="number" value="${todayFreeDlvPrdtCnt}"/></em>개</p>
					<a href="/m/biz/mypage/todayFreeDelivery"></a>
              	</li>
         	</ul>
   		</div>
	</div>
	
	<!-- /////////카드혜택 배너///////// -->
	<c:if test="${not empty cardBnrList}">		
		<div class='swiper-area'>
			<div class="swiper-container">
				<div class="swiper-wrapper">
					<c:forEach items="${cardBnrList}" var="l" varStatus="st">
						<div class="swiper-slide">
							<a href="${l.bnrLinkUrl}">
								<ui:image src="${l.imageUrlMo}" alt="${l.imageAlt}"/>
							</a>
						</div>
					</c:forEach>
				</div>
				<!-- Add Pagination -->
				<div class="swiper-pagination"></div>
			</div>
		</div>
	</c:if>
	<!-- //카드혜택 배너 -->
	
	<!-- /////////오늘의 이벤트///////// -->	
	<c:if test="${not empty todayEventList}">
		<div class='exhibition_wrap'>
			<h2>오늘의 <span>이벤트</span></h2>
			<!-- 이벤트 목록 -->
			<div class='event_list'>
				<div class="event_banner">
					<ul>
						<c:forEach items="${todayEventList}" var="l" varStatus="st">
							<li>
								<a href="javascript:;" onclick="location.href='/m/biz/eventDetail?eventId=${l.eventId}';return false;">
									<div class="img_wrap">
										<ui:image src="${l.eventImageUrl}" alt="${l.eventTitle}"/>
									</div>
									<c:if test="${not empty l.discRate && l.discRate > 0}">
										<span class="font_t percent">${l.discRate}%</span>
									</c:if>
									<strong>${l.eventTitle}</strong>
									<p>${l.eventDtlCont}</p>
								</a>
							</li>
						</c:forEach>
					</ul>
				</div>
				<div class="btn_more">
					<a href="javascript:" onclick="location.href='/m/biz/hot/eventMain';return false;">기획전 더보기</a>
				</div>
			</div>
			<!--// 이벤트 목록 -->
		</div>
	</c:if>
	<!-- //오늘의 이벤트 -->	
</div>