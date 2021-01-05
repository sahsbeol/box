<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="full"/>
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<script type="text/javascript">
isLogin = ${isLogin};
function fn_MoveFrm(memberYn) {
    var targetUrl = "/m/outdoor/orderFrm";
    if (memberYn == 'Y' && !isLogin) {
        targetUrl = '<ui:variable key="kyobo.server"/><ui:variable key="kyobo.login.uri"/>' + escape(targetUrl);
    }
    document.location.href = targetUrl;
}

function fn_Submit(){
    if($.trim($("[name=buyerTelNum]").val()) == ""){
        alert("배송지 전화번호를 입력해주세요");
        $("[name=buyerTelNum]").focus();
    }else if($.trim($("[name=buyerTelNum]").val()) == ""){
        alert("배송지 비밀번호를 입력해주세요");
        $("[name=buyerTelNum]").focus();
    }else{
        document.loginFrm.submit();
    }
}
</script>
</head>
<body>
<div id="outdoor">
    <div class="login_wrap roundbox mt10">
        <fieldset>
            <h3>배송지등록</h3>
            <a href="#" onclick="fn_MoveFrm('Y');return false;" class="btn btn_login01">통합회원 배송지등록</a>
            <p class="info">※ 핫트랙스 온라인몰은 인터넷교보문고와 통합회원으로 운영됩니다.</p>
            <a href="#" onclick="fn_MoveFrm('N');return false;" class="btn btn_login02 mt20">비회원 배송지등록</a>
        </fieldset>
    </div>
    <div class="login_wrap roundbox mt30">
        <form name="loginFrm" action="/m/outdoor/orderList" method="post">
            <input type="hidden" name="returnUrl" value="${returnUrl}"/>
            <fieldset>
                <h3>배송코드조회</h3>
                <ul>
                    <li class="input_wrap"><input type="tel" name="buyerTelNum" class="log_id" title="배송지 전화번호 입력" placeholder="배송지 전화번호" /></li>
                    <li class="input_wrap"><input type="number" pattern="[0-9]*" inputmode="numeric" name="passwd" class="log_pw i_passwd" maxlength="4" max="9999" maxlength="4" oninput="fn_CheckLength(this)" title="배송지 비밀번호 입력" placeholder="배송지 비밀번호" /></li>
                </ul>
                <a href="#" onclick="fn_Submit();return false;" class="btn_login01">조회하기</a>
                <p class="info">※ 등록하신 전화번호 또는 비밀번호를 모르시는 경우 핫트랙스 직원에게 문의해주세요.</p>
            </fieldset>
        </form>
    </div>
</div>
</body>
</html>