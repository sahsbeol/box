<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<html>
<head>
<script type="text/javascript" src="/js/jquery.form.js"></script>
<script type="text/javascript" src="/js/mOrder.js"></script>
<title>결제 연동 테스트</title>
<script type="text/javascript">
function orderPay() {
	alert("결제");
    $("form#orderSheetForm").attr("action", "/m/order/testpayRequest");
    //$("form#orderSheetForm").attr("target", "pay_frame");
    //$("form#orderSheetForm").attr("target", "_blank");
    $("form#orderSheetForm").submit();
}
</script>
</head>
<body>
<form id="orderSheetForm" action="#" method="post">
결제 연동 테스트 : 진행.<BR/>
주문번호 : <input type="text" id="orderNum" name="orderNum" value="20150513001"><BR/>
결제금액 : <input type="text" id="orderAmt" name="orderAmt" value="10000"><BR/>
구매자명 : <input type="text" id="buyerName" name="buyerName" value="홍길동"><BR/>
상 품 명 : <input type="text" id="prdtName" name="prdtName" value="다이어리"><BR/>
이메일 : <input type="text" id="buyerEmail" name="buyerEmail" value="hong@hottracks.co.kr"><BR/>
<input type="button" onclick="javascript:orderPay();" value="결제"/>
</form>
<iframe id="pay_frame" name="pay_frame" style="border:0;width:0;height:0;display:" src=""></iframe>
</body>
</html>