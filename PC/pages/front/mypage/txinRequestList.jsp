<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<head>
<script type="text/javascript">

<%-- 세금계산서 신청--%>
function goTxinRequest() {
    window.location.href = "/ht/mypage/txinRequest";
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
    <h3 class="page_title mgt0"><img src="${imageServer}/images/renewal/common/txinRequestList.gif" alt="세금계산서 신청내역" /></h3>
    <ul class="list_type02">
        <li>[세금계산서] 신청 내역 및 발급현황을 확인 하실 수 있습니다.</li>
    </ul>
    <div class="mgt30">
        <a href="javascript:goTxinRequest()" class="btn_type01">세금계산서 신청</a>
    </div>
    <table class="bbs_list01 mgt15">
        <caption>세금계산서 신청내역 <span>순번, 신청자명, 신청일, 발급일, 처리 상태</span>
        </caption>
        <colgroup>
            <col style="width:20%" />
            <col style="width:20%" />
            <col style="width:20%" />
            <col style="width:20%" />
            <col style="width:20%" />
        </colgroup>
        <thead>
            <tr>
                <th scope="col" class="fir">순번</th>
                <th scope="col">신청자명</th>
                <th scope="col">신청일</th>
                <th scope="col">발급일</th>
                <th scope="col" class="last">처리 상태</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${list}" var="txinRequest" varStatus="status"> 
                <tr> 
                    <td>${pageHolder.startNumber + status.index}</td>
                    <td><a href="/ht/mypage/popopViewTxinRequest?taxBillSeq=${txinRequest.taxBillSeq}" onclick="window.open(this.href,'popupTxinRequest','width=820,height=370');return false;">${txinRequest.sscbrName}</a></td>
                    <td><span class="bold"><fmt:formatDate value="${txinRequest.reqDtm}" pattern="yyyy-MM-dd"/></span></td>
                    <td><span class="bold"><fmt:formatDate value="${txinRequest.issuedtm}" pattern="yyyy-MM-dd"/></span></td>
                    <td><ui:gubun key="ynString" keyName="발급완료,발급처리중" value="${txinRequest.issueYn}"/></td>  
                </tr>
            </c:forEach>
            <c:if test="${empty list}"><tr><td colspan="5" class="no_data">검색된 신청내역이 없습니다.</td></tr></c:if>
        </tbody>
    </table>
    <div class="paging"><ui:pagination url="/ht/mypage/txinRequestList" name="pageHolder"/></div>
</div>
</body>