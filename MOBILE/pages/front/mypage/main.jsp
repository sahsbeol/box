<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<html>
<head>
<script type="text/javascript" src="/js/jquery-barcode.min.js"></script>
<script type="text/javascript" src="/js/jquery.form.js"></script>
<style type="text/css">
div#content div.my_point div.my_info div.btn_box { position: absolute; width: 30px; top: -10px; right: 10px; text-align: right; }
div#content div.my_point div.my_info div.btn_box a.btn_alarm.noover { text-indent: 0px; }
div#content div.my_point div.my_info div.btn_box a.btn_alarm.noover span{ display: inline-block; width: 40px; height: 40px; border-radius: 20px;}
div#content div.my_point div.my_info div.btn_box a.btn_alarm.noover span em.col_red {position: relative;display: inline-block;border:none;color: #fff !important;background-color:#da2128; min-width: 12px; min-height: 12px; 
 font-size: 0.5rem; letter-spacing: 0px;border-radius: 50%;text-align: center;right: -20px;bottom: -1px; line-height:12px; font-weight : bold; }
div.ly_conts{ display: block; margin: auto; padding:10px 0;text-align: center; position: relative; top: 50%; margin-top: -65px; overflow: visible; background-color: #fff; border-radius: 5px; border: 2px solid #ff4400; }
div.ly_box .ly_conts{top : 48%; overflow: visible;}
div.btn_white_l { position: absolute; top : -27px; right: 5px;display:block;background:url('http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/renewal/common/btn_close04.png') no-repeat 50% 50%;background-size:25px; text-overflow:ellipsis;text-indent:-999px;text-align:left; width : 20px; height : 20px;}
</style>
<script type="text/javascript">
jQuery(function($){
    $(document).ready(function(){
        $('body').css("overflow-x", "hidden");//상단 mini 모드
        $('#wrap').addClass('mypage_main');//마이페이지 재설정
        $("#barcode").barcode("${user.userNum}", "code128",{barWidth:2, barHeight:30});
    });
    
    var recentProd = new Swiper('#recentProd .swiper-container',{
        pagination: '#recentProd .pagination',
        watchOverflow: true,
        grabCursor: true,
        paginationClickable: true
    });
    
    var wishBrand = new Swiper('#wishBrand .swiper-container',{
        pagination: '#wishBrand .pagination',
        watchOverflow: true,
        grabCursor: true,
        paginationClickable: true
    });
    
    if("${alarmCnt}" == "0"){
        $("a.btn_alarm.noover span em.col_red").hide();
    }else{
        $("a.btn_alarm.noover span em.col_red").show();
    }
});

function showBarcode(){
    if($(".ly_box").hasClass("active")){
        $(".ly_box").removeClass("active");
        $(".ly_box").hide();
        $(".btn_white_l").hide();
    }else{
        $(".ly_box").addClass("active");
        $(".ly_box").show();
        $(".btn_white_l").show();
    }
}
function closeBarcode(){
    $(".ly_box").hide();
    $(".btn_white_l").hide();
    return false;
}

</script>
</head>
<body>
<div class="mb30">
    <div class="my_point">
        <div class="my_info">
            <dl>
                <dt>
                    <c:if test="${user.userGradeId eq '01'}"><c:set var="gradeName" value="프렌즈"/></c:if>
                    <c:if test="${user.userGradeId eq '02'}"><c:set var="gradeName" value="실버"/></c:if>
                    <c:if test="${user.userGradeId eq '03'}"><c:set var="gradeName" value="골드"/></c:if>
                    <c:if test="${user.userGradeId eq '04'}"><c:set var="gradeName" value="플래티넘"/></c:if>
                    <c:if test="${user.userGradeId eq '99'}"><c:set var="gradeName" value="직원"/></c:if>
                    <em class="ic_medal" id="grade${user.userGradeId}">${gradeName}</em>
                    <a href="/m/help/memberShip" class="btn arrow01">등급혜택</a>
                </dt>
                <dd>
                    <p class="txt"><strong>${user.userName}</strong>회원님 ^0^ <br/><strong class="col_red">반갑구만 반가워요~! &gt;0&lt;</strong></p>
                    <a href="#" onclick="showBarcode();return false;" class="btn barcode">회원바코드</a>
                </dd>
            </dl>
            <div class="ly_box" onclick="showBarcode()">
                <div class="ly_conts">
                    <p class="t_c">통합포인트1</p>
                    <div id="barcode" style="margin:10px auto;width:300px"></div>
                    <hr class="line01"/>
                    <p class="tit t_c">가용포인트</p>
                    <p class="round_orange"><strong><fmt:formatNumber type="number" value="${totalPointAmt}"/></strong>점</p>
                    <a href="/m/mypage/totsaved" class="txt">포인트 내역 상세조회</a>
                    <div onclick="closeBarcode();" class="btn_white_l">닫기</div>
                </div>
            </div>
            <div class="btn_box">
                <a href="/m/help/listAlarm" class="btn_alarm noover"><span><em class="col_red"><fmt:formatNumber type="number" value="${alarmCnt}"/></em></span></a>
                <!--<a href="#" onclick="goSetting();return false;" class="btn_setting"> 설정 바로가기 </a>-->
            </div>
        </div>
        <ul class="my_point_list">
            <li>
                <a href="/m/mypage/totsaved">
                    <strong>통합포인트</strong>
                    <span><em class="col_red"><fmt:formatNumber type="number" value="${totalPointAmt}"/></em>p</span>
                </a>
            </li>
            <li>
                <a href="/m/mypage/deposit">
                    <strong>예치금</strong>
                    <span><em class="col_red"><fmt:formatNumber type="number" value="${depositParam.totalDepositAmount}"/></em>원</span>
                </a>
            </li>
            <li>
                <a href="/m/mypage/coupon" style="position:relative; top : 10px;">
                    <strong>쿠폰</strong>
                    <%-- <span><em class="col_red"><fmt:formatNumber type="number" value="${couponCount}"/></em>장</span> --%>
                </a>
            </li>
            <li>
                <a href="/m/offLine/listReceipt" style="position:relative; top : 5px;">
                    <strong>영업점<br/>영수증</strong>
                </a>
            </li>
        </ul>
    </div>
    <div class="my_point_menu">
        <ul>
            <li><a href="/m/order/cart">장바구니 <span class="col_red">(<fmt:formatNumber type="number">${cartCount}</fmt:formatNumber>)</span></a></li>
            <li><a href="/m/mypage/orderDelivery">주문/배송조회 <span class="col_red">(<fmt:formatNumber type="number">${orderCount}</fmt:formatNumber>)</span></a></li>
            <li><a href="/m/mypage/wishProduct">좋아요♥<span class="col_red">(<fmt:formatNumber type="number">${countWishPrdt}</fmt:formatNumber>)</span></a></li>
        </ul>
    </div>
    <table class="my_point_table" >
        <colgroup>
            <col width="33%"/>
            <col width="34%"/>
            <col width="*"/>
        </colgroup>
        <tbody> 
            <tr>
                <td><a href="/m/mypage/listMyReview"><strong>내 상품평</strong> <em class="col_red">(<fmt:formatNumber type="number" value="${myComment}"/>)</em></a></td>
                <td><a href="/m/help/listAlarm"><strong>알림함</strong> <em class="col_red">(<fmt:formatNumber type="number" value="${alarmCnt}"/>)</em></a></td>
                <td><a href="/m/help/listSosCounsel"><strong>1:1 문의</strong></a></td>
            </tr>
            <tr>
                <td><a href="/m/mypage/orderDelivery?orderTermType=0&orderStatusCode=C0125"><strong>취소/반품/교환</strong></a></td>
                <td><a href="/m/mypage/questionList"><strong>나의 Q&A </strong></a></td>
                <td><a href="/m/mypage/listMyEvent"><strong>이벤트 참여 </strong></a></td>
            </tr>
        </tbody>
    </table>
    <!--  최근 본 상품 -->
    <%-- <div class="my_point_menu03">
        <h5 class="tit" ><span class="col_red">최근</span> 본 상품 (<fmt:formatNumber type="number">${countRecentPrdt}</fmt:formatNumber>)</h5>
        <div class="swipe-main" id="recentProd">
            <div class="swiper-container">
                <ul class="swiper-wrapper">
                    <c:forEach items="${listRecentPrdt}" varStatus="s1" end="8" step="3" >
                        <li class="swiper-slide" >
                            <c:forEach items="${listRecentPrdt}" var="l" begin="${s1.index}" end="${s1.index+2}">
                                <c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G' || l.sellPrdtGbn eq 'S'}"> 
                                    <a href="/m/gift/detail/${l.sellPrdtBcode}" class="pic"><ui:image src="${l.productImageUrl}" server="product" alt="${fn:escapeXml(l.prdtName)}" /></a>
                                </c:if>
                                <c:if test="${l.sellPrdtGbn eq 'R' || l.sellPrdtGbn eq 'D'}">
                                    <a href="/m/record/detail/${l.sellPrdtBcode}" class="pic<c:if test="${l.sellPrdtGbn eq 'D'}"> dvd</c:if>"><ui:image prdtGbn="${l.sellPrdtGbn}" rcrdCd="${l.rcrdCd}" ratingCode="A" alt="${fn:escapeXml(l.prdtName)}"/></a>
                                </c:if>
                            </c:forEach>
                        </li>
                    </c:forEach>
                </ul>
            </div> <!-- container -->
            <div class="pagination"></div>
        </div>
        <a href="/m/mypage/recentProduct" class="btn_more">더보기</a>
    </div>
    <!--  좋아요 브랜드 -->
    <div class="my_point_menu03">
        <h5 class="tit" ><span class="col_red">좋아요<img src="${imageServer }/images/mobile/common/icon_heart02.png" style="width:12px;height:12px;"/></span> 브랜드 (<fmt:formatNumber type="number">${countWishBrand}</fmt:formatNumber>)</h5>
        <div class="swipe-main" id="wishBrand">
            <div class="swiper-container">
                 <ul class="swiper-wrapper">
                    <c:forEach items="${listWishBrand}" varStatus="s1" end="8" step="3" >
                        <li class="swiper-slide" >
                            <c:forEach items="${listWishBrand}" var="l" begin="${s1.index}" end="${s1.index+2}">
                                <a href="/m/hot/brandDetail?brandId=${l.brandId}" class="pic"><ui:image src="${l.productImageUrl}" server="product" alt="${fn:escapeXml(l.brandEngName)}" /></a>
                            </c:forEach>
                        </li>
                    </c:forEach>
                 </ul>
            </div>
            <div class="pagination"></div>
        </div>
        <a href="/m/mypage/wishBrand" class="btn_more">더보기</a>
    </div> --%>
    <p class="info">* 회원정보수정은 회원통합관리 정책에 따라 모바일교보문고에서 가능합니다. 교환/반품 신청은 PC버전에서만 가능합니다.</p>
    <p class="info"><strong>* 회원정보를 수정하시는 경우, 재로그인 하셔야 변경된 정보가 반영됩니다.</strong></p>
    <div class="btn_area box_flex mt20">
        <a href="/m/help/main" class="btn btn_type01 br_red">고객센터</a>
        <a href="#" onclick="goModifyMemInfo();return false;" class="btn btn_type01 br_484848">회원정보 수정</a>
    </div>
    <c:if test="${empty device}">
        <div class="btn_area box_flex mt10">
            <a href="#" onclick="logout();return false;" class="btn btn_type01 bg_red">로그아웃</a>
        </div>
    </c:if>
</div>
</body>
</html>
