<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="none"/>
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0">
<meta name="format-detection" content="telephone=no, address=no, email=no" /> 
<link rel="stylesheet" type="text/css" href="/css/layout.css">
<link rel="stylesheet" type="text/css" href="/css/content.css">
<link rel="stylesheet" type="text/css" href="/css/common.css">
<script type="text/javascript" src="/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="/js/idangerous.swiper.min.js"></script>
<script type="text/javascript" src="/js/common.js"></script>
<script type="text/javascript" src="/js/kakao.min.js"></script>
<script type="text/javascript" src="/scripts/common"></script>
<script type="text/javascript" src="/scripts/loadingBar"></script>
<script type="text/javascript">
jQuery(function($){
    $(".chk_wrap label").click(function(){
        var parent = $(this).parent();
        var chk = $("#"+$(this).attr("for"));
        if(parent.hasClass("active")){
            chk.removeAttr("checked");
            parent.removeClass("active");
        }else{
            chk.attr("checked", true);
            parent.addClass("active");
        }
    });
})
function submitFrm(){
    document.loginFrm.submit();
}
</script>
</head>
<body id="layer">
<!-- tit_section -->
<div id="ly_header">
    <h1>Login</h1>
</div>
<!-- //tit_section -->

<!-- content -->
<div id="ly_content">
    <form name="loginFrm" action="/m/login" method="post">
    <input type="hidden" name="returnUrl" value="${returnUrl}"/>
    <fieldset>
        <div class="roundbox login_wrap">
            <ul>
                <li class="input_wrap"><input type="text" name="userId" class="log_id" title="아이디 입력" placeholder="아이디" /></li>
                <li class="input_wrap"><input type="password" name="userPwd" class="log_pw" title="비밀번호 입력" placeholder="비밀번호" /></li>
            </ul>
            <span class="chk_wrap">
                <input type="checkbox" id="saveId" /><label for="saveId">아이디 저장</label>
            </span>
            <span class="chk_wrap">
                <input type="checkbox" id="savePwd" /><label for="savePwd">비밀번호 저장</label>
            </span>
            <a href="javascript://" onclick="submitFrm()" class="btn_login">로그인</a>
        </div>
    </fieldset>
    </form>
    <div class="btn_area box_flex mt20">
        <a href="http://m.kyobobook.com/member/findId?orderClick=mZ4" class="btn br_484848">아이디찾기</a>
        <a href="http://m.kyobobook.com/member/findPw?orderClick=mZ5" class="btn br_484848">비밀번호찾기</a>
        <a href="http://m.kyobobook.com/member/term?orderClick=mZ6" class="btn br_484848">회원가입</a>
    </div>
    <p class="info">* 비회원 주문 및 주문취소/변경은 모바일에서는 지원 하지 않습니다. 해당 서비스가 필요하신 고객님은 PC버전을 이용해 주시기 바랍니다. 불편을 드려서 죄송합니다.</p>

    <a href="javascript:history.back();" class="btn_cls">닫기</a>
</div>
<!-- //content -->
</body>
</html>