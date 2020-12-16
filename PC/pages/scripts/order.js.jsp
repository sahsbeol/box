<%@page contentType="application/javascript" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<ui:decorator name="none"/>
function addCartSimpleProduct(barcode) {
    var param = "sellPrdtBcode=" + barcode;
    param += "&prdtCount=1";
    
    $.ajax({
        type: "POST"
        ,url: "/ht/order/addCart"
        ,data : param
        ,dataType: "json"
        ,success : function(data){
            if (data) {
                if(data.save) {
                    alert("장바구니에 저장되었습니다.");
                } else {
                    var errorMessages = data.errorMessages;
                    alert(errorMessages.join("\n"));
                }
            }
        }
        ,error: function(data) {
            alert('<fmt:message key="error.common.system"/>');
        }
    });
}
    
    function addCartProductList(barcodeList) {
    if(isEmpty(barcodeList) || barcodeList.length == 0) {
        alert("장바구니에 담을 상품이 없습니다.");
        return;
    }
    
    var param = "prdtCounts=1&sellPrdtBcodes=" + barcodeList.join("&prdtCounts=1&sellPrdtBcodes=");
    
    $.ajax({
        type: "POST"
        ,url: "/ht/order/addCartForProductList"
        ,data: param
        ,dataType: "json"
        ,success : function(data){
            if (data) {
                if(data.save) {
                  alert("장바구니에 저장되었습니다.");
              } else {
                  var errorMessages = data.errorMessages;
                  alert(errorMessages.join("\n") + "\n\n옵션 및 기타  선택이 필요한 상품은 상품 상세에서 장바구니에 담으실 수 있습니다.");
              }
              // 상단 장바구니 카운트 변경
              initTopNavigation();
            }
        }
        ,error: function(data) {
            alert('<fmt:message key="error.common.system"/>');
        }
    });
}