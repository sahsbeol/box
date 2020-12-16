<%@page contentType="application/javascript" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<ui:decorator name="none"/>
function addWishProduct(barcode) {
    <c:if test='${!isLogin}'>
        if (needLogin()) {
            $('img#eventFloatingIcon').hide();
        }
    </c:if>
    <c:if test='${isLogin}'>
        $.ajax({
            type: 'GET'
            ,url: '/ht/mypage/addWishPrdt'
            ,data: 'barcode=' + barcode
            ,dataType: 'json'
            ,success: function(data) {
            	var size = data.errorMessages.length;
                if (size == 0) {
                   window.open('/ht/mypage/wishPrdtPop?barcode=' + barcode, '','width=446, height=330' );
                } else {
                    alert(data.errorMessages);
                }
            }
            ,error: function(data) {
                console.log('<fmt:message key="error.common.system"/>');
            }
        });
    </c:if>
}

function addWishProductList(barcodeList) {
    <c:if test='${!isLogin}'>
        if (needLogin()) {
            $('img#eventFloatingIcon').hide();
        }
    </c:if>
    <c:if test='${isLogin}'>
        $.ajax({
            type: 'GET'
            ,url: '/ht/mypage/addWishProductList'
            ,data: 'barcodes=' + barcodeList.join('&barcodes=')
            ,dataType: 'json'
            ,success: function(data) {
                var size = data.errorMessages.length;
                if (size == 0) {
                   alert("찜상품으로 저장되었습니다.");
                } else {
                    alert(data.errorMessages);
                }
            }
            ,error: function(data) {
                console.log('<fmt:message key="error.common.system"/>');
            }
        });
    </c:if>
}

function addWishBrand(brandId) {
     <c:if test='${!isLogin}'>
        if (needLogin()) {
            $('img#eventFloatingIcon').hide();
        }
    </c:if>
    <c:if test='${isLogin}'>
        $.ajax({
            type: 'GET'
            ,url: '/ht/mypage/addWishBrand'
            ,data: 'brandId=' + brandId
            ,dataType: 'json'
            ,success: function(data) {
            	var size = data.errorMessages.length;
                if (size == 0) {
                    window.open('/ht/mypage/wishBrandPop?brandId=' + brandId , '','width=400, height=320' );
                } else {
                    alert(data.errorMessages);
                }
            }
            ,error: function(data) {
                console.log('<fmt:message key="error.common.system"/>');
            }
        });
    </c:if>
}
