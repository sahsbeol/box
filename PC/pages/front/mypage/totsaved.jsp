<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
<title>통합포인트 | 계좌정보 | MY HOTTRACKS - HOTTRACKS</title>
<script>
function goPage(){
    window.open("http://www.kyobobook.co.kr/myroom/mileageList.laf");
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
    
    <h3 class="page_title mgt0"><img src="${imageServer}/images/renewal/common/tit_totsaved.gif" alt="통합포인트" /></h3>
    <ul class="list_type02">
        <li>통합포인트는 상품구매, 상품평등록 등을 통해 적립됩니다.</li>
    </ul>

    <div class="box_wrap">
        <div class="box_gray02">고객님의 통합포인트는 현재 <span class="order_num"><fmt:formatNumber pattern="#,###" value="${totalPointAmt}" />원</span> 입니다.</div>
        <div class="box_white">
            <h4 class="tit_tip"><span class="tip">TIP</span> 통합포인트 관련 안내</h4>
            <ul class="list_type03 mgt20">
                <li>핫트랙스(온라인/오프라인), 교보문고(온라인/오프라인), 모바일 교보문고 등에서 적립 및 사용하실 수 있습니다.
                    <ul class="list_type02">
                        <li>구매로 적립된 포인트는 기본 유효기간이 1년이며, 이벤트 적립의 경우 상이할 수 있습니다. 만료일이 지난 포인트는 자동소멸됩니다.</li>
                        <li>통합포인트는 비현금성으로 현금이나 예치금으로 환원되지 않습니다.</li>
                    </ul>
                <li>주문취소나 반품시에는 적립된 통합포인트가 다시 차감됩니다.</li>
                <li>이벤트, 제휴를 통해 적립되거나 전환된 통합포인트는 유효기간이 1년 이상이거나 이하일 수 있습니다.</li>
            </ul>
        </div>
    </div>
    
    <div class="tbl_top mgt70">
        <c:if test="${empty listUserCriteria.beginOrderDate}"><c:set var="beginOrderDate" value="3"/></c:if>
        <c:if test="${not empty listUserCriteria.beginOrderDate}"><c:set var="beginOrderDate" value="${listUserCriteria.beginOrderDate}"/></c:if>
        <c:if test="${empty listUserCriteria.endOrderDate}"><c:set var="endOrderDate" value="1"/></c:if>
        <c:if test="${not empty listUserCriteria.endOrderDate}"><c:set var="endOrderDate" value="${listUserCriteria.endOrderDate}"/></c:if>
        <div class="use_point">${beginOrderDate}개월간 적립포인트 <span><fmt:formatNumber pattern="#,###" value="${totalSaveAmt}" /></span>원 | 사용포인트 <span><fmt:formatNumber pattern="#,###" value="${totalUseAmt}" /></span>원</div>
        <div class="btn_r">
            <ul class="tab_btn02">
                <li<c:if test="${beginOrderDate eq 3}"> class="active"</c:if>><a href="/ht/mypage/totsaved?page=1&beginOrderDate=3&endOrderDate=${listUserCriteria.endOrderDate}">3개월</a></li>
                <li<c:if test="${beginOrderDate eq 6}"> class="active"</c:if>><a href="/ht/mypage/totsaved?page=1&beginOrderDate=6&endOrderDate=${listUserCriteria.endOrderDate}">6개월</a></li>
                <li<c:if test="${beginOrderDate eq 12}"> class="active"</c:if>><a href="/ht/mypage/totsaved?page=1&beginOrderDate=12&endOrderDate=${listUserCriteria.endOrderDate}">12개월</a></li>
            </ul>
            <ul class="tab_btn02">
                <li<c:if test="${endOrderDate eq 1}"> class="active"</c:if>><a href="/ht/mypage/totsaved?page=1&beginOrderDate=${listUserCriteria.beginOrderDate}&endOrderDate=1">전체</a></li>
                <li<c:if test="${endOrderDate eq 2}"> class="active"</c:if>><a href="/ht/mypage/totsaved?page=1&beginOrderDate=${listUserCriteria.beginOrderDate}&endOrderDate=2">적립</a></li>
                <li<c:if test="${endOrderDate eq 3}"> class="active"</c:if>><a href="/ht/mypage/totsaved?page=1&beginOrderDate=${listUserCriteria.beginOrderDate}&endOrderDate=3">사용</a></li>
            </ul>
        </div>
    </div>
    <table class="bbs_list01 mgt15">
        <caption>${beginOrderDate}개월간 포인트 적립/사용 내역 <span>거래일, 구분, 내용, 적립P, 사용P</span></caption>
        <colgroup>
            <col style="width:90px" />
            <col style="width:180px" />
            <col style="width:*" />
            <col style="width:80px" />
            <col style="width:80px" />
        </colgroup>
        <thead>
            <tr>
                <th scope="col" class="fir">거래일</th>
                <th scope="col">구분</th>
                <th scope="col">내용</th>
                <th scope="col">적립P</th>
                <th scope="col" class="last">사용P</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${savedList}" var="saved" varStatus="status">
                <tr>
                    <td><fmt:formatDate value="${saved.modDtm}" pattern="yyyy.MM.dd"/></td> 
                    <td class="t_left">${saved.modRsnCode}</td>
                    <td class="t_left">${saved.modRsnCont}</td>
                    <td><fmt:formatNumber value="${saved.chngAmt}" pattern="#,###"/></td> 
                    <td><fmt:formatNumber value="${saved.productPrice}" pattern="#,###"/></td>
                </tr>
            </c:forEach>
            <c:if test="${empty savedList}"><tr><td colspan="5" class="no_data">${beginOrderDate}개월간 포인트 적립/사용 내역이 없습니다.</td></tr></c:if>
        </tbody>
    </table>

    <!-- paging -->
    <div class="paging">
        <ui:pagination url="/ht/mypage/totsaved" name="pageHolder" pageParam="page" parameters="savedYN,listUserCriteria,menuId"/>
    </div>
    <!-- //paging -->
</div>
<!-- //sub contents -->
</body>
</html>