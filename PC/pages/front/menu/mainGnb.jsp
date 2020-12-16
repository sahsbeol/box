<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<ui:decorator name="none"/>
<script type="text/javascript">
<!--
$("form[name='searchForm'] input[name='searchTerm']").focus(function() {
    if ($(this).val() == "검색어를 입력해주세요!") {
        $(this).val("");
    }
});

$("form[name='searchForm'] input[name='searchTerm']").blur(function(e) {
    var _str = $(this).val();
    $("div.at_search").hide();
});
//-->
</script>
<!-- Top_util -->
<div id="top_util">
    <div class="inner">
        <!-- 전체카테고리 보기 -->
        <div class="all_view_cate">
            <a href="#list_cate" class="open_cate"><span>전체 카테고리 보기 +</span></a>
            <div id="list_cate" class="list_cate" style="width:100%;height:200px;background-color:Red;display:none">
                임시레이어
            </div>
        </div>
        <!-- //전체카테고리 보기 -->
        <!-- 로그인 정보 -->
        <ul class="top_info">
            <li><a href="javascript://" onclick="login()"><span>로그인</span></a></li>
            <li><a href="javascript://" onclick="goMemJoin()"><span>회원가입</span></a></li>
            <li><a href="${defaultHost}/ht/order/cart"><span>장바구니 <strong class="point01">(2)</strong></span></a></li>
            <li><a href="${defaultHost}/ht/mypage/mypageMain" class="bold"><span>MY HOTTRACKS</span></a></li>
            <li><a href="${defaultHost}/ht/help/helpMain"><span>고객센터</span></a></li>
            <li><a href="${defaultHost}/company/main" target="_blank"><span>매장안내</span></a></li>
        </ul>
        <!-- //로그인 정보 -->
    </div>
</div>
<!-- //Top_util -->
<!-- Header -->
<div id="haeder_wrap" class="main"><!-- 상단광고영역 있을 시 class main 추가 -->
    <div class="inner">
        <h1 class="logo"><a href="/"><span>NEW ME HOTTRACKS</span></a></h1>
        <!-- Ad_pot -->
        <!--
        기본 이미지명 뒤에 xxx_default.xxx
        롤 오버 이미지에 xxx_hover.xxx
        클래스 .roll_img 
        -->
        <div class="ad_pot">
            <c:if test="${not empty listGnb}">
                <ul>
                    <c:forEach items="${listGnb}" var="l">
                        <li><ui:bnr bnrSeq="${l.bnrSeq}" imgAlt="${l.bnrImgAlt}" imgMap="${l.bnrImgMap}" imgUrl="${l.bnrImgUrl}" imgUrl2="${l.bnrImgUrl2}" lnkUrl="${l.bnrLnkUrl}" newWinYn="${l.bnrNewWinYn}" width="200px" height="190px" clazz="roll_img"/></li>
                    </c:forEach>
                </ul>
            </c:if>
        </div>
        <!-- //Ad_pot -->
        <!-- top_search -->
        <div class="top_search">
            <form name="searchForm">
                <fieldset>
                    <div class="search_box">
                        <label for="search_keyword" class="hidden_obj">검색</label><input type="text" id="search_keyword" class="search_keyword" name="searchTerm" value="" title="검색어 입력" />
                        <a href="#" class="search_btn"><span>검색</span></a>
                        <span class="exm_txt">에코백</span>
                    </div>
                    <ul class="search_link">
                        <li><a href="${defaultHost}/ht/welcome/hotEventMain"><span>EVENT</span></a></li>
                        <li><a href="${defaultHost}/ht/hot/brandMain"><span>BRAND</span></a></li>
                        <li><a href="#"><span>SALE</span></a></li>
                        <li><a href="#"><span>BEST</span></a></li>
                    </ul>
                </fieldset>
            </form>
        </div>
        <!-- //top_search -->
        
    </div>
</div>
<!--//Header -->

<!-- Gnb -->
<div id="gnb">
    <ul class="depth01"><!-- 활성화 메뉴에 클래스 on 추가 -->
        <li><a href="${defaultHost}/ht/gift/giftCategoryMain?ctgrId=000020"><span>디자인문구</span></a></li>
        <li><a href="${defaultHost}/ht/gift/giftCategoryMain?ctgrId=000007"><span>고급필기구</span></a></li>
        <li><a href="${defaultHost}/ht/gift/giftCategoryMain?ctgrId=000021"><span>오피스</span></a></li>
        <li><a href="${defaultHost}/ht/gift/giftCategoryMain?ctgrId=000022"><span>디지털</span></a></li>
        <li><a href="${defaultHost}/ht/gift/giftCategoryMain?ctgrId=000023"><span>취미/펫</span></a></li>
        <li><a href="${defaultHost}/ht/gift/giftCategoryMain?ctgrId=000024"><span>가구/수납</span></a></li>
        <li><a href="${defaultHost}/ht/gift/giftCategoryMain?ctgrId=000025"><span>리빙/생활가전</span></a></li>
        <li><a href="${defaultHost}/ht/gift/giftCategoryMain?ctgrId=000026"><span>키친/푸드</span></a></li>
        <li><a href="${defaultHost}/ht/gift/giftCategoryMain?ctgrId=000027"><span>여행/자동차</span></a></li>
        <li><a href="${defaultHost}/ht/gift/giftCategoryMain?ctgrId=000028"><span>패션/뷰티</span></a></li>
        <li><a href="${defaultHost}/ht/gift/giftCategoryMain?ctgrId=000029"><span>유아동</span></a></li>
        <li><a href="${defaultHost}/ht/gift/giftCategoryMain?ctgrId=000030"><span>Pet</span></a></li>
        <li><a href="${defaultHost}/ht/recordMain"><span>CD</span></a></li>
        <li><a href="${defaultHost}/ht/dvdMain"><span>DVD</span></a></li>
    </ul>
    <!--<div id="catelist01" class="depth02">
        <dl>
            <dt><a href="#"><span>menu2</span></a></dt>
            <dd><a href="#"><span>menu2</span></a></dd>
        </dl>
        <!-- Ad pot 
        <p>
            <a href="#">
                <img src="" alt="" />
                <strong>패션의 한수, 주얼리</strong>
            </a>
        </p>
        <!-- //Ad pot
    </div> -->
</div>
<!-- //Gnb -->
