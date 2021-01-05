<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
<title>알림함 | 서비스안내 | 고객센터 - HOTTRACKS</title>
<script type="text/javascript">
var isLogin = ${isLogin};
jQuery(function($) {
    $("#wrap").addClass("mypage03");
    $("#locAlarm").addClass("active");
    
    $(".btn_more").click(function(e) {
        e.preventDefault();
        
        var li = $(this).parents("li");
        //location.href=$(this).find(".msgUrl").val();
        if(li.hasClass("active")){
            li.removeClass("active");
        }else{
            li.addClass("active");
            
            if(!li.hasClass("read")){
                li.addClass("read");
                
                var msgSeq = $(this).attr("href").replace("#", "");
                $.ajax({
                    type: "POST"
                    ,url:"/m/help/readMsg"
                    ,data:{msgSeq:msgSeq}
                    ,dataType: 'json'
                    ,async:false
                    ,error: function() {
                        alert('<fmt:message key="error.common.system"/>');
                        }
                    });
                
            }
        }
        location.href=$(this).next(".msgUrl").val();
        
    });
});


function delAlarm(msgSeq){
    $.ajax({
        type: "POST"
        ,url:"/m/help/rmAlarm"
        ,data:{msgSeq:msgSeq}
        ,dataType: 'json'
        ,success: function(data) {
            alert("삭제되었습니다.");
            location.reload();
        }
        ,error: function() {
            alert('<fmt:message key="error.common.system"/>');
        }
    });
}
</script>
</head>
<body>
<div class="customer">
    <p class="noti">1개월 이전 알림함은 자동 삭제됩니다.</p>
    <div class="bbs_box03 edit">
        <ul>
            <c:forEach items="${list}" var="l" varStatus="st">
                <li<c:if test="${not empty l.readDtm}"> class="read"</c:if>>
                    <dl class="tit">
                        <dt><a href="#${l.msgSeq}" class="btn_more">${l.msgTitle}</a>
                        <input type="hidden" class="msgUrl" value="${l.msgLnkUrl }"/>
                        
                        </dt>
                        <c:set value="" var="date_style"/>
                        <c:if test="${l.msgDtmMsg eq '이벤트가 종료되었습니다.'}"><c:set value="color:red;" var="date_style"/></c:if>
                        <dd class="date" style="${date_style}">${l.msgDtmMsg}</dd>
                        <dd class="btn_box">
                            <c:if test="${not empty l.msgConts || not empty l.msgImgUrl }"><a href="#${l.msgSeq}" class="btn_more">펼치기</a></c:if>
                            <a href="#" onclick="delAlarm('${l.msgSeq}');return false;" class="btn_del">삭제</a>
                        </dd>
                    </dl>
                    <c:if test="${not empty l.msgConts || not empty l.msgImgUrl }">
                        <p class="conts">
                            <c:choose>
                                <c:when test="${not empty l.msgLnkUrl }">
                                    <a href="${l.msgLnkUrl}">
                                        <c:if test="${not empty l.msgImgUrl}"><img src="${l.msgImgUrl}"/></c:if>
                                        ${l.msgConts}
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <c:if test="${not empty l.msgImgUrl}"><img src="${l.msgImgUrl}"/></c:if>
                                    ${l.msgConts}
                                </c:otherwise>
                            </c:choose>
                        </p>
                    </c:if>
                </li>
            </c:forEach>
        </ul>
    </div>
</div>
</body>
</html>