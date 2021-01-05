<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn"%>
<html>
<head>

<style type="text/css">
#content {
    padding: 0px;
}
.br_484848{
    height: 31px;
    line-height: 31px;
    padding: 0 22px;
}
</style>
<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-968575-10"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-968575-10');
</script>

<script>
var result = [];
	<c:forEach var="recobellProductList" items="${recobellProductList}">
		result.push({id:'${recobellProductList.sellPrdtBcode}', name:'${recobellProductList.prdtName}', brand:'${recobellProductList.dlvyVndrName}', category:'${recobellProductList.ctgrName}', quantity:'${recobellProductList.prdtCount}',price:'${recobellProductList.sellPrice}'});
	</c:forEach>

   gtag('event', 'purchase', {
  	"transaction_id" : '${orderNum}',
  	"value": '${orderInfo.orderProductSum.totalPrdtAmt + orderInfo.orderProductSum.totalDlvyAmt}',
  	"items": result
  }); 
</script>
<script type="text/javascript">
jQuery(function($){
	$(document).ready(function(){
        $('#subTitle').html('주문완료');
	    $('#wrap').addClass('content_new'); // 신규 GNB,FOOTER
	});
	
	var date = new Date();
	
	var yy = date.getFullYear();
	var mm = date.getMonth()+1;
	var dd = date.getDate();
	
	if((mm+"").length < 2){
		mm = "0"+mm;
	}
	
	if((dd+"").length < 2){
		dd = "0"+dd;
	}
	
	today = yy+''+mm+''+dd;
	
	if(eval(today) <= '20190930'){
		$('#evnetBannerArea').show();
	}
	
	//$("body").addClass("bg_gray");
});

</script>

<!-- 레코벨 스크립트 -->
<script type="text/javascript">
	window._eglqueue = window._eglqueue || [];
	/* STAR LOOP: 구매한 모든 상품에 대해 */
	<c:forEach items="${recobellProductList}" var="l" varStatus="st">
		_eglqueue.push(['addVar', 'orderItems', {itemId:'${l.sellPrdtBcode}', price:'${l.sellPrice}', quantity:'${l.prdtCount}'}]);
	</c:forEach>
	/* END LOOP */
</script>

<script type="text/javascript">
	var userId= getCookie("UserCookieKey");

	window._eglqueue = window._eglqueue || [];
	_eglqueue.push(['setVar','cuid','e15e978e-3623-4892-bf0a-485b9f8196ee']);
	_eglqueue.push(['setVar','orderId','${orderNum}']);
	_eglqueue.push(['setVar','orderPrice','${orderInfo.paymentInfo.pymntamt}']);
	_eglqueue.push(['setVar','userId',SHA256(userId)]); // optional
	_eglqueue.push(['track','order']);
	(function(s,x){s=document.createElement('script');s.type='text/javascript';
	s.async=true;s.defer=true;s.src=(('https:'==document.location.protocol)?'https':'http')+'://logger.eigene.io/js/logger.min.js';
	x=document.getElementsByTagName('script')[0];x.parentNode.insertBefore(s, x);})();
</script>
<!-- 레코벨 스크립트 끝 -->

<!-- 전환페이지 설정 -->
<script type="text/javascript" src="//wcs.naver.net/wcslog.js"></script> 
<script type="text/javascript"> 
var _nasa={};
_nasa["cnv"] = wcs.cnv('1','${orderInfo.paymentInfo.pymntamt}'); // 전환유형, 전환가치 설정해야함. 설치매뉴얼 참고
</script> 

</head>
<body>
	<fmt:formatDate value="${orderInfo.orderDtm}" pattern="yyyy.MM.dd" var="chkdt" />

	<div class="w_top_v2 lineb_da">
		<h2 class="tit_h2">주문완료</h2>
	</div>
	<div class="cartlist">
	<div class="cong_msg pd10">
		<p>
			<strong class="tit col_red">감사합니다.</strong>
		</p>
		<p class="line mt5">
			<strong class="col_black">${orderInfo.buyerName}</strong> 회원님의 주문이 완료되었습니다.
		</p>
		주문번호 : <span class="col_black">${orderNum}</span>
	</div>

    <c:import url="/m/order/orderCompleteBanner"/>

	<c:if test="${orderInfo.paymentInfo.pymntMeansCode eq 'C0117'}">
	<div class="roundbox bg_white f14">
		<ul class="t_c line16">
			<li>회원님의 주문은 <strong class="col_black">입금 대기중</strong>입니다.</li>
			<li>${orderInfo.paymentInfo.lgdACCOUNTNAME}은행 계좌번호 <span class="col_blue">${orderInfo.paymentInfo.lgdACCOUNTNUM}</span></li>
			<li>예금주 : 교보핫트랙스㈜</li>
		</ul>
	</div>
	
	<dl class="mt30 mb30">
		<dt>
			<h3 class="f16">꼭 알아두기</h3>
		</dt>
		<dd class="mt10">무통장으로 주문 완료 시 안내되는 계좌는 1회용 계좌입니다. 해당 계좌로 입금 시 주문이 진행됩니다.</dd>
		<dd><span class="col_red">총 결제금액 ${orderInfo.paymentInfo.paymentAmtC0117}원이 입금되어야 본 주문이 최종 완료됩니다.</span></dd>
		<dd>7일 이내 입금이 되지 않을 경우 주문이 자동 취소됩니다.</dd>
	</dl>
	</c:if>
		
	<c:if test="${orderInfo.paymentInfo.pymntMeansCode eq 'C011L'}">
	<div class="roundbox bg_white f14">
	    <ul class="t_c line16">
	        <li>회원님의 주문은 <strong class="col_black">입금 대기중</strong> 입니다.</li>
	        <li>${orderInfo.paymentInfo.nicevBank} 계좌번호 <span class="col_blue">${orderInfo.paymentInfo.nicevBankNum}</span></li>
	        <li>예금주 : 교보핫트랙스㈜</li>
	    </ul>
	</div>
	
	<dl class="mt30 mb30">
		<dt>
			<h3 class="f16">꼭 알아두기</h3>
		</dt>
		<dd class="mt10">무통장으로 주문 완료 시 안내되는 계좌는 1회용 계좌입니다. 해당 계좌로 입금 시 주문이 진행됩니다.</dd>
	    <dd><span class="col_red">총 결제금액 ${orderInfo.paymentInfo.paymentAmtC011L}원이 입금되어야 본 주문이 최종 완료됩니다.</span></dd>
	    <dd>7일 이내 입금이 되지 않을 경우 주문이 자동 취소됩니다.</dd>
	</dl>
	</c:if>
	
	<div class="box_flex mt30 mb30">
		<a href="/m/mypage/main" class="bt_bbrb">마이핫트랙스</a>
		<a href="/" class="ml10 bt_bbgb">계속 쇼핑하기</a>
	</div>
	</div>

	<div class="wd100" id="evnetBannerArea">
	    <a class="wd100" href="/m/biz/personal/personalRecommend">
	        <img class="wd100" src="http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/bnr_02.jpg" alt="쿠폰이벤트">
	    </a>
	</div>
	
<!-- SK Planet 구매 정보 전달 스크립트 -->
<script>
var prdtIdList = '';
var prdtNmList = '';
var orderCnt = 0;

/* 데이터분류명(보고서의 구분명. 한글은 최대 15자까지 가능) */
foinCpa_datakind ="OK캐쉬백연동-매출";
/* 주문번호 */
foinCpa_order_id ='${orderNum}';

/* STAR LOOP: 구매한 모든 상품에 대해 */
<c:set var="comma" value=","/>
<c:forEach var="product" items="${recobellProductList}" varStatus="status">
	<c:if test="${!status.last}">
		prdtIdList += '${product.sellPrdtBcode}';
		prdtNmList += '${product.prdtName}';
		prdtIdList += '${comma}';
		prdtNmList += '${comma}';
	</c:if>  
	<c:if test="${status.last}">
		prdtIdList += '${product.sellPrdtBcode}';
		prdtNmList += '${product.prdtName}';
	</c:if>
	orderCnt += ${product.prdtCount};
</c:forEach>
/* END LOOP */

/* 상품번호 */
foinCpa_product_id = prdtIdList;
/* 상품명 */
foinCpa_product_name = prdtNmList;
/* 주문수량 */
foinCpa_order_cnt = orderCnt;
/* 구매액 */
foinCpa_amount ='${orderInfo.paymentInfo.pymntamt}';
/* 유효 세션 여부 */
foinCpa_session_yn ="Y";
/* 데이터 분류 */
foinCpa_type ="구매";
/* 매체에서 넘어온 후 구매 유효기간 */
foinCpa_term = 3*24*3600*1000;
/* OCB ID */
foinCpa_media_gid = "";
</script> 

<script src="//js.ad4989.co.kr/common/js/mojise/buy.js"></script>
<!--/ SK Planet 구매 정보 전달 스크립트 -->	
</body>
</html>