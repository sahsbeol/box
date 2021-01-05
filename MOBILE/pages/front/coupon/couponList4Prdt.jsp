<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="layer"/>
<html>
<head>
<script type="text/javascript">
jQuery(function($){
    $(document).ready(function(){
        $('body').addClass('bg_gray');//상단 mini 모드
    });
});
function coupondown(couponId) {
    $.ajax({
        type: "POST"
        ,url:"/m/coupon/productCouponDown"
        ,dataType: 'json'
        ,data : {couponId : couponId}
        ,success: function(data) {
            if (data.save) {
                alert("쿠폰이 다운로드 되었습니다.");
            } else {
                alert(data.errorMessage);
            }
            history.back();
        }
        ,error: function() {
            alert('<fmt:message key="error.common.system"/>');
        }
    });
}
</script>
</head>
<!-- tit_section -->
<div id="ly_header">
    <h1>상품 할인쿠폰 받기</h1>
</div>
<!-- //tit_section -->

<!-- content -->
<div id="ly_content" class="mg10 line_db">
    <c:forEach items="${list}" var="l" varStatus="st">
        <div class="roundbox pd10_0">
            <h3 class="tit_type2">${l.cpnName}</h3>
            <ul class="br_list mt20">
                <li>
                    <strong class="fl_l">적용기준</strong>
                    <span class="fl_r">
                        <c:if test="${l.rateYn}">${l.cpnDscntRate}%</c:if><c:if test="${!l.rateYn}">${l.cpnDscntAmt}원</c:if>
                    </span>
                </li>
                <li>
                    <strong class="fl_l">만료일자</strong>
                    <span class="fl_r"><ui:mask pattern="####.##.##">${l.cpnApplyEndDt}</ui:mask></span>
                </li>
            </ul>
            <div class="box_flex mt20">
                <a href="javascript:coupondown('${l.kyoboCpnId}')" class="bt_mbgb"><span class="detail_coupon">쿠폰받기</span></a>
            </div>
        </div>
    </c:forEach>
    <a href="javascript:history.back();" class="btn_cls">닫기</a>
</div>
<!-- //content -->
</body>
</html>
