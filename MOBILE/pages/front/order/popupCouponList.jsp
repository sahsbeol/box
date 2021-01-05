<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<head>
<ui:decorator name="layer"/>
<script type="text/javascript" src="/js/jquery.form.js"></script>
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
            dlvyCouponInfoList.push($(this).val() + "|" + $(this).parent().parent().find("input[name='dlvyVndrId']").val());
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
<div id="ly_header">
    <h1>사용 가능 쿠폰 선택</h1>
</div>
<div id="ly_content" class="layer_a">
	
	<div class="f12 pt10 pb20">
    	<p><span class="col_salmon">상품 쿠폰</span>과 <span class="col_salmon">주문금액 쿠폰</span>은 중복으로 사용이 불가능합니다.<br/>(무료배송 쿠폰은 가능합니다.)</p>
    	<p><span class="col_salmon">주문 취소/반품</span>을 하시게 되면 적용된 <span class="col_salmon">쿠폰은 환원이 되지 않습니다.</span> 유념해주시기 바랍니다.</p>
		<p>무료배송 쿠폰은 국내 배송 상품만 사용 가능하며, 착불 상품 및 도선료는 해당되지 않습니다.</p>
    </div>
    
    <h3>적용 가능한<strong> 상품 쿠폰</strong>이 총 <strong class="col_red"> ${usableCpnCount}</strong>장 있습니다.</h3>
    <c:forEach items="${productList}" var="l" varStatus="st">
        <div class="roundbox mt10">
            <h3><strong>${l.prdtName}</strong></h3>
            <ul class="br_list">
                    <c:if test="${l.sellPrdtGbn eq 'S'}">
                    <li>
                        <span class="fl_l">사양명</span>
                        <span class="fl_r">${l.specName}</span>
                    </li>
                    </c:if>
                    <c:if test="${not empty l.optnList}">
                    <li>
                        <span class="fl_l">옵션명</span>
                        <span class="fl_r"><c:forEach items="${l.optnList}" var="optn" varStatus="optnStatus"><p>${optn}</p></c:forEach></span>
                    </li>
                    </c:if>
                <li>
                    <input type="hidden" name="cartSeq" value="${l.cartSeq}"/>
                    <input type="hidden" name="userCouponSequence" value="${l.userCouponSequence}"/>
                    <span class="f14 fl_l mt7 col_grey">쿠폰 선택</span>
                    <span class="fl_r">
                        <select name="couponSelect" style="width:187px;" class="select couponSelect${l.cartSeq}">
                            <option value="">쿠폰을 선택하세요</option>
                            <c:forEach items="${l.userCouponList}" var="l2">
                                <option value="${l2.userCouponSequence}"<c:if test="${l2.applyStatus eq 'O'}"> disabled="disabled" style="background-color: gray;"</c:if><c:if test="${l2.applyStatus eq 'Y'}"> selected="selected"</c:if>>${l2.couponName}</option>
                            </c:forEach>
                        </select>
                    </span>
                </li>
            </ul>
        </div>
    </c:forEach>
    <h3 class="mt30">적용 가능한<strong> 주문금액 쿠폰</strong>이 총 <strong class="col_red"> ${fn:length(orderCouponList)}</strong>장 있습니다.</h3>
    <c:forEach items="${orderCouponList}" var="l" varStatus="st">
        <div class="roundbox mt10">
        	<h3><strong>${l.couponName}</strong></h3>
            <ul class="br_list">
                <li>
                    <span class="fl_l col_grey"><label><input type="radio" class="radios mtm5 mr10" value="${l.userCouponSequence}" name="orderCouponRadio"<c:if test="${applyOrderCouponInfo eq l.userCouponSequence}"> checked="checked"</c:if>>할인금액</label></span>
                    <span class="fl_r col_black"><strong class="col_red"><fmt:formatNumber value="${l.couponDiscountAmount}" pattern="#,###"/></strong>원</span>
                </li>
                <li>
                	<span class="fl_l col_grey">${l.couponApplyStartDate} ~ ${l.couponApplyEndDate}</span>
                </li>
            </ul>
        </div>
    </c:forEach>
    <c:forEach items="${dlvyVndrList}" var="l" varStatus="st">
        <div class="roundbox mt10">
            <h3 class="tit_type2">${l.dlvyVndrName}</h3>
            <ul class="br_list">
                <li>
                    <span class="fl_l col_grey">배송비</span>
                    <span class="fl_r col_black"><strong class="col_red"><fmt:formatNumber value="${l.dlvyAmt}" pattern="#,###"/></strong>원</span>
                </li>
                <li>
                    <input type="hidden" name="dlvyVndrId" value="${l.dlvyVndrId}"/>
                    <input type="hidden" name="userDlvyCouponSequence" value="${l.userCouponSequence}"/>
                    <span class="f14 fl_l mt7 col_grey">쿠폰 선택</span>
                    <span class="fl_r">
                        <select name="deliveryCouponSelect" style="width:187px;" class="select deliveryCouponSelect${l.dlvyVndrId}">
                            <option value="">쿠폰을 선택하세요</option>
                            <c:forEach items="${l.dlvyCpnList}" var="l2">
                                <option value="${l2.userCouponSequence}"<c:if test="${l2.applyStatus eq 'O'}"> disabled="disabled" style="background-color: gray;"</c:if><c:if test="${l2.applyStatus eq 'Y'}"> selected="selected"</c:if>>${l2.couponName}</option>
                            </c:forEach>
                        </select>
                    </span>
                </li>
            </ul>
        </div>
    </c:forEach>
        
    <div class="mt20 mb10 t_c clear">
        <a href="javascript:applyPopCoupon();" class="bt_mbgb">쿠폰 적용</a>
    </div>
    <a href="javascript:applyPopCouponClose();" class="btn_cls">닫기</a>
</div>
<input type="hidden" name="totalCpnDscntPrice" id="totalCpnDscntPrice" value="${totalCpnDscntPrice}" style="width:140px;" class="input_txt mgl30" readonly="readonly"/>
<form name="usableCouponForm" id="usableCouponForm" method="post" action="/m/order/popupCouponList"></form>
</body>