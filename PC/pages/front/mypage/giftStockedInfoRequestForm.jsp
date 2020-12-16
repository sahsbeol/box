<%@page contentType="text/html;charset=utf-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<ui:decorator name="popup" />
<html>
<head>
<script src="/js/music.js" type="text/javascript" charset="utf-8"></script>
<script src="/js/form.js" type="text/javascript" charset="utf-8"></script>
<script src="/js/validateForm.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">

// 저장 처리
function save(){
	// 데이터 처리 및 검증
	if(!$("#createForm").validateForm()){ return; }

    if($("input[name=emailAddr1]").val() == "" ||  $("input[name=emailAddr2]").val() == ""){
        alert("메일주소를 정확히 입력해 주시기 바랍니다.");
        return;
    }else{
    	$("input[name=mail]").val($("input[name=emailAddr1]").val() + "@" + $("input[name=emailAddr2]").val());
    }
    
    if($("input[name=hp1]").val() == "" ||  $("input[name=hp2]").val() == "" ||  $("input[name=hp3]").val() == ""){
        alert("핸드폰 번호를 정확히 입력해 주시기 바랍니다.");
        return;
    }else{
        $("input[name=hp]").val($("input[name=hp1]").val() + "-" + $("input[name=hp2]").val() + "-" + $("input[name=hp3]").val());
    }
	

	// 전송
	var data = $("#createForm").formData({ debug : false });
    $.ajax({
        async : true, 
        url : "/ht/mypage/giftStockedInfoRequestSubmit",
        dataType : "json", 
        type : "post", 
        data : data, 
        success : function(result, textStatus, XMLHttpRequest){
            if(result.errorMessages.length == 0){
                location.href = "/ht/mypage/recordStockedInfoRequestEnd";
            }else{
                alert(result.errorMessages[0]);
            }
        }, 
        error: function(XMLHttpRequest, textStatus, errorThrown){
        	alert(request.status + " => " + request.statusText);
        }
    });
}




$(document).ready(function(){
/*
	<c:if test="${!isAdd}">
	    alert("해당 음반은 기존에 등록되어 있습니다.");
	    window.close();
	</c:if>	
*/
    <c:if test="${empty goodId}">
	    alert("잘못된 접근입니다.");
	    window.close();
	</c:if> 

	
    $("select[name='emailSelect']").change(function(){
        $("input[name='emailAddr2']").val($(this).val());
        if($(this).val() != ""){
            $("input[name='emailAddr2']").attr("disabled", true);
        }else{
            $("input[name='emailAddr2']").attr("disabled", false);
        }
    });
    if($("select[name='emailSelect']").val() != ""){ $("input[name='emailAddr2']").attr("disabled", true); }
    else{ $("input[name='emailAddr2']").attr("disabled", false); }

    window.resizeTo(620, 510);
});
</script>
</head>
<body>
<div style="">
<form id="createForm">
<input type="hidden" name="rcrdCd" value="${goodId}" />
<input type="hidden" name="mail" value="" />
<input type="hidden" name="hp" value="" />
<h1><img src="${imageServer}/images/renewal/common/tit_pop_alrim02.gif" alt="알림예약 신청"/></h1>
<div class="pop_cont">
    <p class="fs11 line18 point05">해당 상품이 예약등록되어 구매가 가능 할 경우, 회원님의 이메일, SMS로 알려 드립니다.</p>
    <div class="box_complate mgt15 t_left">
        <div class="label_box">
            <label><input name="receiveType" value="1" class="required" type="radio" class="radio" title="이메일 선택" /> 이메일</label>
            <label><input name="receiveType" value="2" class="required" type="radio" class="radio" title="핸드폰 선택" /> 핸드폰</label>
            <label><input name="receiveType" value="3" class="required" type="radio" class="radio" title="이메일+핸드폰 선택" /> 이메일+핸드폰</label>
        </div>
        <div class="tb_box">
            <table>
                <caption>예약등록 정보 입력</caption>
                <colgroup>
                    <col style="width:67px" />
                    <col style="width:auto;" />
                    <col style="width:113px" />
                </colgroup>
                <tr>
                    <th class="t_right">이메일</th>
                    <td>
                        <input name="emailAddr1" type="text" class="input_txt" style="width:100px" title="아이디 입력" /> @
                        <input name="emailAddr2" type="text" class="input_txt" style="width:100px" title="도메인 입력" /> 
                        <select name="emailSelect" class="select" title="도메인 선택">
                            <option value="">직접입력</option>  
                            <option value="naver.com">naver.com</option>
                            <option value="hanmail.net">hanmail.net</option>
                            <option value="hotmail.com">hotmail.com</option>
                            <option value="nate.com">nate.com</option>
                            <option value="yahoo.co.kr">yahoo.co.kr</option>
                            <option value="empas.com">empas.com</option>
                            <option value="dreamwiz.com">dreamwiz.com</option>
                            <option value="freechal.com">freechal.com</option>
                            <option value="lycos.co.kr">lycos.co.kr</option>
                            <option value="korea.com">korea.com</option>
                            <option value="gmail.com">gmail.com</option>
                            <option value="hanmir.com">hanmir.com</option>
                            <option value="paran.com">paran.com</option>
                        </select>
                    </td>
                    <td rowspan="2" class="t_center">
                        <a href="javascript://" onclick="save()" class="btn_ok">확인</a>
                    </td>
                </tr>
                <tr>
                    <th class="t_right">핸드폰</th>
                    <td>
                        <input type="text" name="hp1" class="input_txt onlynum" style="width:40px;ime-mode:disabled" title="핸드폰 국번 입력" /> -
                        <input type="text" name="hp2" class="input_txt inputNumberText" style="width:40px;ime-mode:disabled" title="핸드폰 중간번호 입력" /> -
                        <input type="text" name="hp3" class="input_txt inputNumberText" style="width:40px;ime-mode:disabled" title="핸드폰 끝자리 입력" />
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <ul class="list_type02 mgt30">
        <li>현재 사용하시는 이메일 및 핸드폰을 등록하여 주십시오.</li>
        <li>해당 정보를 변경하시면 회원정보에서도 자동으로 수정됩니다.</li>
        <li class="point01">회원정보 변경 시 핫트랙스의 회원정보만 변경됩니다.</li>
        <li class="point01">E-mail/SMS 수신거부 상태에서는 알림 메일을 받으실 수 없습니다. <a href="javascript://" onclick="parent.opener.goModifyMemInfo();self.close();" class="btn_type10 f_right"><span>회원정보 수정</span></a></li>
    </ul>
</div>
<div class="pop_close">
    <a href="javascript://" onclick="self.close()">닫기</a>
</div>
</div>
</form>
</body>
</html>