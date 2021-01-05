<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<html>
<head>
<script type="text/javascript">
jQuery(function($){
    $("#wrap").addClass("mypage_v2");
    $("#locDelivery").addClass("active");
});

function closeTacbae(){
    $("#tacbaeLayer").hide();
    $("#tacbaeLayer").find("iframe").attr("src", "about:Tabs");
    $("#wrap").css({position:"initial"});
}

function goList(page){
    location.href="?orderTermType=${c.orderTermType}&page="+page;
}
function returnYYYYMM(){
    var now = new Date();
    var year= now.getFullYear();
    var mon = (now.getMonth()+1) > 9 ? ''+(now.getMonth()+1) : '0'+(now.getMonth()+1);
    return year+mon;
}
function sendReview(sellPrdtBcode, rcrdCd, orderNum, orderPrdtInseq){
    $.ajax({
        type: "POST"
        ,url:"/m/ajaxOrderPrdtReview"
        ,dataType: 'json'
        ,async: false
        ,data : {orderNum: orderNum, orderPrdtInseq:orderPrdtInseq }
        ,success: function(data) {
            if(data.save == false){
                   location.href="/m/gift/detail/reviewForm?sellPrdtBcode="+sellPrdtBcode+"&rcrdCd="+rcrdCd+"&orderNum="+orderNum+"&orderPrdtInseq="+orderPrdtInseq+"&rtnGbn=M";    
            }else {
                alert("이미 등록하신 상품후기 입니다.");
                location.reload(true);
            }
        }
        ,error: function() {
            alert('<fmt:message key="error.common.system"/>');
        }
    });
}

function doDeliveryComplete(deliveryId) {
	if(confirm("상품을 받으셨나요?\n상품을 받으신 고객만 수취확인 해주세요!")) {
		$.ajax({
		    type: "POST"
		    ,url: "/m/mypage/doDeliveryComplete"
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
<input type="hidden" name="eof" value="1"/>
<input type="hidden" name="orderTermType" id="orderTermType" value="${c.orderTermType}"/>
<div class="gray_box">
    <!-- 정렬 -->
    <div class="option_box t_select">
        <div class="select_box">
            <c:if test="${empty c.orderTermType || c.orderTermType eq '0'}"><p>최근 6개월</p></c:if>
            <c:if test="${c.orderTermType eq '1'}"><p>6개월 이전</p></c:if>
            <c:if test="${c.orderTermType eq '2'}"><p>취소 주문건</p></c:if>
            <div class="option_box">
                <dl>
                    <dd><a href="/m/mypage/orderDelivery?orderTermType=0"<c:if test="${empty c.orderTermType || c.orderTermType eq '0'}"> class="active"</c:if>>최근 6개월</a></dd>
                    <dd><a href="/m/mypage/orderDelivery?orderTermType=1"<c:if test="${c.orderTermType eq '1'}"> class="active"</c:if>>6개월 이전</a></dd>
                </dl>
            </div>
        </div>
        <div class="select_box">
            
            <c:if test="${empty c.orderStatusCode}"><p>주문상태전체</p></c:if>
            <c:if test="${c.orderStatusCode eq 'C0281'}"><p>결제대기</p></c:if>
            <c:if test="${c.orderStatusCode eq 'C0282'}"><p>결제완료</p></c:if>
            <c:if test="${c.orderStatusCode eq 'C0122'}"><p>상품준비</p></c:if>
            <c:if test="${c.orderStatusCode eq 'C0123'}"><p>배송중</p></c:if>
            <c:if test="${c.orderStatusCode eq 'C0124'}"><p>배송완료</p></c:if>
            <c:if test="${c.orderStatusCode eq 'C0125'}"><p>취소/반품/교환</p></c:if>
            <div class="option_box">
                <dl>
                    <dd><a href="/m/mypage/orderDelivery?orderTermType=${c.orderTermType}"<c:if test="${empty c.orderStatusCode}"> class="active"</c:if>>주문상태전체</a></dd>
                    <dd><a href="/m/mypage/orderDelivery?orderTermType=${c.orderTermType}&orderStatusCode=C0281"<c:if test="${c.orderStatusCode eq 'C0281'}"> class="active"</c:if>>결제대기</a></dd>
                    <dd><a href="/m/mypage/orderDelivery?orderTermType=${c.orderTermType}&orderStatusCode=C0282"<c:if test="${c.orderStatusCode eq 'C0282'}"> class="active"</c:if>>결제완료</a></dd>
                    <dd><a href="/m/mypage/orderDelivery?orderTermType=${c.orderTermType}&orderStatusCode=C0122"<c:if test="${c.orderStatusCode eq 'C0122'}"> class="active"</c:if>>상품준비</a></dd>
                    <dd><a href="/m/mypage/orderDelivery?orderTermType=${c.orderTermType}&orderStatusCode=C0123"<c:if test="${c.orderStatusCode eq 'C0123'}"> class="active"</c:if>>배송중</a></dd>
                    <dd><a href="/m/mypage/orderDelivery?orderTermType=${c.orderTermType}&orderStatusCode=C0124"<c:if test="${c.orderStatusCode eq 'C0124'}"> class="active"</c:if>>배송완료</a></dd>
                    <dd><a href="/m/mypage/orderDelivery?orderTermType=${c.orderTermType}&orderStatusCode=C0125"<c:if test="${c.orderStatusCode eq 'C0125'}"> class="active"</c:if>>취소/반품/교환</a></dd>
                </dl>
            </div>
        </div>
    </div>
    <!-- //정렬 -->
    <hr class="hr_01"/>
</div>
<p class="info" style="margin: 15px auto; text-align: left;font-size: 0.9em;"  >
    PC에서 주문하신 내역은 모바일에서 <font style="color:red">취소/반품/교환</font>이 불가합니다.<BR>
    <B>상품준비 이전 단계까지만 주문 취소가 가능합니다.</B><BR> 
상품준비 이전 단계에서의 부분취소는 [1:1문의]를 이용하시거나 고객센터로 연락주시기 바랍니다.<BR>
상품평 작성에 대한 포인트 적립은 작성 후 익일 23시경 적립됩니다.<BR>
CD, DVD 관련 상품은 상품평을 작성하셔도 후기 포인트가 적립되지 않습니다.
</p>

<c:if test="${not empty sellPrdtBcode}">
    <c:choose>
        <c:when test="${empty result || empty result.stInt1 }">
            <div class="history_contents" style="padding: 5px; ">
                <font style="color:#fe5f01; font-weight: bold;">※ 구매하지 않은 상품이거나 구매 후 3개월이 지난 상품</font>입니다. 상품을 구매하신 뒤 다시 상품평을 작성해주세요.
            </div>
        </c:when>
        <c:when test="${not empty result && result.stVar1 ne 'C0124' }">
            <div class="history_contents" style="padding: 5px; ">
                <font style="color:#fe5f01; font-weight: bold;">※ [ ${result.stVar2 } ]</font> 상품은 배송완료 상태인 경우에 상품평을 작성 하실 수 있습니다.
            </div>
        </c:when>
    </c:choose>
</c:if>

<div id="orderList" class="mt10">
    <c:if test="${empty list}">
        <p class="info t_c"><strong>내역이 존재하지 않습니다.</strong></p>
    </c:if>
    <c:forEach items="${list}" var="l" varStatus="st">
        <ul class="dlvy_list">
            <li class="info">
                <a href="/m/mypage/orderDeliveryDetail?orderNum=${l.orderNum}">
                    <fmt:formatDate value="${l.orderDtm}" pattern="yyyy.MM.dd" var="chkdt"/>${chkdt}
                    <em class="num">${l.orderNum}</em>
                </a>
            </li>
            <c:forEach items="${l.listChild}" var="prod">
                <li class="prod">
                    <dl>
                        <a href="/p/${prod.sellPrdtBcode }">
                            <dt class="pic">
                                <c:choose>
                                    <c:when test="${prod.sellPrdtGbn eq 'R'}"><ui:image rcrdCd="${prod.rcrdCd}" prdtGbn="${prod.sellPrdtGbn}" ratingCode="A"/></c:when>
                                    <c:when test="${prod.sellPrdtGbn eq 'D'}"><ui:image rcrdCd="${prod.rcrdCd}" prdtGbn="${prod.sellPrdtGbn}" ratingCode="A"/></c:when>
                                    <c:otherwise><ui:image src="${prod.productImageUrl}" server="product" size="200"/></c:otherwise>
                                </c:choose>
                            </dt>
                        </a>
                        <dd class="pinfo">
                            <span class="txt">${prod.prdtName }</span>
                            <c:if test="${not empty prod.kyoboSelectOptionStr }"><span class="txt2">${prod.kyoboSelectOptionStr}</span></c:if>
                            <c:if test="${not empty prod.specName }"><span class="spec" style="display: block; min-height: 18px; line-height: 18px;">${prod.specName}</span></c:if>
                            <span class="price">
                                <fmt:formatNumber value="${prod.snglPrdtSellPrice * prod.orderCount}" type="number"/>원
                                (<fmt:formatNumber value="${prod.orderCount}" type="number"/>개)
                            </span>
                            <span class="stat">${prod.orderStatusName}</span>
                        </dd>
                    </dl>
                </li>
                <c:if test="${not empty prod.sendNo || (prod.reviewCnt eq 0 && prod.orderStatusCode eq 'C0124')}">
                    <li class="btn_box">
                        <c:if test="${not empty prod.sendNo}">
                            <a href="#" onclick="winOpen2('${prod.tcbUrl}${prod.sendNo}', '_tacbae', '');return false;" class="btn_tacbae btn_srch">배송조회</a>
                        </c:if>
                        <c:if test="${not empty prod.userNum}"> 
                            <c:if test="${prod.orderStatusCode eq 'C0123' && prod.deliveryCompleteCheck eq 'Y'}">
                                <a href="javascript:doDeliveryComplete('${prod.deliveryId }');" class="btn_orange">수취확인</a>
                            </c:if>
                            <c:if test="${prod.reviewCnt eq 0 && prod.orderStatusCode eq 'C0124' && prod.ableReview ne '-1'}">
                                <a href="javascript:sendReview('${prod.sellPrdtBcode}','${prod.rcrdCd}','${prod.orderNum}','${prod.orderPrdtInseq}');" class="btn_edit">상품후기 작성</a>
                            </c:if>
                            <c:if test="${empty prod.rcrdCd }">
                                <c:if test="${prod.reviewCnt ne 0 && prod.orderStatusCode eq 'C0124' && prod.resultComment eq 1}">
                                    <a href="#" onclick="return false;" class="btn_srch">상품평 적립완료</a>
                                </c:if>
                                <c:if test="${prod.reviewCnt ne 0 && prod.orderStatusCode eq 'C0124' && prod.resultComment ne 1}">
                                    <a href="#" onclick="return false;" class="btn_srch">상품평 작성완료</a>
                                </c:if>
                            </c:if>
                        </c:if>
                    </li>
                </c:if>
            </c:forEach>
        </ul>
    </c:forEach>
</div>
<!-- paging -->
<div class="paging mb30">
    <ui:paginationScript name="pageHolder" scriptName="goList"/>
</div>
<!-- //paging -->
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
