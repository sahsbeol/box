<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<html>
<head>
<style type="text/css">
select.select{ width : 80px;}

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
});
function fnLoadOrder(){
    $.ajax({
         type: "POST"
        ,url: "/m/mypage/layerTotsavedList"
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
</script>
</head>
<input type="hidden" name="eof" value="1"/>
<div class="gray_box">
    <hr class="hr_01"/>
    <div id="my_content">
        <div class="my_smenu4">
            <a href="/m/mypage/totsaved" class="btn_totsaved active">통합포인트</a>
            <a href="/m/mypage/deposit" class="btn_deposit">예치금</a>
            <a href="/m/mypage/coupon"  class="btn_coupon">쿠폰</a>
            <a href="/m/offLine/listReceipt" class="btn_recepit">영업점영수증</a>
        </div>
        <p class="info t_c">
          <span style="font-size : 1.5em;">고객님의 통합포인트는 <span class="col_orange"><strong><fmt:formatNumber type="number" value="${totalPointAmt}"/></strong></span> 원 입니다.</span>
        <br/>(구)마일리지를 소지하신 고객님께서는 교보문고에서 확인가능합니다.
        </p>
        <div class="box_flex tog_area mt20">
            <a href="javascript:location.replace('/m/mypage/totsaved?srchMaxDate=3&srchGbn=${c.srchGbn}')" class="btn tog_btn<c:if test="${c.srchMaxDate eq '3'}"> active</c:if>">3개월</a>
            <a href="javascript:location.replace('/m/mypage/totsaved?srchMaxDate=6&srchGbn=${c.srchGbn}')" class="btn tog_btn<c:if test="${c.srchMaxDate eq '6'}"> active</c:if>">6개월</a>
            <a href="javascript:location.replace('/m/mypage/totsaved?srchMaxDate=12&srchGbn=${c.srchGbn}')" class="btn tog_btn<c:if test="${c.srchMaxDate eq '12'}"> active</c:if>">12개월</a>
            <select name="srchGbn" class="select" title="포인트 검색옵션 선택" style="width:30%;" onchange="location.replace('/m/mypage/totsaved?srchMaxDate=${c.srchMaxDate}&srchGbn='+this.value)">
                <option value="1" <c:if test="${c.srchGbn eq '1'}">selected="selected"</c:if>>전체</option>
                <option value="2" <c:if test="${c.srchGbn eq '2'}">selected="selected"</c:if>>적립</option>
                <option value="3" <c:if test="${c.srchGbn eq '3'}">selected="selected"</c:if>>사용</option>
            </select>
        </div>
        <div id="orderList" class="mt30"></div>
        <!-- <a href="javascript:history.back();" class="btn_cls">닫기</a> -->
    </div>
    <!-- //content -->
</div>
</body>
</html>
