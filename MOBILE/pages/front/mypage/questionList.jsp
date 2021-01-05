<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<html>
<head>
<title>Q&amp;A | 쇼핑도우미 | MY HOTTRACKS - HOTTRACKS</title>
<script type="text/javascript">
jQuery(function($){
    $("#wrap").addClass("mypage_v3");
    $("#locQna").addClass("active");
    $(".conts").hide();
});

function deleteWithAjax(seq){
    if (confirm("<fmt:message key='confirm.delete.message'/>")){
     }else{
        return false;
    }
}
function showComment(index){
    if($("#qna-content"+index).is(":hidden")){
        $("#qna-content"+index).slideDown();
    } else {
        $("#qna-content"+index).slideUp();
    }
}
function goPage(page){
    location.replace("?page="+page); 
}
</script>
</head>
<body>
<!-- sub contents -->
<div class="sub_contents mt40">
    <ul class="br_list" >
        <c:if test="${empty list}"><li class="line">작성하신 상품문의 글이 없습니다.</li></c:if>
        <c:forEach items="${list}" var="l" varStatus="st">
            <li class="line">
                <strong class="fl_l">
                    <em>등록일 : <fmt:formatDate pattern="yyyy.MM.dd" value="${l.registerDate}" /></em><br/>
                    <em>상품명 : ${l.productName}</em>
                </strong>
                <strong class="fl_r">
                    <c:if test="${l.answerYn eq 'Y'}">
                        <a href="#" onclick="showComment('${st.index+1}');return false;" class="btn btn_type01 btn_orange" id="${st.index}">답변보기</a>
                    </c:if>
                    <c:if test="${l.answerYn ne 'Y'}">
                        <a href="#" onclick="return false;" class="btn btn_gray3">미답변</a>
                    </c:if>
                </strong>
            </li>
            <li class="bg_eeeeee conts" id="qna-content${st.index+1}">
                <div class="txt">
                    <c:choose>
                        <c:when test="${l.answerYn eq 'Y'}">
                            <p class="answer" style="border-top:1px dashed #DADADA;border-bottom:1px dashed #DADADA;padding:5px 0;margin:5px 0;color:#DD0000;font-weight:bold;">A. 핫트랙스</p>
                            <p class="answer-content">${l.answerContent}</p>
                        </c:when>
                    </c:choose>
                </div>
            </li>
        </c:forEach>
    </ul>
    <!-- paging -->
    <div class="paging">
        <ui:paginationScript name="pageHolder" scriptName="goPage"/>
    </div>
    <!-- //paging -->
</div>
<!-- //sub contents -->
</body>
</html>
