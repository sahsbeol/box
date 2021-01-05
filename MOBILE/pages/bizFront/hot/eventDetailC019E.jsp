<%@ page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<!-- 태그 라이브러리 -->
<%@ include file="/pages/decorators/biz/tagHeader.jsp" %>
<ui:decorator name="bizFull"/>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now }" pattern="yyyyMMdd" var="thisYmd"/>
<head>
<title>${detail.eventTitle} - NEW ME HOTTRACKS</title>
<meta property="fb:app_id" content="981386905311018" />
<meta property="og:type" content="shopping" />
<meta property="og:title" content="HOTTRACKS - ${detail.eventTitle}" />
<meta property="og:url" content="http://m.hottracks.co.kr/e/${detail.eventId}" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=2.0">
<c:choose>
    <c:when test="${not empty detail.eventRangeInfo}"><meta property="og:description" content="${detail.eventRangeInfo}"/></c:when>
    <c:otherwise><meta property="og:description" content="<ui:mask pattern="####.##.##">${detail.eventStartDt}</ui:mask> ~ <ui:mask pattern="####.##.##">${detail.eventEndDt}</ui:mask>"/></c:otherwise>
</c:choose>
<meta property="og:image" content="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${detail.thumUrl}" />
<link rel="image_src" href="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${detail.thumUrl}" />
<script type="text/javascript" src="/js/jquery.rwdImageMaps.min.js?20170727"></script>
<script type="text/javascript" src="/js/jquery.form.js"></script>
<script type="text/javascript" src="/js/imageMapResizer.min.js"></script><!-- 이미지맵 반응형 -->

<!--  레코벨 스크립트 -->
<script type="text/javascript">
  var _recoUserId = getCookie('UserCookieKey');
  window._eglqueue = window._eglqueue || [];
  _eglqueue.push(['setVar','cuid','e15e978e-3623-4892-bf0a-485b9f8196ee']);
  _eglqueue.push(['setVar','planId','${detail.eventId}']);
  _eglqueue.push(['setVar','userId',SHA256(_recoUserId)]);  // optional
  _eglqueue.push(['track','view']); 
  setTimeout(function() {
    (function(s,x){s=document.createElement('script');s.type='text/x-x-javascript';
    s.async=true;s.defer=true;s.src=(('https:'==document.location.protocol)?'https':'http')+
    '://logger.eigene.io/js/logger.min.js';
    x=document.getElementsByTagName('script')[0];x.parentNode.insertBefore(s, x);})();
  }, 0);
</script>
<!--  레코벨 스크립트 끝-->

<style type="text/css">
.timetable .timetable_top img, .timetable .timetable_header img, .timetable .timetable_bottom img, .timetable .checkTable { width:100%; }
.timetable .checkTable div.box { display:-webkit-box; }
.timetable .checkTable div.box a { position:relative;display:block;-webkit-box-flex:1;width:100%; }
.timetable .checkTable div.box a + a { border:none; }
.timetable .checkTable div.box a img {  }
</style> 
<script type="text/javascript">
isLogin = ${isLogin};

jQuery(function($){
    $(window).load(function(){
        if('${skip}' == 'skipEvent'){
            $(".ly_box_skip").addClass("active");
            $(".ly_box_skip.active").css("height", $(".event_cont").height());
        }
    });
    
    $("area").attr("onfocus","this.blur();");
});

function successProc(step){
    if (!isLogin) {
        needLogin();
    }else{
        $.ajax({
            type: 'POST'
            ,url: '/m/hot/saveEventHistory'
            ,data: {eventId:"${detail.eventId}", step : step}
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
<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${detail.thumUrl}" class="sns_img" style="display:none;"/>
<c:if test="${not empty detail.thumUrl}"><div style="display:none;"><ui:image src="${detail.thumUrl}" clazz="kakao-img"/></div></c:if>
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
<!-- content -->
<div id="content">
	<!-- event_view -->
	<div class="event_view">
		<!-- event_title -->
		<div class="event_title">
	        <h5>${detail.eventDtlCont}</h5>
	        <p class="date font_t ${detail.eventRangeInfo}">
	        <c:choose>
	        <c:when test="${not empty detail.eventRangeInfo && detail.eventRangeInfo != '' && detail.eventRangeInfo != ' ' }">${detail.eventRangeInfo}</c:when>
	        <c:otherwise><ui:mask pattern="####.##.##">${detail.eventStartDt}</ui:mask> ~ <ui:mask pattern="####.##.##">${detail.eventEndDt}</ui:mask></c:otherwise>
	        </c:choose>
	        </p>
	        <a href="javascript:layerPopup('.popup_sns');" class="share"><span>공유하기</span></a>
	    </div>
	    <!-- event_title -->
<!-- event_view_cont -->
	<div class="event_view_cont">
		<div>
<div class="event_info">
<div class="ly_box_skip">
    <p>종료된 이벤트 입니다.</p>
</div>
<div class="event_cont">
    <div class="timetable">
        <div class="timetable_header">
            <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${headerImg}" />
        </div>
        <c:choose>
		    <c:when test="${not empty mobImage}">
		        <c:if test="${mobImage.userTmplUseYn}"><div>${mobImage.userTmpl}</div></c:if>
		    </c:when>
		    <c:otherwise>
		        <c:if test="${detail.userTmplUseYn eq 'Y'}"><div>${detail.userTmpl}</div></c:if>
		    </c:otherwise>
		</c:choose>
        <div class="timetable_top">
            <c:if test="${ history[0].nextStep eq 0}">
                <c:if test="${not empty topImg }">
                    <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${topImg}" usemap="#eventImageMap"/>
                </c:if>
            </c:if>
            <c:if test="${history[0].nextStep > 0}" >
                <c:forEach items="${history}" begin="${ history[0].nextStep-1}" end="${history[0].nextStep-1}" var="h">
                    <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${h.topImage}" usemap="#eventImageMap"/>
                </c:forEach>
            </c:if>
        </div>
        <div class="checkTable">
            <c:forEach items="${history}" varStatus="s1" step="5">
                <div class="box">
                    <c:forEach items="${history}" var="l" varStatus="st" begin="${s1.index}" end="${s1.index +4}">
                        <c:choose>
                            <c:when test="${isLogin eq true && history[0].maxDay eq 'N'}">
                                <a href="javascript://" onclick="successProc('${l.step}');return false;">
                                    <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${l.setImage }" alt="${l.step} 단계"/>
                                </a>
                            </c:when>
                            <c:when test="${isLogin eq true && history[0].maxDay eq 'Y'}">
                                <a href="javascript://" onclick="alert('오늘 이미 참여하셨습니다.');">
                                    <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${l.setImage }" alt="${l.step} 단계"/>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="javascript://" onclick="successProc('${l.step}');return false;">
                                    <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${l.setImage }" alt="${l.step} 단계"/>
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </div>
            </c:forEach>
        </div>
        <div class="timetable_bottom">
            <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${ footerImg}" />
        </div>
    </div>
					</div><!-- event_cont -->
				</div><!-- event_info -->
			</div>
		</div>
	</div>
<!-- event_view -->
</div>
<!-- content -->
<!-- 신규 레이어팝업 : start --> 
<div class="layer_popup popup_sns">
    <div class="inner_layer">
        <div class="sns_content">
            <ul>
                <li><a href="javascript:goTwitter('${detail.eventTitle}', 'http://m.hottracks.co.kr/e/${detail.eventId}')" class="ic_twitter sns01"></a></li>
                <li><a href="javascript:goFaceBook('${detail.eventTitle}', 'http://m.hottracks.co.kr/e/${detail.eventId}')" class="ic_facebook sns02"></a></li>
                <li><a href="javascript:sendKakao('[핫트랙스] ${detail.eventTitle}', 'http://m.hottracks.co.kr/e/${detail.eventId}')" class="ic_kakaotalk sns03"></a></li>
            </ul>
        </div>
    </div>
	<a href="#none" class="layer_close"><span>취소</span></a>
</div>

<!-- 신규 레이어팝업 : end -->
