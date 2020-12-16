<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<ui:decorator name="popup"/>
<html>
<head>
<script type="text/javascript" src="/js/jquery.form.js"></script>
<script type="text/javascript">
var availAmount = ${depositParam.availableRefundAmount};
function cutoff(price) {
    return Math.round(price / 10) * 10;
}

jQuery(function($) {
    $(document).ready(function() {
        if (availAmount == 0) {
            alert("신청가능한 예치금이 없습니다.");
            window.close();
        }
    });
    
    $("#requestFrm").click(function (event) {
        event.preventDefault();
        $('form[name="form"]').ajaxSubmit({
            type: "POST"
            ,url:"/ht/mypage/saveDepositRefund"
            ,dataType: 'json'
            ,success: function(data) {
                if (data.save) {
                    alert("예치금 환불신청이 접수되었습니다."); 
                    opener.location.reload(true);
                    window.close();
                } else {
                    alert("예치금 환불신청에 실패하였습니다. - " + data.errorMessages);
                }
            }
            ,error: function() {
                alert('<fmt:message key="error.common.system"/>');
            }
        });
    });
    
    $("#cancelFrm").click(function (event) { 
        event.preventDefault();
        self.close();
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
<h1><img src="${imageServer}/images/renewal/common/tit_pop_deposit.gif" alt="예치금환불신청" /></h1>
<div class="pop_cont">
    <ul class="list_type02">
        <c:if test="${not empty user }">
            <li>환불계좌 예금주는 회원본인만 가능합니다.</li>
            <li>환불요청 예치금은 신청한 다음날 해당 계좌로 입금됩니다.</li>
        </c:if>
        <c:if test="${empty user }">
            <li>환불요청 예치금은 신청한 다음날 해당 계좌로 입금됩니다.</li>
        </c:if>
    </ul>
    <form id="form" name="form"> 
        <table class="table02 mgt15">
            <caption>예치금환불신청 <span>환불가능 금액, 예금주, 환불대기 금액, 환불은행, 환불신청 금액, 환불계좌번호</span></caption>
            <colgroup>
                <col style="width:95px" />
                <col style="width:180px" />
                <col style="width:95px" />
                <col style="width:*" />
            </colgroup>
            <tr> 
                <th scope="row">환불가능 금액</th> 
                <td><span class="point02"><fmt:formatNumber value="${depositParam.availableRefundAmount}" pattern="#,###"/></span> 원</td> 
                <th scope="row"><label for="accountHolderName">예금주</label></th>
                <td><input type="text" name="accountHolderName" id="accountHolderName" value="${depositName}" style="width:130px;" class="input_txt" readonly/></td> 
            </tr>  
            <tr> 
                <th scope="row">환불대기 금액</th> 
                <td><c:if test="${empty user}">0 원</c:if><c:if test="${not empty user}"><fmt:formatNumber value="${depositParam.reqRefundAmount}" pattern="#,###"/></c:if></td> 
                <th scope="row">환불은행</th>
                <td><ui:select name="bankCode" clazz="select" key="P0063" style="width:140px;"><fmt:message key="label.select.default"/></ui:select></td> 
            </tr>  
            <tr> 
                <th scope="row"><label for="requestAmount">환불신청 금액</label></th> 
                <td>
                    <c:if test="${not empty user}"><input type="text" value="0" name="requestAmount" id="requestAmount" style="width:130px;ime-mode:disabled;" class="input_txt inputNumberText cutofftextbox" /></c:if>
                    <c:if test="${empty user}">
                           <span class="point02"><fmt:formatNumber value="${depositParam.availableRefundAmount}" pattern="#,###"/></span>원
                           <input type="hidden" value="${depositParam.availableRefundAmount}" name="requestAmount"/>
                       </c:if>
                </td> 
                <th scope="row"><label for="paymentAccountNum">환불계좌번호</label></th>
                <td><input type="text" name="paymentAccountNum" id="paymentAccountNum" style="width:130px;ime-mode:disabled;" class="input_txt textbox inputNumberText"/></td>
            </tr>
        </table>
    </form>
    <div class="btn_area t_center mgt30">
        <a href="#n" class="btn_type01" id="requestFrm" style="width:51px">신청하기</a>
        <a href="#n" class="btn_type05" id="cancelFrm" style="width:51px">취소</a>
    </div>
</div>  
<div class="pop_close">
    <a href="javascript://" onclick="self.close(); return false;">닫기</a>
</div>
</body>
</html>