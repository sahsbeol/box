<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<html>
<head>
<style type="text/css">
#my_content .my_smenu2 { width: 100%; margin: 10px 0;height: 39px; background-color: white;}
#my_content .my_smenu2 .my_info.active {
background-color: #fe6000; display: inline-block; float: left; height: 18px; border-top-left-radius: 5px;
border-bottom-left-radius: 5px; height: 19px;}
.mt10 {margin-top: 10px !important;}
.mt30 {margin-top: 30px !important;}
.mb30 {margin-bottom: 30px !important;}
.btn.bg_orange {padding: 2px 10px;}
</style>
<script type="text/javascript" src="/js/jquery.form.js"></script>
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
    
    $("#btnEditOpen").click(function(e){
        e.preventDefault();
        $("#editButton").hide(0, function(){
            $("#editForm").slideDown("slow", function(){$("input[name=cpnId]").select();});
        });
    });
    
    $("#btnEditClose").click(function(e){
        e.preventDefault();
        $("#editForm").slideUp("slow", function(){
            $("#editButton").slideDown();
        });
    });
    
    $("#btnEditReg").click(function(e){
        e.preventDefault();
        
        var cpnId = $("input[name=cpnId]");
        cpnId.val($.trim(cpnId.val()));
        if($.trim(cpnId.val()) == ""){
            alert("쿠폰번호를 입력해주세요");
            cpnId.focus();
        }else{
            $.ajax({
                type: "GET"
                ,url: "/m/getCouponDown"
                ,data: 'couponId=' + cpnId.val()
                ,dataType: "json"
                ,success: function(data) {
                    if (data.save) {
                        alert("쿠폰이 다운로드 되었습니다.");
                        location.reload();
                    } else {
                        alert(data.errorMessage);
                    }
                }
                ,error: function() {
                    alert('<fmt:message key="error.common.system"/>');
                }
            });
        }
    });
});
function fnLoadOrder(){
    $.ajax({
         type: "POST"
        ,url: "/m/mypage/layerCouponList"
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

function couponReg() {
    if ($("input[name=couponNum]").val() == "") {alert("쿠폰번호가 없습니다.");return;}
    
    $.ajax({
        type : "POST"
        , url : "/m/order/eventCouponDown?couponNum=" + $("input[name=couponNum]").val()
        , async : false
        , success : function(result){
            if(result.save){
                alert("쿠폰이 지급 되었습니다.");
                location.reload(true);
            } else {
                var errorMessages = result.errorMessages;
                alert(errorMessages);
            }
        }
        ,error: function(xhr, status, error) {
            alert("<fmt:message key='error.common.system'/>");
        }
    });
}

</script>
</head>
<input type="hidden" name="eof" value="1"/>
<div class="gray_box">
    <hr class="hr_01"/>
    <div id="my_content">
        <div class="my_smenu4">
            <a href="/m/mypage/totsaved" class="btn_totsaved">통합포인트</a>
            <a href="/m/mypage/deposit" class="btn_deposit">예치금</a>
            <a href="/m/mypage/coupon"  class="btn_coupon active">쿠폰</a>
            <a href="/m/offLine/listReceipt" class="btn_recepit">영업점영수증</a>
        </div>
        
        <div class="my_smenu_ment"><strong>이벤트 쿠폰 등록</strong></div>
        <div style="text-align: center;">
            <input name="couponNum" id="couponNum" value="" type="text" class="i_input"/>
            <a href="javascript:couponReg()" class="btn btn_type01 bg_orange">등록</a>
        </div>
        
        
        <div class="my_smenu_ment">고객님의 보유 쿠폰은 <span class="col_orange"><fmt:formatNumber type="number" value="${totalCouponCnt}"/></span>장 입니다.</div>
        <div class="my_smenu2">
            <a href="/m/mypage/coupon" class="my_info active"><span>온라인 쿠폰(<span><fmt:formatNumber type="number" value="${totalCouponCnt}"/>)</span></span></a>
            <a href="/m/offLine/offLineCoupon"  class="my_info"><span>영업점 쿠폰(<fmt:formatNumber type="number" value="${totalOffCouponCnt}"/>)</span></a>
        </div>
        <div class="my_list" id="orderList"></div>
        
        <dl class="notice_txt mt30 mb30">
			<dt><h3>꼭 알아두기</h3></dt>
			<dd class="mt10">쿠폰별 혜택과 사용조건, 유효기간을 꼭 확인해주세요.</dd>
			<dd>취소/반품을 하시게 되면 적용된 쿠폰은 환원이 되지 않습니다.</dd>
			<dd>배송비 쿠폰을 사용해서 주문한 경우 반품 시 적용된 쿠폰은 소멸합니다.</dd>
			<dd>장바구니에 두 건 이상의 배송비가 발생했을 경우, 배송비 쿠폰은 한 건의 배송비만 무료로 적용됩니다.</dd>
		</dl>
        
    </div>
</div>
</body>
</html>