<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<html>
<head>
<script type="text/javascript">
jQuery(function($){
    $(document).ready(function(){
        checkLength("textarea[name=prdtQnaTitle]", "span#chkByte", 500);
    });
});
function fileSelected() {
    var count = document.getElementById('uploadImage').files.length;
    // document.getElementById('details').innerHTML = "";
    for (var index = 0; index < count; index ++) {
        var file = document.getElementById('uploadImage').files[index];
        var fileSize = 0;
        if (file.size > 1024 * 1024)
               fileSize = (Math.round(file.size * 100 / (1024 * 1024)) / 100).toString() + 'MB';
        else
               fileSize = (Math.round(file.size * 100 / 1024) / 100).toString() + 'KB';
        // alert('Name: ' + file.name + '<br>Size: ' + fileSize + '<br>Type: ' + file.type);
        // document.getElementById('details').innerHTML += '<p>';
        
        var fd = new FormData(document.imageUploadFrm);
        $.ajax({
            url: "/uploadImage",
            type: "POST",
            data: fd,
            dataType : "json", 
            enctype: 'multipart/form-data',
            processData: false,  // tell jQuery not to process the data
            contentType: false   // tell jQuery not to set contentType
          }).done(function( data ) {
              if( data.save ){
                  $("[name=imageUrl]").val(data.imagePath);
                  $("#thums").attr("src", "http://image.kyobobook.co.kr/newimages/giftshop_new/work/"+data.imagePath);
              }else{
                  alert(data.errorMessage);
              }
          }).fail(function( data ) {
              alert("이미지업로드 중에 오류가 발생하였습니다.");
          });
    }
}

function submitFrm(){
    var gradeInt = parseInt((parseInt($("[name=practicality]").val()) + parseInt($("[name=design]").val()))/2);
    $.ajax({
        type: "POST"
        ,url: "/m/gift/detail/submitReview"
        ,data:{
            sellPrdtBcode:"${product.sellPrdtBcode}"
            ,prdtGrade:gradeInt
            ,prdtQnaSeq:"${ext.prdtQnaSeq}"
            ,rcrdReviewSeq:"${ext.rcrdReviewSeq}"
            ,prdtQnaTitle:$("textarea[name=prdtQnaTitle]").val()
            ,procStatGbn:"R"
            ,orderNum:"${ext.orderNum}"
            ,orderPrdtInseq:"${ext.orderPrdtInseq}"
            ,imageUrl:$("input[name=imageUrl]").val()
            ,dispYn:true
            ,aswrYn:false
            ,openYn:true
            ,rcrdCd:"${product.rcrdCd}"
            }
        ,dataType: 'json'
        ,success: function(result){
            if(result){
                var isSuccss      = result.isSuccess;
                var errorMessages = result.errorMessages;
                if(isSuccss){
                    alert("정상적으로 등록되었습니다.");
                    if("${rtnGbn}" == "P"){
                        location.replace("/p/${product.sellPrdtBcode}");
                    }else{
                        location.replace("/m/mypage/listMyReview");
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
        ,error: function(result){
            console.log(result);
            alert('<fmt:message key="error.common.system"/>');
        }
    });
}

function findImageFile(){
    if(window.HybridApp != undefined && window.HybridApp.openCrop != undefined){
        window.HybridApp.openCrop( "uploadImage" ); //"contents" : key
    }else{
        document.imageUploadFrm.uploadImage.click();
    }
}

function setFilePath(path){
    if(window.HybridApp != undefined && window.HybridApp.openCrop != undefined){
        imagePath = path.replace("http://image.kyobobook.co.kr/newimages/giftshop_new/work/");
        $("[name=uploadImage]").val(imagePath);
        $("#thums").attr("src", path);
    }else{
        $("[name=uploadImage]").val(path);
    }
}

function setGrade(name, grade){
    $("[name="+name+"]").val(grade);
    $("#r_"+name).removeClass("rate1");
    $("#r_"+name).removeClass("rate2");
    $("#r_"+name).removeClass("rate3");
    $("#r_"+name).removeClass("rate4");
    $("#r_"+name).removeClass("rate5");
    $("#r_"+name).addClass("rate"+grade);
}

function setSimpleReview(){
    $("[name=prdtQnaTitle]").val($("[name=simpleTxt]").val());
    checkLength("textarea[name=prdtQnaTitle]", "span#chkByte", 500);
}

function checkLength(chkObj, printObj, maxLength){
    var str = new String($(chkObj).val());
    var _byte = 0;
    if(str.length != 0){
        for(var i = 0; i < str.length; i++){
            if(escape(str.charAt(i)).length > 4)    _byte += 2;
            else                                    _byte++;

            if(_byte > maxLength){
                alert('제한 글자 수를 초과하였습니다');
                $(chkObj).val(str.substr(0, i-1));

                if(escape(str.charAt(i)).length > 4)    _byte -= 2;
                else                                    _byte--;

                break;
            }
        }
    }
    
    $(printObj).html("("+Byte_Length($(chkObj).val())+"/"+maxLength+")");
}
</script>
</head>
<body>
<!-- content -->
<div id="sc_content">
<!-- tit_section -->
<div id="sc_header">
    <c:choose>
        <c:when test="${ext.prdtQnaSeq ne 0 || not empty ext.rcrdReviewSeq}"><h1>상품평 수정하기</h1></c:when>
        <c:otherwise><h1>상품평 등록하기</h1></c:otherwise>
    </c:choose>
</div>
<!-- //tit_section -->

<form name="imageUploadFrm" id="imageUploadFrm" action="/uploadImage" enctype="multipart/form-data" style="display:none;">
    <input type="file" name="uploadImage" id="uploadImage" onchange="fileSelected();" accept="image/*"/>
</form>
<form name="reviewForm" action="/m/gift/detail/submitReview" method="post">
    <input type="hidden" name="prdtQnaSeq" value="${ext.prdtQnaSeq}" />
    <input type="hidden" name="prdtGrade" value="${ext.prdtGrade}" />
    <input type="hidden" name="rcrdCd" value="${product.rcrdCd}" />
    <c:choose>
        <c:when test="${not empty ext.prdtQnaSeq}"><input type="hidden" name="openYn" value="${ext.openYn}" /></c:when>
        <c:otherwise><input type="hidden" name="openYn" value="Y" /></c:otherwise>
    </c:choose>
    <input type="hidden" name="imageUrl" value="${ext.imageUrl}"/>
    <div class="prod_info">
        <c:choose>
            <c:when test="${product.sellPrdtGbn eq 'R' || product.sellPrdtGbn eq 'D'}">
                <p class="img"><ui:image rcrdCd="${product.rcrdCd}" ratingCode="A"/></p>
            </c:when>
            <c:otherwise>
                <p class="img"><ui:image src="${product.productImageUrl}" server="product" size="200" alt="${product.prdtName}"/></p>
            </c:otherwise>
        </c:choose>
        <p class="txt">${product.prdtName}</p>
    </div>

    <div class="rating_box">
        <input type="hidden" name="practicality" value="${ext.prdtGrade}"/>
        <input type="hidden" name="design" value="${ext.prdtGrade}"/>
        <c:choose>
            <c:when test="${product.sellPrdtGbn ne 'R' && product.sellPrdtGbn ne 'D'}">
                <div class="rating rate${ext.prdtGrade}" id="r_practicality">
                    <strong>실용성</strong>
                    <a href="#" class="r01" onclick="setGrade('practicality', 1);return false;">1점</a>
                    <a href="#" class="r02" onclick="setGrade('practicality', 2);return false;">2점</a>
                    <a href="#" class="r03" onclick="setGrade('practicality', 3);return false;">3점</a>
                    <a href="#" class="r04" onclick="setGrade('practicality', 4);return false;">4점</a>
                    <a href="#" class="r05" onclick="setGrade('practicality', 5);return false;">5점</a>
                </div>
                <div class="rating rate${ext.prdtGrade}" id="r_design">
                    <strong>디자인</strong>
                    <a href="#" class="r01" onclick="setGrade('design', 1);return false;">1점</a>
                    <a href="#" class="r02" onclick="setGrade('design', 2);return false;">2점</a>
                    <a href="#" class="r03" onclick="setGrade('design', 3);return false;">3점</a>
                    <a href="#" class="r04" onclick="setGrade('design', 4);return false;">4점</a>
                    <a href="#" class="r05" onclick="setGrade('design', 5);return false;">5점</a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="rating rate${ext.prdtGrade}" id="r_practicality">
                    <strong>만족도</strong>
                    <a href="#" class="r01" onclick="setGrade('practicality', 1);return false;">1점</a>
                    <a href="#" class="r02" onclick="setGrade('practicality', 2);return false;">2점</a>
                    <a href="#" class="r03" onclick="setGrade('practicality', 3);return false;">3점</a>
                    <a href="#" class="r04" onclick="setGrade('practicality', 4);return false;">4점</a>
                    <a href="#" class="r05" onclick="setGrade('practicality', 5);return false;">5점</a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
    <p class="info mt5 t_c">별점을 등록해 주세요.</p>
    
    <div class="box_flex t_select">
        <select class="select" name="simpleTxt" onchange="setSimpleReview();">
            <option value="">간단 리뷰 등록</option>
            <option value="마음에 쏙 들어요.">마음에 쏙 들어요.</option>
            <option value="빠른 배송 감사합니다.">빠른 배송 감사합니다.</option>
            <option value="친구에게 추천하고 싶어요.">친구에게 추천하고 싶어요.</option>
            <option value="생각보다 별로네요.">생각보다 별로네요.</option>
        </select>
    </div>
    <div class="textarea_box"><textarea class="textarea" title=" 상품후기 입력" style="height:100px;" name="prdtQnaTitle" onkeydown="checkLength('textarea[name=prdtQnaTitle]', 'span#chkByte', 500)"><c:out value="${ext.prdtQnaTitle}" escapeXml="true"/></textarea></div>
    <p class="info mt5"><span class="fl_r" id="chkByte">(0/500)</span></p>
    <c:if test="${product.sellPrdtGbn ne 'R' && product.sellPrdtGbn ne 'D'}">
        <div class="photo_upload">
            <strong>사진 첨부하기</strong>
            <c:choose>
                <c:when test="${not empty ext.imageUrl}">
                    <a href="#" onclick="findImageFile();return false;"><ui:image src="${ext.imageUrl}" onerror="this.src='/images/season02/btn_plus_2.png';return false;" id="thums"/></a>
                </c:when>
                <c:otherwise>
                    <a href="#" onclick="findImageFile();return false;"><img src="/images/season02/btn_plus_2.png" alt="이미지추가" id="thums"/></a>
                </c:otherwise>
            </c:choose>
        </div>
    </c:if>
    <div class="box_flex btn_area btn_area02 mt30">
        <c:choose>
            <c:when test="${ext.prdtQnaSeq ne 0 || not empty ext.rcrdReviewSeq}">
                <a href="/m/gift/detail/removeReview?prdtQnaSeq=${ext.prdtQnaSeq}&rcrdReviewSeq=${ext.rcrdReviewSeq}&rtnGbn=${rtnGbn}&sellPrdtBcode=${product.sellPrdtBcode}" class="btn btn_gray">삭제</a>
                <a href="javascript:submitFrm();" class="btn btn_gray bg_orange">수정</a>
            </c:when>
            <c:otherwise>
                <a href="javascript:history.back();" class="btn btn_gray">취소</a>
                <a href="javascript:submitFrm();" class="btn btn_gray bg_orange">등록</a>
            </c:otherwise>
        </c:choose>
    </div>
    <a href="javascript:history.back();" class="btn_back">뒤로</a>
</div>
<!-- //content -->
</body>
</html>