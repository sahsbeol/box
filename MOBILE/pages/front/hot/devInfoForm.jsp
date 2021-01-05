<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="layer"/>
<html>
<head>
<style type="text/css">
.layer_bg { position:fixed;left:0;top:0;width:100%;height:100%;background:url('/images/season01/bg_layer01.png');z-index:999; }
.layer_bg .layer_form { display: block;border-radius: 5px;background-color: #fff;margin: 7%;height: 93%;position: relative;overflow:hidden; }
.layer_bg .layer_form .layer_title { display: block;padding: 15px 3%;background-color: #ff6600;color: #fff;position: absolute;left: 0;top: 0;width: 94%;z-index: 998; }
.layer_bg .layer_form .layer_title h4 { display:block;font-size:1.5em;font-weight:900;text-align:center; }
.layer_bg .layer_form .layer_title h5 { display:block;font-size:1.2em;text-align:center; }
.layer_bg .layer_form .layer_conts { display:block;height:100%;overflow:auto; }
.layer_bg .layer_form .layer_conts .form_type { padding:10px; }
.layer_bg .layer_form .layer_conts .form_type dl { display:block;padding:10px 0;border-bottom:1px solid #dadada;color:#333; }
.layer_bg .layer_form .layer_conts .form_type dl dt { font-weight:bold;line-height:20px;font-size:1.2em;line-height:1.7em;margin-bottom:5px; }
.layer_bg .layer_form .layer_conts .form_type dl dd { padding:3px;font-size:1.2em;line-height:1.7em; }
.layer_bg .layer_form .layer_conts .form_type dl dd span { display:inline-block;width:49%;float:none; }
.layer_bg .layer_form .layer_conts .form_type dl dd span input[type=radio] { margin-right:5px; }
.layer_bg .layer_form .layer_conts .form_type dl dd span input[type=checkbox] { margin-right:5px; }
.layer_bg .layer_form .layer_conts .form_type .btn_area { clear:both; }
.layer_bg .layer_form .layer_conts .form_type .btn_area .btn_orange { padding:0 40px; }
.layer_bg .layer_form .btn_close { position:absolute;right:13px;top:13px;color:#fff;z-index:999;width: 28px;height: 28px;background: url('/images/season01/btn_close01.png') no-repeat 50% 50%;background-size: 25px 25px;text-indent: -999px; margin-top: 5px;border:1px solid #f1f2f3; text-align: left;}

</style>
<script type="text/javascript" src="/js/jquery.form.js"></script>
<script type="text/javascript">
jQuery(function($){
    $(".chk_wrap").click(function(){
        if($(this).hasClass("active")){
            $(this).removeClass("active");
        }else{
            $(this).addClass("active");
        }
        $(this).find("[type=checkbox]").attr("checked", $(this).hasClass("active"));
    });
    
    $(".btn_close").click(function(e){
        e.preventDefault();
        $(".layer_bg").remove();
    });
    
    $(".btn_submit").click(function(e){
        e.preventDefault();
        var form = $("[name=infoForm]");
        if(isEmpty(form.find("[name=userGender]:checked").val())){
            alert("성별을 선택해주세요.");
            form.find("[name=userGender]:first").focus();
            return false;
        }else if(isEmpty(form.find("[name=userAge]:checked").val())){
            alert("연령대를 선택해주세요.");
            form.find("[name=userAge]:first").focus();
            return false;
        }else if(isEmpty(form.find("[name=ctgrId]:checked").val())){
            alert("관심분야를 1개 이상 선택해주세요.");
            form.find("[name=ctgrId]:first").focus();
            return false;
        }else if(isEmpty(form.find("[name=agreeYn]:checked").val())){
            alert("정보 제공에 동의해주세요.");
            form.find("[name=agreeYn]").focus();
            return false;
        }
        form.ajaxSubmit({
            url: "/m/hot/devInfoSubmit"
            ,dataType: "json"
            ,success: function checkSuccess(data) {
                alert("저장되었습니다.");
                $(".layer_bg").remove();
            }
            ,error: function(xhr, status, error) {
                alert("<fmt:message key='error.common.system'/>");
            }
        });
    });
});
</script>
</head>
<body>
<div class="layer_bg">
<div class="layer_form">
    <div class="layer_title">
        <h4>당신의 취향 저격!</h4>
        <h5 class="mt5">고객님의 쇼핑을 더 편리하게!</h5>
    </div>
    <div class="layer_conts">
        <div class="form_type mt70">
            <form name="infoForm" action="/m/hot/devInfoSubmit" method="post">
                <dl>
                    <dt>1. 여성이신가요? 남성이신가요?</dt>
                    <dd>
                        <span><input type="radio" name="userGender" id="userGenderF" value="F"/><label for="userGenderF">여성</label></span>
                        <span><input type="radio" name="userGender" id="userGenderM" value="M"/><label for="userGenderM">남성</label></span>
                    </dd>
                </dl>
                <dl>
                    <dt>2. 나이대가 어떻게 되시나요?</dt>
                    <dd>
                        <span><input type="radio" name="userAge" id="userAge10" value="10"/><label for="userAge10">10대</label></span>
                        <span><input type="radio" name="userAge" id="userAge20" value="20"/><label for="userAge20">20대</label></span>
                        <span><input type="radio" name="userAge" id="userAge30" value="30"/><label for="userAge30">30대</label></span>
                        <span><input type="radio" name="userAge" id="userAge40" value="40"/><label for="userAge40">40대</label></span>
                        <span><input type="radio" name="userAge" id="userAge50" value="50"/><label for="userAge50">50대 이후</label></span>
                    </dd>
                </dl>
                <dl>
                    <dt>3. 관심 있으신 상품은?</dt>
                    <dd>
                        <c:forEach items="${listCateGift}" var="l">
                            <c:if test="${l.ctgrId ne '000008'}">
                                <span class="chk_wrap"><input type="checkbox" name="ctgrId" id="ctgrId${l.ctgrId}" value="${l.ctgrId}"/><label>${l.ctgrName}</label></span>
                            </c:if>
                        </c:forEach>
                        <span class="chk_wrap"><input type="checkbox" name="ctgrId" id="ctgrId0003" value="0003"/><label>CD</label></span>
                        <span class="chk_wrap"><input type="checkbox" name="ctgrId" id="ctgrId0004" value="0004"/><label>DVD</label></span>
                    </dd>
                </dl>
                <p class="mt10"><span class="chk_wrap"><input type="checkbox" name="agreeYn" id="agreeYn" value="Y"/><label>본 정보를 핫트랙스에 제공하는것을 동의합니다.</label></span></p>
                <div class="btn_area pt20">
                    <a href="#" class="btn btn_orange btn_submit">확인</a>
                </div>
            </form>
        </div>
    </div>
    <a href="#" class="btn_close">닫기</a>
</div>
</div>
</body>
</html>
