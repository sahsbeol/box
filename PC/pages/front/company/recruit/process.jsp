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
        <h2><img src="/images/company/recruit/txt_process.png" alt="채용프로세스" /></h2>
        <em class="location"><img src="/images/company/icon/icon_home.png"  alt="홈"/> &gt; 채용정보 &gt; <strong>채용프로세스</strong></em>
    </div>
    <!-- //location -->
    <!-- recruitWrap -->
    <div class="recruitWrap">
        <p class="pic"><img src="/images/company/recruit/img_recruit.png" alt="서류전형&gt;인성검사&gt;1차면접(실무진)&gt;2차면접(임원진)&gt;채용검진&gt;채용확정" /></p>
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