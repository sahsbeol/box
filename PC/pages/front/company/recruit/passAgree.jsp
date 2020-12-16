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
        <h2><img src="/images/company/recruit/txt_pass.png" alt="합격확인"/></h2>
        <em class="location"><img src="/images/company/icon/icon_home.png" alt="홈"/> &gt; 인재채용 &gt; 채용정보 &gt; <strong>합격확인</strong></em>
    </div>
    <!-- //location -->
    <p class="recruit_text"><img src="/images/company/text/text_re_03.png" alt="핫트랙스(HOTTRACKS)는 원할한 서비스 이용과 주민번호도용 및 허위정보로 인한 피해를 방지하기 위해 회원가입 실명인증을 시행하고 있습니다. 회원정보는 동의 없이 공개되지 않으며, 개인정보보호정책에 의해 보호 받고 있습니다."/></p>
    <p class="text_type1"><img src="/images/company/text/text_re_04.png" alt="개인정보 수집, 이용에 대한 동의"/></p>
    <div class="agreeInfo">
        <div class="agreeInfoContents" title="개인정보 수집, 이용에 대한 동의"><c:import url="./agreeInfo.jsp"/></div>
        <p>
            <span class="bold"><input type="radio" name="agree" value="Y" id="agree" /><label for="agree">위 내용에 대해 동의합니다.</label></span>
            <span class="last"><input type="radio" name="agree" value="N" id="agreeNo" /><label for="agreeNo">동의하지 않습니다.</label></span>
        </p>
    </div>
    <div class="centerBtnView">
        <ul>
            <li><a href="#none" title="확인"><img src="/images/company/btn/btn_ok.png" alt="확인" id="btnAgree"/></a></li>
            <li><a href="#none" title="취소"><img src="/images/company/btn/btn_cancle.png" alt="취소" id="btnDisagree"/></a></li>
        </ul>
    </div>
    </form>
    <p class="mail_send">
        <em><img src="/images/company/text/text_re_01.png" alt="채용문의"/></em>
        <span class="underline"><a href="mailto:hupsu@hottracks.co.kr" >hupsu@hottracks.co.kr</a></span>
    </p>
</div><!-- //contents area -->
</div><!-- //container -->
</body>
</html>