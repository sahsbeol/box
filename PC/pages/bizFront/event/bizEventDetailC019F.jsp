<%@page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<!-- 태그 라이브러리 -->
<%@ include file="/pages/decorators/biz/tagHeader.jsp" %>
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
<style type="text/css">
.timetable { margin:-40px 0 -11px;overflow:hidden; width :950px;}
.timetable .timetable_top img { width:100%; }
.timetable .timetable_bottom img { width:100%; }
.timetable .checkTable {width : 100%; text-align: center;}
.timetable .checkTable a {text-align: center; display:inline-block; width:33%; height: auto;}
</style> 
<script type="text/javascript">
isLogin = ${isLogin};

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
function successProc2(index){
    if (!isLogin) {
        needLogin();
    } else{
        $.ajax({
            type: 'POST'
            ,url: '/ht/event/saveEventStepInit'
            ,data: {eventId:"${detail.eventId}", step : index}
            ,dataType: 'json'
            ,async: false
            ,success: function(data) {
                alert(data.alert);
                if (data.save) {
                    location.reload(true);
                }
            }
            ,error: function(data) {
                alert('이벤트 진행 중 오류가 발생하였습니다. 잠시 후 다시 이용해주세요');
            }
        });
    }
}
</script>
</head>
<body>
<c:if test="${detail.eventDispScrnCode eq 'C0201' || detail.cultZoneYn eq 'Y'}"><c:set var="isFull" value="N"/></c:if>
<c:if test="${detail.eventDispScrnCode ne 'C0201' && detail.cultZoneYn ne 'Y'}"><c:set var="isFull" value="Y"/></c:if>
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
        <c:forEach items="${imageList }" var="dImg">
            <c:if test="${dImg.eventImageCode eq 'C038C'}">
                <c:set var="headerImg">${ dImg.imageUrl}</c:set>
            </c:if>
            <c:if test="${dImg.eventImageCode eq 'C038D'}">
                <c:set var="footerImg">${ dImg.imageUrl}</c:set>
            </c:if>
            <c:if test="${dImg.eventImageCode eq 'C038E' }">
                <c:set var="topImg">${ dImg.imageUrl}</c:set>
            </c:if>
        </c:forEach>    
        <div class="event_wrap">
            <div class="event_info">
                <div class="timetable">
                    <div class="timetable_header">
                        <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${headerImg}" />
                    </div>
                    <c:if test="${detail.userTmplUseYn eq 'Y'}"><div>${detail.userTmpl}</div></c:if>
                    <div class="timetable_top">
                        <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${topImg}" usemap="#eventImageMap"/>
                    </div>
                    <div class="checkTable">
                        <c:forEach items="${ranImg}" varStatus="s1" var="l">
                            <c:forEach items="${ history}" varStatus="st" var="h" begin="${s1.index }" end="${s1.index }">
                                <a href="javascript://" onclick="successProc2('${h.step}');return false;">
                                    <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${l.ranImg }" alt="${st.index+1 } 단계"/>
                                </a>
                            </c:forEach>
                        </c:forEach>
                    </div>
                    <div class="timetable_bottom">
                        <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${ footerImg}" />
                    </div>
                </div>
            </div>
        </div>
    </div><!--  event_info -->
</div><!--  event_wrap -->
</body>
</html>