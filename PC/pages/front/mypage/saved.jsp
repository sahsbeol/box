<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<head>
<title>마일리지 | 계좌정보 | MY HOTTRACKS - HOTTRACKS</title>
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
    
    <h3 class="page_title mgt0"><img src="${imageServer}/images/renewal/common/tit_saved.gif" alt="마일리지" /></h3>
    <ul class="list_type02">
        <li>마일리지는 상품구매, 상품평등록 등을 통해 적립됩니다.</li>
    </ul>

    <div class="box_wrap">
        <div class="box_gray02">고객님의 마일리지는 현재 <span class="order_num"><fmt:formatNumber pattern="#,###" value="${totalchngAmt}" />원</span> 입니다.</div>
        <div class="box_white">
            <h4 class="tit_tip"><span class="tip">TIP</span> 마일리지 관련 안내</h4>
            <ol class="mgt20">
                <li>1. 적립된 마일리지는 3년간 유효하며, 3년이 경과된 마일리지는 익월 1일에 소멸됩니다.</li>
                <li>2. 마일리지 결제분에 대해서는 마일리지가 적립되지 않습니다.
                    <ul class="list_type02">
                        <li>마일리지는 고객님이 "현금 결제하신 금액"에 대해서 할인개념으로 적용해 드리는 서비스입니다.</li>
                        <li>마일리지를 적립대상에 포함시킬 경우 2중 할인이 되므로 적립대상에서 제외하오니, 이에 대한 고객님의 양해 부탁 드립니다.</li>
                        <li>또한 마일리지는 비현금성으로, 현금(예치금 등)으로 환원이 안됩니다.</li>
                    </ul>
                </li>
            </ol>
        </div>
        <div class="box_gray02">
            <div class="txt_info">
                <p class="f_left"><strong>${user.name}님</strong>의 다음달 소멸 예상 마일리지는 인터넷교보문고에서 확인가능합니다.</p>
                <div class="f_right">
                    <a href="javascript://" class="btn_type06" onclick="goPage()" title="새창에서 열림"><span>확인하러 가기</span></a>
                </div>
            </div> 
        </div>
    </div>
    
    <div class="tab1">
        <ul>
            <li><a href="/ht/mypage/saved?savedYN=0&menuId=6"<c:if test="${listUserCriteria.savedYN eq 0}"> class="on"</c:if>><span>적립 마일리지</span></a></li>
            <li><a href="/ht/mypage/saved?savedYN=1&menuId=6"<c:if test="${listUserCriteria.savedYN eq 1}"> class="on"</c:if>><span>사용 마일리지</span></a></li>
        </ul>
    </div>
    <div id="tab_cont_1" class="tab_cont">
        <h4 class="hidden_obj">적립 마일리지</h4>
        <table class="bbs_list01">
            <caption>${listUserCriteria.savedYN eq 0?'적립':'사용'} 마일리지 <span>변동일, 변동사유, 마일리지, 주문번호</span></caption>
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
                    <th scope="col">마일리지</th>
                    <th scope="col" class="last">주문번호</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${savedList }" var="saved" varStatus="status">
                    <tr>
                        <td><fmt:formatDate value="${saved.modDtm}" pattern="yyyy.MM.dd"/></td>
                        <td><ui:code codeId="${saved.modRsnCode}" /> <c:if test="${saved.modRsnCont != null}">(${saved.modRsnCont })</c:if></td>
                        <td class="t_right"><fmt:formatNumber value="${saved.chngAmt}" pattern="#,###"/></td>
                        <td>${saved.orderNum }</td>
                    </tr>
                </c:forEach>
                <c:if test="${empty savedList}"><tr><td colspan="4" class="no-data">적립 마일리지가 없습니다.</td></tr></c:if>
            </tbody>
        </table>
        <!-- paging -->
        <div class="paging">
            <ui:pagination url="/ht/mypage/saved" name="pageHolder" pageParam="page" parameters="savedYN,listUserCriteria,menuId"/>
        </div>
        <!-- //paging -->
    </div>
</div>
<!-- //sub contents -->
</body>