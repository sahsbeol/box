<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<ui:decorator name="popup"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<script type="text/javascript" src="/js/jquery-1.4.2.min.js" charset="utf-8"></script>
<script type="text/javascript" src="/js/jquery.form.js"></script>
<script type="text/javascript">
jQuery(function($) {
    $(document).ready(function(){
    	<c:if test="${empty qnADomain.rcrdCd}">
        	window.resizeTo(516, 710);
    	</c:if>
    	<c:if test="${not empty qnADomain.rcrdCd}">
            window.resizeTo(516, 738);
        </c:if>
    });
    
  //check param
    var $commentContent = $("#textAreaCommentContent");
    var urlStr = "/ht/product/saveComment";
    //var publicYnVal;
    var coententVal;
    var  errorMessages = {practicality:"실용성을체크해주세요"
        , design:"디자인을체크해주세요"
        //, publicYn:"공개여부를 체크해주세요"
        , commentContent:"상품평을 내용입력해주세요"
        , maxCommentSize:"500자를 넘을 수 없습니다."};
    
    String.prototype.getByteSize = function(){
        var str = this;
        var strlength = str.length;
        var size = 0;
        for(var i = 0 ; i < strlength ; i++)
            size += 1;
        
        return size;
    };
    
    function loadParamAlert(){
        var errorMessageStr = "";
        var haveError = true;
        for(key in errorMessages)
            errorMessageStr += errorMessages[key] +"\n";
        
        if(errorMessageStr !== ""){
            alert(errorMessageStr);
            haveError = true;
        }else{
            haveError = false;
        };
        return haveError;    
    };
    
    function printCommentSize(){
        var $byteSize = $("#pByteSize");
        var contentStr = $commentContent.val();
        var byteSize = contentStr.getByteSize();
        $byteSize.text(byteSize);
    };

    function checkTextArea(){
        var contentStr = $commentContent.val();
        var byteSize = contentStr.getByteSize();
        if(byteSize <= 500)
            delete errorMessages["maxCommentSize"];
        if(byteSize >= 15)
            delete errorMessages["commentContent"];
        contentVal = contentStr;
    };
    
    function checkRadio(){
        $(" :radio").each(function(){
            var $radio = $(this);
            var isChecked = $radio.is(":checked");
            if(isChecked){
                var key = $radio.attr("name");
                //if(key !== "publicYn"){
                //}else{
                //    publicYnVal = $radio.val();
                //}
                delete errorMessages[key];
            }
        });
    };
    function ajaxSuccessHandler(result){
        var pageCheck = "${qnADomain.pageCheck }";
        if(pageCheck==98){
            if(result){
                var isSuccss         = result.isSuccess;
                var errorMessages     = result.errorMessages;
                if(isSuccss){
                    alert("정상적으로 등록되었습니다.");
                    opener.parent.location.reload();
                    self.close();
                }else{
                    var messageStr ="";
                    for(var i=0; i<errorMessages.length; i++){
                        messageStr += errorMessages[i] + "\n";
                    }
                    alert(messageStr);
                }    
            }
            
        }else{
            if(result){
                var isSuccss         = result.isSuccess;
                var errorMessages     = result.errorMessages;
                if(isSuccss){
                    reloadNCloseWindow();
                }else{
                    var messageStr ="";
                    for(var i=0; i<errorMessages.length; i++){
                        messageStr += errorMessages[i] + "\n";
                    }
                    alert(messageStr);
                }    
            }
        }
    }
    
    function ajaxErrorHandler(result){
        console.log(result);
        alert('<fmt:message key="error.common.system"/>');
    }
    
    
    function setComment(){
        <c:if test="${not empty qnADomain.rcrdCd}">
        var gradeInt = parseInt($("input:radio[name=practicality]:checked").val());
        </c:if>
        <c:if test="${empty qnADomain.rcrdCd}">
        var gradeInt = parseInt((parseInt($("input:radio[name=practicality]:checked").val()) + parseInt($("input:radio[name=design]:checked").val()))/2);
        </c:if>
        
        $('form[name="commentform"]').ajaxSubmit({
            type: "POST"
            ,url:urlStr
            ,data:{
                barcode:"${qnADomain.barcode}"
                ,grade: gradeInt
                ,seq:"${qnADomain.seq}"
                ,orderNum : "${qnADomain.orderNum}"
                ,orderPrdtInseq : "${qnADomain.orderPrdtInseq}"
                }
            ,dataType: 'json'
            ,success: ajaxSuccessHandler
            ,error: ajaxErrorHandler
        });
        
    }
    
    function reloadNCloseWindow(){
        parent.opener.loadCommentSubList();
        self.close();
    }
    
    function checkParams(){
        checkRadio();
        checkTextArea();
        var haveError = loadParamAlert();
        if(haveError){
            errorMessages = {practicality:"실용성을체크해주세요"
                , design:"디자인을체크해주세요"
                //, publicYn:"공개여부를 체크해주세요"
                , commentContent:"상품평 내용을 입력해주세요"
                , maxCommentSize:"500자를 넘을 수 없습니다."};
        }else{
            setComment();
        }
    };
    
    function addEvent(){
        $("#imgSaveComment").bind("click", checkParams);
        $commentContent.bind("keypress focusout",printCommentSize);
        $commentContent.bind("keydown",printCommentSize);
    };
    
    // for Modify
    
    function setRadios(){
        var grade = "${qnADomain.grade}";
        $(" :radio").each(function(){
                var $inputRadio = $(this);
                var radioVal = $inputRadio.val();
                if(radioVal == grade){
                    $inputRadio.attr("checked",true);}
            });
    }
        
    function setUrlStr(){
        urlStr = "/ht/product/modifyComment";
    }
    
    function setForm4Modify(){
        if(eval("${update == true}")){
            setRadios();
            setUrlStr();
        }
    }
    function deleteImage(seq){
        if(confirm("<fmt:message key='confirm.delete.message'/>")){
            document.location.href ="/ht/product/deleteCommentImageUrl?seq=${qnADomain.seq}";
        }else{
            return false;
        }
    }
    
    //call function
    setForm4Modify();
    addEvent();
    printCommentSize();
});
</script>
</head>
<body>
<div class="popup f_noto">
<h1 class="tit01 mgt0 fs24 c_white"><span class="fw500">상품평 쓰기</span></h1>
<div class="pop_cont">
    <form id="form" name="commentform" action="/ht/product/saveComment" enctype="multipart/form-data">
    <input type="hidden" name="seq" value="${qnADomain.seq}" />
    <input type="hidden" name="rcrdCd" value="${qnADomain.rcrdCd}" />
    <c:choose>
        <c:when test="${empty update}"><input type="hidden" name="publicYn" value="Y" /></c:when>
        <c:when test="${update}"><input type="hidden" name="publicYn" value="${qnADomain.publicYn}" /></c:when>
    </c:choose>
    <c:if test="${not empty qnADomain.imageUrl}">
        <input type="hidden" name="imageUrl" value="${qnADomain.imageUrl}"/>
    </c:if>
    
    <div class="text_wrap">
        <c:choose>
            <c:when test="${not empty qnADomain.title}">
                <textarea id="textAreaCommentContent" placeholder="상품평은 최소 15자 이상 작성해주세요." class="pd10" name="title" rows="" cols="" style="width:95%;height:60px;"><c:out value="${qnADomain.title}" escapeXml="true"></c:out></textarea>
            </c:when>
            <c:otherwise>
                <textarea id="textAreaCommentContent" placeholder="상품평은 최소 15자 이상 작성해주세요." class="pd10" name="title" rows="" cols="" style="width:95%;height:60px;"></textarea>
            </c:otherwise>
        </c:choose> 
        <ul class="list_type02 mgt10 mgb40">
        	<li class="f_right">(<strong id="pByteSize">0</strong>/500)</li>
        	<li>단순 문자 및 기호의 나열/반복 입력 시 적립금 지급 제외</li>
	        <li>1천원 미만 상품의 경우 적립금 지급제외 </li>
	        <li>한 주문 건에 동일 상품을 다수 주문한 경우, 해당 상품에 대한 후기는 1회 작성가능</li>
	        <li>무관한 포토 후기 업로드 시 적립금 지급 제외 될 수 있습니다.</li>
	        <li>우수 상품평을 작성해주신 분께는 매월 100분 추첨하여 25% 쿠폰을 드립니다.</li>
	    </ul>
    </div>

    <h2 class="tit01 mgt0 fs18">이 상품에 대한 고객님의 만족도는?</h2>
    <div class="">
        <div class="incont">
            <ul class="pop_star_wrap">
                <c:if test="${empty qnADomain.rcrdCd}">
                    <li>
                        <strong>실용성</strong>
                        <span>
                            <label for="customer-satisfaction1-1"><input type="radio" name="practicality" value="1" id="customer-satisfaction1-1" /> <span class="pop_star_grade star1">만족도별1개</span></label>
                            <label for="customer-satisfaction1-2"><input type="radio" name="practicality" value="2" id="customer-satisfaction1-2" /> <span class="pop_star_grade star2">만족도별2개</span></label>
                            <label for="customer-satisfaction1-3"><input type="radio" name="practicality" value="3" id="customer-satisfaction1-3" /> <span class="pop_star_grade star3">만족도별3개</span></label>
                            <label for="customer-satisfaction1-4"><input type="radio" name="practicality" value="4" id="customer-satisfaction1-4" /> <span class="pop_star_grade star4">만족도별4개</span></label>
                            <label for="customer-satisfaction1-5"><input type="radio" name="practicality" value="5" id="customer-satisfaction1-5" /> <span class="pop_star_grade star5">만족도별5개</span></label>
                        </span>
                    </li>
                    <li class="c_both">
                        <strong>디자인</strong>
                        <span>
                            <label for="customer-satisfaction2-1"><input type="radio" name="design" value="1" id="customer-satisfaction2-1" /> <span class="pop_star_grade star1">만족도별1개</span></label>
                            <label for="customer-satisfaction2-2"><input type="radio" name="design" value="2" id="customer-satisfaction2-2" /> <span class="pop_star_grade star2">만족도별2개</span></label>
                            <label for="customer-satisfaction2-3"><input type="radio" name="design" value="3" id="customer-satisfaction2-3" /> <span class="pop_star_grade star3">만족도별3개</span></label>
                            <label for="customer-satisfaction2-4"><input type="radio" name="design" value="4" id="customer-satisfaction2-4" /> <span class="pop_star_grade star4">만족도별4개</span></label>
                            <label for="customer-satisfaction2-5"><input type="radio" name="design" value="5" id="customer-satisfaction2-5" /> <span class="pop_star_grade star5">만족도별5개</span></label>
                        </span>
                    </li>
                </c:if>
                <c:if test="${not empty qnADomain.rcrdCd}">
                    <li>
                        <strong>만족도</strong>
                        <span>
                            <label for="customer-satisfaction1-1"><input type="radio" name="practicality" value="1" id="customer-satisfaction1-1" /> <span class="pop_star_grade star1">만족도별1개</span></label>
                            <label for="customer-satisfaction1-2"><input type="radio" name="practicality" value="2" id="customer-satisfaction1-2" /> <span class="pop_star_grade star2">만족도별2개</span></label>
                            <label for="customer-satisfaction1-3"><input type="radio" name="practicality" value="3" id="customer-satisfaction1-3" /> <span class="pop_star_grade star3">만족도별3개</span></label>
                            <label for="customer-satisfaction1-4"><input type="radio" name="practicality" value="4" id="customer-satisfaction1-4" /> <span class="pop_star_grade star4">만족도별4개</span></label>
                            <label for="customer-satisfaction1-5"><input type="radio" name="practicality" value="5" id="customer-satisfaction1-5" /> <span class="pop_star_grade star5">만족도별5개</span></label>
                        </span>
                    </li>
                    <li class="c_both" style="display:none;">
                        <strong>디자인</strong>
                        <span>
                            <label for="customer-satisfaction2-1"><input type="radio" name="design" value="1" id="customer-satisfaction2-1" checked="checked"/> <span class="pop_star_grade star1">만족도별1개</span></label>
                            <label for="customer-satisfaction2-2"><input type="radio" name="design" value="2" id="customer-satisfaction2-2" /> <span class="pop_star_grade star2">만족도별2개</span></label>
                            <label for="customer-satisfaction2-3"><input type="radio" name="design" value="3" id="customer-satisfaction2-3" /> <span class="pop_star_grade star3">만족도별3개</span></label>
                            <label for="customer-satisfaction2-4"><input type="radio" name="design" value="4" id="customer-satisfaction2-4" /> <span class="pop_star_grade star4">만족도별4개</span></label>
                            <label for="customer-satisfaction2-5"><input type="radio" name="design" value="5" id="customer-satisfaction2-5" /> <span class="pop_star_grade star5">만족도별5개</span></label>
                        </span>
                    </li>
                </c:if>
            </ul>
        </div>
    </div>
   
    <c:if test="${empty qnADomain.rcrdCd}">
    	<h2 class="c_both tit01 pdt20 mgt60 fs18 bt_line">사진첨부</h2>
        <div class="">
            <div class="incont mgt10">
                <input type="file" name="imageFile" style="width:390px;height:22px;"/>
                <c:if test="${not empty qnADomain.imageUrl}">
                <div class="mgt10 fs14">
                	<!--<span class="">${qnADomain.imageUrl}</span>-->
                	<input class="" type="checkbox" name="delImageYn" />
                	<label class=""><span class="c_red fw500">업로드 사진 삭제 </span><span> ( 작성 버튼 클릭 시 삭제됩니다. )</span></label>
                </div>
                </c:if>
            </div>
        </div>
    </c:if>    
    <div class="btn_area t_center mgt30">
        <a href="javascript://" onclick="self.close()" class="btn_type04_v2">취소</a>
        <a href="#n" id="imgSaveComment" class="btn_type04_v1 mgl10">작성</a>
    </div>
    </form>
</div>
<%--<div class="pop_close">
    <a href="javascript://" onclick="self.close()">닫기</a>
</div>--%>
</div>
</body>
</html>
