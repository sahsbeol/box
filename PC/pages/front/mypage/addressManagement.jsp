<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
<title>주소록관리 | 주문정보 | MY HOTTRACKS - HOTTRACKS</title>
<script type="text/javascript">
function addNewAddress(){
    window.open('/ht/mypage/createFormDeliveryAddress', '', 'width=660, height=480');
}

function removeAddress(addrSeq){
    var addrSequence = $(this).parent().find("input[name='addrSequence']").val();
    if (confirm("<fmt:message key='confirm.delete.message'/>")){
        $.ajax({
            type: "POST"
            ,url:"/ht/mypage/deleteDeliveryAddress?addrSequence=" + addrSeq
            ,dataType: "json"
            ,success : function(data) {
                if(data.success) {
                    alert("삭제되었습니다.");
                    document.location.reload();
                }else{
                    var errorMessages = data.errorMessages;
                       var errorStr="";
                       for(i=0; i<errorMessages.length; i++) {
                           errorStr += errorMessages[i] + "\n";
                       }
                       alert(errorStr);
                }
            }
            ,error : function(data){
                alert("<fmt:message key='error.common.system'/>");
            }
        });
    }
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
    <h3 class="page_title mgt0"><img src="${imageServer}/images/renewal/common/tit_address_management.gif" alt="주소록 관리" /></h3>
    <ul class="list_type02">
        <li>자주 배송되는 주소는 [주소록]에 등록하여 사용하시면 주문 시 편리하게 배송지 정보를 입력 하실 수 있습니다.</li>
        <li>자택주소와 직장주소는 회원정보에서 수정하실 수 있습니다.</li>
    </ul>

    <div class="btn_area mgt50">
        <a href="javascript://" title="새창에서 열림" onclick="addNewAddress()" class="btn_type01">신규 배송지 등록</a>
    </div>
    <table class="bbs_list01 mgt15">
        <caption>주소록 관리 <span>기본배송지, 구분, 제목/이름, 전화/휴대전화, 이메일/주소, 삭제</span></caption>
        <colgroup>
            <col style="width:80px" />
            <col style="width:50px" />
            <col style="width:80px" />
            <col style="width:120px" />
            <col style="width:*" />
            <col style="width:80px" />
        </colgroup>
        <thead>
            <tr>
                <th scope="col" class="fir">기본배송지</th>
                <th scope="col">구분</th>
                <th scope="col">제목/이름</th>
                <th scope="col">전화/휴대전화</th>
                <th scope="col">이메일/주소</th>
                <th scope="col" class="last">삭제</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${addressManagementList}" var="list" varStatus="status">
                <tr>
                    <td><c:if test="${list.mainAddrYn}"><a title="새창에서 열기" href="/ht/mypage/viewUserAddress?addrSequence=${list.addrSequence}" onclick="window.open(this.href, '', 'width=660, height=480');return false;" >기본배송지</a></c:if></td>
                    <td><a title="새창에서 열기" href="/ht/mypage/viewUserAddress?addrSequence=${list.addrSequence}" onclick="window.open(this.href, '', 'width=660, height=480');return false;"><ui:gubun key="addressGbn" value="${list.addrGbn}"></ui:gubun></a></td>
                    <td>
                        <a title="새창에서 열기" href="/ht/mypage/viewUserAddress?addrSequence=${list.addrSequence}" onclick="window.open(this.href, '', 'width=660, height=480');return false;">
                            <span class="d_block">${list.addrTitle}</span>
                            <span class="d_block">${list.name}</span>
                        </a>
                    </td>
                    <td>
                        <a title="새창에서 열기" href="/ht/mypage/viewUserAddress?addrSequence=${list.addrSequence}" onclick="window.open(this.href, '', 'width=660, height=480');return false;">
                            <span class="d_block">${list.telNum}</span>
                            <span class="d_block">${list.handPhoneNum}</span>
                        </a>
                    </td>
                    <td class="t_left">
                        <a title="새창에서 열기" href="/ht/mypage/viewUserAddress?addrSequence=${list.addrSequence}" onclick="window.open(this.href, '', 'width=660, height=480');return false;">
                            <span class="d_block">${list.emailAddr}</span>
                            <span class="d_block">${list.addr1} ${list.addr2}</span>
                        </a>
                    </td>
                    <td class="img center">
                        <c:if test="${list.mainAddrYn}">기본배송지<br/>삭제불가</c:if>
                        <c:if test="${!list.mainAddrYn}">
                            <a href="javascript://" class="btn_type02" onclick="removeAddress('${list.addrSequence}')">삭제</a>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty addressManagementList}"><tr><td colspan="6" class="no_data">기본배송지가 없습니다.</td></tr></c:if>
        </tbody>
    </table>

    <!-- paging -->
    <div class="paging">
        <ui:pagination name="pageHolder" url="/ht/mypage/addressManagement" parameters=""/>
    </div>
    <!-- //paging -->

</div>
<!-- //sub contents -->
</body>
</html>