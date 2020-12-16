<%@page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<!-- 태그 라이브러리 -->
<%@ include file="/pages/decorators/biz/tagHeader.jsp" %>
<ui:decorator name="bizHt"/>
<jsp:useBean id="now" class="java.util.Date" />
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
<script type="text/javascript" src="/js/jquery.form.js"></script>
<!--  SNS 공유 내용 -->
<style type="text/css">
.timetable {overflow:hidden; }
.timetable .timetable_top img { width:100%; }
.timetable .timetable_bottom { /* padding-top:39px; */ }
.timetable .timetable_bottom img { width:100%; }
.timetable .sun { color:#e43724 !important; }
.timetable .sat { color:#2226e3 !important; }
.timetable .table { width:100%;border-collapse:separate;border-spacing:2px;background:none;padding:5px;border-radius:5px; }
.timetable .table thead th { color:#fff;font-family:Arial;line-height:40px;font-size:14px;font-weight:bold;background-color: #ff8393; }
.timetable .table tbody td { position:relative;text-align:center;vertical-align:middle;height:90px;background-color:#fff; }
.timetable .table tbody td .date { position:absolute;left:0;top:0;text-align:left;padding:10px;font-size:15px;font-family:'돋움','Dotum';background:none;line-height:12px;color:#666; }
.timetable .table tbody td .checked { display:block;text-indent:-999px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;width:100%;height:100%; }
/* .timetable .table tbody td .checked01 { background:url('http://image.kyobobook.co.kr/newimages/giftshop_new/work/1874/1522828543421_icon_1.png') no-repeat 50% 50%; } */
.timetable .table tbody td .checked01 { background:url('http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/event/68182/check.png') no-repeat 50% 50%; }
.timetable .table tbody td .checked02 { background:url('http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/event/59855/check.png') no-repeat 50% 50%; }
.timetable .table tbody td .checked03 { background:url('http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/event/67710/check_icon.png') no-repeat 50% 50%; }
.timetable .table tbody td a { padding-top: 1.3rem;font-size: 14px; text-align: center;font-family:'돋움','Dotum'; }
.timetable .table tbody td a.date02 { padding-top:10px;font-size:2em;font-weight:bold;font-family:Arial; }
.timetable .table tbody td a span { color:#000;font-weight:bold; }
.timetable .table tbody td a span.G { color:#f25f2b; }
.timetable .table tbody td a span.C { color:#e4fce6; }
.timetable .table tbody td a span.txt01 { color:#6c3bda; }
.timetable .table tbody td a span.txt02 { color:#868686; }
.timetable .txt_cpn { color: #41b749; }
.timetable .txt_gift { color: #f47020; }
.timetable .info_box { display:block;text-align: center;background:none;padding:10px 0 20px;border:none;margin:0; }
.timetable .info_box .info_cnt { position:relative;line-height:25px;color:#fff;display:inline-block;font-family:Arial;font-size:15px; }
.timetable .info_box .info_cnt + .info_cnt { margin-left:20px; } 
.timetable .info_box .info_cnt.point { padding-left:67px;background:url('http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/event/44731/txt_point.png') no-repeat 0 50%;background-size:auto 100%; }
.timetable .info_box .info_cnt.coupon { padding-left:57px;background:url('http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/event/44731/txt_coupon.png') no-repeat 0 50%;background-size:auto 100%; }
</style> 
<script type="text/javascript">
isLogin = ${isLogin};
var itemList = new Array(); 
var check_68151 = 0; 
$(document).ready(function(){
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
	
	var eventId = '${detail.eventId}';
	if(eventId == '64631'){
		for(var i=0; i < itemList.length; i++){
			$('#'+itemList[i]).addClass('on');
		}
	}
});
function getCategory(ctgrId){
	$('.c_select .location_1').text($('li[ctgrId='+ctgrId+'] a').text());
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
function onCalClick(giftType, couponId){
	var eventId = '${detail.eventId}';
	if(eventId == '68182'){
		alert('모바일에서만 참여 가능합니다.');
		return false;
	}
	
    if (!isLogin) {
        needLogin();
    } else {
        if(giftType == 'C'){
            $.ajax({
                type: "POST"
                ,url:"/ht/coupon/productCouponDown"
                ,dataType: 'json'
                ,data : {couponId : couponId}
                ,success: function(data) {
                    if (data.result) {
                        if(data.result["V_RES_CODE"] == '200'){
                            successProc();
                        }else{
                            alert(data.result["V_RES_CONT"]);
                        }
                    } else {
                        alert('쿠폰 다운로드 중 오류가 발생하였습니다. 잠시후 다시 이용해주세요.');
                    }
                }
            });
        }else{
            successProc();
        }
    }
}
function successProc(){
    $.ajax({
        type: 'POST'
        ,url: '/ht/hot/saveCheckEvent'
        ,data: {eventId:"${detail.eventId}"}
        ,dataType: 'json'
        ,success: function(data) {
            alert(data.alert);
            if (data.save) {
                location.reload(true);
            }
        }
        ,error: function(data) {
            alert('출석체크 중 오류가 발생하였습니다. 잠시 후 다시 이용해주세요');
        }
    });
}

//68151 이벤트 1회용
function eventRequest_68151(eventNum) {
	var date = new Date();
	
	var yy = date.getFullYear();
	var mm = date.getMonth()+1;
	var dd = date.getDate();
	
	if((mm+"").length < 2){
		mm = "0"+mm;
	}
	if((dd+"").length < 2){
		dd = "0"+dd;
	}
	var today_68151 = yy+''+mm+''+dd;
	
	if(today_68151 == '20200609' && check_68151 == 0){
		alert('오늘의 미션을 수행하고 도전해주세요! (5day)');
		return false;
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
                	onCalClick();
                } else {
                    if(data.msg.indexOf('2day') != -1){
                    	alert('앱푸시 동의하기 미션은 모바일에서만 가능합니다.');
                		return false;
                    }else if(data.msg.indexOf('5day') != -1){
                    	onCalClick();
                    }else{
                    	alert(data.msg);
                    }
                }
            }
            ,error: function() {
                alert('<fmt:message key="error.common.system"/>');
            }
        });
    }
}

function goModifyMemberInfo_68151(){
	check_68151++;
	
	if(!serviceCheck() && confirm("회원정보수정은 회원통합관리 정책에 따라 인터넷교보문고(http://www.kyobobook.co.kr)에서 가능합니다. 이동하시겠습니까?\n회원정보를 수정하시는 경우, 재로그인 하셔야 변경된 정보가 반영됩니다.")){
        window.open('https://order.kyobobook.co.kr/myroom/commIframe?targetUrl=//www.kyobobook.co.kr/myroom/joinModFormIframe.laf?iframe_yn=Y', '_blank'); 
    }
}

</script>
</head>
<body>
<c:if test="${detail.eventId eq '64631'}">
	<c:forEach items="${history}" var="l">
		<c:if test="${l.checkYn}">
		    <script type="text/javascript">
		    	itemList.push('${l.eventDt}');
			</script>
		</c:if>
	</c:forEach>
</c:if>
<div class="event_top">
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
<c:set var="checkYn" value="false"/>
<c:set var="giftType" value="N"/>
<c:set var="cpnId" value=""/>
<c:forEach items="${history}" var="l">
    <c:if test="${l.eventDt eq today}">
        <c:set var="giftType">${l.giftType}</c:set>
        <c:set var="checkYn">${l.checkYn}</c:set>
        <c:set var="cpnId">${l.cpnId}</c:set>
    </c:if>
</c:forEach>
<c:if test="${detail.eventDispScrnCode eq 'C0201' || detail.cultZoneYn eq 'Y'}"><c:set var="isFull" value="N"/></c:if>
<c:if test="${detail.eventDispScrnCode ne 'C0201' && detail.cultZoneYn ne 'Y'}"><c:set var="isFull" value="Y"/></c:if>
	<div class="event_title">
       <h5>${detail.eventTitle}</h5>
       <p class="date font_t">
        <c:choose>
                     <c:when test="${not empty detail.eventRangeInfo && detail.eventRangeInfo ne ' '}"><em class="font_ns">${detail.eventRangeInfo}</em></c:when>
                     <c:otherwise><ui:mask pattern="####.##.##">${detail.eventStartDt}</ui:mask> <span>~</span> <ui:mask pattern="####.##.##">${detail.eventEndDt}</ui:mask></c:otherwise>
                 </c:choose>
       </p>
   </div>
	<div class="inner950">
    <c:if test="${isFull ne 'Y'}">
        <c:if test="${detail.cultZoneYn eq 'Y'}"><div style="border: 5px solid #f5f5f1;float:left;padding: 45px 0 50px;text-align: center;width: 170px;margin-right:15px;"><a href="/ht/culture/main"><img src="${imageServer}/images/renewal/common/tit_culture_zone02.gif" alt="CULTURE ZONE"/></a></div></c:if>
        <c:if test="${detail.cultZoneYn ne 'Y' && not empty detail.brandId}"><div class="brand_name"><a href="/ht/biz/hot/brandDetail?brandId=${detail.brandId}"><ui:image src="${detail.brandImageUrl}" server="brand" width="170" height="170" alt="${detail.brandName}"/></a></div></c:if>
        <c:if test="${detail.cultZoneYn ne 'Y' && empty detail.brandId}"><div class="brand_name"><a style="cursor: default;" href="javascript://"><ui:image src="${detail.brandImageUrl}" server="brand" width="170" height="170"/></a></div></c:if>
    </c:if>
    <div class="ly_box_skip">
        <p>종료된 이벤트 입니다.</p>
    </div>
    <div class="event_info">
        <c:if test="${not empty detail.imageUrl950 }">
            <!-- 이벤트 튼 배경화면 -->
            <script type="text/javascript">
            $("#container").css("background", "url('http://image.kyobobook.co.kr/newimages/giftshop_new/work/${detail.imageUrl950}') no-repeat 50% 392px");
            </script>
            <!-- //이벤트 튼 배경화면 -->
        </c:if>
        <div class="timetable">
            <div class="timetable_top">
                <c:if test="${not empty detail.imageUrl}"><div><ui:image src="${detail.imageUrl}" id="eventImageUrl" usemap="#eventImageMap" clazz="sns_img"/></div></c:if>
                <c:if test="${detail.userTmplUseYn eq 'Y'}"><div>${detail.userTmpl}</div></c:if>
            </div>
            <c:if test="${not empty history}">
	            <c:if test="${detail.eventId ne '64631'}">
	            <table class="table checkTable">
	                <colgroup>
	                    <col width="14.3%"/>
	                    <col width="14.3%"/>
	                    <col width="14.3%"/>
	                    <col width="14.3%"/>
	                    <col width="14.3%"/>
	                    <col width="14.3%"/>
	                    <col width="14.2%"/>
	                </colgroup>
	                <thead>
	                    <tr>
	                       <th scope="row" class="sun">SUN</th>
	                       <th scope="row">MON</th>
	                       <th scope="row">TUE</th>
	                       <th scope="row">WED</th>
	                       <th scope="row">THU</th>
	                       <th scope="row">FRI</th>
	                       <th scope="row" class="sat">SAT</th>
	                    </tr>
	                </thead>
	                <tbody>
	                    <c:forEach items="${history}" varStatus="s1" step="7">
	                        <tr>
	                            <c:forEach items="${history}" var="l" varStatus="st" begin="${s1.index}" end="${s1.index + 6}">
	                                <fmt:formatNumber var="dt" value="${fn:substring(l.eventDt, 6, 8)}"/>
	                                <td id="${st.index+1}">
	                                    <c:choose>
	                                        <c:when test="${l.checkYn}">
	                                            <c:choose>
	                                                <c:when test="${l.giftType eq 'G' && l.giftName eq '출석체크' && l.eventId eq '67710'}"><span class="checked checked03">출석완료</span></c:when>
	                                                <c:when test="${l.giftType eq 'G' && l.giftName eq '출석체크'}"><span class="checked checked01">출석완료</span></c:when>
	                                                <c:otherwise><span class="checked checked02">응모완료</span></c:otherwise>
	                                            </c:choose>
	                                        </c:when>
	                                        <c:when test="${l.giftType eq 'G' && l.giftName eq '출석체크'}">
	                                            <a href="#" onclick="onCalClick();return false;" class="date02 <c:if test="${st.count eq 1}"> sun</c:if><c:if test="${st.count eq 7}"> sat</c:if>" class="${l.giftType }">${dt}</a>
	                                        </c:when>
	                                        <c:otherwise>
	                                            <c:choose>
	                                                <c:when test="${l.giftType eq 'N'}">
	                                                    &nbsp;
	                                                </c:when>
	                                                <c:otherwise>
	                                                    <span class="date<c:if test="${st.count eq 1}"> sun</c:if><c:if test="${st.count eq 7}"> sat</c:if>" class="${l.giftType }">${dt}</span>
	                                                    <c:set var="ment" value=""/>
	                                                    <c:choose>
	                                                        <c:when test="${l.giftType eq 'P'}">
	                                                            <c:choose>
	                                                                <c:when test="${l.limitCnt > 0}"><c:set var="ment"><span class="txt01">랜덤<br/>포인트</span></c:set></c:when>
	                                                                <c:otherwise><c:set var="ment"><span class="txt02">${l.giftAmt}P</span></c:set></c:otherwise>
	                                                            </c:choose>
	                                                        </c:when>
	                                                        <c:when test="${l.giftType eq 'C'}">
	                                                            <c:set var="ment">
	                                                                <c:choose>
	                                                                    <c:when test="${l.cpnAmt eq 1000}"><c:set var="couponAmt" value="천"/></c:when>
	                                                                    <c:when test="${l.cpnAmt eq 2000}"><c:set var="couponAmt" value="2천"/></c:when>
	                                                                    <c:when test="${l.cpnAmt eq 10000}"><c:set var="couponAmt" value="1만"/></c:when>
	                                                                </c:choose>
	                                                                <span class="txt_cpn ${l.giftType}">${couponAmt}원<br/> 쿠폰</span>
	                                                            </c:set>
	                                                        </c:when>
	                                                        <c:when test="${l.giftType eq 'G'}">
	                                                            <c:if test="${l.pwnrYn eq 'Y'}"><c:set var="ment"><span class="txt_gift ${l.giftType }">${l.limitCnt}명<br/><ui:br>${l.giftName}</ui:br></span></c:set></c:if>
	                                                        </c:when>
	                                                    </c:choose>
	                                                    <a class="${l.giftType}" href="#" onclick="onCalClick();return false;">${ment}</a>
	                                                </c:otherwise>
	                                            </c:choose>
	                                        </c:otherwise>
	                                    </c:choose>
	                                </td>
	                            </c:forEach>
	                        </tr>
	                    </c:forEach>
	                </tbody>
	            </table>
	            </c:if>
            </c:if>
            <c:if test="${not empty detail.userTmplHtml}">
                <div id="userTemplate"></div>
                <textarea name="userTmplHtml" style="display:none;">${detail.userTmplHtml}</textarea>
                <script src="/js/fn_htts_event_template.js?201810041520" type="text/javascript"></script>
            </c:if>
            <%--
            <div class="info_box">
                <c:set var="giftAmt" value="${mypoint.giftAmt}"/>
                <c:set var="cpnAmt" value="${mypoint.cpnAmt}"/>
                <c:if test="${empty giftAmt}"><c:set var="giftAmt" value="0"/></c:if>
                <c:if test="${empty cpnAmt}"><c:set var="cpnAmt" value="0"/></c:if>
                <span class="info_cnt point"><fmt:formatNumber type="number">${giftAmt}</fmt:formatNumber></span>
                <span class="info_cnt coupon"><fmt:formatNumber type="number">${cpnAmt}</fmt:formatNumber></span>
            </div>
            --%>
            <c:if test="${detail.eventId eq '53354'}">
                <div class="timetable_bottom">
                    <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/1106/1527732718868_53354_1920_05.jpg" usemap="#eventImageMap2" />
                    <!-- 출석체크하기 버튼-->
                    <map name="eventImageMap2">
                        <area shape="rect" coords="179,175,769,281" href="#" onclick="onCalClick();return false;">
                    </map>
                </div>
            </c:if>
            <c:if test="${detail.eventId eq '54038'}">
                <div class="timetable_bottom">
                    <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/1192/1530248984706_54038_1920_05.jpg" usemap="#eventImageMap2" />
                    <!-- 출석체크하기 버튼-->
                    <map name="eventImageMap2">
                        <area shape="rect" coords="169,152,780,285" href="#" onclick="onCalClick();return false;"/>
                    </map>
                </div>
            </c:if>
            <c:if test="${detail.eventId eq '57396'}">
                <div class="timetable_bottom">
                    <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/1799/1545105727084_57396_1920_bottomgift_02.jpg" usemap="#eventImageMap2" />
                </div>
            </c:if>
            
            <c:if test="${detail.eventId eq '58371'}">
                <div class="timetable_bottom">
                    <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/1799/58371_1920_05_1.jpg" usemap="#eventImageMap2" />
                </div>
            </c:if>
            
            <c:if test="${detail.eventId eq '59855'}">
                <div class="timetable_bottom">
                    <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/event/59855/59855_bottom_1.jpg" usemap="#eventImageMap2" />
                </div>
            </c:if>
            
            
        </div><!-- //.timetable -->
        <!-- link -->
        <c:choose>
            <c:when test="${detail.offLineYn eq 0}">
                <div class="event_link event_link0">
                    <ul>
                        <c:forEach items="${listDisplayType}" var="l">
                            <c:if test="${l.titleUseYn eq 'Y' && l.titleExpsYn eq 'Y'}">
                                <c:choose>
                                    <c:when test="${not empty l.titleImageUrl}">
                                        <li><a href="#event-link${l.eventTypeInseq}" title="${l.eventTitle}"><em class="ic_cover"></em><span><ui:image src="${l.titleImageUrl}"/></span></a></li>
                                    </c:when>
                                    <c:otherwise>
                                        <li><a href="#event-link${l.eventTypeInseq}" title="${l.eventTitle}"><span>${l.eventTitle}</span></a></li>
                                    </c:otherwise>
                                </c:choose>
                            </c:if>
                        </c:forEach>
                    </ul>
                </div>
            </c:when>
            <c:otherwise>
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
            </c:otherwise>
        </c:choose>
        <!-- /link -->
        <c:choose>
            <c:when test="${detail.offLineYn eq 0}">
                <script type="text/javascript">
                    $(".event_link li a").click(function(e){
                        e.preventDefault();
                        _eventTypeInseq = $(this).attr("href").replace("#event-link", "");
                        loadProduct(1);
                        $(".event_link li a.active").removeClass("active");
                        $(this).addClass("active");
                        $(window).scrollTop($(".event_link").offset().top - 15);
                    });
                    
                    var _eventTypeInseq;
                    var _pageHolder;
                    function loadProduct(page){
                        $.ajax({
                            url:"/ht/hot/getEventProduct"
                          , async:false
                          , data: {eventId:"${detail.eventId}",eventTypeInseq:_eventTypeInseq,page:page}
                          , type:"POST"
                          , dataType:"json"
                          , success:function(data){
                                var obj = document.getElementById("listProduct");
                                _removeChild(obj);
                                
                                if(data && data.listProduct){
                                    var list = data.listProduct;
                                    
                                    var div = _createSimpleElement("div", null, "prod_list_normal");
                                    obj.appendChild(div);
                                    
                                    for(var i = 0; i < list.length; i += 4){
                                        var ul = _createSimpleElement("ul");
                                        div.appendChild(ul);
                                        
                                        for(var j = i; j < list.length && j < i+4; j++){
                                            var product = list[j];
                                            var detailLink = "/p/" + product.sellPrdtBcode;
                                            var imgUrl = null;
                                            var imgUrl2 = null;
                                            if(product.sellPrdtGbn == "R" || product.sellPrdtGbn == "D"){
                                                detailLink = "/ht/record/detail/" + product.sellPrdtBcode;
                                                imgUrl = _imgRecordUrl(product.rcrdCd, product.sellPrdtGbn, "midi");
                                            }else{
                                                detailLink = "/ht/product/detail?barcode=" + product.sellPrdtBcode;
                                                imgUrl = productImageUrl(product.prdtImageUrl, "200");
                                                if(!_isEmpty(product.productImageUrl2)){
                                                    imgUrl2 = productImageUrl(product.productImageUrl2, "200");
                                                }
                                            }
                                            
                                            var li = _createSimpleElement("li");
                                            ul.appendChild(li);
                                            
                                            var span = _createSimpleElement("span", null, "img");
                                            li.appendChild(span);
                                            
                                            var anchor = _createSimpleElement("a");
                                            anchor.href = detailLink;
                                            span.appendChild(anchor);
                                            
                                            var img = _createSimpleElement("img");
                                            img.src = imgUrl;
                                            if(!_isEmpty(imgUrl2)){
                                                var hndlOver = function(imgUrl){ return function(e){ this.src = imgUrl; }; };
                                                _addEvent(img, "mouseover", hndlOver(imgUrl2));
                                                _addEvent(img, "mouseout", hndlOver(imgUrl));
                                            }
                                            anchor.appendChild(img);
                                            
                                            var hide_util = _createSimpleElement("div", null, "hide_util");
                                            anchor.appendChild(hide_util);
                                            
                                            var btnDetail = _createSimpleAnchor(detailLink, null, "nblank");
                                            btnDetail.href = detailLink;
                                            btnDetail.target = "_blank";
                                            btnDetail.appendChild(_createSimpleElement("span", "새창"));
                                            
                                            
                                            var hndlLike = function(sellPrdtBcode){ return function(e){e.preventDefault();addWishProduct(sellPrdtBcode);}; };
                                            var btnLike = _createSimpleAnchor(detailLink, null, "zzim");
                                            btnLike.appendChild(_createSimpleElement("span", "좋아요"));
                                            _addEvent(btnLike, "click", hndlLike(product.sellPrdtBcode));
                                            
                                            if(product.sellPrdtGbn == "P" || product.sellPrdtGbn == "G" || product.sellPrdtGbn == "S"){
                                                var hndlSimple = function(sellPrdtBcode){ return function(e){e.preventDefault();productPreview(sellPrdtBcode);}; };
                                                var btnSimple = _createSimpleAnchor(detailLink, null, "zoom");
                                                btnSimple.appendChild(_createSimpleElement("span", "확대"));
                                                _addEvent(btnSimple, "click", hndlSimple(product.sellPrdtBcode));
                                                hide_util.appendChild(btnSimple);
                                            }
                                            hide_util.appendChild(btnDetail);
                                            hide_util.appendChild(btnLike);
                                            
                                            // 상품정보
                                            var anchor2 = _createSimpleAnchor(detailLink);
                                            li.appendChild(anchor2);
                                            
                                            anchor2.appendChild(_createSimpleElement("span", product.brandName, "make txt_line1"));
                                            anchor2.appendChild(_createSimpleElement("span", product.prdtName, "name"));
                                            
                                            var icon = _createSimpleElement("span", null, "icon");
                                            anchor2.appendChild(icon);
                                            
                                            var wishPrdtCnt = product.wishPrdtCnt;
                                            var reviewCount = product.reviewCount;
                                            if(parseInt(wishPrdtCnt) > 99)    wishPrdtCnt = "99+";
                                            if(parseInt(reviewCount) > 99)    reviewCount = "99+";
                                            if(product.prdtIcon.charAt(8) == "1")    icon.appendChild(_createSimpleElement("em", "무료배송", "ico_free"));
                                            if(product.prdtIcon.charAt(0) == "1")    icon.appendChild(_createSimpleElement("em", "쿠폰", "ico_coupon"));
                                            if(product.prdtIcon.charAt(2) == "1")    icon.appendChild(_createSimpleElement("em", "GIFT", "ico_gift"));
                                            if(parseInt(product.wishPrdtCnt) >  0)   icon.appendChild(_createSimpleElement("em", wishPrdtCnt, "ico_like"));
                                            if(parseInt(product.reviewCount) >  0)   icon.appendChild(_createSimpleElement("em", reviewCount, "ico_review"));
                                            
                                            var price = _createSimpleElement("em", null, "price");
                                            anchor2.appendChild(price);
                                            if(product.prdtSellPrice == product.lastCpnPrice){
                                                price.appendChild(_createSimpleElement("span", formatNumber(product.prdtSellPrice), "sale"));
                                                if(product.prdtStatCode != 'C0312'){
                                                    pc = _createSimpleElement("span", null, "pc");
                                                    price.appendChild(pc);
                                                    
                                                    pcImg = _createSimpleElement("img");
                                                    pc.appendChild(pcImg);
                                                    pcImg.src = "http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/renewal/common/ic_status_soldout.gif";
                                                    pcImg.alt = "품절";
                                                }
                                            }else{
                                                price.appendChild(_createSimpleElement("span", formatNumber(product.prdtSellPrice), "dc"));
                                                price.appendChild(_createSimpleElement("span", formatNumber(product.lastCpnPrice), "sale"));
                                                if(product.prdtStatCode != 'C0312'){
                                                    pc = _createSimpleElement("span", null, "pc");
                                                    price.appendChild(pc);
                                                    
                                                    pcImg = _createSimpleElement("img");
                                                    pc.appendChild(pcImg);
                                                    pcImg.src = "http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/renewal/common/ic_status_soldout.gif";
                                                    pcImg.alt = "품절";
                                                }else{
                                                    price.appendChild(_createSimpleElement("span", _calDscntRate(product.prdtSellPrice, product.lastCpnPrice) + "%", "pc"));
                                                }
                                            }
                                        }
                                    }
                                    
                                    var hndlPage = function(page){ return function(e){ e.preventDefault();loadProduct(page);$(window).scrollTop($(".event_link").offset().top - 15); }; };
                                    var page = document.getElementById("listPage");
                                    _removeChild(page);
                                    page.appendChild(_getPager(data.pageHolder, hndlPage));
                                }
                          }
                          ,error: function(request, status, error) {
                                alert("상품로드 중 오류가 발생하였습니다. 잠시 후 다시 이용해주세요");
                                // alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
                            }
                        });
                    }
                    
                    $(document).ready(function(){
                        _eventTypeInseq = $(".event_link li a:first").attr("href").replace("#event-link", "");
                        $(".event_link li a.active").removeClass("active");
                        $(".event_link li a:first").addClass("active");
                        loadProduct(1);
                    });
                </script>
                <div id="listProduct" class="mgt60"></div>
                <div id="listPage"></div>
            </c:when>
            <c:otherwise>
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
            </c:otherwise>
        </c:choose>
    </div><!-- //.event_info -->
    </div>
<!-- //.event_wrap -->
</body>
</html>