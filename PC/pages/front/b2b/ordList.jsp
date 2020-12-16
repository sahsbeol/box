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
	alert("상세보기");
}
</script>
</head>
<body>
<div class="btob_cont">
<h1 class="btob_tit">기대감!만족감!아이디어!최선의 모습으로 감동을 드리는 핫트랙스 B2B멤버십 회원</h1>
<form id="onClickBuyNowForm" name="onClickBuyNowForm">
    <input name="btoburl" style="width:100px;" type="hidden" maxlength="20" value="${btoburl}" size="40"/>
    <div class="mem_info">
        <div class="mem_info_l">
            <p><em>서국영</em>님, 안녕하세요.<br>고객님은 현재 <em>관리자</em>입니다.</p>
            <a href="/ht/bt/${btoburl}" class="more_info"><span>주문하기</span></a>
            <a href="/ht/bt/${btoburl}/confirm" class="more_info"><span>승인하기</span></a>
            <a href="/ht/bt/${btoburl}/ordList" class="more_info"><span>주문내역</span></a>
        </div>
        <div class="mem_info_r">
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
                <thead>
                    <tr>
                        <th scope="col">주문일자</th>
                        <th scope="col">주문번호</th>
                        <th scope="col">주문자ID</th>
                        <th scope="col">이름</th>
                        <th scope="col">상품종수</th>
                        <th scope="col">상품수량</th>
                        <th scope="col">총금액</th>
                        <th scope="col">진행상황</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${ordList}" var="ol" varStatus="st">
                        <tr>
                            <td class="t_center">${ol.ordDt}</td>        <!-- 주문일자 -->
                            <td class="t_center"><a href="#" onclick="ordDetail('${ol.orderNum}');return false;">${ol.orderNum}</a></td>     <!-- 주문번호 -->
                            <td class="t_center">${ol.userId}</td>       <!-- 주문자ID -->
                            <td class="t_center">${ol.ordName}</td>      <!-- 이름 -->
                            <td class="t_right"><fmt:formatNumber type="number">${ol.prdtCnt}</fmt:formatNumber></td>      <!-- 상품종수 -->
                            <td class="t_right"><fmt:formatNumber type="number">${ol.orderQty}</fmt:formatNumber></td>     <!-- 상품수량 -->
                            <td class="t_right"><fmt:formatNumber type="number">${ol.ordAmt}</fmt:formatNumber></td>       <!-- 총금액 -->
                            <td class="t_center">${ol.orderStatNm}</td>  <!-- 진행상황 -->
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</form>
</body>
</html>