<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="layer"/>
<html>
<head>
<title>참여이벤트 | 쇼핑도우미 | MY HOTTRACKS - HOTTRACKS</title>
<style type="text/css">
a.li_a {color:#d50c0c; font-weight: bold;} 
</style>
<script type="text/javascript">
function goList(page){
    location.replace("?page="+page);
}
function showMyEvent(eventId, index){
    if($("li#li_"+index).css("display") =="none"){
        $("li#li_"+index).show();
        $.ajax({
             type: "POST"
            , url: "/m/mypage/getEventWin"
            ,data: {eventId : eventId}
            ,dataType: "json"
            ,success : function(data){
                if(data.result.stVar1 != null)
                	$("li#li_"+index+" span.fl_l4").html(data.result.stVar1);
            }
            ,error: function(data) {
                alert('<fmt:message key="error.common.system"/>');
            }
        });
    }else
        $("li#li_"+index).hide();
}
function goEvent(eventId){
    location.href="/m/biz/eventDetail?eventId="+eventId;
}
</script>
</head>
<body>
<div id="sc_content" style="padding:0 10px;">
<!-- tit_section -->
<div id="sc_header">
    <h1>이벤트 참여 내역</h1>
</div>
<div class="tit_orange full">
    <h3 class="tit">HOTTRACKS EVENT</h3>
</div>
<ul class="br_list mb30 mt40">
    <c:if test="${empty list}">
        <li class="line bg_eeeeee"><strong>이벤트 참여 내역이 없습니다.</strong></li>
    </c:if>
    <c:forEach items="${list}" var="l" varStatus="st">
        <li class="line bg_eeeeee">
            <fmt:formatDate value="${l.regstDtm}" pattern="yyyy.MM.dd"/>(참여일자)
        </li>
        <li>
            <strong class="fl_l2"><a href="#" onclick="showMyEvent('${l.eventId}','${st.index }');return false;">${l.eventTitle }</a></strong>
            <span class="fl_r">
                <jsp:useBean id="now" class="java.util.Date" />
                <fmt:formatDate value="${now}" pattern="yyyyMMdd" var="nowStr"/>
                <c:choose>
                    <c:when test="${l.pwnrRlsScdlStat eq 'progress'}">발표준비중</c:when>
                    <c:when test="${l.pwnrRlsScdlStat eq 'win'}">
                        <em class="btn btn_type01 btn_orange">당첨</em>
                        <a href="#" onclick="goModifyMemInfo();return false;" class="btn btn_type01 br_6e6e6e">회원정보수정</a>
                    </c:when>
                    <c:when test="${l.announceYn}">다음기회에</c:when>
                    <c:when test="${l.pwnrRlsScdlDt < nowStr}">발표완료</c:when>
                    <c:otherwise>발표준비중</c:otherwise>
                </c:choose>
            </span>
        </li>
        <li id="li_${st.index }" style="display: none;">
            <span style="width:100%;">
                <a href="#" class="li_a" onclick="goEvent('${l.eventId}');return false;">해당 이벤트 보기 >></a>
            </span>
            <span class="fl_l4">
            </span>
        </li>
    </c:forEach>
</ul>
<!-- paging -->
<div class="paging mb30">
    <ui:paginationScript name="pageHolder" scriptName="goList"/>
</div>
<!-- //paging -->
<a href="javascript:history.back();" class="btn_back">뒤로</a>
</div>
</body>
</html>