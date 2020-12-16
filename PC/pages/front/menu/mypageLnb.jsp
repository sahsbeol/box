<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<ui:decorator name="none"/>
<script type="text/javascript">
jQuery(function($){
    $(document).ready(function(){
        $('#content').addClass('f_set');//폰트 및 간격 재설정
    });
});
</script>
<!-- mypage_info -->
<c:if test="${not empty user }">
    <div class="mypage_info">
        <div class="member_level">
            <p><em>${user.name}</em>님, 안녕하세요.<br />
            고객님은 현재 <em><ui:userGrade gradeId="${user.gradeId}"/></em>입니다.</p>
            <a href="/ht/help/memberShip" class="more_info"><span>회원혜택안내</span></a>
        </div>
        <ul>
            <li>
                <strong>통합포인트</strong>
                <span><a href="/ht/mypage/totsaved"><fmt:formatNumber value="${userTotPoint}" pattern="#,###"/> 원</a></span>
            </li>
            <li>
                <strong>마일리지</strong>
                <span><a href="/ht/mypage/saved"><fmt:formatNumber value="${userMileage}" pattern="#,###"/> 원</a></span>
            </li>
            <li>
                <strong>온라인 예치금</strong>
                <span><a href="/ht/mypage/deposit"><fmt:formatNumber value="${userDeposit}" pattern="#,###"/> 원</a></span>
            </li>
            <li>
                <strong>쿠폰 / 상품권 등록</strong>
                <span><a href="/ht/mypage/coupon"><fmt:formatNumber value="${userCpnCnt}" pattern="#,###"/> 장</a></span>
            </li>
        </ul>
    </div>
</c:if>
<!-- //mypage_info -->

<!-- lnb -->
<div class="lnb">
    <ul>
        <li><a>주문정보</a>
            <ul class="depth2">
                <li <c:if test="${fn:indexOf(pageContext.request.requestURI,'/orderDelivery') >= 0}"> class="active"</c:if>><a href="/ht/mypage/orderDelivery">주문/배송조회</a></li>
                <li <c:if test="${fn:indexOf(pageContext.request.requestURI,'/orderChange') >= 0}"> class="active"</c:if>><a href="/ht/mypage/orderChange">주문취소/변경</a></li>
                <li <c:if test="${fn:indexOf(pageContext.request.requestURI,'/returnExchange') >= 0}">class="active"</c:if>><a href="/ht/mypage/returnExchange">반품/교환신청</a></li>
                <li <c:if test="${fn:indexOf(pageContext.request.requestURI,'/txinRequest') >= 0}">class="active"</c:if>><a href="/ht/mypage/txinRequest">세금계산서 신청</a></li>
<!--  <c:if test="${not empty user}"><li><a href="/ht/mypage/addressManagement">주소록 관리</a></li></c:if> -->
            </ul>
        </li>
        <li><a>계좌정보</a>
            <ul class="depth2">
                <c:if test="${not empty user}"><li <c:if test="${fn:indexOf(pageContext.request.requestURI,'/totsaved') >= 0}">class="active"</c:if>><a href="/ht/mypage/totsaved">통합포인트</a></li></c:if>
                <c:if test="${not empty user}"><li <c:if test="${fn:indexOf(pageContext.request.requestURI,'/saved') >= 0}">class="active"</c:if>><a href="/ht/mypage/saved">마일리지</a></li></c:if>
                <li <c:if test="${fn:indexOf(pageContext.request.requestURI,'/deposit') >= 0}">class="active"</c:if>><a href="/ht/mypage/deposit">핫트랙스 온라인 예치금</a></li>
                <c:if test="${not empty user}"><li <c:if test="${fn:indexOf(pageContext.request.requestURI,'/coupon') >= 0}">class="active"</c:if>><a href="/ht/mypage/coupon">쿠폰/상품권 등록</a></li></c:if>
            </ul>
        </li>
        <c:if test="${not empty user}">
            <li><a>쇼핑리스트</a>
                <ul class="depth2">
                    <li class="listWishProduct"><a href="/ht/mypage/listWishProduct">좋아요♥ 상품</a></li>
                    <li class="listWishBrand"><a href="/ht/mypage/listWishBrand">좋아요♥ 브랜드</a></li>
                    <li <c:if test="${fn:indexOf(pageContext.request.requestURI,'/myPageCommentListPage') >= 0}">class="active"</c:if>><a href="/ht/mypage/commentList">내 상품평 관리</a></li>
                </ul>
            </li>
        </c:if>
        <li><a>쇼핑도우미</a>
            <ul class="depth2">
                <c:if test="${not empty user}"><li <c:if test="${fn:indexOf(pageContext.request.requestURI,'/questionList') >= 0}">class="active"</c:if>><a href="/ht/mypage/questionList">상품 Q&amp;A</a></li></c:if>
                <li <c:if test="${fn:indexOf(pageContext.request.requestURI,'/listSosCounsel') >= 0}">class="active"</c:if>><a href="/ht/mypage/listSosCounsel">SOS상담</a></li>
                <c:if test="${not empty user}"><li <c:if test="${fn:indexOf(pageContext.request.requestURI,'/myEventList') >= 0}">class="active"</c:if>><a href="/ht/mypage/myEventList">참여이벤트</a></li></c:if>
            </ul>
        </li>
        <%-- <c:if test="${not empty user}">
            <li><a href="#">마이리스트</a>
                <ul class="depth2">
                    <li><a href="/ht/mypage/myListRecordList">담은 음반</a></li>
                    <li><a href="/ht/mypage/myListDvdList">담은 BLU-RAY/DVD</a></li>
                </ul>
            </li>
        </c:if> --%>
    </ul>
    <c:if test="${not empty user}">
        <div class="btn_area">
            <a href="javascript://" class="btn_member_modify" onclick="goModifyMemInfo()"><span>회원정보수정</span></a>
            <a href="javascript://" class="btn_member_leave" onclick="goDeleteMemInfo()"><span>회원탈퇴</span></a>
        </div>
    </c:if>
</div>
<!-- //lnb -->