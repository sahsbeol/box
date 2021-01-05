<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<html>
<head>
<script type="text/javascript">
var page = 1;
jQuery(function($){
    $("#wrap").addClass("mypage03");
    $("#locReview").addClass("active");
});
</script>
</head>
<body>
<input type="hidden" name="eof" value="1"/>
<div class="customer mt17">
    <div class="gray_box2 pt5">
        <div class="tab_box">
            <a href="/m/mypage/listTargetReview" class="active">상품평 쓰기 (<fmt:formatNumber value="${cntTargetReview}" type="number"/>)</a>
            <a href="/m/mypage/listMyReview">내 상품평(<fmt:formatNumber value="${cntMyReview}" type="number"/>)</a>
        </div>
        <hr class="hr_01"/>
    </div>
    <p class="noti">상품마다 첫 상품평 남겨주신 최초 고객님께는 <strong>200포인트 적립.</strong> 모든 상품평은 기본 <strong>100P</strong>적립됩니다.<br/> <strong>매월 10분을 추첨</strong>하여 <strong>우수 상품평</strong>을 작성해주신 분께는 <strong>5,000P를 적립</strong>해드립니다.</p>
    <div class="bbs_box02 edit">
        <ul>
            <c:forEach items="${list}" var="l" varStatus="st">
                <li>
                    <dl class="tit">
                        <dt>${l.prdtName}</dt>
                        <c:if test="${not empty l.specNam}"><dd class="col_orange">${l.specNam}</dd></c:if>
                        <c:forEach items="${l.listKyoboSelectOption}" var="optn">
                            <dd class="col_orange">${optn.optnName}:${optn.optnValue}</dd>
                        </c:forEach>
                    </dl>
                    <dl class="list">
                        <dt>주문일</dt>
                        <dd><fmt:formatDate value="${l.orderDtm}" pattern="yyyy.MM.dd"/></dd>
                        <dt>주문금액</dt>
                        <dd><fmt:formatNumber value="${l.orderAmt}" type="number"/>원 (<fmt:formatNumber value="${l.orderCnt}" type="number"/>개)</dd>
                    </dl>
                    <a href="/m/gift/detail/reviewForm?sellPrdtBcode=${l.sellPrdtBcode}&rcrdCd=${l.rcrdCd}&orderNum=${l.orderNum}&orderPrdtInseq=${l.orderPrdtInseq}&rtnGbn=M" class="btn_review">리뷰작성</a>
                </li>
            </c:forEach>
        </ul>
    </div>
    <p class="info">매월 우수 상품평 작성자 10분께 통합포인트 5,000점이 적립됩니다. 상품평에 적합하지 않은 내용, 미풍양속을 해치는 내용 등은 통보없이 삭제될 수 있으며 통합포인트가 지급되지 않습니다. 상품문의 교환 반품 요청 제품이상 등 불편사항은 1:1 문의 하기를 이용해 주세요.</p>
</div>
</body>
</html>
