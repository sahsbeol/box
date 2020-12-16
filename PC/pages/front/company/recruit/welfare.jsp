<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
</head>
<body>
<div id="container">
<p class="cont_topBg_recruit"><img src="/images/company/layout/bg_snb_recruit.png" alt="아름다운핫트랙스 이야기를 함께 만들어갈 인재를 환영합니다."/></p>
<c:import url="./layerLnb.jsp"/>
<!-- contents area -->
<div id="contents_area">
    <!-- location -->
    <div id="location">
        <h2><img src="/images/company/recruit/txt_welfare.png" alt="복리후생제도" /></h2>
        <em class="location"><img src="/images/company/icon/icon_home.png"  alt="홈"/> &gt; 인재채용 &gt; 인사제도 &gt; <strong>복리후생제도</strong></em>
    </div>
    <!-- //location -->
    <!-- recruitWrap -->
    <div class="recruitWrap">
        <h3><img src="/images/company/recruit/txt_leisureUp.png" alt="레저활동지원" /></h3>
        <ul class="careerTxt">
            <li>- 문화생활 지원을 위한 카페테리아식 복리후생 제도</li>
            <li>- 직원을 위한 콘도운영 (19개 지역, 9구좌 보유)</li>
            <li>- 각종 사내 동호회 지원</li>
            <li>- 체력단련 휴가 부여 (년 5일)</li>
        </ul>
        
        <h3><img src="/images/company/recruit/txt_incentive.png" alt="포상" /></h3>
        <ul class="careerTxt">
            <li>- 우리 부서 우수사원 포상 (매월)</li>
            <li>- 매년 ‘올 해의 핫트랙스인’ 선정, 해외연수 특전 부여</li>
            <li>- 장기 근속자에 대한 포상</li>
        </ul>

        <h3><img src="/images/company/recruit/txt_lifeUp.png" alt="생활안정지원" /></h3>
        <ul class="careerTxt">
            <li>- 경조 휴가 및 경조금 지급</li>
            <li>- 자녀 학자금 지원</li>
            <li>- 직원 건강검진 지원</li>
            <li>- 퇴직 연금제도 및 개인연금 지원</li>
            <li>- 직원 대출제도 운영 (우리, 신한, 외환은행 제휴)</li>
            <li>- 임직원 및 배우자 상해보험 가입</li>
            <li>- 전 직원 교보문고, 핫트랙스 상품구매 할인 혜택</li>
        </ul>
        
        <p class="mail_send">
            <em><img src="/images/company/text/text_re_01.png" alt="채용문의"/></em>
            <span class="underline"><a href="mailto:hupsu@hottracks.co.kr" >hupsu@hottracks.co.kr</a></span>
        </p>
    </div><!-- //recruitWrap -->
</div><!-- //contents area -->
</div><!-- //container -->
</body>
</html>