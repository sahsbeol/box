<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="layer"/>
<html>
<head>
<style type="text/css">
label#content_pre {  text-align: left; display: inline-block; position: absolute; z-index: 1; display: block;  -webkit-box-flex: 1; width: 90%;  padding: 10px; resize: none;}
label#content_pre + textarea{background-color:transparent;}
</style>
<script type="text/javascript">
jQuery(function($){
    $(document).ready(function(){
        if($("label#content_pre + textarea").val().trim() !="")
            $("label#content_pre").hide();
        else
            $("label#content_pre").show();
    });
    
});
function changePre(i){
    if(i==2){
        $("label#content_pre").hide();
        $("label#content_pre + textarea").focus();
    }else{
        if($("label#content_pre + textarea").val()=="")
              $("label#content_pre").show();
    }
}
function submitFrm(){
    var regExp = /^[_a-zA-Z0-9-]+(.[_a-zA-Z0-9-]+)*@[a-zA-Z0-9-]+(.[a-zA-Z0-9-]+)*$/;
    var isTrue = regExp.test($("input[name=wrtorEmailAddr]").val());
    if($("input[name=prdtQnaTitle]").val().length <=0 ){
        alert("제목을 써주세요.");
        return false;
    }
    if(!isTrue){
        alert("이메일을 입력해주세요.");
        return false;
    }
    if($("textarea[name=prdtAskCont]").val().length <=0 ){
        alert("문의글을 써주세요.");
        return false;
    }
    $.ajax({
        type: "POST"
        ,url: "/m/gift/detail/submitQna"
        ,data:{
            sellPrdtBcode:"${ext.sellPrdtBcode}"
            ,prdtGrade:0
            ,prdtQnaSeq:"${ext.prdtQnaSeq}"
            ,prdtQnaTitle:$("input[name=prdtQnaTitle]").val()
            ,writeUserName:$("input[name=writeUserName]").val()
            ,wrtorEmailAddr:$("input[name=wrtorEmailAddr]").val()
            ,prdtAskCont:$("textarea[name=prdtAskCont]").val()
            ,procStatGbn:"R"
            ,dispYn:true
            ,aswrYn:false
            ,openYn:$("input[name=openYn]:checked").val() == "Y"?true:false
            ,rcrdCd:"${ext.rcrdCd}"
            }
        ,dataType: 'json'
        ,success: ajaxSuccessHandler
        ,error: ajaxErrorHandler
    });
}
function ajaxSuccessHandler(result){
    if(result){
        var isSuccss         = result.isSuccess;
        var errorMessages     = result.errorMessages;
        if(isSuccss){
            alert("정상적으로 등록되었습니다.");
            
            if ("${ext.qnaGubun}" == "G") {
                location.replace("/s/${ext.brandName}");
            } else {
                location.replace("/p/${ext.sellPrdtBcode}");
            }
            
            
        }else{
            var messageStr ="";
            for(var i=0; i<errorMessages.length; i++){
                messageStr += errorMessages[i] + "\n";
            }
            alert(messageStr);
        }
    }
}

function ajaxErrorHandler(result){
    console.log(result);
    alert('<fmt:message key="error.common.system"/>');
}
</script>
</head>
<body>
<!-- tit_section -->
<div id="ly_header">
    <h1>상품Q&amp;A 쓰기</h1>
</div>
<!-- //tit_section -->

<!-- content -->
<div id="ly_content">
<form name="reviewForm" action="/m/gift/detail/submitQna" method="post">
    <input type="hidden" name="prdtQnaSeq" value="${ext.prdtQnaSeq}" />
    <input type="hidden" name="rcrdCd" value="${ext.rcrdCd}" />
    <input type="hidden" name="prdtGrade" value="${ext.prdtGrade}" />
    <fieldset>
        <div class="roundbox">
            <dl class="rating_star">
                <dt>제목</dt>
                <dd style="width:100%;"><div class="textarea_box"><input type="text" name="prdtQnaTitle" class="textarea" title="Q&amp;A 제목" /></div></dd>
            </dl>
        </div>
        <div class="roundbox mt10">
            <dl class="rating_star">
                <dt>작성자</dt>
                <dd style="width:100%;"><div class="textarea_box"><input type="text" name="writeUserName" value="${userId}" class="textarea" title="Q&amp;A 작성자명" readOnly/></div></dd>
            </dl>
        </div>
        <div class="roundbox mt10">
            <dl class="rating_star">
                <dt>이메일</dt>
                <dd style="width:100%;"><div class="textarea_box"><input type="email" name="wrtorEmailAddr" value="${ext.wrtorEmailAddr}" class="textarea" title="Q&amp;A 이메일주소" /></div></dd>
            </dl>
        </div>
        <div class="roundbox mt10">
            <div class="textarea_box">
            <label id="content_pre" onclick="changePre(2);">주문 후 주문/배송/취소/환불 등에 관한 문의는<br/>
                        '마이핫트랙스&lt;1:1문의'를 이용해주시기 바랍니다.<br/><br/>
                        상품문의 외 주문/배송/취소/환불 등의 문의를 남겨주시면 빠른 <br/>
                        안내가 어렵습니다.
                </label>
            <textarea class="textarea" title="상품Q&amp;A 문의내용" style="height:100px;" name="prdtAskCont" onchange="changePre(1);" onfocusout="changePre(1);" ><c:out value="${ext.prdtAskCont}" escapeXml="true"/></textarea></div>
            <p class="info mt5">
                ※최대 100자까지 등록 가능합니다.
                <span class="fl_r">(0/100)</span>
            </p>
        </div>
        <div class="roundbox mt10">
            <dl class="rating_star">
                <dt>공개여부</dt>
                <dd><label><input type="radio" name="openYn" value="Y" title="공개" checked="checked"/><span >공개</span></label></dd>
                <dd><label><input type="radio" name="openYn" value="N" title="비공개" /><span >비공개</span></label></dd>
            </dl>
        </div>
    </fieldset>
    
    <div class="btn_area btn_area02 mt30">
        <a href="javascript:submitFrm();" class="btn btn_type01 bg_orange f12">글올리기</a>
        <a href="javascript:history.back();" class="btn btn_type01 br_484848">취소</a>
    </div>
    <a href="javascript:history.back();" class="btn_cls">닫기</a>
</div>
<!-- //content -->
</body>
</html>