<%@ page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<!-- 태그 라이브러리 -->
<%@ include file="/pages/decorators/biz/tagHeader.jsp" %>

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

<!-- 레코벨 스크립트window -->
<script type="text/javascript">
$(window).load(function() {
	var userId= getCookie("UserCookieKey");

	window._eglqueue = window._eglqueue || [];
	_eglqueue.push(['setVar','cuid','e15e978e-3623-4892-bf0a-485b9f8196ee']);
	_eglqueue.push(['setVar','userId',SHA256(userId)]); // optional
	_eglqueue.push(['track','visit']);
	(function(s,x){s=document.createElement('script');s.type='text/javascript';
	s.async=true;s.defer=true;s.src=(('https:'==document.location.protocol)?'https':'http')+'://logger.eigene.io/js/logger.min.js';
  x=document.getElementsByTagName('script')[0];x.parentNode.insertBefore(s, x);})();
});
</script>
<!-- 레코벨 스크립트 끝 -->

<!-- SK Planet 유입경로 추적 스크립트 -->
<script src="//js.ad4989.co.kr/common/js/mojise/intro.js"></script>
<!--/ SK Planet 유입경로 추적 스크립트 -->

	<!-- footer -->
	<div id="footer">
		<div class="inner">
			<p>고객센터 <em class="font_t">1661-1112</em></p>
			<div class="util_menu">
		        <ul>
		            <li><a href="javascript:;" traget="_blank" onclick="winOpen3('http://m.hottracks.co.kr/heart?newPop=chromeYes');return false;">핫트합니다</a></li>
		            <li><a href="javascript:;" traget="_blank" onclick="winOpen('http://m.hottracks.co.kr/m/rule?newPop=chromeYes');return false;">이용약관</a></li>
		            <li><a href="javascript:;" traget="_blank" onclick="winOpen('http://m.hottracks.co.kr/m/privacy?newPop=chromeYes');return false;"><strong>개인정보취급방침</strong></a></li>
		        </ul>
		    </div>
			<div class="cont">
				<a href="javascript:;" traget="_blank" onclick="winOpen('http://m.hottracks.co.kr/heart?newPop=chromeYes');return false;">
					<img src="/images/biz/common/img_award.png" alt="소셜아이어워드 2019">
				</a>
				<ul class="sns_wrap">
		            <li class="ig"><a href="javascript:;" traget="_blank" onFocus="this.blur()" onclick="linkToInstagram('home');return false;">instagram</a></li>
		            <li class="fb"><a href="javascript:;" traget="_blank" onFocus="this.blur()" onclick="winOpen('https://www.facebook.com/HOTTRACKSFRIEND/');return false;">facebook</a></li>
		            <li class="tt"><a href="javascript:;" traget="_blank" onFocus="this.blur()" onclick="winOpen3('https://www.youtube.com/channel/UCqQkoRX4rN-RCbBqVPUv3Hg?newPop=chromeYes');return false;">youtube</a></li>
		            <li class="bg"><a href="javascript:;" traget="_blank" onFocus="this.blur()" onclick="goTwitter('모바일핫트랙스', 'http://m.hottracks.co.kr/');return false;">twitter</a></li>
		            <li class="yt"><a href="javascript:;" traget="_blank" onFocus="this.blur()" onclick="winOpen3('https://hottracks91.blog.me?newPop=chromeYes');return false;">blog</a></li>
		        </ul>
			</div>
			<a href="javascript:;" onclick="javacript:event.preventDefault();" class="btn_cont">교보핫트랙스(주)</a>
			<div class="txt">
				<span>대표이사 오교철</span>
				<span>사업자등록번호 : 102-81-29258</span>
				<span>통신판매업신고번호 : 제 2012-경기파주-3911호</span>
				<span>주소 : 경기도 파주시 회동길 78 (출판단지내)</span>
				<span>개인정보보호책임자 : <a href="/e/69557">김재식</a></span>
				<span>이메일 : PRIVACY@HOTTRACKS.CO.KR</span>
				<span class="copyright">ⓒ Kyobo Hottracks inc.</span>
			</div>
		</div>
	</div>
	<!--// footer -->

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
    <p style="margin-top:30px;"><a href="javascript:;" onclick="linkToDevice('Y');return false;"><img src="/images/device/btn_app.png" alt="앱으로 보기 " style="width:100%;"/></a></p>
    <p style="margin-top:10px;text-align:center;"><a href="javascript:;" onclick="linkToDevice('F');return false;" style="color:#fff;text-decoration:underline;">모바일웹으로 볼께요.</a></p>
</div>
-->
<div style="display: block;margin:20px auto;max-width:290px;position: relative;top:50%;margin-top:-200px;overflow:hidden;background:url('/images/device/bg_layer01.jpg');text-align:center;">
    <img src="${imageServer }/images/device/txt_layer02.png" style="width:100%;"/>
    <a href="javascript:;" onclick="linkToDevice('Y');return false;" style="position:relative;font-size:15px;font-weight:bold;margin-top:10px;">
        <img src="/images/device/btn_layer01.png" style="width:90%;"/>
    </a>
    <p style="margin:10px auto;text-align:center;"><a href="javascript:;" onclick="linkToDevice('F');return false;" style="color:#263741;text-decoration:underline;font-weight:bold;">웹으로 볼께요.</a></p>
</div>
</div>
<div id="devLayer001" class="lyDeviceAlert" style="position:fixed;left:0;top:0;width:100%;height:100%;background:url('/images/season01/bg_layer02.png');z-index:999;display:none;">
<div style="display: block;margin:20px auto;max-width:290px;position: relative;top:50%;margin-top:-150px;overflow:hidden;">
    <a href="javascript:;" onclick="location.href='/m/biz/eventDetail?eventId=42347';return false;" style="position:relative;font-size:15px;font-weight:bold;">
        <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/1056/1479708729992_popup01.png" style="width:100%;"/>
    </a>
    <p style="margin-top:10px;text-align:center;"><a href="javascript:;" onclick="linkToDevice('F');return false;" style="color:#fff;text-decoration:underline;">오늘 하루 그만보기</a></p>
</div>
</div>
<div id="devLayer002" class="lyDeviceAlert" style="position:fixed;left:0;top:0;width:100%;height:100%;background:url('/images/season01/bg_layer02.png');z-index:999;display:none;">
<div style="display: block;margin:20px auto;max-width:290px;position: relative;top:50%;margin-top:-150px;overflow:hidden;">
    <a href="javascript:;" onclick="location.href='/m/biz/eventDetail?eventId=42347';return false;" style="position:relative;font-size:15px;font-weight:bold;">
        <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/1535/1479708673064_popup02.png" style="width:100%;"/>
    </a>
    <p style="margin-top:10px;text-align:center;"><a href="javascript:;" onclick="linkToDevice('F');return false;" style="color:#fff;text-decoration:underline;">오늘 하루 그만보기</a></p>
</div>
</div>
<div id="popupLayer001" style="position:fixed;left:0;top:0;width:100vw;height:100vh;z-index:999;display:none;">
<div style="display:block;position: relative;">
    <a href="javascript:;" onclick="closeWin2();return false;" style="display:block;text-align:right;background-color:#ff6600;padding:10px;margin:0;"><img src="/images/season01/btn_close01.png" style="width:25px;height:25px;"/></a></p>
    <div style="position:relative;font-size:15px;font-weight:bold;background-color:#fff;width:100%;height:calc(100vh - 45px);overflow: auto; -webkit-overflow-scrolling: touch;display:block;">
        <iframe src="about:Tabs" scrolling="yes" style="width:100vw;height:100vh;display:block;border:none;"></iframe>
    </div>
</div>
</div>
<div style="display: none;"><textarea id="myClipboard"></textarea></div>