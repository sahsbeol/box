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
</script> 
</head>
<body>
    <div id="event-sns" style="width:700px"/>
        <img src="/images/event/event_sns_700_1.jpg" width="700px" style="border:0px" usemap="#eventImageMap" />
        <map name="eventImageMap">
            <area id="show-facebook" shape="rect" coords="60,1170,340,1220" href="#" onFocus="this.blur()">
            <area id="show-twitter" shape="rect" coords="360,1170,640,1220" href="#" onFocus="this.blur()">
            <area shape="rect" coords="0,0,700,1266" href="/ht/biz/eventDetail?eventId=11259" target="_mall" onFocus="this.blur()">
        </map>
    </div>
    <div id="event-facebook" style="width:700px;position:relative;top:-1px;left:0px;display:none;">
        <a href="/ht/biz/eventDetail?eventId=11259" target="_mall">
            <img src="/images/event/event_sns_700_2.jpg" width="700px" style="border:0px" />
        </a>
    </div>
    <div id="event-twitter" style="width:700px;position:relative;top:-1px;left:0px;display:none;">
        <a href="/ht/biz/eventDetail?eventId=11259" target="_mall">
            <img src="/images/event/event_sns_700_3.jpg" width="700px" style="border:0px" />
        </a>
    </div>
    <div id="event-notice" style="width:700px;position:relative;top:-5px;left:0px;">
        <a href="/ht/biz/eventDetail?eventId=11259" target="_mall">
            <img src="/images/event/event_sns_700_4.jpg" width="700px" style="border:0px" />
        </a>
    </div>
    <div>
        <div id="fb-root"></div>
        <fb:like href="http://www.facebook.com/onlinehottracks" width="700px" send="true" show_faces="true" font=""></fb:like>
        <div id="fb-root"></div>
        <fb:comments href="http://www.facebook.com/onlinehottracks" num_posts="20" width="700"></fb:comments>
    </div>
</body>
</html>
