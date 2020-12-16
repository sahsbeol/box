<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<html>
<head>
<script type="text/javascript" src="/js/jquery.form.js"></script>
<script type="text/javascript" src="/scripts/common.js"></script>
<script type="text/javascript">
jQuery(function($){
});

function ordDetail(orderNum) {
	alert(orderNum);
	window.open('/ht/bt/${btoburl}/ordListDetail?orderNum=' + orderNum, '', 'width=500px, height=200px, scrollbars=yes');
}
</script>
</head>
<body>
<div class="b2b_main">
    <span><img src="${imageServer}/images/b2b/sub01_img_01.jpg"/></span>
</div>
<form id="onClickBuyNowForm" name="onClickBuyNowForm">
    <input name="btoburl" style="width:100px;" type="hidden" maxlength="20" value="${btoburl}" size="40"/>
<div class="office_design02" id="giftCateMid">
    <!-- 왼쪽 메뉴 -->
    <div class="cate" style="position: relative;z-index:900;vertical-align: top;">
        <table class="table04">
            <tbody>
                <tr>
                    <th>이름</th>
                    <td>서국영</td>
                </tr>
                <tr>
                    <th>등급</th>
                    <td>관리자</td>
                </tr>
                <tr><td colspan="2" align="center"><a href="/ht/bt/${btoburl}">주문하기</a></td></tr>
                <tr><td colspan="2" align="center"><a href="/ht/bt/${btoburl}/confirm">승인하기</a></td></tr>
                <tr><td colspan="2" align="center"><a href="/ht/bt/${btoburl}/ordList">주문내역</a></td></tr>
            </tbody>
        </table>
    </div>
    <div class="cate" style="margin-right:0px;float:right;width:735px;position: relative;z-index:900;">
        <table class="table04">
            <colgroup>
                <col width="*" />
                <col width="*" />
                <col width="*" />
                <col width="*" />
                <col width="*" />
                <col width="*" />
                <col width="*" />
                <col width="*" />
            </colgroup>
            <tbody>
                <tr>
                    <th>주문일자</th>
                    <th>주문번호</th>
                    <th>주문자ID</th>
                    <th>이름</th>
                    <th>상품종수</th>
                    <th>상품수량</th>
                    <th>총금액</th>
                    <th>진행상황</th>
                </tr>
                <c:forEach items="${ordList}" var="ol" varStatus="st">
                    <tr>
                        <td>${ol.ordDt}</td>        <!-- 주문일자 -->
                        <td><a onClick="javascript:ordDetail('${ol.orderNum}');">${ol.orderNum}</a></td>     <!-- 주문번호 -->
                        <td>${ol.userId}</td>       <!-- 주문자ID -->
                        <td>${ol.ordName}</td>      <!-- 이름 -->
                        <td>${ol.prdtCnt}</td>      <!-- 상품종수 -->
                        <td>${ol.orderQty}</td>     <!-- 상품수량 -->
                        <td>${ol.ordAmt}</td>       <!-- 총금액 -->
                        <td>${ol.orderStatNm}</td>  <!-- 진행상황 -->
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>
</form>
</body>
</html>