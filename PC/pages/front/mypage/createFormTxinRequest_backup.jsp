<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<ui:decorator name="popup"/>
<html>
<head>
<script type="text/javascript" src="/js/jquery.form.js"></script>
<script type="text/javascript">
jQuery(function() {
    <%-- 이메일 선택 이벤트 --%>
    $("select[name=emailSelect]").change(function() {
        $(this).parent().find("input[name=emailAddr2]").val($(this).val());
        if($(this).val() == "") {
            $(this).attr("disabled", false);
            $(this).parent().find("input[name=emailAddr2]").attr("disabled", false);
        }else {
            $(this).parent().find("input[name=emailAddr2]").attr("disabled", true);
        }
        $(this).parent().find("input[name=emailAddr2]").val($(this).val());
        
    });
    
    $("#registBiz").click(function(event) {
        event.preventDefault();
        $("form#createTaxBillRequestForm").ajaxSubmit({
            url:'/ht/mypage/addUserBusinessRegistNum'
            , dataType:'json'
            , success: function(data){
                if(data.success) {
                    alert('<fmt:message key="message.save.success"/>');
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
    
    $("#cancelBiz").click(function(event) {
        event.preventDefault();
        self.close();
    });
});
</script>
</head>
<body>
<div style="widht:820px;">
    <h1><img src="${imageServer}/images/renewal/common/h2_popup_mypage08.gif" alt="사업자등록번호 등록" /></h1>
    <div class="pop_cont">
        <form name="createTaxBillRequestForm" id="createTaxBillRequestForm" action="/ht/mypage/addUserBusinessRegistNum" method="post">
        <table class="table02 mgt15">
            <colgroup> 
                <col width="15%" />
                <col width="35%" />
                <col width="15%" />
                <col width="35%" />
            </colgroup>
            <tbody>
                <tr>
                    <th>사업자등록번호</th>
                    <td colspan="3"><input type="text" name="bizRegNum1" style="width:36px;" class="input_txt" maxlength="3"/> -
                    <input type="text" name="bizRegNum2" style="width:36px;" class="input_txt" maxlength="2"/> -
                    <input type="text" name="bizRegNum3" style="width:36px;" class="input_txt" maxlength="6"/></td>
                </tr> 
                <tr> 
                    <th>상호명[법인명]</th>
                    <td><input type="text" name="vndrName" style="width:200px;" class="input_txt"/></td>
                    <th>대표자명</th>
                    <td><input type="text" name="primeName" style="width:140px;" class="input_txt" /></td>
                </tr>
                <tr>
                    <th>업태</th>
                    <td><input type="text" name="bizTypeInfo" style="width:200px;" class="input_txt"/></td>
                    <th>종목</th>
                    <td><input type="text" name="bizKindInfo" style="width:140px;" class="input_txt"/></td>
                </tr>
                <tr>
                <tr>
                    <th>사업자 소재지</th>
                    <td colspan="3"><input type="text" name="vndrAddr" style="width:485px;" class="input_txt" /></td>
                </tr>
                <tr>
                    <th>담당자명</th>
                    <td colspan="3"><input type="text" name="mngrName" style="width:130px;" class="input_txt" /></td>
                </tr>
                <tr>
                    <th>이메일</th>
                    <td colspan="3">
                        <input type="text" name="emailAddr1" style="width:118px;" class="input_txt"  /> <span class="mm1">@</span>
                        <input type="text" name="emailAddr2" class="emailAddr2" style="width:100px;" class="input_txt" />
                        <select name="emailSelect" class="select" style="width:115px;">
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
                </tr>
            </tbody>
        </table>
        <div class="t_center mgt15">
            <a href="#n" class="btn_type01" id="registBiz">등록</a>
            <a href="#n" class="btn_type02" id="cancelBiz">취소</a>
        </div>
        </form>
    </div>
</div>
<div class="pop_close">
    <a href="javascript://" onclick="self.close()">닫기</a>
</div>
</body>
</html>