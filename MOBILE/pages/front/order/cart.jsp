<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn"%>
<html>
<head>
<script type="text/javascript" src="/js/jquery.form.js"></script>
<script type='text/javascript' src='//logger.eigene.io/js/logger.min.js'></script>
<script type="text/javascript" src="/js/mOrder.js"></script>
<script type="text/javascript">
jQuery(function($) {
	$(document).ready(function(){
        $('#subTitle').html('장바구니');
	    $('#wrap').addClass('content_new'); // 신규 GNB,FOOTER
	});
	
	// 전체 삭제
    $('.chk_wrap_all').click(function (){
        if($('.chk_wrap_all').hasClass("active") == false){
            $('.chk_wrap_all').addClass("active");
            $("input[name='cartChk']").attr("checked", true);
            $("span.chk_wrap").addClass('active');
        }else{
            $('.chk_wrap_all').removeClass("active");
            $("input[name='cartChk']").attr("checked", false);
            $("span.chk_wrap").removeClass('active');
        }
        
    });
	
    $('.chk_wrap').click(function (){
        if ($(this).find('input[name=cartChk]').attr('checked')){
            $(this).find('input[name=cartChk]').removeAttr('checked');
            $('.chk_wrap_all').removeClass('active');
            $(this).removeClass('active');
        } else {
            $(this).find('input[name=cartChk]').attr('checked',true);
            $(this).addClass('active');
        }
    });
    
    $(".btnUpPrdtCount").click(function() {
    	var cartSeq = $(this).parent().parent().parent().parent().parent().find("div input[name='cartSeq']").val();
        var prdtCount = $(this).parent().find("input[name='prdtCount']").val();
        var sellPrdtBcode = $(this).parent().parent().parent().parent().parent().find("div input[name='sellPrdtBcode']").val();
        
        $(this).parent().find("input[name='prdtCount']").val(parseInt(prdtCount) + 1);
    });
    
    $(".btnDownPrdtCount").click(function() {
        var cartSeq = $(this).parent().parent().parent().parent().parent().find("div input[name='cartSeq']").val();
        var prdtCount = $(this).parent().find("input[name='prdtCount']").val();
        var sellPrdtBcode = $(this).parent().parent().parent().parent().parent().find("div input[name='sellPrdtBcode']").val();
        
        if (parseInt(prdtCount) < 1) {
        	$(this).parent().find("input[name='prdtCount']").val(0);
        } else {
        	$(this).parent().find("input[name='prdtCount']").val(parseInt(prdtCount) - 1);
        }
    });
    
    $(".btnChangePrdtCount").click(function() {
    	var cartSeq = $(this).parents(".roundbox").find("input[name='cartSeq']").val();
        var prdtCount = $(this).parents(".roundbox").find("input[name='prdtCount']").val();
        var sellPrdtBcode = $(this).parents(".roundbox").find("input[name='sellPrdtBcode']").val();
        
        var param = "cartSeq=" + cartSeq;
        param += "&prdtCount=" + prdtCount;
        param += "&sellPrdtBcode=" + sellPrdtBcode;
        
        if (prdtCount == 0 || prdtCount == "" || prdtCount < 0) {
        	alert("수량이 잘못 되었습니다.");
        	return;
        }
        
        $.ajax({
            type: "POST"
            ,url: "/m/order/changeCartPrdtCount"
            ,data: param
            ,dataType: "json"
            ,success : function(data){
                if (data) {
                    if(data.save) {
                    	alert('수량이 변경되었습니다.');
                    } else {
                        var errorMessages = data.errorMessages;
                        alert(errorMessages.join("\n"));
                    }
                    $('#loading').show();
                    window.location.reload();
                }
            }
            ,error: function(data) {
                alert('<fmt:message key="error.common.system"/>');
                $('#loading').show();
                window.location.reload();
            }
        });
        
    });
    
    
    
    <%-- 삭제 버튼 클릭 이벤트--%>
    $(".btnDeleteCartProduct").click(function(e) {
    	e.preventDefault();
    	
        if(!confirm("장바구니 상품을 삭제하시겠습니까?")) {
            return;
        }
        
        var cartSeq = $(this).parent().parent().find("div input[name='cartSeq']").val();

        var param = "cartSeqs=" + cartSeq;
        
        $.ajax({
            type: "POST"
            ,url: "/m/order/removeCart"
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
    });
    
    <%-- 선택 삭제 버튼 클릭 이벤트--%>
    $(".btnDeleteCartCheckProduct").click(function(e) {
    	e.preventDefault();
        var param = getCheckCartSeqList();

        if(!isEmpty(param)) {
            if(!confirm("장바구니 상품을 삭제하시겠습니까?")) {
                return;
            }
            
            $.ajax({
                type: "POST"
                ,url: "/m/order/removeCart"
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
    
    <%-- 선택 주문 버튼 클릭 이벤트--%>
    $(".btnGoOrderCheckCartProduct").click(function(e) {
    	e.preventDefault();
        var param = getCheckCartSeqList();
        
        if(!isEmpty(param)) {
            goOrder(param);
        }
    });
    
    <%-- 전체 주문 버튼 클릭 이벤트--%>
    $(".btnGoOrderAllCartProduct").click(function(e) {
    	e.preventDefault();
        $("input[name='cartChk']").attr("checked", true);
        var param = getCheckCartSeqList();
        
        if(!isEmpty(param)) {
            goOrder(param);
        }
    });
    
    <%-- 바로주문 버튼 클릭 이벤트 --%>
    $(".btnGoOrder").click(function(e) {
    	e.preventDefault();
        var cartSeq = $(this).parent().parent().find("div input[name='cartSeq']").val();
        var param = "cartSeqs=" + cartSeq;
        
        goOrder(param);
    });   
});

<%-- 체크된 장바구니 일련번호를 parameter 용으로 가공해서 반환 --%>
function getCheckCartSeqList() {
    var chkList = [];
    
    $("input[name='cartChk']").each(function() {
        if(this.checked ||  $(this).attr("checked") =="checked") {
            chkList.push($(this).val());
        }
    });
    
    //return false;
    
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
        ,url: "/m/order/checkOrderSheetProduct"
        ,data: param
        ,dataType: "json"
        ,success : function(data){
            if (data) {
                if(data.save) {
//                    window.location.href = sslHost + "/m/order/orderSheet";
                    window.location.href = "https://m.hottracks.co.kr/m/order/orderSheet";
//                    window.location.href = "http://devm.hottracks.co.kr/m/order/orderSheet";
                } else {
                    var errorMessages = data.errorMessages;
                    
                    alert(errorMessages.join("\n"));
                    
                    if(errorMessages[0].substring(0, 4) == "본인인증"){
                        location.href = certUrl;
                    }
                }
            }
        }
        ,error: function(data) {
            alert('<fmt:message key="error.common.system"/>');
        }
    });
}
//maxlength 체크
function maxLengthCheck(object){
	if (object.value.length > object.maxLength) {
		object.value = object.value.slice(0, object.maxLength);
	}
}
</script>

<style>

/* 레코벨 상품 추천 */
.content_new #content {
    margin-top: 61px;
    padding: 0;
    min-height: auto;
}

.pbest_list {
    position: relative;
    background-color: #fff;
    padding: 10px 0 20px 20px;
    margin-bottom: 180px;
    overflow: hidden;
}
.pbest_list .box_cont .box_prod {
	margin: 10px 10px 20px 0;
}
.pbest_list .pagination {
    height: 1px;
    width: 100%;
    padding: 0px;
    margin-top: 10px;
}
.pbest_list .swiper-container .swiper-scrollbar {
    width:100%; right:0; bottom:0; opacity:1 !important; border-radius:0; height:1px; background-color:#dbdbdb;
}
.pbest_list .swiper-container .swiper-scrollbar-drag {
    background-color:#ff6a5b; border-radius:0;
}
</style>

<!-- 전환페이지 설정 -->
<script type="text/javascript" src="//wcs.naver.net/wcslog.js"></script> 
<script type="text/javascript"> 
var _nasa={};
_nasa["cnv"] = wcs.cnv('3','1'); // 전환유형, 전환가치 설정해야함. 설치매뉴얼 참고
</script> 

</head>
<body>
	<div class="w_top_v2 lineb_da">
		<h2 class="tit_h2">장바구니 ${cartProductSum.sumOfProductClassCount}종 (${cartProductSum.sumOfOrderCount}개)</h2>
		<p>로그인 시 장바구니는 <span class="col_black">14일</span> 동안 보관됩니다.
		<br/>쿠폰 적용 제외 상품은 쿠폰 적용이 되지 않습니다.</p>
	</div>
	
	<%-- <c:import url="/pages/front/order/cart_eventBanner.jsp" charEncoding="utf-8"/> --%>
	<c:import url="/m/order/cartBanner"/>
	
	<!-- 이벤트 배너 영역 -->
	<c:if test="${not empty cartList}">
	
	<!-- 무료배송 배너-->
	<div class="pt10 bg_f5f6f1">
		<a class="wd100" href="/m/biz/hot/best?dispMstrId=FREE_DELIVERY_BEST">
			<img style="width:100%;" class="MB_CART_1" src="http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/bnr_freedelivery_cart.png" alt="무료배송">
		</a>
	</div>
	
	<!-- 오늘의 추천 배너-->
	<!-- 
	<div class="pt10 bg_f5f6f1">
		<a href="/m/biz/personal/personalRecommend" class="wd100">
			<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/bnr_02.jpg" style="width:100%;" alt="ban_event" class="MB_TODAY_CART">
		</a>
	</div> 
	-->
	
	<div class="cartlist">
	
	<!-- 전체선택 선택삭제 -->
	<%--<div class="Selection_a mt10">
		<span class="chk_wrap_all active"> <input type="checkbox" name="cartChkAll" title="전체 상품 선택" /><label for="cartAll">전체삭제</label> </span><span class="fl_r"><a href="#n" class="btn_s br_777 mtm3 btnDeleteCartCheckProduct">선택삭제</a></span>
	</div>--%>	
	<!-- / 전체선택 선택삭제 -->
	</c:if>
	
	<c:forEach items="${cartList}" var="l" varStatus="st">
		<h3 class="mt30 f16">
			${l.dlvyVndrName}
			<c:if test="${st.index eq 0 }">
				<span class="chk_wrap_all active"> <input type="checkbox" name="cartChkAll" title="전체 상품 선택" /><label for="cartAll">전체선택</label> </span>
			</c:if>
		</h3>
		<!-- 상품 -->
		<c:forEach items="${l.cartProductList}" var="product">
			<div class="roundbox mt10">
				<div class="p_name">
					<input type="hidden" name="cartSeq" value="${product.cartSeq}" /> <input type="hidden" name="sellPrdtBcode" value="${product.sellPrdtBcode}" /> <input type="hidden" name="primeSellPrdtBcode" value="${product.primeSellPrdtBcode}" /> <span class="chk_wrap active"> <input type="checkbox" name="cartChk" value="${product.cartSeq}" class="cartChk${product.dlvyVndrId}" title="[${product.prdtName}] 상품 선택" checked="checked" /><label for="cart1"></label></span>
					<a href="/p/${product.primeSellPrdtBcode}">
						<span class="thumb"> <c:if test="${fn:contains('DR' ,product.sellPrdtGbn) }">
								<ui:image rcrdCd="${product.rcrdCd}" prdtGbn="${product.sellPrdtGbn}" width="${product.sellPrdtGbn eq 'R'?'100':'66'}" alt="${product.prdtName}" ratingCode="${product.rtngCode }" />
							</c:if> <c:if test="${!fn:contains('DR' ,product.sellPrdtGbn) }">
								<ui:image src="${product.productImageUrl}" server="product" size="100" alt="${product.prdtName}" />
							</c:if>
						</span>
						<div class="name">
							<strong>${product.prdtName}</strong>
							<c:if test="${!product.salablility}">
								<span>[${product.simpleSaleStatus}]</span>
							</c:if>
							<c:if test="${product.sellPrdtGbn eq 'S'}">
								<span>${product.specName}</span>
							</c:if>
							<c:forEach items="${product.optnList}" var="optn" varStatus="optnStatus">
								<span>${optn}</span>
							</c:forEach>
							<c:if test="${product.cvslPrdtYn eq 'true'}">
								<span>${product.cvslPrice > 0?'유료각인':'무료각인'} : ${product.cvslFont} ${product.cvslCont} ( + <fmt:formatNumber value="${product.cvslPrice}" pattern="#,###" />)</span>
							</c:if>
							<c:if test="${product.orderMakeYn eq 'true'}">
								<span>기타정보 : ${product.orderMakeCont}</span>
							</c:if>
							<c:if test="${!empty product.cartProductFreeGiftList}">
								<c:forEach items="${product.cartProductFreeGiftList}" var="productFreeGift">
                                    <span>사은품 : ${productFreeGift.freeGiftName}</span>
                                </c:forEach>
							</c:if>
						</div>
					</a>
				</div>
				<ul class="br_list">
                    <li>
                        <strong class="fl_l f_normal col_grey">판매가</strong>
                        <span class="fl_r"><span class="col_black"><fmt:formatNumber value="${product.sellPrice}" pattern="#,###"/>원 [<fmt:formatNumber value="${(product.prdtSellPrice-product.sellPrice)/product.prdtSellPrice * 100}" pattern="#,###"/>%]</span></span>
                    </li>
					<li>
						<strong class="fl_l f_normal col_grey">수량</strong>
						<span class="fl_r">
						<c:choose>
								<c:when test="${product.salablility}">
									<span class="count">
										<button type="button" title="1개씩 감소" class="down btnDownPrdtCount btnChangePrdtCount">감소</button>
										<input type="number" value="${product.prdtCount}" name="prdtCount" maxlength="4" oninput="maxLengthCheck(this)" title="[${product.prdtName}] 주문 수량" style="width: 28px; height: 23px; border:1px solid #ccc; text-align: center; font-size: 14px; color: #000;"/>
										<button type="button" title="1개씩 증가" class="up btnUpPrdtCount btnChangePrdtCount">증가</button>
										<a href="javascript://" class="bt_sbrg1 ml10 btnChangePrdtCount">수정</a></span>
								</c:when>
								<c:otherwise>
									<input type="text" class="i_input t_center" value="${product.prdtCount}" name="prdtCount" maxlength="4" oninput="maxLengthCheck(this)" style="width: 25px;" readonly="readonly" title="[${product.prdtName}] 주문수량" />
								</c:otherwise>
						</c:choose>
						</span>
					</li>
                    <li>
                        <strong class="fl_l f_normal col_grey">총금액</strong>
                        <span class="fl_r f_bold"><fmt:formatNumber value="${product.sumSellPrice}" pattern="#,###"/><span class="f_normal">원</span></span>
                    </li>
				</ul>
				<div class="box_flex mt20">
					<a href="javascript://" class="btn_mbrg btnDeleteCartProduct">삭제</a>
					<a href="javascript://" class="bt_mbgb ml10 btnGoOrder">바로주문</a>
				</div>
			</div>
		</c:forEach>
		<div class="delivery_fee">
			상품금액 <strong class="col_black"><fmt:formatNumber value="${l.sellPriceSum}" /></strong>원 + 배송비 <strong class="col_black"><fmt:formatNumber value="${l.dlvyAmtResult}" /></strong>원 = <strong class="col_red"><fmt:formatNumber value="${l.sellPriceSum + l.dlvyAmtResult}" /></strong>원
			<!-- 무료배송 조건값 노출 -->
			<%--<p>
				<c:if test="${l.dlvyAmtResult ne 0}">
					<fmt:formatNumber value="${l.dlvyLevyStdAmt}" pattern=",###" />원 이상 무료배송
			    </c:if>
			</p>--%>
		</div>
		<!-- / 상품 -->
	</c:forEach>
	
	<!-- 장바구니 상품이 없을 때 -->
	<c:if test="${empty cartList}">
		<div class="bg_f5f6f1">
		<h2 class="tit_h2 pt40 t_c f_normal">장바구니에 담은 상품이 없습니다.</h2>
		<div class="btn_area box_flex pt40 pb40">
			<a href="/" class="bt_bbgb">계속 쇼핑하기</a>
		</div>
		</div>
	</c:if>
	
	<c:if test="${not empty cartList}">
	<!-- 총 결제금액 -->
	<div class="order_fee mt30">
		<ul>
			<li><span class="fl_l">총 주문수량</span> <span class="fl_r col_black">${cartProductSum.sumOfProductClassCount}종 (${cartProductSum.sumOfOrderCount}개)</span>
			</li>
			<li><span class="fl_l">총 상품금액</span> <span class="fl_r col_black"><fmt:formatNumber type="number" value="${cartProductSum.totalPrdtAmt}" />원</span>
			</li>
			<li><span class="fl_l">총 배송비</span> <span class="fl_r col_black"><fmt:formatNumber type="number" value="${cartProductSum.totalDlvyAmt}" />원</span>
			</li>
			<li class="amount"><span class="fl_l mb10">총 주문금액</span><span class="fl_r col_red f_bold"><fmt:formatNumber type="number" value="${cartProductSum.totalOrderAmt}" /><span class="f14 f_normal">원</span></strong>
			</li>
			<li class="mb0">
				<span class="fl_l">통합포인트 적립</span><span class="fl_r col_black"><c:if test="${isLogin && userProperty.userGradeId != '99'}"><fmt:formatNumber value="${cartProductSum.totalSavedPrice}" /></c:if><c:if test="${!isLogin || userProperty.userGradeId == '99'}">0</c:if><span class="f14 col_black">원</span></span>
			</li>
			<%--<li>
        		<p class="col_grey mt5">할인금액 등으로 예상 적립 통합포인트가 변동될 수 있습니다.</p>
        	</li>--%>
		</ul>
	</div>
	<!-- / 총 결제금액 -->

    <div class="box_flex mt30 mb30">
    	<a href="#n" class="bt_bbrb btnDeleteCartCheckProduct">선택삭제</a>
		<a href="#n" class="bt_bbgb ml10 btnGoOrderCheckCartProduct">주문하기</a>
		<!--<a href="#n" class="btn btn_black btnGoOrderAllCartProduct">전체주문</a>-->
	</div>
	</c:if>
	
	</div>
    
    <!-- 레코벨 상품 추천 -->
    <fmt:parseNumber var="recobellLength" integerOnly="true" value="${fn:length(listRecobell)/3}" />
    <c:if test="${recobellLength >= 1}">
    <section class="pbest_list">
    	<c:if test="${empty cartList}"><h2 style="padding: 20px 10px 0 0;" class="f20">인기 베스트 추천 상품</h2></c:if>
    	<c:if test="${not empty cartList}"><h2 style="padding: 20px 10px 0 0;" class="f20">함께 구매하면 좋은 상품</h2></c:if>
        <div class="swiper-container">
            <div class="swiper-wrapper">
	            <%-- <c:forEach begin="0" end="14" varStatus="s0" step="3"> --%>
	            <c:forEach begin="0" end="${(recobellLength*3) >= 15 ? 14 : (recobellLength*3)-1}" varStatus="s0" step="3">
	                <div class="swiper-slide">
	                    <div class="box_cont">
	                        <div class="row">
	                            <c:forEach items="${listRecobell}" var="l" begin="${s0.index}" end="${s0.index+2}">
	                                <a href="#" onclick="location.href='/p/${l.sellPrdtBcode}?foo=bar&rccode=mo_cart1';return false;" class="box_prod row_item">
	                                    <c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G'}"><p class="pic"><ui:image src="${l.productImageUrl}" server="product" alt="${fn:escapeXml(l.prdtName)}"/></p></c:if>
	                                    <c:if test="${l.sellPrdtGbn eq 'R'}"><p class="pic"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="R" ratingCode="A" alt="${fn:escapeXml(l.prdtName)}"/></p></c:if>
	                                    <c:if test="${l.sellPrdtGbn eq 'D'}"><p class="pic dvd"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="D" ratingCode="A" alt="${fn:escapeXml(l.prdtName)}"/></p></c:if>
	                                    <p class="tit">${l.prdtName}</p>
	                                    <p class="price">
	                                        <fmt:formatNumber type="number">${l.lastCpnPrice}</fmt:formatNumber>원
	                                        <fmt:parseNumber var="rate" type="number" value="${hfn:rate(l.prdtSellPrice,l.lastCpnPrice)}"/>
	                                        <fmt:parseNumber var="rate" type="number" value="${rate+(1-(rate%1))%1}" integerOnly="true"/>
	                                        <c:if test="${rate > 0}"><span class="sale">[${rate}%]</span></c:if>
	                                    </p>
	                                </a>
	                            </c:forEach>
	                        </div>
	                    </div>
	                </div>
	            </c:forEach>
            </div>
            <!-- 스크롤바 -->
        	<div class="swiper-scrollbar"></div>
        </div>
    </section>
    </c:if>
    <!-- / 레코벨 상품 추천  -->
	<script>
	  var swiper = new Swiper('.pbest_list .swiper-container', {
          slidesPerView: 'auto',
          speed: 1000,
          freeMode: true,
          scrollbar: '.pbest_list .swiper-scrollbar',
          draggable: true
      });        
	</script>
	
</body>  
</html>