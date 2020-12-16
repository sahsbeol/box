<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<head>
<title>쿠폰/상품권등록 | 계좌정보 | MY HOTTRACKS - HOTTRACKS</title>
<link rel="stylesheet" type="text/css" href="/js/tip-yellow/tip-yellow.css"/>
<script type="text/javascript" src="/js/jquery.form.js"></script> 
<script type="text/javascript" src="/js/jquery.poshytip.min.js"></script>
<script type="text/javascript">
jQuery(function($) {
    $(".couponToolTip").poshytip({
        className: 'tip-yellow',
        showTimeout: 0,
        hideTimeout: 0
    });
    
});

function lengchk(id) {
    if (id == "1") {
        
    }
}

function couponReg() {
    if ($("input[name=couponNum]").val() == "") {alert("쿠폰번호가 없습니다.");document.couponForm.couponNum.focus();return;}
    
    $("#couponForm").ajaxSubmit({
        type : "POST"
        , url : "/ht/order/eventCouponDown?couponNum=" + $("input[name=couponNum]").val()
        , async : false
        , success : function(result){
            if(result.save){
                alert("쿠폰이 지급 되었습니다.");
                location.reload(true);
            } else {
                var errorMessages = result.errorMessages;
                alert(errorMessages);
            }
        }
        ,error: function(xhr, status, error) {
            alert("<fmt:message key='error.common.system'/>");
        }
    });
}


function coupangReg() {
    if ($("input[name=coupangNum1]").val() == "") {alert("쿠폰번호가 없습니다.");document.couponForm.coupangNum1.focus();return;}
    if ($("input[name=coupangNum2]").val() == "") {alert("쿠폰번호가 없습니다.");document.couponForm.coupangNum2.focus();return;}
    if ($("input[name=coupangNum3]").val() == "") {alert("쿠폰번호가 없습니다.");document.couponForm.coupangNum3.focus();return;}
    if ($("input[name=coupangNum4]").val() == "") {alert("쿠폰번호가 없습니다.");document.couponForm.coupangNum4.focus();return;}
    
    document.couponForm.trackGcardNum.value = "" 
                                      + $("input[name=coupangNum1]").val()
                                      + $("input[name=coupangNum2]").val()
                                      + $("input[name=coupangNum3]").val()
                                      + $("input[name=coupangNum4]").val();
    
    $("#couponForm").ajaxSubmit({
        type : "POST"
        , url : "/ht/mypage/coupangReg"
        , async : false
        , success : function(result){
            if(result.save == "true"){
                alert("쿠팡 정액 할인 쿠폰이 지급 되었습니다.");
            } else {
                alert(result.errorMessages);
            }
        }
        ,error: function(xhr, status, error) {
            alert("<fmt:message key='error.common.system'/>");
        }
    });
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
    
    <h3 class="page_title mgt0"><img src="${imageServer}/images/renewal/common/tit_coupon.gif" alt="쿠폰/상품권등록" /></h3>
    <ul class="list_type02">
        <li>쿠폰별 혜택과 사용조건, 유효기간을 꼭 확인해 주세요.</li>
        <li>하나의 장바구니에 두 건 이상의 배송비가 발생하였을 경우 배송비 쿠폰은 한 건의 배송비만 무료가 됩니다.</li>
        <li>무료 배송 쿠폰은 국내 배송 상품만 사용 가능하며, 착불 상품 및 도선료는 해당되지 않습니다.</li>
        <li>무료 배송 쿠폰을 사용하여 주문한 경우 반품 시 적용된 쿠폰은 소멸됩니다.</li>
        <li>따라서 주문취소/반품을 하시게되면 적용된 쿠폰은 환원이 되지 않습니다. 유념해주시기 바랍니다.</li>
    </ul>
    
    <div class="box_gray02 mgt40">고객님의 현재 보유쿠폰은 <span class="order_num"><fmt:formatNumber value="${couponCount}" type="number"/> 장</span> 입니다.</div>
    
    <table class="bbs_list01">
        <caption>현재 보유쿠폰 <span>No, 구분, 쿠폰이름, 할인율(금액), 적용기준, 시작일자, 만료일자</span></caption>
        <colgroup>
            <col style="width:10%" />
            <col style="width:12%" />
            <col style="width:*" />
            <col style="width:12%" />
            <col style="width:23%" />
            <col style="width:10%" />
            <col style="width:10%" />
        </colgroup>
        <thead>
            <tr>
                <th scope="col" class="fir">No</th>
                <th scope="col">구분</th>
                <th scope="col">쿠폰이름</th>
                <th scope="col">할인율(금액)</th>
                <th scope="col">적용기준</th>
                <th scope="col">시작일자</th>
                <th scope="col" class="last">만료일자</th>
            </tr>
        </thead>
        <tbody>
            <c:if test="${empty couponList}"><tr><td colspan="6" class="no-data">현재 보유하신 쿠폰이 없습니다.</td></tr></c:if>
            <c:forEach items="${couponList}" var="l" varStatus="st">
                <tr>
                    <td>
                        ${couponCount-st.index}
                        <input type="hidden" name="couponId" value="${l.couponId}"/>
                        <input type="hidden" name="kyoboCouponId" value="${l.kyoboCouponId}"/>
                    </td>
                    <td<c:if test="${l.scopeGbn eq 'C'}"> class="couponToolTip" title="${l.categoryNameList}"</c:if>><ui:gubun key="couponScopeGbnFront" value="${l.scopeGbn}"/></td>
                    <td class="t_left">${l.couponName}</td>
                    <td class="t_right">
                        <c:choose>
                            <c:when test="${l.scopeGbn eq 'D'}">무료</c:when>
                            <c:otherwise>
                                <c:choose>
                                    <c:when test="${l.rateYn}"><fmt:formatNumber value="${l.couponDiscountRate}" pattern="#,###"/>%</c:when>
                                    <c:when test="${!l.rateYn}"><fmt:formatNumber value="${l.couponDiscountAmount}" pattern="#,###"/>원</c:when>
                                    <c:otherwise>0</c:otherwise>
                                </c:choose>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <c:if test="${l.scopeGbn eq 'D'}">국내 배송 상품</c:if>
                        <c:if test="${l.scopeGbn eq 'O'}">주문금액<fmt:formatNumber pattern="#,###" value="${l.couponStandardAmount}"/>원 이상</c:if>
                        <c:if test="${l.scopeGbn eq 'C' || l.scopeGbn eq 'P'}">상품단가 <fmt:formatNumber pattern="#,###" value="${l.snglPrdtLimitPrice}"/>원 이상</c:if>
                    </td>
                    <td>${l.cpnGainDate}</td>
                    <td>
                        <fmt:parseDate value='${l.cpnValidDate}' var='nd' pattern='yyyymmdd'/>
                        <fmt:formatDate value='${nd}' pattern="yyyy.mm.dd" />
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    <!-- paging -->
    <div class="paging"><ui:pagination url="/ht/mypage/coupon" name="pageHolder" pageParam="page"/></div>
    <!-- //paging -->
    <p class="tit02 mgt30"><strong>※ 다양한 이벤트 쿠폰을 등록하여 할인혜택 받으세요!</strong></p>
    <ul class="list_type02 mgl10">
        <li>해당 상품권 및 보너스쿠폰의 사용기준과 기간을 반드시 확인하여 주세요.</li>
        <li>오프라인 및 제휴사에서 받으신 쿠폰은 번호입력을 통해 보너스쿠폰으로 우선 발급을 받으셔야 이용하실 수 있습니다.</li>
        <li>유효기간이 만기된 상품권 및 보너스쿠폰은 등록이 불가합니다.</li>
    </ul>
    <form id="couponForm" name="couponForm">
            <input type="hidden" name="trackGcardNum" style="width:100px;"/>
    </form>
    <p class="tit02"><strong>※ 쿠폰번호를 입력 하세요.</strong></p>
    <div class="box_gray">
        <div class="coupon_regist"><label for="couponNum">쿠폰번호</label> <input type="text" name="couponNum" id="couponNum" maxlength="16" class="input_txt" title="쿠폰번호 입력" style="width:150px;margin:0 8px 0 6px;" /> 쿠폰 번호는 영문의 대소문자를 구별합니다.</div>
        <div class="f_right"><a href="javascript://" onclick="couponReg()" class="btn_type01" style="width:47px;">등록</a></div>
    </div>
</div>
<!-- //sub contents -->
</body>