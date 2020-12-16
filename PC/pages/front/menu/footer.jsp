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
<!--  레코벨 스크립트 끝-->
<style>
#footer_wrap > .policy li + li {
    margin-left: 5px;
}
.used_guide {
	width:505px;
}
.used_guide .enter_payment {
	font-size: 11px;
    display: inline-block;
    float: left;
}
.used_guide .ic_mark {
	float: left;
	margin:23px 0 0 1px;
}
.used_guide .ic_mark a:first-child{
	margin-right:8px;
}
.used_guide .footer_customer {
	margin-right:20px;
}
</style>

<div id="footer">
    <div id="footer_wrap">
        <ul class="policy">
            <li><a href="${defaultHost}/company/about/introduce"><span>회사소개</span></a></li>
            <li><a href="${defaultHost}/ht/welcomeMain/viewRule"><span>이용약관</span></a></li>
            <li><a href="${defaultHost}/ht/welcomeMain/popupEmail" onclick="window.open(this.href,'popupPrizewinner','width=400,height=365');return false;" title="새 창으로 열림"><span>이메일무단수집거부</span></a></li>
            <li><a href="${defaultHost}/company/about/alliance"><span>제휴광고안내</span></a></li>
            <li><a href="http://info.hottracks.co.kr/company/recruit/notice" target="_blank"><span>채용정보</span></a></li>
            <li><a href="/heart" target="_blank"><strong style="color:#ff6600;">핫트합니다</strong></a></li>            
            <li><a href="${defaultHost}/ht/welcomeMain/privacy"><strong>개인정보처리방침</strong></a></li>
            <li><a href="https://www.facebook.com/HOTTRACKSFRIEND/" target="_blank"><span>페이스북</span></a></li>
            <li><a href="https://www.instagram.com/hottracks_online" target="_blank"><span>인스타그램</span></a></li>
            <li><a href="${defaultHost}/ht/help/listNotice?categoryId=00"><span>공지사항</span></a></li>
            <!-- <li><a href="http://hottracks91.blog.me/" target="_blank"><span>블로그</span></a></li> -->
        </ul>
    </div>
    <div class="inner">
        <div class="company_info">
            <p class="foot_txt">교보핫트랙스㈜ 대표이사 오교철</p>
            <p class="foot_txt">주소 : 우편번호 10881 경기도 파주시 회동길 78 (출판단지내)</p>
            <p class="foot_txt">사업자등록번호 : 102-81-29258 서울특별시</p>
            <p class="foot_txt">통신판매업신고번호 : 제 2012-경기파주-3911 호 <a href="javascript://" onclick="window.open('http://www.ftc.go.kr/info/bizinfo/communicationViewPopup.jsp?wrkr_no=1028129258', 'communicationViewPopup', 'width=750, height=700;');return false;" class="more_info" title="새 창으로 열림"><span>사업자정보확인</span></a></p>
            <p class="foot_txt mgt30">개인정보보호책임자 : 김재식 [PRIVACY@HOTTRACKS.CO.KR]</p>
            <p class="foot_txt">대표전화 : 1661-1112(발신자 부담 전화) 팩스 : 02-732-1620</p>

            <div class="go_select">
                <a href="#" class="fm_open"><span>Family Site</span></a>
                <ul class="fm_list"> 
                    <li><a title="새 창 열림" target="_blank" href="http://www.kyobo.co.kr">교보생명</a></li>
                    <li><a title="새 창 열림" target="_blank" href="http://www.kyobobook.co.kr">교보문고</a></li>
                    <li><a title="새 창 열림" target="_blank" href="http://www.kyobotrade.com">교보증권</a></li>
                    <li><a title="새 창 열림" target="_blank" href="http://www.kico.co.kr">교보정보통신</a></li>
                    <li><a title="새 창 열림" target="_blank" href="http://www.kyobobldg.co.kr">교보리얼코</a></li>
                    <li><a title="새 창 열림" target="_blank" href="http://www.kyoboitm.co.kr">교보악사자산운용</a></li>
                    <li><a title="새 창 열림" target="_blank" href="http://www.lifeplanet.co.kr">교보라이프플래닛생명</a></li>
                    <li><a title="새 창 열림" target="_blank" href="http://www.kcasonsa.co.kr">KCA 손해사정</a></li>
                    <li><a title="새 창 열림" target="_blank" href="http://www.daesan.or.kr">대산문화재단</a></li>
                    <li><a title="새 창 열림" target="_blank" href="http://www.kbedu.or.kr">교보생명교육문화재단</a></li>
                    <li><a title="새 창 열림" target="_blank" href="http://www.dsa.or.kr">대산농촌재단</a></li>
                    <li><a title="새 창 열림" target="_blank" href="http://www.kyoboacademy.co.kr">교보아카데미</a></li>
                </ul>
            </div>
            <p class="copyright">COPYRIGHT(C) 2014 KYOBO HOTTRACKS<br />ALL RIGHTS RESERVED</p>
        </div>
        <div class="used_guide">
            <div class="clear">
                <div class="enter_payment">
                    <img src="${imageServer}/images/renewal/common/logo_lgu02.gif" alt="LG U+"/>
                    <a href="javascript:goValidEscrow('${lgdMid}');" class="more_info"><span>서비스 가입사실 확인</span></a>
                    <p class="foot_txt">고객님은 안전거래를 위해 현금 등으로 5만원 이상</p>
                    <p class="foot_txt">결제시 저희 쇼핑몰에서 가입한 LG데이콤의 구매</p>
                    <p class="foot_txt">안전서비스를 이용하실 수 있습니다.</p> 
                </div>
                <div class="ic_mark">
                	<a href="/heart" target="_blank">
                		<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/resources/img/common/ic_siaward_p.png" alt="소셜아이어워드"/>
                	</a>
                    <a href="http://www.copyrightok.kr" target="_blank">
                    	<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/resources/img/common/ic_copyrightok.png" alt="저작권마크"/>
                    </a>
                </div>
            </div>
            <div class="clear mgt25">
                <!-- 고객센터 -->
                <div class="footer_customer">
                    <strong class="tit"><img src="${imageServer}/images/renewal/common/txt_foot_customer02.gif" alt="고객센터" /></strong>
                    <p class="foot_txt mgt15">TEL 1661-1112 언제나 고객에게 열려 있습니다</p>
                    <p class="foot_txt">평일 09:00 ~ 18:00 / 점심시간 12:00 ~ 13:00</p>
                    <p class="foot_txt">공휴일(토,일 포함)휴무</p>
                    
                </div>
                <!-- //고객센터 -->
                
                <!-- 모바일 안내 -->
                <div class="footer_mobile">
                    <strong class="tit"><img src="${imageServer}/images/renewal/common/txt_foot_mobile.gif" alt="모바일 안내" style="padding-top : 20px; padding-right:5px;" />
                        <img src="${imageServer}/images/renewal/common/text.jpg" alt="모바일 멘트" style=""/></strong>
                    <p class="qrcode"><img src="${imageServer}/images/renewal/common/hot_icon.jpg" alt="모바일핫트랙스" /></p> 
                    <p class="foot_img"><a href="https://apps.apple.com/kr/app/hottracks/id1129743143" target="_blank"><img src="${imageServer}/images/renewal/common/app_apple.jpg" alt="핫트랙스 아이폰용" /></a></p>
                    <p class="foot_img"><a href="https://play.google.com/store/apps/details?id=kr.co.hottracks.m.and" target="_blank"><img src="${imageServer}/images/renewal/common/app_and.jpg" alt="핫트랙스 안드로이드용" /></a></p>
                </div>
                <!-- //모바일 안내 -->
            </div>
        </div>
    </div>
</div>