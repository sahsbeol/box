<%@ page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<head>
<!-- 태그 라이브러리 -->
<%@ include file="/pages/decorators/biz/tagHeader.jsp" %>
<ui:decorator name="bizFull"/>
<script type="text/javascript">
$(document).ready(function() {
	sideMenu(); //side menu
	eventFn(); //event
	var eventBannerSwiper01 = new Swiper('.event_list .event_top #prod01', {
		slidesPerView: 'auto',
		spaceBetween: 8,
		speed: 1000,
		freeMode: true,
		scrollbar: '.swiper-scrollbar',
		pagination: '.swiper-pagination',
		paginationType: 'fraction',
		draggable: true
	});
	var eventBannerSwiper02 = new Swiper('.event_list .event_top #prod02', {
		slidesPerView: 'auto',
		spaceBetween: 8,
		speed: 1000,
		init:true,
		freeMode: true,
		scrollbar: '.swiper-scrollbar',
		pagination: '.swiper-pagination',
		paginationType: 'fraction',
		draggable: true
	});

	$(".event_top .swiper-container").hide();
	$(""+$(".event_top .tab ul li.active a").attr("href")+"").show();
    $(".event_top .tab ul li").click(function(){
        $(this).parent().children("li").removeClass("active");
        $(this).addClass("active");
        $(this).parent().parent().parent().find(".swiper-container").hide();
        $(this).parent().parent().parent().find(".event_bnr").hide();
        $($(this).children("a").attr("href")).show();
    	eventBannerSwiper02.init();
        eventBannerSwiper02.init();
        checkClass();
        return false;
    });
    $(".event_list .cont .tab ul li").click(function(){
        $(this).parent().children("li").removeClass("active");
        $(this).addClass("active");
        if ($(this).children("a").attr("href")=="type01") {$(".type01").show();$(".type02").hide();}
        else {$(".type02").show();$(".type01").hide();}
        return false;
    });
    
});

function getEventList(orderBy,codeNum,type){
	var str = "";
	str+="type="+type+"&codeNum="+codeNum;
	str+="&orderBy="+$("."+type+"").find("select").val();
	
	$("#loading").show();
	$.ajax({
	    type: "GET"
	   ,async:false
	   ,url: "/m/biz/eventTemplate?"+str
	   ,dataType: "html"
	   ,success : function(htmlStr){
		   	//실시간 인기&베스트
		       if (type == "type01") {
					$(".type01 .event_banner ul").empty();
					$(".type01 .event_banner ul").append(htmlStr);
					$(".type01 .swiper-wrapper .swiper-slide").removeClass("active");
					$(".type01 .swiper-wrapper [codeNum=" + codeNum + "]").addClass("active");
					var str = $(".type01 .event_banner ul").find("li[listcount]").attr("listcount");
					if (str == null || str == "") {str="0";}
					$(".type01 .pd_filter p em").empty();
					$(".type01 .pd_filter p em").append(str);
				} else {
					$(".type02 #eventList ul").empty();
					$(".type02 #eventList ul").append(htmlStr);
					$(".type02 #eventList").removeClass();
					var str = '';
					if (codeNum=="C1533") {
						$(".type02 #eventList").addClass("event_culture");
						str = $(".event_culture ul").find("li[listcount]").attr("listcount");
					}else{
						$(".type02 #eventList").addClass("event_banner");
						str = $(".type02 .event_banner ul").find("li[listcount]").attr("listcount");
					}
					$(".type02 .list_tab ul li").removeClass("active");
					$(".type02 .list_tab ul [codeNum=" + codeNum + "]").addClass("active");
					
					if (str == null || str == "") {str="0";}
					$(".type02 .pd_filter p em").empty();
					$(".type02 .pd_filter p em").append(str);
				}
		       $(".pagination_v2."+type+"").empty();
		       $(".pagination_v2."+type+"").append($("#pagination_v2").html());
		       $("#pagination_v2").empty();
	       	$("#loading").hide();
	   }
	   ,error: function(data) {
	       alert('<fmt:message key="error.common.system"/>');
	       $("#loading").hide();
	   }
	});
	
};
function getEventSort(orderBy,type){
	getEventList(orderBy,$("."+type+"").find(".active").attr("codeNum"),type);
};
//페이지 이동
function goList(page){
	var typeGbn = $(".cont .tab ul li.active a").attr("href");
	var orderBy = $("."+typeGbn+"").find(".form_select select option:selected").attr("value");
	if (typeGbn=="type01") {
		location.href="?orderBy="+orderBy+"&ctgrId="+$("."+typeGbn+" .category_nav_wrap").find(".active").attr("codeNum")+"&type="+typeGbn+"&page="+page;
	} else {
		location.href="?orderBy="+orderBy+"&newEventDispTypeCode="+$("."+typeGbn+" .list_tab").find(".active").attr("codeNum")+"&type="+typeGbn+"&page="+page;
	}
       
}
function checkClass(){
	if ($(""+$(".event_top .tab ul li.active a").attr("href")+"").hasClass("case2")) {
		$(".event_list").removeClass("case1");
		$(".event_list").removeClass("case2");
		$(".event_list").addClass("case2");
	}else{
		$(".event_list").removeClass("case1");
		$(".event_list").removeClass("case2");
		$(".event_list").addClass("case1");
	}
}
</script>
<title>HOTTRACKS - 생활 속 감성충전소</title>
</head>
 	<!-- content -->
	<div id="content">
		<div class="event_list">
			<!-- 인기/마감임박 -->
			<div class="event_top">
				<div class="tab">
					<ul>
						<li class="active"><a href="#prod01">반응최고</a></li>
						<c:if test="${not empty mainlist2}">
							<li><a href="#prod02">마감임박</a></li>
						</c:if>
					</ul>
				</div>
				<c:forEach varStatus="s1" begin="1" end="2"> 
					<c:if test="${s1.index eq 1}"><c:set var="evtBnrList" value="${mainlist1}"/></c:if>
                    <c:if test="${s1.index eq 2}"><c:set var="evtBnrList" value="${mainlist2}"/></c:if>
                    <c:if test="${not empty evtBnrList}">
				<div id="prod0${s1.index}" class="<c:if test="${fn:length(evtBnrList) > 1}">swiper-container case2</c:if><c:if test="${fn:length(evtBnrList) <= 1}">event_banner case1</c:if>">
					<div class="swiper-wrapper">
            			<c:forEach items="${evtBnrList}" var="l">
						<div class="swiper-slide">
							<a href="/m/biz/eventDetail?eventId=${l.eventId}" title="${l.eventTitle}" style="display:block;">
								<div class="thum">
									<ui:image src="${l.imageUrl}" alt="${l.eventTitle}" />
									<fmt:parseDate var="tDate" value="${now}" pattern="yyyyMMdd" type="date"/>
				        			<fmt:parseNumber value="${tDate.time / (1000*60*60*24)}" integerOnly="true" var="itDate" scope="request" />
									<fmt:parseDate var="sDate" value="${l.eventEndDt}" pattern="yyyyMMdd" type="date"/>
							        <fmt:parseNumber value="${sDate.time / (1000*60*60*24)}" integerOnly="true" var="isDate" scope="request" />
									<c:if test="${(isDate-itDate) < 3 && s1.index eq 2}">
									<span class="font_t label">
										<c:if test="${(isDate-itDate) eq 0 }">D-DAY</c:if>
										<c:if test="${(isDate-itDate) eq 1 }">D-1</c:if>
										<c:if test="${(isDate-itDate) eq 2 }">D-2</c:if>
									</span>
									</c:if>
								</div>
								<c:if test="${not empty l.dispDscntRate}">
									<span class="font_t percent">${l.dispDscntRate}%</span>
								</c:if>
								<strong>${fn:escapeXml(l.eventTitle)}</strong>
								<p>${fn:escapeXml(l.eventDtlCont)}</p>
								<!--eventEndDt-->
							</a>
						</div>
						</c:forEach>
					</div>
					<!-- 스크롤바 -->
					<div class="swiper-scrollbar"></div>
					<!-- swiper-pagination -->
					<div class="pagination_wrap">
						<div class="swiper-pagination"></div>
					</div>
				</div>
				<script>
					checkClass();
				</script>
			</c:if>
				</c:forEach>
			<!--// 인기/마감임박 -->
			</div>
			<!-- 상품기획전/혜택이벤트 -->
			<div class="cont">
				<div class="tab">
					<ul>
						<li class="active"><a href="type01">상품기획전</a></li>
						<li><a href="type02">혜택이벤트</a></li>
					</ul>
				</div>
				<!-- 상품기획전 -->
				<div class="type01">
					<div class="category_nav_wrap">
						<div class="swiper-container">
							<div class="swiper-wrapper">
								<div codeNum="0000" class="swiper-slide <c:if test="${c.ctgrId eq '0000'}">active</c:if>">
									<a href="javascript:getEventList('${c.orderBy}','0000','type01');">전체</a>
								</div>
								<div codeNum="000020" class="swiper-slide  <c:if test="${c.ctgrId eq '000020'}">active</c:if>">
									<a href="javascript:getEventList('${c.orderBy}','000020','type01');">디자인문구</a>
								</div>
								<div codeNum="000022" class="swiper-slide <c:if test="${c.ctgrId eq '000022'}">active</c:if>">
									<a href="javascript:getEventList('${c.orderBy}','000022','type01');">디지털</a>
								</div>
								<div codeNum="000007" class="swiper-slide <c:if test="${c.ctgrId eq '000007'}">active</c:if>">
									<a href="javascript:getEventList('${c.orderBy}','000007','type01');">고급필기구</a>
								</div>
								<div codeNum="000021" class="swiper-slide <c:if test="${c.ctgrId eq '000021'}">active</c:if>">
									<a href="javascript:getEventList('${c.orderBy}','000021','type01');">오피스</a>
								</div>
								<div codeNum="000025" class="swiper-slide <c:if test="${c.ctgrId eq '000025'}">active</c:if>">
									<a href="javascript:getEventList('${c.orderBy}','000025','type01');">리빙/생활가전</a>
								</div>
								<div codeNum="000026" class="swiper-slide <c:if test="${c.ctgrId eq '000026'}">active</c:if>">
									<a href="javascript:getEventList('${c.orderBy}','000026','type01');">키친/푸드</a>
								</div>
								<div codeNum="000024" class="swiper-slide <c:if test="${c.ctgrId eq '000024'}">active</c:if>">
									<a href="javascript:getEventList('${c.orderBy}','000024','type01');">가구/수납</a>
								</div>
								<div codeNum="000028" class="swiper-slide <c:if test="${c.ctgrId eq '000028'}">active</c:if>">
									<a href="javascript:getEventList('${c.orderBy}','000028','type01');">패션잡화</a>
								</div>
								<div codeNum="000006" class="swiper-slide <c:if test="${c.ctgrId eq '000006'}">active</c:if>">
									<a href="javascript:getEventList('${c.orderBy}','000006','type01');">뷰티/헬스</a>
								</div>
								<div codeNum="000027" class="swiper-slide <c:if test="${c.ctgrId eq '000027'}">active</c:if>">
									<a href="javascript:getEventList('${c.orderBy}','000027','type01');">여행/자동차</a>
								</div>
								<div codeNum="000023" class="swiper-slide <c:if test="${c.ctgrId eq '000023'}">active</c:if>">
									<a href="javascript:getEventList('${c.orderBy}','000023','type01');">취미/펫</a>
								</div>
								<div codeNum="000029" class="swiper-slide <c:if test="${c.ctgrId eq '000029'}">active</c:if>">
									<a href="javascript:getEventList('${c.orderBy}','000029','type01');">유아동</a>
								</div>
								<div codeNum="0003" class="swiper-slide <c:if test="${c.ctgrId eq '0003'}">active</c:if>">
									<a href="javascript:getEventList('${c.orderBy}','0003','type01');">CD</a>
								</div>
								<div codeNum="0004" class="swiper-slide <c:if test="${c.ctgrId eq '0004'}">active</c:if>">
									<a href="javascript:getEventList('${c.orderBy}','0004','type01');">DVD/BLU-RAY</a>
								</div>
							</div>
						</div>
					</div>
					<div class="pd_filter">
						<p class="pd_total"><em class="font_t">${listCount}</em>건</p>
						<div class="form_select">
							<select onchange="javascript:getEventSort(this.value,'type01')">
								<option value="N"<c:if test="${c.orderBy eq 'N' || c.orderBy eq null}"> selected</c:if>>최근등록순</option>
								<option value="O"<c:if test="${c.orderBy eq 'O'}"> selected</c:if>>마감임박순</option>
								<option value="P"<c:if test="${c.orderBy eq 'P'}"> selected</c:if>>인기순</option>
							</select>
						</div>
					</div>
					<!-- 이벤트 목록 -->
					<div class="event_banner">
						<ul>
							<c:forEach items="${list}" var="l" varStatus="st">
							<li>
								<a href="/m/biz/eventDetail?eventId=${l.eventId}">
									<div class="img_wrap">
										<ui:image src="${l.imageUrl}" alt="${l.eventTitle}" />
									</div>
									<c:if test="${not empty l.dispDscntRate}">
										<span class="font_t percent">${l.dispDscntRate}%</span>
									</c:if>
									<strong>${fn:escapeXml(l.eventTitle)}</strong>
									<p>${fn:escapeXml(l.eventDtlCont)}</p>
									<span class="date font_t"><ui:mask pattern="####.##.##">${l.eventStartDt}</ui:mask> ~ <ui:mask pattern="####.##.##">${l.eventEndDt}</ui:mask></span>
								</a>
							</li>
							</c:forEach>
						</ul>
					</div>
					<!--// 이벤트 목록 -->
				</div>
				<!--// 상품기획전 -->

				<!-- 혜택이벤트 -->
				<div class="type02" style="display:none;">
					<div class="list_tab">
						<ul>
							<li codeNum="C1532"<c:if test="${c.newEventDispTypeCode eq 'C1532' || c.newEventDispTypeCode eq '' || empty c.newEventDispTypeCode}"> class="active" </c:if>>
								<a href="javascript:getEventList('${c.orderBy}','C1532','type02');">쿠폰/혜택</a>
							</li>
							<li codeNum="C1533"<c:if test="${c.newEventDispTypeCode eq 'C1533'}"> class="active"</c:if>>
								<a href="javascript:getEventList('${c.orderBy}','C1533','type02');">컬쳐</a>
							</li>
							<li codeNum="C1534"<c:if test="${c.newEventDispTypeCode eq 'C1534'}"> class="active"</c:if>>
								<a href="javascript:getEventList('${c.orderBy}','C1534','type02');">우수고객존</a>
							</li>
						</ul>
					</div>
					<div class="pd_filter">
						<p class="pd_total"><em class="font_t"><fmt:formatNumber type="number">${listCount2}</fmt:formatNumber></em>건</p>
						<div class="form_select">
							<select onchange="javascript:getEventSort(this.value,'type02')">
								<option value="N"<c:if test="${c.orderBy eq 'N' || c.orderBy eq null}"> selected</c:if>>최근등록순</option>
								<option value="O"<c:if test="${c.orderBy eq 'O'}"> selected</c:if>>마감임박순</option>
								<option value="P"<c:if test="${c.orderBy eq 'P'}"> selected</c:if>>인기순</option>
							</select>
						</div>
					</div>
					<!-- 쿠폰/혜택, 컬처 , 우수고객존-->
					<div class="event_banner" id="eventList">
						<ul>
							<c:forEach items="${evtBnrList1}" var="l">
							<li>
								<a href="/m/biz/eventDetail?eventId=${l.eventId}">
									<div class="img_wrap">
										<ui:image src="${l.imageUrl}" alt="${l.eventTitle}" />
									</div>
									<c:if test="${not empty l.dispDscntRate}">
										<span class="font_t percent">${l.dispDscntRate}%</span>
									</c:if>
									<strong>${fn:escapeXml(l.eventTitle)}</strong>
									<p>${fn:escapeXml(l.eventDtlCont)}</p>
									<span class="date font_t"><ui:mask pattern="####.##.##">${l.eventStartDt}</ui:mask> ~ <ui:mask pattern="####.##.##">${l.eventEndDt}</ui:mask></span>
								</a>
							</li>
							</c:forEach>
						</ul>
						<!-- swiper-pagination -->
					</div>
					<!--// 컬처 -->
				</div>
				<!--// 혜택이벤트 -->
			</div>
			<!--// 상품기획전/혜택이벤트 -->
		<div class="pagination_v2 type01">
			<ui:bizpaginationScript name="pageHolder1" scriptName="goList"/>
		</div>
		<div class="pagination_v2 type02" style="display:none;">
			<ui:bizpaginationScript name="pageHolder2" scriptName="goList"/>
		</div>
		</div>
	</div>
	<!--// content -->
