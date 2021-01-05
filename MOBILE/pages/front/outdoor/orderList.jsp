<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="full"/>
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<c:if test="${not empty errMsg}">
<script type="text/javascript">
alert("${errMsg}");
history.back();
</script>
</c:if>
<script type="text/javascript">
isLogin = ${isLogin};
orderNum = "${orderNum}";
jQuery(function($){
    $(document).ready(function(){
        if(orderNum != null && orderNum != ''){
            $("#barcode").barcode(orderNum, "code128");
            $("#lyOrder").show();
        }
        
        $("[name=buyerName]").focus();
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
    <div id="orderList" class="mt10">
        <c:if test="${empty list}">
            <p class="info t_c"><strong>내역이 존재하지 않습니다.</strong></p>
        </c:if>
        <c:forEach items="${list}" var="l" varStatus="st">
            <ul class="dlvy_list">
                <li class="info">
                    <a href="/m/outdoor/orderFrm?orderNum=${l.orderNum}">
                        <fmt:formatDate value="${l.regstDtm}" pattern="yyyy-MM-dd"/>
                        <em class="num">${l.orderNum}</em>
                    </a>
                </li>
                <li class="prod">
                    <p class="txt"><strong>${l.buyerName}</strong></p>
                    <p class="txt mt5">[${l.buyerPostNum}]<br/>${l.buyerAddr} ${l.buyerDtlAddr}</p>
                    <p class="txt mt5">${l.buyerTelNum}</p>
                    <p class="txt mt5">${l.buyerEmailAddr}</p>
                    <c:if test="${not empty l.receiptNo}"><p class="txt mt5 col_orange">접수완료되었습니다.</p></c:if>
                </li>
                <li class="btn_box">
                    <a href="/m/outdoor/orderFrm?orderNum=${l.orderNum}" class="btn_tacbae btn_srch">배송코드조회</a>
                </li>
            </ul>
        </c:forEach>
    </div>
    
    <div class="box_flex btn_area btn_area02 mt30">
        <a href="javascript:history.back()" class="btn btn_gray">되돌아가기</a>
    </div>
</div>
</body>
</html>