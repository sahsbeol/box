<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<html>
<head>
<title>SOS상담 | 쇼핑도우미 | MY HOTTRACKS - HOTTRACKS</title>
<script type="text/javascript">
var isLogin = ${isLogin};
jQuery(function($){
    $("#wrap").addClass("mypage_v3");
    $("#locSos").addClass("active");
    $(".conts").hide();
});

function showComment(returnSeq){
    var conts = $("#qna-content"+returnSeq);
    if(conts.is(":hidden")){
        $.ajax({
            type: "GET"
            , url: "/m/help/getSosCounsel"
            , data: "returnSeq=" + returnSeq
            , dataType: "html"
            , success: function(htmlStr) {
                 conts.find(".txt").html(htmlStr);
                 conts.slideDown();
            }
            , error: function() {
                alert("<fmt:message key='error.common.system'/>");
            }
        });
    }else{
        conts.slideUp();
    }
}

function goPage(page){
    location.replace("?page="+page); 
}
function deleteComment(returnSeq){
	if (confirm("문의 내용을 삭제하시겠습니까?")) {
        $.ajax({
            type: "GET"
            , url: "/m/mypage/deleteSosCounsel"
            , data: "returnSeq=" + returnSeq
            , dataType: "json"
            , success: function(data) {
            	if(data.isDeleted){
            		alert("삭제 완료되었습니다.");
                    location.reload(true);	
            	}else{
            	    alert("삭제 중에 오류가 발생헀습니다.");
            	}
            	
            }
            , error: function() {
                alert("<fmt:message key='error.common.system'/>");
            }
        });
    }
	
}
</script>
</head>
<body>
<p class="info02" style="text-align: left;">
· 한번 등록한 상담 내용은 수정이 불가능합니다.<br/>
· 수정을 원하시는 경우, 삭제 후 재등록하셔야 합니다.<br/>
· 영업점 이용상담의 문의는 등록하신 이메일 또는 전화번호로 회신을 드립니다.<br/>
· 음반 공동구매 문의는 SOS 답변이 불가하오니 고객센터로 문의해주시기 바랍니다.
</p>
<div class="sub_contents mt40">
    <ul class="br_list" >
        <c:if test="${empty listCounsel}"><li class="line">작성하신 상품문의 글이 없습니다.</li></c:if>
        <c:forEach items="${listCounsel}" var="l" varStatus="st">
            <li class="line">
                <strong class="fl_l">
                    <em>등록일 : <fmt:formatDate pattern="yyyy.MM.dd" value="${l.registDtm}" /></em><br/>
                    <em>${l.counselTitle}</em>
                </strong>
                <strong class="fl_r">
                    <c:choose>
                        <c:when test="${l.sosProcessGubun ne 'E' }">
                            <a href="#" onclick="showComment('${l.returnSeq}');return false;" class="btn btn_type01 btn_gray3">답변대기</a>
                            <c:if test="${l.sosProcessGubun eq 'N' }">
                                <a href="#" onclick="deleteComment('${l.returnSeq}');return false;" class="btn btn_type01" style="background : #fff; border : 1px solid #6e6e6e; color :#6e6e6e; ">삭제</a>
                            </c:if>
                        </c:when>
                        <c:otherwise><a href="#" onclick="showComment('${l.returnSeq}');return false;" class="btn btn_type01 btn_orange" id="${l.returnSeq}">답변보기</a></c:otherwise>
                    </c:choose>
                </strong>
            </li>
            <li class="bg_eeeeee conts" id="qna-content${l.returnSeq}">
                <div class="txt"></div>
            </li>
        </c:forEach>
    </ul>
    <!-- paging -->
    <div class="paging">
        <ui:paginationScript name="pageHolder" scriptName="goPage"/>
    </div>
    <!-- //paging -->
    
    <div class="btn_area box_flex mt30"><a class="btn btn_type01 btn_orange" href="/m/help/sosCounselMain">1:1 문의하기</a></div>
</div>
</body>
</html>