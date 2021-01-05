<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<html>
<head>
<script type="text/javascript" src="/js/jquery.form.js"></script>
<script type="text/javascript">
jQuery(function($){
    $("#wrap").addClass("mypage_v2");
    $("#locDelivery").addClass("active");
    
    <%-- 선택 삭제 버튼 클릭 이벤트--%>
    $(".btnCancelOrder").click(function() {
    	if(!confirm("주문 취소 하시겠습니까?")) {
            return;
        }
    	
        $.ajax({
            type: "POST"
            ,url: "/m/mypage/cancelOrderForAll"
            ,data: {orderNum : ${order.orderNum}}
            ,dataType: "json"
            ,success : function(data){
                if (data) {
                    if(data.save) {
                        alert("주문이 취소되었습니다.");
                        //window.location.reload();
                        location.href = "${defaultHost}/m/mypage/orderDelivery";
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
    });
    
    $(".btn_tacbae").click(function(e){
        e.preventDefault();
        
        src = $(this).attr("href");
        if(window.HybridApp != undefined && window.HybridApp.popup != undefined){
            window.HybridApp.popup(src);
        }else{
            $("#tacbaeLayer").find("iframe").attr("src", src);
            $("#tacbaeLayer").show();
            
            $("#wrap").css({position:"fixed"});
        }
    });
});

function closeTacbae(){
    $("#tacbaeLayer").hide();
    $("#tacbaeLayer").find("iframe").attr("src", "about:Tabs");
    $("#wrap").css({position:"initial"});
}
</script>
</head>
<div class="w_top">
    <h2 class="tit_type1">주문/배송 내역</h2>
    <p class="">모바일로 확인되지 않는 정보는 PC버전에서 확인해주시기 바랍니다.<BR>
    <B>상품준비 이전 단계까지만 주문 취소가 가능합니다.</B><BR>
상품준비 이전 단계에서의 부분취소는 [1:1문의]를 이용하시거나 고객센터로 연락주시기 바랍니다.</p>
</div>

<h2 class="tit_type1">※주문번호 <span class="col_orange">${order.orderNum}</span></h2>


<div class="roundbox mt20 order_inquiry">
    <strong class="order_num">주문자 정보</strong>
    <ul class="br_list">
        <li class="br_none">
            <strong class="fl_l">주문하시는 분</strong>
            <span class="fl_r">${order.buyerName}</span>
        </li>
        <li>
            <strong class="fl_l">주문접수</strong>
            <span class="fl_r"><fmt:formatDate value="${order.orderDtm}" pattern="yyyy.MM.dd"/></span>
        </li>
<!-- 
        <li>
            <strong class="fl_l">전화번호</strong>
            <span class="fl_r">${order.buyerTelNum}/${order.buyerHdphnNum}</span>
        </li>
 -->
        <li>
            <strong class="fl_l">주문상태</strong>
            <span class="fl_r"><ui:code codeId="${order.orderStatusCode}"/></span>
        </li>
    </ul>
</div>


<div class="roundbox order_inquiry">
    <strong class="order_num">배송 정보</strong>
    <ul class="br_list">
        <li class="br_none">
            <strong class="fl_l">받으실 분</strong>
            <span class="fl_r">${dest.rcvrName}</span>
        </li>
        <li>
            <strong class="fl_l">받으실 분<br >주소</strong>
            <span class="fl_r">
                <span class="name">[<ui:mask pattern="###-###">${dest.rcvrPostNum}</ui:mask>]</span>
                <span class="name">${dest.rcvrAddr}</span>
                <span class="name">${dest.rcvrDtlAddr}</span>
            </span>
        </li>
        <li>
            <strong class="fl_l">전화번호</strong>
            <span class="fl_r">${dest.rcvrTelNum}</span>
        </li>
        <li>
            <strong class="fl_l">핸드폰번호</strong>
            <span class="fl_r">${dest.rcvrHdphnNum}</span>
        </li>
    </ul>
</div>

<c:set var="totOrderCnt" value="0"/>
<c:set var="totOrderPrdtCnt" value="0"/>
<c:set var="totOrderAmt" value="0"/>
<c:set var="totSavedAmt" value="0"/>
<c:forEach items="${orderList}" var="l" varStatus="st">
    <c:set var="totOrderCnt" value="${totOrderCnt + 1}"/>
    <c:set var="totOrderPrdtCnt" value="${totOrderPrdtCnt + l.orderCount - l.cancCount}"/>
    <c:set var="totOrderAmt" value="${totOrderAmt + (l.orderCount - l.cancCount)*l.snglPrdtSellPrice}"/>
    <c:set var="totSavedAmt" value="${totSavedAmt + l.savedPrice}"/>
    
    <div class="roundbox order_inquiry">
        <strong class="order_num">주문상품 정보</strong>
        <ul class="br_list">
            <li class="br_none">
                <strong class="fl_l">상품명</strong>
                <span class="fl_r">
                    <span class="name"><a href="/p/${l.sellPrdtBcode}">${l.prdtName}<br/>
                    ${l.specName}
                    </a></span>
                </span>
            </li>
            <li>
                <strong class="fl_l">수량</strong>
                <span class="fl_r"><fmt:formatNumber type="number">${l.orderCount - l.cancCount}</fmt:formatNumber>개</span>
            </li>
            <li>
                <strong class="fl_l">판매가</strong>
                <span class="fl_r"><span class="col_orange"><fmt:formatNumber type="number">${(l.orderCount - l.cancCount)*l.snglPrdtSellPrice}</fmt:formatNumber></span>원</span>
            </li>
            <li>
                <strong class="fl_l">판매자</strong>
                <span class="fl_r">${l.dlvyVndrName}</span>
            </li>
<!--
            <li>
                <strong class="fl_l">쿠폰사용금액</strong>
                <span class="fl_r"><fmt:formatNumber type="number">${l.couponPrice}</fmt:formatNumber>원</span>
            </li>
 -->
            <li>
                <strong class="fl_l">주문상태</strong>
                <span class="fl_r">
                    <ui:code codeId="${l.orderStatus}"/>
                    <!-- 배송 대기 상태에서는 추적하기 버튼이 안보이게 함 -->
                        <c:choose>
                            <c:when test="${l.orderStatus eq 'C0121' || l.orderStatus eq 'C0122'}"></c:when>
                            <c:otherwise>
                                <a href="${l.tcbUrl}${l.sendNo}" class="detail_view btn_tacbae" style="position:relative;top:0;right:0"><span>배송추적</span></a>
                            </c:otherwise>
                    </c:choose>
                </span>
            </li>
        </ul>
        <a href="/m/help/main" class="detail_view"><span>고객센터</span></a>
    </div>
</c:forEach>

<c:if test="${not empty freeGiftList.freeGiftList || not empty freeGiftList.supplementList || not empty freeGiftList.fgiftList || not empty freeGiftList.posterCaseList }" >
    <div class="roundbox order_inquiry">
        <ul class="br_list">
            <c:if test="${not empty freeGiftList.freeGiftList }">
                <li class="br_none">
                    <strong class="fl_l">사은품</strong>
                    <span class="fl_r">
                        <c:forEach items="${freeGiftList.freeGiftList}" var="freeGift">
                            <span class="name">${freeGift}</span>
                        </c:forEach>
                    </span>
                </li>
            </c:if>
            <c:if test="${not empty freeGiftList.fgiftList}">
                <li class="br_none">
                    <strong class="fl_l">주문사은품</strong>
                    <span class="fl_r">
                        <c:forEach items="${freeGiftList.fgiftList}" var="fgift">
                            <span class="name">${fgift.title}</span>
                        </c:forEach>
                    </span>
                </li>
            </c:if>
            <c:if test="${not empty freeGiftList.supplementList}">
                <li class="br_none">
                    <strong class="fl_l">부록</strong>
                    <span class="fl_r">
                        <c:forEach items="${freeGiftList.supplementList}" var="supplement">
                            <span class="name">${supplement.title}</span>
                        </c:forEach>
                    </span>
                </li>
            </c:if>
            <c:if test="${not empty freeGiftList.posterCaseList }">
                <li class="br_none">
                    <strong class="fl_l">포스터케이스증정</strong>
                </li>
            </c:if>
        </ul>
    </div>
</c:if>

<c:forEach items="${cancelList}" var="l" varStatus="st">
    <c:set var="totOrderCnt" value="${totOrderCnt + 1}"/>
    <c:set var="totOrderPrdtCnt" value="${totOrderPrdtCnt + l.orderCount - l.cancCount}"/>
    <c:set var="totOrderAmt" value="${totOrderAmt + (l.orderCount - l.cancCount)*l.snglPrdtSellPrice}"/>
    <c:set var="totSavedAmt" value="${totSavedAmt + l.savedPrice}"/>
    
    <div class="roundbox order_inquiry">
        <strong class="order_num">주문취소상품 정보</strong>
        <ul class="br_list">
            <li class="br_none">
                <strong class="fl_l">상품명</strong>
                <span class="fl_r">
                    <span class="name">${l.prdtName}</span>
                </span>
            </li>
            <li>
                <strong class="fl_l">수량</strong>
                <span class="fl_r"><fmt:formatNumber type="number">${l.dlvyCount}</fmt:formatNumber>개</span>
            </li>
            <li>
                <strong class="fl_l">판매가</strong>
                <span class="fl_r"><span class="col_orange"><fmt:formatNumber type="number">${l.dlvyCount*l.snglPrdtSellPrice}</fmt:formatNumber></span>원</span>
            </li>
            <li>
                <strong class="fl_l">판매자</strong>
                <span class="fl_r">${l.dlvyVndrName}</span>
            </li>
            <li>
                <strong class="fl_l">쿠폰사용금액</strong>
                <span class="fl_r">0원</span>
            </li>
            <li>
                <strong class="fl_l">취소상태</strong>
                <span class="fl_r"><ui:code codeId="${l.dlvyStatusCode}"/></span>
            </li>
            <li>
                <strong class="fl_l">처리상태</strong>
                <span class="fl_r"><ui:code codeId="${l.rtnStatusCode}"/></span>
            </li>
        </ul>
    </div>
</c:forEach>

<div class="order_price">
    <ul class="br_list">
        <li>
            <strong class="fl_l">주문상품 합계 :</strong>
            <span class="fl_r"><fmt:formatNumber type="number">${totOrderCnt}</fmt:formatNumber>종 <fmt:formatNumber type="number">${totOrderPrdtCnt}</fmt:formatNumber>개</span>
        </li>
        <li>
            <strong class="fl_l">주문총액 :</strong>
            <span class="fl_r"><span class="col_orange"><fmt:formatNumber type="number">${totOrderAmt}</fmt:formatNumber>원</span></span>
        </li>
    </ul>   
</div>

<h2 class="tit_type1">※결제정보</h2>

<c:set var="orderAmt">${pymnt.pymntAmt + pymnt.paymentAmtC0116 + pymnt.paymentAmtC0115 + pymnt.cpnDscntAmt + pymnt.paymentAmtC0118 + pymnt.paymentAmtC0119  + pymnt.paymentAmtC011B + pymnt.paymentAmtC011C + pymnt.paymentAmtC011F - pymnt.dlvyAmt}</c:set>
<c:set var="dscntAmt">${pymnt.cpnDscntAmt+pymnt.paymentAmtC0119+pymnt.paymentAmtC0115+pymnt.paymentAmtC0116+pymnt.paymentAmtC0118+pymnt.paymentAmtC011B+pymnt.paymentAmtC011C+pymnt.paymentAmtC011F}</c:set>
<div class="roundbox order_inquiry">
    <strong class="order_num">주문내용</strong>
    <ul class="br_list">
        <li class="br_none">
            <strong class="fl_l">상품총금액</strong>
            <span class="fl_r"><fmt:formatNumber value="${orderAmt}" pattern="#,###"/>원</span>
        </li>
        <li>
            <strong class="fl_l">배송비</strong>
            <span class="fl_r"><fmt:formatNumber value="${pymnt.dlvyAmt}" pattern="#,###"/>원</span>
        </li>
        <li>
            <strong class="fl_l">주문합계</strong>
            <span class="fl_r"><fmt:formatNumber value="${orderAmt + pymnt.dlvyAmt}" pattern="#,###"/>원</span>
        </li>
        <li class="info_type">
            <strong class="col_black">통합포인트 적립 예정액은 총 <span class="col_orange"><fmt:formatNumber type="number">${totSavedAmt}</fmt:formatNumber>원</span> 입니다.</strong>
            <p class="mt5">쿠폰 또는 통합포인트 상용 시 예상적립 통합포인트는 변동될 수 있습니다.</p>
        </li>
    </ul>
</div>

<div class="roundbox order_inquiry">
    <strong class="order_num">할인내용</strong>
    <ul class="br_list">
        <li class="br_none">
            <strong class="fl_l">할인쿠폰</strong>
            <span class="fl_r"><fmt:formatNumber type="number">${pymnt.cpnDscntAmt}</fmt:formatNumber>원</span>
        </li>
        <li>
            <strong class="fl_l">통합포인트</strong>
            <span class="fl_r"><fmt:formatNumber type="number">${pymnt.paymentAmtC0119}</fmt:formatNumber>원</span>
        </li>
        <li>
            <strong class="fl_l">마일리지</strong>
            <span class="fl_r"><fmt:formatNumber type="number">${pymnt.paymentAmtC0115}</fmt:formatNumber>원</span>
        </li>
        <li>
            <strong class="fl_l">예치금</strong>
            <span class="fl_r"><fmt:formatNumber type="number">${pymnt.paymentAmtC0116}</fmt:formatNumber>원</span>
        </li>
        <li class="line">
            <strong class="fl_l col_orange">할인총금액</strong>
            <strong class="fl_r col_orange"><fmt:formatNumber type="number">${dscntAmt}</fmt:formatNumber>원</strong>
        </li>
    </ul>
</div>

<div class="roundbox order_inquiry">
    <strong class="order_num">결제내용</strong>
    <ul class="br_list">
        <li class="br_none">
            <strong class="fl_l">주문금액</strong>
            <span class="fl_r"><fmt:formatNumber type="number">${orderAmt+pymnt.dlvyAmt-dscntAmt}</fmt:formatNumber>원</span>
        </li>
        <li>
            <strong class="fl_l">할인금액</strong>
            <span class="fl_r"><fmt:formatNumber type="number">${dscntAmt}</fmt:formatNumber>원</span>
        </li>
        <li class="line">
            <strong class="fl_l col_orange">총결제금액 : </strong>
            <strong class="fl_r col_orange"><fmt:formatNumber type="number">${orderAmt+pymnt.dlvyAmt}</fmt:formatNumber>원</strong>
        </li>
    </ul>
</div>

<c:if test="${not empty pymnt}">
    <div class="roundbox order_inquiry">
        <ul class="br_list">
            <li class="br_none">
                <strong class="fl_l">결제방식</strong>
                <span class="fl_r">
                    <ui:code codeId="${pymnt.pymntMeansCode}"/>
                    <c:if test="${pymnt.pymntMeansCode eq 'C0111'}">
                        ( ${pymnt.cardCmpyName} 카드 /
                        <c:choose>
                            <c:when test="${pymnt.mitpCount eq 0}">일시불</c:when>
                            <c:otherwise>${pymnt.mitpCount}개월 할부</c:otherwise>
                        </c:choose>)
                    </c:if>   
                    <c:if test="${pymnt.pymntMeansCode eq 'C0112'}">( ${pymnt.bankName} 은행)</c:if>
                    <c:if test="${pymnt.pymntMeansCode eq 'C0113'}">(${pymnt.lgupPymntHdphnNum})</c:if>
                    <c:if test="${pymnt.pymntMeansCode eq 'C0117'}">(${pymnt.lgdACCOUNTNAME}은행  ${pymnt.lgdACCOUNTNUM}<br/>• 예금주: 교보핫트랙스㈜)<br/>주문일로 부터 7일 동안 입금이 안될 경우 주문이 자동으로 취소 됩니다.</c:if>
                    <c:if test="${pymnt.pymntMeansCode eq 'C011J' || pymnt.pymntMeansCode eq 'C011M' || pymnt.pymntMeansCode eq 'C011N'}">
                        ( ${pymnt.niceCardNm} 카드 /
                        <c:choose>
                            <c:when test="${pymnt.niceCardqyota eq '00'}">일시불</c:when>
                            <c:otherwise>${pymnt.niceCardqyota}개월 할부</c:otherwise>
                        </c:choose>)
                    </c:if>  
                    <c:if test="${pymnt.pymntMeansCode eq 'C011K'}">( ${pymnt.niceBank} 은행)</c:if>
                    <c:if test="${pymnt.pymntMeansCode eq 'C011L'}">(${pymnt.nicevBank}  ${pymnt.nicevBankNum}<br/>• 예금주: 교보핫트랙스㈜)<br/>주문일로 부터 7일 동안 입금이 안될 경우 주문이 자동으로 취소 됩니다.</c:if>
                </span>
            </li>
            <li>
                <strong class="fl_l">금액</strong>
                <span class="fl_r"><span class="col_orange"><fmt:formatNumber type="number">${pymnt.pymntAmt}</fmt:formatNumber>원</span></span>
            </li>
            <li>
                <strong class="fl_l">일자</strong>
                <span class="fl_r"><fmt:formatDate pattern="yyyy.MM.dd" value="${pymnt.pymntDtm}"/></span>
            </li>
            <li>
                <strong class="fl_l">비고</strong>
                <span class="fl_r"><ui:code codeId="${pymnt.pymntStatCode}"/></span>
            </li>
        </ul>
    </div>
</c:if>
<c:if test="${   (order.dlvyStatusCode eq 'C0281' || order.dlvyStatusCode eq 'C0121')
              && (order.kyonoOrderMethodId eq 'MOB' || order.kyonoOrderMethodId eq 'MOBSTEP' || order.kyonoOrderMethodId eq 'MOBA' || order.kyonoOrderMethodId eq 'MOBASTEP')}">
<div class="btn_area box_flex mt30 mb30">
    <a href="#n" class="btn btn_gray btnCancelOrder">주문취소</a>
</div>
</c:if>
<c:if test="${totalOrderCancelAmt ne 0}">
    <div class="roundbox order_inquiry">
        <strong class="order_num">환불정보</strong>
        <ul class="br_list">
            <li class="br_none">
                <strong class="fl_l">취소금액</strong>
                <span class="fl_r"><fmt:formatNumber value="${(-1) * totalOrderCancelAmt}" pattern="#,###"/>원</span>
            </li>
            <li>
                <strong class="fl_l">환불상세</strong>
                <span class="fl_r">
                     <c:forEach items="${refundPaymentList}" var="l" varStatus="st">
                         <span class="name"><ui:code codeId="${l.pymntMeansCode}" /> | <fmt:formatNumber value="${(-1)*l.cancRtnAmt}" pattern="#,###"/>원</span>
                         <c:set var="totalCancRtnAmt" value="${totalCancRtnAmt + (-1)*l.cancRtnAmt}"/>
                     </c:forEach>
                     <span class="name">배송비 공제 | <fmt:formatNumber value="${dlvyAmout}" pattern="#,###"/>원</span>
                     <span class="name">쿠폰  공제 | <fmt:formatNumber value="${cancelCouponAmt}" pattern="#,###"/>원</span>
                </span>
            </li>
            <li class="line">
                <strong class="fl_l col_orange">환불금액 : </strong>
                <strong class="fl_r col_orange"><fmt:formatNumber value="${totalCancRtnAmt}" pattern="#,###"/>원</strong>
            </li>
        </ul>
    </div>
</c:if>
<div id="tacbaeLayer" style="position:fixed;left:0;top:0;width:100%;height:100%;background:url('/images/season01/bg_layer02.png');z-index:999;display:none;">
<div style="display: block;margin:10px;position: relative;top:50%;margin-top:-180px;overflow:hidden;">
    <p style="margin-bottom:10px;text-align:right;"><a href="#" onclick="closeTacbae();return false;" style="color:#fff;text-decoration:underline;"><img src="/images/season01/btn_close01.png" style="width:25px;height:25px;"/></a></p>
    <div style="position:relative;font-size:15px;font-weight:bold;background-color:#fff;width:100%;max-height:300px;overflow: auto; -webkit-overflow-scrolling: touch;display:block;">
        <iframe src="about:Tabs" scrolling="yes" style="width:100vw;height:100vh;display:block;border:none;"></iframe>
    </div>
</div>
</div>
</body>
</html>
