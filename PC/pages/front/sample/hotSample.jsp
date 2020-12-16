<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<html>
<head>
<link rel="stylesheet" type="text/css" href="/css/mygift.css" />
<script type="text/javascript">
jQuery(function($) {
    /* 기념일선택 */
    $("div.select-list")
        .mouseover(function() {
            $(this).find("ul").show();
        })
        .mouseout(function() {
            $(this).find("ul").hide();
        });
});
</script>
</head>
<body>
<div class="page-location">
    <p>현재 페이지 위치</p>
    <ul>
        <li><a href="#">GIFT쇼핑</a> <span>&gt;</span></li>
        <li><strong>MY GIFT STORY</strong></li>
    </ul>
</div><!-- end page-location -->
<div class="my-gift-detail">
    <h3><img src="${imageServer}/images/mygift/h3_my_gift_story.gif" alt="MY GIFT STORY" /></h3>
    <div class="list-sort">
        <ul class="sort">
            <li class="first-child"><a href="#" title="전체보기"><img src="${imageServer}/images/mygift/list_sort01.gif" alt="전체보기" /></a></li>
            <li><a href="#" title="내가 준 선물"><img src="${imageServer}/images/mygift/list_sort02.gif" alt="내가 준 선물" /></a></li>
            <li><a href="#" title="내가 받은 선물"><img src="${imageServer}/images/mygift/list_sort03.gif" alt="내가 받은 선물" /></a></li>
            <li><a href="#" title="주고 싶은 선물"><img src="${imageServer}/images/mygift/list_sort04.gif" alt="주고 싶은 선물" /></a></li>
            <li><a href="#" title="받고 싶은 선물"><img src="${imageServer}/images/mygift/list_sort05.gif" alt="받고 싶은 선물" /></a></li>
            <li><a href="#" title="내가 찜한 상품"><img src="${imageServer}/images/mygift/list_sort06.gif" alt="내가 찜한 상품" /></a></li>
        </ul>
        <div class="select-list">
            <p><a href="#select-list">기념일을 선택하세요</a></p>
            <ul>
                <li><a href="#">토토루 생일</a></li>
                <li><a href="#">친구 생일</a></li>
                <li><a href="#">여친 생일</a></li>
            </ul>
        </div><!-- end list-size -->
    </div><!-- end list-sort -->
    <div class="link-button">
        <a href="#"><img src="${imageServer}/images/mygift/btn_anniversary_register.gif" alt="기념일을 등록하세요" /></a>
        <a href="#"><img src="${imageServer}/images/mygift/btn_mygift_story_write.gif" alt="MY GIFT STORY 쓰기" /></a>
    </div><!-- end link-button -->
    <div class="my-gift-view">
        <p class="my-gift-number"><img src="${imageServer}/images/mygift/text_mygift_story.gif" alt="MY GIFT STORY" /> #10</p>
        <p class="social">
            <a href="#"><img src="${imageServer}/images/common/sidebar_twitter.gif" alt="트위터" /></a> |
            <a href="#"><img src="${imageServer}/images/common/sidebar_facebook.gif" alt="페이스북" /></a> |
            <a href="#"><img src="${imageServer}/images/common/btn_url_copy.gif" alt="URL복사" /></a> |
            <a href="#"><img src="${imageServer}/images/common/btn_html_copy.gif" alt="HTML복사" /></a>
        </p>
        <dl>
            <dt class="subject">제목</dt>
            <dd class="subject">내 서른 번째 생일, 내가 받은 최고의 선물</dd>
            <dt class="when">언제</dt>
            <dd class="when"><span>2010년 9월 10일 내 생일</span>에</dd>
            <dt class="where">어디서</dt>
            <dd class="where"><span>신사동 가로수길 “스테파니”라는 작은 레스토랑</span>에서</dd>
            <dt class="who">누구에게</dt>
            <dd class="who"><span>토토로</span>에게</dd>
            <dt class="gift-subject">GIFT 제목</dt>
            <dd class="gift-subject"><span>[프랭클린플래너] 프레스티지 와인 선물</span>을 받았다.</dd>
            <dt class="gift-photo">GIFT 사진</dt>
            <dd class="gift-photo"><img src="${imageServer}/images/mygift/gift_photo.gif" alt="" /></dd>
            <dt class="memo">메모</dt>
            <dd class="memo">평소에 너무나도 갖고 싶었던 아이템인데, 정말 기분좋다! 고마워, 토토로^^</dd>
        </dl>
        <p class="licence">
            <img src="${imageServer}/images/common/icon_licence01.gif" alt="" />
            <img src="${imageServer}/images/common/icon_licence02.gif" alt="" />
            <img src="${imageServer}/images/common/icon_licence03.gif" alt="" />
        </p>
        <div class="button">
            <a href="#"><img src="${imageServer}/images/mygift/btn_modify.gif" alt="수정" /></a>
            <a href="#"><img src="${imageServer}/images/mygift/btn_delete.gif" alt="삭제" /></a>
            <a href="#"><img src="${imageServer}/images/mygift/btn_list.gif" alt="목록" /></a>
        </div><!-- end button -->
    </div><!-- end my-gift-view -->
</div><!-- end my-gift-detail -->
</body>
</html>