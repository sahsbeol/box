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
        <h2><img src="/images/company/recruit/txt_career.png" alt="경력경로" /></h2>
        <em class="location"><img src="/images/company/icon/icon_home.png"  alt="홈"/> &gt; 인재채용 &gt; 인사제도 &gt; <strong>경력경로</strong></em>
    </div>
    <!-- //location -->
    <!-- recruitWrap -->
    <div class="recruitWrap">
        <h3><img src="/images/company/recruit/txt_position.png" alt="직급체계" /></h3>
        <p class="img alnC"><img src="/images/company/recruit/img_position.png" alt="사원(4급)&gt;사원(3급)&gt;대리/과장(2급)&gt;차장/부장(1급)" /></p>
        <h3><img src="/images/company/recruit/txt_growth.png" alt="성장경로" /></h3>
        <p class="img alnC"><img src="/images/company/recruit/img_growth.png" alt="영업직:사원&gt;매니저&gt;영업점장 | 사무직: 사원&gt;중간리더(대리/과장)&gt;팀장" /></p>

        <p class="mail_send">
            <em><img src="/images/company/text/text_re_01.png" alt="채용문의"/></em>
            <span class="underline"><a href="mailto:hupsu@hottracks.co.kr" >hupsu@hottracks.co.kr</a></span>
        </p>
    </div>
    <!-- //recruitWrap -->
</div><!-- //contents area -->
</div><!-- //container -->
</body>
</html>