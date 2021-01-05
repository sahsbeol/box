<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
<title>통합멤버십 | 서비스안내 | 고객센터 - HOTTRACKS</title>
<style type="text/css">
.my_info { display:block;text-align: center; padding:38px 0; }
.box_slidelist { margin:0 -10px;border-top:1px solid #d1d1d1; }
.box_slidelist li { border-bottom:1px solid #d1d1d1; }
.box_slidelist .btn_tit { display:block;padding:10px;height:23px;line-height:22px;font-size:15px;font-weight:bold;background:url('http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/mobile/content/btn_arrow_down02.png') calc(100% - 10px) center no-repeat #f3f3f3;background-size:20px auto; }
.box_slidelist .btn_tit span { padding-left:31px;background:url('http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/mobile/common/mem05.png') left top no-repeat;background-size:23px auto; height:23px; line-height: 20px;}
.box_slidelist .btn_tit.grade01 span { background:url('http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/mobile/common/mem04.png') left top no-repeat;background-size:23px auto;}
.box_slidelist .btn_tit.grade02 span { background:url('http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/mobile/common/mem03.png') left top no-repeat;background-size:23px auto;}
.box_slidelist .btn_tit.grade03 span { background:url('http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/mobile/common/mem02.png') left top no-repeat;background-size:23px auto;}
.box_slidelist .btn_tit.grade04 span { background:url('http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/mobile/common/mem01.png') left top no-repeat;background-size:23px auto;}
.box_slidelist .cont { display:none;padding:20px;border-top:1px solid #d1d1d1; }
.box_slidelist .cont p { margin-top:5px; }
.box_slidelist .cont p strong { font-size:1.2em; }
.box_slidelist .cont img { width:calc(32% - 10px);margin-right:10px;margin-bottom:10px; }
.box_slidelist .active .btn_tit { background:url('http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/mobile/content/btn_arrow_up02.png') calc(100% - 10px) center no-repeat #f3f3f3;background-size:20px auto; }
.box_slidelist .active .cont { /* display:block; */ }
.box_info { padding:40px 0; }
.box_info p { margin-top:10px; }
</style>
<script type="text/javascript">
var isLogin = ${isLogin};
jQuery(function($) {
    $("#wrap").addClass("mypage_v0");
    $("#locLevel").addClass("active");
    
    $(".box_slidelist .btn_tit").click(function(e) {
        e.preventDefault();
        var item = $($(this).attr("href"));
        if(item.hasClass("active")){
            item.removeClass("active");
            item.find(".cont").slideUp();
        }else{
            item.addClass("active");
            item.find(".cont").slideDown();
        }
     });
});
</script>
</head>
<body>
<!-- sub top -->
<div class="my_info pt20">
    <strong>박민</strong>님은
    <c:if test="${user.userGradeId eq '01'}"><em style="color:#6681dc;text-decoration:underline;font-weight:bold;">프렌즈</em></c:if>
    <c:if test="${user.userGradeId eq '02'}"><em style="color:#8fc41c;text-decoration:underline;font-weight:bold;">실버</em></c:if>
    <c:if test="${user.userGradeId eq '03'}"><em style="color:#8fc41c;text-decoration:underline;font-weight:bold;">골드</em></c:if>
    <c:if test="${user.userGradeId eq '04'}"><em style="color:red;text-decoration:underline;font-weight:bold;">플래티넘</em></c:if>
    <c:if test="${user.userGradeId eq '99'}"><em style="color:#ff6600;text-decoration:underline;font-weight:bold;">직원</em></c:if>
        등급입니다.
</div>
<div class="sub_contents">
    <ul class="box_slidelist">
        <li id="grade01">
            <a href="#grade01" class="btn_tit grade01"><span>플래티넘</span></a>
            <div class="cont">
                <p><strong>선정 기준</strong> - 직전 3개월간 구매 금액 30만원 이상</p>
                <p><strong>온라인 쿠폰 혜택</strong></p>
                <p>
                    <img src="${imageServer}/images/mobile/common/3000_1.png" />
                    <img src="${imageServer}/images/mobile/common/4000_1.png" />
                    <img src="${imageServer}/images/mobile/common/5000_1.png" />
                    <img src="${imageServer }/images/mobile/common/free_3.png" />
                </p>
                <p><strong>매장 쿠폰 혜택</strong></p>
                <p>
                    <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/member/10x02.jpg" />
                    <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/member/cafex2.jpg" />
                    <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/member/free_car.jpg" />
                </p>
                <p>- 기본 0~1% + 추가 4% 적립(2만원 이상 실결제액 기준)</p>
                <p>- 5,000원 쿠폰: 구매 금액 10만원 이상 사용 가능</p>
                <p>- 4,000원 쿠폰: 구매 금액 7만원 이상 사용 가능</p>
                <p>- 3,000원 쿠폰: 구매 금액 5만원 이상 사용 가능</p>
                <p>- 이벤트 참여 우선 당첨 기회</p>
                <p>- 무료 주차 혜택: 매장별 유동적 운영</p>
            </div>
        </li>
        <li id="grade02">
            <a href="#grade02" class="btn_tit grade02"><span>골드</span></a>
            <div class="cont">
                <p><strong>선정 기준</strong> - 직전 3개월간 구매 금액 20만원 이상, 30만원 미만</p>
                <p><strong>온라인 쿠폰 혜택</strong></p>
                <p>
                    <img src="${imageServer}/images/mobile/common/3000_1.png" />
                    <img src="${imageServer}/images/mobile/common/2000_1.png" />
                    <img src="${imageServer }/images/mobile/common/free_2.png" />
                </p>
                <p><strong>매장 쿠폰 혜택</strong></p>
                <p>
                    <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/member/10x01.jpg" />
                    <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/member/5x01.jpg" />
                    <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/member/cafex1.jpg" />
                    <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/member/free_car.jpg" />
                </p>
                <p>- 기본 0~1%+추가 3% 적립(2만원 이상 실결제액 기준)</p>
                <p>- 3,000원 쿠폰: 구매 금액 7만원 이상 사용 가능</p>
                <p>- 2,000원 쿠폰: 구매 금액 5만원 이상 사용 가능</p>
                <p>- 이벤트 참여 우선 당첨 기회<p/>
                <p>- 무료 주차 혜택: 매장별 유동적 운영</p>
            </div>
        </li>
        <li id="grade03">
            <a href="#grade03" class="btn_tit grade03"><span>실버</span></a>
            <div class="cont">
                <p><strong>선정 기준</strong> - 직전 3개월간 구매 금액 10만원 이상, 20만원 미만</p>
                <p><strong>온라인 쿠폰 혜택</strong></p>
                <p>
                    <img src="${imageServer}/images/mobile/common/2000_1.png" />
                    <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/member/free_01.jpg" />
                </p>
                <p><strong>매장 쿠폰 혜택</strong></p>
                <p>
                    <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/member/10x01.jpg" />
                    <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/member/free_car.jpg" />
                </p>
                <p>- 기본 0~1%+추가 2% 적립(2만원 이상 실결제액 기준)</p>
                <p>- 2,000원 쿠폰: 구매 금액 5만원 이상 사용 가능</p>
                <p>- 이벤트 참여 우선 당첨 기회<p/>
                <p>- 무료 주차 혜택: 매장별 유동적 운영</p>
            </div>
        </li>
        <li id="grade04">
            <a href="#grade04" class="btn_tit grade04"><span>프렌즈</span></a>
            <div class="cont">
                <p><strong>선정 기준</strong></p>
                <p> - 교보문고/핫트랙스 통합회원</p>
                <p> - 기본 0~1% 적립</p>
            </div>
        </li>
        <li id="grade05">
            <a href="#grade05" class="btn_tit"><span>신규 회원가입</span></a>
            <div class="cont">
                <p><strong>온라인 쿠폰 혜택</strong></p>
                <p>
                    <img src="${imageServer}/images/mobile/common/1000_1.png" />
                    <img src="${imageServer}/images/mobile/common/free_1.png" />
                </p>
                <p> - 회원가입 시 익일 쿠폰 발급</p>
            </div>
        </li>
        <li id="grade06">
            <a href="#grade06" class="btn_tit"><span>통합회원</span></a>
            <div class="cont">
                <p><strong>선정 기준</strong> - 교보문고/핫트랙스 통합회원</p>
                <p><strong>온라인 쿠폰 혜택</strong></p>
                <p>
                    <img src="${imageServer}/images/mobile/common/1000_1.png" />
                    <img src="${imageServer}/images/mobile/common/free_1.png" />
                </p>
                <p> - 동의 확인 시 익일 쿠폰 발급</p>
            </div>
        </li>
    </ul>
    <div class="box_info">
        <p>* 직전 3개월간의 이용내역을 확인하여 매월 1일 새로운 회원등급이 부여됩니다.</p>
        <p>1만원 미만의 구매 내역은 구매횟수로 계산되는 산정기준에서는 제외됩니다 (마일리지 사용액 제외)</p>
    </div>
</div>
<!-- //sub contents -->
</body>
</html>