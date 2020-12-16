<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<ui:decorator name="none"/>
<script type="text/javascript">
jQuery(function($) {
    $('.go_select a.fm_open').click(function(){
        $(this).toggleClass('on');
        $(this).next().toggle();
        return false;
    });
    
    $('.go_select a.fm_open').focus(function(){
        $(this).toggleClass('on');
        $(this).next().toggle();
        return false;
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

<div id="footer">
    <div id="footer_wrap">
        <ul class="policy">
            <li><a href="/" target="_blank"><span>온라인몰</span></a></li>
            <li><a href="/company/about/introduce"><span>회사소개</span></a></li>
            <li><a href="/company/about/alliance"><span>제휴광고안내</span></a></li>
            <li><a href="http://info.hottracks.co.kr/company/recruit/notice"><span>채용정보</span></a></li>
            <li style="padding-top:10px;"><a href="/ht/welcomeMain/privacy" target="_blank"><strong style="color:#dc2e33;font-size:1.2em">개인정보처리방침</strong></a></li>
            <li><a href="https://www.facebook.com/HOTTRACKSFRIEND/"><span>페이스북</span></a></li>
            <li><a href="https://twitter.com/HOTTRACKSFRIEND"><span>트위터</span></a></li>
            <li><a href="https://www.instagram.com/hottracks_official/" target="_blank"><span>인스타그램</span></a></li>
            <li><a href="http://blog.naver.com/story1917" target="_blank"><span>블로그</span></a></li>
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
                    <li><a title="새 창 열림" target="_blank" href="http://www.sbnet.co.kr">생보부동산신탁</a></li>
                    <li><a title="새 창 열림" target="_blank" href="http://www.daesan.or.kr">대산문화재단</a></li>
                    <li><a title="새 창 열림" target="_blank" href="http://www.kbedu.or.kr">교보생명교육문화재단</a></li>
                    <li><a title="새 창 열림" target="_blank" href="http://www.dsa.or.kr">대산농촌재단</a></li>
                    <li><a title="새 창 열림" target="_blank" href="http://www.kyoboacademy.co.kr">교보아카데미</a></li>
                    <li><a title="새 창 열림" target="_blank" href="http://www.kyoboread.com">독서진단리드</a></li>
                    <li><a title="새 창 열림" target="_blank" href="http://www.edukyobobook.co.kr">에듀교보문고</a></li>
                </ul>
            </div>
            <p class="copyright">COPYRIGHT(C) 2014 KYOBO HOTTRACKS<br />ALL RIGHTS RESERVED</p>
        </div>
        <div class="used_guide">
            <div class="enter_payment">
                <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/renewal/common/logo_lgu02.gif" alt="LG U+"/>
                <a href="javascript:goValidEscrow('${lgdMid}');" class="more_info"><span>서비스 가입사실 확인</span></a>
                <p class="foot_txt">고객님은 안전거래를 위해 현금 등으로 5만원 이상 결제시 </p>
                <p class="foot_txt">저희 쇼핑몰에서 가입한 LG데이콤의 구매안전서비스를 이용하실 수 있습니다.</p>
            </div>


            <div class="clear mgt25">
                <!-- 고객센터 -->
                <div class="footer_customer">
                    <strong class="tit"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/renewal/common/txt_foot_customer02.gif" alt="고객센터" /></strong>
                    <p class="foot_txt mgt15">TEL 1661-1112 언제나 고객에게 열려 있습니다</p>
                    <p class="foot_txt">평일 09:00 ~ 18:00 / 점심시간 12:00 ~ 13:00</p>
                    <p class="foot_txt">공휴일(토,일 포함)휴무</p>
                    
                </div>
                <!-- //고객센터 -->
                
                <!-- 모바일 안내 -->
                <div class="footer_mobile">
                    <strong class="tit"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/renewal/common/txt_foot_mobile.gif" alt="모바일 안내" /></strong>
                    <p class="qrcode"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/renewal/common/qr_foot_mobile.gif" alt="모바일핫트랙스" /></p>
                    <p class="foot_txt mgt15">모바일에서 핫트랙스를 만나세요</p>
                    <p class="foot_txt">다양한 혜택이 기다립니다.</p>
                </div>
                <!-- //모바일 안내 -->
            </div>
        </div>
    </div>
</div>
<input type="hidden" id="commonParams" value="${commonParams}"/>