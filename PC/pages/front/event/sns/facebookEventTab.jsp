<%@ page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
<title>핫트랙스</title>
<script type="text/javascript" src="/js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="/js/jquery.tools.min.js"></script>
<script src="http://connect.facebook.net/ko_KR/all.js#appId=243968305632817&amp;xfbml=1"></script>
<script src="http://connect.facebook.net/ko_KR/all.js#xfbml=1"></script>
<script type="text/javascript">
window.fbAsyncInit = function(){
    FB.Canvas.setAutoResize();
};

jQuery(function($){
    $("#show-facebook").toggle(function(e){
        e.preventDefault();
        $('#event-facebook').slideDown('slow');
    },function(e){
        e.preventDefault();
        $('#event-facebook').slideUp('slow');
    });

    $("#show-twitter").toggle(function(e){
        e.preventDefault();
        $('#event-twitter').slideDown('slow');
    },function(e){
        e.preventDefault();
        $('#event-twitter').slideUp('slow');
    });
});
function openTweet(){
    var url = 'http://twitter.com/intent/tweet';

    var colon = '%3A';
    var slush = '%2F';
    var link = 'http'+colon+slush+slush+'gift.kyobobook.co.kr';
    var text = '아이패드2증정!!핫트랙스온라인몰오픈!!핫트랙스는 OOO다.';
    var via = 'hottracks_on';
    var lang = 'us';
    var param = '?text='+encodeURIComponent(text)+'&url='+link+'&via='+via+'&lang='+lang;

    var target = '_twitter';
    window.open(url+param, target, 'width=800,height=500,scrollbars=yes');
}

function openFollow(){
    var url = 'https://twitter.com/intent/user?screen_name=hottracks_on';

    var user_id = 'hottracks_on';

    var target = '_twitter';
    window.open(url, target, 'width=800,height=500,scrollbars=yes');
}
</script> 
</head>
<body style="overflow:hidden;margin:0 0 0;padding:0 0 0 0;"><!--   -->
    <div id="event-sns" style="width:480px"/>
            <img src="/images/event/event_sns_500_1.jpg" width="500px" style="border:0px" usemap="#eventImageMap" />
            <map name="eventImageMap">
                <area id="show-facebook" shape="rect" coords="20,825,245,865" href="#" onFocus="this.blur()">
                <area id="show-twitter" shape="rect" coords="255,825,480,865" href="#" onFocus="this.blur()">
                <area shape="rect" coords="0,0,500,880" href="/ht/biz/eventDetail?eventId=11259" target="_mall" onFocus="this.blur()">
            </map>
    </div>
    <div id="event-facebook" style="width:480px;position:relative;top:-1px;left:0px;display:none;">
        <a href="/ht/biz/eventDetail?eventId=11259" target="_mall">
            <img src="/images/event/event_sns_500_2.jpg" width="500px" style="border:0px" />
        </a>
    </div>
    <div id="event-twitter" style="width:480px;position:relative;top:-1px;left:0px;display:none;">
        <a href="/ht/biz/eventDetail?eventId=11259" target="_mall">
            <img src="/images/event/event_sns_500_3.jpg" width="500px" style="border:0px" />
        </a>
    </div>
    <div id="event-notice" style="width:480px;position:relative;top:-5px;left:0px;">
        <a href="/ht/biz/eventDetail?eventId=11259" target="_mall">
            <img src="/images/event/event_sns_500_4.jpg" width="500px" style="border:0px" />
        </a>
    </div>
    <div id="fb-root"></div>
    <fb:like href="http://www.facebook.com/onlinehottracks" width="450px" send="true" show_faces="true" font=""></fb:like>
    <div id="fb-root"></div>
    <fb:comments href="http://www.facebook.com/onlinehottracks" num_posts="20" width="450"></fb:comments>
</body>
</html>
