<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<ui:decorator name="popup"/>
<html>
<head>
<script type="text/javascript" src="/js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="/js/jquery.form.js"></script>
<link rel="stylesheet" type="text/css" href="/css/contents.css"/>
<script type="text/javascript" charset="utf-8">
function callbackZipcode(address, zipcode) {
    $("input[name='addr1']").val(address);
    $("input[name='postNum1']").val(zipcode.substring(0,3));
    $("input[name='postNum2']").val(zipcode.substring(4,7));
}

jQuery(function(){
    <%-- 숫자만 입력 가능 --%>
    $('input.inputNumberText').keypress(function(event) {
        if (event.which != 13) { 
            if (event.which != 8) {
                if (event.which < 48 || event.which > 57) {
                    event.preventDefault();
                }
            }
        }
    });
    
    <%-- 이메일 선택 이벤트 --%>
    $("select[name='emailSelect']").change(function() {
        $(this).parent().find("input[name=emailAddr2]").val($(this).val());
        if($(this).val() == "") {
            $(this).attr("disabled", false);
            $(this).parent().find("input[name=emailAddr2]").attr("disabled", false);
        }else {
            $(this).parent().find("input[name=emailAddr2]").attr("disabled", true);
        }
    });
    
    <%-- 등록 --%>
    $("#registFrm").click(function(event) {
        event.preventDefault();
        $("form#deliveryAddressForm").ajaxSubmit({
            url:'/ht/mypage/updateDeliveryAddress'
            , dataType:'json'
            , success: function(data){
                if(data.success) {
                    alert('<fmt:message key="message.save.success"/>');
                    opener.location.reload();
                    self.close();
                }else{
                    var errorMessages = data.errorMessages;
                    var errorStr="";
                    for(i=0; i<errorMessages.length; i++) {
                        errorStr += errorMessages[i] + "\n";
                    }
                    alert(errorStr);
                }
            }
            , error: function(data){
                alert("<fmt:message key='error.common.system'/>");
            }
        });
    });
    
});
</script>
</head>
<body>
<div style="width:660px">
    <h1><img src="${imageServer}/images/renewal/common/tit_pop_create_form_felivery_address.gif" alt="배송지 등록" /></h1>
    <div class="pop_cont">
        <form id="deliveryAddressForm">
            <input type="hidden" name="addrSequence" value="${userAddress.addrSequence}" />
            <input type="hidden" name="addrGbn" value="${userAddress.addrGbn}" />
            <table class="table02">
                <caption>배송지 등록 <span>기본 배송지, 구분, 제목, 이름, 우편번호, 주소, 전화번호, 휴대폰, 이메일</span></caption>
                <colgroup> 
                    <col style="width:95px" />
                    <col style="width:215px" />
                    <col style="width:95px" />
                    <col style="width:*" />
                </colgroup> 
                <tbody> 
                    <tr>
                        <th scope="row">기본 배송지</th>
                        <td><input name="mainAddrYn" id="mainAddrYn" type="checkbox" value="true" class="radios" <c:if test="${userAddress.mainAddrYn eq 'true'}" >checked='checked'</c:if>/> <label for="mainAddrYn">기본배송지로 등록</label></td>
                        <th scope="row">구분</th>
                        <td>기타</td>
                    </tr>
                    <tr>
                        <th scope="row">제목</th>
                        <td><input type="text" name="addrTitle" style="width:130px;" class="input_txt" value="${userAddress.addrTitle}" /></td>
                        <th scope="row">이름</th>
                        <td><input type="text" name="name" style="width:130px;" class="input_txt" value="${userAddress.addrTitle}" /></td>
                    </tr>
                    <tr>
                        <th scope="row">우편번호</th>
                        <td colspan="3">
                            <input type="text" name="postNum1" value="${userAddress.postNum1}" style="width:33px;" class="input_txt" readonly="readonly"/> -
                            <input type="text" name="postNum2" value="${userAddress.postNum2}" style="width:33px;" class="input_txt" readonly="readonly" />
                            <a href="/ht/listZipcode" onclick="window.open(this.href, '', 'width=400,height=372, scrollbars=yes,resizable=no'); return false;" class="btn_type01">우편번호 검색</a>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">주소</th>
                        <td colspan="3">
                            <input type="text" name="addr1" value="${userAddress.addr1}" class="input_txt" title="주소 입력" style="width:440px;" readonly="readonly"/>
                            <div class="br">
                                <input type="text" name="addr2" value="${userAddress.addr2}" class="input_txt" title="상세주소 입력" style="width:440px;" />
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">전화번호</th>
                        <td>
                            <input type="text" name="telNum1" value="${userAddress.telNum1}" style="width:34px;ime-mode:disabled" class="input_txt inputNumberText" maxlength="3"/> -
                            <input type="text" name="telNum2" value="${userAddress.telNum2}" style="width:34px;ime-mode:disabled" class="input_txt inputNumberText" maxlength="4"/> -
                            <input type="text" name="telNum3" value="${userAddress.telNum3}" style="width:34px;ime-mode:disabled" class="input_txt inputNumberText" maxlength="4"/>
                        </td>
                        <th scope="row">휴대폰</th>
                        <td>
                            <input type="text" name="handPhoneNum1" value="${userAddress.handPhoneNum1}" style="width:34px;ime-mode:disabled" class="input_txt inputNumberText" maxlength="3"/> -
                            <input type="text" name="handPhoneNum2" value="${userAddress.handPhoneNum2}" style="width:34px;ime-mode:disabled" class="input_txt inputNumberText" maxlength="4"/> -
                            <input type="text" name="handPhoneNum3" value="${userAddress.handPhoneNum3}" style="width:34px;ime-mode:disabled" class="input_txt inputNumberText" maxlength="4"/>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">이메일</th>
                        <td colspan="3">
                            <input type="text" name="emailAddr1" value="${userAddress.emailAddr1}" style="width:168px;" class="input_txt" /> @
                            <input type="text" name="emailAddr2" value="${userAddress.emailAddr2}" class="emailAddr2" style="width:120px;" class="input_txt" />
                            <select name="emailSelect" class="select" style="width:120px;">
                                <option value="">직접입력</option>
                                <option value="naver.com" <c:if test="${userAddress.emailAddr2 eq 'naver.com'}" >selected='selected'</c:if>>naver.com</option>
                                <option value="hanmail.net" <c:if test="${userAddress.emailAddr2 eq 'hanmail.net'}" >selected='selected'</c:if>>hanmail.net</option>
                                <option value="hotmail.com" <c:if test="${userAddress.emailAddr2 eq 'hotmail.com'}" >selected='selected'</c:if>>hotmail.com</option>
                                <option value="nate.com" <c:if test="${userAddress.emailAddr2 eq 'nate.com'}" >selected='selected'</c:if>>nate.com</option>
                                <option value="yahoo.co.kr" <c:if test="${userAddress.emailAddr2 eq 'yahoo.co.kr'}" >selected='selected'</c:if>>yahoo.co.kr</option>
                                <option value="empas.com" <c:if test="${userAddress.emailAddr2 eq 'empas.com'}" >selected='selected'</c:if>>empas.com</option>
                                <option value="dreamwiz.com" <c:if test="${userAddress.emailAddr2 eq 'dreamwiz.com'}" >selected='selected'</c:if>>dreamwiz.com</option>
                                <option value="freechal.com" <c:if test="${userAddress.emailAddr2 eq 'freechal.com'}" >selected='selected'</c:if>>freechal.com</option>
                                <option value="lycos.co.kr" <c:if test="${userAddress.emailAddr2 eq 'lycos.co.kr'}" >selected='selected'</c:if>>lycos.co.kr</option>
                                <option value="korea.com" <c:if test="${userAddress.emailAddr2 eq 'korea.com'}" >selected='selected'</c:if>>korea.com</option>
                                <option value="gmail.com" <c:if test="${userAddress.emailAddr2 eq 'gmail.com'}" >selected='selected'</c:if>>gmail.com</option>
                                <option value="hanmir.com" <c:if test="${userAddress.emailAddr2 eq 'hanmir.com'}" >selected='selected'</c:if>>hanmir.com</option>
                                <option value="paran.com" <c:if test="${userAddress.emailAddr2 eq 'paran.com'}" >selected='selected'</c:if>>paran.com</option>
                            </select>
                        </td>
                    </tr>
                </tbody>
            </table>
        </form>
    </div>
    <div class="btn_area t_center mgb25">
        <a href="#n" id="registFrm" class="btn_type01" style="width:51px">등록</a>
        <a href="javascript://" onclick="javascript:self.close()" class="btn_type05" style="width:51px">취소</a>
    </div>
</div>
<div class="pop_close">
    <a href="javascript://" onclick="javascript:self.close()">닫기</a>
</div>
</body>
</html>