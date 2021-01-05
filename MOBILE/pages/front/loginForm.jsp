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
<style type="text/css">
html, body { width: 100%; height: 100%; }
body { overflow: auto;word-break: break-all;word-wrap: break-word;font-size: 12px;font-family: 'Nanum Gothic', 'Apple Gothic', 'Droid Sans','돋움','Dotum',sans-serif;/* -webkit-user-select: none; */-webkit-text-size-adjust: none; }
body, div, dl, dt, dd, ul, ol, li, h1, h2, h3, h4, h5, h6, pre, code, form, fieldset, legend, textarea, p, blockquote, th, td, input, select, textarea, button { margin: 0;padding: 0; }
a { display: inline-block;color: #333;text-decoration: none;vertical-align: middle; }
fieldset, img { border: 0 none; }
dl, ul, ol, menu, li { list-style: none; }
span { display: inline-block; }
input, select, textarea, button { font-size: 100%;vertical-align: middle; }
th, td, input, select, textarea, button { font-size: 14px; font-family: 'Nanum Gothic', 'Apple Gothic', 'Droid Sans','돋움','Dotum',sans-serif; color: #222; }
input[type='radio'], input[type='checkbox'] { border: none; }

.mt20 { margin-top: 20px !important; }
.roundbox { position: relative;overflow: hidden;padding: 17px 10px 20px;border-radius: 5px;background: #fff;box-shadow: 0 2px 3px #c1c1c1; }

.box_flex { display: -webkit-box; }
.box_flex * { -webkit-box-flex: 1; display: block; }

.chk_wrap { position: relative; float: left; }
.chk_wrap + .chk_wrap  { margin-left:10px; }
.chk_wrap input { position: absolute;left: -999px;width: 18px;height: 18px; }
.chk_wrap label { display: inline-block;height: 18px;padding-left: 23px;background: url(http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/mobile/common/bg_checkbox.gif) no-repeat 0 0;background-size: 18px 36px;font-size: 11px;line-height: 18px; }
.chk_wrap.active label {background:url(http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/mobile/common/bg_checkbox.gif) no-repeat 0 -18px;background-size:18px 36px;}

.btn { display: inline-block;height: 39px;border-radius: 3px;text-align: center;font-size: 14px;font-weight: bold;color: #fff;line-height: 39px; }
.btn.br_484848 { height: 31px;padding: 0 8px;border: 1px solid #484848;background: #fff;font-size: 12px;color: #2b2b2b;line-height: 31px;text-align: center; }

#layer { background: #f5f6f1; color: #919191; }
#layer .info { margin-top: 15px;color: #919191;line-height: 1.5; }
#layer .naver { display:block;margin-top: 15px;color: #919191;height: 37px;line-height: 37px; }
#layer .naver a { float:right;display: inline-block;text-align:center;height: 37px;line-height: 37px; }
#layer .naver a img { height:37px; }
#ly_header { height: 40px;border-bottom: 3px solid #ff7800;background: #2b2b2b;text-align: center;font-size: 20px;color: #fff; }
#ly_header h1 { font-size: 16px; color: #fff;line-height: 40px; }
#ly_content { padding: 14px 10px 15px; }
#ly_content .btn_area { padding: 0 10px; }
#ly_content .login_wrap { margin-bottom:20px; }
#ly_content .login_wrap li { margin-bottom:10px; }
#ly_content .login_wrap .log_id,
#ly_content .login_wrap .log_pw { width: 100%; height: 37px;line-height: 37px;text-indent:13px;border: 1px solid #d3d3d3;border-radius: 3px;font-size: 12px; }
#ly_content .login_wrap .optn_box { text-align:right;margin-top: 40px; }
#ly_content .login_wrap .optn_box a { color:#919191; }
#ly_content .login_wrap .line01 { clear:both;border:none; }
#ly_content .btn_login { display: block;clear:both;text-align:center;height: 37px;line-height: 37px;padding: 0 23px;border: 1px solid #f05f07;border-radius: 3px;background: #ff6600;font-size: 14px;color: #fff; }
#ly_content .btn_cls { position: absolute;top: 0;right: 0;width: 40px;height: 40px;overflow: hidden;background: url(/images/common/btn_layer_cls.gif) no-repeat;background-size: 100% auto;line-height: 999px; }
</style> 
<script type="text/javascript" src="http://m.hottracks.co.kr/js/jquery-1.9.1.min.js"></script>
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
});
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
            <div class="login_wrap">
                <ul>
                    <li class="input_wrap"><input type="text" name="userId" class="log_id" title="아이디 입력" placeholder="아이디" /></li>
                    <li class="input_wrap"><input type="password" name="userPwd" class="log_pw" title="비밀번호 입력" placeholder="비밀번호" /></li>
                </ul>
                <span class="chk_wrap"><input type="checkbox" id="saveId" /><label for="saveId">아이디 저장</label></span>
                <span class="chk_wrap"><input type="checkbox" id="savePwd" /><label for="savePwd">비밀번호 저장</label></span>
                <div class="optn_box">
                    <a href="http://m.kyobobook.com/member/findId?orderClick=mZ4">아이디찾기</a>
                    <span>|</span>
                    <a href="http://m.kyobobook.com/member/findPw?orderClick=mZ5">비밀번호찾기</a>
                    <span>|</span>
                    <a href="http://m.kyobobook.com/member/term?orderClick=mZ6">회원가입</a>
                </div>
                <hr class="line01"/>
            </div>
            <a href="javascript://" onclick="submitFrm()" class="btn_login">로그인</a>
        </fieldset>
    </form>
    <p class="naver">네이버 아이디로 로그인 하시겠습니까?<a href="#"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/mobile/common/btn_login_naver.png"/></a></p>
    <p class="info">* 비회원 주문 및 주문취소/변경은 모바일에서는 지원 하지 않습니다. 해당 서비스가 필요하신 고객님은 PC버전을 이용해 주시기 바랍니다. 불편을 드려서 죄송합니다.</p>
    <a href="javascript:history.back();" class="btn_cls">닫기</a>
</div>
<!-- //content -->
</body>
</html>