<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="full"/>
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<script type="text/javascript" src="/js/jquery-barcode.min.js"></script>
<script type="text/javascript" src="/js/jquery.form.js"></script>
<script type="text/javascript">
isLogin = ${isLogin};
orderNum = "${orderNum}";
jQuery(function($){
    $(document).ready(function(){
        if($.trim(orderNum) != ''){
            $("#barcode").barcode(orderNum, "code128", {barWidth:2});
            $("input,select").attr("readonly", "readonly");
            $("#lyOrder").show();
        }else{
            $("[name=buyerName]").focus();
        }
    });
    
    $("[name=buyerEmailSvr]").change(function(){
        if($(this).val() == ""){
            $("[name=buyerEmailAddr2]").attr("disabled", false).focus();
        }else{
            $("[name=buyerEmailAddr2]").attr("disabled", true).val($(this).val());
        }
    });
});

function fn_MoveFrm(memberYn) {
    var targetUrl = "/m/outdoor/editFrm";
    if (memberYn == 'Y' && !isLogin) {
        var kyoboLoginUrl = '<ui:variable key="kyobo.server"/><ui:variable key="kyobo.login.uri"/>' + escape(targetUrl);
    }
    document.location.href = kyoboLoginUrl;
}

function showRecentAddr(){
    $("#zipcode").load("/m/order/recentAddr");
    $("#zipcode").show();
}

function showZipcode(){
    $("#zipcode").load("/m/zipcode?ssl=Y");
    $("#zipcode").show();
}

<%-- 우편번호 찾기 콜백 함수 --%>
function callbackZipcode(zipcode, address) {
    $("input[name=buyerPostNum]").val(zipcode);
    $("input[name=buyerAddr]").val(address);
    $("input[name=buyerDtlAddr]").val("").focus();
    closeZipcode();
}

<%-- 도로명 주소 콜백 함수 --%>
function callbackRoadCode(zipcode, address1, address2, address3, address4 ) {
    $("input[name=buyerPostNum]").val(zipcode);
    $("input[name=buyerAddr]").val(address1);
    $("input[name=buyerDtlAddr]").val("").focus();
    document.getElementById("buyerDtlAddrView3").innerHTML = address2;
    document.getElementById("buyerDtlAddrView4").innerHTML = address3;
    closeZipcode();
}

<%-- 최근 주소 콜백 함수 --%>
function select_address(zip1, rcvrAddr, rcvrDtlAddr, rcvrTelNum, rcvrHdphnNum, name){
    //alert(rcvrTelNum);
     $("input[name=buyerName]").val(name);
     $("input[name=buyerPostNum]").val(zip1);
     $("input[name=buyerAddr]").val(rcvrAddr);
     $("input[name=buyerDtlAddr]").val(rcvrDtlAddr);
     $("input[name=buyerTelNum1]").val(rcvrHdphnNum.split("-")[0]);
     $("input[name=buyerTelNum2]").val(rcvrHdphnNum.split("-")[1]);
     $("input[name=buyerTelNum3]").val(rcvrHdphnNum.split("-")[2]);
     
     closeZipcode();
}

function closeZipcode(){
    $("#zipcode").empty;
    $("#zipcode").hide();
}

function submitFrm(){
    var buyerName = $("[name=buyerName]").val();
    var buyerPostNum = $("[name=buyerPostNum]").val();
    var buyerAddr = $("[name=buyerAddr]").val();
    var buyerDtlAddr = $("[name=buyerDtlAddr]").val();
    var buyerTelNum1 = $("[name=buyerTelNum1]").val();
    var buyerTelNum2 = $("[name=buyerTelNum2]").val();
    var buyerTelNum3 = $("[name=buyerTelNum3]").val();
    var buyerEmailAddr1 = $("[name=buyerEmailAddr1]").val();
    var buyerEmailAddr2 = $("[name=buyerEmailAddr2]").val();
    var passwd = $("[name=passwd]").val();
    
    if($.trim(buyerName) == ""){
        alert("수령인명을 입력해주세요.");
        $("[name=buyerName]").focus();
    }else if($.trim(buyerPostNum) == ""){
        alert("수령인 주소를 입력해주세요.");
        $("[name=buyerAddr]").focus();
    }else if($.trim(buyerAddr) == ""){
        alert("수령인 주소를 입력해주세요.");
        $("[name=buyerAddr]").focus();
    }else if($.trim(buyerDtlAddr) == ""){
        alert("수령인 주소를 입력해주세요.");
        $("[name=buyerDtlAddr]").focus();
    }else if($.trim(buyerTelNum1) == ""){
        alert("전화번호를 입력해주세요.");
        $("[name=buyerTelNum1]").focus();
    }else if($.trim(buyerTelNum2) == ""){
        alert("전화번호를 입력해주세요.");
        $("[name=buyerTelNum2]").focus();
    }else if($.trim(buyerTelNum3) == ""){
        alert("전화번호를 입력해주세요.");
        $("[name=buyerTelNum3]").focus();
    }else if($.trim(passwd) == ""){
        alert("비밀번호를 입력해주세요.");
        $("[name=passwd]").focus();
    }else if(passwd.length != 4){
        alert("비밀번호는 4자리여야 합니다.");
        $("[name=passwd]").focus();
    }else{
        var buyerTelNum = buyerTelNum1+"-"+buyerTelNum2+"-"+buyerTelNum3
        var buyerEmailAddr = "";
        if($.trim(buyerEmailAddr1) == "" + $.trim(buyerEmailAddr2) == ""){
            buyerEmailAddr = buyerEmailAddr1+"@"+buyerEmailAddr2
        }
        
        $.ajax({
            type: "POST"
          , url: "/m/outdoor/orderSubmit"
          , data:{
                  buyerName:buyerName
                , buyerPostNum:buyerPostNum
                , buyerAddr:buyerAddr
                , buyerDtlAddr:buyerDtlAddr
                , buyerTelNum:buyerTelNum
                , buyerEmailAddr:buyerEmailAddr
                , passwd:passwd
                }
          , dataType: 'json'
          , success: function(result){
                alert("정상적으로 등록되었습니다.");
                location.replace("/m/outdoor/orderFrm?orderNum="+result.orderNum);
            }
          , error: function(result){
                console.log(result);
                alert('<fmt:message key="error.common.system"/>');
            }
        });
    }
}

</script>
</head>
<body>
<div id="outdoor">
    <form name="orderFrm" action="/m/outdoor/orderSubmit" method="post">
        <div class="roundbox mt20">
            <h3>배송정보 등록</h3>
            <div id="zipcode" style="position:relative;width:100%;background-color:#fff;display:none;border:1px solid #2a2a2a;border-radius:5px;margin:10px 0;"></div>
            <p id="lyOrder" class="t_c" style="display:none;">
                <span id="barcode"></span>
            </p>
            <c:if test="${not empty order}">
                <p class="p_info">※ 해당 페이지를 핫트랙스 직원에게 보여주세요.</p>
            </c:if>
            <ul class="order_form">
                <li>
                    <strong class="edit_txt">수령인명(*)</strong>
                    <span class="edit_frm"><input type="text" name="buyerName" maxlength="30" class="i_input i_full" title="수령인명" value="${order.buyerName}"/></span>
                </li>
                <li>
                    <strong class="edit_txt">수령주소(*)</strong>
                    <span class="edit_frm t_l">
                        <input type="text" name="buyerPostNum" class="i_input" title="수령인 우편번호" size="7" maxlength="6" readonly="readonly" value="${order.buyerPostNum}"/>
                        <c:if test="${empty order}">
                            <a href="#" onclick="showZipcode();return false;" class="btn btn_search">우편번호 검색</a>
                            <c:if test="${not empty loginUser}"><a href="#" onclick="showRecentAddr();return false;" class="btn btn_recent">최근배송지</a></c:if>
                        </c:if>
                        <input type="text" name="buyerAddr" class="i_input i_full mt5" title="수령인 기본주소" readonly="readonly" value="${order.buyerAddr}"/>
                        <input type="text" name="buyerDtlAddr" class="i_input i_full mt5" title="수령인 상세주소" value="${order.buyerDtlAddr}"/>
                        <span id="buyerDtlAddrView3" name="buyerDtlAddrView3"></span>
                        <span id="buyerDtlAddrView4" name="buyerDtlAddrView4"></span>
                        <input name="buyerDtlAddr3" maxlength="50" type="hidden" class="i_input" title="수령인 상세주소" style="width:180px;" />
                        <input name="buyerDtlAddr4" maxlength="50" type="hidden" class="i_input" title="수령인 상세주소" style="width:180px;" />
                    </span>
                </li>
                <li>
                    <strong class="edit_txt">전화번호(*)</strong>
                    <span class="edit_frm tel_box">
                        <input type="tel" name="buyerTelNum1" class="i_input inputNumberText" size="3" maxlength="3" title="수령인 전화번호 지역번호 입력" value="${fn:split(order.buyerTelNum, '-')[0]}"/>
                        <em>-</em>
                        <input type="tel" name="buyerTelNum2" class="i_input inputNumberText" size="4" maxlength="4" title="수령인 전화번호 중간자리 입력" value="${fn:split(order.buyerTelNum, '-')[1]}"/>
                        <em>-</em>
                        <input type="tel" name="buyerTelNum3" class="i_input inputNumberText" size="4" maxlength="4" title="수령인 전화번호 뒷자리 입력" value="${fn:split(order.buyerTelNum, '-')[2]}"/>
                    </span>
                </li>
                <li>
                    <strong class="edit_txt">이메일주소</strong>
                    <span class="edit_frm">
                        <input type="email" name="buyerEmailAddr1" class="i_input i_middle" title="이메일주소" value="${fn:split(order.buyerEmailAddr, '@')[0]}"/>
                        <em>@</em>
                        <input type="email" name="buyerEmailAddr2" class="i_input i_middle" title="이메일서버" value="${fn:split(order.buyerEmailAddr, '@')[1]}"/>
                        <select name="buyerEmailSvr" class="select i_middle" title="수령인 이메일주소" style="text-overflow: ellipsis;overflow: hidden;white-space: nowrap;">
                            <option value="">직접입력</option>
                            <option value="naver.com">naver.com</option>
                            <option value="hanmail.net">hanmail.net</option>
                            <option value="nate.com">nate.com</option>
                            <option value="gmail.com">gmail.com</option>
                            <option value="hotmail.com">hotmail.com</option>
                            <option value="daum.net">daum.net</option>
                            <option value="yahoo.co.kr">yahoo.co.kr</option>
                            <option value="empal.com">empal.com</option>
                            <option value="paran.com">paran.com</option>
                            <option value="empas.com">empas.com</option>
                        </select>
                    </span>
                </li>
                <c:if test="${empty order}">
                    <li>
                        <strong class="edit_txt">비밀번호(*)</strong>
                        <span class="edit_frm">
                            <input type="number" pattern="[0-9]*" inputmode="numeric" name="passwd" max="9999" maxlength="4" oninput="fn_CheckLength(this)" class="i_input i_middle i_passwd" title="비밀번호"/>
                            <em>(숫자 4자리)</em>
                        </span>
                    </li>
                </c:if>
            </ul>
            <c:if test="${not empty order && not empty order.receiptNo}">
                <p class="col_orange">이 주문건은 접수되었습니다.</p>
            </c:if>
        </div>
        <c:choose>
            <c:when test="${not empty order}">
                <div class="box_flex btn_area btn_area02 mt30">
                    <a href="javascript:history.back()" class="btn btn_gray">되돌아가기</a>
                    <a href="/" class="btn bg_orange">쇼핑하러가기</a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="box_flex btn_area btn_area02 mt30">
                    <a href="javascript:history.back();" class="btn btn_gray">취소</a>
                    <a href="#" onclick="submitFrm();return false;" class="btn btn_gray bg_orange">등록</a>
                </div>
            </c:otherwise>
        </c:choose>
    </form>
</div>
</body>
</html>