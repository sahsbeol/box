<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<ui:decorator name="layer"/>
<html>
<head>
<title>주문상품 선택 - NEW ME HOTTRACKS</title>
<style type="text/css">
.btn.btn_black {
    width : 50px;
    height : 40px;
    float : right;
    
}
.table02{
    size: 10px;
}
.btn.btn_type01{
    width : 30px;
    height : 30px;
    background-color: #ff6600;
    float: center;
    margin-bottom: 10px;
}
</style>
<script type="text/javascript">
jQuery(function($) {
    $("input[name=checkAll]").click(function() {
        var isCheckAll = $(this).is(":checked");
        var checkItem = $("input[name=checkItem]");
        
        checkItem.each(function() {
            if (isCheckAll) {
                if (!$(this).attr("checked")) {
                    $(this).attr("checked", true);
                }
            } else {
                if ($(this).attr("checked")) {
                    $(this).attr("checked", false);
                }
            }
        });
    });
});

function selectProduct( ) {
    var barcode = "";
    var inseq = "";
    var count = "";
    
    $("input[name=checkItem]:checked").each(function(i) {
        if (i == 0) {
            inseq = $(this).val();
            barcode = $(this).parent().find("input[name=productBarcode]").val();
            count = "1";
        } else {
            inseq = inseq + "," + $(this).val();
            barcode = barcode + "," + $(this).parent().find("input[name=productBarcode]").val();
            count = count + "," + "1";
        }
    });
    $("input[name=orderProductInseq]").val(inseq);
    $("input[name=productBarcode]").val(barcode);
    $("input[name=returnCount]").val(count);
    
    //$("input[name='deliveryId']").val(deliveryId);
    
    closeOrder();
    //self.close();
}
</script>
</head>
<body>
<div>
    <div class="close">
         <a href="javascript:closeOrder()" class="btn btn_black" style="margin :5px;">닫기</a>
    </div>
    <div class="pop_cont">
        <table class="table02 mgt15">
            <colgroup>  
                <col width="10%" />
                <col width="30%" />
                <col width="30%" />
                <col width="10%" /> 
                <col width="10%" />
                <col width="10%" />
            </colgroup>
            <thead>
                <tr> 
                    <th scope="col"><input type="checkbox" name="checkAll"/></th>
                    <th scope="col">상품코드</th>
                    <th scope="col">상품명</th> 
                    <th scope="col">주문수량</th> 
                    <th scope="col">단품가격</th>
                    <th scope="col">처리상태</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${listProduct}" var="l"> 
                    <tr> 
                        <td>
                            <input type="checkbox" name="checkItem" value="${l.orderProductInseq}"/>
                            <input type="hidden" name="productBarcode" value="${l.productBarcode}"/>
                            <%-- <input type="hidden" name="orderNum" value="${l.orderNum }" /> --%>
                        </td>
                        <td>
                            <span class="bold">${l.productBarcode}</span><br />
                            [${l.deliveryVendorName} 배송]
                        </td>
                        <td class="t_left">
                            ${l.primeProductName}
                            <c:if test="${not empty l.specName}"><br/><span class="f_red">${l.specName}</span></c:if>
                            <c:if test="${not empty l.optionString}"><br/><span class="f_orange">${l.optionString}</span></c:if>
                        </td>
                        <td>${l.orderCount}</td>
                        <td class="t_right"><fmt:formatNumber value="${l.singleProductSellPrice}" pattern="#,###"/>원</td>
                        <td><ui:code codeId="${l.orderDeliveryProductStatusCode}"/></td>
                    </tr>
                </c:forEach>
            </tbody> 
        </table>
    </div>
    <div class="btn_area box_flex mb15">
            <a href="javascript://" onclick="selectProduct()" class="btn btn_type01" >상품 선택</a>
    </div>
</div>
</body>
</html>