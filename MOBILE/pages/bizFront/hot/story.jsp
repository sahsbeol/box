<%@ page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<%@ include file="/pages/decorators/biz/tagHeader.jsp" %>
<html>
<head>
<ui:decorator name="bizFull"/>
<title>${detail.eventTitle} - NEW ME HOTTRACKS</title>
<meta property="fb:app_id" content="981386905311018" />
<meta property="og:type" content="shopping" />
<meta property="og:title" content="HOTTRACKS - ${detail.eventTitle}" />
<meta property="og:url" content="http://m.hottracks.co.kr/m/biz/hot/story" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=2.0,viewport-fit=cover">
<c:choose>
    <c:when test="${not empty detail.eventRangeInfo}"><meta property="og:description" content="${detail.eventRangeInfo}"/></c:when>
    <c:otherwise><meta property="og:description" content="<ui:mask pattern="####.##.##">${detail.eventStartDt}</ui:mask> ~ <ui:mask pattern="####.##.##">${detail.eventEndDt}</ui:mask>"/></c:otherwise>
</c:choose>
<meta property="og:image" content="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${detail.thumUrl}" />
<link rel="image_src" href="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${detail.thumUrl}" />
<script type="text/javascript" src="/js/jquery.rwdImageMaps.min.js"></script>
<script type="text/javascript" src="/js/jquery.form.js"></script>
<style type="text/css">
div.visual.swipe-main div.pagination {background: transparent;text-align: center; position: relative; width: 100%; left: 0; bottom: 14px;}
.event_wrap .visual{margin : 0px; height : auto; width : 100%;}
div.event_cont div.event_wrap div.visual.swipe-main div.swiper-container{margin : 0; margin-bottom : -10px;}
</style>
<script type="text/javascript">
jQuery(function($){
    $("#wrap").removeClass("mini");
    $("#locStory").addClass("active");
    
    $(window).ready(function(){
        if('${skip}' == 'skipEvent'){
            $(".ly_box_skip").addClass("active");
            $(".ly_box_skip.active").css("height", $(".event_cont").height());
            $("form[name=eventCommentForm] textarea[name=cmnt]").attr("disabled","disabled");
        }
        
        $("area").on("click", function(e){
        	$("#loading").remove();
        });
        
        _checkMore();
    });
    $('img[usemap]').rwdImageMaps();
    $("img.lazy").lazyload({placeholder:'/images/no_image2.gif',effect : "fadeIn"});
    
    $("#listStory .thumb_list").scroll(function(){
        _checkMore();
    });
});

function _checkMore(){
    var obj = $(".thumb_box01 .thumb_list");
    var items = obj.find("a");
    var gap = parseInt(items.last().css("marginLeft").replace("px", ""));
    var max = items.first().width() * items.length + gap * (items.length - 1) - obj.width();
    
    if(obj.scrollLeft() > 0)    $("#listStory .btn_slide.left").show();
    else                        $("#listStory .btn_slide.left").hide();
    if(obj.scrollLeft() < max)  $("#listStory .btn_slide.right").show();
    else                        $("#listStory .btn_slide.right").hide();
}

function _moreStory(direct){
    var obj = $(".thumb_box01 .thumb_list");
    var left = obj.scrollLeft();
    var items = obj.find("a");
    var gap = parseInt(items.last().css("marginLeft").replace("px", ""));
    var max = items.first().width() * items.length + gap * (items.length - 1) - obj.width();
    
    if(direct == "L")    left = (left - items.first().width() - gap) < 0?0:(left - items.first().width() - gap);
    else                 left = (left + items.first().width() + gap) > max?max:(left + items.first().width() + gap);
    
    obj.animate({scrollLeft:left}, 500);
}

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

$(document).on("touchend","#replaceBtnId",function() {
    replaceBtn($('#replaceBtnId').attr("code"));
});

$(function(){
    $('.replace-modal .close-btn').click(function(){
        $('.replace-modal').hide();
//         $('html,body').removeClass('noscroll');
    });
});

function replaceBtn(bcode){
	setRecobellRelationList(bcode);
	$('.replace-modal').show();
// 	$('html,body').addClass('noscroll');
}

function setRecobellRelationList(bcode) {
	$.ajax({
		url: "/m/biz/personal/getRecobellRelationList"
		, data: {
			code : bcode
		}
		, type:"POST"
        ,dataType: "json"
        ,success : function(data){
        	var append = "";
           	$('#recobellRelationList').empty();
        	
            if (data) {
                if(!isEmpty(data)) {
					var list = data.recobellRelationList;
					if(!isEmpty(list)) {
						for(var i=0; i < list.length; i++) {
							var rate = 0;
							/* rate = 100 - Math.ceil(((list[i].lastCpnPrice / list[i].prdtSellPrice) * 100)); */
							rate = ((list[i].prdtSellPrice - list[i].lastCpnPrice) / list[i].prdtSellPrice) * 100;
							rate = Math.round(rate * 10);
							rate = Math.floor(rate / 10);
// 							if(i < 4){
								append += '	<li>';
// 							}else{
// 								append += '	<li style="display:none;">';
// 							}
							append += '	<a href="/p/'+list[i].sellPrdtBcode+'?foo=bar&rccode=mo_soldout">';
							append += '		<div class="thum">';
							if(list[i].sellPrdtGbn == 'R' || list[i].sellPrdtGbn == 'D'){
		                	    append += '		<img src="http://image.kyobobook.co.kr/newimages/music/midi/'+list[i].rcrdCd.substring( 1, 5 ).split("").reverse().join("")+'/'+list[i].rcrdCd+'.jpg" alt="'+list[i].prdtName+'" class="photo" >';
	                	    }else{
		                	    append += '		<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/goods/400/'+list[i].productImageUrl+'" alt="'+list[i].prdtName+'" class="photo" onerror="this.src=\'http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/no_image2.gif\';">';
	                	    }
							append += '		</div>';
							append += '	</a>';
							if(list[i].wishUserPrdtCnt > 0){
								append += '	<a href="javascript:" onclick="addBizWishProduct(this);return false;" class="btn_like active" prdtId="'+list[i].sellPrdtBcode+'">';
							}else{
								append += '	<a href="javascript:" onclick="addBizWishProduct(this);return false;" class="btn_like" prdtId="'+list[i].sellPrdtBcode+'">';
							}
							append += '		<span>'+'좋아요'+'</span>';
							append += '	</a>';
							append += '	<a href="/ht/product/detail?barcode='+list[i].sellPrdtBcode+'">';
							append += '	<div class="cont">';
							append += '		<p class="brand">'+list[i].brandName+'</p>';
							append += '		<p class="tit">'+list[i].prdtName+'</p>';
							append += '		<p class="price font_t">';
							if(rate != 0){
		                	    append += '				<span class="percent">'+rate+'%</span>';
	                	    }
							append += '					<span>'+price_format(list[i].lastCpnPrice)+'</span>';
							if(rate != 0){
								append += '					<span class="discount">'+price_format(list[i].prdtSellPrice)+'</span>';
	                	    }
							append += '		</p>';
							append += ' <div class="info">';
							if(list[i].reviewCount > 999){
								append += '<span class="reply">'+'999+'+'</span>';
							}else{
								append += '<span class="reply">'+list[i].reviewCount+'</span>';
							}
							if(list[i].wishPrdtCnt > 999){
								append += '<span class="like">'+'999+'+'</span>';
							}else{
								append += '<span class="like">'+list[i].wishPrdtCnt+'</span>';
							}
							append += ' </div>';
							append += ' <div class="badge">';
								if(list[i].prdtStatCode != 'C0312'){
									if(list[i].prdtStatCode == 'C0313'){
										append += ' <span class="badge03">'+'일시품절'+'</span>';
									}
									if(list[i].prdtStatCode != 'C0313'){
										append += ' <span class="badge03">'+'품절'+'</span>';
									}
								}else{
									if(list[i].prdtIcon.substring(0,1) == '1'){
										append += ' <span class="badge01">'+'쿠폰'+'</span>';
									}
									if(list[i].prdtIcon.substring(2,3) == '1'){
										append += ' <span class="badge01">'+'사은품'+'</span>';
									}
									if(list[i].prdtIcon.substring(8,9) == '1'){
										append += ' <span class="badge01">'+'무료배송'+'</span>';
									}
								}
							append += ' </div>';
						append += ' </div>';
					append += ' </a>';
				append += '</li>';
							
							if (i == 19)	break;
	                	}
					}
                	
					$('#recobellRelationList').html(append);
                }
            }
        }
        ,error: function(request, status, error) {
            if(request.status != 0){
                alert('서비스 수행도중 오류가 발생하였습니다. 잠시후 다시 이용해주세요.\n(※ 지속적으로 오류가 나는 경우 고객센터에 문의바랍니다.)');
            }
        }
    });
}

</script>
</head>
<body>
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
<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${detail.thumUrl}" class="sns_img" style="display:none;"/>
    <div class="ly_box_skip">
        <p>종료된 이벤트 입니다.</p>
    </div>
    <div class="event_view_cont">
        <c:if test="${not empty detail.thumUrl}"><div style="display:none;"><ui:image src="${detail.thumUrl}" clazz="kakao-img"/></div></c:if>
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
    </div>
    <div class="category_wrap"  style="display:block;">
        <div style="border-top: 1px solid #E5E5E5;border-bottom: 1px solid #E5E5E5;">
            <c:forEach items="${listType}" var="lp" varStatus="st">
                <div id="eventPrdt${lp.eventTypeInseq}" class="event_prod_${lp.eventPrdtTypeCode}">
                    <!-- 링크주소에 이벤트 코드가 있는경우 Import시 중복값으로 넘어감 -->
                    <c:choose>
                        <c:when test="${not empty param.eventId}">
                            <c:import url="/m/biz/hot/event/prdtList?eventTypeInseq=${lp.eventTypeInseq}"/>
                        </c:when>
                        <c:otherwise>
                            <c:import url="/m/biz/hot/event/prdtList?eventId=${detail.eventId}&eventTypeInseq=${lp.eventTypeInseq}"/>
                        </c:otherwise>
                    </c:choose>
                </div>
            </c:forEach>
        </div>
        <div class="thumb_box01" id="listStory">
            <div class="story_title">다른 보이는이야기 보기</div>
            <a href="#" onclick="_moreStory('L');return false;" class="btn_slide left">왼쪽더보기</a>
            <div class="thumb_list">
                <c:forEach items="${listEvent}" var="l">
                    <a href="/m/hot/story?eventId=${l.eventId}"><c:if test="${l.curEventYn}"><em class="new">NEW</em></c:if><ui:image src="${l.thumUrl}"/></a>
                </c:forEach>
            </div>
            <a href="#" onclick="_moreStory('R');return false;" class="btn_slide right">오른쪽더보기</a>
            <a href="/m/hot/storyMain" class="btn_more">더보기</a>
        </div>
    </div>

<!-- 하트뿅뿅 코멘트 -->
<%-- <div id="commentArea">
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
</div> --%>
</div>
</div>
<!-- replaced stuff modal -->
    <div class="replace-modal">
        <button type="button" class="close-btn"></button>
        <div class="title-wrap">
            <h2>하필 딱! 품절이지만<br>괜찮아요</h2>
            <p>찾으시는 상품과 비슷한 상품이 여기 있어요!</p>
        </div>
        <div class="category_wrap">
            <div class="pd_list">
                <ul id="recobellRelationList"> 
                </ul>
            </div>
        </div>
    </div>
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
    
//     _printCommentsPage("commentPage", pageholder, "_loadComments");
}

$(document).ready(function(){
//     _loadComments(1, true);
});
</script>
</body>
</html>
