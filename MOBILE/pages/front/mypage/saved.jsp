<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<html>
<head>
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
        ,url: "/m/mypage/layerSavedList"
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
function saveClickLink(){
    location.href = 'http://order.kyobobook.co.kr/myroom/commIframe?targetUrl=//www.kyobobook.co.kr/myroom/mileageListIframe.laf?iframe_yn=Y';
}
</script>
</head>
<input type="hidden" name="eof" value="1"/>
<div id="my_content">
    <div class="my_smenu">
        <a href="/m/mypage/totsaved">통합 포인트</a>
        <a href="/m/mypage/coupon">쿠폰</a>
        <a href="/m/mypage/saved" class="active">마일리지</a>
        <a href="/m/mypage/deposit">예치금</a>
    </div>
    <p class="info t_c">고객님의 마일리지는 <span class="col_orange"><strong><fmt:formatNumber type="number" value="${totalChngAmt}"/></strong></span>원 입니다.</p>
    
    <div class="box_flex mt20">
        <a href="#" onclick="location.replace('/m/mypage/saved?srchGbn=0');return false;" class="btn tog_btn <c:if test="${c.srchGbn eq '0'}"> active </c:if>" > 적립 마일리지</a>
        <a href="#" onclick="location.replace('/m/mypage/saved?srchGbn=1');return false;" class="btn tog_btn <c:if test="${c.srchGbn eq '1'}"> active </c:if>"> 사용 마일리지</a>
    </div>
    
    <div id="orderList" class="mt30"></div>
    
    <p class="info t_c">${user.userName }님의 다음달 소멸 예상 마일리지는<br/>모바일 교보문고에서 확인 가능합니다.</p>
    
    <div class="box_flex mt10"> 
        <a href="javascript://" onclick="saveClickLink()" class="btn bg_orange"> 확인하러가기</a>
    </div>
    <!-- //content -->
</div>
</body>
</html>
