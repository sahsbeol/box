<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
<title>통합멤버십 | 서비스안내 | 고객센터 - HOTTRACKS</title>
<script type="text/javascript">
var isLogin = ${isLogin};
jQuery(function($) {
    $('button.loginButton').click(function() {
        login();
    });
});

function coupondowns(couponId1, couponId2, couponId3) {
    if (!isLogin) {
        needLogin();
    } else {
        var param = "dump=1" ;
        if (!isEmpty(couponId1)) {
            param += "&couponIds=" + couponId1;
        }
        
        if (!isEmpty(couponId2)) {
            param += "&couponIds=" + couponId2;
        }
        
        if (!isEmpty(couponId3)) {
            param += "&couponIds=" + couponId3;
        }
        
        $.ajax({
            type: "POST"
            ,url:"/ht/coupon/productCouponDownForPolicy07"
            ,dataType: 'json'
            ,data: param
            ,success: function(data) {
                if (data.save) {
                    alert("쿠폰이 다운로드 되었습니다.");
                } else {
                    alert(data.errorMessage);
                }
            }
            ,error: function() {
                alert('<fmt:message key="error.common.system"/>');
            }
        });
    }
}
</script>
</head>
<body>
<!-- sub top -->
<div class="page_location">
    <h2 class="title"><img src="${imageServer}/images/renewal/common/tit_cs_center.gif" alt="CS Center"/></h2>
    <div class="loc"><a href="/" class="home">Home</a><em>통합 멤버십</em></div>
</div>
<!-- //sub top -->

<c:import url="/menu/help/lnb"/>

<!-- sub contents -->
<div class="sub_contents">
    <h3 class="page_title mgt0"><img src="${imageServer}/images/renewal/common/tit_membership.gif" alt="통합 멤버십" /></h3>
    <ul class="list_type02">
        <li>다양한 혜택, 차별화된 서비스 회원가입 순간부터 통합 멤버십 혜택이 기다립니다.</li>
        <li>교보문고/핫트랙스 통합회원에 가입하시면 교보문고(www.kyobobook.co.kr)와 핫트랙스온라인몰(www.hottracks.co.kr)에 동시 가입되며, <br />서비스 이용시 하나의 통합 ID로 편리하고 안전하게 이용하실 수 있는 싱글 ID 서비스(웹서비스, 통합포인트 사용)를 이용 하실 수 있습니다.</li>
    </ul>
    <h4 class="tit01">회원 등급 및 혜택 안내</h4>
    <table class="table03">
        <caption>회원 등급 및 혜택 안내</caption>
        <colgroup>
            <col width="20%" />
            <col width="20%" />
            <col width="20%" />
            <col width="20%" />
            <col width="*" />
        </colgroup>
        <thead>
            <tr>
                <th scope="col">회원 등급</th>
                <th scope="col">프렌즈</th>
                <th scope="col">실버</th>
                <th scope="col">골드</th>
                <th scope="col">플래티넘</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>선정 기준</td>
                <td>교보문고/핫트랙스 통합회원</td>
                <td>직전 3개월간 구매 금액<BR>10만원 이상, 20만원 미만</td>
                <td>직전 3개월간 구매 금액<BR>20만원 이상, 30만원 미만</td>
                <td>직전 3개월간 구매 금액<BR>30만원 이상</td>
            </tr>
            <tr>
                <td>신규 회원가입<BR>감사 쿠폰</td>
                <td colspan="4">무료 배송 쿠폰 1장, 1천원 할인 쿠폰 1장<BR>* 회원가입시 익일 쿠폰 발급</td>
            </tr>
            <tr>
                <td>통합 회원 동의<BR>감사 쿠폰</td>
                <td colspan="4">무료 배송 쿠폰 1장, 1천원 할인 쿠폰 1장<BR>* 교보문고/핫트랙스 통합 회원 동의 시 익일 쿠폰 발급</td>
            </tr>
            <tr>
                <td>온라인 쿠폰</td>
                <td>-</td>
                <td>2천원 할인 쿠폰 1장<BR>(구매 금액 5만원 이상)</td>
                <td>3천원 할인 쿠폰 1장<BR>(구매 금액 7만원 이상)<BR><BR>2천원 할인 쿠폰 1장<BR>(구매 금액 5만원 이상)</td>
                <td>5천원 할인 쿠폰 1장<BR>(구매 금액 10만원 이상)<BR><BR>4천원 할인 쿠폰 1장<BR>(구매 금액 7만원 이상)<BR><BR>3천원 할인 쿠폰 1장<BR>(구매 금액 5만원 이상)</td>
            </tr>
            <tr> 
                <td>오프라인 쿠폰</td>
                <td>-</td>
                <td>10% 할인 쿠폰 1장</td>
                <td>10% 할인 쿠폰 1장<BR>5% 할인 쿠폰 1장</td>
                <td>10% 할인 쿠폰 2장</td>
            </tr>
            <tr>
                <td>카페자우</td>
                <td>-</td>
                <td>-</td>
                <td>아메리카노 무료 쿠폰 1장</td>
                <td>아메리카노 무료 쿠폰 2장</td>
            </tr>
            <tr>
                <td>통합 포인트</td>
                <td>기본 0~1% 적립</td>
                <td>기본 0~1% 적립<BR>2만원 이상 구매 시<BR>추가 2% 적립</td>
                <td>기본 0~1% 적립<BR>2만원 이상 구매 시<BR>추가 3% 적립</td>
                <td>기본 0~1% 적립<BR>2만원 이상 구매 시<BR>추가 4% 적립</td>
            </tr>
            <tr>
                <td>주차 혜택</td>
                <td>구매 시 제공</td>
                <td colspan="3">무료 주차(매장별 유동적 운영)</td>
            </tr>
            <tr>
                <td>배송비</td>
                <td>-</td>
                <td>무료 배송 쿠폰 월 1장</td>
                <td>무료 배송 쿠폰 월 2장</td>
                <td>무료 배송 쿠폰 월 3장</td>
            </tr>
        </tbody>
    </table>
    <p class="stxt mgt10">* 직전 3개월간 이용 내역을 반영하여 매월 1일 새로운 회원 등급이 부여됩니다.</p>
    <p class="stxt mgt10">* 등급산정 기준 및 등급별 혜택은 추후 당사 사정에 의해 변경될 수 있습니다.</p>

    <div class="infobox01">
        <dl class="f_left">
            <dt>등급 산정 기간</dt>
            <dd>
                - 직전 3개월 순수 구매액 기준으로 새로운 등급이 적용됩니다.<BR>
                ex) 19년 5월 1일 등급 산정의 경우 19년 1월 26일~4월 25일까지 3개월간의 구매 데이터를 기준으로 산정<BR>
                * 교보문고 구매 금액과 합산 금액으로 등급이 산정됩니다.<BR>
                * 교보문고-핫트랙스 통합회원에 한하여 적용됩니다
            </dd>
            <dt>등급산정 반영일</dt>
            <dd>- 매월 1일 오전 9시</dd>
            
            <dt>등급 유지 기간</dt>
            <dd>
                - 직전 3개월 순수 구매액 기준으로 3개월간 유지됩니다.<BR>
                ex) 19년 5월 1일 등급 산정으로 실버 등급이 된 회원의 경우<BR>
                19년 7월까지 실버 회원 혜택 유지<BR> 
                - 매월 1일 등급 산정 시 구매 금액이 상위 등급 기준에 충족되시면 등급은 상향 조정됩니다.<BR>
                - 고객님의 회원 등급과 구매 내역은 마이핫트랙스에서 확인하실 수 있습니다.<BR>
                - 회원 기준 및 혜택은 당사 규정에 따라 변경될 수 있습니다.
            </dd>
            <dt>등급 추가 통합 포인트</dt>
            <dd>
                - 순수 구매액 2만원 이상 결제 건에 추가 통합포인트를 제공합니다.<BR>
                - 부분 반품, 환불 등으로 결제 잔액이 순수 구매액이 2만원 미만으로 남을 경우 추가 통합포인트는 회수됩니다. 
            </dd>
            <dt>순수구매액이란?</dt>
            <dd>
                - 핫트랙스온라인몰에서 기프트, 음반, DVD등 구입시 지불한<br />
                금액이며 상품 수령일 기준으로 등급 산정시 반영됩니다.<br />
                - 단 통합포인트, 마일리지, 배송비, 할인쿠폰 사용금액은 순수<br />
                구매액 산정에서 제외됩니다.
            </dd>
            <dt>할인쿠폰</dt>
            <dd>
                - 할인쿠폰은 핫트랙스 온라인몰 회원 ID가 있는 우수회원님께만 발급됩니다.<br />
                - 등급별 할인쿠폰은 매월 1일 회원 등급 산정 완료 후 오전 9시부터 오후 1시까지 순차적으로 발급됩니다.<br />
                - 쿠폰 발급 내역은 '마이핫트랙스 > 계좌 정보 > 쿠폰/상품권 등록' 에서 확인하실 수 있습니다.<br />
                - 발급된 할인쿠폰은 1주문건 당 1개만 사용하실 수 있습니다.<br />
                - 핫트랙스 온라인몰에 신규 가입하신 회원님께는 회원가입일로부터 익일 후 가입축하 1천원 할인쿠폰 및 무료 배송 쿠폰이 발급됩니다.<br />
                - 등급별로 발급되는 쿠폰 종류(쿠폰 금액 및 혜택)는 월마다 부분 변경될 수 있습니다.
            </dd>
        </dl>
        <dl class="f_right">
            <dt>무료 배송 쿠폰</dt>
            <dd>
                - 무료 배송 쿠폰은 온라인 주문시 사용 가능하며 할인 쿠폰과 중복 적용 가능합니다.<br />
                - 무료 배송 쿠폰은 국내 배송 상품만 사용 가능하며, 착불 상품 및 도선료는 해당되지 않습니다.<br />
                - 주문시 사용 완료된 쿠폰은 소멸되며, 결제 후 또는 주문취소/발송 후 반품할 경우 환원되지 않습니다.<br />
                - 단, 당사귀책사유로 발생된 품절이나 파손 교환 등의 경우에는 주문에 사용된 배송 쿠폰이 재환원 됩니다.<br /> 
                - 품절로 인해 소멸된 쿠폰은 고객센터로 문의해주시기 바랍니다.<br />
                - 무료 배송 쿠폰은 매월 1일 회원 등급 산정 완료후 오전 9시부터 오후 1시까지 순차적으로 발급됩니다.
            </dd>
            <dt>신규 회원가입 감사 쿠폰</dt>
            <dd>
				- 온라인 핫트랙스에 신규 가입하신 고객님에게 감사 쿠폰을 드립니다.<br />
				- 감사 쿠폰은 익일 발급되며 쿠폰 유효 기간은 1년입니다.
            </dd>
            <dt>교보문고/핫트랙스 통합 회원 동의 감사 쿠폰</dt>
            <dd>
                - 기존 교보문고 회원 중 온라인 핫트랙스와의 통합 회원에 동의하신 회원님께 감사 쿠폰을 드립니다.<br />
                - 감사 쿠폰은 익일 발급해드리며 쿠폰 유효 기간은 1년입니다.            
            </dd>        
        </dl>
    </div>
</div>
<!-- //sub contents -->
</body>
</html>