<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="none"/>
<script type="text/javascript">
<!--
jQuery(function($){
    $("#cate-menu").swipeleft(function($){
        closeGnbMenu();
    });
    
    $(".cate_tab .tab_navi a").click(function(e){
        e.preventDefault();
        $(".cate_tab .tab_navi a.active").removeClass("active");
        $(".cate_tab .tab_item.active").removeClass("active");
        $(this).addClass("active");
        $($(this).attr("href")).addClass("active");
    });
    
    $(".snb-item > a").click(function(e){
        e.preventDefault();
        if($($(this).attr("href")).hasClass("active")){
            $(".snb-item.active").removeClass("active");
        }else{
            $(".snb-item.active").removeClass("active");
            $($(this).attr("href")).addClass("active");
        }
    });
    
    if("${alarmCnt}" == "0"){
        $("#cate-menu-box div div.btn_box a.btn_alarm.noover span em.col_orange").hide();
    }else
    	$("#cate-menu-box div div.btn_box a.btn_alarm.noover span em.col_orange").show();
    
    // 메인배너
    var welcomeSwiper = new Swiper('.swipe-sub .swiper-container',{
        pagination: '.swipe-sub div.pagination',
        loop:true,
        grabCursor: true,
        paginationClickable: true,
        autoplay: 3000,
        autoplayDisableOnInteraction: false
    });
    
});

function tglSmneu(ctgrId){
    if($("#lnbMenu").hasClass("active")){
        $("#lnbSmenu").load("/m/hot/smenu?ctgrId="+ctgrId, function (){
            $("#lnbMenu").removeClass("active");
            $("#lnbSmenu").addClass("active");
        });
    }else{
        $("#lnbSmenu").removeClass("active");
        $("#lnbMenu").addClass("active");
    }
}
//-->
</script>
<style>
a.bnr_todaysub {
	width:100%; text-align:center;
}
a.bnr_todaysub img {
	width:100%; max-width:660px; text-align:center;
}
</style>
<div id="cate-menu" class="ly_base">
    <div id="cate-menu-box">
        <div class="side_gnb">
            <div class="info_box">
                <c:choose>
                    <c:when test="${not empty loginOrderNum}">
                        <a href="#" onclick="logout();return false;" class="btn_join">로그아웃</a>
                    </c:when>
                    <c:when test="${isLogin}">
                        <span class="member">
                            <strong>${user.userName}</strong>님
                            <a href="#" onclick="location.href='/m/help/memberShip';return false;" class="btn_grade">
                                <c:if test="${user.userGradeId eq '01'}">프렌즈</c:if>
                                <c:if test="${user.userGradeId eq '02'}">실버</c:if>
                                <c:if test="${user.userGradeId eq '03'}">골드</c:if>
                                <c:if test="${user.userGradeId eq '04'}">플래티넘</c:if>
                                <c:if test="${user.userGradeId eq '99'}">직원</c:if>
                            </a>
                        </span>
                        <!-- 
                        <a href="#" onclick="logout();return false;" class="btn_join">로그아웃</a>
                        -->
                    </c:when>
                    <c:otherwise>
                        <a href="#" onclick="login();return false;" class="btn_login">로그인</a>
                        <a href="#" onclick="join();return false;" class="btn_join">회원가입</a>
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="btn_box">
                <a href="#" onclick="location.href='${defaultHost}/m/help/listAlarm';return false;" class="btn_alarm noover">
                    <span><fmt:formatNumber type="number" value="${alarmCnt}"/></span>
                </a>
                <a href="#" onclick="goSetting();return false;" class="btn_setting">환경설정</a>
            </div>
        </div>
        <!-- .util -->
        <ul class="side_menu">
            <li><a href="#" onclick="location.href='${defaultHost}/m/mypage/main';return false;" class="side_menu05 MB_SIDE_TOP_1">마이핫트랙스</a></li>
            <li><a href="#" onclick="location.href='${defaultHost}/m/mypage/orderDelivery';return false;" class="side_menu03 MB_SIDE_TOP_2">주문/배송</a></li>
            <li><a href="#" onclick="location.href='${defaultHost}/m/order/cart';return false;" class="side_menu04 MB_SIDE_TOP_3">장바구니</a></li>
        </ul>
        <!-- //.util -->
       	              	
        <div class="cate active" id="lnbMenu" style="margin:0px;">
            <ul>
                <li>
                    <a href="#" class="MB_SIDE_CATE_1" onclick="tglSmneu('000020');return false;"><em class="disc"><img src="${imageServer}/images/app/menu/ic_cate000020_off02.png" alt="디자인문구"/></em><span>디자인문구</span></a>
                    <a href="#" class="MB_SIDE_CATE_3" onclick="tglSmneu('000022');return false;"><em class="disc"><img src="${imageServer}/images/app/menu/ic_cate000022_off02.png" alt="디지털"/></em><span>디지털</span></a>
                </li>
                <li>
                    <a href="#" class="MB_SIDE_CATE_2" onclick="tglSmneu('000007');return false;"><em class="disc"><img src="${imageServer}/images/app/menu/ic_cate000007_off02.png" alt="고급필기구"/></em><span>고급필기구</span></a>
                    <a href="#" class="MB_SIDE_CATE_4" onclick="tglSmneu('000021');return false;"><em class="disc"><img src="${imageServer}/images/app/menu/ic_cate000021_off02.png" alt="오피스"/></em><span>오피스</span></a>
                </li>
                <li>
                    <a href="#" class="MB_SIDE_CATE_7" onclick="tglSmneu('000025');return false;"><em class="disc"><img src="${imageServer}/images/app/menu/ic_cate000025_off02.png" alt="리빙/생활가전"/></em><span>리빙/생활가전</span></a>
                    <a href="#" class="MB_SIDE_CATE_9" onclick="tglSmneu('000026');return false;"><em class="disc"><img src="${imageServer}/images/app/menu/ic_cate000026_off02.png" alt="키친/푸드"/></em><span>키친/푸드</span></a>
                </li>
                <li>
                    <a href="#" class="MB_SIDE_CATE_8" onclick="tglSmneu('000024');return false;"><em class="disc"><img src="${imageServer}/images/app/menu/ic_cate000024_off02.png" alt="가구/수납"/></em><span>가구/수납</span></a>
                    <a href="#" class="MB_SIDE_CATE_11" onclick="tglSmneu('000028');return false;"><em class="disc"><img src="${imageServer}/images/app/menu/ic_cate000028_off02.png" alt="패션잡화"/></em><span>패션잡화</span></a>
                </li>
                <li>
                    <a href="#" class="MB_SIDE_CATE_12" onclick="tglSmneu('000006');return false;"><em class="disc"><img src="${imageServer}/images/app/menu/ic_cate000006_off02.png" alt="뷰티/헬스"/></em><span>뷰티/헬스</span></a>
                    <a href="#" class="MB_SIDE_CATE_10" onclick="tglSmneu('000027');return false;"><em class="disc"><img src="${imageServer}/images/app/menu/ic_cate000027_off02.png" alt="여행/자동차"/></em><span>여행/자동차</span></a>
                </li>
                <li>
                    <a href="#" class="MB_SIDE_CATE_5" onclick="tglSmneu('000023');return false;"><em class="disc"><img src="${imageServer}/images/app/menu/ic_cate000023_off02.png" alt="취미/펫"/></em><span>취미/펫</span></a>
                    <a href="#" class="MB_SIDE_CATE_13" onclick="tglSmneu('000029');return false;"><em class="disc"><img src="${imageServer}/images/app/menu/ic_cate000029_off02.png" alt="유아동"/></em><span>유아동</span></a>
                </li>
                <li>
                    <a href="#" class="MB_SIDE_CATE_14" onclick="location.href='${defaultHost}/m/biz/eventDetail?eventId=47389';return false;"><em class="disc"><img src="${imageServer}/images/app/menu/ic_sohot_off02.png" alt="직수입&PB"/></em><span>직수입&PB</span></a>
                    <a href="#" class="MB_SIDE_CATE_15" onclick="tglSmneu('0003');return false;"><em class="disc"><img src="${imageServer}/images/app/menu/ic_cate0003_off02.png" alt="CD"/></em><span>CD</span></a>
                </li>
                <li>
                    <a href="#" class="MB_SIDE_CATE_16" onclick="tglSmneu('0004');return false;"><em class="disc"><img src="${imageServer}/images/app/menu/ic_cate0004_off02_01.png" alt="DVD"/></em><span>DVD</span></a>
                    <a href="#"></a>
                </li>
            </ul>
            <ul style="margin:0 0 160px 0;">
            	<li>
                    <a href="#" class="MB_SIDE_ANNOUNCE_1" onclick="location.href='${defaultHost}/m/help/listNotice';return false;"><em class="disc"><img src="${imageServer}/images/mobile/menu/icon_menu_01_02.png" alt="공지사항"/></em><span>공지사항</span></a>
                    <a href="#" class="MB_SIDE_ANNOUNCE_2" onclick="location.href='${defaultHost}/m/help/main';return false;"><em class="disc"><img src="${imageServer}/images/mobile/menu/icon_menu_02_02.png" alt="고객센터"/></em><span>고객센터</span></a>
                </li>
                <li>
                    <a href="#" class="MB_SIDE_ANNOUNCE_3" onclick="location.href='${defaultHost}/m/help/listStore';return false;"><em class="disc"><img src="${imageServer}/images/mobile/menu/icon_menu_03_02.png" alt="매장안내"/></em><span>매장안내</span></a>
                    <a href="#" class="MB_SIDE_ANNOUNCE_4" onclick="location.href='${defaultHost}/m/help/signMain';return false;"><em class="disc"><img src="${imageServer}/images/mobile/menu/icon_menu_04_02.png" alt="사인회안내"/></em><span>사인회안내</span></a>
                </li>
                <li>
                    <a href="#" class="MB_SIDE_ANNOUNCE_5" onclick="location.href='${defaultHost}/m/hot/eventMain?orderBy=&ctgrId=0000&eventDispTypeCode=C0213';return false;"><em class="disc"><img src="${imageServer}/images/mobile/menu/icon_menu_05_02.png" alt="참여이벤트"/></em><span>참여이벤트</span></a>
                    <a href="#" class="MB_SIDE_ANNOUNCE_6" onclick="location.href='${defaultHost}/m/help/listEventPrize';return false;"><em class="disc"><img src="${imageServer}/images/mobile/menu/icon_menu_06_02.png" alt="당첨자발표"/></em><span>당첨자발표</span></a>
                </li>
            </ul>
        </div>
        <div class="cate" id="lnbSmenu"></div>
        
    </div>
    <div id="cate-close-box" onclick="closeGnbMenu()">
        <a href="#" onclick="return false;">메뉴 레이어 닫기</a>
    </div>
</div>
<!-- //#util -->
