<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<ui:decorator name="popup"/>
<head>
<link rel="stylesheet" type="text/css" href="/css/contents.css" />
<script type="text/javascript" src="/scripts/order"></script>
<script type="text/javascript">
function goProductDetail(url) {
    opener.location.href = url;
    window.close();
}
</script>
</head>
<body>
<div id="popup">
    <div class="pop-head" >
        <h1><img src="${imageServer}/images/popup/h1_logo.gif" alt="Hottracks" /></h1>
        <h2><img src="${imageServer}/images/popup/h2_popup_keepproduct.gif" alt="찜상품 보기" /></h2>
    </div> 
    <div class="pop_body">
    
         <div class="popup_infor"> 
            <div class="popup_title"> 
                <p><span class="f_black_b">[${dlvyVndrInfo.dlvyVndrName}]</span>의 찜상품입니다. (<span class="f_red_b"><fmt:formatNumber value="${dlvyVndrInfo.dlvyLevyStdAmt}" pattern="#,###"/></span>만원이상 구매시 무료배송)</p>
            </div>  
            <div class="hbox_kp">
                <c:choose>
                    <c:when test="${!empty dlvyVndrInfo.wishProductList}">
                    <ul class="photo">
                        <c:forEach items="${dlvyVndrInfo.wishProductList}" var="wishProduct" varStatus="status">
                        <li>
                            <a href="/ht/product/detail?barcode=${wishProduct.barcode}" onclick="goProductDetail(this.href);return false;"><ui:image src="${wishProduct.productImageUrl}" server="product" style="border:1px solid #999" size="200"/></a>
                            <p class="product-name"><a href="/ht/product/detail?barcode=${wishProduct.barcode}" target="_blank">${hfn:cutoff(wishProduct.productName, 18)}</a></p>  
                            <p class="price"><span><fmt:formatNumber pattern="#,###" value="${wishProduct.productSellPrice}" /></span>원</p>  
                            <span class="newbtn_025"><button type="button" class="ir" onclick="addCartSimpleProduct('${wishProduct.barcode}');">장바구니 담기</button></span>
                        </li>
                        </c:forEach>
                    </ul>
                    </c:when>
                </c:choose>
            </div>
        </div> 
        
        <div class="order_btn h15_top">
            <span class="newbtn_061"><button type="button" class="ir" onclick="opener.location.reload();window.close();">확인</button></span>
            <span class="newbtn_053"><button type="button" onclick="self.close()" class="ir">닫기</button></span>
        </div>  
                
    </div> 
</div> 
</body>