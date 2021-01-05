<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<ui:decorator name="layer"/>
<html>
<head>
<style type="text/css">
.tog_btn{ background-color:#fff; color :#ff6600; border:1px solid #ff6600; height : 30px; padding-top : 4px;}
.tog_btn.active{ background-color:#ff6600; border:1px solid #ff6600; height : 30px; padding-top : 4px;}
.btn_type01{

}
.pop_cont h1{ text-align: center;
    color : #fff;
    background-color: #fd6f1b;
    margin-bottom: 10px;
    padding-top: 15px;
    height : 50px;
}
.point02{   
    color: #fd6f1b;
    font-weight: bolder;
}
.pop_cont{ 
    background-color: #fff;
    padding-bottom: 20px;
}
.list_type02 li{   
    text-align: center;
    font-size: 1.1em;
    font-weight: bold;
    padding-top : 10px;
    padding-bottom : 5px;
    color: #9f9f9f;
}
div.line{   
    margin-top : 10px;
    margin-bottom : 10px;
    width : auto;
    border: 0.1px solid #eee;
    margin-left: 10px;
    margin-right: 10px;
}
th{ 
    width : auto;
    padding-left: 30px;
    padding-right: 30px;
    padding-bottom: 10px;
}
td{
    padding-bottom: 10px;
    color : #a2a2a2;
}
td input{
    border-radius : 5px;
    border-color: #aaa;
}
.btn_type01{
    border-radius : 5px;
    background-color: #fd6f1b;
    width : 80px;
    height : 30px;
    font-weight: bold;
    margin-left: 5px;
    margin-right: 5px;
    padding-top : 10px;
    border:1px solid #fd6f1b;
    color:#fff;
}
#error_console{
    margin : 10px;
    border : 0px solid #fff;
    width : 100%;
    color :  #fd6f1b;
    text-align: center;
}
</style>
<script type="text/javascript" src="/js/jquery.form.js" charset="utf-8"></script>
<script type="text/javascript">
var availAmount = ${depositParam.availableRefundAmount};
function cutoff(price) {
    return Math.round(price / 10) * 10;
}

jQuery(function($) {
	$("#error_console").hide();
    $(document).ready(function() {
        if (availAmount == 0) {
            alert("신청가능한 예치금이 없습니다.");
            //window.close();
            closeLayer();
        }
    });
    
    $("#requestFrm").click(function (event) {
        event.preventDefault();
        $('form[name="form"]').ajaxSubmit({
            type: "POST"
            ,url:"/m/mypage/saveDepositRefund"
            ,dataType: 'json'
            ,success: function(data) {
                if (data.save) {
                    alert("예치금 환불신청이 접수되었습니다."); 
                    location.reload(true);
                    closeLayer();
                } else {
                	$("#error_console").show();
                	$("#error_console").val(data.errorMessages);
                }
            }
            ,error: function() {
                alert('<fmt:message key="error.common.system"/>');
            }
        });
    });
    
    $("#cancelFrm").click(function () { 
        //closeLayer();
        $(':text:not([id=accountHolderName])').val('');
        //셀렉트 박스 초기화
        $('select').each(function(){
            $(this).find('option:first').attr('selected','true');
        });
    });
     
    $('input.cutofftextbox').blur(function(){
        var oldValue = $(this).val();
        var newValue = cutoff(oldValue);
        $(this).attr('value', newValue);
    });
});
</script>
</head>
<body>
<div class="pop_cont">
    <h1>예치금환불신청</h1>
    <ul class="list_type02">
        <c:if test="${not empty user }">
            <li>환불계좌 예금주는 회원본인만 가능합니다.</li>
            <li>환불요청 예치금은 신청한 다음날 </li>
            <li>해당 계좌로 입금됩니다.</li>
        </c:if>
        <c:if test="${empty user }">
            <li>환불요청 예치금은 신청한 다음날 해당 계좌로 입금됩니다.</li>
        </c:if>
    </ul>
    <div class="line"></div>
    <form id="form" name="form"> 
        <table class="table02 mgt15">
            <caption>예치금환불신청 <span>환불가능 금액, 예금주, 환불대기 금액, 환불은행, 환불신청 금액, 환불계좌번호</span></caption>
            <colgroup>
                <col style="*" />
                <col style="*" />
                <col style="*" />
                <col style="*" />
            </colgroup>
            <tr> 
                <th scope="row">환불 가능금액</th> 
                <td><span class="point02"><fmt:formatNumber value="${depositParam.availableRefundAmount}" pattern="#,###"/></span> 원</td>
            </tr>
            <tr> 
                <th scope="row">환불 대기금액</th> 
                <td><span class="point02"><c:if test="${empty user}">0 원</c:if><c:if test="${not empty user}"><fmt:formatNumber value="${depositParam.reqRefundAmount}" pattern="#,###"/></c:if></span> 원</td>
            </tr>
            <tr> 
                <th scope="row"><label for="requestAmount">환불 신청금액</label></th> 
                <td>
                    <c:if test="${not empty user}"><input type="text" value="0" name="requestAmount" id="requestAmount" style="width:130px;ime-mode:disabled;" class="input_txt inputNumberText cutofftextbox" /></c:if>
                    <c:if test="${empty user}">
                           <span class="point02"><fmt:formatNumber value="${depositParam.availableRefundAmount}" pattern="#,###"/></span>원
                           <input type="hidden" value="${depositParam.availableRefundAmount}" name="requestAmount"/>
                       </c:if>
                </td>
            </tr>
            <tr> 
                <th scope="row"><label for="accountHolderName">예금주</label></th>  
                <td><input type="text" name="accountHolderName" id="accountHolderName" value="${depositName}" style="width:130px;" class="input_txt"/></td> 
            </tr>  
            <tr> 
                <th scope="row">환불은행</th>
                <td><ui:select name="bankCode" clazz="select" key="P0063" style="width:140px;"><fmt:message key="label.select.default"/></ui:select></td> 
            </tr>  
            <tr>
                <th scope="row"><label for="paymentAccountNum">환불계좌번호</label></th>
                <td><input type="text" name="paymentAccountNum" id="paymentAccountNum" style="width:130px;ime-mode:disabled;" class="input_txt textbox inputNumberText"/></td>
            </tr>
        </table>
    </form>
    <div class="line"></div>
    <div class="error">
        <input type="text" readOnly id="error_console" >
    </div>
    <div class="btn_area t_center mgt30">
        <a href="#n" class="btn_type01" id="requestFrm" style="width:51px">신청하기</a>
        <a href="#n" class="btn_type01" id="cancelFrm" style="width:51px">취소</a>
        <a href="javascript:closeLayer()" class="btn_type01">닫기</a>
    </div>
</div>  
</body>
</html>