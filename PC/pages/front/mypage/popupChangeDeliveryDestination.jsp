<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<ui:decorator name="popup"/>
<head>
<script type="text/javascript" src="/js/jquery.form.js" charset="utf-8"></script>
<script type="text/javascript">
jQuery(function($) {
    $("#btnChangeDeliveryDestination").click(function(){
        $("form#chageDeliveryDestination input").each(function() {
            $(this).val($.trim($(this).val()));
        });
        
        $("form#chageDeliveryDestination").ajaxSubmit({
            url: "/ht/mypage/changeDeliveryDestination"
            ,dataType: "json"
            ,success: function saveSuccess(data) {
                if(data.save) {
                    alert("수정완료");
                    window.close();
                } else {
                    var errorMessages = data.errorMessages;
                    alert(errorMessages.join("\n"));
                }
            },error: function(xhr, status, error) {
                alert("<fmt:message key='error.common.system'/>");
            }
        });
    });
});

<%-- 우편번호 찾기 콜백 함수 --%>
function callbackZipcode(address, zipcode) {
    $("input[name='receiverAddress']").val(address);
    $("input[name='receiverPostNum1']").val(zipcode.substring(0,3));
    $("input[name='receiverPostNum2']").val(zipcode.substring(4,7));
}

<%-- 도로명 주소 콜백 함수 --%>
function callbackRoadCode(zipcode, address1, address2, address3, address4 ) {
    $("input[name=receiverAddress]").val(address1);
    $("input[name=receiverPostNum1]").val(zipcode.substring(0,3));
    $("input[name=receiverPostNum2]").val(zipcode.substring(4,7));
}
</script>
</head>
<body>
<div style="">
<h1><img src="${imageServer}/images/renewal/common/tit_pop_address_change.gif" alt="주소변경" /></h1>
<div class="pop_cont">
    <form name="chageDeliveryDestination" id="chageDeliveryDestination" method="post">
        <input type="hidden" name="orderNum" value="${orderDestination.orderNum}"/>
        <table class="table02">
            <colgroup> 
                <col width="15%" />
                <col width="35%" />
                <col width="15%" />
                <col width="35%" /> 
            </colgroup> 
            <tbody>
                <tr>
                    <th scope="row">수취인명</th>
                    <td colspan="3">
                        <input type="text" name="receiverName" value="${orderDestination.receiverName}" style="width:134px;" class="input_txt" />
                    </td>
                </tr>
                <tr>
                    <th scope="row">전화번호</th>
                    <td>
                        <c:set var="telePhone" value="${fn:split(orderDestination.receiverTelePhone, '-')}"/>
                        <c:forEach items="${telePhone}" var="phone" varStatus="phoneStatus">
                            <c:choose>
                                <c:when test="${phoneStatus.count == 1}">
                                    <c:set var="telePhone1" value="${phone}"/>
                                </c:when>
                                <c:when test="${phoneStatus.count == 2}">
                                    <c:set var="telePhone2" value="${phone}"/>
                                </c:when>
                                <c:when test="${phoneStatus.count == 3}">
                                    <c:set var="telePhone3" value="${phone}"/>
                                </c:when>
                            </c:choose>
                        </c:forEach>
                        <c:set var="handPhone" value="${fn:split(orderDestination.receiverHandPhone, '-')}"/>
                        <c:forEach items="${handPhone}" var="phone" varStatus="phoneStatus">
                            <c:choose>
                                <c:when test="${phoneStatus.count == 1}">
                                    <c:set var="handPhone1" value="${phone}"/>
                                </c:when>
                                <c:when test="${phoneStatus.count == 2}">
                                    <c:set var="handPhone2" value="${phone}"/>
                                </c:when>
                                <c:when test="${phoneStatus.count == 3}">
                                    <c:set var="handPhone3" value="${phone}"/>
                                </c:when>
                            </c:choose>
                        </c:forEach>
                        <input type="text" name="receiverTelePhone1" value="${telePhone1}" maxlength="3" class="input_txt inputNumberText" style="width:21px;ime-mode:disabled;"/> -
                        <input type="text" name="receiverTelePhone2" value="${telePhone2}" maxlength="4" class="input_txt inputNumberText" style="width:31px;ime-mode:disabled;"/> -
                        <input type="text" name="receiverTelePhone3" value="${telePhone3}" maxlength="4" class="input_txt inputNumberText" style="width:31px;ime-mode:disabled;"/>
                    </td>
                    <th scope="row">휴대폰</th>
                    <td>
                        <input type="text" name="receiverHandPhone1" value="${handPhone1}" maxlength="3" class="input_txt inputNumberText" style="width:21px;ime-mode:disabled;"/> -
                        <input type="text" name="receiverHandPhone2" value="${handPhone2}" maxlength="4" class="input_txt inputNumberText" style="width:31px;ime-mode:disabled;"/> -
                        <input type="text" name="receiverHandPhone3" value="${handPhone3}" maxlength="4" class="input_txt inputNumberText" style="width:31px;ime-mode:disabled;"/>
                    </td>
                </tr>
                <tr>
                    <th scope="row">배송주소</th>
                    <td colspan="3" class="txt">
                        <input type="text" name="receiverPostNum1" style="width:21px;" class="input_txt" value="${fn:substring(orderDestination.receiverPostNum,0,3)}" readonly="readonly"/>
                        -
                        <input type="text" name="receiverPostNum2" style="width:21px;" class="input_txt" value="${fn:substring(orderDestination.receiverPostNum,3,7)}" readonly="readonly"/>
                        <span class="mgt10"><a href="javascript://" class="btn_type01" onclick="window.open('/ht/listZipcode','popupZipcode','width=400,height=372'); return false;">우편번호검색</a></span>
                        <br />
                        <span>
                            <input type="text" name="receiverAddress" style="width:200px;" class="input_txt mgt10" value="${orderDestination.receiverAddress}" readonly="readonly"/>
                            <input type="text" name="receiverDetailAddress" style="width:190px;" class="input_txt mgt10" value="${orderDestination.receiverDetailAddress}"/>
                        </span>
                    </td>
                </tr>
            </tbody>
        </table>
    </form>
    <div class="btn_area t_center mgt30">
        <a href="javascript://" class="btn_type01" id="btnChangeDeliveryDestination" style="width:51px">변경하기</a>
        <a href="javascript://" class="btn_type02" onclick="self.close()" id="cancelFrm" style="width:51px">취소</a>
    </div>
</div>  
<div class="pop_close">
    <a href="javascript://" onclick="self.close(); return false;">닫기</a>
</div>
</div> 
</body>