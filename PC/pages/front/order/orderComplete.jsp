<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<head>
<script language="javascript" src="http://<ui:pgurl service='pgweb'/>/WEB_SERVER/js/receipt_link.js"></script>

<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-968575-10"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-968575-10');
</script>

<script>

// var result = [];

var result = [];
// var ss = recobellProductList.length;
// var ss1 = recobellProductList.size;
// alert(ss);
// alert(ss1);
// console.log('데이터:'+ss);
// console.log('데이터:'+ss1);
// for(var i=0; i<recobellProductList.length; i++){
	<c:forEach var="recobellProductList" items="${recobellProductList}">
		result.push({id:'${recobellProductList.sellPrdtBcode}', name:'${recobellProductList.prdtName}', brand:'${recobellProductList.dlvyVndrName}', category:'${recobellProductList.ctgrName}', quantity:'${recobellProductList.prdtCount}',price:'${recobellProductList.sellPrice}'});
	</c:forEach>
// }
// <c:forEach var="recobellProductList" items="${recobellProductList}">
// result.push({id:'${recobellProductList.sellPrdtBcode}', name:'${recobellProductList.prdtName}', brand:'${recobellProductList.dlvyVndrName}', quantity:'${recobellProductList.prdtCount}',price:'${recobellProductList.sellPrice}'});
// </c:forEach>
alert(result);
console.log('데이터:'+result);

// 	for(var i=0; i<product.length; i++){
// 		var item = {};
		
// 		item["id"] = product[i].sellPrdtBcode;
// 		item["name"] = product[i].prdtName;
// 		item["brand"] = product[i].dlvyVndrName;
// 		item["quantity"] = product[i].prdtCount;
// 		item["price"] = product[i].sellPrice;
// 		result.push(item);
// 	}

//   <c:forEach var="order" items="${recobellProductList}">
//   		result.push({id:'${order.sellPrdtBcode}', name:'${order.prdtName}', brand:'${order.dlvyVndrName}', quantity:'${order.prdtCount}',price:'${order.sellPrice}'});
//   		var json = new Object();
//   		json.id = "${order.sellPrdtBcode}";
//   		console.log(json.id);
//   		json.name = "${order.prdtName}";
//   		json.brand = "${order.dlvyVndrName}";
//   		json.quantity = "${order.prdtCount}";
//   		json.price = "${order.sellPrice}";
//   		result.push(json);
//   </c:forEach>
// var product_list = JSON.stringify(result);
//   console.log('값:'+product_list);
  //alert(result);
//   var itemList = [result];

   gtag('event', 'purchase', {
  	"transaction_id" : '${orderNum}',
  	"value": '${orderInfo.orderProductSum.totalPrdtAmt + orderInfo.orderProductSum.totalDlvyAmt}',
  	"items": result
  }); 
</script>


<!-- Facebook Pixel Code -->
<script>
!function(f,b,e,v,n,t,s){if(f.fbq)return;n=f.fbq=function(){n.callMethod?
n.callMethod.apply(n,arguments):n.queue.push(arguments)};if(!f._fbq)f._fbq=n;
n.push=n;n.loaded=!0;n.version='2.0';n.queue=[];t=b.createElement(e);t.async=!0;
t.src=v;s=b.getElementsByTagName(e)[0];s.parentNode.insertBefore(t,s)}(window,
document,'script','//connect.facebook.net/en_US/fbevents.js');

fbq('init', '2595348470556537');
fbq('track', "PageView");</script>
<noscript><img height="1" width="1" style="display:none" src="https://www.facebook.com/tr?id=1053245131399072&ev=PageView&noscript=1"/></noscript>
<!-- End Facebook Pixel Code -->

<!--  레코벨 스크립트 -->
<script type="text/javascript">
  window._eglqueue = window._eglqueue || [];
  /* STAR LOOP: 구매한 모든 상품에 대해 */
  <c:forEach var="product" items="${recobellProductList}">
  _eglqueue.push(['addVar', 'orderItems', {itemId:'${product.sellPrdtBcode}', price:'${product.sellPrice}', quantity:'${product.prdtCount}'}]);
  </c:forEach>
  /* END LOOP */
</script>

<script type="text/javascript">
  var _recoUserId = getCookie('UserCookieKey');
  
  window._eglqueue = window._eglqueue || [];
  _eglqueue.push(['setVar','cuid','e15e978e-3623-4892-bf0a-485b9f8196ee']);
  _eglqueue.push(['setVar','orderId','${orderNum}']);
  _eglqueue.push(['setVar','orderPrice','${orderInfo.orderProductSum.totalPrdtAmt + orderInfo.orderProductSum.totalDlvyAmt}']);
  _eglqueue.push(['setVar','userId',SHA256(_recoUserId)]); // optional
  _eglqueue.push(['track','order']);
  (function(s,x){s=document.createElement('script');s.type='text/javascript';
  s.async=true;s.defer=true;s.src=(('https:'==document.location.protocol)?'https':'http')+'://logger.eigene.io/js/logger.min.js';
  x=document.getElementsByTagName('script')[0];x.parentNode.insertBefore(s, x);})();
</script>
<!--  레코벨 스크립트 끝-->

<script type="text/javascript">
jQuery(function($){
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
	
	if(eval(today) <= '20191231'){
		$('#evnetBannerArea').show();
	}
	
});

officePopCheck();

// 거래명세서 출력
function specificationOnTransaction() {
	window.open('/ht/order/viewSpecificationOnTransaction?orderNo=${orderNum}','popupSpecificationOnTransaction','width=770,height=570');
}

function officePopCheck() {
	if ('${orderInfo.orderOfficeProductYn}' == 'Y') {
	    window.open('/ht/mypage/popupCoupon','officePopupCoupon','width=630,height=400');
	}
}
/* Facebook Pixel Code */
fbq('track', 'Purchase', {value: '${orderInfo.orderProductSum.totalPrdtAmt + orderInfo.orderProductSum.totalDlvyAmt}', currency: 'KRW'});
/* End Facebook Pixel Code */

// NICE 신용카드 전표 출력
function NicePrintReceipt(tid) {	
    var status = "toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=yes,width=420,height=540";
    var url = "https://npg.nicepay.co.kr/issue/IssueLoader.do?TID="+tid+"&type=0";
    window.open(url,"popupIssue",status);
}

//NICE 현금영수증 출력
function NicePrintCashReceipt(tid) {    
    var status = "toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=yes,width=420,height=540";
    var url = "https://npg.nicepay.co.kr/issue/IssueLoader.do?TID="+tid+"&type=1";
    window.open(url,"popupIssue",status);
}
</script>

<!-- 전환페이지 설정 -->
 <script type="text/javascript" src="http://wcs.naver.net/wcslog.js"> </script> 
 <script type="text/javascript">
var _nasa={};
 _nasa["cnv"] = wcs.cnv('1','${orderInfo.orderProductSum.totalPrdtAmt}'); // 전환유형, 전환가치 설정해야함. 설치매뉴얼 참고
</script> 


</head>
<body>
<fmt:formatDate value="${orderInfo.orderDatetime}" pattern="yyyy.MM.dd" var="chkdt"/>
<!-- sub top -->
<div class="page_location">
    <h2 class="title"><img src="${imageServer}/images/renewal/common/tit_my_hottracks.gif" alt="My Hottracks"/></h2>
    <div class="loc"><a href="/" class="home">Home</a><em>MY HOTTRACKS</em></div>
</div>
<!-- sub top -->
<div class="title_a">
    <h2 class="title">주문완료</h2>
</div>
<!-- / sub top -->

<div class="box_wrap">
    <div class="t_center bb_line" style="min-height:80px;">
        <p class="fs20 c_black mgt60"><strong>${orderInfo.buyerName}</strong> 회원님의 주문이 완료되었습니다.</p>
        <c:if test="${orderInfo.paymentInfo.pymntMeansCode eq 'C0117'}">
        	<p class="fs18 mgt30">주문일로부터 일주일까지 입금이 완료되면 배송이 진행됩니다.</p>
            <p class="fs18 mgt20 mgb60"><span>입금 계좌 : </span>${orderInfo.paymentInfo.lgdACCOUNTNAME}은행 <span class="c_blue">${orderInfo.paymentInfo.lgdACCOUNTNUM}</span><span class="mgl10">예금주 : 교보핫트랙스㈜</span></p>            
        </c:if>
        <c:if test="${orderInfo.paymentInfo.pymntMeansCode eq 'C011L'}">
        	<p class="fs18 mgt30">주문일로부터 일주일까지 입금이 완료되면 배송이 진행됩니다.</p>
            <p class="fs18 mgt20 mgb60"><span>입금 계좌 : </span>${orderInfo.paymentInfo.nicevBank}<span class="c_blue"> ${orderInfo.paymentInfo.nicevBankNum}</span><span class="mgl10">예금주 : 교보핫트랙스㈜</span></p>            
        </c:if>
        <c:import url="/ht/order/orderCompleteBanner"/>
    </div>
    
    <div>
	    <div class="title_box mgt40">
		    <h3 class="tit01_v2 f_left">주문번호 <span class="mgl30 order_num">${orderNum}</span></h3>
		    <a class="f_right" href="/ht/mypage/orderDelivery"><span class="btn_type01_v2">주문배송조회</span></a>
		</div>
	    
	    <div class="box_gray02 b_line pdt40 pdb40 t_center fs18">  
	        <c:set var="discountPrice" value="${orderInfo.paymentInfo.paymentAmtC0116 + orderInfo.paymentInfo.paymentAmtC0115 + orderInfo.paymentInfo.paymentAmtC0119 + orderInfo.paymentInfo.cpnDscntAmt + orderInfo.paymentInfo.gsAmt + orderInfo.paymentInfo.paymentAmtC011F +orderInfo.paymentInfo.paymentAmtC011C}"/>
			<span>총 상품금액 <strong><fmt:formatNumber pattern="#,###" value="${orderInfo.orderProductSum.totalPrdtAmt}"/></strong>원</span> + 
			<span>총 배송비 <strong><fmt:formatNumber pattern="#,###" value="${orderInfo.paymentInfo.dlvyAmt}"/></strong>원</span> - 
			<span>총 할인금액 <strong><fmt:formatNumber pattern="#,###" value="${discountPrice}"/></strong>원</span> = 
			<span>총 결제금액 <strong class="c_red"><fmt:formatNumber pattern="#,###" value="${orderInfo.paymentInfo.pymntAmt}"/></strong>원</span>
		</div>
	</div>
    
    <!-- 이벤트 배너 
    <div class="mgt20" id="evnetBannerArea" style="display: block;">
    	<a href="/ht/hot/eventDetail?eventId=63770&skip=Y">
    		<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/20190918_950x100.jpg" alt="ban_event">
    	</a>
    </div>-->
    
</div>

<h3 class="tit01_v2">배송지 정보</h3>
<table class="table02_v1">
    <caption>배송지 정보 상세</caption>
    <colgroup>
        <col style="width:15%" />
        <col style="width:35%" />
        <col style="width:15%" />
        <col style="width:*" />
    </colgroup>
    <tbody>
        <c:forEach var="orderDestination" items="${orderInfo.orderDestinationList}">
            <tr> 
                <th scope="row">이름</th> 
                <td class="fs14 c_black">${orderDestination.receiverName}</td>
                <th scope="row">이메일</th> 
                <td class="fs14 c_black">${orderDestination.receiverEmail}</td>  
            </tr> 
            <tr>
            	<th scope="row">휴대폰</th>
                <td class="fs14 c_black">${orderDestination.receiverHandPhone}</td>  
                <th scope="row">전화번호</th> 
                <td class="fs14 c_black">${orderDestination.receiverTelePhone}</td> 
            </tr>  
            <tr> 
                <th scope="row">주소</th> 
                <td colspan="3" class="fs14 c_black">
                    <c:if test="${!empty orderDestination.receiverPostNum}">
                        ${fn:substring(orderDestination.receiverPostNum,0,3)}-${fn:substring(orderDestination.receiverPostNum, 3,6)}<br />
                    </c:if> 
                    <div class="w01">${orderDestination.receiverAddress} ${orderDestination.receiverDetailAddress}</div>
                </td>
            </tr> 
            <tr> 
                <th scope="row">주문 요청사항</th> 
                <td colspan="3" class="fs14 c_black"><div class="w01">${orderDestination.orderMessage}</div></td>
            </tr>
            <tr> 
                <th scope="row">배송 요청사항</th> 
                <td colspan="3" class="fs14 c_black"><div class="w01">${orderDestination.deliveryMessage}</div></td>
            </tr>
        </c:forEach> 
    </tbody>
</table>

<h3 class="tit01_v2 f_left">결제 정보</h3>
<table class="table02_v1">
    <caption>결제 정보 상세</caption>
    <colgroup>
        <col style="width:15%" />
        <col style="width:35%" />
        <col style="width:15%" />
        <col style="width:*" />
    </colgroup>
    <tbody>
        <tr>
            <th>총 결제금액</th>
            <td colspan="3" class="fs18 c_black"><strong class="c_red"><fmt:formatNumber value="${orderInfo.orderProductSum.totalPrdtAmt + orderInfo.paymentInfo.dlvyAmt}" pattern="#,###"/></strong>원</td>
        </tr>
        <tr>
        	<th>통합포인트 적립</th>
            <td colspan="3" class="c_black"><strong class=""><fmt:formatNumber pattern="#,###" value="${orderInfo.paymentInfo.savedPrice}"/></strong>원<span class="fs14 mgl30 c_black">· 통합포인트는 주문 상품 출고 완료 후 적립됩니다.</span></td>
        </tr>
        <tr>
            <th rowspan="2">결제 상세</th>
            <td colspan="3">
                <div class="payment_list">
                    <p class="c_black fs14">상품금액 : <fmt:formatNumber pattern="#,###" value="${orderInfo.orderProductSum.totalPrdtAmt}"/>원</p>
                    <p class="mgt10 c_black fs14">배송비 : <fmt:formatNumber pattern="#,###" value="${orderInfo.paymentInfo.dlvyAmt}"/>원</p>
                    <p class="p_lineh mgt5 c_black fs14">할인금액 : 
                    <c:if test="${orderInfo.paymentInfo.paymentAmtC0116 ne '0' }"><span>교보핫트랙스 온라인 예치금 <fmt:formatNumber pattern="#,###" value="${orderInfo.paymentInfo.paymentAmtC0116}"/>원</span></c:if>
                    <c:if test="${orderInfo.paymentInfo.paymentAmtC0115 ne '0' }"><span>마일리지 <fmt:formatNumber pattern="#,###" value="${orderInfo.paymentInfo.paymentAmtC0115}"/>원</span></c:if>
                    <c:if test="${orderInfo.paymentInfo.paymentAmtC0119 ne '0' }"><span>통합포인트 <fmt:formatNumber pattern="#,###" value="${orderInfo.paymentInfo.paymentAmtC0119}"/>원</span></c:if>
                    <c:if test="${orderInfo.paymentInfo.cpnDscntAmt ne '0' }"><span>쿠폰 <fmt:formatNumber pattern="#,###" value="${orderInfo.paymentInfo.cpnDscntAmt}"/>원</span></c:if>
                    <c:if test="${orderInfo.paymentInfo.gsAmt ne '0' }"><span>GS&amp;POINT <fmt:formatNumber pattern="#,###" value="${orderInfo.paymentInfo.gsAmt}"/>원</span></c:if>
                    <c:if test="${orderInfo.paymentInfo.paymentAmtC011F ne '0' }"><span>L.POINT <fmt:formatNumber pattern="#,###" value="${orderInfo.paymentInfo.paymentAmtC011F}"/>원</span></c:if>
                    <c:if test="${orderInfo.paymentInfo.paymentAmtC011C ne '0' }"><span>OK캐쉬백 <fmt:formatNumber pattern="#,###" value="${orderInfo.paymentInfo.paymentAmtC011C}"/>원</span></c:if>
                    </p>
                </div>
            </td>
        </tr>
        <tr>
            <td colspan="3" class="c_black fs14">
            <div class="p_lineh">
                <p>결제금액 : <fmt:formatNumber pattern="#,###" value="${orderInfo.paymentInfo.pymntAmt}"/>원
                <c:if test="${   orderInfo.paymentInfo.pymntMeansCode eq 'C0111' 
                              || orderInfo.paymentInfo.pymntMeansCode eq 'C0112' 
                              || orderInfo.paymentInfo.pymntMeansCode eq 'C0113' 
                              || orderInfo.paymentInfo.pymntMeansCode eq 'C0114' 
                              || orderInfo.paymentInfo.pymntMeansCode eq 'C0117' 
                              || orderInfo.paymentInfo.pymntMeansCode eq 'C011D'
                              || orderInfo.paymentInfo.pymntMeansCode eq 'C011J'
                              || orderInfo.paymentInfo.pymntMeansCode eq 'C011K'
                              || orderInfo.paymentInfo.pymntMeansCode eq 'C011L'
                              || orderInfo.paymentInfo.pymntMeansCode eq 'C011M'
                              || orderInfo.paymentInfo.pymntMeansCode eq 'C011N'}">
                <span> - <ui:code codeId="${orderInfo.paymentInfo.pymntMeansCode}"/> </span>
                </c:if>
                <c:choose>
                    <c:when test="${orderInfo.paymentInfo.pymntMeansCode eq 'C0111'}">
                        <span>( <ui:creditCardCode codeId="${orderInfo.paymentInfo.paymentCodeId}"/>카드 / <c:if test="${orderInfo.paymentInfo.itrstFreeYn eq 'true'}">무이자 </c:if><c:if test="${orderInfo.paymentInfo.mitpCount > 0}">${orderInfo.paymentInfo.mitpCount}개월 할부</c:if><c:if test="${orderInfo.paymentInfo.mitpCount == 0}">일시불</c:if> )</span>
                    </c:when>
                    <c:when test="${orderInfo.paymentInfo.pymntMeansCode eq 'C0112'}">
                        <span>( <ui:bankCode codeId="${orderInfo.paymentInfo.transferCodeId}"/>은행 )</span>
                    </c:when>
                    <c:when test="${orderInfo.paymentInfo.pymntMeansCode eq 'C0113'}">
                        <span>( ${orderInfo.paymentInfo.lgupPymntHdphnNum} )</span>
                    </c:when>
                    <c:when test="${orderInfo.paymentInfo.pymntMeansCode eq 'C0117'}">
                        <span>( ${orderInfo.paymentInfo.lgdACCOUNTNAME}은행 &nbsp; ${orderInfo.paymentInfo.lgdACCOUNTNUM} &nbsp; 예금주 : 교보핫트랙스㈜ )<br/>주문일로부터 일주일까지 입금이 안 될 경우 주문이 자동으로 취소됩니다.</span>
                    </c:when>
                    <c:when test="${orderInfo.paymentInfo.pymntMeansCode eq 'C011J' || orderInfo.paymentInfo.pymntMeansCode eq 'C011M' || orderInfo.paymentInfo.pymntMeansCode eq 'C011N'}">
                        <span>( ${orderInfo.paymentInfo.niceCardNm}/<c:if test="${orderInfo.paymentInfo.niceCardqyota != '00'}">${orderInfo.paymentInfo.niceCardqyota}개월 할부</c:if><c:if test="${orderInfo.paymentInfo.niceCardqyota == '00'}">일시불</c:if> )</span>
                    </c:when>
                    <c:when test="${orderInfo.paymentInfo.pymntMeansCode eq 'C011K'}">
                        <span>( <ui:bankCode codeId="${orderInfo.paymentInfo.niceBank}"/> )</span>
                    </c:when>
                    <c:when test="${orderInfo.paymentInfo.pymntMeansCode eq 'C011L'}">
                        <span>( ${orderInfo.paymentInfo.nicevBank} &nbsp; ${orderInfo.paymentInfo.nicevBankNum} &nbsp; 예금주 : 교보핫트랙스㈜ )<br/>주문일로부터 일주일까지 입금이 안 될 경우 주문이 자동으로 취소됩니다.</span>
                    </c:when>
                </c:choose>
                </p>
                </div>
                <c:choose>
                    <c:when test="${orderInfo.paymentInfo.pymntMeansCode eq 'C0111'}">
                        <a href="javascript:showReceiptByTID('${lgdMid}', '${orderInfo.paymentInfo.lgupDealNum}', '${orderInfo.paymentInfo.lgupChprDealNum}')" class="btn_type05_v2 mgt10">신용카드 전표출력</a>
                    </c:when>
                    <c:when test="${orderInfo.paymentInfo.pymntMeansCode eq 'C0112'}">
                        <a href="javascript:showCashReceipts('${lgdMid}','${orderNum}', '0', 'BANK', '${cstPlatform}')" class="btn_type05_v2 mgt10">현금영수증 출력</a>
                    </c:when>
                    <c:when test="${orderInfo.paymentInfo.pymntMeansCode eq 'C011J'}">
                        <a href="javascript:NicePrintReceipt('${orderInfo.paymentInfo.lgupDealNum}')" class="btn_type05_v2 mgt10">신용카드 전표출력</a>
                    </c:when>
                    <c:when test="${orderInfo.paymentInfo.pymntMeansCode eq 'C011K'}">
                        <a href="javascript:NicePrintCashReceipt('${orderInfo.paymentInfo.niceBankTID}')" class="btn_type05_v2 mgt10">현금영수증 출력</a>
                    </c:when>
                </c:choose>
                <c:choose>
                    <c:when test="${(orderInfo.paymentInfo.pymntAmt + orderInfo.paymentInfo.paymentAmtC0115 + orderInfo.paymentInfo.paymentAmtC0116) > 0 && !(orderInfo.paymentInfo.pymntMeansCode eq 'C0117' || orderInfo.paymentInfo.pymntMeansCode eq 'C011L')}">
                        <a href="javascript:specificationOnTransaction();" class="btn_type05_v2 mgt10">거래명세서 출력</a>
                    </c:when>
                </c:choose>
            </td>
        </tr>
        <tr>
            <th>결제 일시</th>
            <td colspan="3" class="c_black fs14"><fmt:formatDate value="${orderInfo.paymentInfo.pymntDtm}" pattern="yyyy.MM.dd HH:mm:ss"/></td>
        </tr>
    </tbody>
</table>

<ul class="list_type02_v2 mgt10">
  <li>주문하신 내역은 '마이핫트랙스 &#62; 주문/배송조회' 메뉴에서 확인하실 수 있습니다.</li>
  <li>주문 후 취소 및 변경, 반품, 교환 요청사항은 '마이핫트랙스'에서 접수 가능합니다.</li>
  <li>현금영수증, 세금계산서, 신용카드 매출전표 등 증빙 서류는 주문 완료 후 '마이핫트랙스 &#62; 주문정보' 메뉴에서 발급 가능합니다.</li>
</ul>

<div class="btn_area t_center mgt50">
    <a href="/" class="btn_360">계속 쇼핑하기</a>
    <%--<a href="/ht/mypage/mypageMain" class="btn_type03">마이핫트랙스</a>--%>
</div>



<div id="order"></div>
<%--
<!-- 링크프라이스 전송 처리 -->
${linkprice_tag}
<!-- 링크프라이스 전송 처리 끝-->
--%>

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
foinCpa_amount ='${orderInfo.orderProductSum.totalPrdtAmt + orderInfo.orderProductSum.totalDlvyAmt}';
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