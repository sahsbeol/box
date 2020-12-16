<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<ui:decorator name="orderSheet"/>
<html>
<head>
<title>비회원 로그인 - NEW ME HOTTRACKS</title>
</head>
<body>
<!-- sub top -->
<div class="page_location">
    <h2 class="title"><img src="${imageServer}/images/renewal/common/tit_my_hottracks.gif" alt="My Hottracks"/></h2>
    <div class="loc"><a href="/" class="home">Home</a><em>MY HOTTRACKS</em></div>
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
                <h3 class="tit">비회원 로그인</h3>
                <p class="txt">주문번호와 비밀번호를 입력하시고 로그인 해주세요</p>
                <div class="login">
                    <fieldset>
                        <legend>로그인</legend>
                        <ul>
                            <li>
                                <label for="ordernum" class="stit">주문번호</label>
                                <input type="text" name="orderNum" class="input_txt inputNumberText" id="ordernum" maxlength="12"/>
                            </li>
                            <li>
                                <label for="password" class="stit">비밀번호</label>
                                <input type="password" name="password" class="input_txt" id="password">
                            </li>
                        </ul>
                        <button class="button" onclick="document.nouserLoginForm.submit;">로그인</button>
                    </fieldset>
                </div>
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