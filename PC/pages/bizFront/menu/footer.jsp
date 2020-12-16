<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<ui:decorator name="none"/>
<script type="text/javascript">
/* Array.from 미지원에 따른 추가내용 */
// Production steps of ECMA-262, Edition 6, 22.1.2.1
// Reference: https://people.mozilla.org/~jorendorff/es6-draft.html#sec-array.from
if (!Array.from) {
  Array.from = (function () {
    var toStr = Object.prototype.toString;
    var isCallable = function (fn) {
      return typeof fn === 'function' || toStr.call(fn) === '[object Function]';
    };
    var toInteger = function (value) {
      var number = Number(value);
      if (isNaN(number)) { return 0; }
      if (number === 0 || !isFinite(number)) { return number; }
      return (number > 0 ? 1 : -1) * Math.floor(Math.abs(number));
    };
    var maxSafeInteger = Math.pow(2, 53) - 1;
    var toLength = function (value) {
      var len = toInteger(value);
      return Math.min(Math.max(len, 0), maxSafeInteger);
    };

    // The length property of the from method is 1.
    return function from(arrayLike/*, mapFn, thisArg */) {
      // 1. Let C be the this value.
      var C = this;

      // 2. Let items be ToObject(arrayLike).
      var items = Object(arrayLike);

      // 3. ReturnIfAbrupt(items).
      if (arrayLike == null) {
        throw new TypeError("Array.from requires an array-like object - not null or undefined");
      }

      // 4. If mapfn is undefined, then let mapping be false.
      var mapFn = arguments.length > 1 ? arguments[1] : void undefined;
      var T;
      if (typeof mapFn !== 'undefined') {
        // 5. else      
        // 5. a If IsCallable(mapfn) is false, throw a TypeError exception.
        if (!isCallable(mapFn)) {
          throw new TypeError('Array.from: when provided, the second argument must be a function');
        }

        // 5. b. If thisArg was supplied, let T be thisArg; else let T be undefined.
        if (arguments.length > 2) {
          T = arguments[2];
        }
      }

      // 10. Let lenValue be Get(items, "length").
      // 11. Let len be ToLength(lenValue).
      var len = toLength(items.length);

      // 13. If IsConstructor(C) is true, then
      // 13. a. Let A be the result of calling the [[Construct]] internal method of C with an argument list containing the single item len.
      // 14. a. Else, Let A be ArrayCreate(len).
      var A = isCallable(C) ? Object(new C(len)) : new Array(len);

      // 16. Let k be 0.
      var k = 0;
      // 17. Repeat, while k < len… (also steps a - h)
      var kValue;
      while (k < len) {
        kValue = items[k];
        if (mapFn) {
          A[k] = typeof T === 'undefined' ? mapFn(kValue, k) : mapFn.call(T, kValue, k);
        } else {
          A[k] = kValue;
        }
        k += 1;
      }
      // 18. Let putStatus be Put(A, "length", len, true).
      A.length = len;
      // 20. Return A.
      return A;
    };
  }());
}
/* Array.from 미지원에 따른 추가내용 */

jQuery(function($) {
    $('select.select_style02').change(function(){
        if($(this).val()!="Family Site"){
            window.open($(this).val());
        }
    });
    
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

<!-- 네이버 검색 광고 공통 적용 스크립트 , 모든 페이지에 노출되도록 설치. 단 전환페이지 설정값보다 항상 하단에 위치해야함 --> 
<script type="text/javascript" src="//wcs.naver.net/wcslog.js"> </script> 
<script type="text/javascript"> 
if (!wcs_add) var wcs_add={};
wcs_add["wa"] = "s_4d6e800c5751";
if (!_nasa) var _nasa={};
wcs.inflow();
wcs_do(_nasa);
</script>
<!-- 끝 -- 네이버 검색 광고 공통 적용 스크립트 , 모든 페이지에 노출되도록 설치. 단 전환페이지 설정값보다 항상 하단에 위치해야함 -->

<!-- Facebook Pixel Code -->
<script>
!function(f,b,e,v,n,t,s){if(f.fbq)return;n=f.fbq=function(){n.callMethod?
n.callMethod.apply(n,arguments):n.queue.push(arguments)};if(!f._fbq)f._fbq=n;
n.push=n;n.loaded=!0;n.version='2.0';n.queue=[];t=b.createElement(e);t.async=!0;
t.src=v;s=b.getElementsByTagName(e)[0];s.parentNode.insertBefore(t,s)}(window,
document,'script','//connect.facebook.net/en_US/fbevents.js');

fbq('init', '2595348470556537');
fbq('track', "PageView");
</script>
<noscript><img height="1" width="1" style="display:none" src="https://www.facebook.com/tr?id=1053245131399072&ev=PageView&noscript=1"/></noscript>
<!-- End Facebook Pixel Code -->


<!--  레코벨 스크립트 -->
<script type="text/javascript">
  var _recoUserId = getCookie('UserCookieKey');

    window._eglqueue = window._eglqueue || [];
    _eglqueue.push(['setVar','cuid','e15e978e-3623-4892-bf0a-485b9f8196ee']);
    _eglqueue.push(['setVar','userId',SHA256(_recoUserId)]); // optional
    _eglqueue.push(['track','visit']);
    (function(s,x){s=document.createElement('script');s.type='text/javascript';
    s.async=true;s.defer=true;s.src=(('https:'==document.location.protocol)?'https':'http')+'://logger.eigene.io/js/logger.min.js';
    x=document.getElementsByTagName('script')[0];x.parentNode.insertBefore(s, x);})();
</script>
<!--  레코벨 스크립트 끝 -->

<!-- SK Planet 유입경로 추적 스크립트 -->
<script src="//js.ad4989.co.kr/common/js/mojise/intro.js"></script>
<!--/ SK Planet 유입경로 추적 스크립트 -->

<!-- footer -->
<div id="footer">
	<div class="util">
		<div class="util_cont">
			<ul>
				<li><a href="${defaultHost}/company/about/introduce" target="_blank">회사소개</a></li>
				<li><a href="http://info.hottracks.co.kr/company/recruit/notice" target="_blank">채용정보</a></li>
				<li><a href="/heart" target="_blank">핫트합니다</a></li>
				<li><a href="${defaultHost}/company/store/main?deptcode=030005" target="_blank">매장안내</a></li>
				<li><a href="${defaultHost}/company/about/alliance" target="_blank">제휴/광고안내</a></li>
				<li><a href="${defaultHost}/ht/welcomeMain/viewRule" target="_blank">이용약관</a></li>
				<li><a href="${defaultHost}/ht/welcomeMain/privacy" target="_blank"><strong>개인정보처리방침</strong></a></li>
				<li><a href="${defaultHost}/ht/welcomeMain/popupEmail" onclick="window.open(this.href,'popupPrizewinner','width=400,height=365');return false;" title="새 창으로 열림">이메일수집거부</a></li>
			</ul>
			<div class="family_site">
				<p>패밀리 사이트</p>
				<ul>
                    <li><a href="http://www.kyobo.co.kr" title="새 창 열림" target="_blank">교보생명</a></li>
                    <li><a href="http://www.kyobobook.co.kr" title="새 창 열림" target="_blank">교보문고</a></li>
                    <li><a href="http://www.kyobotrade.com" title="새 창 열림" target="_blank">교보증권</a></li>
                    <li><a href="http://www.kico.co.kr" title="새 창 열림" target="_blank">교보정보통신</a></li>
                    <li><a href="http://www.kyobobldg.co.kr" title="새 창 열림" target="_blank">교보리얼코</a></li>
                    <li><a href="http://www.kyoboitm.co.kr" title="새 창 열림" target="_blank">교보악사자산운용</a></li>
                    <li><a href="http://www.lifeplanet.co.kr" title="새 창 열림" target="_blank">교보라이프플래닛생명</a></li>
                    <li><a href="http://www.kcasonsa.co.kr" title="새 창 열림" target="_blank">KCA 손해사정</a></li>
                    <li><a href="http://www.daesan.or.kr" title="새 창 열림" target="_blank">대산문화재단</a></li>
                    <li><a href="http://www.kbedu.or.kr" title="새 창 열림" target="_blank">교보생명교육문화재단</a></li>
                    <li><a href="http://www.dsa.or.kr" title="새 창 열림" target="_blank">대산농촌재단</a></li>
                    <li><a href="http://www.kyoboacademy.co.kr" title="새 창 열림" target="_blank">교보아카데미</a></li>
				</ul>
			</div>
		</div>
	</div>
	<div class="inner">
		<div class="cont left">
			<div class="cs_center">
				<strong class="font_t">1661-1112</strong>
				<span>평일 09:00 ~ 18:00 점심시간 12:00 ~ 13:00</span>
				<dl>
					<dt><a href="${defaultHost}/ht/help/sosCounselMain"><span>SOS 상담</span></a></dt>
					<dd>24시간 접수 가능<br/>고객센터 운영시간에 순차적으로 답변해드리겠습니다.</dd>
				</dl>
			</div>
			<h2>교보핫트랙스㈜</h2>
			<span>대표이사 오교철</span>
			<span>사업자등록번호 : 102-81-29258 <a href="javascript://" onclick="window.open('http://www.ftc.go.kr/info/bizinfo/communicationViewPopup.jsp?wrkr_no=1028129258', 'communicationViewPopup', 'scrollbars=yes, width=750, height=700;');return false;" title="새 창으로 열림">사업자정보확인 &gt;</a></span>
			<span>통신판매업신고번호 : 제 2012-경기파주-3911호</span>
			<span>주소 : 경기도 파주시 회동길 78 (출판단지내)</span>
			<span>개인정보보호책임자 : 김재식  PRIVACY@HOTTRACKS.CO.KR</span>
		</div>
		<div class="cont right">
			<ul class="sns">
				<li><a href="https://www.instagram.com/hottracks_online/" target="_blank"><img src="/images/biz/common/icon_instagram.png" alt="instagram"></a></li>
				<li><a href="https://www.facebook.com/HOTTRACKSFRIEND/" target="_blank"><img src="/images/biz/common/icon_facebook.png" alt="facebook"></a></li>
				<li><a href="https://www.youtube.com/channel/UCqQkoRX4rN-RCbBqVPUv3Hg" target="_blank"><img src="/images/biz/common/icon_youtube.png" alt="youtube"></a></li>
				<li><a href="https://twitter.com/hotonmusic" target="_blank"><img src="/images/biz/common/icon_twitter.png" alt="twitter"></a></li>
				<li><a href="http://hottracks91.blog.me/" target="_blank"><img src="/images/biz/common/icon_blog.png" alt="blog"></a></li>
			</ul>
               <div class="mobile">
               		<a href="https://apps.apple.com/kr/app/hottracks/id1129743143" target="_blank" class="font_t ios">APP STORE</a>
					<a href="https://play.google.com/store/apps/details?id=kr.co.hottracks.m.and" target="_blank" class="font_t and">PLAY STORE</a>
               </div>
			<ul class="copyright">
				<li><a href="/heart" target="_blank"><img src="/images/biz/common/img_award.png" alt="소셜아이어워드 2019"></a></li>
				<li><a href="http://www.copyrightok.kr" target="_blank"><img src="/images/biz/common/img_copyright.png" alt="저작권마크"></a></li>
			</ul>
			<span class="payment"><em class="font_t">NICEPAY</em><a href="#n" onclick="window.open('http://image.kyobobook.co.kr/newimages/giftshop_new/company/nicepay.html','window','location=no, directories=no, resizable=no, status=no, toolbar=no, menubar=no, width=740, height=867, left=100, top=50, scrollbars=no');return false">서비스 가입사실 확인 &gt;</a></span>
			<span class="txt">핫트랙스는 나이스페이먼츠 에스크로 서비스에 가입된 사업자이며,<br/>고객님은 구매 안전서비스를 이용하실 수 있습니다.</span>
		</div>
	</div>
</div>
<!--// footer -->