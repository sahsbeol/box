<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui"%>
<ui:decorator name="none"/>
<script type="text/javascript">
jQuery(function($){
    $(document).ready(function(){
        $('#content').addClass('f_set');//폰트 및 간격 재설정
    });
});
</script>
<!-- lnb -->
<div class="lnb">
    <ul>
        <li><a href="/ht/help/sosCounselMain">SOS상담</a></li>
        <li><a>공지/문의</a>
            <ul class="depth2">
                <li><a href="/ht/help/listNotice">공지사항</a></li>
                <li><a href="/ht/help/eventPrizeList">이벤트 당첨자</a></li>
                <li><a href="/ht/help/vendorInquiry">상품입점문의</a></li>
                <li><a href="/ht/help/businessBuy">대량구매상담</a></li>
            </ul>
        </li>
        <li><a>서비스안내</a>
            <ul class="depth2">
                <li><a href="/ht/help/memberShip">통합 멤버십</a></li>
                <li><a href="/ht/help/savePointByOffBill">영수증 적립 서비스</a></li>
                <li><a href="/ht/help/carvingService">각인 서비스</a></li>
                <li><a href="/ht/help/packingService">포장 서비스</a></li>
                <li><a href="/ht/help/cardInfo">제휴/할인 카드</a></li>
            </ul>
        </li>
        <li><a>주문 FAQ</a>
            <ul class="depth2">
                <li><a href="/ht/help/faqListC0391">주문결제</a></li>
                <li><a href="/ht/help/faqListC0392">배송</a></li>
                <li><a href="/ht/help/faqListC0393">반품/교환/환불</a></li>
                <li><a href="/ht/help/faqListC0394">세금계산서/증빙</a></li>
            </ul>
        </li>
        <li><a>회원 FAQ</a>
            <ul class="depth2">
                <li><a href="/ht/help/faqListC0401">회원정보</a></li>
                <li><a href="/ht/help/faqListC0402">통합포인트/예치금/쿠폰</a></li>
                <li><a href="/ht/help/faqListC0403">상품문의</a></li>
                <li><a href="/ht/help/faqListC0404">이벤트</a></li>
            </ul>
        </li>
        <li><a>기타 FAQ</a>
            <ul class="depth2">
                <li><a href="/ht/help/faqListC0411">영업점</a></li>
                <li><a href="/ht/help/faqListC0412">사이트이용/장애</a></li>
                <li><a href="/ht/help/faqListC0413">기타</a></li>
            </ul>
        </li>
    </ul>
</div>
<!-- //lnb -->