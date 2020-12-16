<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<ui:decorator name="popup"/>
<head>
<script type="text/javascript">
jQuery(function($){
    $(document).ready(function(){
        window.resizeTo(840,470);
    });
});
function selectAddress() {
    var flag = false;
    $("input[name='selectAddressRadio']:checked").each(function() {
        flag = true;
        var name = $(this).parent().find("input[name='name']").val();
        var telePhone1 = !isEmpty($(this).parent().find("input[name='telePhone1']").val())? $(this).parent().find("input[name='telePhone1']").val() : "";
        var telePhone2 = !isEmpty($(this).parent().find("input[name='telePhone2']").val())? $(this).parent().find("input[name='telePhone2']").val() : "";
        var telePhone3 = !isEmpty($(this).parent().find("input[name='telePhone3']").val())? $(this).parent().find("input[name='telePhone3']").val() : "";
        var handPhone1 = !isEmpty($(this).parent().find("input[name='handPhone1']").val())? $(this).parent().find("input[name='handPhone1']").val() : "";
        var handPhone2 = !isEmpty($(this).parent().find("input[name='handPhone2']").val())? $(this).parent().find("input[name='handPhone2']").val() : "";
        var handPhone3 = !isEmpty($(this).parent().find("input[name='handPhone3']").val())? $(this).parent().find("input[name='handPhone3']").val() : "";
        var email1 = !isEmpty($(this).parent().find("input[name='email1']").val())? $(this).parent().find("input[name='email1']").val() : "";
        var email2 = !isEmpty($(this).parent().find("input[name='email2']").val())? $(this).parent().find("input[name='email2']").val() : "";
        var postNum1 = !isEmpty($(this).parent().find("input[name='postNum1']").val())? $(this).parent().find("input[name='postNum1']").val() : "";
        var postNum2 = !isEmpty($(this).parent().find("input[name='postNum2']").val())? $(this).parent().find("input[name='postNum2']").val() : "";
        var addr1 = !isEmpty($(this).parent().find("input[name='addr1']").val())? $(this).parent().find("input[name='addr1']").val() : "";
        var addr2 = !isEmpty($(this).parent().find("input[name='addr2']").val())? $(this).parent().find("input[name='addr2']").val() : "";
        
        opener.setDeliveryAddress(name, telePhone1, telePhone2, telePhone3, handPhone1, handPhone2, handPhone3, email1, email2, postNum1, postNum2, addr1, addr2);
        window.close();
    });
    
    if(!flag) {
        alert("<fmt:message key='error.not.selected'/>");
    }
}
</script>
</head>
<body>
<div style="width:820px;">
<h1><img src="${imageServer}/images/renewal/common/tit_address_select.gif" alt="배송지 주소선택"/></h1>
<div class="pop_cont" style="height:230px;overflow-y:auto">
    <ul class="list_type02">
        <li>원하시는 배송지를 선택하세요!</li>
    </ul>
    <table class="table02 mgt15">
        <caption>배송지 주소선택 <span>선택, 기본배송지설정/구분, 제목/이름, 전화/휴대전화, 이메일/주소</span></caption>
        <colgroup>
            <col width="50px" />
            <col width="120px" />
            <col width="120px" /> 
            <col width="120px" /> 
            <col width="*" /> 
        </colgroup>
        <thead>
            <tr>
                <th scope="col">선택</th>
                <th scope="col">기본배송지설정/구분</th>
                <th scope="col">제목/이름</th>
                <th scope="col">전화/휴대전화</th>
                <th scope="col">이메일/주소</th>
            </tr>
        </thead>
        <tbody class="link_add">
            <c:forEach items="${addressList}" var="address" varStatus="status">
                <tr>
                    <td class="t_center">
                        <input name="selectAddressRadio" type="radio" value="${address.addrSequence}" class="radios" />
                        <input type="hidden" name="name" value="${address.name}"/>
                        <input type="hidden" name="postNum1" value="${address.postNum1}"/>
                        <input type="hidden" name="postNum2" value="${address.postNum2}"/>
                        <input type="hidden" name="addr1" value="${address.addr1}"/>
                        <input type="hidden" name="addr2" value="${address.addr2}"/>
                        <c:set var="email" value="${fn:split(address.emailAddr, '@')}"/>
                        <c:forEach items="${email}" var="email" varStatus="emailStatus">
                            <c:choose>
                                <c:when test="${emailStatus.count == 1}">
                                    <input type="hidden" name="email1" value="${email}"/>
                                </c:when>
                                <c:when test="${emailStatus.count == 2}">
                                    <input type="hidden" name="email2" value="${email}"/>
                                </c:when>
                            </c:choose>
                        </c:forEach>
                        <c:set var="telePhone" value="${fn:split(address.telNum, '-')}"/>
                        <c:forEach items="${telePhone}" var="phone" varStatus="phoneStatus">
                            <c:choose>
                                <c:when test="${phoneStatus.count == 1}">
                                    <input type="hidden" name="telePhone1" value="${phone}"/>
                                </c:when>
                                <c:when test="${phoneStatus.count == 2}">
                                    <input type="hidden" name="telePhone2" value="${phone}"/>
                                </c:when>
                                <c:when test="${phoneStatus.count == 3}">
                                    <input type="hidden" name="telePhone3" value="${phone}"/>
                                </c:when>
                            </c:choose>
                        </c:forEach>
                        <c:set var="handPhoneNum" value="${fn:split(address.handPhoneNum, '-')}"/>
                        <c:forEach items="${handPhoneNum}" var="phone" varStatus="phoneStatus">
                            <c:choose>
                                <c:when test="${phoneStatus.count == 1}">
                                    <input type="hidden" name="handPhone1" value="${phone}"/>
                                </c:when>
                                <c:when test="${phoneStatus.count == 2}">
                                    <input type="hidden" name="handPhone2" value="${phone}"/>
                                </c:when>
                                <c:when test="${phoneStatus.count == 3}">
                                    <input type="hidden" name="handPhone3" value="${phone}"/>
                                </c:when>
                            </c:choose>
                        </c:forEach>
                    </td>
                    <td class="center">
                        <c:if test="${address.mainAddrYn eq 'true'}">기본배송지<br /></c:if>
                        <ui:gubun key="addressGbn" value="${address.addrGbn}"/>
                    </td>
                    <td class="center">${address.addrTitle}<br /> ${address.name}</td>
                    <td>${address.telNum}<br /> ${address.handPhoneNum}</td>
                    <td>${address.emailAddr}<br /> ${address.postNum1}-${address.postNum2} ${address.addr1} ${address.addr2}</td> 
                </tr>
            </c:forEach>
        </tbody>
    </table>
    <div class="btn_area t_center mgt30">
        <a href="javascript://" onclick="selectAddress()" class="btn_type01" style="width:80px">배송지로 선택</a>
        <a href="javascript://" onclick="self.close()" class="btn_type05" id="cancelFrm" style="width:51px">취소</a>
    </div>
</div>
<div class="pop_close">
    <a href="javascript://" onclick="self.close(); return false;">닫기</a>
</div>
</div> 
</body>