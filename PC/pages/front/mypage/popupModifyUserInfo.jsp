<%@page contentType="text/html;charset=utf-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<ui:decorator name="popup" />
<html>
<head>
<script type="text/javascript" src="/js/jquery.form.js" charset="utf-8"></script>
<script type="text/javascript">
jQuery(function($) {

    $("form#saveUserInfoForEvent").submit(function() {
        $("form#saveUserInfoForEvent").ajaxSubmit({
            url: "/ht/mypage/saveUserInfoForEvent"
            ,dataType: "json"
            ,success: saveSuccess
            ,error: function(xhr, status, error) {
                alert("<fmt:message key='error.common.system'/>");
            }
        });

        return false;
    });
});

function saveSuccess(data) {
    if (data.save) {
        alert('<fmt:message key="message.save.success"/>');
        opener.location.reload();
        window.close();
    } else {
        alert('<fmt:message key="message.save.fail"/>');
        var errorMessages = data.errorMessages;
        alert(errorMessages.join("\n"));
    }
}

function callbackZipcode(address, zipcode) {
    $("input[name='address']").val(address);
    $("input[name='postNum']").val(zipcode);
    $("input[name='postNum1']").val(zipcode.substring(0,3));
    $("input[name='postNum2']").val(zipcode.substring(4,7));
}
</script>
</head>
<body>
<div id="popup">
    <div class="pop-head" >
        <h1><img src="${imageServer}/images/popup/h1_logo.gif" alt="Hottracks" /></h1>
        <h2><img src="${imageServer}/images/popup/h2_basic_info.gif" alt="기본정보 수정" /></h2>
    </div><!-- end pop-head -->
    <div class="pop-body">
        <div class="popup-prizewinner">
        <form id="saveUserInfoForEvent" action="/ht/mypage/saveUserInfoForEvent" method="post">
            <p class="basics-text"><img src="${imageServer}/images/popup/basic_info_title_text.gif" alt="핫트랙스에서 제공하는 상품 정보 및
            사은품을 수령하기 위한 정보를 관리합니다." /></p>
            <p class="basics-info">※ 교보문고의 회원 정보는 수정되지 않습니다.</p>
            <div class="personal-information">
                <p class="username">
                    <label for="username"><img src="${imageServer}/images/popup/text_username.gif" alt="이름" /></label>
                    <input type="text" id="username" name="name" value="${loginUser.name}"/>
                </p>
                <p class="mobile">
                    <label for="mobile"><img src="${imageServer}/images/popup/text_mobile.gif" alt="휴대폰" /></label>
                    <input type="text" id="mobile" name="handphoneNum" value="${loginUser.handphoneNum}" maxlength="13">
                </p>
                <p class="email">
                    <label for="email"><img src="${imageServer}/images/popup/text_email.gif" alt="이메일" /></label>
                    <input type="text" id="email" name="emailAddress" value="${loginUser.emailAddress}"/>
                </p>
            </div><!-- end personal-information -->
            <div class="prizewinner-address">
                <p class="address-info">배송지 정보가 변경된 경우 배송지 정보를 수정하여 주십시오</p>
                <p class="zipcode">
                    <label for="zipcode"><img src="${imageServer}/images/popup/text_zipcode.gif" alt="우편번호" /></label>
                    <input type="text" id="zipcode" title="우편번호 첫번째 자리" name="postNum1" title="우편번호 첫번째 자리" readonly="readonly" value="<c:if test='${!empty loginUser.postNum}'>${fn:substring(loginUser.postNum,0,3)}</c:if>"/> <input type="text" name="postNum2" title="우편번호 두번째 자리" readonly="readonly" value="<c:if test='${!empty loginUser.postNum}'>${fn:substring(loginUser.postNum,4,7)}</c:if>"/>
                    <input type="hidden" name="postNum" value="${loginUser.postNum}"/>
                    <a href="/ht/listZipcode" onclick="window.open(this.href,'popupZipcode','width=400,height=372'); return false;" target="_blank" title="새창에서 열림"><img src="${imageServer}/images/popup/btn_zipcode_search.gif" alt="우편번호 검색" /></a>
                </p>
                <p class="address">
                    <label for="address"><img src="${imageServer}/images/popup/text_address.gif" alt="주소" /></label>
                    <input type="text" id="address" name="address" readonly="readonly" value="${loginUser.address}"/>
                </p>
                <p class="detail-address">
                    <label for="detail-address"><img src="${imageServer}/images/popup/text_detail_address.gif" alt="상세주소" /></label>
                    <input type="text" id="detail-address" name="detailAddress" value="${loginUser.detailAddress}"/>
                </p>
            </div><!-- end prizewinner-address -->
            <div class="button">
                <input type="image" src="${imageServer}/images/popup/btn_confirm.gif" alt="확인" />
                <button type="button" onclick="self.close()"><img src="${imageServer}/images/popup/btn_cancel.gif" alt="취소" /></button>
            </div><!-- end button -->
        </form>
        </div><!-- end popup-prizewinner -->
    </div><!-- end pop-body -->
    <div class="popup-foot">
        <button type="button" onclick="self.close()"><img src="${imageServer}/images/popup/btn_close.gif" alt="닫기" /></button>
    </div><!-- end close-popup -->
</div><!-- end popup -->
</body>
</html>