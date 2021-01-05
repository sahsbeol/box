<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="none"/>
<script type="text/javascript">
jQuery(function($){
    $.ajax({
        url: '//admin.hottracks.co.kr/admin/system/hotSiteClickCheck2'
        ,dataType: 'jsonp'
        ,jsonpCallback: "callback"
        ,success: function(data) {
        }
    });
});

var _gaq = _gaq || [];
_gaq.push(['_setAccount', 'UA-968575-10']);
_gaq.push(['_trackPageview']);

(function() {
  var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
  ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
  var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
})();
</script>

<!-- 공통 적용 스크립트 , 모든 페이지에 노출되도록 설치. 단 전환페이지 설정값보다 항상 하단에 위치해야함 --> 
<script type="text/javascript" src="//wcs.naver.net/wcslog.js"> </script> 
<script type="text/javascript"> 
if (!wcs_add) var wcs_add={};
wcs_add["wa"] = "s_3b427c425785";
if (!_nasa) var _nasa={};
wcs.inflow();
wcs_do(_nasa);
</script>

<!-- 레코벨 스크립트 -->
<script type="text/javascript">
	var userId= getCookie("UserCookieKey");

	window._eglqueue = window._eglqueue || [];
	_eglqueue.push(['setVar','cuid','e15e978e-3623-4892-bf0a-485b9f8196ee']);
	_eglqueue.push(['setVar','userId',SHA256(userId)]); // optional
	_eglqueue.push(['track','visit']);
	(function(s,x){s=document.createElement('script');s.type='text/javascript';
	s.async=true;s.defer=true;s.src=(('https:'==document.location.protocol)?'https':'http')+'://logger.eigene.io/js/logger.min.js';
  x=document.getElementsByTagName('script')[0];x.parentNode.insertBefore(s, x);})();
</script>
<!-- 레코벨 스크립트 끝 -->
<style>
#footer .ic_mark a{
	text-align: center;
    margin: 15px 0 10px 0;
}
#footer .ic_mark a img{
	width: 40px;
    float: left;
}
#footer .ic_mark a p{
	float: left;
    text-align: left;
    padding: 10px 8px;
    font-weight: bold;
    font-size: 12px;
}
#footer .sns_box {
    margin: 0 0 100px 0;
    text-align: center;
}
</style>

<!-- //#footer -->
<div id="footer">
    <ul class="finfo">
        <li style="line-height:20px;">
            <a style="font-size:1.1em;color:#757575;font-weight:bold;" href="#" onclick="location.href='${defaultHost}/m/rule';return false;">이용약관</a>
            <a style="font-size:1.1em;color:#000;font-weight:bold;margin-left:15px;" href="#" onclick="location.href='${defaultHost}/m/privacy';return false;">개인정보처리방침</a>
            <a style="font-size:1.1em;color:#da2128;font-weight:bold;margin-left:15px;" href="#" onclick="location.href='${defaultHost}/heart';return false;">핫트합니다</a>
            <a style="font-size:1.1em;color:#757575;font-weight:bold;margin-left:15px;" href="#" onclick="location.href='${defaultHost}/m/help/main';return false;">고객센터</a>
            <a style="font-size:1.1em;color:#757575;font-weight:bold;margin-left:15px;" href="#" onclick="showPcVer();return false;">PC화면</a>
        </li>
        <li class="mt10" style="line-height:16px;letter-spacing:-0.3px">교보핫트랙스㈜ 대표이사 오교철 사업자등록번호 : 102-81-29258</li>
        <li style="line-height:16px;">서울시 통신판매업신고번호 : 제 2012-경기파주-3911 호</li>
        <li style="line-height:16px;">주소 (10881) 경기도 파주시 회동길 78 (출판단지내)</li>
        <li class="copyright" style="line-height:16px;">COPYRIGHT(C) 2019 KYOBO HOTTRACKS ALL RIGHTS RESERVED</li>
    </ul>
    
    <!-- 소셜아이어워드  -->
    <div class="ic_mark">
    	<a href="/heart">
    		<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/resources/img/common/ic_siaward_m.png" alt="소셜아이어워드">
				<p>소셜아이어워드 2019<br/>문화쇼핑 플랫폼분야 대상</p>
		</a>
    </div>
    
    <div class="sns_box">
        <a href="#" onclick="goTwitter('모바일핫트랙스', 'http://m.hottracks.co.kr/');return false;" class="share_twiter"><span>트위터 바로가기</span></a>
        <a href="#" onclick="winOpen('https://www.facebook.com/HOTTRACKSFRIEND/');return false;" class="share_facebook"><span>페이스북 바로가기</span></a>
        <a href="#" onclick="linkToInstagram('home');return false;" target="_blank" class="share_instagram"><span>인스타그램 바로가기</span></a>
    </div>
</div>
<!-- //#footer -->

<div id="devLayer" class="lyDeviceAlert" style="position:fixed;left:0;top:0;width:100%;height:100%;background:url('/images/season01/bg_layer02.png');z-index:999;display:none;">
<!-- 
<div style="display: block;margin:20px auto;max-width:290px;position: relative;top:50%;margin-top:-100px;overflow:hidden;">
    <dl style="position:relative;font-size:15px;font-weight:bold;">
        <dt style="position:absolute;top:0;left:0;"><img src="/images/device/ico_logo.png" alt="HOTTRACKS" style="width:70px;height:70px;"></dt>
        <dd style="margin-left:80px;color:#fff;">
            <p style="margin-top:20px;">나의 감성 충전소, 핫트랙스</p>
            <p style="font-size:1.3em;margin-top:7px;">더욱 편리하게<br/>쇼핑하실 수 있어요!</p>
        </dd>
    </dl>
    <p style="margin-top:30px;"><a href="#" onclick="linkToDevice('Y');return false;"><img src="/images/device/btn_app.png" alt="앱으로 보기 " style="width:100%;"/></a></p>
    <p style="margin-top:10px;text-align:center;"><a href="#" onclick="linkToDevice('F');return false;" style="color:#fff;text-decoration:underline;">모바일웹으로 볼께요.</a></p>
</div>
-->
<div style="display: block;margin:20px auto;max-width:290px;position: relative;top:50%;margin-top:-200px;overflow:hidden;background:url('/images/device/bg_layer01.jpg');text-align:center;">
    <img src="${imageServer }/images/device/txt_layer02.png" style="width:100%;"/>
    <a href="#" onclick="linkToDevice('Y');return false;" style="position:relative;font-size:15px;font-weight:bold;margin-top:10px;">
        <img src="/images/device/btn_layer01.png" style="width:90%;"/>
    </a>
    <p style="margin:10px auto;text-align:center;"><a href="#" onclick="linkToDevice('F');return false;" style="color:#263741;text-decoration:underline;font-weight:bold;">웹으로 볼께요.</a></p>
</div>
</div>
<div id="devLayer001" class="lyDeviceAlert" style="position:fixed;left:0;top:0;width:100%;height:100%;background:url('/images/season01/bg_layer02.png');z-index:999;display:none;">
<div style="display: block;margin:20px auto;max-width:290px;position: relative;top:50%;margin-top:-150px;overflow:hidden;">
    <a href="#" onclick="location.href='/m/biz/eventDetail?eventId=42347';return false;" style="position:relative;font-size:15px;font-weight:bold;">
        <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/1056/1479708729992_popup01.png" style="width:100%;"/>
    </a>
    <p style="margin-top:10px;text-align:center;"><a href="#" onclick="linkToDevice('F');return false;" style="color:#fff;text-decoration:underline;">오늘 하루 그만보기</a></p>
</div>
</div>
<div id="devLayer002" class="lyDeviceAlert" style="position:fixed;left:0;top:0;width:100%;height:100%;background:url('/images/season01/bg_layer02.png');z-index:999;display:none;">
<div style="display: block;margin:20px auto;max-width:290px;position: relative;top:50%;margin-top:-150px;overflow:hidden;">
    <a href="#" onclick="location.href='/m/biz/eventDetail?eventId=42347';return false;" style="position:relative;font-size:15px;font-weight:bold;">
        <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/1535/1479708673064_popup02.png" style="width:100%;"/>
    </a>
    <p style="margin-top:10px;text-align:center;"><a href="#" onclick="linkToDevice('F');return false;" style="color:#fff;text-decoration:underline;">오늘 하루 그만보기</a></p>
</div>
</div>
<div id="popupLayer001" style="position:fixed;left:0;top:0;width:100vw;height:100vh;z-index:999;display:none;">
<div style="display:block;position: relative;">
    <a href="#" onclick="closeWin2();return false;" style="display:block;text-align:right;background-color:#ff6600;padding:10px;margin:0;"><img src="/images/season01/btn_close01.png" style="width:25px;height:25px;"/></a></p>
    <div style="position:relative;font-size:15px;font-weight:bold;background-color:#fff;width:100%;height:calc(100vh - 45px);overflow: auto; -webkit-overflow-scrolling: touch;display:block;">
        <iframe src="about:Tabs" scrolling="yes" style="width:100vw;height:100vh;display:block;border:none;"></iframe>
    </div>
</div>
</div>
<div style="display: none;"><textarea id="myClipboard"></textarea></div>