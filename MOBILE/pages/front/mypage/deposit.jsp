<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<html>
<head>
<script type="text/javascript">
var page = 1;
jQuery(function($){
    $(document).ready(function(){
        $("#wrap").addClass("mypage01");
        $("#locGift").addClass("active");
        
        fnLoadOrder();
    });
    
    $(window).scroll(function(){
        if($("input[name=eof]").val() == "0")  // 남은 개수가 0인경우 더이상 호출 하지 않기 위한 용도
        {
           if(parseInt($(window).scrollTop() + $(window).height()) >= parseInt($("#footer").offset().top)){
               $("input[name=eof]").val("1");
               page++;
               fnLoadOrder();
           }
        }
     });
});
//예치금 환불 신청 팝업
function depositRequest(){
    var availableRefundAmount = "${depositParam.availableRefundAmount}" ;
    if(availableRefundAmount != "0"){
        $("#depositLayer").load("/m/mypage/popupDeposit");
        $("#depositLayer").show();
        //location.href="";
        //window.open("/m/mypage/popupDeposit", "popupPrizewinner", "width=610,height=390");
    }else{
        alert("환불 신청 가능한 금액이 없습니다.");
    }
}
function closeLayer(){
    $("#depositLayer").empty;
    $("#depositLayer").hide();
}
function fnLoadOrder(){
    $.ajax({
         type: "POST"
        ,url: "/m/mypage/layerDepositList"
        ,data: {page : page, srchMaxDate:"${c.srchMaxDate}", srchGbn:"${c.srchGbn}"}
        ,dataType: "html"
        ,success : function(htmlStr){
            $("#orderList").append(htmlStr);
            $("input[name=eof]").val("0");
        }
        ,error: function(data) {
            alert('<fmt:message key="error.common.system"/>');
        }
    });
}
function clickLink(){
    
}
</script>
</head>
<input type="hidden" name="eof" value="1"/>
<div class="gray_box">
    <hr class="hr_01"/>
    <div id="my_content">
        <div class="my_smenu4">
            <a href="/m/mypage/totsaved" class="btn_totsaved">통합포인트</a>
            <a href="/m/mypage/deposit" class="btn_deposit active">예치금</a>
            <a href="/m/mypage/coupon"  class="btn_coupon">쿠폰</a>
            <a href="/m/offLine/listReceipt" class="btn_recepit">영업점영수증</a>
        </div>
        <p class="info t_c">고객님의 온라인 예치금은 <span class="col_orange"><strong><fmt:formatNumber type="number" value="${totalDepositAmt}"/></strong></span> 원 입니다.</p>
        
        <div class="box_flex tog_area mt20">
            <a href="#" onclick="location.replace('/m/mypage/deposit?srchGbn=0');return false;" class="btn tog_btn <c:if test="${c.srchGbn eq '0'}"> active </c:if>" >예치금내역</a>
            <a href="#" onclick="location.replace('/m/mypage/deposit?srchGbn=1');return false;" class="btn tog_btn <c:if test="${c.srchGbn eq '1'}"> active </c:if>" >환불신청내역</a>
        </div>
        <div id="orderList" class="mt30"></div>
        <!-- <a href="javascript:history.back();" class="btn_cls">닫기</a> -->
        
        <div id="depositLayer"></div>
        
        <!-- //content -->
        <div class="box_flex mt20"> 
            <a href="javascript://" onclick="depositRequest()" class="btn bg_orange"> 예치금 환불 신청</a>
        </div>
    </div>
</div>
</body>
</html>
