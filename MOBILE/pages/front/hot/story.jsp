<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<html>
<head>
<title>${detail.eventTitle} - NEW ME HOTTRACKS</title>
<meta property="fb:app_id" content="981386905311018" />
<meta property="og:type" content="shopping" />
<meta property="og:title" content="HOTTRACKS - ${detail.eventTitle}" />
<meta property="og:url" content="http://m.hottracks.co.kr/m/hot/story" />
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

</script>
</head>
<body>
<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${detail.thumUrl}" class="sns_img" style="display:none;"/>
<div class="w_top event_sub_info">
    <c:choose>
        <c:when test="${not empty detail.eventRangeInfo}"><p>${detail.eventRangeInfo}</p></c:when>
        <c:otherwise><p>(<ui:mask pattern="####.##.##">${detail.eventStartDt}</ui:mask> ~ <ui:mask pattern="####.##.##">${detail.eventEndDt}</ui:mask>)</p></c:otherwise>
    </c:choose>
    <div class="sns">
        <a href="javascript:goTwitter('${detail.eventTitle}', 'http://m.hottracks.co.kr/m/hot/story')" class="ic_twitter">트위터</a>
        <a href="javascript:goFaceBook('${detail.eventTitle}', 'http://m.hottracks.co.kr/m/hot/story')" class="ic_facebook">페이스북</a>
        <a href="javascript:sendKakao('[핫트랙스] ${detail.eventTitle}', 'http://m.hottracks.co.kr/m/hot/story')" class="ic_kakaotalk">카카오톡</a>
    </div>
</div>
<div class="event_info">
    <div class="ly_box_skip">
        <p>종료된 이벤트 입니다.</p>
    </div>
    <div class="event_cont">
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
    <div style="display:block;">
        <div style="border-top: 1px solid #E5E5E5;border-bottom: 1px solid #E5E5E5;">
            <c:forEach items="${listType}" var="lp" varStatus="st">
                <div class="event_prod_${lp.eventPrdtTypeCode}">
                    <!-- 링크주소에 이벤트 코드가 있는경우 Import시 중복값으로 넘어감 -->
                    <c:choose>
                        <c:when test="${not empty param.eventId}">
                            <c:import url="/m/hot/event/prdtList?eventTypeInseq=${lp.eventTypeInseq}"/>
                        </c:when>
                        <c:otherwise>
                            <c:import url="/m/hot/event/prdtList?eventId=${detail.eventId}&eventTypeInseq=${lp.eventTypeInseq}"/>
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
    _loadComments(1, true);
});
</script>
</body>
</html>
