<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<head>
    <title>고객센터</title>
</head>
<body>
    <!-- customer -->
    <div id="customer">
        <div class="contents"> 
            <p class="mypagetit13 ir">SOS상담</p>
            <div class="sub_stitle">
                <p>교보핫트랙스는,<br />
                원활한 상담과 타인의 주민번호도용 및 허위정보로 인한 피해를 방지하기 위해 실명인증을 시행하고 있습니다.<br /><br />
                
                교보핫트랙스 회원이신 고객께서는 <span class="f_red">[회원 상담]</span>을 선택해 주시기 바라며 (로그인 후 바로 이용가능하십니다),<br />
                비회원으로 상담을 원하시는 고객께서는 [비회원 상담]을 선택해 주시기 바랍니다.<br />
                <span class="f_red">[비회원 상담]</span>의 경우 실명확인을 하셔야만 접수가 가능합니다.<br /><br />
                
                입력하신 정보는 고객님의 동의 없이 공개되지 않으며, 개인정보보호정책에 의해 보호 받고 있습니다.</p>
            </div>
             
            <div class="sos_box">
                <div class="boxfl"> 
                    <span class="text01 ir">회원 상담</span> 
                    <a href="https://www.hottracks.co.kr/ht/mypage/loginForm" class="btn1 ir">회원 상담</a>
                </div>
                <div class="boxfr"> 
                    <span class="text01 ir">비회원 상담</span>
                    <a href="/ht/help/niceCheck" class="btn1 ir">아이핀 인증</a>
                    <span class="text02 ir">교보문고/핫트랙스 통합 회원으로 가입하시면 편리함과 혜택이 늘어납니다!</span>
                    <a href="#" class="btn2 ir">회원가입</a>
                </div>      
            </div>  
        </div>
    </div>
    <!-- //customer -->
</body>

