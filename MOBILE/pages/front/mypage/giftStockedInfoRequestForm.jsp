<%@page contentType="text/html;charset=utf-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<ui:decorator name="none" />
<html>
<head>
<script src="/js/form.js" type="text/javascript" charset="utf-8"></script>
<script src="/js/validateForm.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">
$(document).ready(function(){
    <c:if test="${empty goodId}">
        alert("잘못된 접근입니다.");
        window.close();
    </c:if> 
    $("input[name='hp1']").attr("disabled", true);
    $("input[name='hp2']").attr("disabled", true);
    $("input[name='hp3']").attr("disabled", true);
    
    $("input[type=radio][name='receiveType']").change(function() {
        var radioValue = $(this).val();
        if(radioValue ==1){
            //email 선택
            $("input[name='hp1']").attr("disabled", true);
            $("input[name='hp2']").attr("disabled", true);
            $("input[name='hp3']").attr("disabled", true);
            
            $("input[name='hp1']").val('');
            $("input[name='hp2']").val('');
            $("input[name='hp3']").val('');
            
            $("input[name='emailAddr1']").attr("disabled", false);
            $("input[name='emailAddr2']").attr("disabled", false);
            $("input[name='emailAddr3']").attr("disabled", false);
            
        }else{
            //hp 선택
            $("input[name='emailAddr1']").attr("disabled", true);
            $("input[name='emailAddr2']").attr("disabled", true);
            $("input[name='emailAddr3']").attr("disabled", true);
            $("input[name='emailAddr1']").val('');
            $("input[name='emailAddr2']").val('');
            $("input[name='emailAddr3']").val('');
            
            $("input[name='hp1']").attr("disabled", false);
            $("input[name='hp2']").attr("disabled", false);
            $("input[name='hp3']").attr("disabled", false);
        }
    });
    
    // 숫자만 입력을 허용함.
    $(".onlynum").keyup(function(event){
        var v = this.value;
        var arr = [];
        
        for(var i=0 ; i < v.length ; i++){
            if(!isNaN(v.substring(i, i+1))){ arr.push(v.substring(i, i+1)); }
        }
        this.value = arr.join("");
    });
});


//저장 처리
function save(){
 // 데이터 처리 및 검증
 if(!$("#createForm").validateForm()){ return; }
 
 if($("input[type=radio][name='receiveType']:checked").val()==1){
    if($("input[name=emailAddr1]").val() == "" ||  $("input[name=emailAddr2]").val() == ""){
        alert("메일주소를 정확히 입력해 주시기 바랍니다.");
        return;
    }else{
        $("input[name=mail]").val($("input[name=emailAddr1]").val() + "@" + $("input[name=emailAddr2]").val());
    }
 }
 else{
    if($("input[name=hp1]").val() == "" ||  $("input[name=hp2]").val() == "" ||  $("input[name=hp3]").val() == ""){
        alert("핸드폰 번호를 정확히 입력해 주시기 바랍니다.");
        return;
    }else{
        $("input[name=hp]").val($("input[name=hp1]").val() + "-" + $("input[name=hp2]").val() + "-" + $("input[name=hp3]").val());
    }
 }

 // 전송
 var data = $("#createForm").formData({ debug : false });
 $.ajax({
     async : true, 
     url : "/m/mypage/giftStockedInfoRequestSubmit",
     dataType : "json", 
     type : "post", 
     data : data, 
     success : function(result, textStatus, XMLHttpRequest){
         if(result.errorMessages.length == 0){
             openrecordStockedInfoRequestEnd();
         }else{
             alert(result.errorMessages[0]);
         }
     }, 
     error: function(XMLHttpRequest, textStatus, errorThrown){
         alert(request.status + " => " + request.statusText);
     }
 });
}

</script>
</head>
<body>
<div class="req_stock_form" id="alarmLayer">
    <form id="createForm">
        <input type="hidden" name="rcrdCd" value="${goodId}" />
        <input type="hidden" name="mail" value="" />
        <input type="hidden" name="hp" value="" />
        <div class="title">
            <h1>알림예약 신청 </h1>
            <div align="right"><a href="javascript://" onclick="closeGiftStockedInfoRequest()"><img src="${imageServer }/images/mobile/common/close_white.png" id="close_btn"/></a></div>
        </div> 
        <div class="pop_cont">
            <p class="fs11 line18 point05">해당 상품이 예약등록되어 구매가 가능 할 경우,</p>
            <p class="fs11 line18 point05">회원님의 앱 푸쉬 알람으로 알려드립니다.</p>
            <p class="fs11 line18 point05"> 앱 사용자가 아니신 경우 </p>
            <p class="fs11 line18 point05"> 아래, 이메일이나 핸드폰을 입력해주세요.</p>
            <div class="box_complate mgt15 t_left">
                <div class="tb_box">
                    <table>
                        <caption>예약등록 정보 입력</caption>
                        <colgroup>
                            <col style="*" />
                            <col style="*" />
                            <col style="*" />
                        </colgroup>
                        <tr><td><input type="radio" class="radio" name="receiveType" value="1" title="이메일 선택" checked="checked" /></td>
                            <th class="t_right">이메일</th>
                            <td>
                                <input name="emailAddr1" type="text" class="input_txt" style="width:100px" title="아이디 입력" /> @
                                <input name="emailAddr2" type="text" class="input_txt" style="width:100px" title="도메인 입력" /> 
                            </td>
                        </tr>
                        <tr><td><input name="receiveType" value="2" type="radio" class="radio" title="핸드폰 선택" /></td>
                            <th class="t_right">핸드폰</th>
                            <td>
                                <input type="text" name="hp1" class="input_txt onlynum" maxlength="3" style="width:40px;ime-mode:disabled" title="핸드폰 국번 입력" /> -
                                <input type="text" name="hp2" class="input_txt inputNumberText" maxlength="4" style="width:40px;ime-mode:disabled" title="핸드폰 중간번호 입력" /> -
                                <input type="text" name="hp3" class="input_txt inputNumberText" maxlength="4" style="width:40px;ime-mode:disabled" title="핸드폰 끝자리 입력" />
                            </td>
                        </tr>
                    </table>
                </div><!-- tb_box -->
            </div><!--  box_complate mgt15 t_left -->
            <a href="javascript://" class="btn btn_orange_1" ><img src="${imageServer }/images/mobile/common/btn_plus_1.png" style="width: 20px;height: 20px; margin-top :10px; margin-right: 3px; "/>푸쉬 알람 설정</a>
            <div class="line"></div>
            <ul class="list_type02 mgt30">
                <li class="point01">현재 사용하시는 이메일 및 핸드폰을 등록하여 주십시오.</li>
                <li class="point01">E-mail/SMS 수신거부 상태에서는 알림 메일을 받으실 수 없습니다.</li>
                <li class="point02"> <a href="javascript://" onclick="goModifyMemInfo();" class="btn_type10"><span>회원정보수정</span></a></li>
            </ul>
            <div class="pop_close" style="text-align: center;">
                <a href="javascript://" onclick="save()" class="btn btn_orange">신청하기</a>
            </div><!-- pop_close -->
        </div><!--  pop_cont -->
    </form>
</div>
</body>
</html>