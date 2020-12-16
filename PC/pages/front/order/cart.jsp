<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>

<link rel="stylesheet" type="text/css" href="/css/swiper.min.css?${tmpKey}">
<!-- Facebook Pixel Code -->
<script>
!function(f,b,e,v,n,t,s){if(f.fbq)return;n=f.fbq=function(){n.callMethod?
n.callMethod.apply(n,arguments):n.queue.push(arguments)};if(!f._fbq)f._fbq=n;
n.push=n;n.loaded=!0;n.version='2.0';n.queue=[];t=b.createElement(e);t.async=!0;
t.src=v;s=b.getElementsByTagName(e)[0];s.parentNode.insertBefore(t,s)}(window,
document,'script','//connect.facebook.net/en_US/fbevents.js');

fbq('init', '2595348470556537');
fbq('track', "PageView");</script>
<noscript><img height="1" width="1" style="display:none"
src="https://www.facebook.com/tr?id=1053245131399072&ev=PageView&noscript=1"
/></noscript>
<!-- End Facebook Pixel Code -->

<script type="text/javascript">
var _CNM = '장바구니';   /* Conversion Name ex) _CNM='회원가입';*/
var _CNV = '0';   /* Conversion Value ex) _CNV = '10000'; */
var sslHost = "${sslHost}";
jQuery(function($) {
    <%-- 전체선택 체크박스 클릭 이벤트 --%>
    $("input[name='chkAll']").click(function(){
        if($(this).is(":checked")){
        	$(this).closest('table').find('input[type=checkbox]').prop("checked",true);
        }else{
        	$(this).closest('table').find('input[type=checkbox]').prop("checked",false);
        }
    });
    
    
    <%-- 수량변경 버튼 클릭 이벤트--%>
    $(".btnChangePrdtCount").click(function() {
        var cartSeq = $(this).parent().parent().find("td input[name='cartSeq']").val();
        var prdtCount = $(this).parent().find("input[name='prdtCount']").val();
        var sellPrdtBcode = $(this).parent().parent().find("td input[name='sellPrdtBcode']").val();
        
        var param = "cartSeq=" + cartSeq;
        param += "&prdtCount=" + prdtCount;
        param += "&sellPrdtBcode=" + sellPrdtBcode;
        
        // 공백 제거 trim 기능...
        prdtCount = prdtCount.replace(/(^\s*)|(\s*$)/gi,"");
        
        if (prdtCount == "" || cartSeq == "" || sellPrdtBcode == "") {
            alert("수량이 없습니다.");
            return;
        }
        
        if (isNaN(prdtCount)) {
            alert("수량에 숫자만 입력해야 합니다.");
            return;
        }
        
        $.ajax({
            type: "POST"
            ,url: "/ht/order/changeCartPrdtCount"
            ,data: param
            ,dataType: "json"
            ,success : function(data){
                if (data) {
                    if(data.save) {
                        alert("수량이 변경되었습니다.");
                    } else {
                        var errorMessages = data.errorMessages;
                        alert(errorMessages.join("\n"));
                    }
                    window.location.reload();
                }
            }
            ,error: function(data) {
                alert('<fmt:message key="error.common.system"/>');
                window.location.reload();
            }
        });
    });
    
    <%-- 삭제 버튼 클릭 이벤트--%>
    $(".btnDeleteCartProduct").click(function() {
        if(!confirm("<fmt:message key='confirm.delete.message' />")) {
            return;
        }
        var cartSeq = $(this).parents("tr").find("input[name='cartSeq']").val();
        
        var param = "cartSeqs=" + cartSeq;
        
        $.ajax({
            type: "POST"
            ,url: "/ht/order/removeCart"
            ,data: param
            ,dataType: "json"
            ,success : function(data){
                if (data) {
                    if(data.save) {
                        alert("삭제되었습니다.");
                        window.location.reload();
                    } else {
                        alert(data.save);
                        var errorMessages = data.errorMessages;
                        alert(errorMessages.join("\n"));
                    }
                }
            }
            ,error: function(data) {
                alert('<fmt:message key="error.common.system"/>');
            }
        });
    });
    
    <%-- 찜하기 버튼 클릭 이벤트 --%>
    $(".btnAddWishProduct").click(function() {
        var sellPrdtBcode = $(this).parents("tr").find("input[name=primeSellPrdtBcode]").val();
        
        if($(this).hasClass("on")){
        	cart_removeWishProduct(sellPrdtBcode);
        }else{
        	cart_addWishProduct(sellPrdtBcode);
        }
        
    });
    
    <%-- 바로주문 버튼 클릭 이벤트 --%>
    $(".btnGoOrder").click(function() {
        var cartSeq = $(this).parents("tr").find("input[name=cartSeq]").val();
        var param = "cartSeqs=" + cartSeq;
        
        goOrder(param);
    });
    
    <%-- 선택상품 찜하기 버튼 클릭 이벤트 --%>
    $("#btnAddWishListCheckProduct").click(function() {
        var chkList = [];
        
        $("input[name='cartChk']").each(function() {
            if(this.checked) {
                chkList.push($(this).parent().parent().find("td input[name='primeSellPrdtBcode']").val());
            }
        });
        
        if($(chkList).length == 0) {
            alert("<fmt:message key='error.not.selected'/>");
        } else {
            addWishProductList(chkList);
        }
    });
    
    <%-- 선택상품 삭제 버튼 클릭 이벤트 --%>
    $("a#btnDeleteCartCheckProduct").click(function() {
        var param = getCheckCartSeqList();
        if(!isEmpty(param)) {
    
            if(!confirm("장바구니 상품을 삭제하시겠습니까?")) {
                return;
            }
            
            $.ajax({
                type: "POST"
                ,url: "/ht/order/removeCart"
                ,data: param
                ,dataType: "json"
                ,success : function(data){
                    if (data) {
                        if(data.save) {
                            alert("장바구니 상품이 삭제되었습니다.");
                            window.location.reload();
                        } else {
                            alert(data.save);
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
    });
    
    <%-- 선택상품 주문하기 버튼 클릭 이벤트 --%>
    $("a#btnGoOrderCheckCartProduct").click(function(){
        var param = getCheckCartSeqList();
        
        if(!isEmpty(param)) {
            goOrder(param);
        }
    });
    
    <%-- 전체상품 주문하기 버튼 클릭 이벤트 --%>
    $("a#btnGoOrderAllCartProduct").click(function(){
        $("input[name=cartChk]").prop("checked", true);
        
        var param = getCheckCartSeqList();
        
        if(!isEmpty(param)) {
            goOrder(param);
        }
    });
    
    $("input[type=checkbox]").prop("checked",true);
});

<%-- 체크된 장바구니 일련번호를 parameter 용으로 가공해서 반환 --%>
function getCheckCartSeqList() {
    var chkList = [];
    
    $("input[name='cartChk']").each(function() {
         if(this.checked) {
            chkList.push($(this).val());
        } 
    });
    
    if($(chkList).length == 0) {
        alert("<fmt:message key='error.not.selected'/>");
        return null;
    } else {
        var param = "cartSeqs=" + chkList.join("&cartSeqs=");
        return param;
    }
}

<%-- 주문하기(주문서) - param 은 'cartSeqs=10&cartSeqs=20' 형식 --%>
function goOrder(param) {
    $.ajax({
        type: "POST"
        ,url: "/ht/order/checkOrderSheetProduct"
        ,data: param
        ,dataType: "json"
        ,success : function(data){
            if (data) {
                if(data.save) {
                    window.location.href = sslHost + "/ht/order/orderGiftChoose";
                } else {
                    var errorMessages = data.errorMessages;
                    
                    alert(errorMessages.join("\n"));
                    
                    if(errorMessages[0].substring(0, 4) == "본인인증"){
                        //location.href = certUrl;
                    }
                }
            }
        }
        ,error: function(data) {
            alert('<fmt:message key="error.common.system"/>');
        }
    });
}

/* 개별 상품 찜하기 */
function cart_addWishProduct(barcode) {
    <c:if test='${!isLogin}'>
        needLogin();
        // location.href = '<ui:variable key="kyobo.server"/><ui:variable key="kyobo.login.uri"/>' + escape((document.location.href).substr(0,(document.location.href).indexOf('#')));
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
                	alert("좋아요 성공!\n마이핫트랙스에서 확인하실 수 있습니다.");
                	location.reload(true);
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

/* 상품 좋아요삭제*/
function cart_removeWishProduct(barcode) {
    <c:if test='${!isLogin}'>
        needLogin();
    </c:if>
    <c:if test='${isLogin}'>
        $.ajax({
            type: 'GET'
            ,url: '/ht/mypage/removeWishProduct'
            ,data: 'barcode=' + barcode
            ,dataType: 'json'
            ,success: function(data) {
                if(data.save != false) {
                	alert("좋아요 취소!\n마이핫트랙스에서 삭제되었습니다.");
                	location.reload(true);
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

/* Facebook Pixel Code */
fbq('track', 'InitiateCheckout');
/* End Facebook Pixel Code */

</script>

<!-- 전환페이지 설정 -->
 <script type="text/javascript" src="http://wcs.naver.net/wcslog.js"> </script> 
 <script type="text/javascript">
var _nasa={};
 _nasa["cnv"] = wcs.cnv('3','10'); // 전환유형, 전환가치 설정해야함. 설치매뉴얼 참고
</script>
</head>
<body>
<!-- sub top -->
<div class="title_a">
    <h2 class="title">장바구니</h2>
    <%--<div class="loc"><em class="active">홈</em><em class="active">장바구니</em></div>--%>
</div>
<!-- / sub top -->

<div class="mgt20 c_both">
    <ul class="list_type02_v2 fs14">
        <li>로그인 시 장바구니는 <strong class="normal">14일</strong> 동안 보관됩니다.
        <li>더 오래 보관하고 싶은 상품은 <strong class="">♡ </strong>버튼을 눌러주세요.</li>
        <li><strong class="">♡ </strong>상품은 '마이핫트랙스'에서 확인 가능합니다.</li>
        <li>쿠폰 적용 제외 상품은 쿠폰 적용이 되지 않습니다.</li>
    </ul>
</div>

<h2 class="hidden_obj">장바구니</h2>

<!-- 이벤트 배너 영역 -->
<c:import url="/ht/order/cartBanner"/>

<!-- <form id="productFrm"> -->
    <c:forEach items="${cartList}" var="cart">
        <h3 class="tit01_v2">${cart.dlvyVndrId eq '0625'?'핫트랙스':'업체개별'} 배송</h3>
        <table class="bbs_list_v2">
            <caption>${cart.dlvyVndrId eq '0625'?'핫트랙스':'업체개별'} 배송<span>선택, 상품코드, 상품, 상품명, 판매가, 수량, 가격, 통합포인트, 상품 처리 </span></caption>
            <colgroup>
                <col style="width:5%">
                <col style="width:10%">
                <col style="width:12%">
                <col style="width:27%">
                <col style="width:10%">                
                <col style="width:10%">
                <col style="width:10%">
                <col style="width:8%">
                <col style="width:8%">
            </colgroup>
            <thead>
                <tr>
                    <th scope="col" class="fir"><input type="checkbox" name="chkAll" value="cartChk${cart.dlvyVndrId}" title="${cart.dlvyVndrId eq '0625'?'핫트랙스 배송':'업체개별 배송'} 상품 전체 선택"/></th>
                    <th scope="col">상품코드</th>
                    <th scope="col">상품</th>
                    <th scope="col">상품명</th>
                    <th scope="col">판매가</th>
                    <th scope="col">수량</th>
                    <th scope="col">가격</th>
                    <th scope="col">통합포인트</th>
                    <th scope="col"><span class="hidden_obj">상품 처리</span></th>
                </tr>
            </thead>
            <tfoot>
                <tr>
                    <td colspan="9">
                        상품금액 <strong><fmt:formatNumber value="${cart.sellPriceSum}"/></strong>원 + 
                        배송비 <strong><fmt:formatNumber value="${cart.dlvyAmtResult}"/></strong>원 =
                        <strong class="point02"><fmt:formatNumber value="${cart.sellPriceSum + cart.dlvyAmtResult}"/></strong>원
                    </td>
                </tr>
            </tfoot>
            <tbody>
                <c:if test="${empty cart.cartProductList}">
                    <tr><td colspan="9" class="no">상품이 없습니다.</td></tr>
                </c:if>
                <c:forEach items="${cart.cartProductList}" var="product">
                    <tr>
                        <td><input type="checkbox" name="cartChk" value="${product.cartSeq}" class="cartChk${product.dlvyVndrId}" title="[${product.prdtName}] 상품 선택"/></td>
                        <td>
                            <input type="hidden" name="cartSeq" value="${product.cartSeq}"/>
                            <input type="hidden" name="sellPrdtBcode" value="${product.sellPrdtBcode}"/>
                            <input type="hidden" name="primeSellPrdtBcode" value="${product.primeSellPrdtBcode}"/>
                            <a class="fs12" href="/p/${product.primeSellPrdtBcode}">${product.primeSellPrdtBcode}</a>
                        </td>
                        <td>
                            <c:if test="${fn:contains('DR' ,product.sellPrdtGbn) }"><a href="/ht/record/detail/${product.primeSellPrdtBcode}"><ui:image rcrdCd="${product.rcrdCd}" prdtGbn="${product.sellPrdtGbn}" clazz="photo" size="100" alt="${product.prdtName}" ratingCode="${product.rtngCode }"/></a></c:if>
                            <c:if test="${!fn:contains('DR' ,product.sellPrdtGbn) }"><a href="/ht/product/detail?barcode=${product.primeSellPrdtBcode}"><ui:image src="${product.productImageUrl}" size="100" server="product" clazz="photo" alt="${product.prdtName}"/></a></c:if>
                        </td>
                        <td class="t_left">
                            ${product.prdtName} 
                            <c:if test="${!product.salablility}">
                                <span class="p_desc">[${product.simpleSaleStatus}]</span>
                            </c:if>
                            <c:if test="${product.sellPrdtGbn eq 'S'}"><p class="txt_option">${product.specName}</p></c:if>
                            <c:forEach items="${product.optnList}" var="optn" varStatus="optnStatus">
                                <p class="txt_option">${optn}</p>
                            </c:forEach>
                            <c:if test="${product.cvslPrdtYn eq 'true'}">
                                <p class="txt_option">${product.cvslPrice > 0?'유료각인':'무료각인'} : ${product.cvslFont} ${product.cvslCont} ( + <fmt:formatNumber value="${product.cvslPrice}" pattern="#,###"/>)</p>
                            </c:if>
                            <c:if test="${product.orderMakeYn eq 'true'}">
                                <p class="txt_option">기타정보 : ${product.orderMakeCont}</p>
                            </c:if>
                        </td>
                        <td><fmt:formatNumber value="${product.sellPrice}" pattern="#,###"/>원<BR>[<fmt:formatNumber value="${(product.prdtSellPrice-product.sellPrice)/product.prdtSellPrice * 100}" pattern="#,###"/>%↓]</td>
                        <td>
                            <c:choose>
                                <c:when test="${product.salablility}">
                                    <input type="text" class="input_txt t_center inputNumberText" value="${product.prdtCount}" name="prdtCount" style="ime-mode:disabled;width:25px;" maxlength="4" title="[${product.prdtName}] 주문 수량"/>
                                    <a href="javascript://" class="btn_type05_v2 btnChangePrdtCount">수정</a>
                                </c:when>
                                <c:otherwise>
                                    <input type="text" class=input_txt t_center value="${product.prdtCount}" name="prdtCount" maxlength="4" style="width:25px;" readonly="readonly" title="[${product.prdtName}] 주문수량"/>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td><fmt:formatNumber value="${product.sumSellPrice}" pattern="#,###"/>원</td>
                        <td>
                            <c:if test="${isLogin && userProperty.gradeId != '99'}"><fmt:formatNumber value="${product.sumSavedPrice}" pattern="#,###"/>원</c:if>
                            <c:if test="${!isLogin || userProperty.gradeId == '99'}">0원</c:if>
                        </td>
                        <td>
                            <span class="btn_wrap">
                                <c:if test="${product.salablility}">
                                    <a href="javascript://" class="btnAddWishProduct btn_blike mgt10 <c:if test="${product.wishYn != 0}">on</c:if>" title="좋아요">좋아요</a>
                                    <a href="javascript://" class="btnGoOrder btn_bgred">바로 주문</a>
                                </c:if>
                                <%--<a href="javascript://" class="btnDeleteCartProduct btn_brblack" onmousedown="javascript:AEC_F_D('${product.sellPrdtBcode}', 'o' ,${product.prdtCount});">삭제</a>--%>
                            </span>
                        </td>
                    </tr>
                    <c:if test="${!empty product.cartProductFreeGiftList || !empty product.cartProductSupplementList || !empty product.cartProductPosterCaseList}">
                        <tr> 
                            <td></td>
                            <td></td>
                            <td></td>
                            <td class="t_left">
                                <c:forEach items="${product.cartProductFreeGiftList}" var="productFreeGift">
                                    <p class="pt5">사은품 : ${productFreeGift.freeGiftName}</p>
                                </c:forEach>
                                <c:forEach items="${product.cartProductSupplementList}" var="productSupplement">
                                    <p class="pt5">부록 : ${productSupplement.suppName}</p>
                                </c:forEach>
                                <c:forEach items="${product.cartProductPosterCaseList}" var="productPosterCase">
                                    <p class="pt5">포스터 증정</p>
                                </c:forEach>
                            </td>
                            <td></td>
                            <td>
                                <c:forEach items="${product.cartProductFreeGiftList}" var="productFreeGift">
                                    <p class="pt5">${productFreeGift.prdtCount}개 </p>
                                </c:forEach>
                                <c:forEach items="${product.cartProductSupplementList}" var="productSupplement">
                                    <p class="pt5">${product.prdtCount}개 </p>
                                </c:forEach>
                                <c:forEach items="${product.cartProductPosterCaseList}" var="productPosterCase">
                                    <p class="pt5">${product.prdtCount}개 </p>
                                </c:forEach>
                            </td>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                    </c:if>
                </c:forEach>
                <c:if test="${!empty cart.cartProductFgiftList}">
                    <tr> 
                        <td></td>
                        <td></td>
                        <td></td>
                        <td class="t_left"><strong>주문사은품</strong> : 다음 페이지에서 사은품 선택</td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                </c:if>
                <c:if test="${!empty cart.cartProductFreeGiftList}">
                    <c:forEach items="${cart.cartProductFreeGiftList}" var="vndrFreeGift">
                        <tr> 
                            <td></td>
                            <td></td>
                            <td></td>
                            <td class="t_left"><strong>업체사은품</strong> : ${vndrFreeGift.freeGiftName}</td>
                            <td></td>
                            <td>${vndrFreeGift.prdtCount}개</td>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                    </c:forEach>
                </c:if>
            </tbody>
        </table>
    </c:forEach>
<!-- </form> -->

<!-- 장바구니 상품이 없을 때 -->
<c:if test="${empty cartList}">
	<h2 class="tit01_v2 normal pdt60 mgt20 fs20 bt_line t_center"><span>장바구니에 담은 상품이 없습니다.</span></h2>
	<div class="t_center mgt40">
		<a href="/" class="btn_360">계속 쇼핑하기</a>
	</div>
</c:if>

<c:if test="${not empty cartList}">
	<div class="order_sum">
		<h2 class="tit">주문 합계</h2>
	    <div class="top">
	        <p><span class="f_left">총 주문수량</span><span class="f_right c_black">${cartProductSum.sumOfProductClassCount}종 (${cartProductSum.sumOfOrderCount}개)</span></p>
	       	<p><span class="f_left">총 상품금액</span><span class="f_right c_black"><fmt:formatNumber value="${cartProductSum.totalPrdtAmt}"/>원</span></p>
	       	<p><span class="f_left">총 배송비</span><span class="f_right c_black"><fmt:formatNumber value="${cartProductSum.totalDlvyAmt}"/>원</span></p>
	    </div>
	    <div class="sum_price">
	        <p><span class="f_left">총 주문금액</span><span class="c_red f_right bold"><fmt:formatNumber value="${cartProductSum.totalOrderAmt}"/><span class="c_black fs14 normal">원</span></span></p>
	    </div>
	    <div class="sum_point">
	    	<p><span class="f_left">통합포인트 적립</span><span class="f_right c_black"><c:if test="${isLogin && userProperty.gradeId != '99'}"><fmt:formatNumber value="${cartProductSum.totalSavedPrice}"/></c:if><c:if test="${!isLogin || userProperty.gradeId == '99'}">0</c:if><span class="c_black">원</span></span></p> 
	    </div>
	</div>
	<div class="btn_area mgt40">
	    <span class="f_left">
	        <%--<a href="javascript://" id="btnAddWishListCheckProduct" class="btn_type03">선택상품 찜하기</a>--%>
	        <a href="javascript://" id="btnDeleteCartCheckProduct" class="btn_type04_v2 fs20">선택상품 삭제</a>
	    </span>
	    <span class="f_right">
	        <a href="/" class="btn_type04_v2 fs20">계속 쇼핑하기</a>
	        <a href="javascript://" id="btnGoOrderCheckCartProduct" class="btn_360 mgl10">주문하기</a>
	        <!-- <a href="javascript://" id="btnGoOrderAllCartProduct" class="btn_red50">주문하기</a> -->
	    </span>
	</div>
	
	<div class="pdt40 c_both">
	    <ul class="list_type02_v2 fs14">
	        <li>상품 배송비는 핫트랙스 배송, 업체개별 배송으로 구분되어 적용됩니다.</li>
	        <li>쿠폰 또는 통합포인트 사용 시 예상 적립 통합포인트가 변동될 수 있습니다.</li>
	    </ul>
	</div>
</c:if>

<!-- 레코벨 추천 리스트 -->
<c:if test="${not empty listRecobell}">
	<div class="recobell_cart swiper-container mgt80">
	    <c:if test="${empty cartList}"><h1 class="tit fs24">인기 베스트 추천 상품</h1></c:if>
    	<c:if test="${not empty cartList}"><h1 class="tit fs24">함께 구매하면 좋은 상품</h1></c:if>
	    <div class="swiper-wrapper">
	        <c:forEach items="${listRecobell}" varStatus="s1" step="5" end="14">
	            <ul id="recobell0${s1.count}" class="swiper-slide">
	                <c:forEach items="${listRecobell}" var="l" varStatus="st" begin="${s1.index}" end="${s1.index+4}">
	                    <li class="PC_RECO">
	                        <span class="img_a">
	                            <c:if test="${l.sellPrdtGbn eq 'R' || l.sellPrdtGbn eq 'D'}"><a href="/ht/record/detail/${l.sellPrdtBcode}?foo=bar&rccode=pc_cart1"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" ratingCode="A" rcrdImgType="large" width="${l.sellPrdtGbn eq 'R'?'150':'99'}" clazz="photo" alt="${fn:escapeXml(l.prdtName)}"/></a></c:if>
	                            <c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G' || l.sellPrdtGbn eq 'S'}"><a href="/ht/product/detail?barcode=${l.sellPrdtBcode}&foo=bar&rccode=pc_cart1"><ui:image src="${l.prdtImgUrl}" src2="${l.productImageUrl2}" size="200" server="product" clazz="photo" alt="${fn:escapeXml(l.prdtName)}"/></a></c:if>
	                        </span>
	                        <c:if test="${l.sellPrdtGbn eq 'R' || l.sellPrdtGbn eq 'D'}"><a href="/ht/record/detail/${l.sellPrdtBcode}?foo=bar&rccode=pc_cart1"></c:if>
	                        <c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G' || l.sellPrdtGbn eq 'S'}"><a href="/ht/product/detail?barcode=${l.sellPrdtBcode}&foo=bar&rccode=pc_cart1"></c:if>
	                            <span class="name txt_line1">${fn:escapeXml(l.prdtName)}</span>
	                            <em class="price">
	                            	 <c:if test="${l.basePrdtSellPrice ne l.lastCpnPrice}">
	                                    <c:if test="${l.prdtStatCode ne 'C0312'}"><span class="pc"><%--<img src="${imageServer}/images/renewal/common/ic_status_soldout.gif" alt="품절"/>--%></span></c:if>
	                                    <c:if test="${l.prdtStatCode eq 'C0312'}"><span class="pc"><fmt:formatNumber value="${hfn:rate(l.basePrdtSellPrice,l.lastCpnPrice)}" pattern=",###"/>%</span></c:if>
	                                </c:if>
	                                <span class="sale"><fmt:formatNumber type="number">${l.lastCpnPrice}</fmt:formatNumber></span>
	                                 <c:if test="${l.basePrdtSellPrice ne l.lastCpnPrice}">
	                                    <span class="dc"><fmt:formatNumber type="number">${l.basePrdtSellPrice}</fmt:formatNumber></span>
	                                </c:if>
	                            </em>
	                        </a>
	                    </li>
	                </c:forEach>
	            </ul>
	        </c:forEach>
	    </div>
	    <!-- Add Pagination -->
	    <div class="swiper-pagination"></div>
	    <!-- Add Arrows -->
	    <div class="swiper-button-area">
	    	<div class="swiper-button-next"></div>
	    	<div class="swiper-button-prev"></div>
	    </div>
	</div>
</c:if>
<!-- / 레코벨 추천 리스트 -->
  
<script> 
    var swiper = new Swiper('.swiper-container',{
        nextButton: '.swiper-button-next',
        prevButton: '.swiper-button-prev',
        pagination: '.swiper-pagination',
        paginationType: 'fraction'
    });
	
	$('.swiper-pagination-fraction').each(function() {
		var text = $(this).html();
		$(this).html(text.replace(' / ', ' '));
	});
</script>

<style>
.recobell_cart .tit {border:none;}
.recobell_cart ul li a em.price {font-family: font_gs, sans-serif; display: block;overflow:hidden;padding-top:15px;font-size: 14px;line-height: 20px;}
.recobell_cart ul li a em.price span.dc{color: #777;text-decoration: line-through;float: left; font-size:12px;}
.recobell_cart ul li a em.price span.sale{font-weight:bold;color: #000000;font-size: 14px;float: left;margin-right: 5px;}
.recobell_cart ul li a em.price span.pc{float: left;font-weight: bold;color: #da2128;font-size: 14px;margin-right: 5px;}
.recobell_cart.swiper-container .swiper-pagination {font-size:18px; line-height:20px;}
.recobell_cart.swiper-container .swiper-pagination span.swiper-pagination-current {font-family: font_gs, sans-serif; font-weight:bold; color: #000; margin-right: 8px;}
.recobell_cart.swiper-container .swiper-pagination span.swiper-pagination-total {font-family: font_gs, sans-serif; font-weight:normal; color: #777;}
.recobell_cart.swiper-container .swiper-button-area {position:absolute;width:232px;left:50%;margin-left:-116px;bottom:0;height:44px;}
.recobell_cart.swiper-container .swiper-button-next {position:absolute; width:44px; height:44px; background:url('https://simage.kyobobook.co.kr/newimages/giftshop_new/resources/img/common/icon_swiper_arr03.png') no-repeat; background-position:-88px 0; overflow:hidden; font-size:0; line-height:0px; text-indent:-9999px; opacity: 1;}
.recobell_cart.swiper-container .swiper-button-prev {position:absolute; width:44px; height:44px; background:url('https://simage.kyobobook.co.kr/newimages/giftshop_new/resources/img/common/icon_swiper_arr03.png') no-repeat; background-position:-44px 0; overflow:hidden; font-size:0; line-height:0px; text-indent:-9999px; opacity: 1;}
.recobell_cart.swiper-container .swiper-button-next.swiper-button-disabled {position:absolute; width:44px; height:44px; background-position:100% 0; overflow:hidden; font-size:0; line-height:0px; text-indent:-9999px; opacity: 1;}
.recobell_cart.swiper-container .swiper-button-prev.swiper-button-disabled {position:absolute; width:44px; height:44px; background-position:0 0; overflow:hidden; font-size:0; line-height:0px; text-indent:-9999px; opacity: 1;}
.recobell_cart.swiper-container .swiper-button-next, .swiper-button-prev {display: inline-flex;}
</style>

<form id="checkOrderProductForm" name="checkOrderProductForm" action="/ht/order/checkOrderSheetProduct"></form>

</body>
</html>