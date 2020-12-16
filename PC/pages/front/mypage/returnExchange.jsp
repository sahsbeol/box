<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
<title>반품/교환신청 | 주문정보 | MY HOTTRACKS - HOTTRACKS</title>
<script type="text/javascript">
jQuery(function() {
    $("#goRtnExchange").click(function(event) {
        event.preventDefault();
        
        document.location.href='/ht/mypage/createFormReturnExchange';
    });
});
function dlvyInfoPopup(returnSeq) {
    window.open('/ht/mypage/deliveryInformation?returnSeq='+returnSeq, '', 'width=480,height=220, scrollbars=no');
}
function rtnExchangePopup(returnSeq) {
    window.open('/ht/mypage/returnExchangeInformation?returnSeq='+returnSeq, '', 'width=480,height=220, scrollbars=no');
}
</script>
</head>
<body>
<!-- sub top -->
<div class="page_location">
    <h2 class="title"><img src="${imageServer}/images/renewal/common/tit_my_hottracks.gif" alt="My Hottracks"/></h2>
    <div class="loc"><a href="#" class="home">Home</a><em>MY HOTTRACKS</em></div>
</div>
<!-- //sub top -->

<c:import url="/menu/mypage/lnb"/>

<!-- sub contents -->
<div class="sub_contents">
    
    <h3 class="page_title mgt0"><img src="${imageServer}/images/renewal/common/tit_return_exchange.gif" alt="반품/교환신청" /></h3>
    <ul class="list_type02 tit_desc">
        <li>구매하신 상품의 반품 및 교환 신청내역입니다. 반품/교환 신청은 발송완료일로부터 7일 이내에 가능합니다.</li>
        <li>처리상태가 '반품환불완료' 또는 '교환상품발송'인 경우, 링크를 클릭하시면 상세정보를 확인하실 수 있습니다.</li>
    </ul>

    <div class="btn_area">
        <a href="#n" class="btn_type01" id="goRtnExchange">반품/교환신청</a>
    </div>
    <table class="bbs_list01 mgt15">
        <caption>반품/교환신청 내역 <span>주문일, 주문번호, 상품평,신청구분, 신청수량, 처리상태</span></caption>
        <colgroup>
            <col style="width:80px" />
            <col style="width:110px" />
            <col style="width:*" />
            <col style="width:80px" />
            <col style="width:60px" />
            <col style="width:100px" />
        </colgroup>
        <thead>
            <tr>
                <th scope="col" class="fir">주문일</th>
                <th scope="col">주문번호</th>
                <th scope="col">상품평</th>
                <th scope="col">신청구분</th>
                <th scope="col">신청수량</th>
                <th scope="col" class="last">처리상태</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${list}" var="rtnExchange" varStatus="status" >
                <tr> 
                    <td><fmt:formatDate value="${rtnExchange.registDtm}" pattern="yyyy.MM.dd" /></td>
                    <td><a href="/ht/mypage/orderDeliveryDetail?orderNo=${rtnExchange.orderNum}&menuId=3">${rtnExchange.orderNum}</a></td>
                    <td class="t_left">${rtnExchange.prdtName}<c:if test="${not empty rtnExchange.specName}"><span class="point02"> (${rtnExchange.specName}) </span></c:if></td>   
                    <td>
                        <c:if test="${empty rtnExchange.counselGubunCode}"><ui:code codeId="${rtnExchange.sosCounselCode}"></ui:code></c:if>
                        <c:if test="${not empty rtnExchange.counselGubunCode}"><ui:code codeId="${rtnExchange.counselGubunCode}"></ui:code></c:if>
                    </td>
                    <td>${rtnExchange.rtnCount}</td>
                    <td>
                    <%--
                    1.
                        sos상담구분값이 없을경우- 처리상태:sos상담코드
                        sos상담구분값이 있고,상담구분코드값이 없을경우- 처리상태:sos처리구분코드
                        sos상담구분값이 있고,상담구분코드값이 있을경우- 처리상태:반품상태코드
                    2.    
                        신청구분: 주문상담 구분코드가 있으면(counselGubunCode 교환요청, 반품요청)  주문상담 구분코드(counselGubunCode 교환요청, 반품요청)를 보여주고 
                        처리상태를: 반품교환 상태코드(returnStatusCode 반품환불, 반품완료) 를 보여줌. 
                        신청구분: 주문상담 구분코드가 없으면 (counselGubunCode 교환요청, 반품요청) SOS상담코드(sosCounselCode 반품/교환) 를 보여주고 
                        처리상태를: SOS처리구분(sosProcessGubun) 를 보여줌
                    --%>
                        <span class="f_gray">
                        <c:if test="${empty rtnExchange.counselGubunCode}">
                            <ui:gubun key="sosProcessGubun" value="${rtnExchange.sosProcessGubun}" />
                        </c:if>
                        <c:if test="${not empty rtnExchange.counselGubunCode}">
                            <c:choose>
                                <c:when test="${rtnExchange.returnStatusCode eq 'C0273'}"><!--C0273: 교환배송요청 C0274:교환완료 -->
                                    <a href="javascipt://" class="btn_type02" onclick="dlvyInfoPopup(${rtnExchange.returnSeq});" title="새창으로 열기">
                                        <ui:code codeId="${rtnExchange.returnStatusCode}"></ui:code>
                                    </a>
                                </c:when>
                                <c:when test="${rtnExchange.returnStatusCode eq 'C0278'}"><!--C0277:반품환불 C0278: 반품완료 -->
                                    <a href="javascript://" class="btn_type02" onclick="rtnExchangePopup(${rtnExchange.returnSeq});" title="새창으로 열기">
                                        <ui:code codeId="${rtnExchange.returnStatusCode}"></ui:code>
                                    </a>
                                </c:when>
                                <c:when test="${not empty rtnExchange.returnStatusCode}">
                                    <ui:code codeId="${rtnExchange.returnStatusCode}" />
                                </c:when>
                                <c:otherwise>
                                    <c:choose>
                                        <c:when test="${not empty rtnExchange.returnStatusCode}">
                                            <ui:code codeId="${rtnExchange.returnStatusCode}" />
                                        </c:when>
                                        <c:when test="${empty rtnExchange.returnStatusCode}">
                                            <ui:gubun key="sosProcessGubun" value="${rtnExchange.sosProcessGubun}" />
                                        </c:when>
                                    </c:choose>
                                </c:otherwise>
                            </c:choose>
                        </c:if>
                        </span>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty list}"><tr><td colspan="6" class="no_data">반품/교환신청 내역이 없습니다.</td></tr></c:if>
        </tbody>
    </table>

    <!-- paging -->
    <div class="paging">
        <ui:pagination name="pageHolder" url="/ht/mypage/returnExchange" parameters="userNum, orderNo, password, menuId"/>
    </div>
    <!-- //paging -->

    <h4 class="tit01">반품처리 안내</h4>
    <ol class="step_list return_step">
        <li>반품접수</li>
        <li>반품 회수대기</li>
        <li>반품 회수확인</li>
        <li>반품 환불처리</li>
    </ol>

    <h4 class="tit01">교환처리 안내</h4>
    <ol class="step_list exchange_step">
        <li>교환접수</li>
        <li>교환상품발송</li>
        <li>하자상품교환</li>
    </ol>

</div>
<!-- //sub contents -->
</body>
</html>