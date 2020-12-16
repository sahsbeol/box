<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<ui:decorator name="popup"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<style type="text/css">
label#content_pre { position: absolute;top: 504px; left: 117px; z-index:-1;}
label#content_pre + textarea{background-color:transparent; width:367px;height:100px;}
</style>
<script type="text/javascript" src="/js/jquery-1.4.2.min.js" charset="utf-8"></script>
<script type="text/javascript" src="/js/jquery.form.js"></script>
<script type="text/javascript">
jQuery(function($) {
    $(document).ready(function(){
        window.resizeTo(518, 825);
        if($("label#content_pre + textarea").val()!="")
            $("label#content_pre").hide();
        else
        	$("label#content_pre").show();
    });
    
    var urlStr = "/ht/product/saveQuestion";
    var titleVal;
    var contentVal;
    var publicYnVal;
    var userNameVal;
    var userEmailVal;
    
    var  errorMessages = {title:"제목을 적어 주세요"
        , userName:"이름을 적어 주세요"
        , userEmail:"이메일을 적어 주세요"
        , content:"내용을 적어 주세요"
        , emailFormat:"이메일 형식을 확인하세요"
        , publicYn:"공개여부를체크해주세요"};
    
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
    
    function deleteErrorMessage(Boolean, keyVal){
        if(eval(Boolean))
            delete errorMessages[keyVal];    
    };
    
    function checkStrLength(object){
        var size = object.val().getByteSize();
        var isTrue = (size !== 0);
        var key = object.attr("name");
        
        deleteErrorMessage(isTrue, key);
    };
    
    function checkSelected(object){
        var isTrue = object.attr("checked");
        var key = object.attr("name");
        
        deleteErrorMessage(isTrue, key);
    };
    function checkEmailFormat(object){
        var regExp = /^[_a-zA-Z0-9-]+(.[_a-zA-Z0-9-]+)*@[a-zA-Z0-9-]+(.[a-zA-Z0-9-]+)*$/;
        var emailStr = object.val();
        var isTrue = regExp.test(emailStr);
        var key = "emailFormat";
        
        deleteErrorMessage(isTrue , key);
    };
    
    function checkRadio(){
        $(" :radio").each(function(){
            var $radio = $(this);
            checkSelected($radio);
        });
    };    
    
    function checkTexts(){
        $(" input[type='text']").each(function(){
            var $inputText = $(this);
            checkStrLength($inputText);
        });
        checkStrLength($("textArea"));
        checkEmailFormat($("#inputEmail"));
    }
    
    function reloadNCloseWindow(){
        parent.opener.loadQuestionSubList();
        self.close();
    }
    
    function ajaxSuccessHandler(result){
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
    
    function ajaxErrorHandler(result){
        alert('<fmt:message key="error.common.system"/>');
    }
    
    function setQuestionWithAjax(){
        $.ajax({
            type: "POST"
              ,url: urlStr
              ,dataType: "json"
              ,data:{barcode        :"${qnADomain.barcode}"
                  , title                :titleVal
                  , content            :contentVal
                  , publicYn            :publicYnVal
                  , seq                :"${qnADomain.seq}"
                  , userName            :userNameVal
                  , userEmail            :userEmailVal
                  , grade                :"0"
              }
            ,success : ajaxSuccessHandler
            ,error : ajaxErrorHandler
       });
    }
    
    function setParams4Ajax(){
        titleVal         = $("input[name='title']").val();
        contentVal         = $("textArea").val();
        publicYnVal        = $("[name=publicYn]:checked").val();
        userNameVal     = $("input[name='userName']").val();
        userEmailVal     = $("input[name='userEmail']").val();
    }
    function checkParams(){ 
        checkTexts();
        checkRadio();
        var haveError = loadParamAlert();
        if(haveError){
            errorMessages = {title:"제목을 적어 주세요"
                , userName:"이름을 적어 주세요"
                , userEmail:"이메일을 적어 주세요"
                , content:"내용을 적어 주세요"
                , emailFormat:"이메일 형식을 확인하세요"
                , publicYn:"공개여부를체크해주세요"};
        }else{
            setParams4Ajax();
            setQuestionWithAjax();
        }
    };
    
    function addEvent(){
        $("#imgSaveQuestion").bind("click",checkParams);
    };
    
    function setForm4Modify(){
        if(eval("${update == true}")){
            urlStr = "/ht/product/modifyQuestion";
        }
    }
    setForm4Modify();
    addEvent();
    
    
});
function changePre(i){
    if(i==2)
        $("label#content_pre").hide();
    else{
        if($("label#content_pre + textarea").val()=="")
              $("label#content_pre").show();
    }
}

</script>
</head>
<body>
<div style="width:500px;">
<h1><img src="${imageServer}/images/renewal/common/tit_pop_qna_write.gif" alt="상품 Q&amp;A 쓰기" /></h1>
<div class="pop_cont">
    <div class="pop_txt_wrap">
        상품관련 문의에 대해서만 답변 받으실수 있습니다.<br />
        주문/배송/교환/환불 등 쇼핑몰 사용에 관한 문의시 임의적으로 SOS상담쪽으로 이관되어 답변 확인이 되실수 있습니다.<br />
        아래 [고객센터 바로가기]를 이용부탁드립니다.<br />
        <a href="javascript:parent.opener.location.href ='/ht/help/createCounselForm';self.close();" class="btn_type10 mgt10"><span>고객센터 바로가기</span></a>
        <p class="point02 mgt15">상품관련 문의가 아닐 경우 고객님 문의하신 내용은 마이핫트랙스 &gt; sos 상담에서 확인 가능합니다.</p>
    </div>
    
    <form id="form" action="">
    <table class="table02 mgt10">
        <caption>상품 Q&amp;A 쓰기</caption>
        <colgroup>
            <col style="width:70px" />
            <col style="width:*" />
        </colgroup>
        <tbody>
            <tr>
                <th>상품</th>
                <td>
                    <div class="p_qna">
                        <span class="thum">
                            <c:if test="${empty simpleProductDto.rcrdCd}">
                                <ui:image src="${simpleProductDto.productImageUrl}" alt="${simpleProductDto.brandName}Imgs"  server="product" size="100" />
                            </c:if>
                            <c:if test="${not empty simpleProductDto.rcrdCd}">
                                <ui:image rcrdCd="${simpleProductDto.rcrdCd}" prdtGbn="${simpleProductDto.sellPrdtGbn}" width="100" alt="${l.rcrdName}" ratingCode="A" />
                            </c:if>
                        </span>
                        <span class="company">${simpleProductDto.brandName}</span>
                        <span class="name">${simpleProductDto.productName}</span>
                        <strong class="price"><fmt:formatNumber value="${simpleProductDto.productPrice}" pattern=",###"/> 원</strong>
                    </div>
                </td>
            </tr>
            <tr>
                <th>제목</th>
                <td><input type="text" name="title" value="${qnADomain.title}" class="input_txt" style="width:284px;" title="제목입력" /></td>
            </tr>
            <tr>
                <th>작성자</th>
                <td><input type="text" name="userName" value="${userId}" class="input_txt" style="width:284px;" title="작성자입력" readonly/></td>
            </tr>
            <tr>
                <th>이메일</th>
                <td><input type="text" id="inputEmail" name="userEmail" value="${qnADomain.userEmail}" class="input_txt" style="width:284px;" title="이메일입력" /></td>
            </tr>
            <tr>
                <th>문의내용</th>
                <td><label id="content_pre">주문 후 주문/배송/취소/환불 등에 관한 문의는<br/>
                        '마이핫트랙스&lt;SOS상담'을 이용해주시기 바랍니다.<br/><br/>
                        상품문의 외 주문/배송/취소/환불 등의 문의를 남겨주시면 빠른 <br/>
                        안내가 어렵습니다.
                </label>
                    <textarea id="content" name="content" rows="" cols=""  onchange="changePre(1);" onclick="changePre(2);">${qnADomain.content}</textarea>
                </td>
            </tr>
            <tr>
                <th>공개여부</th>
                <td>
                    <label for="tit1"><input type="radio" name="publicYn" value="Y" <c:if test="${qnADomain.publicYn == 'Y'}">checked="checked"</c:if> id="tit1" /> 공개</label>
                    <label for="tit2" class="mgl10"><input type="radio" name="publicYn" value="N" <c:if test="${qnADomain.publicYn == 'N'}">checked="checked"</c:if> name="tit" id="tit2" /> 비공개</label>
                </td>
            </tr>
        </tbody>
    </table>

    <div class="btn_area t_center mgt20">
        <a href="#n" id="imgSaveQuestion" class="btn_type01" style="width:51px">글올리기</a>
        <a href="javascript://" onclick="self.close()" class="btn_type05" style="width:51px">취소</a>
    </div>
    </form>
</div>
<div class="pop_close">
    <a href="javascript://" onclick="self.close()">닫기</a>
</div>
</div>
</body>
</html>