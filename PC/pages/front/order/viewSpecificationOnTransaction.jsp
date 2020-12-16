<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<ui:decorator name="popup"/>
<html>
<head>
<script type="text/javascript">
var initBody;
var footer;
function beforePrint(){ 
    initBody = document.body.innerHTML; 
    
    $(".pop_body").css("width","1000px");
    $("body").html($(".pop_body"));
    $(".order_btn").remove();
   
} 

function afterPrint(){ 
    $("body").html(initBody); 
} 
/*
function goPrint()
{
     window.onbeforeprint = beforePrint; 
     window.onafterprint = afterPrint; 
     window.print(); 
}
*/

function goPrint() {
    var url = "/ht/order/printViewSpecificationOnTransaction?orderNo=${orderInfo.orderNum}";
    window.open(url, "", "width=1000px");
}

</script>
</head>
<body>
<div class="f_noto">
<h1 class="tit01 mgt0 fs24 c_white"><span class="fw500">거래명세서</span></h1>
<div class="pop_cont">

    <div class="p_re">
        <table class="table02 cash">
            <caption>거래명세서 상세정보</caption>
            <colgroup>
                <col style="width:78px" />
                <col style="width:195px" />
                <col style="width:36px" />
                <col style="width:78px" />
                <col style="width:140px" />
                <col style="width:78px" />
                <col style="width:*" />
            </colgroup>
            <tbody>
                <tr>
                    <th>주문번호</th>
                    <td>No. ${orderInfo.orderNum}</td>
                    <td rowspan="4" class="t_center">공<br />급<br />자</td>
                    <th>등록번호</th>
                    <td colspan="3">102-81-29258</td>
                </tr>
                <tr>
                    <th>입금일</th>
                    <td><fmt:formatDate value="${orderInfo.orderDatetime}" pattern="yyyy년 MM월 dd일"/></td>
                    <th>상호</th>
                    <td>교보핫트랙스(주)</td>
                    <th>성명</th>
                    <td>오교철</td>
                </tr>
                <tr>
                    <td colspan="2">${orderInfo.buyerName} 귀하<c:if test="${!empty orderInfo.userId}"> (교보핫트랙스 아이디 : ${orderInfo.userId})</c:if><br />아래금액을 영수함</td>
                    <th>사업장<br />소재지</th>
                    <td colspan="3">경기도 파주시 회동길 78 (출판단지내)</td>
                </tr>
                <tr>
                    <th>총액</th>
                    <td><strong><fmt:formatNumber value="${orderInfo.orderAmt + orderInfo.deliveryAmt}" pattern="#,###"/>원</strong></td>
                    <th>업태</th>
                    <td>제조/도소매</td>
                    <th>종목</th>
                    <td>문구 판촉물 음반</td>
                </tr>
            </tbody>
        </table>
        <div class="ingam"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/mypage/mbj.gif" alt="직인" /></div>
    </div>

    <table class="table02 cash t_center mgt10">
        <caption>결제 금권 상세정보</caption>
        <colgroup>
            <col style="width:92px" />
            <col style="width:92px" />
            <col style="width:92px" />
            <col style="width:*">
        </colgroup>
        <tbody>
            <tr>
                <th>번호</th>
                <th>결제 금권</th>
                <th>결제 금액</th>
                <th>비고</th>
            </tr>
            <c:set var="count" value="0"/>
            <c:forEach items="${paymentInfo}" var="paymentInfo" varStatus="status">
                <c:set var="count" value="${count+1}"/>
                <tr>
                    <td>${count}</td>
                    <td>${paymentInfo.pymntStatCode}</td>
                    <td class="t_right"><fmt:formatNumber value="${paymentInfo.prdtAmt}" pattern="#,###"/>원</td>
                    <td></td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <table class="table02 cash t_center mgt10">
        <caption>거래명세서 상세정보</caption>
        <colgroup>
            <col style="width:92px" />
            <col style="width:92px" />
            <col style="width:92px" />
            <col style="width:92px" />
            <col style="width:92px" />
            <col style="width:92px" />
            <col style="width:92px" />
            <col style="width:*">
        </colgroup>
        <tbody>
            <tr>
                <th>번호</th>
                <th>상품코드</th>
                <th colspan="2">상품명</th>
                <th>단가</th>
                <th>VAT</th>
                <th>수량</th>
                <th>금액</th>
            </tr>
            <c:set var="count" value="0"/>
            <c:forEach items="${orderInfo.orderProductList}" var="orderProduct" varStatus="status">
                <c:set var="count" value="${count+1}"/>
                <tr> 
                    <td>${count}</td>
                    <td class="t_left">${orderProduct.barcode}</td>  
                    <td class="t_left" colspan="2">
                        ${orderProduct.productName}
                        <c:if test="${!empty orderProduct.specName}">(${orderProduct.specName})</c:if>
                        <c:if test="${!empty orderProduct.option}">(${orderProduct.option})</c:if>
                    </td>  
                    <td class="t_right"><fmt:formatNumber value="${orderProduct.sellProductPrice}" pattern="#,###"/></td>  
                    <td class="t_right"><fmt:formatNumber value="${orderProduct.vat}" pattern="#,###"/></td>   
                    <td>${orderProduct.orderCount - orderProduct.returnCount}</td>  
                    <td class="t_right"><fmt:formatNumber value="${orderProduct.sumSellPrice}" pattern="#,###"/></td>  
                </tr>
                <c:if test="${!empty orderProduct.cvslInfo}">
                    <tr>
                        <c:set var="count" value="${count+1}"/>
                        <td>${count}</td>
                        <td class="t_left"></td>
                        <td class="t_left" colspan="2">각인서비스</td>
                        <td class="t_right"><fmt:formatNumber value="${orderProduct.cvslInfo.price/1.1}" pattern="#,###"/></td>  
                        <td class="t_right"><fmt:formatNumber value="${orderProduct.cvslInfo.price - orderProduct.cvslInfo.price/1.1}" pattern="#,###"/></td>   
                        <td>${orderProduct.orderCount - orderProduct.returnCount}</td>  
                        <td class="t_right"><fmt:formatNumber value="${orderProduct.cvslInfo.price * (orderProduct.orderCount - orderProduct.returnCount)}" pattern="#,###"/></td>
                    </tr>
                </c:if>
            </c:forEach> 
            <tr class="tfoot">
                <th colspan="6">합계</th>
                <td>${orderInfo.totalPrdtCount}</td>
                <td class="t_right"><fmt:formatNumber value="${orderInfo.orderAmt}" pattern="#,###"/></td>
            </tr>
            <tr>
                <td>주문일자</td>
                <td><fmt:formatDate value="${orderInfo.orderDatetime}" pattern="yyyy-MM-dd"/></td>
                <td>배송비</td>
                <td><fmt:formatNumber value="${orderInfo.deliveryAmt}" pattern="#,###"/></td>
                <td>포장비</td>
                <td colspan="3" class="t_right">0원</td>
            </tr>
        </tbody>
    </table>
    <p class="mgt10 fs12">위 영수증 국세청 고시 제 95-24에 의거하여 영수증으로 사용할 수 있습니다.</p>
    <div class="btn_area t_center mgt30 order_btn">
        <a href="javascript://" onclick="goPrint()" class="btn_type01 fs16 pd10" style="width:100px"><strong>인쇄</strong></a>
    </div>
</div>
<%--<div class="pop_close">
    <a href="javascript://" onclick="self.close();">닫기</a>
</div>--%>
</div>
</body>
</html>