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
    $("#wrap").addClass("mypage01");
    $("#locDelivery").addClass("active");
    
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

function goList(page){
    location.href="?orderTermType=${c.orderTermType}&page="+page;
}
function returnYYYYMM(){
    var now = new Date();
    var year= now.getFullYear();
    var mon = (now.getMonth()+1) > 9 ? ''+(now.getMonth()+1) : '0'+(now.getMonth()+1);
    return year+mon;
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
                    <dd><a href="/m/mypage/emp/orderDelivery?orderTermType=0"<c:if test="${empty c.orderTermType || c.orderTermType eq '0'}"> class="active"</c:if>>최근 6개월</a></dd>
                    <dd><a href="/m/mypage/emp/orderDelivery?orderTermType=1"<c:if test="${c.orderTermType eq '1'}"> class="active"</c:if>>6개월 이전</a></dd>
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
                    <dd><a href="/m/mypage/emp/orderDelivery?orderTermType=${c.orderTermType}"<c:if test="${empty c.orderStatusCode}"> class="active"</c:if>>주문상태전체</a></dd>
                    <dd><a href="/m/mypage/emp/orderDelivery?orderTermType=${c.orderTermType}&orderStatusCode=C0281"<c:if test="${c.orderStatusCode eq 'C0281'}"> class="active"</c:if>>결제대기</a></dd>
                    <dd><a href="/m/mypage/emp/orderDelivery?orderTermType=${c.orderTermType}&orderStatusCode=C0282"<c:if test="${c.orderStatusCode eq 'C0282'}"> class="active"</c:if>>결제완료</a></dd>
                    <dd><a href="/m/mypage/emp/orderDelivery?orderTermType=${c.orderTermType}&orderStatusCode=C0122"<c:if test="${c.orderStatusCode eq 'C0122'}"> class="active"</c:if>>상품준비</a></dd>
                    <dd><a href="/m/mypage/emp/orderDelivery?orderTermType=${c.orderTermType}&orderStatusCode=C0123"<c:if test="${c.orderStatusCode eq 'C0123'}"> class="active"</c:if>>배송중</a></dd>
                    <dd><a href="/m/mypage/emp/orderDelivery?orderTermType=${c.orderTermType}&orderStatusCode=C0124"<c:if test="${c.orderStatusCode eq 'C0124'}"> class="active"</c:if>>배송완료</a></dd>
                    <dd><a href="/m/mypage/emp/orderDelivery?orderTermType=${c.orderTermType}&orderStatusCode=C0125"<c:if test="${c.orderStatusCode eq 'C0125'}"> class="active"</c:if>>취소/반품/교환</a></dd>
                </dl>
            </div>
        </div>
    </div>
    <!-- //정렬 -->
    <hr class="hr_01"/>
</div>
<p class="info t_c" style="margin: 15px auto; text-align: left;" ><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/mypage/19_orderdelivery.jpg" style="width: 100%; max-width: 570px; text-align: left;"/></p>

<c:if test="${not empty sellPrdtBcode}">
    <div class="history_contents" style="padding: 5px; ">
        <c:if test="${empty result || empty result.stInt1 }"><font style="color:#fe5f01; font-weight: bold;">※ 구매하지 않은 상품이거나 구매 후 3개월이 지난 상품</font>입니다. 상품을 구매하신 뒤 다시 상품평을 작성해주세요.</c:if>
        <c:if test="${not empty result && result.stVar1 ne 'C0124' }"><font style="color:#fe5f01; font-weight: bold;">※ [ ${result.stVar2 } ]</font> 상품은 배송완료 상태인 경우에 상품평을 작성 하실 수 있습니다.</c:if>
        </div>
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
                            <a href="${prod.tcbUrl}${prod.sendNo}" class="btn_tacbae btn_srch">배송조회</a>
                        </c:if>
                        <c:if test="${prod.reviewCnt eq 0 && prod.orderStatusCode eq 'C0124' && prod.ableReview ne '-1'}">
                            <c:if test="${empty prod.rcrdCd }"><c:set var="ment" value="상품평 작성시 포인트 적립"/></c:if>
                            <c:if test="${not empty prod.rcrdCd }"><c:set var="ment" value="상품평 작성"/></c:if>
                            <a href="/m/gift/detail/reviewForm?sellPrdtBcode=${prod.sellPrdtBcode}&rcrdCd=${prod.rcrdCd}&orderNum=${prod.orderNum}&orderPrdtInseq=${prod.orderPrdtInseq}&rtnGbn=M" class="btn_edit">${ment }</a>
                        </c:if>
                        <c:if test="${empty prod.rcrdCd }">
                            <c:if test="${prod.reviewCnt ne 0 && prod.orderStatusCode eq 'C0124' && resultComment eq 1}">
                                <a href="#" onclick="return false;" class="btn_srch">상품평 적립완료</a>
                            </c:if>
                            <c:if test="${prod.reviewCnt ne 0 && prod.orderStatusCode eq 'C0124' && resultComment ne 1}">
                                <a href="#" onclick="return false;" class="btn_srch">상품평 작성완료</a>
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
