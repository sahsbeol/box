<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<ui:decorator name="popup"/>
<html>
<head>
<title>주문상품 선택 - NEW ME HOTTRACKS</title>
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

function selectProduct() {
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
    $("input[name=orderProductInseq]", opener.document).val(inseq);
    $("input[name=productBarcode]", opener.document).val(barcode);
    $("input[name=returnCount]", opener.document).val(count);
    
    self.close();
}
</script>
</head>
<body>
<div style="width:900px;">
    <h1><img src="${imageServer}/images/renewal/common/h2_popup_customer02.gif" alt="주문상품 조회" /></h1>
    <div class="pop_cont">
        <ul class="list_type02">
            <li>상담을 원하시는 상품을 선택하세요.</li>
        </ul>
        <table class="table02 mgt15">
            <colgroup>  
                <col width="5%" />
                <col width="20%" />
                <col width="12%" />
                <col width="33%" /> 
                <col width="8%" />
                <col width="10%" />
                <col width="12%" />
            </colgroup>
            <thead>
                <tr> 
                    <th scope="col"><input type="checkbox" name="checkAll"/></th>
                    <th scope="col">상품코드</th>
                    <th scope="col"></th>
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
                        </td>
                        <td>
                            <span class="bold">${l.productBarcode}</span><br />
                            [${l.deliveryVendorName} 배송]
                        </td>
                        <td class="product"><ui:image src="${l.imageUrl }" server="product" alt="${l.primeProductName}"/></td>
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
        <div class="btn_area t_center mgt30">
            <a href="javascript://" onclick="selectProduct()" class="btn_type01" style="width:51px">상품 선택</a>
        </div>
    </div>
    <div class="pop_close">
        <a href="javascript://" onclick="self.close(); return false;">닫기</a>
    </div>
</div>
</body>
</html>