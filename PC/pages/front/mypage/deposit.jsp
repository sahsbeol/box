<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
<title>교보핫트랙스 온라인 예치금 | 계좌정보 | MY HOTTRACKS - HOTTRACKS</title>
<script>
//예치금 환불 신청 팝업
function depositRequest(){
    var availableRefundAmount = "${depositParam.availableRefundAmount}" ;
    if(availableRefundAmount != "0"){
        window.open("/ht/mypage/popupDeposit", "popupPrizewinner", "width=610,height=390");
    }else{
        alert("환불 신청 가능한 금액이 없습니다.");
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
    
    <h3 class="page_title mgt0"><img src="${imageServer}/images/renewal/common/tit_deposit.gif" alt="교보핫트랙스 온라인 예치금" /></h3>
    <ul class="list_type02">
        <li>교보핫트랙스 온라인 예치금은 결제대금 환불, 배송비 정산 등으로 발생한 금액입니다.</li>
        <li>예치된 금액은 주문결제 시 사용이 가능하며, 은행계좌로 환불신청을 하실 수 있습니다.</li>
    </ul>
    
    <div class="box_gray02 mgt50">고객님의 교보핫트랙스 온라인 예치금은 현재 <span class="order_num"><fmt:formatNumber value="${depositParam.totalDepositAmount}" pattern="#,###"/>원</span> 입니다.</div>
    <div class="tab1">
        <ul>
            <li><a href="/ht/mypage/deposit?viewType=0&menuId=7" <c:if test="${depositCriteria.viewType eq 0 }">class="on"</c:if>><span>교보핫트랙스 온라인 예치금내역</span></a></li>
            <li><a href="/ht/mypage/deposit?viewType=1&menuId=7" <c:if test="${depositCriteria.viewType eq 1 }">class="on"</c:if>><span>환불신청내역</span></a></li>
        </ul>
    </div>
    <div class="tab_r_btn">
        <a href="javascript://" class="btn_type01" onclick="depositRequest()">예치금 환불신청</a>
    </div>
    <div class="tab_cont">
        <c:if test="${depositCriteria.viewType eq 0}">
            <h4 class="hidden_obj">교보핫트랙스 온라인 예치금내역</h4>
            <table class="bbs_list01">
                <caption>교보핫트랙스 온라인 예치금 내역 <span>변동일,변동사유,교보핫트랙스 온라인 예치금,주문번호</span></caption>
                <colgroup>
                    <col style="width:25%" />
                    <col style="width:25%" />
                    <col style="width:25%" />
                    <col style="width:*" />
                </colgroup>
                <thead>
                    <tr>
                        <th scope="col" class="fir">변동일</th>
                        <th scope="col">변동사유</th> 
                        <th scope="col">교보핫트랙스 온라인 예치금</th> 
                        <th scope="col">주문번호</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${depositList}" var="deposit" varStatus="status">
                        <tr> 
                            <td><fmt:formatDate value="${deposit.modifyDatetime}" pattern="yyyy.MM.dd"/></td> 
                            <td>${deposit.changeReasonContent }</td>
                            <td class="t_right"><fmt:formatNumber value="${deposit.changeAmount}" pattern="#,###"/>원</td> 
                            <td>${deposit.paymentOrderNum}</td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty depositList}"><tr><td colspan="4" class="no_data">교보핫트랙스 온라인 예치금 내역이 없습니다.</td></tr></c:if>
                </tbody>
            </table>
        </c:if>
        
        <c:if test="${depositCriteria.viewType eq 1}">
            <h4 class="hidden_obj">환불신청내역</h4>
            <table class="bbs_list01">
                <caption>환불신청내역 <span>신청일,신청금액,처리상태,처리일</span></caption>
                <colgroup>
                    <col style="width:25%" />
                    <col style="width:25%" />
                    <col style="width:25%" />
                    <col style="width:*" />
                </colgroup>
                <thead>
                    <tr>
                        <th scope="col" class="fir">신청일</th>
                        <th scope="col">신청금액</th>
                        <th scope="col">처리상태</th>
                        <th scope="col">처리일</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${depositList }" var="deposit" varStatus="status">
                        <tr> 
                            <td><fmt:formatDate value="${deposit.repaymentRequestDatetime}" pattern="yyyy.MM.dd"/></td> 
                            <td class="t_right"><fmt:formatNumber value="${deposit.changeAmount}" pattern="#,###"/>원</td>
                            <td>${deposit.changeReasonContent}</td>
                            <td><fmt:formatDate value="${deposit.repaymentCompleteDatetime}" pattern="yyyy.MM.dd"/></td> 
                        </tr>
                    </c:forEach>
                    <c:if test="${empty depositList}"><tr><td colspan="4" class="no_data">환불신청내역이 없습니다.</td></tr></c:if>
                </tbody>
            </table>
        </c:if>
        <!-- paging -->
        <div class="paging">
            <ui:pagination url="/ht/mypage/deposit" name="pageHolder" pageParam="page" parameters="viewType, menuId"/>
        </div>
        <!-- //paging -->
    </div>
</div>
<!-- //sub contents -->
</body>
</html>