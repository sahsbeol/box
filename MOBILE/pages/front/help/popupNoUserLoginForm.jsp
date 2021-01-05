<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<head>
    <title>비회원로그인</title> 
</head>
<body>
<h1><img src="${imageServer}/images/renewal/common/h2_nomember_logoin.gif" alt="비회원로그인" /></h1>
<div class="pop_cont">
    <ul class="list_type02">
        <li>주문번호와 비밀번호를 입력하시고 로그인 해주세요</li>
    </ul>
    <form name="loginForm" method="post" action="/m/help/noUserLogin">
        <div class="login_wrap mgt10" style="height:auto;background:none;padding:0;">
            <div class="login pd14">
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
                    <button class="button" onclick="document.loginForm.submit;">로그인</button>
                </fieldset>
            </div>
            <p class="txt point02 pd5"><c:forEach items="${errorMessagesForNoUser}" var="errorMessage" varStatus="status">${errorMessage}<br/></c:forEach></p>
            <p class="txt pd5">교보문고/핫트랙스 통합 회원으로 가입하시면 편리함과 혜택이<br/> 늘어납니다!</p>
            <p class="pd5 t_right"><a href="javascript://" onclick="goMemJoin()" class="btn_type01">회원가입 하기</a></p>
        </div>
        <!-- //login -->
    </form> 
</div>
<div class="pop_close">
    <a href="javascript://" onclick="self.close(); return false;">닫기</a>
</div>
</body>
