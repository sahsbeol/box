<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<ui:decorator name="none"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>거래명세서</title> 
<link rel="stylesheet" type="text/css" href="/css/common.css" />
<link rel="stylesheet" type="text/css" href="/css/layout.css" />
<link rel="stylesheet" type="text/css" href="/css/contents.css" />
<link rel="stylesheet" type="text/css" href="/css/shop.css" />
<script type="text/javascript" src="/js/jquery-1.4.2.min.js"></script>
<script type="text/javascript">
jQuery(function($) {
    window.resizeTo(700, 865);
    window.print();
});
</script>
</head>
<body class="popup" style="width:680px;">
<p style="padding:20px 0 0 20px;font-weight:bold;font-size:20px;">거래명세서</p>
<div class="pop_cont">
    <div class="p_re">
        <table class="table02 cash">
            <caption>거래명세서 상세정보</caption>
            <colgroup>
                <col style="width:78px" />
                <col style="width:155px" />
                <col style="width:36px" />
                <col style="width:78px" />
                <col style="width:100px" />
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
                    <td colspan="2">${orderInfo.buyerName} 귀하<c:if test="${!empty orderInfo.userId}"><br/>(교보핫트랙스 아이디 : ${orderInfo.userId})</c:if><br />아래금액을 영수함</td>
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
            <col style="width:62px" />
            <col style="width:92px" />
            <col style="width:*" />
            <col style="width:62px" />
            <col style="width:62px" />
            <col style="width:62px" />
            <col style="width:62px" />
            <col style="width:62px">
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
    <p class="mgt10 fs11">위 영수증 국세청 고시 제 95-24에 의거하여 영수증으로 사용할 수 있습니다.</p>
</div>
</body>
</html>