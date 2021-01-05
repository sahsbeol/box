<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="none"/>
<!-- HT 쿠폰 및 자우 쿠폰이 없을 경우, -->
<c:if test="${empty list && c.page eq 1 && empty result}">
    <div class="couponbox_none">
        <div class="box">
            <p class="nocoupon"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/mobile/common/offcoupon_none.jpg" alt="오프라인쿠폰없음"/></p>
        </div>
    </div>
</c:if>
<c:if test="${c.page eq 1 && not empty offDcYn}">
    <div class="offCouponbox"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/offDc102.jpg"/></div>
</c:if>
<!--  자우 쿠폰 -->
<c:forEach items="${result}" var="l" varStatus="st">
    <c:if test="${l.stVar7 eq 'N' }">
        <div class="offCouponbox"><a href="#" onclick="popupBarcode('${l.stVar1}', '${l.stVar2 }', '${l.stVar7 }','${l.stVar3 }','${l.stVar4 }','${l.stVar8 }');return false;"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/coupon_1.png"/></a></div>
    </c:if>
    <c:if test="${l.stVar7 eq 'Y' }">
        <div class="offCouponbox"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/coupon_2.png"/></div>
    </c:if> 
</c:forEach>

<!-- 핫트랙스 쿠폰 -->
<c:forEach items="${list}" var="l" varStatus="st">
    <div class="couponbox">
        <div class="box_off">
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
                        <ui:mask pattern="####-##-##">${l.offCpnValidDt}</ui:mask> 일까지
                    </p>
                    
                    <p class="cpn_cont">
                        ${l.offCpnStd}
                    </p>
                    <p class="cpn_cont">
                        ${l.offCpnStd2}
                    </p>
            </div>
            </a>
        </div><!-- box -->
    </div>
</c:forEach>
