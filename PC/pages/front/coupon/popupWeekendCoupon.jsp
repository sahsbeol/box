<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<ui:decorator name="welcomeMain"/>
<html>
<head>
<style type="text/css">
table.limitCoupon { width:950px;border:0;}
table.limitCoupon tr td.downBtn { width:572px; }
table.limitCoupon tr td.limitCount { width:156px; }
table.limitCoupon tr td.limitCount table { width:212px;border:0; }
table.limitCoupon tr td.limitCount table tr.couponCount td { width:52px; height:53px; text-align:center; background:url("http://image.kyobobook.co.kr/newimages/giftshop_new/work/1570/1333328304716_w_coupon_c1.jpg") no-repeat; }
table.limitCoupon tr td.limitCount table tr.couponCount td span {font-family:verdana; font-size: 26px; COLOR: #ffffff; LINE-HEIGHT: 1.5; TEXT-DECORATION: bold;}
</style>
<script type="text/javascript">
var isLogin = ${isLogin}
function couponDown(couponId) {
    if (!isLogin) {
        needLogin();
    } else {
        $.ajax({
            type: "GET"
            ,url: "/ht/getCouponDown"
            ,data: 'couponId=' + couponId
            ,dataType: "json"
            ,success: function(data) {
                if (data.save) {
                    alert("쿠폰이 다운로드 되었습니다.");
                } else {
                    alert(data.errorMessage);
                }
            }
            ,error: function() {
                alert('<fmt:message key="error.common.system"/>');
            }
        });
    }
}
</script>
</head>
<body>
<c:set var="imgUrl" value="http://image.kyobobook.co.kr/newimages/giftshop_new/work"/>
<c:set var="endYn" value="${empty couponLimit||couponLimit.leaveCnt<1?'Y':'N'}"/>
<table class="limitCoupon">
    <tr>
        <%--td colspan="3"><img src="${imgUrl}/1715/1333507006052_w_coupon_1_1.jpg" width="950" height="596" /></td --%>
        <td colspan="3">
            <c:if test="${empty couponLimit}">
                <img src="${imgUrl}/w_coupon_5000_off.jpg" width="950" height="596"/>
            </c:if>
            <c:if test="${couponLimit.leaveCnt<1}">
                <img src="${couponLimit.imageOff}" width="950" height="596" onerror="this.src='http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/no_image2.gif';"/>
            </c:if>
            <c:if test="${couponLimit.leaveCnt>0}">
                <img src="${couponLimit.imageOn}" width="950" height="596" onerror="this.src='${imgUrl}/1715/1333507006052_w_coupon_1_1.jpg';"/>
            </c:if>
        </td>
    </tr>
    <tr>
        <td class="downBtn" style="background:url('http://image.kyobobook.co.kr/newimages/giftshop_new/work/1124/1333328272305_w_coupon_2.jpg') no-repeat 0 0;width:517px;">
            <c:if test="${endYn eq 'N'}">
                <p onclick="javascript:couponDown('${couponLimit.couponId}')" style="background:url('http://image.kyobobook.co.kr/newimages/giftshop_new/work/1124/1333328272305_w_coupon_2.jpg') no-repeat -203px 0;width:144px;height:139px;cursor:pointer;margin-left:203px;"/>
            </c:if>
        </td>
        <td class="limitCount" style="width:211px;">
            <table>
                <tr>
                    <td colspan="4" style="vertical-align:top;text-align:center;">
                        <img src="${imgUrl}/1603/1333328335102_w_coupon_3.jpg" style="width:156px;height:66px;"/>
                    </td>
                </tr>
                <tr class="couponCount">
                    <c:choose>
                        <c:when test="${endYn eq 'Y'}"><c:set var="leaveCnt" value="0000"/></c:when>
                        <c:when test="${couponLimit.leaveCnt>9999}"><c:set var="leaveCnt" value="9999"/></c:when>
                        <c:otherwise><c:set var="leaveCnt"><ui:lpad length="4" padChar="0">${couponLimit.leaveCnt%10000}</ui:lpad></c:set></c:otherwise>
                    </c:choose>
                    <td><span>${fn:substring(leaveCnt, 0,1)}</span></td>
                    <td><span>${fn:substring(leaveCnt, 1,2)}</span></td>
                    <td><span>${fn:substring(leaveCnt, 2,3)}</span></td>
                    <td><span>${fn:substring(leaveCnt, 3,4)}</span></td>
                </tr>
                <tr>
                    <td height="20" background="${imgUrl}/1091/1333328604885_w_coupon_c2.jpg">&nbsp;</td>
                    <td height="20" background="${imgUrl}/1091/1333328604885_w_coupon_c2.jpg">&nbsp;</td>
                    <td height="20" background="${imgUrl}/1091/1333328604885_w_coupon_c2.jpg">&nbsp;</td>
                    <td background="${imgUrl}/1091/1333328604885_w_coupon_c2.jpg">&nbsp;</td>
                </tr>
            </table>
        </td>
        <td width="222" style="background:url('http://image.kyobobook.co.kr/newimages/giftshop_new/work/1082/1333328286579_w_coupon_4.jpg') no-repeat 0 0;"></td>
    </tr>
    <tr>
        <td colspan="4" style="background:url('http://image.kyobobook.co.kr/newimages/giftshop_new/work/1561/1333328296191_w_coupon_5.jpg') no-repeat 0 -1px;width:950px;height:180px;"></td>
    </tr>
</table>
</body>
</html>