<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="none"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr"/>
<title>휴대폰 결제 인증 응답페이지</title>
<script type="text/javascript" src="/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="/js/jquery.form.js" charset="utf-8"></script>
<script language="JavaScript">
function onPayCall() {
    var replaceUrl = "http://m.hottracks.co.kr/m/order/orderComplete";
    // 결제 최종요청
    $("form#orderInfoForm").ajaxSubmit({
        url: "/m/order/payMobResponse"
        ,dataType: "json"
        ,success: function saveSuccess(data) {
            if (data.save) {
                location.replace(replaceUrl);
                window.close();
                return false;
            } else {
                var errorMessages = data.errorMessages;
                alert(errorMessages.join("\n"));
                location.href = "${defaultHost}/m/order/cart";
                window.close();
            }
        }
        ,error: function(xhr, status, error) {
            alert("<fmt:message key='error.common.system'/>");
            location.href = "${defaultHost}/m/order/cart";
            window.close();
        }
    });
}
</script>
</head>

<body onload="javascript:onPayCall();">
<form id="orderInfoForm" action="/m/order/payResponse" method="post">

    <input type="hidden" name="Mob_Phoneid" value="${param.USERKEY}"/>
    <input type="hidden" name="Mob_Tradeid" value="${param.Tradeid}"/>
    <input type="hidden" name="Mob_Prdtnm" value="${param.Prdtnm}"/>
    <input type="hidden" name="Mob_Prdtprice" value="${param.Prdtprice}"/>
    <input type="hidden" name="Mob_Mobilid" value="${param.Mobilid}"/>
    <input type="hidden" name="Mob_Userid" value="${param.Userid}"/>
    <input type="hidden" name="Mob_Userip" value="${param.Userip}"/>
    <input type="hidden" name="Mob_MSTR" value="${param.MSTR}"/>
    <input type="hidden" name="Mob_Email" value="${param.Email}"/>
</form>
</body>
</html>
