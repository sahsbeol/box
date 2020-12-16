<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
<style type="text/css">
</style>
<title>주문/배송조회 | 주문정보 | MY HOTTRACKS - HOTTRACKS</title>
<script type="javascript" src="http://<ui:pgurl service='pgweb'/>/js/DACOMEscrow_UTF8.js"></script>
<script type="text/javascript">

function orderSearch(i){
    location.href="/ht/mypage/orderDelivery?orderTermType="+i;
}

function escrowAgreement(orderNum) {
    var result = checkDacomESC("${lgdMid}", orderNum, '');
    if(result == "0000") {
        $.ajax({
            type: "POST"
            ,url: "/ht/mypage/changeEscrowAgreementGbn"
            ,data: {orderNum : orderNum}
            ,dataType: "json"
            ,success : function(data){
                window.location.reload();
            }
            ,error: function(data) {
                alert('<fmt:message key="error.common.system"/>');
            }
        });
    } else {
        alert("구매 확정 실패하였습니다.");
    }
}

function paramFactory(urlStr, barcode, orderNum, orderPrdtInseq, rcrdCd){
    var url = urlStr;
    url += "?barcode="+barcode+"&orderNum="+orderNum+"&orderPrdtInseq="+orderPrdtInseq+"&rcrdCd="+rcrdCd+"&pageCheck=98";
    return url;
}

function goReview(barcode, orderNum, orderPrdtInseq, rcrdCd){
    window.open(paramFactory("/ht/product/commentPopup4write", barcode, orderNum, orderPrdtInseq, rcrdCd), "", "width=500, height=600, scrollbars=no");
}

function doDeliveryComplete(deliveryId) {
	if(confirm("상품을 받으셨나요?\n상품을 받으신 고객만 수취확인 해주세요!")) {
		$.ajax({
		    type: "POST"
		    ,url: "/ht/mypage/doDeliveryComplete"
		    ,data: {deliveryId : deliveryId}
		    ,dataType: "json"
		    ,success : function(data){
		        window.location.reload();
		    }
		    ,error: function(data) {
		        alert('<fmt:message key="error.common.system"/>');
		    }
		});
    } else {
        return false;
    }
}

</script>
</head>
<body>
<!-- sub top -->
<div class="page_location">
    <h2 class="title"><img src="${imageServer}/images/renewal/common/tit_my_hottracks.gif" alt="My Hottracks"/></h2>
    <div class="loc"><a href="/" class="home">Home</a><em>MY HOTTRACKS</em></div>
</div>
<!-- //sub top -->

<c:import url="/menu/mypage/lnb"/>

<!-- sub contents -->
<div class="sub_contents">
    <h3 class="page_title mgt0"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/renewal/common/tit_order_delivery.gif" alt="주문/배송조회" /></h3>
    <ul class="list_type02 tit_desc">
        <li>최근 6개월간의 주문내역을 기본으로 보여드립니다.</li>
        <li>주문번호, 상품명을 클릭하시면 주문상세내역 및 배송현황을 확인하실 수 있습니다.</li>
        <li><B>상품준비 이전 단계까지만 주문 취소가 가능합니다.</B></li>
        <li>주문취소/변경은 <B>[My Hottracks>주문정보>주문취소/변경]</B>을 통해 가능합니다.</li>
        <li>상품평 작성에 대한 포인트 적립은 작성 후 익일 PM:11시가 지나야 적립됩니다.</li> 
        <li>구매후 3개월 이내에 상품후기를 작성하셔야 포인트 적립이 가능합니다.</li>
        <li>CD, DVD 관련 상품은 상품평을 작성하셔도 포인트 적립대상에서 제외입니다.</li>
    </ul>
    
    <c:if test="${not empty sellPrdtBcode}">
        <c:if test="${empty result || empty result.stInt1 }">
            <div class="list_type02 tit_desc"> 
                <span class="c_orange li18">※ 구매하지 않은 상품이거나 구매 후 3개월이 지난 상품</span>입니다. 상품을 구매하신 뒤 다시 상품평을 작성해주세요.</div>
        </c:if>
        <c:if test="${not empty result && result.stVar1 ne 'C0124' }">
            <div class="list_type02 tit_desc">
                <span class="c_orange li18">※ [ ${result.stVar2 } ]</span> 상품은 배송완료 상태인 경우에 상품평을 작성 하실 수 있습니다.
            </div>
        </c:if>
    </c:if>
    
    <div class="period_srch">
        <h4>조회기간</h4>
        <ul class="tab_btn02">
            <li <c:if test="${orderCriteria.orderTermType eq 0}"> class="active"</c:if>><a href="javascript://" onclick="orderSearch(0)">최근 6개월 주문</a></li>
            <li <c:if test="${orderCriteria.orderTermType eq 1}"> class="active"</c:if>><a href="javascript://" onclick="orderSearch(1)">6개월 이전 주문</a></li>
            <li <c:if test="${orderCriteria.orderTermType eq 2}"> class="active"</c:if>><a href="javascript://" onclick="orderSearch(2)">취소 주문 조회</a></li>
        </ul>
    </div>
    <c:if test="${orderCriteria.orderTermType eq 0 || orderCriteria.orderTermType eq 1}">
        <table class="bbs_list01">
            <caption>조회기간별 주문내역 <span>주문일, 주문번호, 주문상품, 주문금액, 주문상태</span>
            </caption>
            <colgroup>
                <col style="width:80px" />
                <col style="width:126px" />
                <col style="width:*" />
                <col style="width:100px" />
                <col style="width:100px" />
                <col style="width:110px" />
            </colgroup>
            <thead>
                <tr>
                    <th scope="col" class="fir">주문일</th>
                    <th scope="col">주문번호</th>
                    <th scope="col">주문상품</th>
                    <th scope="col">-</th>
                    <th scope="col">주문금액</th>
                    <th scope="col" class="last">주문상태</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${orderList}" var="l" varStatus="st">
                    <tr>
                        <td><fmt:formatDate value="${l.orderDatetime}" pattern="yyyy.MM.dd" var="chkdt"/>${chkdt}</td>
                        <td><a href="/ht/mypage/orderDeliveryDetail?orderNo=${l.orderNum }&orderTermType=${orderCriteria.orderTermType }">${l.orderNum}</a></td>
                        <td>
                            <a href="/ht/mypage/orderDeliveryDetail?orderNo=${l.orderNum }&orderTermType=${orderCriteria.orderTermType }" class="aprdtName">
                                <c:forEach items="${l.listChild}" var="prod" varStatus="sd">
                                    <div style="margin-top : ${sd.index ne 0 ? '17px': '0'};">
                                        <p class="prdtName">${prod.prdtName }</p>
                                        
                                        <c:set var="cntPos" value="0"/>
                                        <c:if test="${not empty prod.userNum}">
                                            <c:if test="${not empty prod.sendNo || (prod.reviewCnt eq 0 && prod.orderStatusCode eq 'C0124')}">
                                                <c:if test="${prod.orderStatusCode eq 'C0123' && prod.deliveryCompleteCheck eq 'Y'}">  <!-- 배송중일때 -->
                                                	<c:set var="cntPos" value="1"/>
                                                	<div class="btn_orange"><span onclick="javascript:doDeliveryComplete('${prod.deliveryId }'); return false;" class="btn btn_type01 bg_orange">수취확인</span></div>
                                                </c:if>
                                                <c:if test="${prod.reviewCnt eq 0 && prod.orderStatusCode eq 'C0124' && prod.ableReview ne '-1'}">  <!--  작성한 적이 없고, 배송완료이고, 작성 기한안에 있다면 -->
                                                	<c:set var="cntPos" value="1"/>
                                                	<div class="btn_orange"><span onclick="javascript:goReview('${prod.barcode }', '${prod.orderNum}', '${prod.orderPrdtInseq}','${prod.rcrdCd }'); return false;" class="btn_edit">상품평 쓰기</span></div>
                                                </c:if>
                                                <!-- 음반이면 버튼 없애기 / 기프트 인경우에만 (상품평 적립 완료, 혹은 상품평 쓰기 완료)-->
                                                <c:if test="${empty prod.rcrdCd }">
                                                    <c:if test="${prod.reviewCnt ne 0 && prod.orderStatusCode eq 'C0124' && prod.resultComment ne 1}"><!--  상품 후기완료 && 배송완료 && 적립 전  -->
                                                        <c:set var="cntPos" value="1"/>
                                                        <div class="btn_orange"><span onclick="return false;" class="btn_black">상품평 작성완료</span></div>
                                                    </c:if>
                                                    <c:if test="${prod.reviewCnt ne 0 && prod.orderStatusCode eq 'C0124' && prod.resultComment eq 1}"><!--  상품 후기완료 && 배송완료 && 적립 후  -->
                                                        <c:set var="cntPos" value="1"/>
                                                        <div class="btn_orange"><span onclick="return false;" class="btn_black">상품평 적립완료</span></div>
                                                    </c:if>
                                                </c:if>
                                            </c:if>
                                        </c:if>
                                        <c:if test="${cntPos eq 0}"><div class="btn_orange"></div></c:if>
                                        <c:if test="${not empty prod.kyoboSelectOptionStr }">
                                            <p class="txt2" style="${specStyle}">${prod.kyoboSelectOptionStr}</p></c:if>
                                        <c:if test="${not empty prod.specName }">
                                            <p class="specName" style="${specStyle}">└ ${prod.specName}
                                                <span class="price" style="font-weight: bold;">
                                                   (<fmt:formatNumber value="${prod.orderCount}" type="number"/>개)</span>
                                            </p>
                                        </c:if>
                                    </div>
                                </c:forEach>
                            </a>
                        </td> 
                        <td></td>
                        <td><fmt:formatNumber value="${l.orderPrdtAmt}" pattern="#,###"/>원</td>
                        <td>
                            <c:choose>
                                <c:when test="${l.orderStatusCode eq 'C0123'}"><span style="color:#ff0000;"><ui:code codeId="${l.orderStatusCode}"/></span></c:when>
                                <c:when test="${l.orderStatusCode eq 'C0124'}"><span style="color:#000000;"><ui:code codeId="${l.orderStatusCode}"/></span></c:when>
                                <c:otherwise><span><ui:code codeId="${l.orderStatusCode }" /></span></c:otherwise>
                            </c:choose>
                            <c:if test="${l.escrowYn eq 'true' && empty l.escrowAgreementGbn && (l.orderStatusCode eq 'C0123' || l.orderStatusCode eq 'C0124')}">
                                <br /><span class="btn_type02"><a href="javascript://" onclick="escrowAgreement('${l.orderNum}');">구매확정</a></span>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty orderList}"><tr><td colspan="5" class="no_data">주문내역이 없습니다.</td></tr></c:if>
            </tbody>
        </table>
    </c:if>
    <!--  최소 내역 -->
    <c:if test="${orderCriteria.orderTermType eq 2}">
        <table class="bbs_list01">
            <caption>조회기간별 주문내역 <span>주문일, 주문번호, 주문상품, 환불금액, 주문상태</span>
            </caption>
            <colgroup>
                <col style="width:80px" />
                <col style="width:126px" />
                <col style="width:*" />
                <col style="width:100px" />
                <col style="width:110px" />
            </colgroup>
            <thead>
                <tr>
                    <th scope="col" class="fir">주문일</th>
                    <th scope="col">주문번호</th>
                    <th scope="col">주문상품</th>
                    <th scope="col">환불금액</th>
                    <th scope="col" class="last">주문상태</th>
                </tr>
            </thead>
            <tbody> 
                <c:forEach items="${orderList}" var="l" varStatus="st">
                    <tr> 
                        <td><fmt:formatDate value="${l.orderDatetime}" pattern="yyyy.MM.dd" var="chkdt"/>${chkdt}</td>
                        <td><a href="/ht/mypage/orderDeliveryDetail?orderNo=${l.orderNum }&orderTermType=${orderCriteria.orderTermType }">${l.orderNum}</a></td>
                        <td class="t_left"><a href="/ht/mypage/orderDeliveryDetail?orderNo=${l.orderNum }&orderTermType=${orderCriteria.orderTermType }">${l.prdtName}<c:if test="${l.prdtClassCount ne '0' }"> 외 ${l.prdtClassCount}건</c:if></a></td> 
                        <td><fmt:formatNumber value="${l.orderPrdtAmt}" pattern="#,###"/>원
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${l.orderStatusCode eq 'C0123'}"><span style="color:#ff0000;"><ui:code codeId="${l.orderStatusCode}"/></span></c:when>
                                <c:when test="${l.orderStatusCode eq 'C0124'}"><span style="color:#000000;"><ui:code codeId="${l.orderStatusCode}"/></span></c:when>
                                <c:otherwise><span style="color:#DADADA"><ui:code codeId="${l.orderStatusCode }" /></span></c:otherwise>
                            </c:choose>
                            <c:if test="${l.escrowYn eq 'true' && empty l.escrowAgreementGbn && (l.orderStatusCode eq 'C0123' || l.orderStatusCode eq 'C0124')}">
                                <br /><span class="btn_type02"><a href="javascript://" onclick="escrowAgreement('${l.orderNum}');">구매확정</a></span>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty orderList}"><tr><td colspan="5" class="no_data">주문내역이 없습니다.</td></tr></c:if>
            </tbody>
        </table>
    </c:if>
    <!-- paging -->
    <div class="paging">
        <ui:pagination url="/ht/mypage/orderDelivery" name="pageHolder" pageParam="page" parameters="orderTermType, pageHolder"/>
    </div>
    <!-- //paging -->

    <h4 class="tit01">주문처리안내</h4>
    <ol class="step_list order_step">
        <li><strong>결제완료</strong> 결제내역 확인</li>
        <li><strong>상품준비</strong> 상품 출고지시</li>
        <li><strong>배송중</strong> 상품 출고완료</li>
        <li><strong>배송완료</strong> 상품고객수령</li>
    </ol>

</div>
<!-- //sub contents -->
</body>
</html>