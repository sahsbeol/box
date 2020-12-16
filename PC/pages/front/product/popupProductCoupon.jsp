<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<ui:decorator name="popup"/>
<html>
<head>
<script type="text/javascript">
jQuery(function($) {
    $('#viewMyCoupon').click(function() {
        opener.location.href = "/ht/mypage/coupon";
        window.close();
    });
});
</script>
</head>
<body>
<div style="width:610px;">
<h1><img src="${imageServer}/images/renewal/common/tit_pop_coupon.gif" alt="상품할인 쿠폰 받기" /></h1>
<div class="pop_cont">
    <ul class="list_type02">
        <li>쿠폰은 유효기간 내에만 사용가능 합니다.</li>
        <li>다운 받으신 쿠폰은 주문결제 단계에서 사용하실 수 있습니다.</li>
        <li>하나의 상품에는 하나의 쿠폰만 사용할 수 있습니다.</li>
        <li>이미 보유 중인 쿠폰은 추가발급 되지 않습니다.</li>
    </ul>
    <div class="t_right">
        <a href="javascript://" id="viewMyCoupon" class="btn_type06"><span>나의 쿠폰내역보기</span></a>
    </div>
    <table class="table02 t_center mgt10">
        <caption>상품할인 쿠폰 받기</caption>
        <colgroup>
            <col style="width:102px" />
            <col style="width:*" />
            <col style="width:78px" />
            <col style="width:90px" />
        </colgroup>
        <thead>
            <tr>
                <th scope="col" class="fir">쿠폰받기</th>
                <th scope="col">쿠폰명</th>
                <th scope="col">혜택</th>
                <th scope="col" class="last">유효기간</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${downCouponList}" var="coupon" varStatus="status">
                <tr> 
                    <td><a href="javascript://" class="btn_type05" onclick="coupondown('${coupon.kyoboCouponId}')">쿠폰받기</a></td> 
                    <td class="t_left">${coupon.couponName }</td> 
                    <td><c:if test="${coupon.rateYn}">${coupon.couponDiscountRate}%</c:if><c:if test="${!coupon.rateYn}">${coupon.couponDiscountAmount}원</c:if></td> 
                    <td><ui:mask pattern="####.##.##">${coupon.couponApplyEndDate}</ui:mask></td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
<div class="pop_close">
    <a href="javascript://" onclick="self.close()">닫기</a>
</div>
</div>
</body>
</html>