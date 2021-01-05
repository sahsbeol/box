<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<head>
<ui:decorator name="none"/>
<script type="text/javascript">
<c:if test="${orderCheck eq 'Fail'}">
    alert("주문 결제 시간이 초과 되었습니다. 다시 주문 하셔야 합니다.");
    location.href = "${defaultHost}/m/order/cart";
</c:if>

jQuery(function($) {
    $(document).ready(function(){
        window.resizeTo(800,800);
    });
    
    <%-- 기존에 선택된 상품 쿠폰 셋팅 --%>
    $("select[name='couponSelect']").each(function(){
        if(!isEmpty($(this).val())) {
            var cartSeq = $(this).parent().parent().find("input[name='cartSeq']").val();
            $("form#usableCouponForm").append("<input type='hidden' name='applyCouponInfo' value='" + $(this).val() + "|" + cartSeq + "'/>");
        }
    });
    
    <%-- 기존에 선택된 배송비 쿠폰 셋팅 --%>
    $("select[name='deliveryCouponSelect']").each(function(){
        if(!isEmpty($(this).val())) {
            var dlvyVndrId = $(this).parent().parent().find("input[name='dlvyVndrId']").val();
            $("form#usableCouponForm").append("<input type='hidden' name='applyDlvyCouponInfo' value='" + $(this).val() + "|" + dlvyVndrId + "'/>");
        }
    });
    
    <%-- 기존에 선택된 주문금액 쿠폰 셋팅 --%>
    $("input[name='orderCouponRadio']:checked").each(function(){
        $("form#usableCouponForm").append("<input type='hidden' name='applyOrderCouponInfo' value='" + $(this).val() + "'/>");
    });

    <%-- 상품별 쿠폰 선택 이벤트 --%>
    $("select[name='couponSelect']").change(function(){
        $("form#usableCouponForm").find("input[name='applyCouponInfo']").remove();
        $("form#usableCouponForm").find("input[name='applyOrderCouponInfo']").remove();
        
        $("select[name='couponSelect']").each(function(){
            if(!isEmpty($(this).val())) {
                var cartSeq = $(this).parent().parent().find("input[name='cartSeq']").val();
                $("form#usableCouponForm").append("<input type='hidden' name='applyCouponInfo' value='" + $(this).val() + "|" + cartSeq + "'/>");
            }
        });
        
        $("form#usableCouponForm").append("<input type='hidden' name='dlvyCp' value='${param.dlvyCp}'/>");
        
        
        $("form#usableCouponForm").ajaxSubmit({
            url: '/m/order/popupCouponList'
            ,dataType: 'html'
            ,success: function(html) {
                $("#useCouponList").html(html);
//                $("#useCouponList").show();
            }
            ,error: function(data) {
                alert('<fmt:message key="error.common.system"/>');
            }
        });
        
//        $("form#usableCouponForm").submit();
    });
    
    <%-- 배송업체별 쿠폰 선택 이벤트 --%>
    $("select[name='couponSelect'], select[name='deliveryCouponSelect']").change(function(){
        $("form#usableCouponForm").find("input[name='applyDlvyCouponInfo']").remove();
        
        $("select[name='deliveryCouponSelect']").each(function(){
            if(!isEmpty($(this).val())) {
                var dlvyVndrId = $(this).parent().parent().find("input[name='dlvyVndrId']").val();
                $("form#usableCouponForm").append("<input type='hidden' name='applyDlvyCouponInfo' value='" + $(this).val() + "|" + dlvyVndrId + "'/>");
            }
        });
        
        $("form#usableCouponForm").ajaxSubmit({
            url: '/m/order/popupCouponList'
            ,dataType: 'html'
            ,success: function(html) {
                $("#useCouponList").html(html);
//                $("#useCouponList").show();
            }
            ,error: function(data) {
                alert('<fmt:message key="error.common.system"/>');
            }
        });
        
        //$("form#usableCouponForm").submit();
    });
    
    <%-- 주문금액 쿠폰 선택 이벤트 --%>
    $("input[name='orderCouponRadio']").click(function(){
        var productCoupontLength = $("form#usableCouponForm").find("input[name='applyCouponInfo']").length;
        
        if(productCoupontLength > 0) {
            if(!confirm("주문금액 쿠폰과 상품쿠폰은 함께 사용할 수 없습니다.\n주문금액 쿠폰을 사용하시겠습니까?")) {
                $("input[name='orderCouponRadio']").attr("checked", false);
                return;
            }
        }
        
        $("form#usableCouponForm").find("input[name='applyCouponInfo']").remove();
        $("form#usableCouponForm").find("input[name='applyOrderCouponInfo']").remove();
        $("form#usableCouponForm").append("<input type='hidden' name='applyOrderCouponInfo' value='" + $(this).val() + "'/>");
        $("form#usableCouponForm").append("<input type='hidden' name='dlvyCp' value='${param.dlvyCp}'/>");
        
        $("form#usableCouponForm").ajaxSubmit({
            url: '/m/order/popupCouponList'
            ,dataType: 'html'
            ,success: function(html) {
                $("#useCouponList").html(html);
//                $("#useCouponList").show();
            }
            ,error: function(data) {
                alert('<fmt:message key="error.common.system"/>');
            }
        });
        
//        $("form#usableCouponForm").submit();
    });
});

<%-- 쿠폰적용 버튼 클릭 이벤트 --%>
function applyPopCoupon() {
    var totalCpnDscntPrice = $("input[name='totalCpnDscntPrice']").val();
    var couponInfoList = [];
    var dlvyCouponInfoList = [];
    $("input[name='userCouponSequence']").each(function() {
        if($(this).val() != 0) {
            couponInfoList.push($(this).val() + "|" + $(this).parent().find("input[name='cartSeq']").val());
        }
    });
    $("input[name='userDlvyCouponSequence']").each(function() {
        if($(this).val() != 0) {
            dlvyCouponInfoList.push($(this).val() + "|" + $(this).parent().find("input[name='dlvyVndrId']").val());
        }
    });
    var orderCouponInfo = isEmpty($("input[name='orderCouponRadio']:checked").val()) ? 0 : $("input[name='orderCouponRadio']:checked").val();
    
    applyCoupon(totalCpnDscntPrice, couponInfoList, dlvyCouponInfoList, orderCouponInfo);
    $("#useCouponList").hide();
}
function applyPopCouponClose() {
    $("#useCouponList").hide();
}
</script>
</head>
<body>
<div style="width:780px;">
<div class="pop_cont" style="height:555px;overflow-y:auto;">
    <ul class="list_type02">
        <li><span class="point02">상품 쿠폰</span>과 <span class="point02">주문금액 쿠폰</span>은 중복으로 사용이 불가능합니다. (배송비 쿠폰은 가능합니다.)</li>
    </ul>
    <ul class="list_type02 mgt15">
        <li>적용가능한  <span class="point02 bold">상품쿠폰</span>이 총 <span class="point02 bold">${usableCpnCount}</span> 장 있습니다.</li>
    </ul>
    <table class="table02">
        <colgroup>  
            <col width="*" /> 
            <col width="200px" /> 
        </colgroup>
        <thead>
            <tr>
                <th scope="col">상품명</th> 
                <th scope="col">쿠폰</th> 
            </tr>
        </thead>
        <tbody>
            <c:forEach var="product" items="${productList}">
                <tr>
                    <input type="hidden" name="cartSeq" value="${product.cartSeq}"/>
                    <input type="hidden" name="userCouponSequence" value="${product.userCouponSequence}"/>
                    <td>${product.prdtName}
                        <c:if test="${product.sellPrdtGbn eq 'S'}">
                            <span class="point02">(${product.specName})</span>
                        </c:if>
                        <c:choose>
                            <c:when test="${!empty product.optnList}">
                                <span class="point02">(<c:forEach items="${product.optnList}" var="optn" varStatus="optnStatus">${optn}<c:if test="${fn:length(product.optnList) > optnStatus.count}">&nbsp;</c:if></c:forEach>)</span>
                            </c:when>
                        </c:choose>
                    </td> 
                    <td class="t_center">
                        <select name="couponSelect" style="width:164px;" class="select couponSelect${product.cartSeq}">
                            <option value="">쿠폰을 선택하세요</option>
                            <c:forEach items="${product.userCouponList}" var="coupon">
                                <option value="${coupon.userCouponSequence}"<c:if test="${coupon.applyStatus eq 'O'}"> disabled="disabled" style="background-color: gray;"</c:if><c:if test="${coupon.applyStatus eq 'Y'}"> selected="selected"</c:if>>${coupon.couponName}</option>
                            </c:forEach>
                        </select>
                    </td> 
                </tr>
            </c:forEach>
        </tbody>
    </table>
    <ul class="list_type02 mgt15">
        <li>적용가능한  <span class="point02 bold">주문금액쿠폰</span>이 총 <span class="point02 bold">${fn:length(orderCouponList)}</span> 장 있습니다.</li>
    </ul>
    <table class="table02">
        <colgroup>  
            <col width="60px" /> 
            <col width="200px" /> 
            <col width="100px" />
        </colgroup>
        <thead>
            <tr> 
                <th scope="col">선택</th> 
                <th scope="col">쿠폰명</th> 
                <th scope="col">쿠폰금액</th> 
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${orderCouponList}" var="coupon">
                <tr> 
                    <td class="t_center">
                        <input type="radio" class="radios" value="${coupon.userCouponSequence}" name="orderCouponRadio"<c:if test="${applyOrderCouponInfo eq coupon.userCouponSequence}"> checked="checked"</c:if>>
                    </td> 
                    <td>${coupon.couponName}</td> 
                    <td class="t_right"><fmt:formatNumber value="${coupon.couponDiscountAmount}" pattern="#,###"/>원</td> 
                </tr>
            </c:forEach>
        </tbody>
    </table> 
    <c:if test="${param.dlvyCp ne 'N' }">
        <ul class="list_type02 mgt15">
            <li>배송비 쿠폰을 사용하시면 해당 장바구니는 무료 배송이 가능합니다.</li>
        </ul>
        <table class="table02">
            <colgroup>  
                <col width="40%" /> 
                <col width="20%" />
                <col width="40%" /> 
            </colgroup>
            <thead>
                <tr>
                    <th scope="col">배송업체</th> 
                    <th scope="col">배송비</th> 
                    <th scope="col">쿠폰</th> 
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${dlvyVndrList}" var="vendor">
                    <tr>
                        <td>
                            <input type="hidden" name="dlvyVndrId" value="${vendor.dlvyVndrId}"/>
                            <input type="hidden" name="userDlvyCouponSequence" value="${vendor.userCouponSequence}"/>
                            ${vendor.dlvyVndrName}
                        </td>
                        <td class="t_right"><fmt:formatNumber value="${vendor.dlvyAmt}" pattern="#,###"/>원</td>
                        <td class="t_right">
                            <select name="deliveryCouponSelect" style="width:164px;" class="select deliveryCouponSelect${vendor.dlvyVndrId}">
                                <option value="">쿠폰을 선택하세요</option>
                                <c:forEach items="${vendor.dlvyCpnList}" var="coupon">
                                    <option value="${coupon.userCouponSequence}"<c:if test="${coupon.applyStatus eq 'O'}"> disabled="disabled" style="background-color: gray;"</c:if><c:if test="${coupon.applyStatus eq 'Y'}"> selected="selected"</c:if>>${coupon.couponName}</option>
                                </c:forEach>
                            </select>
                        </td> 
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>
    <div class="mgt15 box_gray">
        <label for="totalCpnDscntPrice"><span>쿠폰할인금액</span> <input type="text" name="totalCpnDscntPrice" id="totalCpnDscntPrice" value="${totalCpnDscntPrice}" style="width:140px;" class="input_txt mgl30" readonly="readonly"/> 원</label>
    </div>
    <div class="btn_area t_center mgt30">
        <a href="javascript://" onclick="applyPopCoupon()" class="btn_type01" style="width:51px">쿠폰적용</a>
    </div>
</div>  
<div class="pop_close">
    <a href="javascript://" onclick="applyPopCouponClose(); return false;">닫기</a>
</div>
</div> 
<form name="usableCouponForm" id="usableCouponForm" method="post" action="/m/order/popupCouponList"></form>
</div>
</body>