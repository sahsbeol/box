<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<ui:decorator name="popup"/>
<head>
<script type="text/javascript">
var listProduct;
var listDlvyVendor;
var listOrderCpn;
var totCpnAmt;
var selProductCoupon = {};
var selOrderCoupon;
var selDeliveryCoupon = {};

jQuery(function($) {
    $(document).ready(function(){
        window.resizeTo(800,930);
        
        init();
    });
});


function init(){
    $.ajax({
        type: "POST"
        ,url:"/ht/order/userCouponList"
        ,dataType: 'json'
        ,success: function(data) {
            if(data){
                if(data.orderCheck == "Fail"){
                    alert("주문 결제 시간이 초과 되었습니다. 다시 주문 하셔야 합니다.");
                    opener.cartPageGo();
                    window.close();
                }else{
                    listProduct = data.productList;
                    listDlvyVendor = data.dlvyVndrList;
                    listOrderCpn = data.orderCouponList;
                    
                    var userCouponSeqList = {};
                    
                    for(var i = 0; i < listProduct.length; i++) {
                        var product = listProduct[i];
                        for(var j = 0; j < product.userCouponList.length; j++) {
                            var coupon = product.userCouponList[j];
                            userCouponSeqList[coupon.userCouponSequence] = "A";
                        }
                    }
                    
                    $("#productCouponCount").text(price_format(Object.keys(userCouponSeqList).length));
                    $("#orderCouponCount").text(price_format(listOrderCpn.length));
                    
                    initProductCoupon();
                    initOrderCoupon();
                    initDeliveryCoupon();
                    
                    _calcTotalCpnPrice();
                }
            }else{
                alert("적용가능한 쿠폰이 없습니다.");
            }
        }
        ,error: function() {
            console.log('<fmt:message key="error.common.system"/>');
        }
    });
}

<%-- 상품 쿠폰 --%>
function initProductCoupon(){
    var obj = document.getElementById("divProductCoupon");
    while(obj.firstChild)    obj.removeChild(obj.firstChild);
    
    if(listProduct && listProduct.length > 0){
        for(var i = 0; i < listProduct.length; i++){
            var product = listProduct[i];
            
            var tr = document.createElement("tr");
            
            var bcode = document.createElement("td");
            bcode.classList.add("t_center");
            var strong = document.createElement("span");
            strong.appendChild(document.createTextNode(product.primeSellPrdtBcode));
            bcode.appendChild(strong);
            tr.appendChild(bcode);
            
            var prdtName = document.createElement("td");
            prdtName.appendChild(document.createTextNode(product.prdtName));
            if(product.sellPrdtGbn == 'S'){
                prdtName.appendChild(document.createElement("br"));
                var point01 = document.createElement("span");
                point01.classList.add("point02");
                point01.appendChild(document.createTextNode(product.specName));
                prdtName.appendChild(point01);
            }
            if(product.optnNameList && product.optnValueList){
                var arr1 = product.optnNameList.split("|");
                var arr2 = product.optnValueList.split("|");
                
                if(arr1.length == arr2.length){
                    prdtName.appendChild(document.createElement("br"));
                    var point02 = document.createElement("span");
                    point02.classList.add("point02");
                    point02.appendChild(document.createTextNode("("));
                    for(var j = 0; j < arr1.length; j++){
                        if(j > 0)    point02.appendChild(document.createTextNode(" "));
                        var strong = document.createElement("strong");
                        strong.appendChild(document.createTextNode(arr1[j]));
                        point02.appendChild(strong);
                        point02.appendChild(document.createTextNode(" : " + arr2[j]));
                    }
                    point02.appendChild(document.createTextNode(")"));
                    prdtName.appendChild(point02);
                }
            }
            tr.appendChild(prdtName);
            
            var price = document.createElement("td");
            price.classList.add("t_center");
            price.appendChild(document.createTextNode(price_format(product.sellPrice) + " 원"));
            tr.appendChild(price);
            
            var prdtCount = document.createElement("td");
            prdtCount.classList.add("t_center");
            prdtCount.appendChild(document.createTextNode(price_format(product.prdtCount)));
            tr.appendChild(prdtCount);
            
            var selCoupon = document.createElement("td");
            selCoupon.classList.add("t_center");
            var select = document.createElement("select");
            select.style.width = "164px";
            select.classList.add("select");
            var hndl = (function(cartSeq){ return function(){ _selProductCoupon(cartSeq, this.value); }; });
            if(select.addEventListener)    select.addEventListener("change", hndl(product.cartSeq));
            else                           select.attachEvent("onchange", hndl(product.cartSeq));
            
            var optionDef = document.createElement("option");
            optionDef.value = "";
            optionDef.appendChild(document.createTextNode("쿠폰을 선택하세요."));
            select.appendChild(optionDef);
            for(var j = 0; j < product.userCouponList.length; j++){
                var coupon = product.userCouponList[j];
                var option = document.createElement("option");
                option.value = coupon.userCouponSequence;
                option.appendChild(document.createTextNode(coupon.couponName));
                if(selProductCoupon[product.cartSeq] && coupon.userCouponSequence == selProductCoupon[product.cartSeq]){
                    option.selected = "selected";
                }else if(_applyProductYn(coupon.userCouponSequence)){
                    option.style.color = "red";
                }
                select.appendChild(option);
            }
            
            selCoupon.appendChild(select);
            tr.appendChild(selCoupon);
            
            obj.appendChild(tr);
        }
    }
}

function _selProductCoupon(cartSeq, userCpnSeq){
    if(selOrderCoupon){
        if(confirm("주문금액 쿠폰과 상품 쿠폰은 함께 사용할 수 없습니다.\n상품 쿠폰을 사용하시겠습니까?")){
            selOrderCoupon = null;
        }else{
            init();
            return;
        }
    }
    
    if(!userCpnSeq || userCpnSeq == ""){
        if(selProductCoupon[cartSeq])    delete selProductCoupon[cartSeq];
    }else {
        var product = _findProduct(cartSeq);
        var coupon = _findProductCoupon(product, userCpnSeq);
        
        if(_applyProductYn(userCpnSeq)){
            if(confirm("다른 상품에 등록된 쿠폰입니다. 추가 발급받으시겠습니까?")){
                if(coupon){
                    $.ajax({
                          type:"POST"
                        , async:false
                        , url:"/ht/coupon/productCouponDown"
                        , dataType: 'json'
                        , data : {couponId : coupon.kyoboCouponId}
                        , success: function(data) {
                            if (data.result) {
                                if(data.result["V_RES_CODE"] == '200'){
                                    alert("쿠폰이 다운로드 되었습니다.");
                                    selProductCoupon[cartSeq] = data.result["V_RES_CONT"];
                                }else{
                                    alert(data.result["V_RES_CONT"]);
                                }
                            } else {
                                alert('쿠폰 다운로드 중 오류가 발생하였습니다. 잠시후 다시 이용해주세요.');
                            }
                        }
                    });
                }else{
                    alert("쿠폰코드가 올바르지 않습니다.");
                }
            }
        }else{
            selProductCoupon[cartSeq] = userCpnSeq;
        }
    }
    init();
}

<%-- 해당 쿠폰 적용 여부 (다른 상품 또는 조건에 적용했는지 여부) --%>
function _applyProductYn(userCpnSeq){
    for(var key in selProductCoupon){
        if(selProductCoupon[key] == userCpnSeq){
            return true;
        }
    }
    return false;
}

<%-- 해당장바구니 번호의 상품 정보 반환 --%>
function _findProduct(cartSeq){
    for(var i = 0; i < listProduct.length; i++){
        var product = listProduct[i];
        if(product.cartSeq == cartSeq){
            return product;
        }
    }
}

<%-- 해당장바구니 사용자 쿠폰일련번호의 쿠폰 정보 반환 --%>
function _findProductCoupon(product, userCpnSeq){
    if(product){
        for(var i = 0; i < product.userCouponList.length; i++){
            var coupon = product.userCouponList[i];
            if(coupon.userCouponSequence == userCpnSeq){
                return coupon;
            }
        }
    }
}

<%-- 장바구니쿠폰 --%>
function initOrderCoupon(){
    var obj = document.getElementById("divOrderCoupon");
    while(obj.firstChild)    obj.removeChild(obj.firstChild);
    
    if(listOrderCpn && listOrderCpn.length > 0){
        for(var i = 0; i < listOrderCpn.length; i++){
            var coupon = listOrderCpn[i];
            
            var tr = document.createElement("tr");
            
            var check = document.createElement("td");
            check.classList.add("t_center");
            var radio = document.createElement("input");
            radio.type = "radio";
            radio.classList.add("radios");
            radio.value = coupon.userCouponSequence;
            radio.name = "orderCouponRadio";
            if(selOrderCoupon == coupon.userCouponSequence)    radio.checked = "checked";
            var hndl = (function(){ _selOrderCoupon(this.value); });
            if(radio.addEventListener)    radio.addEventListener("change", hndl);
            else                          radio.attachEvent("onchange", hndl);
            check.appendChild(radio);
            tr.appendChild(check);
            
            var cpnName = document.createElement("td");
            cpnName.classList.add("t_center");
            cpnName.appendChild(document.createTextNode(coupon.couponName));
            tr.appendChild(cpnName);
            
            var dscntAmt = document.createElement("td");
            dscntAmt.classList.add("t_center");
            dscntAmt.appendChild(document.createTextNode(price_format(coupon.couponDiscountAmount) + "원"));
            tr.appendChild(dscntAmt);
            
            var stdAmt = document.createElement("td");
            stdAmt.classList.add("t_center");
            stdAmt.appendChild(document.createTextNode(price_format(coupon.couponStandardAmount) + "원 이상 구매"));
            tr.appendChild(stdAmt);

            var applyDt = document.createElement("td");
            applyDt.classList.add("t_center");
            applyDt.appendChild(document.createTextNode(coupon.couponApplyStartDate + " ~ " + coupon.couponApplyEndDate));
            tr.appendChild(applyDt);
            
            obj.appendChild(tr);
        }
    }
}

<%-- 장바구니쿠폰 선택시 --%>
function _selOrderCoupon(userCpnSeq){
    if(!userCpnSeq || userCpnSeq == ""){
        selOrderCoupon = null;
    }else if(Object.keys(selProductCoupon).length > 0){
        if(confirm("주문금액 쿠폰과 상품 쿠폰은 함께 사용할 수 없습니다.\n주문금액 쿠폰을 사용하시겠습니까?")){
            selProductCoupon = {};
            selOrderCoupon = userCpnSeq;
        }else{
            init();
            return;
        }
    }else{
        selOrderCoupon = userCpnSeq;
    }
    init();
}

<%-- 해당장바구니 사용자 쿠폰일련번호의 쿠폰 정보 반환 --%>
function _findOrderCoupon(userCpnSeq){
    for(var i = 0; i < listOrderCpn.length; i++){
         var coupon = listOrderCpn[i];
         if(coupon.userCouponSequence == userCpnSeq){
             return coupon;
        }
    }
}

<%-- 배송쿠폰 --%>
function initDeliveryCoupon(){
    var obj = document.getElementById("divDeliveryCoupon");
    while(obj.firstChild)    obj.removeChild(obj.firstChild);
    
    if(listDlvyVendor && listDlvyVendor.length > 0){
        for(var i = 0; i < listDlvyVendor.length; i++){
            var vendor = listDlvyVendor[i];
            
            var tr = document.createElement("tr");
            
            var vndrName = document.createElement("td");
            vndrName.classList.add("t_center");
            vndrName.appendChild(document.createTextNode(vendor.dlvyVndrName));
            tr.appendChild(vndrName);
            
            var dlvyLevyStdAmt = document.createElement("td");
            dlvyLevyStdAmt.classList.add("t_center");
            dlvyLevyStdAmt.appendChild(document.createTextNode(price_format(vendor.dlvyLevyStdAmt) + "원 이상"));
            tr.appendChild(dlvyLevyStdAmt);
            
            var sellPriceSum = document.createElement("td");
            sellPriceSum.classList.add("t_center");
            sellPriceSum.appendChild(document.createTextNode(price_format(vendor.sellPriceSum) + "원"));
            tr.appendChild(sellPriceSum);
            
            var dlvyAmt = document.createElement("td");
            dlvyAmt.classList.add("t_center");
            dlvyAmt.appendChild(document.createTextNode(price_format(vendor.dlvyAmt) + "원"));
            tr.appendChild(dlvyAmt);
            
            var selCoupon = document.createElement("td");
            selCoupon.classList.add("t_center");
            var select = document.createElement("select");
            select.name = "deliveryCouponSelect";
            select.style.width = "164px";
            select.classList.add("select");
            
            var hndl = (function(vndrId){ return function(){ _selDeliveryCoupon(vndrId, this.value); }; });
            if(select.addEventListener)    select.addEventListener("change", hndl(vendor.dlvyVndrId));
            else                           select.attachEvent("onchange", hndl(vendor.dlvyVndrId));
            
            var optionDef = document.createElement("option");
            optionDef.value = "";
            optionDef.appendChild(document.createTextNode("쿠폰을 선택하세요."));
            select.appendChild(optionDef);
            for(var j = 0; j < vendor.dlvyCpnList.length; j++){
                var coupon = vendor.dlvyCpnList[j];
                var option = document.createElement("option");
                option.style.color = "#4C4C4C";
                option.value = coupon.userCouponSequence;
                if(selDeliveryCoupon[vendor.dlvyVndrId] && coupon.userCouponSequence == selDeliveryCoupon[vendor.dlvyVndrId]){
                    option.selected = "selected";
                }else if(_applyDeliveryYn(coupon.userCouponSequence)){
                    option.style.color = "#A6A6A6";
                    option.disabled = "disabled";
                }
                option.appendChild(document.createTextNode(coupon.couponName));
                select.appendChild(option);
            }
            
            selCoupon.appendChild(select);
            tr.appendChild(selCoupon);
            
            obj.appendChild(tr);
        }
    }
}

function _selDeliveryCoupon(vndrId, userCpnSeq){
    if(!userCpnSeq || userCpnSeq == ""){
        if(selDeliveryCoupon[vndrId])    delete selDeliveryCoupon[vndrId];
    }else {
        selDeliveryCoupon[vndrId] = userCpnSeq;
    }
    init();
}

<%-- 해당 쿠폰 적용 여부 (다른 상품 또는 조건에 적용했는지 여부) --%>
function _applyDeliveryYn(userCpnSeq){
    for(var key in selDeliveryCoupon){
        if(selDeliveryCoupon[key] == userCpnSeq){
            return true;
        }
    }
    return false;
}

<%-- 해당 배송업체 코드의 업체정보 반환 --%>
function _findVendor(dlvyVndrId){
    for(var i = 0; i < listDlvyVendor.length; i++){
        var vendor = listDlvyVendor[i];
        if(vendor.dlvyVndrId == dlvyVndrId){
            return vendor;
        }
    }
}

<%-- 해당 사용자 쿠폰일련번호의 배송쿠폰 정보 반환 --%>
function _findDeliveryCoupon(vendor, userCpnSeq){
    if(vendor){
        for(var i = 0; i < vendor.dlvyCpnList.length; i++){
            var coupon = vendor.dlvyCpnList[i];
            if(coupon.userCouponSequence == userCpnSeq){
                return coupon;
            }
        }
    }
}

<%-- 적용쿠폰금액 반환 --%>
function _calcTotalCpnPrice(){
    var totCpnDscntPrice = 0;
    // 상품 쿠폰 할인금액
    if(Object.keys(selProductCoupon).length > 0){
        for(var key in selProductCoupon){
            var product = _findProduct(key);
            var coupon = _findProductCoupon(product, selProductCoupon[key]);
            
            if(coupon){
                // 수량쿠폰 여부에 따른 할인금액 처리
                var cpnDscntPrice = 0;
                if(coupon.rateYn)        cpnDscntPrice = Math.round(product.sellPrice * coupon.couponDiscountRate / 1000) * 10;
                else                     cpnDscntPrice = coupon.couponDiscountAmount;
                if(coupon.countCpnYn)    cpnDscntPrice = cpnDscntPrice * product.prdtCount;
                
                totCpnDscntPrice += cpnDscntPrice;
            }
        }
    }
    
    // 장바구니쿠폰 할인금액
    if(selOrderCoupon){
        var coupon = _findOrderCoupon(selOrderCoupon);
        
        if(coupon){
            // 수량쿠폰 여부에 따른 할인금액 처리
            totCpnDscntPrice += coupon.couponDiscountAmount;
        }
    }
    
    // 배송쿠폰 할인금액
    if(Object.keys(selDeliveryCoupon).length > 0){
        for(var key in selDeliveryCoupon){
            var vendor = _findVendor(key);
            var coupon = _findDeliveryCoupon(vendor, selDeliveryCoupon[key]);
            
            if(coupon){
                totCpnDscntPrice += vendor.dlvyAmt;
            }
        }
    }
    
    $("[name=totalCpnDscntPrice]").val(price_format(totCpnDscntPrice));
}

<%-- 쿠폰적용 버튼 클릭 이벤트 --%>
function applyCoupon() {
    var totalCpnDscntPrice = parseInt($("[name=totalCpnDscntPrice]").val().split(",").join(""));
    var couponInfoList = [];
    var dlvyCouponInfoList = [];
    var orderCouponInfo = 0;
    
    // 상품 쿠폰
    if(Object.keys(selProductCoupon).length > 0){
        for(var key in selProductCoupon){
            couponInfoList.push(selProductCoupon[key] + "|" + key);
        }
    }
    
    // 장바구니쿠폰
    if(selOrderCoupon){
        orderCouponInfo = selOrderCoupon;
    }
    
    // 배송쿠폰 할인금액
    if(Object.keys(selDeliveryCoupon).length > 0){
        for(var key in selDeliveryCoupon){
            dlvyCouponInfoList.push(selDeliveryCoupon[key] + "|" + key);
        }
    }
    
    opener.applyCoupon(totalCpnDscntPrice, couponInfoList, dlvyCouponInfoList, orderCouponInfo);
    window.close();
}

</script>
<style>
.table02_v1 tbody td {padding: 10px;}
.table02_v1 tbody td.t_right {text-align: center !important;}
</style>
</head>
<body>
<div class="f_noto">
<h1 class="tit01_v2 mgt0 fs24 c_white"><span class="fw500">쿠폰 조회/적용</span></h1>
<div class="pop_cont">
    <ul class="list_type02_v2">
        <li><span class="point02">상품 쿠폰</span>과 <span class="point02">주문금액 쿠폰</span>은 중복으로 사용이 불가능합니다. (무료 배송 쿠폰은 가능합니다.)</li>
        <li><span class="point02">주문 취소/반품</span>을 하시게 되면 적용된 쿠폰은<span class="point02"> 환원이 되지 않습니다.</span> 유념해주시기 바랍니다.</li>
        <li>무료 배송 쿠폰은 국내 배송 상품만 사용 가능하며, 착불 상품 및 도선료는 해당되지 않습니다.</li>
    </ul>
    
    <h2 class="tit01_v2 mgt50 nomal">적용 가능한  <span class="point02">상품 쿠폰</span>이 총 <span class="point02" id="productCouponCount">0</span> 장 있습니다.</h2>
    <table class="table02_v1">
        <colgroup>  
            <col width="150px" /> 
            <col width="*" /> 
            <col width="100px" />
            <col width="60px" />
            <col width="200px" /> 
        </colgroup>
        <thead>
            <tr>
                <th scope="col">상품코드</th>
                <th scope="col">상품명</th>
                <th scope="col">단가</th>
                <th scope="col">수량</th>
                <th scope="col">쿠폰</th>
            </tr>
        </thead>
        <tbody id="divProductCoupon"></tbody>
    </table>
    <h2 class="tit01_v2 mgt50 normal">적용 가능한  <span class="point02">주문금액 쿠폰</span>이 총 <span class="point02" id="orderCouponCount">0</span> 장 있습니다.</h2>
    <table class="table02_v1">
        <colgroup>  
            <col width="60px" /> 
            <col width="*" /> 
            <col width="100px" />
            <col width="200px" /> 
        </colgroup>
        <thead>
            <tr> 
                <th scope="col">선택</th>
                <th scope="col">쿠폰명</th>
                <th scope="col">쿠폰금액</th>
                <th scope="col">적용기준</th>
                <th scope="col">사용기간</th>
            </tr>
        </thead>
        <tbody id="divOrderCoupon"></tbody>
    </table> 
    <c:if test="${param.dlvyCp ne 'N' }">
	    <h2 class="tit01_v2 mgt50 normal">무료 배송 쿠폰</h2>
        <table class="table02_v1">
            <colgroup>  
                <col width="20%" /> 
                <col width="15%" /> 
                <col width="20%" />
                <col width="15%" />
                <col width="30%" /> 
            </colgroup>
            <thead>
                <tr>
                    <th scope="col">배송업체</th>
                    <th scope="col">무료배송 기준</th>
                    <th scope="col">주문금액</th>
                    <th scope="col">배송비</th>
                    <th scope="col">쿠폰</th>
                </tr>
            </thead>
            <tbody id="divDeliveryCoupon"></tbody>
        </table>
    </c:if>
    <div class="box_gray02 mgt20">
        <p class="t_left fs18"><span>쿠폰 할인금액</span><label for="totalCpnDscntPrice"><input type="text" name="totalCpnDscntPrice" id="totalCpnDscntPrice" style="width:140px;text-align:right;border:none; margin-top:-4px; background-color: #f5f5f1;" class="input_txt mgl10 fs18 c_red" readonly="readonly"/></label><span>원</span></p>
    </div>
    <div class="btn_area t_center mgt30">
    	<a href="javascript://" onclick="self.close()" class="btn_type04_v2"><span>취소</span></a>
        <a href="javascript://" onclick="applyCoupon()" class="btn_type04_v1 mgl10"><span>쿠폰적용</span></a>
    </div>
</div>  
<%--<div class="pop_close" style="position:fixed;bottom:0;left:0;width:100%;">
    <a href="javascript://" onclick="self.close(); return false;">닫기</a>
</div>--%>
</div> 
<form name="usableCouponForm" id="usableCouponForm" method="post" action="/ht/order/popupCouponList"></form>
</body>