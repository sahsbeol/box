<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<html>
<head>
<title>영수증적립 | 서비스안내 | 고객센터 - HOTTRACKS</title>
<script type="text/javascript" src="/js/jquery.form.js" charset="utf-8"></script>
<style type="text/css">
table { width : 100%; border : 1px solid #ccc; }
table tbody {border-top : 3px solid black;}
table th.t_right{background-color: #eeeeee; text-align:left; padding : 10px; height : 40px; }
table td {padding : 0 10px;}
table td input{border:none;border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px;}
table td span.f_left {display: block;}
table td span.f_left input {display : inline-block; width: 100%;height: 30px;border: 1px solid #eeeeee;border-radius: 4px;}
a.btn_type01 { display: block; width: 100%; height: auto; margin-top: 10px; padding: 10px 0 10px 0; background-color: #ff6600; text-align: center; border-radius: 5px;}
a.btn_type01.hid_obj { display:none; }
a.btn_type01 span{ color : white; font-weight :bold;  font-size : 1.2em;}
a.btn_type02 { display: block; width: 100%; height: auto; margin-top: 10px; padding: 10px 0 10px 0; border:1px solid #ff6600; text-align: center; border-radius: 5px;}
a.btn_type02.hid_obj { display:none; }
a.btn_type02 span{ color : #ff6600; font-weight :bold;  font-size : 1.2em;}
div.bill_noti img{width : 100%; margin-bottom: 20px;}
div.bill_noti div{margin-bottom:5px;}
div .red{ color: red; vertical-align: middle; line-height: 2; position: relative; top: -28px; left: 31px; font-size: 1.3em; font-weight: bold;}
hr{ margin: 20px 0 10px; border: 1px solid black;}
</style>
<script type="text/javascript">
var isLogin = ${user.userNum};
jQuery(function($){
    $("#wrap").addClass("mypage01");
    $("#locReceipt").addClass("active");
    $("#locGift").addClass("active");
    $(".conts").hide();
    
    <c:if test="${not empty device}">
        $("#btnScan").show();
    </c:if>
    
    $("#savePoint input[type=number]").focus(function(){
        $(this).select();
    });
});
function offSavePoint(){
    if (!isLogin) {
        needLogin();
    } else {
        if ($("input[name=textfield1]").val() == "") {alert("영수증번호가 없습니다.");document.offPoint.textfield1.focus();return;}
        if ($("input[name=textfield2]").val() == "") {alert("금액이 없습니다.");document.offPoint.textfield2.focus();return;}
        
        $("#offPoint").ajaxSubmit({
            type : "POST"
            , url : "/m/offLine/savePointByOffBillAjx"
            , async : false
            , success : function(result){
                if(result.save == "OK"){
                    alert("적립되었습니다.");
                    location.reload();
                } else {
                    alert(result.errorMessages);
                }
            }
            ,error: function(xhr, status, error) {
                alert("<fmt:message key='error.common.system'/>");
            }
        });
    }
}

//숫자 체크하는 function
function InpuOnlyNumber() {
    if (event.keyCode >= 48 && event.keyCode <= 57) { //숫자키만 입력
    } else {
        event.returnValue = false;
    }
}

function scanCall(){
    var ua = window.navigator.userAgent.toLowerCase(); 
    if(/iPhone/i.test(ua) || /iPad/i.test(ua)){
        document.location = "myScheme://scanCall";
    }else{
        if(window.HybridApp != undefined){
            window.HybridApp.startScan();
        }else{
            alert("해당 프로그램은 스캔검색을 지원하지 않습니다.");
        }
    }
}

function scanCallBack(txt){
    $("#txtReciptNo").val(txt);
}
</script>
</head>
<body>
<!-- sub top -->
<!-- //sub top -->
<!-- sub contents -->
<div class="gray_box">
    <hr class="hr_01"/>
    <div id="my_content">
        <div class="my_smenu4">
            <a href="/m/mypage/totsaved" class="btn_totsaved"></a>
            <a href="/m/mypage/deposit" class="btn_deposit"></a>
            <a href="/m/mypage/coupon" class="btn_coupon" ></a>
            <a href="/m/offLine/listReceipt" class="btn_recepit active"></a>
        </div>
        <div class="my_smenu2">
            <a href="#" class="my_info" onclick="location.href='${defaultHost}/m/offLine/listReceipt';return false;"><span>영업점 영수증</span></a>
            <a href="#" class="my_info active" style="float:right;"  onclick="location.href='${defaultHost}/m/offLine/savePointByOffBill';return false;" ><span>영수증 후 적립</span></a>
        </div>
        <form id="offPoint" name="offPoint" style="margin:30px 0;">
            <table class="table" summary="영수증 적립" border="1">
                <caption>영수증 적립</caption>
                <colgroup>
                    <col width="*"></col>
                    <col width="*"></col>
                </colgroup>
                <tbody id="savePoint">
                    <tr>
                        <th scope="row" class="t_right">승인금액</th>
                        <td><span class="f_left"><input type="number" pattern="\d*" name="textfield2" placeholder="승인금액" id="txtReciptAmt" class="inputNumberText" id="tit" /></span></td>
                    </tr>
                    <tr>
                        <th scope="row" class="t_right">영수증 바코드 번호</th>
                        <td><span class="f_left"><input type="number" pattern="\d*" name="textfield1" class="inputNumberText" id="txtReciptNo" placeholder="영수증 바코드 번호" value="${bar }"/></span></td>
                    </tr>
                </tbody>
            </table>
        </form>
        <!-- <a href="#" onclick="scanCall();return false;" id="btnScan" class="btn_type02 hid_obj"><span>바코드검색</span></a> -->
        <a href="#" onclick="offSavePoint();return false;" class="btn_type01"><span>적립하기</span></a>
        <hr>
        <div class="bill_noti">
            <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/common/9_a_text1.jpg" />
            <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/common/9_a_text2.jpg" />
        </div>
    </div>
</div>
<!-- //sub contents -->
</body>
</html>