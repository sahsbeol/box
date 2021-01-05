<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<!--  여기 까지 삭제 -->
<style type="text/css">
span.btn_area { padding : 0 38px; text-align: center; border : 1px solid #a0a0a0;}
span.btn_area a.btn{color : #000;}
.box_tit { font-size:15px;font-weight:bold;padding-bottom:10px;margin-bottom:20px;border-bottom:1px solid #dadada;display:block; }
.ly_box.active{ background:url('http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/company/bg_10x10.png') }
.ly_box .ly_conts { display: block; margin: auto; padding:10px 0;text-align: center; position: relative; top: 50%; margin-top: -65px; overflow: visible; background-color: #fff; border-radius: 5px;  border: 2px solid #ff4400;}
.btn_white_l { position: absolute;top: -28px;right: 5px;display:block;width:25px;height:25px;background:url('http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/renewal/common/btn_close04.png') no-repeat 50% 50%;background-size:25px;overflow:hidden;text-overflow:ellipsis;text-indent:-999px;text-align:left;}
.ly_box .ly_conts .line01 { width : 100%;border-bottom: 1px solid #dadada;border-width: 0 0 1px 0; }
#my_content .my_list .couponbox .box_on{     background-repeat: no-repeat; margin: 10px 10px; border: 5px solid #ff6600; border-radius: 20px; background: url(http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/common/online_coupon.png) no-repeat 90% center; background-size: 97px auto;    background-color: #f60;
}
</style>
<script type="text/javascript" src="/js/jquery-barcode.min.js"></script>
<script type="text/javascript">
function showBarcode(cpnId, offCpnName, offUseYn){
    $("#cpnTit").html(offCpnName);
    $(".barcode").barcode(cpnId, "code128");
    $(".bar_hidden").val(cpnId);
    
    if(offUseYn == 'N'){
        $("div#btn_barcode").hide();
    } else {
        $("div#btn_barcode").show();
    }
    
    if($(".ly_box").hasClass("active")){
        $(".ly_box").removeClass("active");
        $(".ly_box").hide();
        $(".btn_white_l").hide();
    }else{
        $(".ly_box").addClass("active");
        $(".ly_box").show();
        $(".btn_white_l").show();
    }
    
}
function completeBarcode(){
    var offCpnId = $(".bar_hidden").val();
    $.ajax({
        type: "POST"
       ,url: "/m/offLine/updateUseBarcode"
       ,data: { offCpnId : offCpnId}
       ,dataType: "JSON"
       ,success : function(data){
            alert("사용완료 되었습니다.");
            location.reload();
       }
       ,error: function(data) {
           alert("사용되지 않았습니다.");
       }
   });
}
function closeBarcode(){
    $(".ly_box").hide();
    $(".btn_white_l").hide();
    return false;
}
</script>
<ui:decorator name="none"/>
<div class="ly_box" onclick="showBarcode();">
    <div class="ly_conts">
        <strong id="cpnTit" class="box_tit"></strong>
        <div class="barcode" style="margin:10px auto;"></div>
        <div id="btn_barcode">
            <input class="bar_hidden" type="hidden" value="">
            <span class="btn_area"><a class="btn" href="#" onclick="completeBarcode();return false;">사용</a></span><br>
            <p style="padding : 8px 0 8px;">●사용완료 버튼은 영업점 결제시, <br> 카운터에서 체크하는 버튼입니다.</p>
        </div>
        <div onclick="closeBarcode();" class="btn_white_l">닫기</div>
    </div>
</div>
<!--  여기 까지 삭제 -->
<c:if test="${empty list && c.page eq 1}">
    <div class="couponbox_none">
        <div class="box">
            <p class="nocoupon"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/mobile/common/oncoupon_none.jpg" alt="온라인쿠폰없음"/></p>
        </div>
    </div>
</c:if>
<c:forEach items="${list}" var="l" varStatus="st">
    <div class="couponbox">
        <div class="box_on">
            <c:if test="${empty l.kyoboCpnId }">
                <a href="#" onclick="showBarcode('${l.offCpnId}', '${l.offCpnName }', '${l.offUseYn }');return false;" style="display:block;" >
                <div class="inner_box" >
                    <p class="cpn_tit">${l.offCpnName}</p>
                    <p class="cpn_txt">
                        <c:choose>
                            <c:when test="${l.offRateYn eq 'N'}"><span><fmt:formatNumber value="${l.offCpnDscntAmt}" pattern="#,###"/></span>원 할인</c:when>
                            <c:otherwise>
                                <span><fmt:formatNumber value="${l.offCpnDscntRate}" pattern="#,###"/></span>% 할인
                            </c:otherwise>
                        </c:choose>
                    </p>
                    <p class="cpn_date">
                        <fmt:formatDate value="${l.offCpnGainDtm}" pattern="yyyy-MM-dd"/> ~ <ui:mask pattern="####-##-##">${l.offCpnValidDt}</ui:mask>
                    </p>
                    
                    <p class="cpn_cont">
                        ${l.offCpnStd}
                    </p>
                    <p class="cpn_cont">
                        ${l.offCpnStd2}
                    </p>
                </div>
                <!-- <div class="ment"> 
                    영업점 전용쿠폰<br>사용시 클릭
                    <em class="ico_arr_r">
                        <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/mobile/common/arrow_r02.png"/>
                        <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/mobile/common/arrow_r02.png"/>
                    </em>
                </div> -->
                </a>
            </c:if>
            <c:if test="${not empty l.kyoboCpnId }">
            <div class="inner_box">
                <p class="cpn_tit">${l.offCpnName}</p>
                <p class="cpn_txt">
                    <c:choose>
                        <c:when test="${fn:contains(l.offCpnName, '입장권')}"><span>초대권</span></c:when>
                        <c:when test="${l.scopeGbn eq 'D'}"><span>무료 배송</span></c:when>
                        <c:otherwise>
                            <%-- <c:choose>
                                <c:when test="${l.rateYn}"><span><fmt:formatNumber value="${l.offCpnDscntRate}" pattern="#,###"/></span>% 할인</c:when>
                                <c:when test="${!l.rateYn}"><span><fmt:formatNumber value="${l.offCpnDscntAmt}" pattern="#,###"/></span>원 할인</c:when>
                                <c:otherwise><span>0</span></c:otherwise>
                            </c:choose> --%>
                            <c:choose>
                                <c:when test="${l.offRateYn eq 'N'}"><span><fmt:formatNumber value="${l.offCpnDscntAmt}" pattern="#,###"/></span>원 할인</c:when>
                                <c:otherwise>
                                    <span><fmt:formatNumber value="${l.offCpnDscntRate}" pattern="#,###"/></span>% 할인
                                </c:otherwise>
                            </c:choose>
                        </c:otherwise>
                    </c:choose>
                </p>
                <p class="cpn_date">
                    <fmt:formatDate value="${l.offCpnGainDtm}" pattern="yyyy-MM-dd"/> ~ <ui:mask pattern="####-##-##">${l.offCpnValidDt}</ui:mask>
                </p>
                
                <c:choose>
                    <c:when test="${fn:contains(l.offCpnName, '입장권')}"></c:when>
                    <c:when test="${l.scopeGbn eq 'O'}">주문금액 <fmt:formatNumber pattern="#,###" value="${l.cpnStdAmt}"/>원 이상</c:when>
                    <c:when test="${l.scopeGbn eq 'C' || l.scopeGbn eq 'P'}">상품단가 <fmt:formatNumber pattern="#,###" value="${l.snglPrdtLimitPrice}"/>원 이상</c:when>
                </c:choose>
                
                <%--  
                <p class="cpn_date">
                    <ui:mask pattern="####-##-##">${l.cpnValidDt}</ui:mask> 일까지
                    <em class="col_orange">${l.limitDt}일 남음</em> 
                </p>
                
                <p class="cpn_cont">
                    <c:if test="${l.scopeGbn eq 'D'}">-</c:if>
                    <c:if test="${l.scopeGbn eq 'O'}">주문금액 <fmt:formatNumber pattern="#,###" value="${l.cpnStdAmt}"/>원 이상</c:if>
                    <c:if test="${l.scopeGbn eq 'C' || l.scopeGbn eq 'P'}">상품단가 <fmt:formatNumber pattern="#,###" value="${l.snglPrdtLimitPrice}"/>원 이상</c:if>
                </p> --%> 
            </div>
            </c:if>
            
        </div><!--  class: box -->
    </div>
</c:forEach>