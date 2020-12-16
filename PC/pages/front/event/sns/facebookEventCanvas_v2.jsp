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

    function showEvent(){
        if($('#event-twitter').css('display') == 'none'){
            $('#event-twitter').slideDown('slow');
        }else{
            $('#event-twitter').slideUp('slow');
        }
    }
</script> 
</head>
<body>
    <div id="event-facebook">
        <a href="http://gift.kyobobook.co.kr/">
            <img src="/images/event/event_sns_top.jpg" width="700px" style="border:0px" />
        </a>
    </div>
    <div id="show-twitter" style="position:relative;top:-40px;left:500px">
        <a href="javascript://" onclick="showEvent()">
            <img src="/images/event/btn_twitter.png" width="100px" style="border:0px" />
        </a>
    </div>
    <div id="event-twitter" style="position:relative;top:-30px;left:0px;display:none;">
        <a href="http://gift.kyobobook.co.kr/">
            <img src="/images/event/event_sns_twitter.jpg" width="700px" style="border:0px" />
        </a>
    </div>
    <div id="event-notice" style="position:relative;top:-30px;left:0px;">
        <a href="http://gift.kyobobook.co.kr/">
            <img src="/images/event/event_sns_notice.jpg" width="700px" style="border:0px" />
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
