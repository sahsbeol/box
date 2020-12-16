<%@ page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<head>
<!-- 태그 라이브러리 -->
<%@ include file="/pages/decorators/biz/tagHeader.jsp" %>
<script type="text/javascript" src="/js/jquery.rwdImageMaps.min.js"></script>
<script type="text/javascript">
//레이어 팝업 
function go_popup(img) { 
    popimg.src = img; 
    $("#popup").bPopup({
    	follow: [false, false],
        position: [000, 'auto'] //x, y
    });
}

//핫트 프라이데이 이벤트 포인트지급 참여 때문에 일회용으로 만듦(단계별이벤트형식으로 지급) - 스텝순서무시
var date = new Date(); 
var day = date.getDate(); 
var st = 1;
var shareYn = 0; 
//20일(1step), 21일(2step), 22일(3step)
switch(day) {
	case 21:
		st = 2;	
		break;
	case 22:
		st = 3;
		break;
}

function ht_dailyCheck(){ 
	if (!isLogin) {
        needLogin();
    }else{
        $.ajax({
            type: 'POST'
            ,url: '/m/hot/saveEventHistory'
            ,data: {eventId:"${detail.eventId}", step : st}
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
/* 핫트 프라이데이 응모하기 이벤트 (1회용)*/
function ht_entryEvent(){
	
	var eventId = '${detail.eventId}';
	
	if(eventId == '65004'){
		eventId = '65101';
	}
	
	if (preValidation()) {
		if (shareYn > 0) {
	        $.ajax({
	            type: "GET"
	            ,url: "/m/hot/entryEvent"
	            ,data: "eventId="+eventId
	            ,dataType: 'json'
	            ,success: function(data) {
	                if (data.result.save) {
	                    alert(data.result.resultMsg);
	                } else {
	                    alert(data.result.errMsg);
	                }
	            }
	            ,error: function(data) {
	                alert('<fmt:message key="error.common.system"/>');
	            }
	        });
		}else{
			alert('친구에게 공유하기를 하신 후 참여가능합니다');
		}
    }	
}
function ht_shareEvent(){
	shareYn += 1;
	sendKakao('[핫트랙스] ${detail.eventTitle}', 'http://m.hottracks.co.kr/e/${detail.eventId}');
}
$(document).ready(function() {
	sideMenu(); //side menu
	footerFn(); //footer
	eventFn(); //event
	$("#wrap").removeClass("mini");
    $("#locEvent").addClass("active");
    $(window).load(function(){
        if('${skip}' == 'skipEvent'){
            $(".ly_box_skip").addClass("active");
            $(".ly_box_skip.active").css("height", $(".event_cont").height());
            $("form[name=eventCommentForm] textarea[name=cmnt]").attr("disabled","disabled");
            }
    });
    $('img[usemap]').rwdImageMaps();
    $("img.lazy").lazyload({placeholder:'/images/no_image2.gif',effect : "fadeIn"});
});


isLogin = ${isLogin};
isEntryTerm = ${entryTermYn};

function preValidation() {
    if (!isLogin) {
        needLogin();
        return false;
    } else if (!isEntryTerm) {
        alert("해당기간이 아닙니다.");
        return false;
    }

    return true;
}

/* 참여이벤트 */
function entryEvent(){
    if (preValidation()) {
        $.ajax({
            type: "GET"
            ,url: "/m/hot/entryEvent"
            ,data: "eventId=${detail.eventId}"
            ,dataType: 'json'
            ,success: function(data) {
                if (data.result.save) {
                    alert(data.result.resultMsg);
                } else {
                    alert(data.result.errMsg);
                }
            }
            ,error: function(data) {
                alert('<fmt:message key="error.common.system"/>');
            }
        });
    }
}


/* 참여이벤트 -주문금액 */
function entryEventAmt(){
    if (preValidation()) {
        $.ajax({
            type: "GET"
            ,url: "/m/hot/entryEventAmt"
            ,data: "eventId=${detail.eventId}"
            ,dataType: 'json'
            ,success: function(data) {
                if (data.result.save) {
                    alert(data.result.resultMsg);
                } else {
                    alert(data.result.errMsg);
                }
            }
            ,error: function(data) {
                alert('<fmt:message key="error.common.system"/>');
            }
        });
    }
}

function moveToLayer(preInseq, moveInseq){
    if(preInseq != moveInseq){
        $("#eventTypeInseq"+preInseq).find("option[value="+preInseq+"]").attr("selected", true);
        $("html,body").animate({scrollTop: $("#eventTypeInseq"+moveInseq).offset().top - $("#header").height()}, 500);
    }
}

function couponDown(couponId) {
    if (!isLogin) {
        needLogin();
    } else {
        $.ajax({
            type: "GET"
            ,url: "/m/getCouponDown"
            ,data: 'couponId=' + couponId
            ,dataType: "json"
            ,success: function(data) {
                if (data.save) {
                    alert("쿠폰이 다운로드 되었습니다.");
                } else {
                    alert(data.errorMessage);
                }
            }
            ,error: function() {
                alert('시스템오류가 발생하였습니다. 고객센터에 문의해주시기 바랍니다.');
            }
        });
    }
}

function checkEmtcId(obj, imgSrc){
    $(".comment_emtc li a.on").removeClass("on");
    obj.setAttribute("class", "on");
    $("input[name=emtcId]").val(imgSrc);
}

function _applyEvent(){
    if (!isLogin) {
        needLogin();
    } else {
        $.ajax({
            type: 'POST'
            ,url: '/m/hot/saveCheckEvent'
            ,data: { eventId:"${detail.eventId}" }
            ,dataType: 'json'
            ,success: function(data) {
                alert(data.alert);
                if (data.save) {
                    location.reload(true);
                }
            }
            ,error: function(data) {
                alert('응모 중 오류가 발생하였습니다. 잠시 후 다시 이용해주세요');
            }
        });
    }
}

function saveOff(){
    if($("input[name=userName]").val() == null ||  $("input[name=userName]").val() == ""){
        alert("이름을 입력해주세요.");
    }else if($("input[name=handPhoneNum1]").val() == null ||  $("input[name=handPhoneNum1]").val() == ""
       ||$("input[name=handPhoneNum2]").val() == null ||  $("input[name=handPhoneNum2]").val() == ""
       ||$("input[name=handPhoneNum3]").val() == null ||  $("input[name=handPhoneNum3]").val() == ""
       ){
            alert("핸드폰번호를 입력해주세요.");
    }else if($("textarea[name=userAddr]").val() == null ||  $("textarea[name=userAddr]").val() == ""){
            alert("주소지를 입력해주세요.");
    }else if($("input[name=userDtl]").val() == null ||  $("input[name=userDtl]").val() == ""){
            alert("영수증번호를 입력해주세요.");
    }else{
        var userTelNum = $("input[name=handPhoneNum1]").val() + $("input[name=handPhoneNum2]").val() + $("input[name=handPhoneNum3]").val();
        $('form[name="eventCommentForm"]').ajaxSubmit({
            url: '/m/hot/entryEventOff'
            ,dataType: 'json'
            ,data :{
            	eventId : '${detail.eventId}',
                userTelNum : userTelNum
            }
            ,success: function(data) {
                if (data.result.save) {
                    alert(data.result.resultMsg);
                    location.href="/m/welcomeMain";
                } else {
                    alert(data.result.errMsg);
                }
            }
            ,error: function(data) {
                alert('<fmt:message key="error.common.system"/>');
            }
        });
    }
}

</script>
<title>HOTTRACKS - 생활 속 감성충전소</title>
</head>
<!-- content -->
<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${detail.thumUrl}" class="sns_img" style="display:none;"/>
<div id="content">
	<div class="event_view">
		<div class="event_title">
	        <h5>${detail.eventDtlCont}</h5>
	        <p class="date font_t">
	        <c:choose>
	        <c:when test="${not empty detail.eventRangeInfo}">${detail.eventRangeInfo}</c:when>
	        <c:otherwise><ui:mask pattern="####.##.##">${detail.eventStartDt}</ui:mask> ~ <ui:mask pattern="####.##.##">${detail.eventEndDt}</ui:mask></c:otherwise>
	        </c:choose>
	        </p>
	        <a href="javascript:layerPopup('.popup_sns');" class="share"><span>공유하기</span></a>
	    </div>

		<div class="event_view_cont">
<div class="event_info">
    <div class="ly_box_skip">
        <p>종료된 이벤트 입니다.</p>
    </div>
    <div class="event_cont">
        <c:if test="${not empty detail.thumUrl}"><div style="display:none;"><ui:image src="${detail.thumUrl}" clazz="kakao-img"/></div></c:if>
        <c:choose>
            <c:when test="${fn:contains('41488|42167|46371', detail.eventId) || not empty eventRandom}">
<script type="text/javascript" src="/js/jQueryRotate.2.3.js"></script>
<script type="text/javascript" src="/js/jQueryRotateCompressed.2.3.js"></script>
<script type="text/javascript">
    var is_rotating = false;
    var is_rotated = false;

    function call_rotate(img_id, angle, msg) {
        if(is_rotating) return;
        is_rotating = true;

        duration = 3000;  //돌리는 시간 : 1/1000초
        rotateCnt = Math.floor(Math.random()*20) * 360;

        $('#'+img_id).rotate({
            duration: duration,
            animateTo: (rotateCnt + angle),
            callback: function () {
                is_rotating = false;
                //is_rotated = true;  //한번 페이지 로딩시 한번만 돌아가도록하기 위해. 여러번 돌아가게 하려면 돌리는 이미지를 재 계산해야함. 해당 기능 필요하면 구현하는걸로~~
                alert(msg);
                // location.href = "/m/mypage/coupon";
            }
        });
    }
    
    function getRotateNum(eventId) {
        if(eventId == '41488' || eventId == '42167'){
            alert("이 이벤트는 이미 종료되었습니다.");
            return;
        }
        
        if(isLogin){
            /* if(is_rotated) {
                alert('이미 응모하신 이벤트입니다.');
                return;
            } */
            
            if(is_rotating) {
                return;			
            }
            
            // 서버에서 룰렛 값을 가져옴 ( 조작 방지 위함 )
            $.ajax({
                url: "/ht/hot/saveRandomPoint",
                dataType: "json",
                data: { eventId:'${detail.eventId}' },
                success: function(data) {
                    if(data.save){
                        call_rotate('roulette', data.rotateAngle, data.returnMsg);
                    }else{
                        alert(data.returnMsg);
                    }
                },
                error: function(data) {
                    alert('error Process');
                }
            });
        }else{
            needLogin();
        }
    }
</script>
                <c:if test="${not empty eventRandom}">
                    <c:if test="${detail.eventId eq '49299'}">
                        <c:set var="num"><ui:lpad length="7" padChar="0">${eventRandom.totGiftAmt}</ui:lpad></c:set>
                        <style type="text/css">
                        .event_cont .txt_scr { display: block;height:150px;font-size: 0;text-align: center;margin: 0;background:url('${imageServer}/images/event/49299/mob/bg_scr.jpg') #000 center center no-repeat;background-size:auto 135px; }
                        .event_cont .txt_scr img { height:50px;width:auto;display:inline-block;background:none;margin:50px 0; }
                        </style>
                        <div class="txt_scr">
                            <c:set var="isnon" value="true"/>
                            <c:forEach begin="0" end="6" varStatus="st">
                                <c:set var="num_idx">${fn:substring(num, st.index, st.index+1)}</c:set>
                                <c:if test="${isnon && num_idx ne '0'}"><c:set var="isnon" value="false"/></c:if>
                                <c:choose>
                                    <c:when test="${!isnon}">
                                        <c:if test="${st.index eq 1 || st.index eq 4}"><img src="${imageServer}/images/event/49299/mob/ic_num_dot.png"/></c:if>
                                        <img src="${imageServer}/images/event/49299/mob/ic_num_${num_idx}.png" alt="${num_idx}"/>
                                    </c:when>
                                    <c:otherwise><img src="${imageServer}/images/event/49299/mob/ic_num_no.jpg" alt="none"/></c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </div>
                    </c:if>
                    <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${eventRandom.imageUrlTop}" usemap="#eventImageTop"/>
                    <c:if test="${not empty eventRandom.imageMapTop}">
                        <map name="eventImageTop">
                            ${eventRandom.imageMapTop}
                        </map>
                    </c:if>
                    <div style="position:relative;display:block;">
                        <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${eventRandom.imageUrlBg}" style="position:relative;z-index:1;width:100%;"/>
                        <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${eventRandom.imageUrlPin}" style="position:absolute;bottom:97%;left:47%;z-index:3;width:6%;background:none;"/>
                        <a href="#" onClick="getRotateNum('${eventRandom.eventId}');return false;" id="roulette" style="position:absolute;bottom:6.5%;width:86%;left:7%;display:block;z-index:2;background:none;" >
                            <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${eventRandom.imageUrlRlt}" style="background:none;"/>
                        </a>
                    </div>
                    <c:choose>
                        <c:when test="${not empty mobImage}">
                            <div><ui:image src="${mobImage.imageUrl}" id="eventImageUrl" usemap="#eventImageMap" clazz="detail-img"/></div>
                            <c:if test="${mobImage.userTmplUseYn}"><div>${mobImage.userTmpl}</div></c:if>
                        </c:when>
                        <c:otherwise>
                            <c:if test="${not empty detail.imageUrl}"><div><ui:image src="${detail.imageUrl}" id="eventImageUrl" usemap="#eventImageMap" clazz="detail-img"/></div></c:if>
                            <c:if test="${detail.userTmplUseYn eq 'Y'}"><div>${detail.userTmpl}</div></c:if>
                        </c:otherwise>
                    </c:choose>
                </c:if>
            </c:when>
            <c:when test="${not empty mobImage}">
                <div><ui:image src="${mobImage.imageUrl}" id="eventImageUrl" usemap="#eventImageMap" clazz="detail-img"/></div>
                <c:if test="${detail.stampYn}">
                    <!-- 스탬프이벤트 -->
                    <div id="divStamp"></div>
                    <script src="/js/ht.hot.eventDetail.stamp.js" type="text/javascript"></script>
                    <script type="text/javascript">
                        _eventStamp("${detail.eventId}");
                    </script>
                    <!-- #스탬프이벤트 -->
                </c:if>
                <c:if test="${mobImage.userTmplUseYn}"><div>${mobImage.userTmpl}</div></c:if>
            </c:when>
            <c:otherwise>
                <c:if test="${not empty detail.imageUrl}"><div><ui:image src="${detail.imageUrl}" id="eventImageUrl" usemap="#eventImageMap" clazz="detail-img"/></div></c:if>
                <c:if test="${detail.stampYn}">
                    <!-- 스탬프이벤트 -->
                    <div id="divStamp"></div>
                    <script src="/js/ht.hot.eventDetail.stamp.js" type="text/javascript"></script>
                    <script type="text/javascript">
                        _eventStamp("${detail.eventId}");
                    </script>
                    <!-- #스탬프이벤트 -->
                </c:if>
                <c:if test="${detail.userTmplUseYn eq 'Y'}"><div>${detail.userTmpl}</div></c:if>
            </c:otherwise>
        </c:choose>
        <!-- swiper -->
        <c:if test="${not empty detail.userTmplHtml}">
            <div class="event_wrap">
                <!--  header img -->
                <textarea name="userTmplHtml" style="display : none;">${detail.userTmplHtml}</textarea>
                <div id="header_userTemplate"></div>
                <div class="visual swipe-main">
                    <div class="swiper-container"><ul class="swiper-wrapper"></ul></div>
                    <div class="pagination"></div>
                </div>
                <div id="footer_userTemplate" ></div>
            </div>
            <script src="/js/fn_htts_event_template.js?201810041523" type="text/javascript"></script>
            <script src="/js/jquery.rwdImageMaps.min.js?20170612" type="text/javascript"></script>
            <style type="text/css"> img[usemap] {border: none;height: auto;max-width: 100%; width: auto;}</style>
            <script type="text/javascript">
            // 메인배너
            $(document).ready(function(){
                var welcomeSwiper = new Swiper('.swipe-main .swiper-container',{
                    pagination: '.swipe-main div.pagination',
                    loop:true,
                    grabCursor: true,
                    paginationClickable: true,
                    autoplay: 3000,
                    autoplayDisableOnInteraction: false
                });
                $('img[usemap]').rwdImageMaps();
                
            });
            </script>
        </c:if>
    </div>
    
    <c:if test="${detail.eventTypeCode eq 'C0192' || detail.eventTypeCode eq 'C0193' || detail.eventTypeCode eq 'C0197' || detail.eventTypeCode eq 'C019A'}">
    <c:if test="${not empty listType}">
    <div class="btn_area box_flex mt10">
        <a href="#" onclick="_moveToComment();return false;" class="btn btn_orange">코멘트 보러가기</a>
    </div>
    </c:if>
    </c:if>
    <c:forEach items="${listType}" var="lp" varStatus="st">
        <div id="event-link${lp.eventTypeInseq}" class="category_wrap">
        <c:if test="${lp.titleUseYn eq 'Y'}">
            <div class="box_flex t_select" id="eventTypeInseq${lp.eventTypeInseq}">
                <select class="select" title="정렬 순서 선택" class="eventTypeInseq" onchange="moveToLayer('${lp.eventTypeInseq}', this.value)">
                    <c:forEach items="${listType}" var="ls">
                        <c:if test="${ls.titleUseYn eq 'Y'}">
                            <option value="${ls.eventTypeInseq}"<c:if test="${lp.eventTypeInseq eq ls.eventTypeInseq}"> selected="selected"</c:if>>${ls.eventTitle}</option>
                        </c:if>
                    </c:forEach>
                </select>
            </div>
        </c:if>
        <!-- prod -->
        <div id="eventPrdt${lp.eventTypeInseq}" class="event_prod_${lp.eventPrdtTypeCode}">
        	<c:import url="/m/biz/hot/event/prdtList?eventTypeInseq=${lp.eventTypeInseq}"/>
       	</div>
        <!-- //prod -->
        </div>
    </c:forEach>
</div>			
			<!-- COMMENT 영역 -->
			<c:if test="${(detail.eventTypeCode eq 'C0192' || detail.eventTypeCode eq 'C0193' || detail.eventTypeCode eq 'C0197' || detail.eventTypeCode eq 'C019A') && detail.eventId ne '57658'}">
			    <div id="commentArea">
			        <hr class="hr_01"/>
			        <div class="commnt_write">
			            <strong class="amount">총 <span class="col_orange"><fmt:formatNumber type="number" value="${cmntCnt}"/>개</span>의 댓글이 있습니다.</strong>
			            <form name="eventCommentForm" method="post" onsubmit="return false">
			                <input type="hidden" value="${c.eventId}" name="eventId"/>
			                <div class="textarea_box">
			                    <c:choose>
			                        <c:when test="${not empty listChoice}">
			                            <select class="select" name="emtcId" title="이모티콘 선택">
			                                <c:forEach items="${listChoice}" var="l" varStatus="st">
			                                    <option value="${l.bnrSeq}">${l.bnrTitle}</option>
			                                </c:forEach>
			                            </select>
			                        </c:when>
			                        <c:otherwise><input type="hidden" name="emtcId"/></c:otherwise>
			                    </c:choose>
			                    <textarea class="textarea" name="cmnt" title="댓글 입력" style="height:100px;" onclick="preValidation()" placeHolder="내용을 입력하세요."></textarea>
			                </div>
			                <p class="info mt5">
			                    ※ 로그인 후 글을 남길 수 있습니다.
			                    <a href="javascript:save()" class="btn btn_type01 bg_orange fl_r">등록</a>
			                </p>
			            </form>
			        </div>
			        <ul id="commentList" class="commnt_list"></ul>
			        <div id="commentPage" class="paging mb30"></div>
			    </div>
			</c:if>
			<c:if test="${detail.eventId eq '58998' || detail.eventId eq '61406' || detail.eventId eq '63447'}">
			<div id="commentArea">
			    <hr class="hr_01"/>
			    <div class="commnt_write">
			        <form name="eventCommentForm" method="post" onsubmit="return false">
			            <table class="table02">
			            <caption>개인정보입력 <span>이름, 아이디, 핸드폰, 이메일</span></caption>
			            <colgroup>
			                <col width="*" />
			            </colgroup>
			            <tbody>
			                <tr>
			                    <th scope="row"><label for="name">영수증번호<br/>※ 영수증 제일 하단의 바코드 밑 숫자 20자리를 입력해주세요.</label>
			                    </th>
			                </tr>
			                <tr>
			                <td><input name="userDtl" value="" type="text" class="i_input" id="userDtl"/></td>
			                </tr>
			                <tr>
			                    <th scope="row"><label for="name">이 름</label></th>
			                </tr>
			                <tr>
			                    <td><input name="userName" value="" type="text" class="i_input"/></td>
			                </tr>
			                <tr>
			                    <th scope="row">핸드폰 번호</th>
			                </tr>
			                <tr>
			                    <td>
			                        <input name="handPhoneNum1" value="" type="text" class="i_input handPhoneNum" maxlength="3" title="핸드폰 앞자리 입력"/> -
			                        <input name="handPhoneNum2" value="" type="text" class="i_input handPhoneNum" maxlength="4" title="핸드폰 중간자리 입력"/> -
			                        <input name="handPhoneNum3" value="" type="text" class="i_input handPhoneNum" maxlength="4" title="핸드폰 마지막자리 입력"/>
			                    </td>
			                </tr>
			                <tr>
			                    <th scope="row"><label for="name">주소</label></th>
			                </tr>
			                <tr>
			                    <td><textarea name="userAddr" id="userAddr" cols="50" rows="50" placeholder ="주소지 정보를 입력해주세요."></textarea></td>
			                </tr>
			            </tbody>
			        </table>
			            <p class="info mt5">
			                <a href="javascript:saveOff()" class="btn btn_type01 bg_orange fl_r">등록</a>
			            </p>
			        </form>
			    </div>
			</div>
			</c:if>
			<c:if test="${detail.eventTypeCode eq 'C0192' || detail.eventTypeCode eq 'C0193' || detail.eventTypeCode eq 'C0197' || detail.eventTypeCode eq 'C019A'}">
				<script type="text/javascript">
				var comments = null;
				var pageholder = null;
				
				function save(){
				    if (preValidation()) {
				        $('form[name="eventCommentForm"]').ajaxSubmit({
				            url: '/m/hot/saveEventComment'
				            ,dataType: 'json'
				            ,success: function(data) {
				                if (data.save) {
				                    alert('<fmt:message key="message.save.success"/>');
				                    $("form[name=eventCommentForm]").find("[name=cmnt]").val("");
				                    _loadComments(1, true);
				                } else {
				                    alert(data.errorMessages);
				                }
				            }
				            ,error: function(data) {
				                alert('<fmt:message key="error.common.system"/>');
				            }
				        });
				    }
				    return false;
				}
				
				
				function _moveToComment(){
				    $("html,body").animate({scrollTop: $("#commentArea").offset().top - $("#header").height()}, 500);
				}
				
				function _deleteComment(eventCmntSeq) {
				    if (preValidation()) {
				        if (confirm('삭제하시겠습니까?')) {
				            $.ajax({
				                type: 'GET'
				                ,url: '/m/hot/deleteEventComment'
				                ,data: {eventId:"${detail.eventId}",eventCmntSeq:eventCmntSeq}
				                ,dataType: 'json'
				                ,success: function(data) {
				                    if (data.save) {
				                        alert('<fmt:message key="message.delete.success"/>');
				                        _loadComments(1, true);
				                    } else {
				                        alert(data.errorMessages);
				                    }
				                }
				                ,error: function(data) {
				                    alert('<fmt:message key="error.common.system"/>');
				                }
				            });
				        }
				    }
				}
				
				function _loadComments(page, initYn){
				    if(!initYn)    _moveToComment();
				    
				    $.ajax({
				        type: 'GET'
				        ,url: '/m/hot/event/comments'
				        ,data: {eventId:"${detail.eventId}", page:page}
				        ,dataType: 'json'
				        ,success: function(data) {
				            comments = data.list;
				            pageholder = data.pageHolder;
				            
				            _printComments();
				        }
				        ,error: function(data) {
				            alert('<fmt:message key="error.common.system"/>');
				        }
				    });
				}
				
				function _clearComments(){
				    var ul = document.getElementById("commentList");
				    while (ul.firstChild){
				        ul.removeChild(ul.firstChild);
				    }
				}
				
				function _printComments(){
				    var ul = document.getElementById("commentList");
				    
				    _clearComments();
				    
				    if(comments != null && comments.length > 0){
				        for(var i = 0; i < comments.length ; i++){
				            var li = document.createElement("li");
				            
				            // 번호
				            var span = document.createElement("span");
				            var spanTxt = document.createTextNode(comments[i].num);
				            span.setAttribute("class", "num");
				            span.appendChild(spanTxt);
				            li.appendChild(span);
				            
				            // 이모티콘
				            if(comments[i].emtcUrl != null && comments[i].emtcUrl != ""){
				                var emtc = document.createElement("p");
				                var emtcImg = document.createElement("img");
				                emtcImg.setAttribute("src", "http://image.kyobobook.co.kr/newimages/giftshop_new/work/"+comments[i].emtcUrl);
				                emtc.appendChild(emtcImg);
				                li.appendChild(emtc);
				            }
				            
				            // 내용
				            var p = document.createElement("p");
				            var pTxt = document.createTextNode(comments[i].cmnt);
				            p.appendChild(pTxt);
				            li.appendChild(p);
				            
				            // 작성자
				            var info = document.createElement("div");
				            info.setAttribute("class", "info");
				            
				            var userId = document.createElement("span");
				            userId.setAttribute("class", "writer");
				            var userIdTxt = document.createTextNode(comments[i].userId);
				            userId.appendChild(userIdTxt);
				            
				            var date = document.createElement("span");
				            date.setAttribute("class", "date");
				            var dateTxt = document.createTextNode(_formatDate(comments[i].regstDtm, 'yyyy.MM.dd'));
				            date.appendChild(dateTxt);
				            
				            info.appendChild(userId);
				            info.appendChild(document.createTextNode(" | "));
				            info.appendChild(date);
				            li.appendChild(info);
				            
				            // 삭제버튼
				            var btnDel = document.createElement("span");
				            btnDel.setAttribute("class", "btn_del");
				            if(comments[i].userNum == "${loginUser.userNum}"){
				                btnDelAnchor = document.createElement("a");
				                btnDelAnchor.setAttribute("href", "javascript:_deleteComment('" + comments[i].eventCmntSeq + "');");
				                btnDelAnchor.appendChild(document.createTextNode("삭제"));
				                btnDel.appendChild(btnDelAnchor);
				            }
				            li.appendChild(btnDel);
				            
				            ul.appendChild(li);
				        }
				    }
				    
				    _printCommentsPage("commentPage", pageholder, "_loadComments");
				}
				
				$(document).ready(function(){
				    if(${detail.eventId} != '57984'){
				        _loadComments(1, true);    
				    }
				    
				});
				</script>
				<!-- //COMMENT 영역 -->
			
				<c:if test="${not empty detail.userTmplHtml}">
				    <div id="userTmplMap"></div>
				</c:if>
			
			</c:if>
		</div>
	</div>
</div>
<!--// content -->
<!-- 신규 레이어팝업 : start --> 
<div class="layer_popup popup_sns">
    <div class="inner_layer">
        <div class="sns_content">
            <ul>
                <li><a href="javascript:goTwitter('${detail.eventTitle}', 'http://m.hottracks.co.kr/e/${detail.eventId}')" class="ic_twitter sns01">트위터</a></li>
                <li><a href="javascript:goFaceBook('${detail.eventTitle}', 'http://m.hottracks.co.kr/e/${detail.eventId}')" class="ic_facebook sns02">페이스북</a></li>
                <li><a href="javascript:sendKakao('[핫트랙스] ${detail.eventTitle}', 'http://m.hottracks.co.kr/e/${detail.eventId}')" class="ic_kakaotalk sns03">카카오톡</a></li>
            </ul>
        </div>
    </div>
	<a href="#none" class="layer_close"><span>취소</span></a>
</div>
<!-- 신규 레이어팝업 : end -->
