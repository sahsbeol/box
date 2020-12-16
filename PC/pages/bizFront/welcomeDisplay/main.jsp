<%@page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<!-- 태그 라이브러리 -->
<%@ include file="/pages/decorators/biz/tagHeader.jsp" %>
<ui:decorator name="bizWelcomeMain"/>
<!DOCTYPE ui:decorator PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!--  SNS 공유 내용 -->
<meta property="og:type" content="website"/>
<meta property="og:title" content="HOTTRACKS - 생활 속 감성충전소"/>
<meta property="og:url" content="${defaultHost}/ht/biz/welcomeMain"/>
<meta property="og:image" content="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/renewal/common/logo_over.gif"/>
<!--  SNS 공유 내용 -->

<!-- 레이어팝업 -->
<c:if test="${not empty list21St}">
<script type="text/javascript">
jQuery(function($){
    $(document).ready(function(){
    	$(function(){
    	    $('.slide_popup .slide_part ul').bxSlider({
    			auto: true,
    			autoHover: true,
    	        touchEnabled: false,
    	        infiniteLoop: true,
    	        speed: 1000,
    			pause: 3000,
    	        displaySlideQty: 2,
    	        moveSlides: 1,
    			slideMargin: 8,
    			pager: true,
    	        pagerType: 'short',
    	        pagerShortSeparator: ''
    	    });
    	    $('.slide_popup .close_popup').click(function(){
    	        $('.slide_popup, .mask').hide();
    	        $('body').removeClass('noscroll');
    	    });
    	    $('.slide_popup .dont_show_again').click(function(){
    			$('.slide_popup, .mask').hide();
    	        $('body').removeClass('noscroll');
				setCookie("NOT_ANIMORE", "Y", 1);
    	    });
    	    if($('.slide_popup').is(':visible')){
    	        $('body').addClass('noscroll');
    	    }else{
    	        $('body').removeClass('noscroll');
    	    }
    	});

    	if(getCookie("NOT_ANIMORE") == null || getCookie("NOT_ANIMORE") == ""){
    		$('.slide_popup, .mask').show();
		}
    });
});
</script>
</c:if>

<script type="text/javascript">
	$(document).ready(function(){
		main.init();
		
		//기획상품
		main.loadTemplate($('.cont10 .pager li:first a'), 'cont10');
		
		//오늘의 특가가 있을떄
	    if($("#gauge").length > 0){ 
	        /* timer start */
	        main.today = new Date();
	        
		    main.changeTime();
		    main.timer = setInterval(main.changeTime, 1000);
	    }
		
	    /* setTimeout(function(){
    		$(".cont01").attr("style","visibility: visible;");
    		$(".cont05").attr("style","visibility: visible;");
    		$(".cont06").attr("style","visibility: visible;");
        },100); */
    	
	    
	    $(".btn_fullmore").click(function () {
	      $("body").addClass("dimlock");
	      $(".layer_fullban").addClass("active");
	    });
	    $(".btn_fullclose").click(function () {
	      $("body").removeClass("dimlock");
	      $(".layer_fullban").removeClass("active");
	    });
	});

	var main = {
		 today : new Date()
		,timer : null
		,mainCont05Slider : null
		,changeTime : function(){
			var now = new Date();
		    var end = new Date();
		    
		    end.setHours(23);
		    end.setMinutes(59);
		    end.setSeconds(59);
		    
		    var H = end.getHours() - now.getHours();
		    var M = end.getMinutes() - now.getMinutes();
		    var S = end.getSeconds() - now.getSeconds();
		    
		    //36e5는 60 * 60 * 1000의 과학 표기법. 남은시간 / 24 * 100. 소수점 첫째자리까지 가져오기
		    var percent = ((Math.abs(end - now) / 36e5) / 24 * 100).toFixed(1);
		    $("#gauge").css("height" , percent + "%");
		    
		    if((now.getDate() - main.today.getDate()) > 0){
		        //alert("현재 시각 정시 기준으로\n원데이 특가가 업데이트 되었습니다.");
		        location.replace("/ht/biz/welcomeMain?"+H+M+S);
		    }
		    $("#txtOddTime").html(lpad(H, 2, '0') + "<em>:</em>" + lpad(M, 2, '0') + "<em>:</em>" + lpad(S, 2, '0'));
		}
		,loadTemplate : function(myObj, parentObj){
			$("#loading").show();
			var type = $(myObj).parent().attr("type");
			if($(myObj).parents().hasClass("active")){
				return false;
			}
			$.ajax({
			    type: "GET"
			   ,async:false
			   ,url: "/ht/biz/mainTemplate?type="+type
			   ,dataType: "html"
			   ,success : function(htmlStr){
				   	//인기베스트, 예약음반
				   	if(parentObj == 'cont02' || parentObj == 'cont05' || parentObj == 'cont15'){
				   		$("."+ parentObj +" .listArea").empty();
				       	$("."+ parentObj +" .listArea").append(htmlStr);
				       	
					   	$("."+ parentObj +" .tab li").removeClass("active");
				       	$("."+ parentObj +" .tab [type=" + type + "]").addClass("active");
				       	
				       	if(parentObj == 'cont02'){
				       		var url = "${defaultHost}/ht/biz/welcome/hotAwardPage";
				       		if(type == "recordBest"){
				       			url = "${defaultHost}/ht/record/bestList/0003?bestRangeType=C1001";
				       		}else if(type == "dvdBest"){
				       			url = "${defaultHost}/ht/record/bestList/000400?bestRangeType=C1001";
				       		}else{
				       			url = "${defaultHost}/ht/biz/welcome/hotAwardPage";
				       		}
				       		$(".bestUrl").attr("href", url);
				       		
				       	}else if(parentObj == 'cont05'){
				       		main.mainCont05Slider.reloadSlider();
				       	}
					}else if(parentObj == 'cont10'){
						$("."+ parentObj +" .listArea").empty();
				       	$("."+ parentObj +" .listArea").append(htmlStr);
				       	
				       	$("."+ parentObj +" .pager li").removeClass("active");
				       	$("."+ parentObj +" .pager [type=" + type + "]").addClass("active");
				       	
				       	$("."+ parentObj +" .slide_num").text("0" + $(myObj).parent().attr("numbering"));
					}
			       	
				  	//로딩바 숨기기
			       	$("#loading").hide();
			   }
			   ,error: function(data) {
			       alert('<fmt:message key="error.common.system"/>');
			       $("#loading").hide();
			   }
			}); 
		}
		,init : function(){
			
			//이미지 로드 후 스와이퍼 셋팅하기 위해
			var obj = mainFn();
			main.mainCont05Slider = obj["mainCont05Slider"];
			main.loadTemplate($(".cont15 .tab li:first a"), 'cont15');
		}
	};
	
	/* function wrapWindowByMask(){
	    //화면의 높이와 너비를 구한다.
	    var maskHeight = $(document).height();  
	    var maskWidth = $(document).width();
	    
	    var bnrTop = $(window).height()/2 - $(".window .bnr-img img:first").height()/2;
	    var bnrLeft = $(window).width()/2 - $(".window .bnr-img img:first").width()/2;
	    
	    //마스크의 높이와 너비를 화면 것으로 만들어 전체 화면을 채운다.
	    $('#mask').css({'width':maskWidth,'height':maskHeight});
	    $('.window').css({'left':bnrLeft,'top':bnrTop});

	    //애니메이션 효과
	    // $('#mask').fadeIn(500);
	    $('#mask').fadeTo(10,0.6);
	    
	    $('.window').show();
	} */	
</script>

</head>
<body>
<div class="content main_wrapper" id="content">
	<!-- 슬라이드 레이어 팝업 -->
	<c:if test="${not empty list21St}">
	    <div class="mask" style="display:none;"></div>
	    <div class="slide_popup" style="display:none;">
	        <div class="btn_wrap clear">
	            <label class="dont_show_again">
	                <input type="checkbox">
	                <span>오늘하루그만보기</span>
	            </label>
	            <a href="#" onclick="javacript:event.preventDefault();" class="close_popup"></a>
	        </div>
	        <div class="slide_wrap">
	            <div class="slide_part">
	                <ul>
	                	<c:forEach items="${list21St}" var="l">
					        <%-- <div class="bnr-img">
					            <a href="${l.bnrLnkUrl}"<c:if test="${l.bnrNewWinYn eq 'Y'}"> target="_blank"</c:if>>
					                <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${l.bnrImgUrl}" alt="${l.bnrImgAlt}"
					                    <c:if test="${not empty l.bnrImgUrl2}">class="roll_img"</c:if>
					                    hover="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${l.bnrImgUrl2}"
					                    default="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${l.bnrImgUrl}"
					                    onerror="this.src='${imageServer}/images/no_image2.gif';"
					                    width="${l.orgBnrWidth}"
					                    height="${l.orgBnrHeight}"
					                />
					            </a>
					        </div> --%>
					        
					        <li>
		                        <a href="${l.bnrLnkUrl}">
		                            <div class="thum">
		                                <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${l.bnrImgUrl}" alt="${l.bnrImgAlt}"
					                    <c:if test="${not empty l.bnrImgUrl2}">class="roll_img"</c:if>
					                    hover="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${l.bnrImgUrl2}"
					                    default="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${l.bnrImgUrl}"
					                    onerror="this.src='${imageServer}/images/no_image2.gif';"
					                    width="${l.orgBnrWidth}"
					                    height="${l.orgBnrHeight}"
					                	/>
		                            </div>
		                            <c:if test="${not empty l.bnrTitle}">
			                            <div class="text_wrap">
			                                <strong class="item_title">${l.bnrTitle}</strong>
											<p class="item_description">${l.bnrSubTitle}</p>
											<!-- 할인은 discount-box
											HOT, NEW는 discount-box에 hot 클래스 추가
											사은품은 discount-box에 gift 클래스 추가 (한글은 적용폰트가 달라서 따로 빠집니다) 
											무료배송은 discount-box에 ship 클래스 추가 (4글자라서 사이즈 조정때문에 따로 빠졌습니다)-->
											<c:if test="${not empty l.flagCd}">
												<c:if test="${l.flagCd eq 'C1481'}">
													<div class="discount-box hot">
														<i>~</i>
														<em>NEW</em>
													</div>
												</c:if>
												<c:if test="${l.flagCd eq 'C1482'}">
													<div class="discount-box hot">
														<i>~</i>
														<em>HOT</em>
													</div>
												</c:if>
												<c:if test="${l.flagCd eq 'C1483'}">
													<div class="discount-box gift">
														<i>~</i>
														<em>사은품</em>
													</div>
												</c:if>
												<c:if test="${l.flagCd eq 'C1484'}">
													<div class="discount-box ship">
														<i>~</i>
														<em>무료배송</em>
													</div>
												</c:if>
												<c:if test="${l.flagCd eq 'C1485'}">
													<c:if test="${not empty l.discRate}">
														<div class="discount-box">
															<i>~</i>
															<em>${l.discRate}</em>%
														</div>
													</c:if>	
												</c:if>								
												<c:if test="${l.flagCd eq 'C1486'}">
													<div class="discount-box hot">
														<i>~</i>
														<em>1+1</em>
													</div>
												</c:if>								
											</c:if>
			                            </div>
		                            </c:if>
		                        </a>
		                    </li>
					    </c:forEach>
	                </ul>
	            </div>
	        </div>
	    </div>
	</c:if>

	<!-- /////////상단 롤링 배너///////// -->
	<c:if test="${not empty pwlcRollBnrList and fn:length(pwlcRollBnrList) > 0}">
		<div class="cont cont01">
			<div class="main_top_slider">
				<ul>
					<c:forEach items="${pwlcRollBnrList}" var="l" varStatus="st">
						<li class="${l.signWayGbn eq 'C1451' ? 'type01' : 'type02'}">
							<a href="javascript:;" class="PC_MAIN_MENU_1" onclick="location.href='${l.bnrLnkUrl}';return false;">
								<div class="thum">
									<ui:image src="${l.bnrImgUrl}" alt="${l.bnrImgAlt}"/>
								</div>
								<c:if test="${l.signWayGbn ne 'C1451'}">
									<div class="desc" style="visibility:hidden;">
										<c:if test="${not empty l.flagCd}">
											<c:if test="${l.flagCd eq 'C1481'}">
												<span class="tag_new">NEW</span>
											</c:if>
											<c:if test="${l.flagCd eq 'C1482'}">
												<span class="tag_hot">HOT</span>
											</c:if>
											<c:if test="${l.flagCd eq 'C1483'}">
												<span class="tag_gift">사은품</span>
											</c:if>
											<c:if test="${l.flagCd eq 'C1484'}">
												<span class="tag_free">무료배송</span>
											</c:if>
											<c:if test="${l.flagCd eq 'C1485'}">
												<c:if test="${not empty l.discRate}">
													<span class="tag_percent">~<strong>${l.discRate}</strong>%</span>
												</c:if>	
											</c:if>								
										</c:if>
										<p class="tit">${l.bnrTitle}</p>
										<c:if test="${l.signWayGbn eq 'C1453'}">
											<p class="txt">${l.bnrSubTitle}</p>
										</c:if>
									</div>
								</c:if>
							</a>
						</li>
					</c:forEach>
				</ul>
			</div>
			<div class="btn_fullbox PC_MAIN_MENU_1_1">
				<a href="#n" class="btn_fullmore">전체보기</a>
			</div>
			
		</div>
	</c:if>
	<script type="text/javascript">
	var mainSlider01 = $('.main_wrapper .main_top_slider ul').bxSlider({
	      auto : true,
	      autoHover: true,
	      hideControlOnEnd: true,
	      maxSlides: 1,
	      pause : 3000,
	      speed : 1000,
	      infiniteLoop : true,
	      touchEnabled: false,
	       pager: true,
	      pagerType: 'short',
	      pagerShortSeparator: ''
	   });
	$(".desc").attr("style",null);	
	</script>
	<!--// 상단 롤링 배너 -->

<div class="lower_content">	
	<div class="cont cont02">
		<!-- /////////오늘만 특가///////// -->
		<c:if test="${not empty hotdeal}">
			<c:choose>
				<c:when test="${not empty hotdeal.eventId}">
					<c:set var="linkUrl" value="/ht/biz/eventDetail?eventId=${hotdeal.eventId}"/>
				</c:when>
				<c:otherwise>
					<c:set var="linkUrl" value="/m/gift/detail/${hotdeal.sellPrdtBcode}"/>
				</c:otherwise>
			</c:choose>
			<div class="cont_left">
				<a href="javascript:" class="PC_MAIN_MENU_2" onclick="location.href='${linkUrl}';return false;">
					<h3>오늘만 특가<span class="btn_detail">더보기</span></h3>
				</a>
				<span class="font_t time" id="txtOddTime"></span>
				<div class="product">
					<span class="percent font_t">				
						<c:choose>
							<c:when test="${not empty hotdeal.prdtDscntRate and hotdeal.prdtDscntRate ne '0'}">
								<fmt:parseNumber var="rate" integerOnly="true" value="${hotdeal.prdtDscntRate}"/>
							</c:when>
							<c:otherwise>
								<fmt:parseNumber var="rate" integerOnly="true" value="0"/>
<%-- 								<fmt:parseNumber var="rate" integerOnly="true" value="${hfn:rate(hotdeal.prdtSellPrice, hotdeal.lastCpnPrice)}"/> --%>
							</c:otherwise>
						</c:choose>
						<c:if test="${rate > 0}">
							<em>${rate}</em>%
						</c:if>
					</span>

					<a href="javascript:;" class="main_pd PC_MAIN_MENU_2_1" onclick="location.href='${linkUrl}';return false;">
						<div class="thum">
							<ui:image src="${hotdeal.productImageUrl}" size="400" server="product" alt="${hotdeal.prdtName}"/>
						</div>
						
						<c:if test="${hotdeal.freeDlvyYn == 'Y'}">
							<div class="label_wrap">
								<span class="label">무료배송</span>
							</div>
						</c:if>

						<p class="brand">${hotdeal.prdtName}</p>
						<div class="info_wrap">
							<p class="tit">${hotdeal.eventTitle}</p>
							<p class="price font_t">
								<c:if test="${not empty hotdeal.prdtDscntRate and hotdeal.prdtDscntRate ne '0'}">
									<em class="discount"><fmt:formatNumber type="number" value="${hotdeal.prdtSellPrice}"/></em>
								</c:if>
								<fmt:formatNumber type="number" value="${hotdeal.lastCpnPrice}"/>		
							</p>
						</div>
					</a>
				</div>
				<ul class="event">
					<c:forEach items="${listHotdeal}" var="l" varStatus="st">
						<li>
							<a href="javascript:;" class="PC_MAIN_MENU_2_2" onclick="location.href='${linkUrl}';return false;">
								<div class="thum">
									<ui:image src="${l.prdtImageUrl}" size="400" server="product" alt="${l.prdtName}"/>
								</div>
								<span class="percent font_t">
<%-- 									<c:choose> --%>
<%-- 										<c:when test="${not empty l.eventDscntRate and l.eventDscntRate ne '0'}"> --%>
<%-- 											<fmt:parseNumber var="rate" integerOnly="true" value="${l.eventDscntRate}"/> --%>
<%-- 										</c:when> --%>
<%-- 										<c:otherwise> --%>
											<fmt:parseNumber var="rate" integerOnly="true" value="${hfn:rate(l.prdtSellPrice, l.lastCpnPrice)}"/>
<%-- 										</c:otherwise> --%>
<%-- 									</c:choose> --%>
									<c:if test="${rate > 0}">
										${rate}%
									</c:if>
								</span>
							</a>
						</li>
					</c:forEach>
				</ul>
				<!-- 남은 시간 -->
				<div class="time_line">
					<span class="txt">남은시간</span>
					<div class="bar">
						<span id="gauge" style="height:0%;"></span>
					</div>
				</div>
			</div>
		</c:if>
		<!--// 오늘만 특가 -->
	
		<!-- /////////인기베스트///////// -->
		<c:if test="${not empty mwlBestList}">
			<div class="cont_right">
				<a class="bestUrl PC_MAIN_MENU_3" href="${defaultHost}/ht/biz/welcome/hotAwardPage">
					<h3>인기 베스트<span class="btn_detail">더보기</span></h3>
				</a>
				<div class="tab">
					<ul>
						<li class="PC_MAIN_MENU_3_1 active" type="munguBest"><a href="javascript:;" onclick="main.loadTemplate(this, 'cont02');">문구/기프트</a></li>
						<li class="PC_MAIN_MENU_3_2" type="recordBest"><a href="javascript:;" onclick="main.loadTemplate(this, 'cont02');">음반</a></li>
						<li class="PC_MAIN_MENU_3_3" type="dvdBest"><a href="javascript:;" onclick="main.loadTemplate(this, 'cont02');">영상</a></li>
					</ul>
				</div>
				<div class="best_list">
					<ul class="listArea">
						<c:forEach items="${mwlBestList}" var="l" varStatus="st">
							<li class="PC_MAIN_MENU_3_4">
								<a href="javascript:;" onclick="location.href='/ht/product/detail?barcode=${l.sellPrdtBcode}';return false;">
									<em class="font_t">${st.count}</em>
									<div class="thum">
										<c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G'}">
		                            		<ui:image src="${l.productImageUrl}" size="100" server="product" alt="${fn:escapeXml(l.prdtName)}"/>
		                            	</c:if>
										<c:if test="${l.sellPrdtGbn eq 'R'}">
											<ui:image rcrdCd="${l.rcrdCd}" size="100" prdtGbn="${l.sellPrdtGbn}" alt="${fn:escapeXml(l.prdtName)}" ratingCode="A"/>
										</c:if>
				               			<c:if test="${l.sellPrdtGbn eq 'D'}">
				                   			<ui:image rcrdCd="${l.rcrdCd}" size="100" prdtGbn="${l.sellPrdtGbn}" alt="${fn:escapeXml(l.prdtName)}" ratingCode="A"/>
				                		</c:if>
									</div>
									<div class="desc">
										<p class="tit">
											<c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G'}">
			                            		${l.prdtName}
			                            	</c:if>
											<c:if test="${l.sellPrdtGbn eq 'R' || l.sellPrdtGbn eq 'D'}">
												${l.commTitle}
											</c:if>
                                   		</p>
										<p class="price font_t">
											<c:if test="${l.prdtSellPrice > l.lastCpnPrice}">
                                        		<fmt:parseNumber var="rate" integerOnly="true" value="${hfn:rate(l.prdtSellPrice,l.lastCpnPrice)}" />
                                         		<span class="percent">${rate}%</span>
                                			</c:if>
											<fmt:formatNumber type="number">${l.lastCpnPrice}</fmt:formatNumber>
										</p>
									</div>
								</a>
							</li>
						</c:forEach>
					</ul>
				</div>
			</div>
		</c:if>
		<!--// 인기베스트 -->
	</div>
	
	<!-- /////////이벤트2단배너 배너///////// -->
	<c:if test="${not empty mgftEvent2BnrList}">
		<div class="event_banner">
			<ul>
				<c:forEach items="${mgftEvent2BnrList}" var="l" varStatus="st">
					<li class="PC_MAIN_MENU_4">
						<a href="javascript:;" onclick="location.href='/ht/biz/eventDetail?eventId=${l.eventId}';return false;">
							<div class="img_wrap">
								<ui:image src="${l.eventImageUrl}" alt="${l.eventTitle}"/>
							</div>
							<c:if test="${not empty l.discRate && l.discRate > 0}">
		                       	<span class="font_t percent">${l.discRate}%</span>
		                    </c:if>
							<strong>${l.eventTitle}</strong>
							<p>${l.eventDtlCont}</p>
							<span class="date font_t">
								<c:choose>        
									<c:when test="${not empty l.eventRangeInfo}">
										${l.eventRangeInfo}
									</c:when>        
	                            	<c:when test="${l.eventEndDt eq '99991231' || l.eventEndDt eq '99999999'}">
	                            		<ui:mask pattern="####.##.##">${l.eventStartDt}</ui:mask> ~ 
	                            	</c:when>
	                            	<c:otherwise>
	                            		<ui:mask pattern="####.##.##">${l.eventStartDt}</ui:mask> ~ <ui:mask pattern="####.##.##">${l.eventEndDt}</ui:mask>
	                            	</c:otherwise>
	                        	</c:choose>
							</span>
						</a>
					</li>
				</c:forEach>
			</ul>
		</div>
	</c:if>
	<!--// 이벤트2단배너 배너 -->
	
	<!-- /////////앵콜특가///////// -->
	<c:if test="${not empty encoreList}">
		<div class="cont cont03">
			<p class="txt">한 주간<br/>최다 판매 베스트를 모아 한정 세일</p>
			<h5 class="tit">앵콜<br/>특가</h5>
			
			<c:forEach items="${encoreList}" var="l" varStatus="st">
				<c:choose>
					<c:when test="${st.first}">
						<div class="main_pd">
							<a href="javascript:;" onclick="location.href='/ht/biz/eventDetail?eventId=${l.eventId}';return false;">
								<div class="thum">
									<c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G'}">
										<ui:image src="${l.productImageUrl}" size="400" server="product" alt="${fn:escapeXml(l.prdtName)}"/>
									</c:if>
									<c:if test="${l.sellPrdtGbn eq 'R'}">
										<ui:image rcrdCd="${l.rcrdCd}" size="400" prdtGbn="${l.sellPrdtGbn}" alt="${fn:escapeXml(l.prdtName)}" ratingCode="A"/>
									</c:if>
									<c:if test="${l.sellPrdtGbn eq 'D'}">
										<ui:image rcrdCd="${l.rcrdCd}" size="400" prdtGbn="${l.sellPrdtGbn}" alt="${fn:escapeXml(l.prdtName)}" ratingCode="A"/>
									</c:if>
								</div>
								<div class="info">
									<p class="tit">${l.prdtName}</p>
									<p class="price font_t">
										<fmt:parseNumber var="rate" integerOnly="true" value="${hfn:rate(l.prdtSellPrice, l.lastCpnPrice)}"/>
										<c:if test="${rate > 0}">
											<span class="percent">${rate}%</span>
										</c:if>
										<fmt:formatNumber type="number" value="${l.lastCpnPrice}"/>
									</p>
								</div>
							</a>
						</div>
						<div class="right_pd">
							<ul>
					</c:when>
					<c:otherwise>
						<li>
							<a href="javascript:;" onclick="location.href='/ht/biz/eventDetail?eventId=${l.eventId}';return false;">
								<div class="thum">
									<c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G'}">
										<ui:image src="${l.productImageUrl}" size="400" server="product" alt="${fn:escapeXml(l.prdtName)}"/>
									</c:if>
									<c:if test="${l.sellPrdtGbn eq 'R'}">
										<ui:image rcrdCd="${l.rcrdCd}" width="200" prdtGbn="${l.sellPrdtGbn}" alt="${fn:escapeXml(l.prdtName)}" ratingCode="A"/>
									</c:if>
									<c:if test="${l.sellPrdtGbn eq 'D'}">
										<ui:image rcrdCd="${l.rcrdCd}" width="200" prdtGbn="${l.sellPrdtGbn}" alt="${fn:escapeXml(l.prdtName)}" ratingCode="A"/>
									</c:if>
								</div>
								<div class="info">
									<p class="tit">${l.prdtName}</p>
									<p class="price font_t">
										<fmt:parseNumber var="rate" integerOnly="true" value="${hfn:rate(l.prdtSellPrice, l.lastCpnPrice)}"/>
										<c:if test="${rate > 0}">
											<span class="percent">${rate}%</span>
										</c:if>
										<fmt:formatNumber type="number" value="${l.lastCpnPrice}"/>
									</p>
								</div>
							</a>
						</li>
					</c:otherwise>
				</c:choose>
				
				<c:if test="${st.last}">
							</li>
						</ul>
					</div>
				</c:if>
			</c:forEach>
		</div>
	</c:if>
	<!--// 앵콜특가 -->

	<!-- 이미지 띠배너 -->
	<c:if test="${not empty pwlcImgBnrList}">
		<div class="banner_wrap mgt80">
			<c:forEach items="${pwlcImgBnrList}" var="pwlcImgBnrList">
				<a href="${pwlcImgBnrList.bnrLnkUrl}" class="PC_MAIN_VIEWER">
					<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${pwlcImgBnrList.bnrImgUrl}">
		    	</a>
	    	</c:forEach>
		</div>
	</c:if>
	<!-- / 이미지 띠배너 -->

	<!-- /////////띠배너///////// -->
	<c:if test="${not empty pwlcTextBnrList}">
		<div class="text_banner">
			<c:forEach items="${pwlcTextBnrList}" var="l" varStatus="st">
				<c:choose>
					<c:when test="${st.first}">
						<div class="bn_cont cont_left" style="background:#FFBFCE;">
						<a href="javascript:;" class="PC_MAIN_MENU_5" onclick="location.href='${l.bnrLnkUrl}';return false;">
							<div class="txt">
								<p>
									${l.bnrTitle}
								</p>
							</div>
						</a>
						</div>
					</c:when>
					<c:otherwise>
						<div class="bn_cont cont_right" style="background:#E6D6FF;">
						<a href="javascript:;" class="PC_MAIN_MENU_6" onclick="location.href='${l.bnrLnkUrl}';return false;">
							<div class="txt">
								<p>
									${l.bnrTitle}
								</p>
							</div>
						</a>
						</div>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</div>
	</c:if>
	<!--// 띠배너  -->

	<!-- /////////인기베스트///////// -->
	<c:if test="${not empty listFocusOn}">
		<div class="cont cont04">
			<h3><strong>지금,</strong><br/>이 상품을 <span>가장 많이</span> 보고 있어요</h3>
			<div class="slide_banner">
				<c:forEach items="${listFocusOn}" var="l" varStatus="st">
					<c:if test="${(st.first) or ((st.count-1) % 4 == 0)}">
						<div class="slide-item">
							<ul>
					</c:if>
							<li class="PC_MAIN_MENU_7<c:if test="${st.count % 3 == 0}"> round</c:if>">
								<c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G' || l.sellPrdtGbn eq 'S'}">
									<a href="javascript:;" onclick="location.href='/ht/product/detail?barcode=${l.sellPrdtBcode}';return false;">
								</c:if>
								<c:if test="${l.sellPrdtGbn eq 'R' || l.sellPrdtGbn eq 'D'}">
									<a href="javascript:;" onclick="location.href='/ht/record/detail/${l.sellPrdtBcode}';return false;">
								</c:if>
									<div class="thum">
										<c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G' || l.sellPrdtGbn eq 'S'}">
		                            		<ui:image src="${l.productImageUrl}" size="400" src2="${l.productImageUrl2}" server="product" clazz="photo" alt="${fn:escapeXml(l.prdtName)}"/>
		                            	</c:if>
										<c:if test="${l.sellPrdtGbn eq 'R'}">
		                               		<ui:image rcrdCd="${l.rcrdCd}" size="400" width="${l.sellPrdtGbn eq 'R'?'150':'99'}" prdtGbn="${l.sellPrdtGbn}" alt="${fn:escapeXml(l.prdtName)}" rcrdImgType="large" ratingCode="A"/>
		                            	</c:if>
		                          		<c:if test="${l.sellPrdtGbn eq 'D'}">
		                           			<ui:image rcrdCd="${l.rcrdCd}" size="400" width="${l.sellPrdtGbn eq 'R'?'150':'99'}" prdtGbn="${l.sellPrdtGbn}" alt="${fn:escapeXml(l.prdtName)}" rcrdImgType="large" ratingCode="A"/>
		                             	</c:if>
									</div>
									<div class="desc">
										<p class="tit">${l.prdtName}</p>
										<p class="price font_t">
											<fmt:parseNumber var="rate" type="number" integerOnly="true" value="${hfn:rate(l.prdtSellPrice,l.lastCpnPrice)}"/>
			                               	<c:if test="${rate > 0}">
												<span class="percent">${rate}%</span>
											</c:if>
											<fmt:formatNumber type="number" value="${l.lastCpnPrice}"/>
										</p>
									</div>
								</a>
							</li>						
					<c:if test="${(st.last) or (st.count % 4 == 0)}">
							</ul>
						</div>
					</c:if>
				</c:forEach>
			</div>
			<div class="custom_paging_wrap">
				<div class="custom_paging"></div>
			</div>
		</div>
	</c:if>
	<!--// 인기베스트 -->
	
	<!-- /////////예약음반///////// -->
	<div class="cont cont05">
		<div class="inner950">
			<a href="${defaultHost}/ht/record/reserve/0003" class="PC_MAIN_MENU_8"><h3>예약음반<span class="btn_detail">더보기</span></h3></a>
			<div class="tab">
				<ul>
					<li type="songReserve" class="PC_MAIN_MENU_8_1 active"><a href="javascript:;" onclick="main.loadTemplate(this, 'cont05');">가요</a></li>
					<li type="popReserve" class="PC_MAIN_MENU_8_2"><a href="javascript:;" onclick="main.loadTemplate(this, 'cont05');">팝</a></li>
					<li type="classicReserve" class="PC_MAIN_MENU_8_3"><a href="javascript:;" onclick="main.loadTemplate(this, 'cont05');">클래식</a></li>
					<li type="dvdReserve" class="PC_MAIN_MENU_8_4"><a href="javascript:;" onclick="main.loadTemplate(this, 'cont05');">영상</a></li>
				</ul>
			</div>
			<div class="slide_banner dvd">
				<ul class="listArea">
					<c:forEach items="${reServeBnrListSong}" var="l" varStatus="st">
						<li class="PC_MAIN_MENU_8_5">
							<a href="javascript:;" onclick="location.href='/ht/record/detail/${l.sellPrdtBcode}';return false;">
								<div class="thum">
									<ui:image rcrdCd="${l.rcrdCd}" width="400" prdtGbn="${l.sellPrdtGbn}" alt="${l.prdtName}" ratingCode="A"/>
									<c:if test="${l.preDay > 0}">
										<span class="font_t">D-${l.preDay}</span>
									</c:if>
									<c:if test="${l.preDay eq 0}">
										<span class="font_t">D-DAY</span>
									</c:if>
								</div>
								<p class="date">발매일<strong class="mgl5 font_t"><ui:mask pattern="####.##.##">${l.rlseDt}</ui:mask></strong></p>
								<p class="tit">${l.prdtName}</p>
								<p class="price font_t">
									<c:if test="${l.prdtSellPrice ne l.dscntPrice}">
										<span class='percent'>
											<fmt:parseNumber integerOnly="true">${hfn:rate(l.prdtSellPrice, l.dscntPrice)}</fmt:parseNumber>%
										</span>
									</c:if>
									<fmt:formatNumber type="number">${l.dscntPrice}</fmt:formatNumber>
								</p>
							</a>
						</li>
					</c:forEach>
				</ul>
			</div>
		</div>
	</div>
	<!--// 예약상품 -->
	
	<!-- /////////내게 맞는 추천상품(레코벨 추천상품)///////// -->
	<c:if test="${not empty listRecobell}">
		<div class="cont cont06">
			<a href="javascript:" class="PC_MAIN_MENU_9" onclick="location.href='/ht/biz/personal/personalRecommend';return false;"><h3>내게 맞는 추천 상품<span class="btn_detail">접기</span></h3></a>
			<div class="list_wrap">
				<ul>
					<c:forEach items="${listRecobell}" var="l" varStatus="st">
						<li <c:if test="${st.count > 4}">style="display:none" class="recobellMore"</c:if>>
							<c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G' || l.sellPrdtGbn eq 'S'}">
								<a href="javascript:;" class="PC_MAIN_MENU_9_1" onclick="location.href='/ht/product/detail?barcode=${l.sellPrdtBcode}&foo=bar&rccode=pc_main1';return false;">
							</c:if>
							<c:if test="${l.sellPrdtGbn eq 'R' || l.sellPrdtGbn eq 'D'}">
								<a href="javascript:;" class="PC_MAIN_MENU_9_1" onclick="location.href='/ht/record/detail/${l.sellPrdtBcode}?foo=bar&rccode=pc_main1';return false;">
							</c:if>
								<div class="thum">
									<c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G' || l.sellPrdtGbn eq 'S'}">
	                            		<ui:image src="${l.productImageUrl}" size="400" src2="${l.productImageUrl2}" server="product" alt="${fn:escapeXml(l.prdtName)}"/>
	                            	</c:if>
									<c:if test="${l.sellPrdtGbn eq 'R'}">
	                               		<ui:image rcrdCd="${l.rcrdCd}" size="400" prdtGbn="${l.sellPrdtGbn}" alt="${fn:escapeXml(l.prdtName)}" rcrdImgType="large" ratingCode="A"/>
	                            	</c:if>
	                          		<c:if test="${l.sellPrdtGbn eq 'D'}">
	                           			<ui:image rcrdCd="${l.rcrdCd}" size="400" prdtGbn="${l.sellPrdtGbn}" alt="${fn:escapeXml(l.prdtName)}" rcrdImgType="large" ratingCode="A"/>
	                             	</c:if>
								</div>
								<p class="tit">${l.prdtName}</p>
								<p class="price font_t">									
                               		<fmt:parseNumber var="rate" type="number" integerOnly="true" value="${hfn:rate(l.prdtSellPrice,l.lastCpnPrice)}"/>
                                	<c:if test="${rate > 0}">
                                 		<span class="percent">${rate}%</span>
                               		</c:if>
                               		<fmt:formatNumber type="number">${l.lastCpnPrice}</fmt:formatNumber>
								</p>
							</a>
						</li>
					</c:forEach>
				</ul>
			</div>
			<div class="btn_wrap PC_MAIN_MENU_9_2">
				<a href="javascript:;" onclick="if($('.btn_more').hasClass('on')){$(this).removeClass('on');$('.recobellMore').hide();$('#moreTxt').text('더보기');}else{$(this).addClass('on');$('.recobellMore').show();$('#moreTxt').text('접기');}" class="btn_more"><span id="moreTxt">더보기</span></a>
			</div>
		</div>
	</c:if>
	<!--// 내게 맞는 추천 상품 -->

	<!-- /////////가로 통 배너///////// -->
	<c:if test="${not empty pwlcWidthBnrList}">
		<div class="banner_wrap PC_MAIN_MENU_10">
			<c:forEach items="${pwlcWidthBnrList}" var="l" varStatus="st">
				<a href="javascript:;" onclick="location.href='${l.bnrLnkUrl}';return false;">
					<ui:image src="${l.bnrImgUrl}" alt="${l.bnrImgAlt}"/>
				</a>
			</c:forEach>
		</div>
	</c:if>
	<!--// 가로 통 배너 -->

	<!-- /////////가로 3단 배너///////// -->
	<c:if test="${not empty pwlcWidth3BnrList}">
		<div class="event_banner02">
			<ul>
				<c:forEach items="${pwlcWidth3BnrList}" var="l" varStatus="st">
					<li class="PC_MAIN_MENU_11">
						<a href="javascript:;" onclick="location.href='/ht/biz/eventDetail?eventId=${l.eventId}';return false;">
							<div class="img_wrap">
								<ui:image src="${l.eventImageUrl}" alt="${l.eventTitle}"/>
							</div>
							<c:if test="${not empty l.discRate && l.discRate > 0}">
	                        	<span class="font_t percent">${l.discRate}%</span>
	                        </c:if>
							<strong>${l.eventTitle}</strong>
							<p>${l.eventDtlCont}</p>
							<span class="date font_t">
								<c:choose>        
									<c:when test="${not empty l.eventRangeInfo}">
										${l.eventRangeInfo}
									</c:when>        
	                            	<c:when test="${l.eventEndDt eq '99991231' || l.eventEndDt eq '99999999'}">
	                            		<ui:mask pattern="####.##.##">${l.eventStartDt}</ui:mask> ~ 
	                            	</c:when>
	                            	<c:otherwise>
	                            		<ui:mask pattern="####.##.##">${l.eventStartDt}</ui:mask> ~ <ui:mask pattern="####.##.##">${l.eventEndDt}</ui:mask>
	                            	</c:otherwise>
	                        	</c:choose>
							</span>
						</a>
					</li>
				</c:forEach>
			</ul>
		</div>
	</c:if>
	<!--// 가로 3단 배너 -->
	
	<!-- /////////이벤트 전체 배너 ///////// -->
	<c:if test="${not empty mgftEventBnrList}">
		<div class="cont cont07">
			<div class="event_banner_wrap">
				<div class="slide_banner">
					<c:forEach items="${mgftEventBnrList}" var="l" varStatus="st">
						<div class="slide-item">
							<a href="javascript:;" class="PC_MAIN_MENU_12" onclick="location.href='/ht/biz/eventDetail?eventId=${l.eventId}';return false;">
								<div class="thum">
									<ui:image src="${l.eventImageUrl}" alt="${l.eventTitle}"/>
								</div>
								<div class="desc">
									<c:if test="${not empty l.discRate && l.discRate > 0}">
										<span class="font_t percent">${l.discRate}%</span>
									</c:if>
									<strong>${l.eventTitle}</strong>
									<p>${l.eventDtlCont}</p>
									<span class="date font_t">
										<c:choose>        
											<c:when test="${not empty l.eventRangeInfo}">
												${l.eventRangeInfo}
											</c:when>        
			                            	<c:when test="${l.eventEndDt eq '99991231' || l.eventEndDt eq '99999999'}">
			                            		<ui:mask pattern="####.##.##">${l.eventStartDt}</ui:mask> ~ 
			                            	</c:when>
			                            	<c:otherwise>
			                            		<ui:mask pattern="####.##.##">${l.eventStartDt}</ui:mask> ~ <ui:mask pattern="####.##.##">${l.eventEndDt}</ui:mask>
			                            	</c:otherwise>
			                        	</c:choose>
									</span>
								</div>
							</a>
						</div>
					</c:forEach>
				</div>
				<div class="custom_paging_wrap">
					<div class="custom_paging"></div>
				</div>
			</div>
		</div>
	</c:if>
	<!--// 이벤트 전체 배너 -->

	<!-- /////////에디터 추천///////// -->
	<c:if test="${not empty mgftEditorPrdtList}">
		<div class="cont cont08">
			<h3>에디터 추천</h3>
			<div class="slide_banner">
				<ul>
					<c:forEach items="${mgftEditorPrdtList}" var="l" varStatus="st">
						<li class="PC_MAIN_MENU_13">
							<c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G' || l.sellPrdtGbn eq 'S'}">
								<a href="javascript:;" onclick="location.href='/ht/product/detail?barcode=${l.sellPrdtBcode}';return false;">
							</c:if>
							<c:if test="${l.sellPrdtGbn eq 'R' || l.sellPrdtGbn eq 'D'}">
								<a href="javascript:;" onclick="location.href='/ht/record/detail/${l.sellPrdtBcode}';return false;">
							</c:if>
								<div class="thum">
									<c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G' || l.sellPrdtGbn eq 'S'}">
	                            		<ui:image src="${l.productImageUrl}" size="600" src2="${l.productImageUrl2}" server="product" alt="${fn:escapeXml(l.prdtName)}"/>
	                            	</c:if>
									<c:if test="${l.sellPrdtGbn eq 'R'}">
	                               		<ui:image rcrdCd="${l.rcrdCd}" size="600" prdtGbn="${l.sellPrdtGbn}" alt="${fn:escapeXml(l.prdtName)}" rcrdImgType="large" ratingCode="A"/>
	                            	</c:if>
	                          		<c:if test="${l.sellPrdtGbn eq 'D'}">
	                           			<ui:image rcrdCd="${l.rcrdCd}" size="600" prdtGbn="${l.sellPrdtGbn}" alt="${fn:escapeXml(l.prdtName)}" rcrdImgType="large" ratingCode="A"/>
	                             	</c:if>
								</div>
								<div class="desc">
									<p class="tit">${l.prdtName}</p>
									<p class="price font_t">									
	                               		<fmt:parseNumber var="rate" type="number" integerOnly="true" value="${hfn:rate(l.prdtSellPrice,l.lastCpnPrice)}"/>
	                                	<c:if test="${rate > 0}">
	                                 		<span class="percent">${rate}%</span>
	                               		</c:if>
	                               		<fmt:formatNumber type="number">${l.lastCpnPrice}</fmt:formatNumber>
									</p>
								</div>
							</a>
						</li>
					</c:forEach>
				</ul>
			</div>
		</div>
	</c:if>
	<!--// 에디터 추천 -->

	<!-- /////////이벤트 세로 4단 배너///////// -->
	<c:if test="${not empty pwlcHeight4BnrList}">
		<div class="cont cont09">
			<div class="slide_banner">
				<ul>
					<c:forEach items="${pwlcHeight4BnrList}" var="l" varStatus="st">
						<li class="PC_MAIN_MENU_14">
							<strong class="font_t">0${st.count}</strong>
							<a href="javascript:;" onclick="location.href='/ht/biz/eventDetail?eventId=${l.eventId}';return false;">
								<div class="thum">
									<ui:image src="${l.eventImageUrl}" alt="${l.eventTitle}"/>
								</div>
								<p class="date font_t">
									<c:choose>        
										<c:when test="${not empty l.eventRangeInfo}">
											${l.eventRangeInfo}
										</c:when>        
		                            	<c:when test="${l.eventEndDt eq '99991231' || l.eventEndDt eq '99999999'}">
		                            		<ui:mask pattern="####.##.##">${l.eventStartDt}</ui:mask> ~ 
		                            	</c:when>
		                            	<c:otherwise>
		                            		<ui:mask pattern="####.##.##">${l.eventStartDt}</ui:mask> ~ <ui:mask pattern="####.##.##">${l.eventEndDt}</ui:mask>
		                            	</c:otherwise>
		                        	</c:choose>
			            		</p>
							</a>
							<p class="tit">${l.eventTitle}<br/>${l.eventDtlCont}</p>
						</li>
					</c:forEach>
				</ul>
			</div>
		</div>
	</c:if>
	<!--// 이벤트 세로 4단 배너 -->

	<!-- /////////기획상품///////// -->
	<c:if test="${mgftTheme1stMst.dispPrdtYn eq 'Y' || mgftTheme2ndMst.dispPrdtYn eq 'Y' || mgftTheme3rdMst.dispPrdtYn eq 'Y'
				 || mgftTheme4thMst.dispPrdtYn eq 'Y' || mgftTheme5thMst.dispPrdtYn eq 'Y'}">
		<div class="cont cont10">
			<p class="slide_num"></p>
			<div class="slide_banner">
				<ul>
					<li class="listArea">

					</li>
				</ul>
				<div class="pager">
					<ul>
						<c:set var="totalPage" value="0"/>
						<c:if test="${mgftTheme1stMst.dispPrdtYn eq 'Y'}" >
							<c:set var="totalPage" value="${totalPage + 1}"/>
							<li numbering="${totalPage}" class="PC_MAIN_MENU_15" type="pd1ST"><a href="javascript:;" onclick="main.loadTemplate(this, 'cont10');">${mgftTheme1stMst.title}</a></li>
						</c:if>
						<c:if test="${mgftTheme2ndMst.dispPrdtYn eq 'Y'}" >
							<c:set var="totalPage" value="${totalPage + 1}"/>
							<li numbering="${totalPage}" class="PC_MAIN_MENU_15" type="pd2ND"><a href="javascript:;" onclick="main.loadTemplate(this, 'cont10');">${mgftTheme2ndMst.title}</a></li>	
						</c:if>
						<c:if test="${mgftTheme3rdMst.dispPrdtYn eq 'Y'}" >
							<c:set var="totalPage" value="${totalPage + 1}"/>
							<li numbering="${totalPage}" class="PC_MAIN_MENU_15" type="pd3RD"><a href="javascript:;" onclick="main.loadTemplate(this, 'cont10');">${mgftTheme3rdMst.title}</a></li>
						</c:if>
						<c:if test="${mgftTheme4thMst.dispPrdtYn eq 'Y'}" >
							<c:set var="totalPage" value="${totalPage + 1}"/>
							<li numbering="${totalPage}" class="PC_MAIN_MENU_15" type="pd4TH"><a href="javascript:;" onclick="main.loadTemplate(this, 'cont10');">${mgftTheme4thMst.title}</a></li>
						</c:if>
						<c:if test="${mgftTheme5thMst.dispPrdtYn eq 'Y'}" >
							<c:set var="totalPage" value="${totalPage + 1}"/>
							<li numbering="${totalPage}" class="PC_MAIN_MENU_15" type="pd5TH"><a href="javascript:;" onclick="main.loadTemplate(this, 'cont10');">${mgftTheme5thMst.title}</a></li>
						</c:if>
					</ul>
				</div>
			</div>
		</div>
	</c:if>
	<!--// 기획상품 -->

	<!-- /////////도트배너 ///////// -->
	<c:if test="${not empty mgftDotBnrList}">	
		<div class="cont cont11">
			<div class="tit_cont11">
				<h2>주목!<br> 놓칠 수 없는<br> 소식</h2>
			</div>
			<div class="slide_banner">
				<ul class='clear'>
					<c:forEach items="${mgftDotBnrList}" var="l" varStatus="st">
						<li class="PC_MAIN_MENU_16">
							<a href="javascript:;" onclick="location.href='${l.bnrLnkUrl}';return false;">
								<div class="">
									<ui:image src="${l.bnrImgUrl}" alt="${l.bnrImgAlt}"/>
									<c:if test="${l.signWayGbn eq 'C1452'}">
										<div class="desc_tag">
											<p># ${l.bnrTitle}</p>
										</div>
									</c:if>
								</div>
							</a>
						</li>
					</c:forEach>
				</ul>
			</div>
			<div class="custom-pager"><strong></strong><span></span></div>
		</div>
	</c:if>
	<!--// 도트배너 -->

	<!-- /////////스페셜 에디션 ///////// -->
	<c:if test="${not empty seList[0] || not empty seList[1] || not empty seList[2] || not empty seList[3] || not empty seList[4]}">
		<div class="cont cont12">
			<a href="/ht/biz/eventDetail?eventId=47389" class="PC_MAIN_MENU_17"><h3>스페셜에디션;<span class="btn_detail">더보기</span></h3></a>
			<div class="tit_wrap">
				<h5>핫트랙스 PB</h5>
			</div>
			<div class="slide_banner">
				<ul>
					<c:forEach items="${seList}" var="lst" varStatus="stMst">
						<c:forEach items="${lst}" var="l" varStatus="st">
							<c:if test="${st.first}">
								<li class="PC_MAIN_MENU_17_1">
									<div class="desc">
										<p class="tit">${l.title}</p>
										<c:if test="${not empty l.subTitle}">
											<p class="txt">${l.subTitle}</p>
										</c:if>
										<div class="thum_list">
											<ul>
							</c:if>
											<c:if test="${st.count > 1}">
												<li>
													<c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G' || l.sellPrdtGbn eq 'S'}">
														<a href="javascript:;" onclick="location.href='/ht/product/detail?barcode=${l.sellPrdtBcode}';return false;">
													</c:if>
													<c:if test="${l.sellPrdtGbn eq 'R' || l.sellPrdtGbn eq 'D'}">
														<a href="javascript:;" onclick="location.href='/ht/record/detail/${l.sellPrdtBcode}';return false;">
													</c:if>
														<c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G' || l.sellPrdtGbn eq 'S'}">
								                      		<ui:image src="${l.productImageUrl}" src2="${l.productImageUrl2}" size="400" server="product" alt="${fn:escapeXml(l.prdtName)}"/>
								                      	</c:if>
														<c:if test="${l.sellPrdtGbn eq 'R'}">
															<ui:image rcrdCd="${l.rcrdCd}" size="400" prdtGbn="${l.sellPrdtGbn}" alt="${l.commTitle}" rcrdImgType="large" ratingCode="A"/>
														</c:if>
								               			<c:if test="${l.sellPrdtGbn eq 'D'}">
								                   			<ui:image rcrdCd="${l.rcrdCd}" size="400" prdtGbn="${l.sellPrdtGbn}" alt="${l.commTitle}" rcrdImgType="large" ratingCode="A"/>
								                		</c:if>
													</a>
												</li>
											</c:if>
							<c:if test="${st.last}">
											</ul>
										</div>
									</div>
									<div class="thum">
										<c:if test="${lst[0].sellPrdtGbn eq 'P' || lst[0].sellPrdtGbn eq 'G' || lst[0].sellPrdtGbn eq 'S'}">
											<a href="javascript:;" onclick="location.href='/ht/product/detail?barcode=${lst[0].sellPrdtBcode}';return false;">
										</c:if>
										<c:if test="${lst[0].sellPrdtGbn eq 'R' || lst[0].sellPrdtGbn eq 'D'}">
											<a href="javascript:;" onclick="location.href='/ht/record/detail/${lst[0].sellPrdtBcode}';return false;">
										</c:if>
											<c:if test="${lst[0].sellPrdtGbn eq 'P' || lst[0].sellPrdtGbn eq 'G' || lst[0].sellPrdtGbn eq 'S'}">
					                      		<ui:image src="${lst[0].productImageUrl}" src2="${lst[0].productImageUrl2}" size="400" server="product" alt="${fn:escapeXml(lst[0].prdtName)}"/>
					                      	</c:if>
											<c:if test="${lst[0].sellPrdtGbn eq 'R'}">
												<ui:image rcrdCd="${lst[0].rcrdCd}" size="400" prdtGbn="${lst[0].sellPrdtGbn}" alt="${lst[0].commTitle}" rcrdImgType="large" ratingCode="A"/>
											</c:if>
					               			<c:if test="${lst[0].sellPrdtGbn eq 'D'}">
					                   			<ui:image rcrdCd="${lst[0].rcrdCd}" size="400" prdtGbn="${lst[0].sellPrdtGbn}" alt="${lst[0].commTitle}" rcrdImgType="large" ratingCode="A"/>
					                		</c:if>
										</a>
									</div>
								</li>
							</c:if>
						</c:forEach>
					</c:forEach>
				</ul>
			</div>
		</div>
	</c:if>
	<!--// 스페셜 에디션 -->

	<!-- 라이프 -->
	<div class="cont cont13">
	</div>
	<!--// 라이프 -->

	<!-- 아지트 -->
	<div class="cont cont14">
	</div>
	<!--// 아지트 -->

	<!-- /////////카테고리별 추천///////// -->
	<c:if test="${not empty ctgryHeadList}">
		<div class="cont cont15">
			<div class="tab">
				<ul>
					<c:set var="C1491" value="디자인문구" />
					<c:set var="C1492" value="디지털" />
					<c:set var="C1493" value="고급필기구" />
					<c:set var="C1494" value="오피스" />
					<c:set var="C1495" value="리빙/생활가전" />
					<c:set var="C1496" value="키친/푸드" />
					<c:set var="C1497" value="가구/수납" />
					<c:set var="C1498" value="패션잡화" />
					<c:set var="C1499" value="뷰티/헬스" />
					<c:set var="C149A" value="여행/자동차" />
					<c:set var="C149B" value="취미/펫" />
					<c:set var="C149C" value="유아동" />
					<c:forEach items="${ctgryHeadList}" var="l" varStatus="st">
						<li type="ctgr_${l.ctgrId}" class="PC_MAIN_CATE_1">
							<a href="javascript:;" onclick="main.loadTemplate(this, 'cont15');">
								${pageScope[l.ctgrId]}
							</a>
						</li>
					</c:forEach>				
				</ul>
			</div>
	
			<div class="category_cont_wrap listArea">
				
			</div>
		</div>
	</c:if>
	<!--// 카테고리별 추천 -->

	<!-- /////////컬쳐/음반 이벤트///////// -->
	<div class="cont cont16">
		<!-- /////////컬쳐 이벤트///////// -->
		<c:if test="${not empty cultureEventList}">
			<div class="culture">
				<div class="tit PC_MAIN_EVENT_1">
					<a href="/ht/biz/hotEventMain?type=type02&newEventDispTypeCode=C1533">컬처<br/>이벤트</a>
				</div>
				<div class="slide_banner">
					<ul>
						<c:forEach items="${cultureEventList}" var="l" varStatus="st">
							<li class="PC_MAIN_EVENT_1_1">
								<span class="date font_t">
									<c:choose>        
										<c:when test="${not empty l.eventRangeInfo}">
											${l.eventRangeInfo}
										</c:when>        
		                            	<c:when test="${l.eventEndDt eq '99991231' || l.eventEndDt eq '99999999'}">
		                            		<ui:mask pattern="####.##.##">${l.eventStartDt}</ui:mask> ~ 
		                            	</c:when>
		                            	<c:otherwise>
		                            		<ui:mask pattern="####.##.##">${l.eventStartDt}</ui:mask> ~ <ui:mask pattern="####.##.##">${l.eventEndDt}</ui:mask>
		                            	</c:otherwise>
		                        	</c:choose>
								</span>
								<a href="/e/${l.eventId}">
									<p>${l.eventTitle}<br/>${l.eventDtlCont}</p>
									<div class="thum">
										<ui:image src="${l.eventImageUrl}" alt="${l.eventTitle}"/>
									</div>
								</a>
							</li>
						</c:forEach>
					</ul>
				</div>
			</div>
		</c:if>
		<!--// 컬쳐 이벤트 -->
		
		<!-- /////////음반 이벤트///////// -->
		<c:if test="${not empty musicEventList}">
			<div class="music">
				<h5>음반 이벤트</h5>
				<div class="slide_banner">
					<ul>
						<c:forEach items="${musicEventList}" var="l" varStatus="st">
							<li class="PC_MAIN_EVENT_2">
								<a href="javascript:;" onclick="location.href='/ht/biz/eventDetail?eventId=${l.eventId}';return false;">
									<div class="thum">
										<ui:image src="${l.eventImageUrl}" alt="${l.eventTitle}"/>
									</div>
									<strong>${l.eventTitle}</strong>
									<p>${l.eventDtlCont}</p>
								</a>
							</li>
						</c:forEach>
					</ul>
				</div>
			</div>
		</c:if>
		<!--// 음반 이벤트 -->
	</div>
	<!--// 컬쳐/음반 이벤트 -->

	<div class="main_bottom">
		<!-- /////////공지사항///////// -->
		<c:if test="${not empty userNoticeList}">
			<div class="cont_left">
				<a href="javascript:" class="PC_MAIN_ANNOUNCE_1" onclick="location.href='/ht/help/listNotice';return false;">
					<h3>공지사항<span class="btn_detail">더보기</span></h3>
				</a>
				<div class="board_list">
					<ul>
						<c:forEach items="${userNoticeList}" var="l" varStatus="st">
							<li class="PC_MAIN_ANNOUNCE_1_1">
								<a href="javascript:;" onclick="location.href='/ht/help/listNotice?notiSeq=${l.notiSeq}&categoryId=0000'">${l.notiTitle}</a>
							</li>
						</c:forEach>
					</ul>
				</div>
			</div>
		</c:if>
		<!--// 공지사항 -->
		
		<div class="cont_right">
			<h3>핫트랙스 서비스</h3>
			<div class="service">
				<ul>
					<li>
						<a href="/company/main" class="PC_MAIN_ANNOUNCE_2" target="_blank">
							<div class="icon"></div>
							<span>매장안내</span>
						</a>
					</li>
					<li>
						<a href="javascript:;" class="PC_MAIN_ANNOUNCE_3" onclick="location.href='/ht/help/memberShip';return false;">
							<div class="icon"></div>
							<span>멤버십 혜택</span>
						</a>
					</li>
					<li>
						<a href="javascript:;" class="PC_MAIN_ANNOUNCE_4" onclick="location.href='/ht/help/businessBuy';return false;">
							<div class="icon"></div>
							<span>대량구매</span>
						</a>
					</li>
				</ul>
			</div>
		</div>
	</div>
	
	<!-- 전체보기 레이어 -->
	<div class="layer_fullban">
        <div class="list_fullbox">
	        
          <a href="#n" class="btn_fullclose"><span>닫기</span></a>
			<c:forEach items="${pwlcRollBnrList}" var="l" varStatus="st">
				<div class="list_fullban_a">
					<div class="list_fullban">
<%-- 			<li class="${l.signWayGbn eq 'C1451' ? 'type01' : 'type02'}"> --%>
				<a href="javascript:;" class="PC_MAIN_MENU_1" onclick="location.href='${l.bnrLnkUrl}';return false;">
					<div class="thum">
						<ui:image src="${l.bnrImgUrl}" alt="${l.bnrImgAlt}"/>
					</div>
					<c:if test="${l.signWayGbn ne 'C1451'}">
						<div class="desc">
							<c:if test="${not empty l.flagCd}">
								<c:if test="${l.flagCd eq 'C1481'}">
									<span class="tag_new">NEW</span>
								</c:if>
								<c:if test="${l.flagCd eq 'C1482'}">
									<span class="tag_hot">HOT</span>
								</c:if>
								<c:if test="${l.flagCd eq 'C1483'}">
									<span class="tag_gift">사은품</span>
								</c:if>
								<c:if test="${l.flagCd eq 'C1484'}">
									<span class="tag_free">무료배송</span>
								</c:if>
								<c:if test="${l.flagCd eq 'C1485'}">
									<c:if test="${not empty l.discRate}">
										<span class="tag_percent">~<strong>${l.discRate}</strong>%</span>
									</c:if>	
								</c:if>								
							</c:if>
							<p class="tit">${l.bnrTitle}</p>
							<c:if test="${l.signWayGbn eq 'C1453'}">
								<p class="txt">${l.bnrSubTitle}</p>
							</c:if>
						</div>
					</c:if>
				</a>
				</div>
				</div>
<!-- 			</li> -->
		</c:forEach>
      </div>
	</div>
	<!--/ 전체보기 레이어 -->
	
	<c:import url="/menu/biz/quickMenu"/>
</div>	
</div>
</body>
</html>