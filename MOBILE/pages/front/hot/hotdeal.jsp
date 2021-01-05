<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<html>
<head>
<script type="text/javascript" src="/js/jquery.rwdImageMaps.min.js"></script>
<script type="text/javascript" src="/js/jquery.form.js"></script>
<script type="text/javascript">
jQuery(function($){
    $("#wrap").removeClass("mini");
    $("#locHotdeal").addClass("active");
    
    $('img[usemap]').rwdImageMaps();
});
</script>
<script type="text/javascript">
isLogin = ${isLogin};
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

function save(){
    if (preValidation()) {
        $('form[name="eventCommentForm"]').ajaxSubmit({
            url: '/m/hot/saveEventComment'
            ,dataType: 'json'
            ,success: function(data) {
                if (data.save) {
                    alert('<fmt:message key="message.save.success"/>'); 
                    goCommentList(1);
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

function deleteComment(eventCmntSeq) {
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
                        goCommentList(1);
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

function goCommentList(page) {
    $('div#commentArea').load('/m/hot/event/${detail.eventTypeCode}?eventId=${detail.eventId}&page=' + page);
    location.href="#commentArea";
}

function moveToLayer(preInseq, moveInseq){
    if(preInseq != moveInseq){
        $("#eventTypeInseq"+preInseq).find("option[value="+preInseq+"]").attr("selected", true);
        $("html,body").animate({scrollTop: $("#eventTypeInseq"+moveInseq).offset().top - 85}, 500);
    }
}
</script>
</head>
<body>
<div class="event_info mt10">
    <div class="event_cont">
        <c:if test="${not empty detail.imageUrl}"><div><ui:image src="${detail.imageUrl}" id="eventImageUrl" clazz="kakao-img" usemap="#eventImageMap"/></div></c:if>
        <c:if test="${detail.userTmplUseYn eq 'Y'}"><div>${detail.userTmpl}</div></c:if>
        <c:if test="${not empty detail.userTmplHtml}"><div>${detail.userTmplHtml}</div></c:if>
    </div>
    
    <c:forEach items="${listType}" var="lp" varStatus="st">
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
        <div id="eventPrdt${lp.eventTypeInseq}">
            <c:import url="/m/hot/event/prdtList?eventId=${c.eventId}&eventTypeInseq=${lp.eventTypeInseq}"/>
        </div>
        <!-- //prod -->
    </c:forEach>
</div>
</body>
</html>
