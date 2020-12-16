<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<html>
<head>
<title>비회원 로그인 - NEW ME HOTTRACKS</title>
<script type="text/javascript">
jQuery(function($) {
    $('a#agreementNoUserPopup').click(function() {
        window.open('/ht/order/termAgreeFormForNoUser','popupPrizewinner','width=650,height=590');
    });
    // <a href="html/order/popup02.html" onclick="window.open(this.href,'popupPrizewinner','width=650,height=590');return false;">/html/order/popup02.html</a>
});
</script>
</head>
<body>
<!-- sub top -->
<div class="page_location">
    <h2 class="title"><img src="${imageServer}/images/renewal/common/tit_my_hottracks.gif" alt="My Hottracks"/></h2>
    <div class="loc"><a href="/" class="home">Home</a><em>결제하기</em></div>
</div>
<!-- //sub top -->

<!-- login -->
<div class="login_wrap">
    <div class="f_left">
        <div class="inbox">
            <h3 class="tit"><img src="${imageServer}/images/renewal/common/logo_hottracks.gif" alt="Hottracks" /> 회원주문</h3>
            <div class="btn">
                <a href="<ui:variable key="kyobo.server"/><ui:variable key="kyobo.login.uri"/>${encodedReturnUrl}" class="btn_type07">인터넷교보문고 통합회원 로그인</a>
            </div>
        </div>
        <p class="txt">핫트랙스 온라인몰은 인터넷교보문고와 통합회원으로 운영됩니다.<br />로그인 버튼을 누르시면 인터넷교보문고로 이동합니다.<br />인터넷 교보문고 회원은 통합회원동의 완료만으로 서비스를 이용가능합니다.</p>
        <a href="javascript://" onclick="goAgreeMemInfo()" class="btn_type01">회원통합 동의</a>
    </div>
    <div class="f_right">
        <form id="nouserLoginForm" method="post" action="/ht/mypage/nouserLogin">
            <div class="inbox">
                <h3 class="tit">비회원 주문</h3>
                <p class="txt">비회원으로 구매하실 경우, 마일리지, 이벤트 등의 혜택을 받으실 수 없습니다.</p>
                <p><a href="javascript://" id="agreementNoUserPopup" class="btn_type07">비회원 주문</a></p>
                <p class="txt point02"><c:forEach items="${errorMessagesForNoUser}" var="errorMessage" varStatus="status">${errorMessage}<br/></c:forEach></p>
            </div>
            <p class="txt">교보문고/핫트랙스 통합 회원으로 가입하시면<br /> 편리함과 혜택이 늘어납니다!</p>
            <a href="javascript://" onclick="goMemJoin()" class="btn_type01">회원가입 하기</a>
        </form>
    </div>
</div>
<!-- //login -->
</body>
</html>