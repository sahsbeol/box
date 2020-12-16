<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<html>
<head>
<title>${detail.eventTitle} - NEW ME HOTTRACKS</title>
<meta property="fb:app_id" content="981386905311018" />
<!--  SNS 공유 내용 -->
<meta property="og:type" content="website"/>
<meta property="og:title" content="${fn:escapeXml(detail.eventTitle)}"/>
<meta property="og:url" content="${defaultHost}/ht/hot/heart?eventId=${detail.eventId}"/>
<c:choose>
    <c:when test="${not empty detail.eventRangeInfo}"><meta property="og:description" content="${detail.eventRangeInfo}"/></c:when>
    <c:otherwise><meta property="og:description" content="<ui:mask pattern="####.##.##">${detail.eventStartDt}</ui:mask> ~ <ui:mask pattern="####.##.##">${detail.eventEndDt}</ui:mask>"/></c:otherwise>
</c:choose>
<meta property="og:image" content="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${detail.thumUrl}" />
<link rel="image_src" href="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${detail.thumUrl}" />
<!--  SNS 공유 내용 -->
<style type="text/css">
.tit_bucket { margin:60px 0 50px;text-align:center; }
.tit_bucket p { margin-top:20px; }
.bucket_cont { max-width:950px;margin-bottom:50px; }
#imageMid {height : 530px;position: relative; margin-top : -530px; z-index : -1;}

</style>
<script type="text/javascript" src="/js/jquery.form.js"></script>
<script type="text/javascript">
isLogin = ${isLogin};
isEntryTerm = ${entryTermYn};
orderBy = 'regDtmDesc';

jQuery(function($){
    $(document).ready(function(){
        $(".c_select ul li").each(function(){
            var clsName = $(this).find("a").attr("href");
            if($(".e_select li"+clsName).length < 1){
                $(this).hide();
            }
        });
        
        var cateId = "${detail.ctgrId}";
        if(cateId.substring(0, 4) == "0003"){
            $(".c_select li.item0003").find("a").click();
        }else if(cateId.substring(0, 4) == "0004"){
            $(".c_select li.item0004").find("a").click();
        }else if(cateId.length >= 6){
            $(".c_select li.item"+cateId.substring(0, 6)).find("a").click();
        }
        
        var page = 1;
        if(window.history && window.history.state && window.history.state.page){
            page = window.history.state.page;
        }
        loadEvent(page);
    });
    
    $(".c_select ul li a").click(function(e){
        e.preventDefault();
        clsName = $(this).attr("href");
        $(".c_select .c_txt").html($(this).text());
        if(clsName == ""){
            $(".e_select li").show();
        }else{
            $(".e_select li").hide();
            $(".e_select li:first").show();
            $(".e_select li"+clsName).show();
        }
        $(".e_select_btn").hide();
        $(".e_select .e_txt").html($(".e_select li:first").html());
    });
    
    $(".e_select ul li").click(function(e){
        e.preventDefault();
        clsName = $(this).attr("href");
        $(".e_select .e_txt").html($(this).html());
        $(".e_select_btn").fadeIn();
    });
});

function couponDown(couponId) {
    if (!isLogin) {
        needLogin();
    } else {
        $.ajax({
            type: "GET"
            ,url: "/ht/getCouponDown"
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
                alert('<fmt:message key="error.common.system"/>');
            }
        });
    }
}

function goEventList(page) {
    if(page == null || page == undefined)    page = 1;
    location.href="/ht/hot/heart?eventId=${detail.eventId}&page=" +page + "#bucketEventList";
}

function goEvent(){
    location.href = $(".e_select .e_txt a").attr("href");
}

var listEvent;
var pageHolder;
function loadEvent(page){
    if(!page || $.trim(page) == "")   page = 1;
    
    if(history.pushState){
        var state = { page: page };
        var title = "${detail.eventTitle}";
        var url = location.href.split("#")[0];
        history.pushState(state, title, url);
    }
    
    $.ajax({
        type: "GET"
        ,url: "/ht/hot/heartList"
        ,data: {eventId:"${detail.eventId}", page:page}
        ,dataType: "json"
        ,success: function(data) {
            if(data && data.list){
                listEvent = data.list;
                pageHolder = data.pageHolder;
            }
            
            _createEventList();
        }
        ,error: function() {
            alert('<fmt:message key="error.common.system"/>');
        }
    });
}

function _createEventList(){
    var obj = document.getElementById("lyEventList");
    while(obj.firstChild)    obj.removeChild(obj.firstChild);
    
    if(listEvent && listEvent.length > 0){
        var ul = document.createElement("ul");
        ul.classList.add("thumb_list");
        obj.appendChild(ul);
        for(var i = 0; i < listEvent.length; i++){
            ul.appendChild(_createEventThumb("li", listEvent[i], "/ht/hot/heart?eventId="+listEvent[i].eventId));
        }
        
        var hndl = function(page){ return function(e){ e.preventDefault();loadEvent(page); }; };
        obj.appendChild(_getPager(pageHolder, hndl));
    }
}

function _createEventThumb(tagName, event, linkUrl){
    var obj = document.createElement(tagName);
    
    if(linkUrl){
        var anchor = document.createElement("a");
        anchor.href = linkUrl;
        var imgSpan = document.createElement("span");
        imgSpan.classList.add("img");
        if(event.curEventYn){
            var em = document.createElement("em");
            em.classList.add("new");
            em.appendChild(document.createTextNode("NEW"));
            imgSpan.appendChild(em);
        }
        var img = document.createElement("img");
        img.src = "http://image.kyobobook.co.kr/newimages/giftshop_new/work/" + event.thumUrl;
        imgSpan.appendChild(img);
        anchor.appendChild(imgSpan);
        obj.appendChild(anchor);
    }else{
        var imgSpan = document.createElement("span");
        imgSpan.classList.add("img");
        var img = document.createElement("img");
        img.src = "http://image.kyobobook.co.kr/newimages/giftshop_new/work/" + event.thumUrl;
        imgSpan.appendChild(img);
        obj.appendChild(imgSpan);
    }
    return obj;
}


function goCommentList(page) {
    $('div#commentArea').load('/ht/hot/comment/${detail.eventTypeCode}?eventId=${detail.eventId}&orderBy='+orderBy+'&page=' + page);
}


function save(){
    if (preValidation()) {
        $('form[name="eventCommentForm"]').ajaxSubmit({
            url: '/ht/hot/saveEventComment'
            ,dataType: 'json'
            ,success: function(data) {
                if (data.save) {
                    alert('<fmt:message key="message.save.success"/>'); 
                    $('div#commentArea').load('/ht/hot/comment/${detail.eventTypeCode}?eventId=${detail.eventId}&orderBy='+orderBy);
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

function preValidation() {
    if (!isLogin) {
        needLogin();
        return false;
    } else if (!isEntryTerm) {
        alert("해당기간이 아닙니다.");
        $("div.comment_box textarea[name=eventComment]").attr("disabled","disabled");
        $("div.comment_box textarea[name=eventComment]").val();
        return false;
    }

    return true;
}


function deleteComment(sequence) {
    if (preValidation()) {
        if (confirm('삭제하시겠습니까?')) {
            $.ajax({
                type: 'GET'
                ,url: '/ht/hot/deleteEventComment'
                ,data: 'eventId=${detail.eventId}&sequence=' + sequence
                ,dataType: 'json'
                ,success: function(data) {
                    if (data.save) {
                        alert('<fmt:message key="message.delete.success"/>');
                        $('div#commentArea').load('/ht/hot/comment/${detail.eventTypeCode}?eventId=${detail.eventId}&orderBy='+orderBy+'&temp='+ Math.random());
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

</script>
</head>
<body>
<div class="event_wrap w950">
    <div class="event_info">
        <div class="h_section" style="width:750px;margin:0 auto;">
            <div class="sns">
                <a href="javascript://" onclick="goTwitter('${detail.eventTitle}', '${defaultHost}/ht/biz/eventDetail?eventId=${detail.eventId}')"><img src="${imageServer}/images/renewal/common/ico_sns_twitter.png" alt="twitter"/></a>
                <a href="javascript://" onclick="goFaceBook('${detail.eventTitle}', '${defaultHost}/ht/biz/eventDetail?eventId=${detail.eventId}')"><img src="${imageServer}/images/renewal/common/ico_sns_facebook.png" alt="facebook"/></a>
                <a href="javascript://" onclick="goPinterest('${detail.eventTitle}', '${defaultHost}/ht/biz/eventDetail?eventId=${detail.eventId}')"><img src="${imageServer}/images/renewal/common/ico_sns_pinterest.png" alt="pinterest" style="width:28px;height:28px;" nopin="true"/></a>
            </div>
            <span class="date">${detail.eventTitle}</span>
        </div>
        <!-- img -->
        <c:if test="${not empty detail.imageUrl950 }">
            <c:choose>
                <c:when test="${fn:startsWith(detail.ctgrId, '00002000')}">
                    <div> <!-- 이벤트 튼 배경화면 -->
                        <script type="text/javascript">
                        $("#container").css("background", "url('http://image.kyobobook.co.kr/newimages/giftshop_new/work/${detail.imageUrl950}') no-repeat 50% 572px");
                        $(".event_wrap").css("padding-top" ,"25px");
                        </script>
                    </div>
                </c:when>
                <c:otherwise>
                    <div> <!-- 이벤트 튼 배경화면 -->
                        <script type="text/javascript">
                        $("#container").css("background", "url('http://image.kyobobook.co.kr/newimages/giftshop_new/work/${detail.imageUrl950}') no-repeat 50% 80px");
                        </script>
                    </div>
                </c:otherwise>
            </c:choose>
        </c:if>
        <div class="event_img">
            <c:if test="${not empty detail.imageUrl}"><div><ui:image src="${detail.imageUrl}" id="eventImageUrl" usemap="#eventImageMap" clazz="sns_img"/></div></c:if>
            <c:if test="${detail.userTmplUseYn eq 'Y'}"><div>${detail.userTmpl}</div></c:if>
            <c:if test="${not empty detail.userTmplHtml}">
                <div id="userTemplate"></div>
                <textarea name="userTmplHtml" style="display:none;">${detail.userTmplHtml}</textarea>
                <script src="/js/fn_htts_slide_1.2.js?201710261756" type="text/javascript"></script>
                <script src="/js/fn_htts_event_template.js?201710261756" type="text/javascript"></script>
            </c:if>
        </div>
        <div style="display:block;">
            <div style="border-top: 1px solid #E5E5E5;border-bottom: 1px solid #E5E5E5;">
                <c:forEach items="${listDisplayType}" var="l" varStatus="st">
                    <!-- 링크주소에 이벤트 코드가 있는경우 Import시 중복값으로 넘어감 -->
                    <c:choose>
                        <c:when test="${not empty param.eventId}">
                            <c:import url="/ht/hot/listEventProduct?eventTypeInseq=${l.eventTypeInseq}&eventPrdtTypeCode=${l.eventPrdtTypeCode}&prdtInfoExpsYn=${l.prdtInfoExpsYn}&eventDispTypeCode=${detail.eventDispTypeCode}"/>
                        </c:when>
                        <c:otherwise>
                            <c:import url="/ht/hot/listEventProduct?eventId=${detail.eventId}&eventTypeInseq=${l.eventTypeInseq}&eventPrdtTypeCode=${l.eventPrdtTypeCode}&prdtInfoExpsYn=${l.prdtInfoExpsYn}&eventDispTypeCode=${detail.eventDispTypeCode}"/>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </div>
            <div class="thumb_box01" style="width:750px;margin:50px auto 0;display:block;">
                <div class="thumb_title">다른 핫트뿅뿅 보기</div>
                <div id="lyEventList" ></div>
            </div>
            
            <div id="commentArea">
                <c:choose>
                    <c:when test="${not empty param.eventId }"><c:import url="/ht/hot/comment/${detail.eventTypeCode}"/></c:when>
                    <c:otherwise><c:import url="/ht/hot/comment/${detail.eventTypeCode}?eventId=${detail.eventId }"/></c:otherwise>
                </c:choose>
            </div> 
        </div>
    </div>
</div>
</body>
</html>